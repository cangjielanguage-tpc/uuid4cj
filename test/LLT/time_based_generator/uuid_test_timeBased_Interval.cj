
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import crypto.crypto.SecureRandom
import std.random.*
import std.time.*
import std.fs.*
import std.format.Formatter
import std.io.SeekPosition
import std.core.sleep


main() {  

    var file1: File = File("gggg_delay.txt", OpenOption.CreateOrTruncate(true))
    var file2: File = File("zzzz_delay.txt", OpenOption.CreateOrTruncate(true))

    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)
    oFile.getOrThrow().setUpdateInterval(10 * 1000) // 10s update
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, oFile)

    a.generate()

    sleep((1*1000) * Duration.millisecond) //1s sleep

    a.generate()

    sleep((10*1000) * Duration.millisecond) //10s sleep

    a.generate()

    file1.close()
    file2.close()

    return 0
}
