// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*


main() {    
    if(
        testToByteArray1() != 0 ||
        testToByteArray2() != 0
    ) {
        return -1
    }
    return 0
}
// first we'll test the null EthernetAddress
func testToByteArray1(): Int32 {
    var ethernet_address: EthernetAddress = EthernetAddress(0)
    if(ethernet_address.toByteArray().size != 6) {
        return -1
    }
    assertEthernetAddressArraysAreEqual(Array<UInt8>(6, item: 0), 0, ethernet_address.toByteArray(), 0)
    return 0
 }

// now test a non-null EthernetAddress
func testToByteArray2(): Int32 {
    var ethernet_address: EthernetAddress = EthernetAddress(0)
    if(ethernet_address.toByteArray().size != 6) {
        return -1
    }
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]
    assertEthernetAddressArraysAreEqual(arr, 0, ethernet_address.toByteArray(), 0)
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