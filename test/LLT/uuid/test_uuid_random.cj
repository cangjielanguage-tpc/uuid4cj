// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let uuid = UUID.randomUUID()
    if(uuid.version() != 4) {
        return -1
    }
    return 0
}

