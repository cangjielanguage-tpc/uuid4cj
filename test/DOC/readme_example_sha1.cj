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
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("helloworld")
        @Assert("6adfb183-a4a2-594a-af92-dab5ade762a4", uuid.toString())
        @Assert(5, name.getType().raw())
    }
}

