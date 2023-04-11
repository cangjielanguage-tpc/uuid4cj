/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package uuid

/**
 * Default UUID comparator is not very useful, since
 * it just does blind byte-by-byte comparison which does not work well
 * for time+location - based UUIDs. Additionally it also uses signed
 * comparisons for longs which can lead to unexpected behavior
 * This comparator does implement proper lexical ordering: starting with
 * type (different types are collated
 * separately), followed by time and location (for time/location based),
 * and simple lexical (byte-by-byte) ordering for name/hash and random
 * variants.
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
    @overflowWrapping
    static func staticCompare(u1: UUID, u2: UUID): Int32 {
        // First: major sorting by types
        let types: Int32 = u1.version()
        var diff: Int32 = types - u2.version()
        if (diff != 0) {
            return diff
        }
        // Second: for time-based variant, order by time stamp:
        if (Int64(types) == UUIDType.TIME_BASED.raw()) {
            diff = compareULongs(u1.timestamp(), u2.timestamp())
            if (diff == 0) {
                // or if that won't work, by other bits lexically
                diff = compareULongs(u1.getLeastSignificantBits(), u2.getLeastSignificantBits())
            }
        } else {
            // note: java.util.UUIDs compares with sign extension, IMO that's wrong, so:
            diff = compareULongs(u1.getMostSignificantBits(),
                    u2.getMostSignificantBits())
            if (diff == 0) {
                diff = compareULongs(u1.getLeastSignificantBits(),
                        u2.getLeastSignificantBits())
            }
        }
        return diff
    }

    @overflowWrapping
    static func compareULongs(l1: Int64, l2: Int64): Int32 {
        var diff: Int32 = compareUInts(Int32(l1 >> 32), Int32(l2 >> 32))
        if (diff == 0) {
            diff = compareUInts(Int32(l1), Int32(l2))
        }
        return diff
    }

    static func compareUInts(i1: Int32, i2: Int32):Int32 {
        /* if both have same sign, normal comparison (by subtraction) works fine
         * but if signs don't agree need to resolve differently
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
