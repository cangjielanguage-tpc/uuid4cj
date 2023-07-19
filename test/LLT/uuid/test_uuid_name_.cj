// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let name: Array<UInt8> = "helloworld".toUtf8Array()
    let uuid = UUID.nameUUIDFromBytes(UInt8ToInt8(name))
    let least = uuid.getLeastSignificantBits()
    let most = uuid.getMostSignificantBits()
    if(uuid.toString() != "fc5e038d-38a5-3032-8854-41e7fe7010b0" ||
        least != -8623194921845649232 ||
        most != -261767823265288142) {
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