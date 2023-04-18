// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*


main() {  
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]  
    var ethernet_address: EthernetAddress =  EthernetAddress(arr)
    if(ethernet_address.toString().toLower() != "87:f5:93:06:D3:0c".toLower()) {
        return -1
    }
    return 0
}
