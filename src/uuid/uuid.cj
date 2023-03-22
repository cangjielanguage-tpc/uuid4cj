/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

from std import format.Formatter
from crypto import crypto.SecureRandom

/*
 * The class is uuid base class
 * @since 0.37.2
 */
public class UUID <: ToString {
    private let mostSigBits: Int64
    private let leastSigBits: Int64

    private init(data: Array<UInt8>) {
        var msb: Int64 = 0
        var lsb: Int64 = 0
        if(data.size != 16) {
            throw UUIDException("data must be 16 bytes in length")
        }
        var k: Int64 = 0
        for(i in 0..8) {
            msb = (msb << 8) | (Int64(data[k]) & 0xff)
            k++
        }
        k = 8
        for(i in 8..16) {
           lsb = (lsb << 8) | (Int64(data[k]) & 0xff)
           k++
        }            
        this.mostSigBits = msb
        this.leastSigBits = lsb
    }

    /**
     * Constructs a new {@code UUID} using the specified data.  {@code
     * mostSigBits} is used for the most significant 64 bits of the {@code
     * UUID} and {@code leastSigBits} becomes the least significant 64 bits of
     * the {@code UUID}.
     *
     * @param  mostSigBits- The most significant bits of the {@code UUID}
     * @param  leastSigBits - The least significant bits of the {@code UUID}
     */
    public init(mostSigBits: Int64, leastSigBits: Int64) {
        this.mostSigBits = mostSigBits
        this.leastSigBits = leastSigBits
    }

    /**
     * 00000000-0000-0000-0000-000000000000
     *
     * @return  A generated {@code UUID}
     */
    public static func nilUUID(): UUID {
        UUID(0, 0)
    }

    /**
     * Static factory to retrieve a type 4 (pseudo randomly generated) UUID.
     *
     * The {@code UUID} is generated using a cryptographically strong pseudo random number generator.
     *
     * @return  A randomly generated {@code UUID}
     */
    public static func randomUUID(): UUID {
        let ng: SecureRandom = SecureRandom(priv: false)
        let randomBytes = ng.nextBytes(16)
        randomBytes[6]  &= 0x0f  /* clear version        */
        randomBytes[6]  |= 0x40  /* set to version 4     */
        randomBytes[8]  &= 0x3f  /* clear variant        */
        randomBytes[8]  |= 0x80  /* set to IETF variant  */
        return UUID(randomBytes)
    }

    /**
     * Static factory to retrieve a type 3 (name based) {@code UUID} based on
     * the specified byte array.
     *
     * @param name - A byte array to be used to construct a {@code UUID}
     * @return  A {@code UUID} generated from the specified array
     */
    public static func nameUUIDFromBytes(name: Array<UInt8>): UUID {
        var md: MessageDigest = MessageDigest(DigestType.MD5)
        var md5Bytes: Array<UInt8> = md.digest(name)
        md5Bytes[6]  &= 0x0f  /* clear version        */
        md5Bytes[6]  |= 0x30  /* set to version 3     */
        md5Bytes[8]  &= 0x3f  /* clear variant        */
        md5Bytes[8]  |= 0x80  /* set to IETF variant  */
        return UUID(md5Bytes)
    }

    /**
     * Creates a {@code UUID} from the string standard representation as
     * described in the {@link #toString} method.
     *
     * @param name - A string that specifies a {@code UUID}
     * @return  A {@code UUID} with the specified value
     */
    public static func fromString(name: String): UUID {
        let components: Array<String> = name.split("-")
        if (components.size != 5) {
            throw UUIDException("Invalid UUID string: " + name)
        }
        var k: Int64 = 0
        for( i in 0..5) {
            components[i] = "0x" + components[i]
            k++
        }
        var mostSigBits: Int64 = Int64.parse(components[0])
        mostSigBits <<= 16
        mostSigBits |= Int64.parse(components[1])
        mostSigBits <<= 16
        mostSigBits |= Int64.parse(components[2])
        var leastSigBits: Int64 = Int64.parse(components[3])
        leastSigBits <<= 48
        leastSigBits |= Int64.parse(components[4])
        return UUID(mostSigBits, leastSigBits)
    }


    public func toString(): String {
        return (digits(mostSigBits >> 32, 8) + "-" +
                digits(mostSigBits >> 16, 4) + "-" +
                digits(mostSigBits, 4) + "-" +
                digits(leastSigBits >> 48, 4) + "-" +
                digits(leastSigBits, 12))
    }

    /** Returns val represented by the specified number of hex digits. */
    private static func digits(val: Int64, digits: Int32): String {
        var hi: Int64 = 1 << (digits * 4)
        return (hi | (val & (hi - 1))).format("02x").substring(1)
    }

    public func getLeastSignificantBits(): Int64 {
        return this.leastSigBits
    }

    /**
     * Returns the most significant 64 bits of this UUID's 128 bit value.
     *
     * @return  The most significant 64 bits of this UUID's 128 bit value
     */
    public func getMostSignificantBits(): Int64 {
        return this.mostSigBits
    }
    /*
     * 返回UUID的版本值
     * 1 版本1，基于时间戳生成。
     * 2 版本2，DCE安全版本。
     * 3 版本3，基于命名空间和MD5散列算法。
     * 4 版本4，基于随机数生成的，UUID.randomUUID使用版本4。
     * 5 版本4，基于命名空间和SHA1散列算法。
     */
    public func version(): Int32 {
        return Int32((mostSigBits >> 12) & 0x0f)
    }

    /*
     * 返回UUID的变体值
     * UUID的变体描述了UUID的布局。变体值的意义如下：
     * 0 变体0，保留，NCS向后兼容性。
     * 1 变体1，IETF RFC 4122  (Leach-Salz)，UUID类型使用该布局。
     * 2 变体2，保留，Microsoft Corporation向后兼容性。
     * 3 保留供将来定义使用。
     */
    public func variant(): Int32 {
        return Int32(rightShift(leastSigBits, (64 - rightShift(leastSigBits, 62))) & (leastSigBits >> 63))
    }

    public func timestamp(): Int64 {
        if (version() != 1) {
            throw UUIDException("Not a time-based UUID")
        }

        return (mostSigBits & 0x0FFF) << 48 | ((mostSigBits >> 16) & 0x0FFFF) << 32 | rightShift(mostSigBits, 32)
    }  

    public func clockSequence(): Int32 {
        if (version() != 1) {
            throw UUIDException ("Not a time-based UUID")
        }
        return Int32(rightShift((leastSigBits & 0x3FFF000000000000), 48))
    }  

    public func node(): Int64 {
        if (version() != 1) {
            throw UUIDException("Not a time-based UUID")
        }

        return leastSigBits & 0x0000FFFFFFFFFFFF
    }

    @overflowWrapping
    public func hashCode(): Int32 {
        let hilo: Int64 = mostSigBits ^ leastSigBits
        return Int32((Int32(hilo >> 32)) ^ Int32(hilo))
    }

    public func equals(obj: UUID): Bool {
        return (mostSigBits == obj.getMostSignificantBits() &&
                leastSigBits == obj.getLeastSignificantBits())
    }

    public func compareTo(val: UUID): Int32 {
        // The ordering is intentionally set up so that the UUIDs
        // can simply be numerically compared as two numbers
        if(this.mostSigBits < val.getMostSignificantBits()) {
            return -1     
        } else if(this.mostSigBits > val.getMostSignificantBits()) {
            return 1
        } else if(this.leastSigBits < val.getLeastSignificantBits()) {
            return -1
        } else if(this.leastSigBits > val.getLeastSignificantBits()) {
            return 1
        } else {
            return 0
        }
        return 0
    }
}
