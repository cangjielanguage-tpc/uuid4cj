// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

let IMPROPER_NUM_DASHES_UUID_STRING_1: String = "01234567089AB-CDEF-0123-456789ABCDEF"
let IMPROPER_NUM_DASHES_UUID_STRING_2: String = "01234567-89AB0CDEF-0123-456789ABCDEF"
let IMPROPER_NUM_DASHES_UUID_STRING_3: String = "01234567-89AB-CDEF00123-456789ABCDEF"
let IMPROPER_NUM_DASHES_UUID_STRING_4: String = "01234567-89AB-CDEF-01230456789ABCDEF"
let IMPROPER_NUM_DASHES_UUID_STRING_5: String = "01234567089AB0CDEF001230456789ABCDEF"
let IMPROPER_NUM_DASHES_UUID_STRING_6: String = "0123-4567-89AB-CDEF-0123-456789ABCDE"
let NON_HEX_UUID_STRING: String = "01THISIS-ANON-HEX0-UUID-FORSURE01234"
let RANDOM_PROPER_LENGTH_STRING: String = "String Of The Same Length as a UUID!"

main() {  
     
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_1)
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_2)
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_3)
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_4)
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_5)
    badStringUUIDConstructorHelper(IMPROPER_NUM_DASHES_UUID_STRING_6)
    badStringUUIDConstructorHelper(NON_HEX_UUID_STRING)
    badStringUUIDConstructorHelper(RANDOM_PROPER_LENGTH_STRING)
    return 0
}

func badStringUUIDConstructorHelper(s: String): Int32 {
    try {
        UUIDUtil.uuid(s)
    }catch(e: NumberFormatException) {
        if(!e.toString().contains("UUID has to be represented by the standard 36-char representation")) {
            return -1
        }
        return 0
    }
    return -2
}