// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var uuid = UUIDUtil.initUUIDFirstLong(-768862386091519507, UUIDType.TIME_BASED)
    var uuid2 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.DCE)
    var uuid3 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.NAME_BASED_MD5)
    var uuid4 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.RANDOM_BASED)
    var uuid5 = UUIDUtil.initUUIDFirstLong( -768862386091519507,UUIDType.NAME_BASED_SHA1)
    var uuid6 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.TIME_BASED_REORDERED)
    var uuid7 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.TIME_BASED_EPOCH)
    var uuid8 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.FREE_FORM)
    var uuid9 = UUIDUtil.initUUIDFirstLong(-768862386091519507,UUIDType.UNKNOWN)

    if(uuid != -768862386091519507) {
        return -1
    }
    if(uuid2 != -768862386091515411) {
        return -2
    }
    if(uuid3 != -768862386091511315) {
        return -3
    }
    if(uuid4 != -768862386091507219) {
        return -4
    }
    if(uuid5 != -768862386091503123) {
        return -5
    }
    if(uuid6 != -768862386091499027) {
        return -6
    }
    if(uuid7 != -768862386091494931) {
        return -7
    }
    if(uuid8 != -768862386091490835) {
        return -8
    }
    if(uuid9 != -768862386091523603) {
        return -9
    }
    return 0
}

