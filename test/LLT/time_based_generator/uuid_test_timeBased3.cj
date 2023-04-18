
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  
    let filePath1: String = "./ggg.txt"

    var file1: File

    if (File.exists(filePath1)) {
        file1 = File(filePath1, OpenOption.Open(true, true))
    } else {
        file1 = File(filePath1, OpenOption.Create(true))
    }

    let filePath2: String = "./zzzz.txt"

    var file2: File

    if (File.exists(filePath2)) {
        file2 = File(filePath2, OpenOption.Open(true, true))
    } else {
        file2 = File(filePath2, OpenOption.Create(true))
    }


    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)

    let a: TimeBasedGenerator = Generators.timeBasedGenerator(oFile)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<FileBasedTimestampSynchronizer>.None)

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
