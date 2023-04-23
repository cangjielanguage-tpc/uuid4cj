
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  


    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer()

    let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, oFile)


    let uuid: UUID = a.generate()

    if(uuid.version() != 1) {
        return -1
    }

    if(uuid.variant() != 2) {
        return -2
    }
    return 0
}
