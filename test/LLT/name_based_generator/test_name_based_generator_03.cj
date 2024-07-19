// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var s: String = "helloworld"
    var name2: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.SHA1))
    var name3: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.MD5))
    var name4: NameBasedGenerator = Generators.nameBasedGenerator(namespace)
    var name5: NameBasedGenerator = Generators.nameBasedGenerator()
    var uuid2: UUID = name2.generate(s)
    var uuid4: UUID = name4.generate(s)
    if(
        uuid2.toString() != uuid4.toString() ||
        name2.getType().raw() != 5 ||
        name3.getType().raw() != 3 ||
        name4.getType().raw() != 5 ||
        name5.getType().raw() != 5
    ) {
        return -1
    }

    return 0
}

