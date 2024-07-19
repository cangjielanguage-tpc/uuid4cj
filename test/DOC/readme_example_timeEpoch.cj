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
        var time: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator()
        let uuid: UUID = time.generate()
        @Assert(7, uuid.version())
    }
}

