// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 31, 114, -84, 100, 115, 100, 102, 115, 103, 115]
    var uuid = UUIDUtil.constructUUID(UUIDType.TIME_BASED, s)
    var uuid2 = UUIDUtil.constructUUID(UUIDType.DCE, s)
    var uuid3 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5, s)
    var uuid4 = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, s)
    var uuid5 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1, s)
    var uuid6 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED, s)
    var uuid7 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, s)
    var uuid8 = UUIDUtil.constructUUID(UUIDType.FREE_FORM, s)
    var uuid9 = UUIDUtil.constructUUID(UUIDType.UNKNOWN, s)
    var uuid10 = UUID.nilUUID()

    if(
        UUIDUtil.typeOf(uuid).getOrThrow().raw() != 1 ||
        UUIDUtil.typeOf(uuid2).getOrThrow().raw() != 2 ||
        UUIDUtil.typeOf(uuid3).getOrThrow().raw() != 3 ||
        UUIDUtil.typeOf(uuid4).getOrThrow().raw() != 4 ||
        UUIDUtil.typeOf(uuid5).getOrThrow().raw() != 5 ||
        UUIDUtil.typeOf(uuid6).getOrThrow().raw() != 6 ||
        UUIDUtil.typeOf(uuid7).getOrThrow().raw() != 7 ||
        UUIDUtil.typeOf(uuid8).getOrThrow().raw() != 8 ||
        UUIDUtil.typeOf(uuid10).getOrThrow().raw() != 0
    ) {
        return -2
    }
    try {
        UUIDUtil.typeOf(uuid9).getOrThrow().raw()
    }catch(e: Exception) {
        if(!e.toString().contains("NoneValueException")) {
            return -1
        }
    }
    return 0
}
