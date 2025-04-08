//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*
import std.fs.*
import std.time.*
import std.core.sleep
import crypto.crypto.*

@Test
public class uuid_TimeBasedGenerator_001{
    func funcuuid(){
        var file1 = File("uuid_TimeBasedGenerator_004.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_004_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        var timeBasedGenerator = TimeBasedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))
        println("生成uuid:${timeBasedGenerator.generate()}")
        sleep((10*1000) * Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        file1.close()
        file2.close()
    }
    @TestCase
    public func uuid_TimeBasedGenerator_001():Unit{
        println("---------------------------------uuid_TimeBasedGenerator_001------------------------------")
        var file1 = File("uuid_TimeBasedGenerator_001.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_001_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        var timeBasedGenerator = TimeBasedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))

        var bytearry_ = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry_).trimAsciiEnd()}")
        var bytearry2_ = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry2_).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry_).trimAsciiEnd() == "",true)
        @Assert(String.fromUtf8(bytearry2_).trimAsciiEnd() == "",true)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry).trimAsciiEnd()}")
        var bytearry2 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry2).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() != "",true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)
        sleep((1*1000) * Duration.millisecond)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry3 = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry3).trimAsciiEnd()}")
        var bytearry4 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry4).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() == String.fromUtf8(bytearry3).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)

        sleep((10*1000) * Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry5 = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry5).trimAsciiEnd()}")
        var bytearry6 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry6).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry3).trimAsciiEnd() == String.fromUtf8(bytearry5).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry6).trimAsciiEnd() != "",true)

        sleep((1*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry7 = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry7).trimAsciiEnd()}")
        var bytearry8 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry8).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry5).trimAsciiEnd() == String.fromUtf8(bytearry7).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry6).trimAsciiEnd(),true)

        sleep((10*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry9 = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry9).trimAsciiEnd()}")
        var bytearry10 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry10).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry7).trimAsciiEnd() != String.fromUtf8(bytearry9).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry10).trimAsciiEnd(),true)

        sleep((10*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry11 = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry11).trimAsciiEnd()}")
        var bytearry12 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry12).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry9).trimAsciiEnd() == String.fromUtf8(bytearry11).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry10).trimAsciiEnd() != String.fromUtf8(bytearry12).trimAsciiEnd(),true)
    }
    @TestCase
    public func uuid_TimeBasedGenerator_002():Unit{
        println("---------------------------------uuid_TimeBasedGenerator_002------------------------------")
        var file1 = File("uuid_TimeBasedGenerator_002.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_002_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2,5*1000) 
        var timeBasedGenerator = TimeBasedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))

        var bytearry_ = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry_).trimAsciiEnd()}")
        var bytearry2_ = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry2_).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry_).trimAsciiEnd() == "",true)
        @Assert(String.fromUtf8(bytearry2_).trimAsciiEnd() == "",true)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry).trimAsciiEnd()}")
        var bytearry2 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry2).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() != "",true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)
        sleep((1*1000)* Duration.millisecond)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry3 = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry3).trimAsciiEnd()}")
        var bytearry4 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry4).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() == String.fromUtf8(bytearry3).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry5 = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry5).trimAsciiEnd()}")
        var bytearry6 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry6).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry3).trimAsciiEnd() == String.fromUtf8(bytearry5).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry6).trimAsciiEnd() != "",true)

        sleep((1*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry7 = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry7).trimAsciiEnd()}")
        var bytearry8 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry8).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry5).trimAsciiEnd() == String.fromUtf8(bytearry7).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry6).trimAsciiEnd(),true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry9 = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry9).trimAsciiEnd()}")
        var bytearry10 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry10).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry7).trimAsciiEnd() != String.fromUtf8(bytearry9).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry10).trimAsciiEnd(),true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry11 = File.readFrom("uuid_TimeBasedGenerator_002.txt")
        println("file1: ${String.fromUtf8(bytearry11).trimAsciiEnd()}")
        var bytearry12 = File.readFrom("uuid_TimeBasedGenerator_002_2.txt")
        println("file2: ${String.fromUtf8(bytearry12).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry9).trimAsciiEnd() == String.fromUtf8(bytearry11).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry10).trimAsciiEnd() != String.fromUtf8(bytearry12).trimAsciiEnd(),true)
    }
    @TestCase
    public func uuid_TimeBasedGenerator_003():Unit{
        println("---------------------------------uuid_TimeBasedGenerator_003------------------------------")
        var file1 = File("uuid_TimeBasedGenerator_003.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_003_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        fbts.setUpdateInterval(5*1000)
        var timeBasedGenerator = TimeBasedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))

        var bytearry_ = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry_).trimAsciiEnd()}")
        var bytearry2_ = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry2_).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry_).trimAsciiEnd() == "",true)
        @Assert(String.fromUtf8(bytearry2_).trimAsciiEnd() == "",true)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry).trimAsciiEnd()}")
        var bytearry2 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry2).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() != "",true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)
        sleep((1*1000)* Duration.millisecond)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry3 = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry3).trimAsciiEnd()}")
        var bytearry4 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry4).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() == String.fromUtf8(bytearry3).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == "",true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry5 = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry5).trimAsciiEnd()}")
        var bytearry6 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry6).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry3).trimAsciiEnd() == String.fromUtf8(bytearry5).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry6).trimAsciiEnd() != "",true)

        sleep((1*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry7 = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry7).trimAsciiEnd()}")
        var bytearry8 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry8).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry5).trimAsciiEnd() == String.fromUtf8(bytearry7).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry6).trimAsciiEnd(),true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry9 = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry9).trimAsciiEnd()}")
        var bytearry10 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry10).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry7).trimAsciiEnd() != String.fromUtf8(bytearry9).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiEnd() == String.fromUtf8(bytearry10).trimAsciiEnd(),true)

        sleep((5*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry11 = File.readFrom("uuid_TimeBasedGenerator_003.txt")
        println("file1: ${String.fromUtf8(bytearry11).trimAsciiEnd()}")
        var bytearry12 = File.readFrom("uuid_TimeBasedGenerator_003_2.txt")
        println("file2: ${String.fromUtf8(bytearry12).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry9).trimAsciiEnd() == String.fromUtf8(bytearry11).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry10).trimAsciiEnd() != String.fromUtf8(bytearry12).trimAsciiEnd(),true)
    }
    @TestCase
    @Skip
    public func uuid_TimeBasedGenerator_004():Unit{
        println("---------------------------------uuid_TimeBasedGenerator_004------------------------------")
        funcuuid()
        var file1 = File("uuid_TimeBasedGenerator_004.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_004_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        fbts.setUpdateInterval(20*1000)
        var timeBasedGenerator = TimeBasedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))

        var bytearry_ = File.readFrom("uuid_TimeBasedGenerator_004.txt")
        println("file1: ${String.fromUtf8(bytearry_).trimAsciiEnd()}")
        var bytearry2_ = File.readFrom("uuid_TimeBasedGenerator_004_2.txt")
        println("file2: ${String.fromUtf8(bytearry2_).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry_).trimAsciiEnd() != "",true)
        @Assert(String.fromUtf8(bytearry2_).trimAsciiEnd() != "",true)
        sleep((1*1000)* Duration.millisecond)

        println("生成uuid:${timeBasedGenerator.generate()}")
        var bytearry = File.readFrom("uuid_TimeBasedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry).trimAsciiEnd()}")
        var bytearry2 = File.readFrom("uuid_TimeBasedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry2).trimAsciiEnd()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiEnd() == String.fromUtf8(bytearry_).trimAsciiEnd(),true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiEnd() == String.fromUtf8(bytearry2_).trimAsciiEnd(),true)
    }
    @TestCase
    public func uuid_TimeBasedGenerator_005():Unit{
        println("---------------------------------uuid_TimeBasedGenerator_005------------------------------")
        var file1 = File("uuid_TimeBasedGenerator_005.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedGenerator_005_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        var timeBasedGenerator = TimeBasedGenerator(EthernetAddress("00:C0:F0:3D:5B:7C"),UUIDTimer(SecureRandom(),fbts))
        println("timeBasedGenerator.getType():${timeBasedGenerator.getType().raw()}")
        @Assert(timeBasedGenerator.getType().raw(),1)
        println("timeBasedGenerator.getEthernetAddress():${timeBasedGenerator.getEthernetAddress()}")
        @Assert(timeBasedGenerator.getEthernetAddress().toString(),"00:c0:f0:3d:5b:7c")
        var uuid = timeBasedGenerator.generate()
        println("timeBasedGenerator.generate():${uuid}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.version(),1)
        println("uuid.variant(): ${uuid.variant()}")
        @Assert(uuid.variant(),2)
        var uuid2 = timeBasedGenerator.generate()
        @Assert(uuid.toString() != uuid2.toString(),true)
    }
}