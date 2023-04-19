// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

let EXTRA_DATA_LENGTH: Int32 = 9
main() {    
    if(
        testToByteArray1() != 0
    ) {
        return -1
    }
    return 0
}

func testToByteArray1(): Int32 {
    try {
        EthernetAddress(0).toByteArray([])
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Too small array")) {
            return -1
        }
        return 0
    }
    return -2
}
