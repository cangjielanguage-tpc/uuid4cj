//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*

@Test
public class uuid_Standard_018 {
    @TestCase
    public func uuid_Standard_018 ():Unit{
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(uuid.version(),5)
        @Assert(uuid.variant(),2)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
}