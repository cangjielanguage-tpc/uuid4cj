// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {    
    var ethernet_address: EthernetAddress =  EthernetAddress(0)
    if(ethernet_address.toString().toLower() != "00:00:00:00:00:00".toLower()) {
        return -1
    }
    return 0
}
