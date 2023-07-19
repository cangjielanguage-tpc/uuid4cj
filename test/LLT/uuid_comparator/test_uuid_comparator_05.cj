// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var u1: UUID = UUID.fromString("0187737d-e5d4-7b8d-8152-b7240c8a1b2e")
    var u2: UUID = UUID.fromString("0187737d-e5d4-7b8d-8152-b7240c8a1b2e")
    var diff: Int32 = UUIDComparator.compare(u1, u2)
    if(diff != 0) {
        return -1
    }
    return 0
}

