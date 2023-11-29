//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import random.*

@Test
public class uuid_Generators_7_002{
    @TestCase
    public func uuid_Generators_7_002():Unit{
        var time: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator(Random(1))
        let uuid: UUID = time.generate()
        let uuid2: UUID = time.generate()
        println("UUIDType: ${time.getType().raw()}")
        println("基于时间的纪元生成UUID: ${uuid.toString()}")
        println("基于时间的纪元生成UUID2: ${uuid2.toString()}")
        @Assert(time.getType() is UUIDType,true)
        @Assert(time.getType().raw(),7)
        @Assert(uuid.toString()==uuid2.toString(),false)
    }

}