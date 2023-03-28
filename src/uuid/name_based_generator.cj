package uuid

from charset import charset.*
from charset import charset.unicode.*
from charset import charset.encoding.*
from std import log.*

public class NameBasedGenerator <: StringArgGenerator {
    public static let  _utf8 = newUTF8Charset()
    private let logger: SimpleLogger = SimpleLogger()
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
    
    public init(namespace: ?UUID, digester: ?MessageDigest, types: ?UUIDType) {
        _namespace = namespace
        // And default digester SHA-1
        match (digester) {
            case None => 
                _digester = MessageDigest(DigestType.SHA1)
            case Some(v) =>
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
            case Some(v) =>
                _types = types
        }
    }

    public override func getType(): UUIDType {
        return _types.getOrThrow() 
    }
    
    // NoneValueException
    public func getNamespace(): UUID { 
        return _namespace.getOrThrow() 
    }
    
    public override func generate(name: String): UUID {
        return generate(_utf8.newEncoder().encode(name))
    }
    
    @overflowWrapping
    public override func generate(nameBytes: Array<UInt8>): UUID {
        var digest: Array<UInt8> = Array<UInt8>()
        _digester.getOrThrow().reset()
        match (_namespace) {
            case Some(v) =>
                _digester.getOrThrow().update(Int8ToUInt8(UUIDUtil.asByteArray(v)))
                _digester.getOrThrow().update(nameBytes)
                digest = _digester.getOrThrow().digest()
            case None => 
                digest = _digester.getOrThrow().digest(input: nameBytes)
        }
        return UUIDUtil.constructUUID(_types.getOrThrow(), UInt8ToInt8(digest))
    }
    
}
