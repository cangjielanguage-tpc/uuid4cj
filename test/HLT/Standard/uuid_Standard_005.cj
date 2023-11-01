//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*

@Test
public class uuid_Standard_005{
    @TestCase
    public func uuid_Standard_005():Unit{
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator()
        let uuid: UUID = randuuid.generate()
        let uuid2: UUID = randuuid.generate()
        println("UUIDType: ${randuuid.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于随机数 生成的UUID: ${uuid.toString()}")
        println("基于随机数 生成的UUID2: ${uuid2.toString()}")
        @Assert(randuuid.getType() is UUIDType,true)
        @Assert(uuid.version(),4)
        @Assert(uuid.variant(),2)
        @Assert(randuuid.getType().raw(),4)
        @Assert(uuid.toString() == uuid2.toString(),false)
    }
}