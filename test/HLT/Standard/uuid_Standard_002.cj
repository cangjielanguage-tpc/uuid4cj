//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*

@Test
public class uuid_Standard_002 {
    @TestCase
    public func uuid_Standard_002():Unit{
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
}