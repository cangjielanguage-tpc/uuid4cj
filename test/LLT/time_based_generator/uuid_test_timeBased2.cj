
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*

main() {

    var timer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(timer)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<UUIDTimer>.None)


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
