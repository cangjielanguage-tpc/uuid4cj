/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/*
 * The class is timeStamp generators
 * @since 0.37.2
 */
class LockedFile {

    private let logger = getGlobalLogger()

    static let READ_ERROR: Int64 = 0

    var mFile: File 

    var mWriteArray: Array<UInt8> = Array<UInt8>(22, item: 0)
    
    var mLastTimestamp: Int64 = 0

    static let HEX_DIGITS: String  = "0123456789abcdef"

    /*
     * init class
     *
     * @param f - File
     */
    public init (f: File) {
        mFile = f
    }

    /*
     * deactivate
     */
    public func deactivate() {
       throw NoneValueException("deactivate the file")
    }

    /*
     * read timeStamp
     *
     * @return timeStamp
     */
    public func readStamp(): Int64{
        var size: Int64 = mFile.length
        if (size == 0) {
            logger.warn("Missing or empty file, can not read timestamp value");
            return READ_ERROR;
        }
        
        if (size > 100) {
            size = 100
        }

        var uArray: Array<UInt8> = Array<UInt8>(mFile.length, item: 0)
        try {
            mFile.read(uArray)
        } catch (ie: FSException | IllegalArgumentException) {
            logger.error("file Failed to read ${mFile.length} bytes")
            return READ_ERROR
        }

        var charArray: Array<Rune> = Array<Rune>(uArray.size, item: Rune(0))

        for( i in 0..uArray.size) {
            // uint8 -> char
           charArray[i] = Rune(uArray[i])
        }
        // charArray -> String
        var dataStr: String = String(charArray)
        dataStr = dataStr.trim()

        var result: Int64 = -1
        var err: String = ""

        if ((!dataStr.startsWith("[0")) || (dataStr.size < 3) || (dataStr.toRuneArray()[2].toLowerCase() != r'x')) {
            err = "does not start with '[0x' prefix"
        } else {
            let ix: Int64 = dataStr.indexOf("]", 3).getOrThrow()
            if (ix <= 0) {
                err = "does not end with ']' marker"
            } else {
                var hex: String = dataStr[3..ix]
                if (hex.size > 16) {
                    err = "length of the (hex) timestamp too long; expected 16"
                } else {
                    try {
                        result = Int64.parse("0x" + hex.toString())
                    } catch (iae: IllegalArgumentException) {
                        err = "parse fail"
                    }
                }
            }
        }
        if (result < 0) {
            logger.error("timestamp file contents wrong timestamp ${err}");
            return READ_ERROR;
        }
        mLastTimestamp = result
        return result
    }

    /*
     * write timeStamp
     *
     * @param stamp - Int64 timeStamp
     */
    public func writeStamp (stamp: Int64) {
        if (stamp <= mLastTimestamp) {
            if (stamp == mLastTimestamp) {
                logger.warn("(file '') Trying to re-write existing timestamp (${stamp})")
                return
            }
        }

        mWriteArray[0] = UInt8(UInt32(r'['))
        mWriteArray[1] = UInt8(UInt32(r'0'))
        mWriteArray[2] = UInt8(UInt32(r'x'))
        mWriteArray[19] = UInt8(UInt32(r']'))
        mWriteArray[20] = UInt8(UInt32(r'\r'))
        mWriteArray[21] = UInt8(UInt32(r'\n'))

        var stampTemp: Int64 = stamp
        for(i in 18..2 : -1) {
            var val: Int64 = stampTemp & 0x0f
            // Char -> uint8
            mWriteArray[i] = UInt8(UInt32(HEX_DIGITS.toRuneArray()[val]))

            stampTemp = (stampTemp >> 4)
        }
        mFile.seek(SeekPosition.Begin(0))
        mFile.write(mWriteArray)

    }

}
