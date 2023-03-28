/*
 * Copyright (c) Cangjie Library Team 2023-2024. All rights resvered.
 */

package uuid

from cryptocj import md5cj.*
from cryptocj import sha1cj.*
from cryptocj import sha224cj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

/*
 * The class is digest type
 * @since 0.37.2
 */
public enum DigestType <: ToString{
    | MD5 
    | SHA1
    | SHA224
    | SHA256
    | SHA384
    | SHA512

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
            case SHA224 => "SHA224"
            case SHA256 => "SHA256"
            case SHA384 => "SHA384"
            case SHA512 => "SHA512"
        }
    }
    public func getType(): Object {
        match (this) {
            case MD5 => MD5CTX()
            case SHA1 => SHACTX()
            case SHA224 => SHA224CTX()
            case SHA256 => SHA256CTX()
            case SHA384 => SHA384CTX()
            case SHA512 => SHA512CTX()
        }
    }
}

/*
 * The class is message digest
 * @since 0.37.2
 */
public class MessageDigest {
    let algorithm: DigestType
    var c: Object
    var state: Int32 = 0

    /*
     * message digest initialization
     *
     * @param algorithm - digest type
     */
    public init(algorithm: DigestType) {
        this.algorithm = algorithm
        this.c = algorithm.getType()
        this.state = 0
    }

    /*
     * Get digest type
     *
     * @return DigestType - digest type
     */
    public func getAlgorithm(): DigestType {
        return this.algorithm
    }
    
    public func update(input: Array<UInt8>): Unit {
        this.state = 1
        if(input.size == 0) {
            throw UUIDException("The input cannot be empty!")
        }
        var str: String = unsafe { String.fromUtf8Unchecked(input) }  
        match (this.algorithm) {
            case DigestType.MD5 =>
                md5Update((this.c as MD5CTX).getOrThrow(), str)
            case DigestType.SHA1 =>
                sha1Update((this.c as SHACTX).getOrThrow(), str)
            case DigestType.SHA224 =>
                sha224Update((this.c as SHA224CTX).getOrThrow(), str) 
            case DigestType.SHA256 =>
                sha256Update((this.c as SHA256CTX).getOrThrow(), str) 
            case DigestType.SHA384 =>
                sha384Update((this.c as SHA384CTX).getOrThrow(), str) 
            case DigestType.SHA512 =>
                sha512Update((this.c as SHA512CTX).getOrThrow(), str)  
        }
    }

    /*
     * Digest the information
     *
     * @param input - digest message
     * @return Array<UInt8> - Results after digest
     */
    public func digest(input!: Array<UInt8> = Array<UInt8>()): Array<UInt8> {
        if(this.state == 1) {
            return digestProcess()
        }
        return digestAll(input) 
    }

    public func reset(): Unit {
        this.state = 0
    }

    private func digestProcess(): Array<UInt8> {
        match (this.algorithm) {
            case DigestType.MD5 => 
                var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, item: 0)
                md5Final(md, (this.c as MD5CTX).getOrThrow())
                return md
            case DigestType.SHA1 => 
                var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
                sha1Final(md, (this.c as SHACTX).getOrThrow())
                return md
            case DigestType.SHA224 => 
                var md: Array<UInt8> = Array<UInt8>(SHA224_DIGEST_LENGTH, item: 0)
                sha224Final(md, (this.c as SHA224CTX).getOrThrow())
                return md  
            case DigestType.SHA256 => 
                var md: Array<UInt8> = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                sha256Final(md, (this.c as SHA256CTX).getOrThrow())
                return md  
            case DigestType.SHA384 => 
                var md: Array<UInt8> = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                sha384Final(md, (this.c as SHA384CTX).getOrThrow())
                return md 
            case DigestType.SHA512 => 
                var md: Array<UInt8> = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                sha512Final(md, (this.c as SHA512CTX).getOrThrow())
                return md    
        }
        return Array<UInt8>() 
    }

    private func digestAll(input: Array<UInt8>): Array<UInt8> {
        match (this.algorithm) {
            case DigestType.MD5 => 
                var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, item: 0)
                md5(input, md)
                return md
            case DigestType.SHA1 => 
                var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
                sha1(input, md)
                return md
            case DigestType.SHA224 => 
                var md: Array<UInt8> = Array<UInt8>(SHA224_DIGEST_LENGTH, item: 0)
                sha224(input, md)
                return md  
            case DigestType.SHA256 => 
                var md: Array<UInt8> = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                sha256(input, md)
                return md  
            case DigestType.SHA384 => 
                var md: Array<UInt8> = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                sha384(input, md)
                return md 
            case DigestType.SHA512 => 
                var md: Array<UInt8> = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                sha512(input, md)
                return md    
        }
        return Array<UInt8>() 
    }
}
