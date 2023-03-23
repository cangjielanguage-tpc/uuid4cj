// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    let uuid = UUID.nilUUID()
    if(uuid.toString() != "00000000-0000-0000-0000-000000000000") {
        return -1
    }

    return 0
}

