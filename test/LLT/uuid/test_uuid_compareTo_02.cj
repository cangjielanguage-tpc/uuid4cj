// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID(6742583835698893911, 768862386091519507)
    let uuid2 = UUID(-6742583835698893911, -768862386091519507)
    let uuid3 = UUID(6742583835698893911, 868862386091519507)
    let uuid4 = UUID(5742583835698893911, 668862386091519507)
    if(
        uuid.compareTo(uuid2) != 1 || 
        uuid.compareTo(uuid3) != -1 ||
        uuid.compareTo(uuid4) != 1
    ) {
        return -1
    }

    return 0
}

