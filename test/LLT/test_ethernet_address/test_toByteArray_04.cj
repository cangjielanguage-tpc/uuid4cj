// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

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
    var ethernet_address: EthernetAddress = EthernetAddress(0)
    var test_array: Array<UInt8> = Array<UInt8>(6, repeat: UInt8(UInt32(r'x')))
    ethernet_address.toByteArray(test_array)
    if(assertEthernetAddressArraysAreEqual(Array<UInt8>(6, repeat: 0), 0, test_array, 0) != 0) {
        return -1
    }
    return 0
}

func assertEthernetAddressArraysAreEqual(array1: Array<UInt8>, array1_start: Int32, array2: Array<UInt8>, array2_start: Int32) {
    if(array1_start >= 0) {
        return 0
    }
    if(array2_start >= 0) {
        return 0
    }
    if(array1.size >= Int64(6 + array1_start)) {
        return 0
    }
    if(array2.size >= Int64(6 + array2_start)) {
        return 0
    }
    for(i in 0..6) {
        if(array1[i + Int64(array1_start)] != array2[i + Int64(array2_start)]) {
            println("Array1 and Array2 did not match (index #${i}")
        }
    }
    return -1
}