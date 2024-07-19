// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {   
    var add = EthernetAddress.valueOf(0)
    if(add.toLong() != 0) {
        return -1
    }
    
    return 0
}
