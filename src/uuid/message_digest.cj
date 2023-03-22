/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

package uuid

from cryptocj import md5cj.*
from cryptocj import sha1cj.*

/*
 * The class is digest type
 * @since 0.37.2
 */
public enum DigestType <: ToString{
    | MD5 
    | SHA1

    operator func ==(b: DigestType): Bool {
        this.toString().equals(b.toString())
    } 

    /*
     * Convert the digest type to string
     *
     * @return String
     */
    public func toString(): String {
        match (this) {
            case MD5 => "MD5"
            case SHA1 => "SHA1"
        }
    }
}

/*
 * The class is message digest
 * @since 0.37.2
 */
public class MessageDigest {
    let algorithm: DigestType

    /*
     * message digest initialization
     *
     * @param algorithm - digest type
     */
    public init(algorithm: DigestType) {
        this.algorithm = algorithm
    }

    /*
     * Get digest type
     *
     * @return DigestType - digest type
     */
    public func getAlgorithm(): DigestType {
        return this.algorithm
    }

    /*
     * Digest the information
     *
     * @param input - digest message
     * @return Array<UInt8> - Results after digest
     */
    public func digest(input: Array<UInt8>): Array<UInt8> {
        if(input.size == 0) {
            throw UUIDException("The input cannot be empty!")
        }
        if(this.algorithm == DigestType.MD5) {
            var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, item: 0)
            md5(input, md)
            return md
        } else {
            var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
            sha1(input, md)
            return md
        }
        return Array<UInt8>()
    }
}