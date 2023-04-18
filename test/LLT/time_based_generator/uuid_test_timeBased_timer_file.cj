
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  
    let filePath1: Path = Path("./ggg.txt")

    var file1: File

    if (File.exists(filePath1)) {
        file1 = File(filePath1, OpenOption.Open(true, true))
    } else {
        file1 = File(filePath1, OpenOption.Create(true))
    }

    let filePath2: Path = Path("./zzz.txt")

    var file2: File

    if (File.exists(filePath2)) {
        file2 = File(filePath2, OpenOption.Open(true, true))
    } else {
        file2 = File(filePath2, OpenOption.Create(true))
    }

    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)

    let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, UUIDTimer(Random(UInt64( Time.now().unixTimeStamp().milliseconds())), oFile))
    let uuid: UUID = a.generate()

    if(uuid.version() != 1) {
        return -1
    }
    if(uuid.variant() != 2) {
        return -2
    }
    file1.close()
    file2.close()
    return 0
}