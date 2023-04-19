// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*


main() {    
    var x: EthernetAddress =  EthernetAddress("87:f5:93:06:d3:0c")
    if(x.clone() != x) {
        return -1
    }
    return 0
}
