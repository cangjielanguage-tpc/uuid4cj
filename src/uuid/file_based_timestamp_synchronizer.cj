/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package uuid

/*
 * The class is file generators
 * @since 0.37.2
 */
public class FileBasedTimestampSynchronizer {

    private let logger: SimpleLogger = SimpleLogger()
    
    static let DEFAULT_UPDATE_INTERVAL: Int64 = 10 * 1000

    private static let DEFAULT_LOCK_FILE_NAME1: String = "uuid1.txt"

    private static let DEFAULT_LOCK_FILE_NAME2: String = "uuid2.txt"

    private var mInterval:Int64 = DEFAULT_UPDATE_INTERVAL



    var mLocked1: LockedFile

    var mLocked2: LockedFile

    var mFirstActive: Bool = false

    /**
     * Constructor that uses default values for names of files to use
     * (files will get created in the current working directory), as
     * well as for the update frequency value (10 seconds).
     */
    public init(){
        this(openFile(DEFAULT_LOCK_FILE_NAME1), openFile(DEFAULT_LOCK_FILE_NAME2))
    }

    /**
     * Constructor that uses default values for names of files to use
     * (files will get created in the current working directory), as
     * well as for the update frequency value (10 seconds).
     *
     * @param lockFile1 - File
     * @param lockFile2 - File
     */
    public init(lockFile1: File, lockFile2: File){
        this(lockFile1, lockFile2, DEFAULT_UPDATE_INTERVAL)
    }

    /**
     * Constructor that uses default values for names of files to use
     * (files will get created in the current working directory), as
     * well as for the update frequency value (10 seconds).
     *
     * @param lockFile1 - File
     * @param lockFile2 - File
     * @param interval - Int64
     */
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

    /**
     * set mInterval
     *
     * @param interval - Int64
     */
    public func setUpdateInterval(interval: Int64) {
        if (interval < 1) {
            throw IllegalArgumentException("Illegal value (${interval}); has to be a positive integer value")
        }
        
        mInterval = interval
    }

    protected func initialize():Int64 {
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

    protected func deactivate() {
        doDeactivate(mLocked1, mLocked2);
    }

    private func doDeactivate(lf1: ?LockedFile, lf2: ?LockedFile) {
        if (let Some(i) = lf1) {
            lf1.getOrThrow().deactivate();
        }

        if (let Some(i) = lf2) {
            lf2.getOrThrow().deactivate();
        }
    }

    /**
     * update file
     *
     * @param now - Int64
     * @return timeStamp
     */
    public func update(now:Int64):Int64 {
        let nextAllowed: Int64 = now + mInterval
        if (mFirstActive) {
            mLocked2.writeStamp(nextAllowed)
        } else {
            mLocked1.writeStamp(nextAllowed);
        }
        mFirstActive = !mFirstActive
        return nextAllowed
    }

    private static func openFile(filePath: String): File{
        let file: File
        if (File.exists(filePath)) {
            file = File(filePath, OpenOption.Open(true, true))
        } else {
            file = File(filePath, OpenOption.Create(true))
        }
        return file
    }
}
