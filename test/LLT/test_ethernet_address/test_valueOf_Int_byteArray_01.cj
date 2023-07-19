// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {   
    try {
        var arr: Array<Int32> = []
        EthernetAddress.valueOf(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}
