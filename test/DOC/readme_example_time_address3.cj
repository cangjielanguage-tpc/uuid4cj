// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unittest.*
import std.unittest.testmacro.*
import crypto.crypto.SecureRandom
import std.random.*
import std.time.*
import std.fs.*
import std.convert.Formattable

main() {   
    let testReadmeExample = TestReadmeExample()
    testReadmeExample.test1()
    return 0
}

@Test
public class TestReadmeExample {
    @TestCase
    public func test1(): Unit {
        var timer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
        let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, timer)

        let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, Option<UUIDTimer>.None)


        let uuid: UUID = a.generate()

        let uuid2: UUID = b.generate()

        @Assert(1, uuid.version())
        @Assert(1, uuid2.version())
        
    }
}

