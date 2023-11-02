// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from std import unittest.*
from std import unittest.testmacro.*

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
        @Assert("c464cb54-da68-36d5-a15b-6ebbd2bd02ec", uuid.toString())
        @Assert(3, name.getType().raw())
    }
}

