// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {   
    try {
        var arr: Array<UInt8> = []
        EthernetAddress.valueOf(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}
