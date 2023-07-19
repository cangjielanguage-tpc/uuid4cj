// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID.randomUUID()
    if(uuid.version() != 4) {
        return -1
    }
    return 0
}

