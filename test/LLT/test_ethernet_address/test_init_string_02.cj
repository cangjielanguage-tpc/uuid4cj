// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

// some valid strings for the various dropped digit cases
let FIRST_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "00:23:45:67:89:ab"
let FIRST_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "0:23:45:67:89:ab"
let FIRST_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    ":23:45:67:89:ab"
let SECOND_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:00:45:67:89:ab"
let SECOND_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:0:45:67:89:ab"
let SECOND_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "01::45:67:89:ab"
let THIRD_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:00:67:89:ab"
let THIRD_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:0:67:89:ab"
let THIRD_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23::67:89:ab"
let FOURTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:00:89:ab"
let FOURTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:0:89:ab"
let FOURTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45::89:ab"
let FIFTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67:00:ab"
let FIFTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67:0:ab"
let FIFTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67::ab"
let SIXTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67:89:00"
let SIXTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67:89:0"
let SIXTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:23:45:67:89:"
let MIXED_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING: String =
    "01:03:00:07:00:00"
let MIXED_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING: String =
    "1:3:0:7:0:0"
let MIXED_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING: String =
    "1:3::7::"

// here are some sets of good ethernet addresses in various forms
let NULL_ETHERNET_ADDRESS_STRING: String =
    "00:00:00:00:00:00"
let VALID_ETHERNET_ADDRESS_STRING: String =
    "87:f5:93:06:d3:0c"
let MIXED_CASE_VALID_ETHERNET_ADDRESS_STRING: String =
    "87:f5:93:06:D3:0c"
let UPPER_CASE_VALID_ETHERNET_ADDRESS_STRING: String =
    "87:F5:93:06:D3:0C"

main() {    
    if(
        testStringEthernetAddressConstructor1() != 0
    ) {
        return -1
    }
    return 0
}

// test some failure cases for the constructor
func testStringEthernetAddressConstructor1(): Int32 {
    goodStringEthernetAddressConstructorHelper(
        FIRST_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        FIRST_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FIRST_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        FIRST_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FIRST_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        FIRST_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SECOND_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        SECOND_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SECOND_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        SECOND_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SECOND_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        SECOND_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        THIRD_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        THIRD_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        THIRD_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        THIRD_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        THIRD_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        THIRD_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FOURTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        FOURTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FOURTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        FOURTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FOURTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        FOURTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FIFTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        FIFTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FIFTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        FIFTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        FIFTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        FIFTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SIXTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        SIXTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SIXTH_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        SIXTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        SIXTH_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        SIXTH_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        MIXED_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING,
        MIXED_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        MIXED_GROUP_ONE_NUM_ETHERNET_ADDRESS_STRING,
        MIXED_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        MIXED_GROUP_NO_NUM_ETHERNET_ADDRESS_STRING,
        MIXED_GROUP_ALL_NUM_ETHERNET_ADDRESS_STRING)
    
    // test the other good cases
    goodStringEthernetAddressConstructorHelper(
        NULL_ETHERNET_ADDRESS_STRING,
        NULL_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        UPPER_CASE_VALID_ETHERNET_ADDRESS_STRING,
        UPPER_CASE_VALID_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        VALID_ETHERNET_ADDRESS_STRING,
        VALID_ETHERNET_ADDRESS_STRING)
    goodStringEthernetAddressConstructorHelper(
        MIXED_CASE_VALID_ETHERNET_ADDRESS_STRING,
        MIXED_CASE_VALID_ETHERNET_ADDRESS_STRING)
    return 0
}

func goodStringEthernetAddressConstructorHelper(EthernetAddressString: String, expectedEthernetAddressString: String): Int32 {
    if(
        EthernetAddress(EthernetAddressString).toString().toLower() != expectedEthernetAddressString.toLower()
    ) {
        return -1
    }
    return 0
} 