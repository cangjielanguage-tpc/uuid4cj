// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: String = "helloworld"
    var uuid1: UUID = Generators.nameBasedGenerator().generate(s)
    var uuid2: UUID = Generators.nameBasedGenerator().generate(UInt8ToInt8(s.toUtf8Array()))
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

@overflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}