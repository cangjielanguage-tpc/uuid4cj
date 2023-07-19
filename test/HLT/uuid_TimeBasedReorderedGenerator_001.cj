//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import random.*
from std import fs.*
from std import time.*
from std import sync.sleep
from crypto import crypto.*

@Test
public class uuid_TimeBasedReorderedGenerator_001{
    @TestCase
    public func uuid_TimeBasedReorderedGenerator_001():Unit{
        println("---------------------------------uuid_TimeBasedReorderedGenerator_001------------------------------")
        var file1 = File("uuid_TimeBasedReorderedGenerator_001.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedReorderedGenerator_001_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        var timeBasedReorderedGenerator = TimeBasedReorderedGenerator(Option<EthernetAddress>.None,UUIDTimer(SecureRandom(),fbts))

        var bytearry_ = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry_).trimAsciiRight()}")
        var bytearry2_ = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry2_).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry_).trimAsciiRight() == "",true)
        @Assert(String.fromUtf8(bytearry2_).trimAsciiRight() == "",true)

        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry).trimAsciiRight()}")
        var bytearry2 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry2).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiRight() != "",true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiRight() == "",true)
        sleep((1*1000)* Duration.millisecond)

        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry3 = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry3).trimAsciiRight()}")
        var bytearry4 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry4).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry).trimAsciiRight() == String.fromUtf8(bytearry3).trimAsciiRight(),true)
        @Assert(String.fromUtf8(bytearry2).trimAsciiRight() == "",true)

        sleep((10*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry5 = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry5).trimAsciiRight()}")
        var bytearry6 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry6).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry3).trimAsciiRight() == String.fromUtf8(bytearry5).trimAsciiRight(),true)
        @Assert(String.fromUtf8(bytearry6).trimAsciiRight() != "",true)

        sleep((1*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry7 = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry7).trimAsciiRight()}")
        var bytearry8 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry8).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry5).trimAsciiRight() == String.fromUtf8(bytearry7).trimAsciiRight(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiRight() == String.fromUtf8(bytearry6).trimAsciiRight(),true)

        sleep((10*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry9 = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry9).trimAsciiRight()}")
        var bytearry10 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry10).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry7).trimAsciiRight() != String.fromUtf8(bytearry9).trimAsciiRight(),true)
        @Assert(String.fromUtf8(bytearry8).trimAsciiRight() == String.fromUtf8(bytearry10).trimAsciiRight(),true)

        sleep((10*1000)* Duration.millisecond)
        println("生成uuid:${timeBasedReorderedGenerator.generate()}")
        var bytearry11 = File.readFrom("uuid_TimeBasedReorderedGenerator_001.txt")
        println("file1: ${String.fromUtf8(bytearry11).trimAsciiRight()}")
        var bytearry12 = File.readFrom("uuid_TimeBasedReorderedGenerator_001_2.txt")
        println("file2: ${String.fromUtf8(bytearry12).trimAsciiRight()}")
        @Assert(String.fromUtf8(bytearry9).trimAsciiRight() == String.fromUtf8(bytearry11).trimAsciiRight(),true)
        @Assert(String.fromUtf8(bytearry10).trimAsciiRight() != String.fromUtf8(bytearry12).trimAsciiRight(),true)
    }
    @TestCase
    public func uuid_TimeBasedReorderedGenerator_002():Unit{
        println("---------------------------------uuid_TimeBasedReorderedGenerator_002------------------------------")
        var file1 = File("uuid_TimeBasedReorderedGenerator_002.txt", OpenOption.CreateOrTruncate(true))
        var file2 = File("uuid_TimeBasedReorderedGenerator_002_2.txt", OpenOption.CreateOrTruncate(true))
        var fbts = FileBasedTimestampSynchronizer(file1,file2) 
        var timeBasedReorderedGenerator = TimeBasedReorderedGenerator(EthernetAddress("00:C0:F0:3D:5B:7C"),UUIDTimer(SecureRandom(),fbts))
        println("TimeBasedReorderedGenerator.getType():${timeBasedReorderedGenerator.getType().raw()}")
        @Assert(timeBasedReorderedGenerator.getType().raw(),6)
        println("TimeBasedReorderedGenerator.getEthernetAddress():${timeBasedReorderedGenerator.getEthernetAddress()}")
        @Assert(timeBasedReorderedGenerator.getEthernetAddress().toString(),"00:c0:f0:3d:5b:7c")
        var uuid = timeBasedReorderedGenerator.generate()
        println("TimeBasedReorderedGenerator.generate():${uuid}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.version(),6)
        println("uuid.variant(): ${uuid.variant()}")
        @Assert(uuid.variant(),2)
        var uuid2 = timeBasedReorderedGenerator.generate()
        println("TimeBasedReorderedGenerator.generate():${uuid2}")
        @Assert(uuid.toString() != uuid2.toString(),true)
    }
}