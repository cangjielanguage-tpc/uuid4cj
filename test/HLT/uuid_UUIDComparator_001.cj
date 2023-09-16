//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import random.*

@Test
public class uuid_UUIDComparator_001{
    @TestCase
    public func uuid_UUIDComparator_001():Unit{
        println("---------------------------------uuid_UUIDComparator_001------------------------------")
        let uuid = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2,0)))
        let uuid2 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(0,2)))
        let uuid3 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2,2)))
        let uuid4 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2,2)))

        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        println("uuid3: ${uuid3.toString()}")
        println("uuid4: ${uuid4.toString()}")

        println("UUIDComparator.compare(uuid,uuid): ${UUIDComparator.compare(uuid,uuid)}")
        println("UUIDComparator.compare(uuid,uuid2): ${UUIDComparator.compare(uuid,uuid2)}")
        println("UUIDComparator.compare(uuid,uuid3): ${UUIDComparator.compare(uuid,uuid3)}")
        println("UUIDComparator.compare(uuid3,uuid4): ${UUIDComparator.compare(uuid3,uuid4)}")
        
        @Assert(UUIDComparator.compare(uuid,uuid),0)
        @Assert(UUIDComparator.compare(uuid,uuid2)>0,true)
        @Assert(UUIDComparator.compare(uuid,uuid3)<0,true)
        @Assert(UUIDComparator.compare(uuid3,uuid4),0)
    }
}
@OverflowWrapping
func Int8ToUInt8(arr: Array<Int8>): Array<UInt8> {
    var res: Array<UInt8> = Array<UInt8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = UInt8(arr[i])
    }
    return res
}