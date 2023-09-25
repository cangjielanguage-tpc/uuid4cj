// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    let uuid2 = UUID.fromString("f55473bb-c3df-11Fd-a26d-87b9a4e06ba9")
    let uuid3 = UUID.fromString("f55473bb-c3db-11ed-a26d-77b9a4e06ba9")
    let uuid4 = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    
    if(uuid.compareTo(uuid2) != -1 || uuid.compareTo(uuid3) != 1 || uuid.compareTo(uuid4) != 0) {
        return -1
    }
    
    return 0
}

