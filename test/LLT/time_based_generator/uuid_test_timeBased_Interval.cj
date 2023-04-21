
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


    var mFile1: LockedFile = LockedFile(file1)
    var mFile2: LockedFile = LockedFile(file2)


    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)
    oFile.getOrThrow().setUpdateInterval(10 * 1000) // 10s update
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(oFile)

    a.generate()

    sleep(1*1000 * 1000 * 1000) //1s sleep

    a.generate()

    sleep(10*1000 * 1000 * 1000) //10s sleep

    a.generate()
    

    file1.seek(SeekPosition.Begin(0))
    file2.seek(SeekPosition.Begin(0))

    var result1New: Int64 = mFile1.readStamp()
    var result2New: Int64 = mFile2.readStamp()
    file1.close()
    file2.close()


    if (result1New <= 0 || result2New <= 0) {
        return -1
    }
    
    return 0
}
