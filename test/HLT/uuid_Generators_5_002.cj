//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*

@Test
public class uuid_Generators_5_002{
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_DNS():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"823a2f73-a936-56c3-b8b4-03641bd74f35")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_URL():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_URL)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"7b3d66ac-cb60-5154-8edf-0bcfd0c418b3")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_OID():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_OID)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"25024589-1a7c-5625-bdb2-81143473d4d3")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_X500():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_X500)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"dbd9b896-6d7c-5852-895c-ecc5735cf874")
        @Assert(uuid.toString(),uuid2.toString())
    }
}