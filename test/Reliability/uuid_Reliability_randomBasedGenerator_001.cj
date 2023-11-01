//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import collection.*
from std import time.*
from std import sync.*
from std import random.*

@Test
public class uuid_Reliability_randomBasedGenerator_001{
    @Skip
    @TestCase
    public func uuid_Reliability_randomBasedGenerator_001():Unit{
        let threadCount = 200
        let loopCount = 10000
        let futures = ArrayList<Future<Int64>>()
        let successCount = AtomicInt64(0)
        let s = DateTime.now()
        let random1 =  random.Random(1)
        for (_ in 0..threadCount) {
            var thread = spawn {
                var threadSuccessCount = loopCount
                for (_ in 0..loopCount) {
                    try {
                        // random1.nextInt64()
                        var randuuid: RandomBasedGenerator = Generators.randomBasedGenerator(random1)
                        let uuid: UUID = randuuid.generate()
                        @Assert(randuuid.getType().raw(),4)
                    } catch (e: Exception) {
                        println("Exception!!!! ${e}")
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