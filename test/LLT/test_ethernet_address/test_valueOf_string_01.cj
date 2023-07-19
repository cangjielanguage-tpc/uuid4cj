// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*


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
