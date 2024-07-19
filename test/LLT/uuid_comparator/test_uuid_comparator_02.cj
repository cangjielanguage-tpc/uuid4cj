// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    var u1: UUID = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    var u2: UUID = UUID.fromString("401110a8-d62c-4504-8b11-d73ec0b1631b")
    var diff: Int32 = UUIDComparator.compare(u1, u2)
    if(diff > 0) {
        return -1
    }
    return 0
}

