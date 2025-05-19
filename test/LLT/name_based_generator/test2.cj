// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

import stdx.encoding.hex.*
import stdx.crypto.digest.*

main() {    

    var s = "hello".toArray()

    var md5Instance = MD5()
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }

    md5Instance.write(s)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }

    var md: Array<Byte> = md5Instance.finish()
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }
    if (md.toString() != "[93, 65, 64, 42, 188, 75, 42, 118, 185, 113, 157, 145, 16, 23, 197, 146]") {
        return 1
    }

    var result1: String = toHexString(md)
    var result2: String = toHexString(s)
    if (result1 != "5d41402abc4b2a76b9719d911017c592") {
        return 1
    }
    if (result2 != "68656c6c6f") {
        return 1
    }

    return 0
}
