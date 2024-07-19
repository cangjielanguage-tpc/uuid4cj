//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*

@Test
public class uuid_Generators_6_002{
    @TestCase
    public func uuid_Generators_6_002():Unit{
        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
        var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address)
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("基于时间的重新排序生成UUID: ${uuid.toString()}")
        println("基于时间的重新排序生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(time.getType().raw(),6)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }
}