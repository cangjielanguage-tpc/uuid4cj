/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
package uuid4cj.uuid4cj

/**
 * Implementation of UUID generator that uses generation method 4.
 *<p>
 * Note on random number generation when using {@link SecureRandom} for random number
 * generation: the first time {@link SecureRandom} object is used, there is noticeable delay between
 * calling the method and getting the reply. This is because SecureRandom
 * has to initialize itself to reasonably random state. Thus, if you
 * want to lessen delay, it may be be a good idea to either get the
 * first random UUID asynchronously from a separate thread, or to
 * use the other generateRandomBasedUUID passing a previously initialized
 * SecureRandom instance.
 *
 * @since 39.8
 */
public class RandomBasedGenerator <: NoArgGenerator{

    /**
     * SecureRandom number generator that this generator uses.
     */
    protected let _sRandom: SecureRandom

    /**
     * Random number generator that this generator uses.
     */
    protected let _random: Random

    protected let lock: Monitor = LazyRandom.getMonitor()

    /**
     * Looks like {@link SecureRandom} implementation is more efficient
     * using single call access (compared to basic {@link java.util.Random}),
     * so let's use that knowledge to our benefit.
     */
    protected let _secureRandom: Bool 

    /**
     * @param rnd - Random number generator to use for generating UUIDs; if null,
     *   shared default generator is used. Note that it is strongly recommend to
     *   use a good random number generator; for example, SecureRandom.
     */
    public init(rnd: Random) {
        _secureRandom = false
        _random = rnd
        _sRandom = LazyRandom.sharedSecureRandom()
    }

    /**
     * @param rnd - SecureRandom number generator to use for generating UUIDs; if null,
     *   shared default generator is used. Note that it is strongly recommend to
     *   use a good random number generator; for example, SecureRandom.
     */
    public init(rnd: SecureRandom) {
        _secureRandom = true
        _sRandom = rnd
        _random = LazyRandom.sharedNewRandom()
    }

    /**
     * Get UUIDType
     *
     * @return UUIDType
     */
    public override func getType(): UUIDType { return UUIDType.RANDOM_BASED}

    /**
     * Generate UUID through random OR SecureRandom
     *
     * @return UUID
     */  
    public override func generate():UUID { 
        let r1: Int64
        let r2: Int64
        
       if (_secureRandom) {
            let buffer: Array<UInt8> = _sRandom.nextBytes(16).toArray()
            r1 = _toLong(buffer, 0);
            r2 = _toLong(buffer, 1);
        } else {
            r1 = safeRandom()
            r2 = safeRandom()
        }
        return UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, r1, r2);
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
        return (Int64(buffer[offset]) << 24) +
            (Int64((buffer[offset+1]) & 0xFF) << 16) +
            (Int64((buffer[offset+2]) & 0xFF) << 8) +
            (Int64(buffer[offset+3]) & 0xFF)
    }

    private func safeRandom(): Int64 {
        synchronized(lock) {
            return _random.nextInt64()
        }
    }

}