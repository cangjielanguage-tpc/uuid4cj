// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    try {
        UUIDUtil.uuid("f55473bb-c3db-11ed-a26d-87b9a4e06ba.")
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Non-hex character at #35: '.' (value 2e)")) {
            return -1
        }
        return 0
    }
    return 0
}

