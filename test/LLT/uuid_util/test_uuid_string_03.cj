// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

let NULL_UUID_STRING: String = "00000000-0000-0000-0000-000000000000"
let UPPER_CASE_VALID_UUID_STRING: String = "4D687664-3A1E-4F30-ACC1-87F59306D30C"
let LOWER_CASE_VALID_UUID_STRING: String = "4d687664-3a1e-4f30-acc1-87f59306d30c"
let MIXED_CASE_VALID_UUID_STRING: String = "4d687664-3A1e-4F30-aCc1-87F59306d30C"

main() {   
    goodStringUUIDConstructorHelper(NULL_UUID_STRING)
    goodStringUUIDConstructorHelper(UPPER_CASE_VALID_UUID_STRING)
    goodStringUUIDConstructorHelper(LOWER_CASE_VALID_UUID_STRING)
    goodStringUUIDConstructorHelper(MIXED_CASE_VALID_UUID_STRING)
    return 0
}

func goodStringUUIDConstructorHelper(uuidString: String): Int32 {
    let temp_uuid = UUIDUtil.uuid(uuidString)
    if(temp_uuid.toString().toAsciiLower() != uuidString.toAsciiLower()) {
        return -1
    }
    return 0
}