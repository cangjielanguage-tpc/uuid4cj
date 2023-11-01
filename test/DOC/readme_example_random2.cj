// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from std import unittest.*
from std import unittest.testmacro.*
from crypto import crypto.SecureRandom
from std import random.*

main() {   
    let testReadmeExample = TestReadmeExample()
    testReadmeExample.test1()
    return 0
}

@Test
public class TestReadmeExample {
    @TestCase
    public func test1(): Unit {
        let _random: Random = Random()
        let b: RandomBasedGenerator = Generators.randomBasedGenerator(_random)
        let uuid: UUID = b.generate()
        @Assert(4, uuid.version())
    }
}

