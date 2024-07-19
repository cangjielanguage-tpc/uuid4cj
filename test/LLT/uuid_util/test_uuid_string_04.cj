// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    try {
        UUIDUtil.uuid("f55473bb-c3db-11ed-a26d")
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("UUID has to be represented by the standard 36-char representation")) {
            return -1
        }
        return 0
    }
    return -2
}

