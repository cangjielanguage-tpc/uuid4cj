// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid = UUIDUtil.constructUUID(UUIDType.TIME_BASED, s).toString()
    var uuid2 = UUIDUtil.constructUUID(UUIDType.DCE, s).toString()
    var uuid3 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5, s).toString()
    var uuid4 = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, s).toString()
    var uuid5 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1, s).toString()
    var uuid6 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED, s).toString()
    var uuid7 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, s).toString()
    var uuid8 = UUIDUtil.constructUUID(UUIDType.FREE_FORM, s).toString()
    var uuid9 = UUIDUtil.constructUUID(UUIDType.UNKNOWN, s).toString()

    if(uuid != "68656c6c-6f77-1f72-ac64-736466736773") {
        return -1
    }
    if(uuid2 != "68656c6c-6f77-2f72-ac64-736466736773") {
        return -2
    }
    if(uuid3 != "68656c6c-6f77-3f72-ac64-736466736773") {
        return -3
    }
    if(uuid4 != "68656c6c-6f77-4f72-ac64-736466736773") {
        return -4
    }
    if(uuid5 != "68656c6c-6f77-5f72-ac64-736466736773") {
        return -5
    }
    if(uuid6 != "68656c6c-6f77-6f72-ac64-736466736773") {
        return -6
    }
    if(uuid7 != "68656c6c-6f77-7f72-ac64-736466736773") {
        return -7
    }
    if(uuid8 != "68656c6c-6f77-8f72-ac64-736466736773") {
        return -8
    }
    if(uuid9 != "68656c6c-6f77-0f72-ac64-736466736773") {
        return -9
    }
    return 0
}

