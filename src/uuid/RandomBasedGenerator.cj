/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class RandomBasedGenerator {

    protected let _sharedRandom: Random = Random()
    protected let _sRandom: SecureRandom
    protected let _random: Random
    protected let _secureRandom: Bool 


    public init(rnd: Random) {
        _secureRandom = false;
        _random = rnd
         _sRandom = LazyRandom.sharedSecureRandom();
    }

    public init(rnd: SecureRandom) {
        _secureRandom = true;
    
        _sRandom = rnd
         _random = Random()
    }

    // @Override
    public func getType(): UUIDType { return UUIDType.RANDOM_BASED}

    // @Override
    public func generate():UUID { 
        let r1: Int64
        let r2: Int64
        
       if (_secureRandom) {
            println("11")
            let buffer: Array<UInt8> = Array<UInt8>(_sRandom.nextBytes(16))
            r1 = _toLong(buffer, 0);
            r2 = _toLong(buffer, 1);
        } else {
            println("22")
            r1 =  _random.nextInt64()
            r2 =  _random.nextInt64()
        }
        println(r1)
        println(r2)
        // return util.constructUUID(UUIDType.RANDOM_BASED, r1, r2);
        return UUID(r1, r2)
    }

    protected func _toLong(buffer: Array<UInt8>, offset: Int64): Int64
    {
        let l1: Int64 = _toInt(buffer, offset)
        let l2: Int64 = _toInt(buffer, offset+4)
        let l: Int64 = (l1 << 32) + rightShift((l2 << 32), 32)
        return l
    }

    private func _toInt(buffer: Array<UInt8>, offset: Int64): Int64
    {
        return (Int64(buffer[offset]) << 24)
            + (Int64((buffer[offset+1]) & 0xFF) << 16)
            + (Int64((buffer[offset+2]) & 0xFF) << 8)
            + (Int64(buffer[offset+3]) & 0xFF)
    }

}