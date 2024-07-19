// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid2 = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid3 = UUID.fromString("35a83239-c3dc-11ed-ba36-bd215a723aba")
    let uuid4 = UUID.fromString("ff5473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid5 = UUID.fromString("f55473bb-c3db-11ec-a26d-87b9a4e06ba9")
    let uuid6 = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06baf")
    if(uuid.compareTo(uuid2) != 0 || uuid.compareTo(uuid3) != 1) {
        return -1
    }

    if(uuid.compareTo(uuid4) != -1 || uuid.compareTo(uuid5) != 1 || uuid.compareTo(uuid6) != -1) {
        return -2
    }
    
    return 0
}

