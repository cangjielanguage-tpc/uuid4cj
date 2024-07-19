/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj


/*
 * The class is uuid base class
 * @since 0.37.2
 */
public class UUID <: ToString {

    private let bytes: Array<Byte> = Array(16, item: 0)

    public init(data: Array<Byte>) {
        if(data.size != 16) {
            throw IllegalArgumentException("data must be 16 bytes in length")
        }
        data.copyTo(bytes, 0, 0, bytes.size)
    }

    private init() {
        UUID(this.bytes)
    }

    /**
     * 00000000-0000-0000-0000-000000000000
     *
     * @return  A generated {@code UUID}
     */
    public static func nilUUID(): UUID {
        UUID()
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
    @OverflowWrapping 
    public static func nameUUIDFromBytes(name: Array<Int8>): UUID {
        var md: MessageDigest = MessageDigest(DigestType.MD5)
        var md5Bytes: Array<Int8> = md.digest(input: name)
        md5Bytes[6]  &= Int8(0x0f)  /* clear version        */
        md5Bytes[6]  |= Int8(0x30)  /* set to version 3     */
        md5Bytes[8]  &= Int8(0x3f)  /* clear variant        */
        md5Bytes[8]  |= Int8(0x80)  /* set to IETF variant  */
        return UUID(Int8ToUInt8(md5Bytes))
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
            throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let hexStr = String.join(components)
        if (hexStr.size != 32) {
           throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let data = match(fromHexString(hexStr)) {
            case Some(value) => value
            case None => throw IllegalArgumentException("Invalid UUID string: " + name)
        }
        let uuid = UUID(data)
        return uuid

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
        return (toHexString(this.bytes.slice(0, 4)) + "-" +
                toHexString(this.bytes.slice(4, 2)) + "-" +
                toHexString(this.bytes.slice(6, 2)) + "-" +
                toHexString(this.bytes.slice(8, 2)) + "-" +
                toHexString(this.bytes.slice(10, 6)))

    }

    /**
     * Returns the 16 bytes value.
     *
     * @return Array<Byte> - the 16 bytes value.
     */
    public func getBytes(): Array<Byte> {
        return this.bytes
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
        return Int32(bytes[6] >> 4 & 0x0f)
    }

    /**
     * The variant number associated with this {@code UUID}.  The variant
     * number describes the layout of the {@code UUID}.
     *
     * The variant number has the following meaning:
     *
     * 0    Reserved for NCS backward compatibility
     * 2    4122
     * (Leach-Salz), used by this class
     * 6    Reserved, Microsoft Corporation backward compatibility
     * 7    Reserved for future definition
     *
     * @return  The variant number of this {@code UUID}
     */
    public func variant(): Int32 {
        return Int32(bytes[8] >> 6 & 0x0f)
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
            throw UnsupportedOperationException("Not a time-based UUID")
        }
        let timestampBytes = Array<Byte>(8, item: 0)
        this.bytes.copyTo(timestampBytes, 6, 0, 2)
        this.bytes.copyTo(timestampBytes, 4, 2, 2)
        this.bytes.copyTo(timestampBytes, 0, 4, 4)
        timestampBytes[0] &= 0x0f
        Int64.parse("0x" + toHexString(timestampBytes))
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
            throw UnsupportedOperationException ("Not a time-based UUID")
        }

        let clockSequenceBytes = Array<Byte>(2, item: 0)
        this.bytes.copyTo(clockSequenceBytes, 8, 0, 2)
        clockSequenceBytes[0] &= 0x3f
        return Int32.parse("0x" + toHexString(clockSequenceBytes))
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
            throw UnsupportedOperationException("Not a time-based UUID")
        }

        return Int64.parse("0x" + toHexString(this.bytes.slice(10, 6)))
    }

    /**
     * Returns a hash code for this {@code UUID}.
     *
     * @return Int32 - A hash code value for this {@code UUID}
     */
    @OverflowWrapping
    public func hashCode(): Int64 {
        return toString().hashCode()
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
        var isEquals = true
        let objArray: Array<UInt8> = obj.getBytes()
        for( i in 0..objArray.size) {
            if (bytes[i] != objArray[i]) {
                isEquals = false
                break
            }
        }
        return isEquals
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

        let bytesFirstValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(0, 5)))
        let bytesMidValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(5, 5)))
        let bytesEndValue: UInt64 = UInt64.parse("0x" + toHexString(this.bytes.slice(10, 6)))

        let uuidFirstValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(0, 5)))
        let uuidMidValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(5, 5)))
        let uuidEndValue: UInt64 = UInt64.parse("0x" + toHexString(val.getBytes().slice(10, 6)))

        if(bytesFirstValue < uuidFirstValue) {
            return -1     
        } else if(bytesFirstValue > uuidFirstValue) {
            return 1
        } else if(bytesMidValue < uuidMidValue) {
            return -1
        } else if(bytesMidValue > uuidMidValue) {
            return 1
        } else if(bytesEndValue < uuidEndValue) {
            return -1
        } else if(bytesEndValue > uuidEndValue) {
            return 1
        } else {
            return 0
        }
    }
}