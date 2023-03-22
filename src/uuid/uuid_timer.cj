/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class UUIDTimer{

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

    public init(rnd:Random,sync:TimestampSynchronizer){
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






}
