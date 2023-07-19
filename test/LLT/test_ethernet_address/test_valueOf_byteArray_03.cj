// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {   
    var arr: Array<UInt8> = Array<UInt8>(7, item: 0)
    try {
        EthernetAddress.valueOf(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}
