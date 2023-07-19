// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    try {
        UUID.fromString("b053e9b3-c1f2-444b-9299")
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Invalid UUID string: b053e9b3-c1f2-444b-9299")) {
            return -1
        }
        return 0
    }
    return -2
}

