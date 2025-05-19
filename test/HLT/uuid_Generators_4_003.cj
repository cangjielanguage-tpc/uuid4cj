//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import stdx.crypto.crypto.*

@Test
public class uuid_Generators_4_003{
    @TestCase
    public func uuid_Generators_4_SecureRandom_001():Unit{
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(SecureRandom())
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
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(SecureRandom(priv: true))
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
        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(SecureRandom(priv: false))
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