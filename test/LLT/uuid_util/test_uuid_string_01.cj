// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var uuidNil = UUIDUtil.nilUUID().toString()
    var uuidMax = UUIDUtil.maxUUID().toString()

    if(uuidNil != "00000000-0000-0000-0000-000000000000") {
        return -2
    }
    if(uuidMax != "ffffffff-ffff-ffff-ffff-ffffffffffff") {
        return -3
    }
    var uuid1 = UUIDUtil.uuid("f55473bb-c3db-11ed-a26d-87b9a4e06ba9").toString()
    if(uuid1 != "f55473bb-c3db-11ed-a26d-87b9a4e06ba9") {
        return -4
    }
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid2 = UUIDUtil.uuid(s).toString()
    if(uuid2 != "68656c6c-6f77-6f72-6c64-736466736773") {
        return -5
    }
    return 0
}

