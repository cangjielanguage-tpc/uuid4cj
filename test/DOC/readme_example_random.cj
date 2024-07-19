// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unittest.*
import std.unittest.testmacro.*

main() {   
    let testReadmeExample = TestReadmeExample()
    testReadmeExample.test1()
    return 0
}

@Test
public class TestReadmeExample {
    @TestCase
    public func test1(): Unit {
        let c: RandomBasedGenerator = Generators.randomBasedGenerator()
        let uuid: UUID = c.generate()
        @Assert(4, uuid.version())
    }
}

