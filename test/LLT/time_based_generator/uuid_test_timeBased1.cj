
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    var ethernetAddress1: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]
    var ethernetAddress2: Option<EthernetAddress> =  EthernetAddress(arr)
    var ethernetAddress3: Option<EthernetAddress> =  EthernetAddress(Int64(0x000087f59306d30c))

    let a: TimeBasedGenerator = Generators.timeBasedGenerator()
    let b: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1)
    let c: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress2)
    let d: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress3)

    let uuid: UUID = a.generate()

    if(uuid.version() != 1) {
        return -1
    }
    if(uuid.variant() != 2) {
        return -2
    }

    if(b.getEthernetAddress().toLong() != Int64(0x000087f59306d30c)) {
        return -3
    }

    if(b.getType().raw() != 1) {
        return -4
    }

    if(c.getEthernetAddress().toLong() != Int64(0x000087f59306d30c)) {
        return -5
    }

    if(c.getType().raw() != 1) {
        return -6
    }

    if(d.getEthernetAddress().toLong() != Int64(0x000087f59306d30c)) {
        return -7
    }

    if(d.getType().raw() != 1) {
        return -8
    }

    return 0
}