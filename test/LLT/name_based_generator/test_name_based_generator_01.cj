// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: String = "helloworld"
    var uuid1: UUID = Generators.nameBasedGenerator().generate(s)
    var uuid2: UUID = Generators.nameBasedGenerator().generate(s.toUtf8Array())
    let type1: Int64 = Generators.nameBasedGenerator().getType().raw()
    let type2: Int64 = Generators.nameBasedGenerator().getType().raw()
    let s1: String = uuid1.toString()
    let s2: String = uuid2.toString()

    if(s1 != "6adfb183-a4a2-594a-af92-dab5ade762a4" ||
       s1 != s2 || 
       type1 != 5 ||
       type1 != type2
       ) {
        return -2
    }

    return 0
}

