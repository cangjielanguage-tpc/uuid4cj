
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  
    let filePath1: String = "./ggg_3.txt"

    var file1: File

    if (File.exists(filePath1)) {
        file1 = File(filePath1, OpenOption.Open(true, true))
    } else {
        file1 = File(filePath1, OpenOption.Create(true))
    }

    let filePath2: String = "./zzz_3.txt"

    var file2: File

    if (File.exists(filePath2)) {
        file2 = File(filePath2, OpenOption.Open(true, true))
    } else {
        file2 = File(filePath2, OpenOption.Create(true))
    }


    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)
    var ethernetAddress: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")

    let a: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress, oFile)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, Option<FileBasedTimestampSynchronizer>.None)

    let uuid: UUID = a.generate()

    let uuid2: UUID = b.generate()

    file1.close()
    file2.close()

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
