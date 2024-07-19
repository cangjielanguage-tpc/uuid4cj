// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.MD5))
    let uuid: UUID = name.generate("hello world")
    var uuid2 = uuid
    let uuid3: UUID = name.generate("hello world")

    if(uuid.equals(uuid3) && uuid.equals(uuid2)){
        return 0
    }

    return -1
}
