// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from std import random.*
from crypto import crypto.SecureRandom
from std import unicode.*

main() {    
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var timer: UUIDTimer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address, timer)
    if(uuid.getEthernetAddress().toString().toUpper() != "87:F5:93:06:D3:0C") {
        return -1
    }
    return 0
}

