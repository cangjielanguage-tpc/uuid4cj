//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from crypto import crypto.*

@Test
public class uuid_Standard_013{
    @TestCase
    public func uuid_Standard_013():Unit{
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
}