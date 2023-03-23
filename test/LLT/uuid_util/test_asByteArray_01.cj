// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid = UUIDUtil.constructUUID(UUIDType.TIME_BASED, s)
    var uuid2 = UUIDUtil.constructUUID(UUIDType.DCE, s)
    var uuid3 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5, s)
    var uuid4 = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, s)
    var uuid5 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1, s)
    var uuid6 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED, s)
    var uuid7 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, s)
    var uuid8 = UUIDUtil.constructUUID(UUIDType.FREE_FORM, s)
    var uuid9 = UUIDUtil.constructUUID(UUIDType.UNKNOWN, s)

    if(UUIDUtil.asByteArray(uuid).toString() != "[104, 101, 108, 108, 111, 119, 31, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid2).toString() != "[104, 101, 108, 108, 111, 119, 47, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid3).toString() != "[104, 101, 108, 108, 111, 119, 63, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid4).toString() != "[104, 101, 108, 108, 111, 119, 79, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid5).toString() != "[104, 101, 108, 108, 111, 119, 95, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid6).toString() != "[104, 101, 108, 108, 111, 119, 111, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid7).toString() != "[104, 101, 108, 108, 111, 119, 127, 114, -84, 100, 115, 100, 102, 115, 103, 115]" ||
        UUIDUtil.asByteArray(uuid8).toString() != "[104, 101, 108, 108, 111, 119, -113, 114, -84, 100, 115, 100, 102, 115, 103, 115]" 
    ) {
        return -1
    }
    return 0
}
