/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package uuid4cj

/*
 * The class is UUIDUtil
 * @since 0.39.4
 */
public class UUIDUtil {
    public static let BYTE_OFFSET_CLOCK_LO: Int32 = 0
    public static let BYTE_OFFSET_CLOCK_MID: Int32 = 4
    public static let BYTE_OFFSET_CLOCK_HI: Int32 = 6
    public static let BYTE_OFFSET_TYPE: Int32 = 6
    public static let BYTE_OFFSET_CLOCK_SEQUENCE: Int32 = 8
    public static let BYTE_OFFSET_VARIATION: Int32 = 8
    private static let NIL_UUID: UUID = UUID.nilUUID()
    private static let MAX_UUID: UUID = UUID(-1, -1)
    
    /**
     * one that is all zeroes.
     *
     * @return UUID
     */
    public static func nilUUID(): UUID {
        return NIL_UUID
    }

    /**
     * Accessor for so-call "Max UUID"
     * one that is all one bits
     *
     * @return UUID
     */
    public static func maxUUID(): UUID {
        return MAX_UUID
    }
    
    /**
     * Factory method for creating UUIDs from the canonical string representation.
     *
     * @param id - String that contains the canonical representation of the UUID to build;
     *             36-char string. Hex-chars may be in upper-case too; 
     *             UUID class will always output them in lowercase.
     *              
     * @return UUID
     */
    public static func uuid(id: String): UUID {
        if (id.size != 36) {
            throw NumberFormatException("UUID has to be represented by the standard 36-char representation")
        }

        var lo: Int64 = 0
        var hi: Int64 = 0
        var i: Int64 = 0
        var j: Int64 = 0
        for (k in 0..36) {
            if( i >= 36 ) {
                break
            }
            // Need to bypass hyphens:
            if( i == 8 || i == 13 || i == 18 || i == 23) {
                if (id.get(i).getOrThrow() != '-') {
                        throw NumberFormatException("UUID has to be represented by the standard 36-char representation")
                    }
                i++
            }

            var curr: Int32 = 0
            var c: Char = id.get(i).getOrThrow()

            if (c >= '0' && c <= '9') {
                curr = Int32(UInt32(c) - UInt32('0'))
            } else if (c >= 'a' && c <= 'f') {
                curr = Int32(UInt32(c) - UInt32('a') + 10)
            } else if (c >= 'A' && c <= 'F') {
                curr = Int32(UInt32(c) - UInt32('A') + 10)
            } else {
                throw NumberFormatException("Non-hex character at #${i}: '${c}' (value ${UInt32(c).format("0x")})")
            }
            curr = (curr << 4)
            i++
            c = id.get(i).getOrThrow()

            if (c >= '0' && c <= '9') {
                curr |= Int32(UInt32(c) - UInt32('0'))
            } else if (c >= 'a' && c <= 'f') {
                curr |= Int32(UInt32(c) - UInt32('a') + 10)
            } else if (c >= 'A' && c <= 'F') {
                curr |= Int32(UInt32(c) - UInt32('A') + 10)
            } else {
                throw NumberFormatException("Non-hex character at #${i}: '${c}' (value ${UInt32(c).format("0x")})")
            }
            if (j < 8) {
            	hi = (hi << 8) | Int64(curr)
            } else {
            	lo = (lo << 8) | Int64(curr)
            }
            j++
            i++
        }		
        return UUID(hi, lo)
    }

    /**
     * Factory method for constructing {@link UUID} instance from given 16 bytes.
     * NOTE: since absolutely no validation is done for contents, this method should
     * only be used if contents are known to be valid.
     *
     * @param bytes - Valid arrays
     * @return UUID
     */
    public static func uuid(bytes: Array<Int8>): UUID {
        checkUUIDByteArray(bytes, 0)
        let l1: Int64 = gatherLong(bytes, 0)
        let l2: Int64 = gatherLong(bytes, 8)
        return UUID(l1, l2)
    }

    /**
     * Factory method for constructing {@link UUID} instance from given
     * 16 bytes.
     * NOTE: since absolutely no validation is done for contents, this method should
     * only be used if contents are known to be valid.
     * 
     * @param bytes Array that contains sequence of 16 bytes that contain a valid UUID
     * @param offset Offset of the first of 16 bytes
     * @return UUID
     */
    public static func uuid(bytes: Array<Int8>, offset: Int32): UUID {
        checkUUIDByteArray(bytes, offset)
        return UUID(gatherLong(bytes, offset), gatherLong(bytes, offset + 8))
    }

    /**
     * Helper method for constructing UUID instances with appropriate type
     * 
     * @param types - UUIDType
     * @param uuidBytes - 16 bytes array
     * @return UUID
     */
    @OverflowWrapping
    public static func constructUUID(types: UUIDType, uuidBytes: Array<Int8>): UUID {
        // first, ensure type is ok
        var b: Int32 = Int32(uuidBytes[Int64(BYTE_OFFSET_TYPE)] & 0xF) // clear out high nibble
        b |= Int32(types.raw() << 4)
        uuidBytes[Int64(BYTE_OFFSET_TYPE)] = Int8(b)
        // second, ensure variant is properly set too
        b = Int32(uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_VARIATION)] & 0x3F) // remove 2 MSB
        b |= 0x80 // set as '10'
        uuidBytes[Int64(BYTE_OFFSET_VARIATION)] = Int8(b)
        return uuid(uuidBytes)
    }
    
    /**
     * Helper method for constructing UUID instances with appropriate type
     * 
     * @param l1 - the least significant 64 bits of this UUID's 128 bit value.
     * @param l2 - the most significant 64 bits of this UUID's 128 bit value.
     * @return UUID
     */
    public static func constructUUID(types: UUIDType, l1: Int64, l2: Int64): UUID {
        var ll1: Int64 = l1
        var ll2: Int64 = l2
        // first, ensure type is ok
        ll1 &= (!0xF000) // remove high nibble of 6th byte
        ll1 |= (types.raw() << 12)
        // second, ensure variant is properly set too (8th byte most-sig byte of second long)
        ll2 = rightShift((ll2 << 2), 2) // remove 2 MSB
        ll2 |= (2 << 62) // set 2 MSB to '10'
        return UUID(ll1, ll2)
    }
    
    /**
     * Initialize the least significant 64 bits of the 128 bit value of this UUID based on type
     * 
     * @param l1 - the least significant 64 bits of this UUID's 128 bit value.
     * @param types - UUIDType.
     * @return Int64
     */
    public static func initUUIDFirstLong(l1: Int64, types: UUIDType): Int64 {
        return initUUIDFirstLong(l1, Int32(types.raw()))
    }

    /**
     * Initialize the least significant 64 bits of the 128 bit value of this UUID based on type
     * 
     * @param l1 - the least significant 64 bits of this UUID's 128 bit value.
     * @param rawType - UUIDType.raw()
     * @return Int64
     */
    public static func initUUIDFirstLong(l1: Int64, rawType: Int32): Int64 {
        var ll1: Int64 = l1
        ll1 &= (!0xF000) // remove high nibble of 6th byte
        ll1 |= Int64(rawType << 12)
        return ll1
    }

    /**
     * Initialize the least significant 64 bits of the 128 bit value
     * 
     * @param l2 - the least significant 64 bits of this UUID's 128 bit value.
     * @return Int64
     */
    public static func initUUIDSecondLong(l2: Int64): Int64 {
        var ll2: Int64 = l2
        ll2 = rightShift((ll2 << 2), 2) // remove 2 MSB
        ll2 |= (2 << 62) // set 2 MSB to '10'
        return ll2
    }
    
    /**
     * Method for determining which type of UUID given UUID is.
     * 
     * @param uuid - UUID to check
     * 
     * @return UUIDType - UUIDType
     *                    NoneValueException  
     */
    @OverflowWrapping
    public static func typeOf(uuid: UUID): ?UUIDType {
        // Ok: so 4 MSB of byte at offset 6...
        let l: Int64 = uuid.getMostSignificantBits()
        let typeNibble: Int32 = (Int32(l) >> 12) & 0xF
        
        match (typeNibble) {
            case 0 =>
                if (l == 0 && uuid.getLeastSignificantBits() == l) {
                    return UUIDType.UNKNOWN
                }
            case 1 =>
                return UUIDType.TIME_BASED
            case 2 =>
                return UUIDType.DCE
            case 3 =>
                return UUIDType.NAME_BASED_MD5
            case 4 =>
                return UUIDType.RANDOM_BASED
            case 5 =>
                return UUIDType.NAME_BASED_SHA1
            case 6 =>
                return UUIDType.TIME_BASED_REORDERED
            case 7 =>
                return UUIDType.TIME_BASED_EPOCH
            case 8 =>
                return UUIDType.FREE_FORM
            case _ => 
                return Option<UUIDType>.None
        }
        return Option<UUIDType>.None
    }

    /**
     * Get the Array of UUID
     * 
     * @param uuid - UUID to check
     * 
     * @return Array<Int8>
     */
    @OverflowWrapping
    public static func asByteArray(uuid: UUID): Array<Int8> {
        let hi: Int64 = uuid.getMostSignificantBits()
        let lo: Int64 = uuid.getLeastSignificantBits()
        var result: Array<Int8> = Array<Int8>(16, item: 0)
        appendInt(Int32(hi >> 32), result, 0)
        appendInt(Int32(hi), result, 4)
        appendInt(Int32(lo >> 32), result, 8)
        appendInt(Int32(lo), result, 12)
        return result
    }

    /**
     * if you have longer buffer already
     * 
     * @param uuid - UUID to check
     * @param buffer - buffer
     * @return Unit
     */
    public static func toByteArray(uuid: UUID, buffer: Array<Int8>): Unit {
        toByteArray(uuid, buffer, 0)
    }

    /**
     * if you have longer buffer already,append at position {@code offset}
     * 
     * @param uuid - UUID to check
     * @param buffer - buffer
     * @param offset - position
     * @return Unit
     */
    @OverflowWrapping
    public static func toByteArray(uuid: UUID, buffer: Array<Int8>, offset: Int32): Unit {
        checkUUIDByteArray(buffer, offset)
        let hi: Int64 = uuid.getMostSignificantBits()
        let lo: Int64 = uuid.getLeastSignificantBits()
        appendInt(Int32(hi >> 32), buffer, offset)
        appendInt(Int32(hi), buffer, offset + 4)
        appendInt(Int32(lo >> 32), buffer, offset + 8)
        appendInt(Int32(lo), buffer, offset + 12)
    }

    protected static func gatherLong(buffer: Array<Int8>, offset: Int32): Int64 {
        let hi: Int64 = (Int64(gatherInt(buffer, offset))) << 32
        let lo: Int64 = rightShift(((Int64(gatherInt(buffer, offset+4))) << 32), 32)
        return hi | lo
    }
    
    @OverflowWrapping
    private static func appendInt(value: Int32, buffer: Array<Int8>, offset: Int32): Unit {
        var os: Int32 = offset
        buffer[Int64(os)] = Int8(value >> 24)
        os++
        buffer[Int64(os)] = Int8(value >> 16)
        os++
        buffer[Int64(os)] = Int8(value >> 8)
        os++
        buffer[Int64(os)] = Int8(value)
    }
    
    private static func gatherInt(buffer: Array<Int8>, offset: Int32): Int32 {
        return Int32((Int32(Int64(buffer[Int64(offset)])) << 24) | (Int32(Int64(buffer[Int64(offset + 1)]) & 0xFF) << 16) | (Int32(Int64(buffer[Int64(offset + 2)]) & 0xFF) << 8) | Int32(Int64(buffer[Int64(offset + 3)]) & 0xFF))
    }

    private static func checkUUIDByteArray(bytes: Array<Int8>, offset: Int32): Unit {
        if (bytes.size == 0) {
            throw IllegalArgumentException("Invalid bytes passed: can not be null")
        }
        if (offset < 0) {
            throw IllegalArgumentException("Invalid offset (${offset}) passed: can not be negative")
        }
        if ((offset + 16) > Int32(bytes.size)) {
            throw IllegalArgumentException("Invalid offset (${offset}) passed: not enough room in byte array (need 16 bytes)")
        }
    }    
}
