/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj

/**
 * Default UUID comparator is not very useful
 * This comparator does implement proper lexical ordering: starting with
 * type, followed by time and location, and simple lexical (byte-by-byte) 
 * ordering for name/hash and random variants.
 * 
 * @since 0.38.2
 */
public class UUIDComparator {

    /**
     * UUID comparator
     *
     * @param u1 - UUID
     * @param u2 - UUID
     * @return Int32
     */
    public static func compare(u1: UUID, u2:UUID): Int32 {
        return staticCompare(u1, u2)
    }

    /**
     * Static helper method that can be used instead of instantiating comparator
     * (used by unit tests, can be used by code too)
     */
    @OverflowWrapping
    static func staticCompare(u1: UUID, u2: UUID): Int32 {
        // First: major sorting by types
        let types: Int32 = u1.version()
        var diffs: Int32 = types - u2.version()
        if (diffs != 0) {
            return diffs
        }
        // Second: for time-based variant, order by time stamp:
        if (Int64(types) == UUIDType.TIME_BASED.raw()) {
            diffs = compareULongs(u1.timestamp(), u2.timestamp())
            if (diffs == 0) {
                // or if that won't work, by other bits lexically
                diffs = compareULongs(UUIDUtil.getLeastSignificantBits(u1), UUIDUtil.getLeastSignificantBits(u2))
            }
        } else {
            // note: java.util.UUIDs compares with sign extension, IMO that's wrong, so:
            diffs = compareULongs(UUIDUtil.getMostSignificantBits(u1),
                    UUIDUtil.getMostSignificantBits(u2))
            if (diffs == 0) {
                diffs = compareULongs(UUIDUtil.getLeastSignificantBits(u1),
                        UUIDUtil.getLeastSignificantBits(u2))
            }
        }
        return diffs
    }

    @OverflowWrapping
    static func compareULongs(l1: Int64, l2: Int64): Int32 {
        var diffs: Int32 = compareUInts(Int32(l1 >> 32), Int32(l2 >> 32))
        if (diffs == 0) {
            diffs = compareUInts(Int32(l1), Int32(l2))
        }
        return diffs
    }

    static func compareUInts(i1: Int32, i2: Int32):Int32 {
        /* if both have same sign, normal comparison (by subtraction) works fine
         * but if signs don't agree need to resolve diffserently
         */
        if (i1 < 0) {
            if(i2 < 0) {
                return (i1 - i2)
            }
            return 1
        }
        if(i2 < 0) {
            return -1
        } else {
            return (i1 - i2)
        }
        
    }
}
