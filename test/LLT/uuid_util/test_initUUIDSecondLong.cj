// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var s: Array<UInt8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid = UUIDUtil.initUUIDSecondLong(-768862386091519507)
    var uuid2 = UUIDUtil.initUUIDSecondLong(-6742583835698893911)

    if(uuid != -5380548404518907411) {
        return -1
    }
    if(uuid2 != -6742583835698893911) {
        return -2
    }
    
    return 0
}

