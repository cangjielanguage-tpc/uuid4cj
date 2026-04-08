/**
 * @file
 * This file provides digest functionality using stdx.crypto.digest.
 */
package uuid4cj.uuid4cj

import stdx.crypto.digest.*
import stdx.encoding.hex.*

// MD5 digest length in bytes
public let MD5_DIGEST_LENGTH: Int64 = 16

// SHA1 digest length in bytes
public let SHA_DIGEST_LENGTH: Int64 = 20

/**
 * The class is Crypto exception handling
 * @since 0.32.5
 */
public class CryptoException <: Exception {
    public init() {
        super()
    }
    public init(messages: String) {
        super(messages)
    }
}

/**
 * MD5 context wrapper compatible with the old interface
 */
public class MD5CTX {
    let instance: MD5

    /**
     * Initialize MD5 context
     */
    public init() {
        this.instance = MD5()
    }
}

/**
 * SHA1 context wrapper compatible with the old interface
 */
public class SHACTX {
    let instance: SHA1

    /**
     * Initialize SHA1 context
     */
    public init() {
        this.instance = SHA1()
    }
}

/**
 * Call this function circularly to add different data together to calculate MD5
 *
 * @param c - MD5CTX context
 * @param data - data to be encrypted
 * @since 0.32.5
 */
public func md5Update(c: MD5CTX, data: Array<UInt8>): Unit {
    if (data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    c.instance.write(data)
}

/**
 * Finalize MD5 calculation
 *
 * @param md - output array for encrypted data
 * @param c - MD5CTX context
 * @since 0.32.5
 */
public func md5Final(md: Array<UInt8>, c: MD5CTX): Unit {
    if (md.size < 16) {
        throw CryptoException("md5Final: The length of md is greater than or equal to ${MD5_DIGEST_LENGTH}.")
    }
    let result: Array<Byte> = c.instance.finish()
    for (i in 0..result.size) {
        md[i] = UInt8(result[i])
    }
}

/**
 * Calculate MD5 in one shot
 *
 * @param data - data to be encrypted
 * @param md - output array for encrypted data
 * @since 0.32.5
 */
public func md5(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if (data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if (md.size < 16) {
        throw CryptoException("md5: The length of md is greater than or equal to ${MD5_DIGEST_LENGTH}.")
    }
    let instance = MD5()
    instance.write(data)
    let result: Array<Byte> = instance.finish()
    for (i in 0..result.size) {
        md[i] = UInt8(result[i])
    }
}

/**
 * Convert MD5 bytes to hex string (32 characters)
 *
 * @param md - MD5 data
 * @return String - hex string result
 * @since 0.32.5
 */
public func md5HexToString(md: Array<UInt8>): String {
    return toHexString(md)[..(MD5_DIGEST_LENGTH * 2)]
}

/**
 * Call this function circularly to add different data together to calculate SHA1
 *
 * @param c - SHACTX context
 * @param data - data to be encrypted
 * @since 0.32.5
 */
public func sha1Update(c: SHACTX, data: Array<UInt8>): Unit {
    if (data.size <= 0) {
        throw CryptoException("The data can not be empty.")
    }
    c.instance.write(data)
}

/**
 * Finalize SHA1 calculation
 *
 * @param md - output array for encrypted data
 * @param c - SHACTX context
 * @since 0.32.5
 */
public func sha1Final(md: Array<UInt8>, c: SHACTX): Unit {
    if (md.size != SHA_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA_DIGEST_LENGTH}.")
    }
    let result: Array<Byte> = c.instance.finish()
    for (i in 0..result.size) {
        md[i] = UInt8(result[i])
    }
}

/**
 * Calculate SHA1 in one shot
 *
 * @param data - data to be encrypted
 * @param md - output array for encrypted data
 * @since 0.32.5
 */
public func sha1(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if (data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if (md.size != SHA_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA_DIGEST_LENGTH}.")
    }
    let instance = SHA1()
    instance.write(data)
    let result: Array<Byte> = instance.finish()
    for (i in 0..result.size) {
        md[i] = UInt8(result[i])
    }
}
