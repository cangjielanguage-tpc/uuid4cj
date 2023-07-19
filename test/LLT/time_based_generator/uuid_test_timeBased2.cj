
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*

main() {

    var timer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)

    var ethernetAddress: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")
    
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress, timer)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, Option<UUIDTimer>.None)


    let uuid: UUID = a.generate()

    let uuid2: UUID = b.generate()

    if(uuid.version() != 1) {
        return -1
    }
    if(uuid.variant() != 2) {
        return -2
    }

    if(uuid2.version() != 1) {
        return -3
    }
    if(uuid2.variant() != 2) {
        return -4
    }
    return 0
}
