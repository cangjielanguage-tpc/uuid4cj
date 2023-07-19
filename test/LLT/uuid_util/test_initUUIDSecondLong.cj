// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
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

