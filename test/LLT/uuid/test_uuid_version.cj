// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    if(uuid.version()!= 1) {
        return -1
    }
    return 0
}

