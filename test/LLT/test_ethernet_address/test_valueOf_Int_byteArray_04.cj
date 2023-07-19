// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {   
    var arr: Array<UInt8> = Array<UInt8>(6, item: 0)
    var add = EthernetAddress.valueOf(arr)
    if(add.toLong() != 0) {
        return -1
    }
    
    return 0
}
