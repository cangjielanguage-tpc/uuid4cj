// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*


main() {   
    var add = EthernetAddress.valueOf(0)
    if(add.toLong() != 0) {
        return -1
    }
    
    return 0
}
