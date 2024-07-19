//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.collection.*
import std.time.*
import std.sync.*
import crypto.crypto.*

@Test
public class uuid_Reliability_timeBasedGenerator_004{
    @Skip
    @TestCase
    public func uuid_Reliability_timeBasedGenerator_004():Unit{
        let threadCount = 200
        let loopCount = 10000
        let futures = ArrayList<Future<Int64>>()
        let successCount = AtomicInt64(0)
        let s = DateTime.now()
        for (_ in 0..threadCount) {
            var thread = spawn {
                var threadSuccessCount = loopCount
                for (_ in 0..loopCount) {
                    try {
                        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
                        var time: TimeBasedGenerator = Generators.timeBasedGenerator(address,UUIDTimer(SecureRandom(), FileBasedTimestampSynchronizer()))
                        let uuid: UUID = time.generate()
                        @Assert(time.getType().raw(),1)
                    } catch (e: Exception) {
                        println("Exception!!!! ")
                        threadSuccessCount--
                        break
                    }
                }
                successCount.fetchAdd(threadSuccessCount)
            }
            futures.append(thread)
        }
        for (f in futures) {
            f.get()
        }
        println("futures:${futures.size}")
        println("s:${s}")
        println("Duration.since(s):${Duration.since(s)}")
        let e = Duration.since(s).toSeconds()
        println("线程数:${threadCount}")
        println("successCount:${successCount.load()}")
        println("循环次数:${loopCount}")
        println("耗时:${e} s")
        println("吞吐量:${Float32(successCount.load())/Float32(e)} 次/s")
    }
}