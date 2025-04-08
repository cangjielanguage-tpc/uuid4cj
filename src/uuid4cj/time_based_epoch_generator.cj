/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/**
 * Implementation of UUID generator that uses time/location based generation
 * method field from the Unix Epoch timestamp source - the number of 
 * milliseconds seconds since midnight 1 Jan 1970 UTC, leap seconds excluded.
 * This is usually referred to as "Variant 7".
 * As all JUG provided implementations, this generator is fully thread-safe.
 *
 * @since 38.2
 */
public class TimeBasedEpochGenerator <: NoArgGenerator {

    protected var _random: ?Random = Option<Random>.None
    protected var _srandom: ?SecureRandom = Option<SecureRandom>.None

    /**
     * TimeBasedEpochGenerator initialization,default SecureRandom
     */
    public init(){
        this._srandom = LazyRandom.sharedSecureRandom()
    }

    /**
     * TimeBasedEpochGenerator initialization
     * 
     * @param rnd - Random
     */
    public init(rnd: Random){
        this._random = rnd
    }

    /**
     * get type
     * 
     * @return UUIDType
     */
    public func getType(): UUIDType {
        return UUIDType.TIME_BASED_EPOCH
    }

    /**
     * UUID generation
     * 
     * @return UUID
     */
    public func generate(): UUID {
        let rawTimestamp: Int64 = UUIDClock().currentTimeMillis()
        var rnd: Array<UInt8> = Array<UInt8>(10, item: 0)
        match(_random) {
            case Some(_) => 
                rnd = _random.getOrThrow().nextBytes(10)
            case None => 
                rnd = _srandom.getOrThrow().nextBytes(10)
        }
        let l1: Int64 = (rawTimestamp << 16) | _toShort(rnd, 8)
        let l2: Int64 = _toLong(rnd, 0)
        return UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, l1, l2)
    }

    protected static func  _toLong(buffer: Array<UInt8>, offset: Int64): Int64 {
        var l1:Int64 = _toInt(buffer, offset)
        var l2:Int64 = _toInt(buffer, offset + 4)
        let l = (l1 << 32) + rightShift((l2 << 32), 32)
        return l
    }

    private static func _toInt(buffer: Array<UInt8>, offset: Int64) {
         return (Int64(buffer[offset]) << 24)+ ((Int64(buffer[offset + 1]) & 0xFF) << 16)+ ((Int64(buffer[offset + 2]) & 0xFF) << 8)+ (Int64(buffer[offset + 3]) & 0xFF)
    }

    private static func _toShort(buffer: Array<UInt8>, offset: Int64){
         return ((Int64(buffer[offset]) & 0xFF) << 8) + (Int64(buffer[offset + 1]) & 0xFF)
    }


}
