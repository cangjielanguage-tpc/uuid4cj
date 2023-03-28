/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
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
     * @return UUID - A {@code UUID} generated from the specified array
     */
    public static func nameUUIDFromBytes(name: Array<UInt8>): UUID {
        var md: MessageDigest = MessageDigest(DigestType.MD5)
        var md5Bytes: Array<UInt8> = md.digest(input: name)
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

    /**
     * Returns a {@code String} object representing this {@code UUID}.
     *
     * The UUID string representation is as described by this BNF:
     * {@code
     * UUID                   = <time_low> "-" <time_mid> "-"
     *                          <time_high_and_version> "-"
     *                          <variant_and_sequence> "-"
     *                          <node>
     * time_low               = 4*<hexOctet>
     * time_mid               = 2*<hexOctet>
     * time_high_and_version  = 2*<hexOctet>
     * variant_and_sequence   = 2*<hexOctet>
     * node                   = 6*<hexOctet>
     * hexOctet               = <hexDigit><hexDigit>
     * hexDigit               =
     *       "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
     *       | "a" | "b" | "c" | "d" | "e" | "f"
     *       | "A" | "B" | "C" | "D" | "E" | "F"
     * }
     *
     * @return A string representation of this {@code UUID}
     */
    public func toString(): String {
        return (digits(mostSigBits >> 32, 8) + "-" +
                digits(mostSigBits >> 16, 4) + "-" +
                digits(mostSigBits, 4) + "-" +
                digits(leastSigBits >> 48, 4) + "-" +
                digits(leastSigBits, 12))
    }

    private static func digits(val: Int64, digits: Int32): String {
        var hi: Int64 = 1 << (digits * 4)
        return (hi | (val & (hi - 1))).format("02x").substring(1)
    }

    /**
     * Returns the least significant 64 bits of this UUID's 128 bit value.
     *
     * @return Int64 - The least significant 64 bits of this UUID's 128 bit value
     */
    public func getLeastSignificantBits(): Int64 {
        return this.leastSigBits
    }

    /**
     * Returns the most significant 64 bits of this UUID's 128 bit value.
     *
     * @return Int64 - The most significant 64 bits of this UUID's 128 bit value
     */
    public func getMostSignificantBits(): Int64 {
        return this.mostSigBits
    }

    /**
     * The version number associated with this {@code UUID}.  The version
     * number describes how this {@code UUID} was generated.
     *
     * The version number has the following meaning:
     * 
     * 1  Time-based UUID
     * 2  DCE security UUID
     * 3  Name-based UUID
     * 4  Randomly generated UUID
     *
     * @return Int32 - The version number of this {@code UUID}
     */
    public func version(): Int32 {
        return Int32((mostSigBits >> 12) & 0x0f)
    }

    /**
     * The variant number associated with this {@code UUID}.  The variant
     * number describes the layout of the {@code UUID}.
     *
     * The variant number has the following meaning:
     *
     * 0    Reserved for NCS backward compatibility
     * 2    <a href="http://www.ietf.org/rfc/rfc4122.txt">4122</a>
     * (Leach-Salz), used by this class
     * 6    Reserved, Microsoft Corporation backward compatibility
     * 7    Reserved for future definition
     *
     * @return  The variant number of this {@code UUID}
     */
    public func variant(): Int32 {
        return Int32(rightShift(leastSigBits, (64 - rightShift(leastSigBits, 62))) & (leastSigBits >> 63))
    }

    /**
     * The timestamp value associated with this UUID.
     *
     * The 60 bit timestamp value is constructed from the time_low,
     * time_mid, and time_hi fields of this {@code UUID}.  The resulting
     * timestamp is measured in 100-nanosecond units since midnight,
     * October 15, 1582 UTC.
     *
     * The timestamp value is only meaningful in a time-based UUID, which
     * has version type 1.  If this {@code UUID} is not a time-based UUID then
     * this method throws {@code Not a time-based UUID}.
     *
     * @return Int64 - The timestamp of this {@code UUID}.
     */
    public func timestamp(): Int64 {
        if (version() != 1) {
            throw UUIDException("Not a time-based UUID")
        }

        return (mostSigBits & 0x0FFF) << 48 | ((mostSigBits >> 16) & 0x0FFFF) << 32 | rightShift(mostSigBits, 32)
    }  

    /**
     * The clock sequence value associated with this UUID.
     *
     * The 14 bit clock sequence value is constructed from the clock
     * sequence field of this UUID.  The clock sequence field is used to
     * guarantee temporal uniqueness in a time-based UUID.
     *
     * The {@code clockSequence} value is only meaningful in a time-based
     * UUID, which has version type 1.  If this UUID is not a time-based UUID
     * then this method throws {@code Not a time-based UUID}.
     *
     * @return Int32- The clock sequence of this {@code UUID}
     */
    public func clockSequence(): Int32 {
        if (version() != 1) {
            throw UUIDException ("Not a time-based UUID")
        }
        return Int32(rightShift((leastSigBits & 0x3FFF000000000000), 48))
    }  

    /**
     * The node value associated with this UUID.
     *
     * The 48 bit node value is constructed from the node field of this
     * UUID.  This field is intended to hold the IEEE 802 address of the machine
     * that generated this UUID to guarantee spatial uniqueness.
     *
     * The node value is only meaningful in a time-based UUID, which has
     * version type 1.  If this UUID is not a time-based UUID then this method
     * throws {@code Not a time-based UUID}.
     *
     * @return  The node value of this {@code UUID}
     */
    public func node(): Int64 {
        if (version() != 1) {
            throw UUIDException("Not a time-based UUID")
        }

        return leastSigBits & 0x0000FFFFFFFFFFFF
    }

    /**
     * Returns a hash code for this {@code UUID}.
     *
     * @return Int32 - A hash code value for this {@code UUID}
     */
    @overflowWrapping
    public func hashCode(): Int32 {
        let hilo: Int64 = mostSigBits ^ leastSigBits
        return Int32((Int32(hilo >> 32)) ^ Int32(hilo))
    }

    /**
     * Compares this object to the specified object.  The result is {@code
     * true} if and only if the argument is not {@code null}, is a {@code UUID}
     * object, has the same variant, and contains the same value, bit for bit,
     * as this {@code UUID}.
     *
     * @param obj - The object to be compared
     *
     * @return Bool - {@code true} if the objects are the same; {@code false}
     *          otherwise
     */
    public func equals(obj: UUID): Bool {
        return (mostSigBits == obj.getMostSignificantBits() &&
                leastSigBits == obj.getLeastSignificantBits())
    }

    /**
     * Compares this UUID with the specified UUID.
     *
     * The first of two UUIDs is greater than the second if the most
     * significant field in which the UUIDs differ is greater for the first
     * UUID.
     *
     * @param  val - {@code UUID} to which this {@code UUID} is to be compared
     *
     * @return  -1, 0 or 1 as this {@code UUID} is less than, equal to, or
     *          greater than {@code val}
     */
    public func compareTo(val: UUID): Int32 {
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
