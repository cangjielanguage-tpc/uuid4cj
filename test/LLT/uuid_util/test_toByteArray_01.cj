// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

let UUID_BYTE_ARRAY_LENGTH: Int64 = 16
let EXTRA_DATA_LENGTH: Int64 = 9
let MIXED_CASE_VALID_UUID_STRING: String = "4d687664-3A1e-4F30-aCc1-87F59306d30C"
let NULL_UUID_BYTE_ARRAY: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
let VALID_UUID_BYTE_ARRAY: Array<UInt8> = [
        0x4d, 0x68, 0x76, 0x64,
        0x3a, 0x1e, 0x4f, 0x30,
        0xac, 0xc1, 0x87, 0xf5,
        0x93, 0x06, 0xd3, 0x0c
    ]

main() {  
    if(testToByteArrayNull() != 0 ||
       testToByteArraySmall() != 0 ||
       testToByteArrayNullUuid() != 0 ||      
       testToByteArrayNonNullUuid() != 0 || 
       testToByteArrayNullUuidExtra() != 0 ||
       testToByteArrayNonNullUuidExtra() != 0
       ) {
        return -1
    }

    return 0
}

// passing null
func testToByteArrayNull(): Int32 {
    try {
        let uuid1 = UUIDUtil.nilUUID()
        UUIDUtil.toByteArray(uuid1, Array<Int8>())
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid bytes passed: can not be null")) {
            return -1
        }
        return 0
    }
    return -2
}

// now an array that is too small
func testToByteArraySmall(): Int32 {
    try {
        let uuid2 = UUIDUtil.nilUUID()
        let arr: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH - 1, item: 0)
        UUIDUtil.toByteArray(uuid2, arr)
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid offset (0) passed: not enough room in byte array (need 16 bytes)")) {
            return -3
        }
        return 0
    }
    return -4
}

//we'll test the null uuid
func testToByteArrayNullUuid(): Int32 {
    let test_uuid = UUIDUtil.nilUUID()
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
    UUIDUtil.toByteArray(test_uuid, test_array)
    if(test_array != NULL_UUID_BYTE_ARRAY) {
        return -1
    }
    return 0
}
// test a non-null uuid
func testToByteArrayNonNullUuid(): Int32 {
    let test_uuid = UUIDUtil.uuid(MIXED_CASE_VALID_UUID_STRING)
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
    UUIDUtil.toByteArray(test_uuid, test_array)
    if(test_array != UInt8ToInt8(VALID_UUID_BYTE_ARRAY)) {
        return -1
    }
    return 0
}

// test a null uuid case with extra data in the array
func testToByteArrayNullUuidExtra(): Int32 {
    let test_uuid = UUIDUtil.nilUUID()
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32('x')))
    UUIDUtil.toByteArray(test_uuid, test_array)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(NULL_UUID_BYTE_ARRAY[k] != test_array[k]) {
            return -1
        }
    }
    for(k in 0..EXTRA_DATA_LENGTH) {
        if(Int8(UInt32('x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH]) {
            return -1
        }
    }

    return 0
}

// test a good uuid case with extra data in the array
@OverflowWrapping
func testToByteArrayNonNullUuidExtra(): Int32 {
    let test_uuid = UUIDUtil.uuid(MIXED_CASE_VALID_UUID_STRING)
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32('x')))
    UUIDUtil.toByteArray(test_uuid, test_array)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(Int8(VALID_UUID_BYTE_ARRAY[k]) != test_array[k]) {
            return -1
        }
    }
    for(k in 0..EXTRA_DATA_LENGTH) {
        if(Int8(UInt32('x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH]) {
            return -1
        }
    }

    return 0
}

@OverflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}

