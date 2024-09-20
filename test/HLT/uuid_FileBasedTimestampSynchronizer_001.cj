//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*
import std.fs.*

@Test
public class uuid_FileBasedTimestampSynchronizer_001{
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_001():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_001------------------------------")
        var file = File("uuid_UUIDTimer_001.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_UUIDTimer_001_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file,file2)     
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),11000)
        @Assert(fbts.update(2000),12000)
        var bytearry = File.readFrom("uuid_UUIDTimer_001.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x0000000000002af8]")
        var bytearry2 = File.readFrom("uuid_UUIDTimer_001_2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000000002ee0]")
    }
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_002():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_002------------------------------")
        var fbts = FileBasedTimestampSynchronizer()     
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),11000)
        @Assert(fbts.update(2000),12000)
        var bytearry = File.readFrom("uuid1.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x0000000000002af8]")
        var bytearry2 = File.readFrom("uuid2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000000002ee0]")
    }
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_003():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_003------------------------------")
        var file = File("uuid_UUIDTimer_003.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_UUIDTimer_003_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file,file2,1000)  
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),2000)
        @Assert(fbts.update(2000),3000)
        var bytearry = File.readFrom("uuid_UUIDTimer_003.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x00000000000007d0]")
        var bytearry2 = File.readFrom("uuid_UUIDTimer_003_2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000000000bb8]")
    }
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_004():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_004------------------------------")
        var file = File("uuid_UUIDTimer_004.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_UUIDTimer_004_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file,file2) 
        fbts.setUpdateInterval(1000)
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),2000)
        @Assert(fbts.update(2000),3000)
        var bytearry = File.readFrom("uuid_UUIDTimer_004.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x00000000000007d0]")
        var bytearry2 = File.readFrom("uuid_UUIDTimer_004_2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000000000bb8]")
    }
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_005():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_005------------------------------")
        var file = File("uuid_UUIDTimer_005.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_UUIDTimer_005_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file,file2) 
        fbts.setUpdateInterval(1000*1000*1000*2)
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),2000001000)
        @Assert(fbts.update(2000),2000002000)
        var bytearry = File.readFrom("uuid_UUIDTimer_005.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x00000000773597e8]")
        var bytearry2 = File.readFrom("uuid_UUIDTimer_005_2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000077359bd0]")
    }
    @TestCase
    public func uuid_FileBasedTimestampSynchronizer_006():Unit{
        println("---------------------------------uuid_FileBasedTimestampSynchronizer_006------------------------------")
        var file = File("uuid_UUIDTimer_006.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_UUIDTimer_006_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file,file2) 
        fbts.setUpdateInterval(1000*1000*1000*2)
        println("fbts.update(1000): ${fbts.update(1000)}")
        println("fbts.update(2000): ${fbts.update(2000)}")
        @Assert(fbts.update(1000),2000001000)
        @Assert(fbts.update(2000),2000002000)
        var bytearry = File.readFrom("uuid_UUIDTimer_006.txt")
        println(String.fromUtf8(bytearry).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd(),"[0x00000000773597e8]")
        var bytearry2 = File.readFrom("uuid_UUIDTimer_006_2.txt")
        println(String.fromUtf8(bytearry2).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd(),"[0x0000000077359bd0]")

        fbts.setUpdateInterval(1000)
        println("fbts.update(1000): ${fbts.update(1000)}")
        var bytearry3 = File.readFrom("uuid_UUIDTimer_006.txt")
        println(String.fromUtf8(bytearry3).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry3).trimAsciiEnd(),"[0x00000000000007d0]")

        var bytearry4 = File.readFrom("uuid_UUIDTimer_006_2.txt")
        println(String.fromUtf8(bytearry4).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry4).trimAsciiEnd(),"[0x0000000077359bd0]")

        println("fbts.update(2000): ${fbts.update(2000)}")
        var bytearry5 = File.readFrom("uuid_UUIDTimer_006.txt")
        println(String.fromUtf8(bytearry5).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry5).trimAsciiEnd(),"[0x00000000000007d0]")

        var bytearry6 = File.readFrom("uuid_UUIDTimer_006_2.txt")
        println(String.fromUtf8(bytearry6).trimAsciiEnd())
        @Assert(String.fromUtf8(bytearry6).trimAsciiEnd(),"[0x0000000000000bb8]")
    }
}