// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108]
    try {
        UUIDUtil.uuid(s)
    } catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Invalid offset (0) passed: not enough room in byte array (need 16 bytes)")) {
            return -1
        }
        return 0
    }
    return -2
}

