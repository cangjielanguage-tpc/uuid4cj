// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    if(
        testInt64EthernetAddressConstructor1() != 0 ||
        testInt64EthernetAddressConstructor2() != 0
    ) {
        return -1
    }
    return 0
}

// let's test that creating a EthernetAddress from an zero long
// gives us a null EthernetAddress (definition of null EthernetAddress)
func testInt64EthernetAddressConstructor1(): Int32 {
    if(EthernetAddress(0).toLong() != 0) {
        return -1
    }
    return 0
}

// let's test creating an array from a good long
func testInt64EthernetAddressConstructor2(): Int32 {
    if(EthernetAddress(0x000087f59306d30c).toLong() != Int64(0x000087f59306d30c)) {
        return -1
    }
    return 0
}