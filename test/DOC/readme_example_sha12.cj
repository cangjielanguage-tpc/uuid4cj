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
        var name: NameBasedGenerator = Generators.nameBasedGenerator(namespace)
        let uuid: UUID = name.generate("helloworld")
        @Assert("8cf4fccd-e796-5676-9352-57ff9bed87d1", uuid.toString())
        @Assert(5, name.getType().raw())
    }
}

