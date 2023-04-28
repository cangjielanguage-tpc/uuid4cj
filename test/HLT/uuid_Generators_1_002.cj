//3rd_party_lib:uuid4cj/build/uuid
//3rd_party_lib:uuid4cj/ci_lib/cryptocj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid import uuid.*

@Test
public class uuid_Generators_1_002{
    @TestCase
    public func uuid_Generators_1_0021():Unit{
        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
        var time: TimeBasedGenerator = Generators.timeBasedGenerator(address)
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("基于时间+默认地址生成UUID: ${uuid.toString()}")
        println("基于时间+默认地址生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(time.getType().raw(),1)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }
    @TestCase
    public func uuid_Generators_1_0022():Unit{
        var time: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None)
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("基于时间+默认地址生成UUID: ${uuid.toString()}")
        println("基于时间+默认地址生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(time.getType().raw(),1)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }
}