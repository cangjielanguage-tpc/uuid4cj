// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    let uuid = UUID.randomUUID()
    if(uuid.version() != 4) {
        return -1
    }
    return 0
}

