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
        var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
        var name: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("helloworld")
        println(uuid.toString())
        @Assert("def0fbe0-63e1-3bc5-8c80-3e4f481c1661", uuid.toString())
        @Assert(3, name.getType().raw())
    }
}

