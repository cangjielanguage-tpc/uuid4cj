// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_1: String =
    "01f23:45:67:89:ab"
let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_2: String =
    "01:23f45:67:89:ab"
let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_3: String =
    "01:23:45f67:89:ab"
let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_4: String =
    "01:23:45:67f89:ab"
let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_5: String =
    "01:23:45:67:89fab"
let IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_6: String =
    "01f23f45f67f89fab"
let NON_HEX_ETHERNET_ADDRESS_STRING: String =
    "NON-HEX0-FORSURE0"
let RANDOM_PROPER_LENGTH_STRING: String =
    "Same LengthString"

main() {    
    if(
        testStringEthernetAddressConstructor1() != 0 ||
        testStringEthernetAddressConstructor2() != 0
    ) {
        return -1
    }
    return 0
}

// test a null string case
func testStringEthernetAddressConstructor1(): Int32 {
    try {
        EthernetAddress("")
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("Incomplete ethernet address")) {
            return -1
        }
        return 0
    }
    return -2
}

// test some failure cases for the string constructor
func testStringEthernetAddressConstructor2(): Int32 {
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_1)
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_2)
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_3)
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_4)
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_5)
    badStringEthernetAddressConstructorHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_6)
    badStringEthernetAddressConstructorHelper(
        NON_HEX_ETHERNET_ADDRESS_STRING)
    badStringEthernetAddressConstructorHelper(
        RANDOM_PROPER_LENGTH_STRING)
    return 0
}

func badStringEthernetAddressConstructorHelper(EthernetAddressString: String): Int32 {
    try {
        EthernetAddress(EthernetAddressString)
    }catch(e: NumberFormatException) {
        println(e.toString())
    }
    return 0
}