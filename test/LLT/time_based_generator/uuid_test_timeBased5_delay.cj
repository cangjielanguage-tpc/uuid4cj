
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import crypto.crypto.SecureRandom
import std.random.*
import std.time.*
import std.fs.*
import std.convert.Formattable

main() {  

    let a: TimeBasedGenerator = Generators.timeBasedGenerator()
    let uuid: UUID = a.generate()
    
    let uuid2: UUID = a.generate()

    let uuid3: UUID = a.generate()

    let var1 = uuid.getBytes() == uuid2.getBytes()

    let var2 = uuid.getBytes() == uuid3.getBytes()

    let var3 = uuid2.getBytes() == uuid3.getBytes()
    if (var1 || var2 || var3) {
        return -1
    }

    return 0
}

