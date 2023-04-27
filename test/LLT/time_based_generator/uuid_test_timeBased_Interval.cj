
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter
from std import io.SeekPosition


main() {  

    var file1: File = File("gggg_delay.txt", OpenOption.CreateOrTruncate(true))
    var file2: File = File("zzzz_delay.txt", OpenOption.CreateOrTruncate(true))

    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)
    oFile.getOrThrow().setUpdateInterval(10 * 1000) // 10s update
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, oFile)

    a.generate()

    sleep(1*1000 * 1000 * 1000) //1s sleep

    a.generate()

    sleep(10*1000 * 1000 * 1000) //10s sleep

    a.generate()

    file1.close()
    file2.close()

    return 0
}
