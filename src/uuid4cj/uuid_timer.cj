/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package uuid4cj

from std import log.*

/*
 * The class is timeStamp generators
 * @since 0.37.2
 */
public class UUIDTimer {

    private let _logger: SimpleLogger = SimpleLogger()

    private static let kClockOffset:Int64 = 0x01b21dd213814000

    private static let kClockMultiplier:Int32 = 10000

    private static let kClockMultiplierL:Int64 = 10000

    private static let kMaxClockAdvance:Int64 = 100

    protected var _syncer = Option<FileBasedTimestampSynchronizer>.None

    protected var _random = SecureRandom()

    protected var _clock = UUIDClock()

    private var _clockSequence:Int32 = 0

    private var _lastSystemTimestamp:Int64 = 0

    private var _lastUsedTimestamp:Int64 = 0

    private var _firstUnsafeTimestamp:Int64 = Int64.Max

    private var _clockCounter:Int32 = 0

    private static let MAX_WAIT_COUNT:Int32 = 50

    /**
     * init UUIDTimer
     *
     * @param rnd = SecureRandom
     * @param sync = Option<FileBasedTimestampSynchronizer>
     */
    public init(rnd: SecureRandom,sync: Option<FileBasedTimestampSynchronizer>){
        this(rnd, sync,UUIDClock())
    }

    /**
     * init UUIDTimer
     *
     * @param rnd = SecureRandom
     * @param sync = Option<FileBasedTimestampSynchronizer>
     * @param clock = UUIDClock
     */
    public init(rnd:SecureRandom,sync:Option<FileBasedTimestampSynchronizer>,clock:UUIDClock){
        _random = rnd
        _syncer = sync
        _clock = clock
        initCounters(rnd)
        _lastSystemTimestamp = 0
        _lastUsedTimestamp = 0
        if(let Some(_) <- sync){
            let lastSaved:Int64 = sync.getOrThrow().initialize()
            if(lastSaved > _lastUsedTimestamp){
                _lastUsedTimestamp = lastSaved
            }
        }
        _firstUnsafeTimestamp = 0
    }

    private func initCounters(rnd:SecureRandom):Unit{
        _clockSequence = rnd.nextInt32()
        _clockCounter = (_clockSequence >> 16) & 0xFF
    }

    /**
     * get clockSequence
     *
     * @return Int32
     */
    public func getClockSequence():Int32{
        return (_clockSequence & 0xFFFF)
    }

    /**
     * get timestamp
     *
     * @return Int64
     */
    public func getTimestamp(): Int64{
        var systime: Int64 = _clock.currentTimeMillis()
        if(systime < _lastSystemTimestamp) {
            _logger.warn("System time going backwards! (got value ${systime}, last  ${_lastSystemTimestamp})")
            _lastSystemTimestamp = systime

        }
        if (systime <= _lastUsedTimestamp) {
            if (_clockCounter < kClockMultiplier) {
                systime = _lastUsedTimestamp;
            } else {
                let actDiff: Int64 = _lastUsedTimestamp - systime
                let origTime: Int64 = systime
                systime = _lastUsedTimestamp + 1

                _logger.warn("Timestamp over-run: need to reinitialize random sequence");

                initCounters(_random);

                if (actDiff >= kMaxClockAdvance) {
                    slowDown(origTime, actDiff);
                }
            }

        } else {
            _clockCounter &= 0xFF;
        }

        _lastUsedTimestamp = systime;

        let isSyncer: Bool = match (_syncer) {
          case Some(_) => true
          case None => false
        }

        if ( isSyncer && systime >= _firstUnsafeTimestamp) {
            try {
                _firstUnsafeTimestamp = _syncer.getOrThrow().update(systime);
            } catch (ioe: Exception) {
                throw Exception("Failed to synchronize timestamp");
            }
        }

        systime *= kClockMultiplierL;
        systime += kClockOffset;

        systime += Int64(_clockCounter);
        _clockCounter ++;
        return systime;
    }

    protected func slowDown(startTime: Int64, actDiff: Int64) {
        let ratio: Int64 = actDiff / kMaxClockAdvance
        var delay: Int64

        if(ratio < 2) {
            delay = 1
        } else if (ratio < 10) {
            delay = 2
        } else if (ratio < 600) {
            delay = 3;
        } else {
            delay = 5;
        }

        _logger.warn("Need to wait for ${delay.toString()} milliseconds; virtual clock advanced too far in the future")
        let waitUntil: Int64 = startTime + delay
        var counter: Int32 = 0
        do {
            try {
                sleep(delay * Duration.millisecond)
            } catch (ie: InterruptedException ){
                throw InterruptedException("Failed to sleep ");
            }
            delay = 1
            
            counter++
            if (counter > MAX_WAIT_COUNT) {
                break
            }
        } while (Int64(DateTime.now().toUnixTimeStamp().toMilliseconds()) < waitUntil)

    }
}
