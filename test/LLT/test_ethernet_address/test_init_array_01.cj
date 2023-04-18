// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    if(
        testByteArrayEthernetAddressConstructor1() != 0 ||
        testByteArrayEthernetAddressConstructor2() != 0 ||
        testByteArrayEthernetAddressConstructor3() != 0 ||
        testByteArrayEthernetAddressConstructor4() != 0 ||
        testByteArrayEthernetAddressConstructor5() != 0 
    ) {
        return -1
    }
    return 0
}

// pass null
func testByteArrayEthernetAddressConstructor1(): Int32 {
    var arr: Array<UInt8> = []
    try {
        EthernetAddress(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}

// now an array thsat is too small
func testByteArrayEthernetAddressConstructor2(): Int32 {
    var arr: Array<UInt8> = Array<UInt8>(5, item: 0)
    try {
        EthernetAddress(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}

// now an array thsat is too big
func testByteArrayEthernetAddressConstructor3(): Int32 {
    var arr: Array<UInt8> = Array<UInt8>(7, item: 0)
    try {
        EthernetAddress(arr)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Ethernet address has to consist of 6 bytes")) {
            return -1
        }
        return 0
    }
    return -2
}

// let's test that creating a EthernetAddress from an zero'd array
// gives us a null EthernetAddress (definition of null EthernetAddress)
func testByteArrayEthernetAddressConstructor4(): Int32 {
    var arr: Array<UInt8> = Array<UInt8>(6, item: 0)
    if(EthernetAddress(arr).toLong() != 0) {
        return -1
    }
    return 0
}

// let's test creating an array from a good byte array
func testByteArrayEthernetAddressConstructor5(): Int32 {
    var arr: Array<UInt8> = [0x87, 0xf5, 0x93, 0x06, 0xd3, 0x0c]
    if(EthernetAddress(arr).toLong() != Int64(0x000087f59306d30c)) {
        return -1
    }
    return 0
}
