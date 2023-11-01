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
        let _sRandom: SecureRandom = LazyRandom.sharedSecureRandom();
        let a: RandomBasedGenerator = Generators.randomBasedGenerator(_sRandom)
        let uuid: UUID = a.generate()
        @Assert(4, uuid.version())
    }
}

