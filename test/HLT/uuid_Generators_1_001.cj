//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*

@Test
public class uuid_Generators_1_001{
    @TestCase
    public func uuid_Generators_1_001():Unit{
        var time: TimeBasedGenerator = Generators.timeBasedGenerator()
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("uuid.version(): ${uuid.version()}")
        println("uuid.variant(): ${uuid.variant()}")
        println("基于时间+默认地址生成UUID: ${uuid.toString()}")
        println("基于时间+默认地址生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(uuid.version(),1)
        @Assert(uuid.variant(),2)
        @Assert(time.getType().raw(),1)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }

}