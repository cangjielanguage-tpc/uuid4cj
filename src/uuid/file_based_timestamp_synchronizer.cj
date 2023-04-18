/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package uuid

public class FileBasedTimestampSynchronizer <: TimestampSynchronizer {

    private let logger: SimpleLogger = SimpleLogger()
    
    static let DEFAULT_UPDATE_INTERVAL: Int64 = 10 * 1000

    private static let DEFAULT_LOCK_FILE_NAME1: String = "uuid1.lck"

    private static let DEFAULT_LOCK_FILE_NAME2: String = "uuid2.lck"

    private var mInterval:Int64 = DEFAULT_UPDATE_INTERVAL

    protected var mLocked1: LockedFile

    protected var mLocked2: LockedFile

    var mFirstActive: Bool = false

    public init(){
        this(File(DEFAULT_LOCK_FILE_NAME1, OpenOption.Open(true, true)), File(DEFAULT_LOCK_FILE_NAME2, OpenOption.Open(true, true)))
    }

    public init(lockFile1: File, lockFile2: File){
        this(lockFile1, lockFile2, DEFAULT_UPDATE_INTERVAL)
    }

    public init(lockFile1: File, lockFile2: File, interval: Int64){
        mInterval = interval
        mLocked1 = LockedFile(lockFile1)

        var ok: Bool = false
        try {
         mLocked2 = LockedFile(lockFile2)
         ok = true
        } finally {
            if (!ok) {
               mLocked1.deactivate()
            }
        }
    }

    public func setUpdateInterval(interval: Int64) {
        if (interval < 1) {
            throw IllegalArgumentException("Illegal value (${interval}); has to be a positive integer value")
        }
        
        mInterval = interval
    }

    protected override func initialize():Int64 {
        let ts1: Int64 = mLocked1.readStamp()
        let ts2: Int64 = mLocked2.readStamp()
        var result: Int64
        if(ts1 > ts2) {
            mFirstActive = true
            result = ts1
        } else {
            mFirstActive = false
            result = ts2
        }

        if (result <= 0) {
            logger.warn("Could not determine safe timer starting point: assuming current system time is acceptable")
        } else {
            let now: Int64 = Int64(Time.now().unixTimeStamp().milliseconds())
            if ((now + mInterval) < result) {
                logger.warn("Safe timestamp read is ${result - now} milliseconds in future, and is greater than the inteval (${mInterval})")
            }
        }

        return result
     }

    protected override func deactivate() {
        doDeactivate(mLocked1, mLocked2);
    }

    protected func doDeactivate(lf1: ?LockedFile, lf2: ?LockedFile) {
        if (let Some(i) = lf1) {
            lf1.getOrThrow().deactivate();
        }

        if (let Some(i) = lf2) {
            lf2.getOrThrow().deactivate();
        }
    }

    public override func update(now:Int64):Int64 {
        let nextAllowed: Int64 = now + mInterval
        if (mFirstActive) {
            mLocked2.writeStamp(nextAllowed)
        } else {
            mLocked1.writeStamp(nextAllowed);
        }
        mFirstActive = !mFirstActive
        return nextAllowed
    }
}
