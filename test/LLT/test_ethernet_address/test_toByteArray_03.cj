// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

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
    var arr: Array<UInt8> =  Array<UInt8>(5, item: 0)
    try {
        EthernetAddress(0).toByteArray(arr)
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Too small array")) {
            return -1
        }
        return 0
    }
    return -2
}