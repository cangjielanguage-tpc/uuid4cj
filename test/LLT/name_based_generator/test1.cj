// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

internal import crypto4cj.md5cj.*
internal import crypto4cj.sha1cj.*
internal import crypto4cj.sha224cj.*
internal import crypto4cj.sha256cj.*
internal import crypto4cj.sha384cj.*
internal import crypto4cj.sha512cj.*

main() {    

    var s = "hello".toArray()
    var md: Array<UInt8> = Array<UInt8>(16, repeat: 0)
    var sh: Array<UInt8> = Array<UInt8>(20, repeat: 0)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }

    md5Update(MD5CTX(), s)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }

    sha1Update(SHACTX(), s)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }

    md5(s, md)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }
    if (md.toString() != "[93, 65, 64, 42, 188, 75, 42, 118, 185, 113, 157, 145, 16, 23, 197, 146]") {
        return 1
    }

    sha1(s, sh)
    if (s.toString() != "[104, 101, 108, 108, 111]") {
        return 1
    }
    if (sh.toString() != "[170, 244, 198, 29, 220, 197, 232, 162, 218, 190, 222, 15, 59, 72, 44, 217, 174, 169, 67, 77]") {
        return 1
    }

    return 0
}
