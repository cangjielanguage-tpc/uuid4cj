// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var s: String = "helloworld"
    var uuid1: UUID = Generators.nameBasedGenerator(namespace).generate(s)
    var uuid2: UUID = Generators.nameBasedGenerator(namespace).generate(s.toUtf8Array())
    let type1: Int64 = Generators.nameBasedGenerator(namespace).getType().raw()
    let type2: Int64 = Generators.nameBasedGenerator(namespace).getType().raw()
    let s1: String = uuid1.toString()
    let s2: String = uuid2.toString()
    if(s1 != s2) {
        return -1
    }

    return 0
}

