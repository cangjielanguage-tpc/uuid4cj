// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import crypto.crypto.*


main() {   
    var r: SecureRandom = SecureRandom()
    var a1: EthernetAddress = EthernetAddress.constructMulticastAddress(r)
    a1.isLocallyAdministeredAddress()
    a1.isMulticastAddress()
    a1.hashCode()
    if(a1 != a1) {
        return -1
    }
    return 0
}
