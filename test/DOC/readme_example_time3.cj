// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unittest.*
import std.unittest.testmacro.*
import stdx.crypto.crypto.SecureRandom

main() {   
    let testReadmeExample = TestReadmeExample()
    testReadmeExample.test1()
    return 0
}

@Test
public class TestReadmeExample {
    @TestCase
    public func test1(): Unit {
        var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
        var timer: UUIDTimer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
        var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address, timer)
        var uuid: UUID = time.generate()
        @Assert(6, uuid.version())
    }
}

