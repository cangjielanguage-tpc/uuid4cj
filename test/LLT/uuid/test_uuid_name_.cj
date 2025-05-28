// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let name: Array<UInt8> = "helloworld".toArray()
    let uuid = UUID.nameUUIDFromBytes(UInt8ToInt8(name))
    if(uuid.toString() != "fc5e038d-38a5-3032-8854-41e7fe7010b0" ) {
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