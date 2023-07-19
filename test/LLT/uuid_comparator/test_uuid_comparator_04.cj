// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var u1: UUID = UUID.fromString("9530f1fd-d8e0-11ed-af98-c112d7b09be1")
    var u2: UUID = UUID.fromString("9530f1fd-d8e0-11ed-af98-c112d7b09be1")
    var diff: Int32 = UUIDComparator.compare(u1, u2)
    if(diff != 0) {
        return -1
    }
    return 0
}

