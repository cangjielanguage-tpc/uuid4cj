// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {    
    var x: EthernetAddress =  EthernetAddress(0)
    if(x.toLong() != 0) {
        return -1
    }
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]
    var xx: EthernetAddress =  EthernetAddress(arr)
    if(xx.toLong() != Int64(0x000087f59306d30c)) {
        return -1
    }
    return 0
}
