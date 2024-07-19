// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unicode.*

main() {    
    var ethernet_address: EthernetAddress =  EthernetAddress(0)
    if(ethernet_address.toString().toLower() != "00:00:00:00:00:00".toLower()) {
        return -1
    }
    return 0
}
