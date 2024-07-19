// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {   
    try {
        EthernetAddress.valueOf("")
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Incomplete ethernet address")) {
            return -1
        }
        return 0
    }
    return -2
}
