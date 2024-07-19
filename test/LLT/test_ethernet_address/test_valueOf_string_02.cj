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
        testString() != 0
    ) {
        return -1
    }
    return 0
}

// test some failure cases for the string constructor
func testString(): Int32 {
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_1)
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_2)
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_3)
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_4)
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_5)
    badStringValueOfHelper(
        IMPROPER_NUM_COLONS_ETHERNET_ADDRESS_STRING_6)
    badStringValueOfHelper(
        NON_HEX_ETHERNET_ADDRESS_STRING)
    badStringValueOfHelper(
        RANDOM_PROPER_LENGTH_STRING)
    return 0
}

func badStringValueOfHelper(EthernetAddressString: String): Int32 {
    try {
        EthernetAddress.valueOf(EthernetAddressString)
    }catch(e: NumberFormatException) {
        println(e.toString())
    }
    return 0
}