// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid2 = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid3 = UUID.fromString("35a83239-c3dc-11ed-ba36-bd215a723aba")
    if(uuid.compareTo(uuid2) != 0 || uuid.compareTo(uuid3) != 1) {
        return -1
    }
    
    return 0
}

