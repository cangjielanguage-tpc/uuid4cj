// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    let uuid = UUID.fromString("b053e9b3-c1f2-444b-9299-df2c236b23c1")
    try {
        uuid.timestamp()
    }catch(e: UnsupportedOperationException) {
        if(!e.toString().contains("Not a time-based UUID")) {
            return -2
        }
        try {
            uuid.clockSequence()
        }catch(e: UnsupportedOperationException) {
            if(!e.toString().contains("Not a time-based UUID")) {
                return -3
            }
            try {
                uuid.node()
            }catch(e: UnsupportedOperationException) {
                if(!e.toString().contains("Not a time-based UUID")) {
                    return -4
                }
                return 0
            }
        }   
    }
    return -10
}

