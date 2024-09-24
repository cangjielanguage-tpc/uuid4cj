// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    var name: NameBasedGenerator = Generators.nameBasedGenerator(MessageDigest(DigestType.MD5))
    let uuid: UUID = name.generate("hello")
    if (uuid.toString() != "5d41402a-bc4b-3a76-b971-9d911017c592") {
        return 1
    }

    var name1: NameBasedGenerator = Generators.nameBasedGenerator(MessageDigest(DigestType.SHA1))
    let uuid1: UUID = name1.generate("hello")
    if (uuid1.toString() != "aaf4c61d-dcc5-58a2-9abe-de0f3b482cd9") {
        return 1
    }
    return 0
}
