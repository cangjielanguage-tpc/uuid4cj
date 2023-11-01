// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from std import unittest.*
from std import unittest.testmacro.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

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

