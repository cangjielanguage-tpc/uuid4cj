//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*

@Test
public class uuid_Standard_004 {
    @TestCase
    public func uuid_Generators_3_MD5_NAMESPACE_DNS():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")

        var name2: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.MD5))
        let uuid3: UUID = name2.generate("hello worldhello world")
        println("UUIDType: ${name.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于MD5摘要生成的UUID: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        println("uuid3: ${uuid3.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(uuid.version(),3)
        @Assert(uuid.variant(),2)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"b19189f9-4548-3aab-b923-47aefbcdd0a7")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_3_MD5_NAMESPACE_URL():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_URL, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于MD5摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"64cacb45-4bce-3b61-8714-1cb5bd63ac1d")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_3_MD5_NAMESPACE_OID():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_OID, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于MD5摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"e358ca3c-f9fc-3846-8322-d8c511a3a11b")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_3_MD5_NAMESPACE_X500():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_X500, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于MD5摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"054faba8-fc2f-302b-ad0f-6cb01c9c3f89")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_Generators_3_MD5_():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.MD5))
        var exc = ""
        try {
            name.generate("")
        } catch (e:Exception) {
            println(e.message)
            exc = e.message
        }
        @Assert(exc,"The input cannot be empty!")
    }
}