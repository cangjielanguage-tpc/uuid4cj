// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {   
    var arr: Array<UInt8> = Array<UInt8>(6, item: 0)
    var add = EthernetAddress.valueOf(arr)
    if(add.toLong() != 0) {
        return -1
    }
    
    return 0
}
