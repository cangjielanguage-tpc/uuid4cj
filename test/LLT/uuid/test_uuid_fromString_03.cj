// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    try {
        UUID.fromString("b053e9b3-c1f2-gggb-9299-df2c236b23c1")
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Invalid UUID string: b053e9b3-c1f2-gggb-9299-df2c236b23c1")) {
            return -1
        }
        return 0
    }
    return -2
}

