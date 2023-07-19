// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    if(uuid.getLeastSignificantBits() != -6742583835698893911) {
        return -1
    }
    return 0
}

