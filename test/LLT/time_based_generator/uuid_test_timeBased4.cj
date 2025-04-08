
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import crypto.crypto.SecureRandom
import std.random.*
import std.time.*
import std.fs.*
import std.format.Formatter

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
