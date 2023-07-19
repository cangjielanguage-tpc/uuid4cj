// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {   
    var add = EthernetAddress.valueOf(0x000087f59306d30c)
    if(add.toLong() != Int64(0x000087f59306d30c)) {
        return -1
    }
    
    return 0
}
