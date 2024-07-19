// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let uuid = UUID.fromString("b053e9b3-c1f2-444b-9299-df2c236b23c1")
    if(uuid.toString() != "b053e9b3-c1f2-444b-9299-df2c236b23c1") {
        return -1
    }
    return 0
}

