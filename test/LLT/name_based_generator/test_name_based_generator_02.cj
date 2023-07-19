// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var s: String = "helloworld"
    var uuid1: UUID = Generators.nameBasedGenerator(namespace).generate(s)
    var uuid2: UUID = Generators.nameBasedGenerator(namespace).generate(UInt8ToInt8(s.toUtf8Array()))
    let s1: String = uuid1.toString()
    let s2: String = uuid2.toString()
    if(s1 != s2) {
        return -1
    }

    return 0
}

@OverflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}