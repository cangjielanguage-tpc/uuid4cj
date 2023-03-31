/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

from std import log.*

public class UUIDTimer {

    private let logger: SimpleLogger = SimpleLogger()

    private static let kClockOffset:Int64 = 0x01b21dd213814000

    private static let kClockMultiplier:Int32 = 10000

    private static let kClockMultiplierL:Int64 = 10000

    private static let kMaxClockAdvance:Int64 = 100

    protected var _syncer = Option<TimestampSynchronizer>.None

    protected var _random = Random()

    protected var _clock = UUIDClock()

    private var _clockSequence:Int32 = 0

    private var _lastSystemTimestamp:Int64 = 0

    private var _lastUsedTimestamp:Int64 = 0

    private var _firstUnsafeTimestamp:Int64 = Int64.Max

    private var _clockCounter:Int32 = 0

    private static let MAX_WAIT_COUNT:Int32 = 50

    public init(rnd:Random,sync:Option<TimestampSynchronizer>){
        this(rnd, sync,UUIDClock())
    }

    public init(rnd:Random,sync:Option<TimestampSynchronizer>,clock:UUIDClock){
        _random = rnd
        _syncer = sync
        _clock = clock
        initCounters(rnd)
        _lastSystemTimestamp = 0
        _lastUsedTimestamp = 0
        if(let Some(i) = sync){
            let lastSaved:Int64 = sync.getOrThrow().initialize()
            if(lastSaved > _lastUsedTimestamp){
                _lastUsedTimestamp = lastSaved
            }
        }
        _firstUnsafeTimestamp = 0
    }

    private func initCounters(rnd:Random):Unit{
        _clockSequence = rnd.nextInt32()
        _clockCounter = (_clockSequence >> 16) & 0xFF
    }

    public func getClockSequence():Int32{
        return (_clockSequence & 0xFFFF)
    }

    public func getTimestamp(): Int64{
        var systime: Int64 = _clock.currentTimeMillis()

        if(systime < _lastSystemTimestamp) {
            logger.warn("System time going backwards! (got value ${systime}, last  ${_lastSystemTimestamp})")
            _lastSystemTimestamp = systime

        }

        if (systime <= _lastUsedTimestamp) {
            if (_clockCounter < kClockMultiplier) {
                systime = _lastUsedTimestamp;
            } else {
                let actDiff: Int64 = _lastUsedTimestamp - systime
                let origTime: Int64 = systime
                systime = _lastUsedTimestamp + 1
                initCounters(_random);

                if (actDiff >= kMaxClockAdvance) {
                }
            }

        } else {
            _clockCounter &= 0xFF;
        }

        _lastUsedTimestamp = systime;

        let isSyncer: Bool = match (_syncer) {
          case Some(v) => true
          case None => false
        }

        if ( isSyncer && systime >= _firstUnsafeTimestamp) {
            try {
                _firstUnsafeTimestamp = _syncer.getOrThrow().update(systime);
            } catch (ioe: InterruptedException) {
                throw InterruptedException("Failed to synchr`onize timestamp: ");
            }
        }

        systime *= kClockMultiplierL;
        systime += kClockOffset;

        systime += Int64(_clockCounter);
        _clockCounter ++;
        return systime;
    }

    @overflowWrapping
    protected func getAndSetTimestamp(uuidBytes: Array<UInt8>)
    {
        let timestamp: Int64 = getTimestamp();

        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE)] = UInt8(_clockSequence);
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE+1)] = UInt8( (_clockSequence >> 8));

        let clockHi: Int32 = Int32(rightShift(timestamp, 32));
        let clockLo: Int32 = Int32(timestamp);

        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_HI)] = UInt8(rightShift(Int64(clockHi), 24));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_HI+1)] = UInt8(rightShift(Int64(clockHi), 16));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_MID)] = UInt8(rightShift(Int64(clockHi), 8));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_MID+1)] = UInt8(clockHi);

        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_LO)] = UInt8(rightShift(Int64(clockLo), 24));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_LO+1)] = UInt8(rightShift(Int64(clockLo), 16));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_LO+2)] = UInt8(rightShift(Int64(clockLo), 8));
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_LO+3)] = UInt8(clockLo);
    }

}
