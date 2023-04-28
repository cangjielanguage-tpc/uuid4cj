//3rd_party_lib:uuid4cj/build/uuid
//3rd_party_lib:uuid4cj/ci_lib/cryptocj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid import uuid.*
from crypto import crypto.*

@Test
public class uuid_Generators_6_003{
    @TestCase
    public func uuid_Generators_6_0031():Unit{
        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
        var uuidtimer: UUIDTimer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
        var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address,uuidtimer)
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("基于时间的重新排序生成UUID: ${uuid.toString()}")
        println("基于时间的重新排序生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(time.getType().raw(),6)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }
    @TestCase
    public func uuid_Generators_6_0032():Unit{
        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
        var uuidtimer: UUIDTimer = UUIDTimer(SecureRandom(), FileBasedTimestampSynchronizer())
        var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address,uuidtimer)
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