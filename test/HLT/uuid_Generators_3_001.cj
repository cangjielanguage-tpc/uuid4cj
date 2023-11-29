//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*

@Test
public class uuid_Generators_3_001{
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
        @Assert(uuid.toString(),"11f3c98e-ee6f-32d6-93cc-8ea97b77b2a0")
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
        @Assert(uuid.toString(),"1ac8da69-0d38-3d76-9610-25ab6ee6dc2f")
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
        @Assert(uuid.toString(),"5af444b8-bf08-3277-946a-be3800a0349e")
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
        @Assert(uuid.toString(),"3dba5e6d-ce97-3b41-a58c-686674d18ada")
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