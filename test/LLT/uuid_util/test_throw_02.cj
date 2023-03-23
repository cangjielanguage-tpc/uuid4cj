// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    try {
        UUIDUtil.uuid(s, 14)
    } catch(e: UUIDException) {
        if(!e.toString().contains("Invalid offset (14) passed: not enough room in byte array (need 16 bytes)")) {
            return -1
        }
        return 0
    }
    return -2
}

