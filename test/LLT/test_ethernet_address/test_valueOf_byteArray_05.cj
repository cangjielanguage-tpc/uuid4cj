// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {   
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]
    var add = EthernetAddress.valueOf(arr)
    if(add.toLong() != Int64(0x000087f59306d30c)) {
        return -1
    }
    
    return 0
}
