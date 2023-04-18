// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from std import random.*
from crypto import crypto.SecureRandom

main() {    
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var timer: UUIDTimer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address, timer)
    uuid.generate()
    if(uuid.getType().raw() != 6) {
        return -1
    }
    return 0
}

