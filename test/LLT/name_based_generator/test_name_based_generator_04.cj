// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var s: String = "helloworld"
    var name2: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.SHA1))
    var name3: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.MD5))
    var name4: NameBasedGenerator = Generators.nameBasedGenerator(namespace)
    var name5: NameBasedGenerator = Generators.nameBasedGenerator()
    var uuid2: UUID = name2.getNamespace()
    var uuid3: UUID = name3.getNamespace()
    var uuid4: UUID = name4.getNamespace()
   
    if(
        uuid2.toString() != namespace.toString() ||
        uuid3.toString() != namespace.toString() ||
        uuid4.toString() != namespace.toString() 
        
    ) {
        return -1
    }

    try {
        var uuid5: UUID = name5.getNamespace()
    }catch(e: Exception) {
        if(!e.toString().contains("NoneValueException")) {
            return -3
        }
        return 0
    }

    return -2
}

