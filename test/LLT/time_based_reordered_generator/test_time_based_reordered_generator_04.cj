// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from std import random.*

main() {    
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var timer: UUIDTimer = UUIDTimer(Random(), Option<FileBasedTimestampSynchronizer>.None)
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address, timer)
    if(uuid.getEthernetAddress().toString().toUpper() != "87:F5:93:06:D3:0C") {
        return -1
    }
    return 0
}

