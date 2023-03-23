// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: Array<UInt8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid = UUIDUtil.constructUUID(UUIDType.TIME_BASED, -768862386091519507, -6742583835698893911).toString()
    var uuid2 = UUIDUtil.constructUUID(UUIDType.DCE, -768862386091519507, -6742583835698893911).toString()
    var uuid3 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5, -768862386091519507, -6742583835698893911).toString()
    var uuid4 = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, -768862386091519507, -6742583835698893911).toString()
    var uuid5 = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1, -768862386091519507, -6742583835698893911).toString()
    var uuid6 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED, -768862386091519507, -6742583835698893911).toString()
    var uuid7 = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, -768862386091519507, -6742583835698893911).toString()
    var uuid8 = UUIDUtil.constructUUID(UUIDType.FREE_FORM, -768862386091519507, -6742583835698893911).toString()
    var uuid9 = UUIDUtil.constructUUID(UUIDType.UNKNOWN, -768862386091519507, -6742583835698893911).toString()

    if(uuid != "f55473bb-c3db-11ed-a26d-87b9a4e06ba9") {
        return -1
    }
    if(uuid2 != "f55473bb-c3db-21ed-a26d-87b9a4e06ba9") {
        return -2
    }
    if(uuid3 != "f55473bb-c3db-31ed-a26d-87b9a4e06ba9") {
        return -3
    }
    if(uuid4 != "f55473bb-c3db-41ed-a26d-87b9a4e06ba9") {
        return -4
    }
    if(uuid5 != "f55473bb-c3db-51ed-a26d-87b9a4e06ba9") {
        return -5
    }
    if(uuid6 != "f55473bb-c3db-61ed-a26d-87b9a4e06ba9") {
        return -6
    }
    if(uuid7 != "f55473bb-c3db-71ed-a26d-87b9a4e06ba9") {
        return -7
    }
    if(uuid8 != "f55473bb-c3db-81ed-a26d-87b9a4e06ba9") {
        return -8
    }
    if(uuid9 != "f55473bb-c3db-01ed-a26d-87b9a4e06ba9") {
        return -9
    }
    return 0
}

