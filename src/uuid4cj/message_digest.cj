/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/*
 * The class is digest type
 * @since 0.37.2
 */
public enum DigestType <: ToString{
    | MD5 
    | SHA1

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
    func getType(): Object {
        match (this) {
            case MD5 => MD5CTX()
            case SHA1 => SHACTX()
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
    
    func update(input: Array<UInt8>): Unit {
        this.state = 1
        if(input.size == 0) {
            throw IllegalArgumentException("The input cannot be empty!")
        }
        match (this.algorithm) {
            case DigestType.MD5 =>
                md5Update((this.c as MD5CTX).getOrThrow(), input)
            case DigestType.SHA1 =>
                sha1Update((this.c as SHACTX).getOrThrow(), input) 
        }
    }

    /*
     * Digest the information
     *
     * @param input - digest message
     * @return Array<Int8> - Results after digest
     */
    @OverflowWrapping
    func digest(input!: Array<Int8> = Array<Int8>()): Array<Int8> {
        if(this.state == 1) {
            return UInt8ToInt8(digestProcess())
        }
        return UInt8ToInt8(digestAll(input))
    }

    func reset(): Unit {
        this.state = 0
        this.c = algorithm.getType()
    }

    func digestProcess(): Array<UInt8> {
        match (this.algorithm) {
            case DigestType.MD5 => 
                var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, repeat: 0)
                md5Final(md, (this.c as MD5CTX).getOrThrow())
                return md
            case DigestType.SHA1 => 
                var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, repeat: 0)
                sha1Final(md, (this.c as SHACTX).getOrThrow())
                return md
        }
    }

    @OverflowWrapping
    func digestAll(input: Array<Int8>): Array<UInt8> {
        match (this.algorithm) {
            case DigestType.MD5 => 
                var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, repeat: 0)
                md5(Int8ToUInt8(input), md)
                return md
            case DigestType.SHA1 => 
                var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, repeat: 0)
                sha1(Int8ToUInt8(input), md)
                return md
        }
    }
}
