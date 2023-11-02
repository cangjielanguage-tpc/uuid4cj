//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from crypto import crypto.*

@Test
public class uuid_Standard_020{
    @TestCase
    public func uuid_Generators_4_SecureRandom_001():Unit{
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(crypto.SecureRandom())
        let uuid: UUID = randuuid.generate()
        let uuid2: UUID = randuuid.generate()
        println("UUIDType: ${randuuid.getType().raw()}")
        println("基于随机数 生成的UUID: ${uuid.toString()}")
        println("基于随机数 生成的UUID2: ${uuid2.toString()}")
        @Assert(randuuid.getType() is UUIDType,true)
        @Assert(randuuid.getType().raw(),4)
        @Assert(uuid.toString() == uuid2.toString(),false)
    }
    @TestCase
    public func uuid_Generators_4_SecureRandom_002():Unit{
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(crypto.SecureRandom(priv: true))
        let uuid: UUID = randuuid.generate()
        let uuid2: UUID = randuuid.generate()
        println("UUIDType: ${randuuid.getType().raw()}")
        println("基于随机数 生成的UUID: ${uuid.toString()}")
        println("基于随机数 生成的UUID2: ${uuid2.toString()}")
        @Assert(randuuid.getType() is UUIDType,true)
        @Assert(randuuid.getType().raw(),4)
        @Assert(uuid.toString() == uuid2.toString(),false)
    }
    @TestCase
    public func uuid_Generators_4_SecureRandom_003():Unit{
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(crypto.SecureRandom(priv: false))
        let uuid: UUID = randuuid.generate()
        let uuid2: UUID = randuuid.generate()
        println("UUIDType: ${randuuid.getType().raw()}")
        println("基于随机数 生成的UUID: ${uuid.toString()}")
        println("基于随机数 生成的UUID2: ${uuid2.toString()}")
        @Assert(randuuid.getType() is UUIDType,true)
        @Assert(randuuid.getType().raw(),4)
        @Assert(uuid.toString() == uuid2.toString(),false)
    }
}