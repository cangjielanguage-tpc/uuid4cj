//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*

@Test
public class uuid_Standard_017{
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_DNS():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.SHA1))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"cbd88ca2-d47a-5ecc-bf09-73d2beeb84c7")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_URL():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_URL, MessageDigest(DigestType.SHA1))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"430af79a-55ad-5570-b7af-420c1c95823b")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_OID():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_OID, MessageDigest(DigestType.SHA1))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"ee99fac8-36df-59d0-b293-e2e98fc8e908")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_5_SHA1_NAMESPACE_X500():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_X500, MessageDigest(DigestType.SHA1))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"26f3da01-5999-5447-b074-6d443151b195")
        @Assert(uuid.toString(),uuid2.toString())
    }
   
}