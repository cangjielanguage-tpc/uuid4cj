// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unittest.*
import std.unittest.testmacro.*
import crypto.crypto.SecureRandom
import std.random.*

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

