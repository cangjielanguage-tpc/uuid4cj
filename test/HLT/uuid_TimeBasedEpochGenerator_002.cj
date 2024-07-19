//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*

@Test
public class uuid_TimeBasedEpochGenerator_002{
    @TestCase
    public func uuid_TimeBasedEpochGenerator_002():Unit{
        var time: TimeBasedEpochGenerator = TimeBasedEpochGenerator(Random(1))
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