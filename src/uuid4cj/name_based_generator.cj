/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/**
 * Implementation of UUID generator that uses one of name-based generation methods
 * (variants 3 (MD5) and 5 (SHA1)).
 * As all JUG provided implementations, this generator is fully thread-safe; access
 * to digester is synchronized as necessary.
 * 
 * @since 37.2
 */
public class NameBasedGenerator <: StringArgGenerator {
    private let logger = getGlobalLogger()
    /**
     * Namespace used when name is a DNS name.
     */
    public static let NAMESPACE_DNS: UUID = UUID.fromString("6ba7b810-9dad-11d1-80b4-00c04fd430c8")

    /**
     * Namespace used when name is a URL.
     */
    public static let NAMESPACE_URL: UUID = UUID.fromString("6ba7b811-9dad-11d1-80b4-00c04fd430c8")
    /**
     * Namespace used when name is an OID.
     */
    public static let NAMESPACE_OID: UUID = UUID.fromString("6ba7b812-9dad-11d1-80b4-00c04fd430c8")
    /**
     * Namespace used when name is an X500 identifier
     */
    public static let NAMESPACE_X500: UUID = UUID.fromString("6ba7b814-9dad-11d1-80b4-00c04fd430c8") 

    protected var _namespace: ?UUID
    protected var _digester: ?MessageDigest
    protected var _types: ?UUIDType
    
    /**
     * @param namespace - as defined by the
     *   spec. UUID has 4 pre-defined "standard" name space strings
     *   that can be passed to UUID constructor (see example below).
     *   Note that this argument is optional; if no namespace is needed
     *   (for example when name includes namespace prefix), null may be passed.
     * @param digester - Hashing algorithm to use. 
     * @param types - UUIDType
     */
    public init(namespace: ?UUID, digester: ?MessageDigest, types: ?UUIDType) {
        _namespace = namespace
        // And default digester SHA-1
        match (digester) {
            case None => 
                _digester = MessageDigest(DigestType.SHA1)
            case Some(_) =>
                _digester = digester
        }
        match (types) {
            case None => 
                let typeStr: String = _digester.getOrThrow().getAlgorithm().toString()
                if (typeStr.startsWith("MD5")) {
                    _types = UUIDType.NAME_BASED_MD5
                } else if (typeStr.startsWith("SHA")) {
                    _types = UUIDType.NAME_BASED_SHA1
                } else {
                    // Default to SHA-1, but log a warning
                    _types = UUIDType.NAME_BASED_SHA1
                    logger.warn("Could not determine type of Digester from '%s' assuming 'SHA-1' type")
                }
            case Some(_) =>
                _types = types
        }
    }

    /**
     * Get UUIDType
     *
     * @return UUIDType
     */
    public override func getType(): UUIDType {
        return _types.getOrThrow() 
    }
    
    /**
     * Get namespace
     *
     * @return UUID - NAMESPACE_DNS,NAMESPACE_URL,NAMESPACE_OID,NAMESPACE_X500
     *         UUID - NoneValueException
     */
    public func getNamespace(): UUID { 
        return _namespace.getOrThrow() 
    }

    /**
     * Generate UUID through name
     *
     * @param name - string
     * @return UUID
     */  
    @OverflowWrapping  
    public override func generate(name: String): UUID {
        return generate(UInt8ToInt8(name.toArray()))
    }
    
    /**
     * Generate UUID through name
     *
     * @param nameBytes - Array<UInt8>
     * @return UUID
     */
    @OverflowWrapping
    public override func generate(nameBytes: Array<Int8>): UUID {
        var digest: Array<Int8> = Array<Int8>()
        _digester.getOrThrow().reset()
        match (_namespace) {
            case Some(v) =>
                _digester.getOrThrow().update(UUIDUtil.asByteArray(v))
                _digester.getOrThrow().update(Int8ToUInt8(nameBytes))
                digest = _digester.getOrThrow().digest()
            case None => 
                digest = _digester.getOrThrow().digest(input: nameBytes)
        }
        return UUIDUtil.constructUUID(_types.getOrThrow(), digest)
    }
    
}
