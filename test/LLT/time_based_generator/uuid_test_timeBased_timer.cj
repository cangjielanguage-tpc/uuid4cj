
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*

main() {
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, UUIDTimer(Random(UInt64( Time.now().unixTimeStamp().milliseconds())), Option<FileBasedTimestampSynchronizer>.None))
    let uuid: UUID = a.generate()

    if(uuid.version() != 1) {
        return -1
    }
    if(uuid.variant() != 2) {
        return -2
    }
    return 0
}