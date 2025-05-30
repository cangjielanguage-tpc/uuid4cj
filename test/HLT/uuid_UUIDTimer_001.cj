//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*
import std.fs.*
import std.math.*
import stdx.crypto.crypto.*

@Test
public class uuid_UUIDTimer_001{
    @TestCase
    public func uuid_UUIDTimer_001():Unit{
        println("---------------------------------uuid_UUIDTimer_001------------------------------")
        var file = File("UUIDTimer_001.txt", OpenMode.ReadWrite)
        var file2 = File("UUIDTimer_001_2.txt", OpenMode.ReadWrite)
        var fbts = FileBasedTimestampSynchronizer(file,file2,1000) 
        var uuidTimer = UUIDTimer(SecureRandom(),fbts)
        println("uuidTimer.getClockSequence(): ${uuidTimer.getClockSequence()} ${uuidTimer.getClockSequence()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        @Assert(uuidTimer.getClockSequence(),uuidTimer.getClockSequence())
        @Assert(uuidTimer.getTimestamp() <= uuidTimer.getTimestamp(), true)
        @Assert(abs(uuidTimer.getTimestamp()-uuidTimer.getTimestamp()) < 2, true)
    }
    @TestCase
    public func uuid_UUIDTimer_002():Unit{
        println("---------------------------------uuid_UUIDTimer_002------------------------------")
        var uuidTimer = UUIDTimer(SecureRandom(),Option<FileBasedTimestampSynchronizer>.None)
        println("uuidTimer.getClockSequence(): ${uuidTimer.getClockSequence()} ${uuidTimer.getClockSequence()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        @Assert(uuidTimer.getClockSequence(),uuidTimer.getClockSequence())
        @Assert(uuidTimer.getTimestamp() <= uuidTimer.getTimestamp(), true)
        @Assert(abs(uuidTimer.getTimestamp()-uuidTimer.getTimestamp()) < 2, true)
    }
    @TestCase
    public func uuid_UUIDTimer_003():Unit{
        println("---------------------------------uuid_UUIDTimer_003------------------------------")
        var file = File("UUIDTimer_001.txt", OpenMode.ReadWrite)
        var file2 = File("UUIDTimer_001_2.txt", OpenMode.ReadWrite)
        var fbts = FileBasedTimestampSynchronizer(file,file2,1000) 
        var uuidTimer = UUIDTimer(SecureRandom(),fbts,UUIDClock())
        println("uuidTimer.getClockSequence(): ${uuidTimer.getClockSequence()} ${uuidTimer.getClockSequence()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        @Assert(uuidTimer.getClockSequence(),uuidTimer.getClockSequence())
        @Assert(uuidTimer.getTimestamp() <= uuidTimer.getTimestamp(), true)
        @Assert(abs(uuidTimer.getTimestamp()-uuidTimer.getTimestamp()) < 2, true)
    }
    @TestCase
    public func uuid_UUIDTimer_004():Unit{
        println("---------------------------------uuid_UUIDTimer_004------------------------------")
        var uuidTimer = UUIDTimer(SecureRandom(),Option<FileBasedTimestampSynchronizer>.None,UUIDClock())
        println("uuidTimer.getClockSequence(): ${uuidTimer.getClockSequence()} ${uuidTimer.getClockSequence()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        println("uuidTimer.getTimestamp(): ${uuidTimer.getTimestamp()}")
        @Assert(uuidTimer.getClockSequence(),uuidTimer.getClockSequence())
        @Assert(uuidTimer.getTimestamp() <= uuidTimer.getTimestamp(), true)
        @Assert(abs(uuidTimer.getTimestamp()-uuidTimer.getTimestamp()) < 2, true)
    }
}