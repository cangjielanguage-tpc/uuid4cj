// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

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
    if(
        testToByteArraySmall() != 0 ||
        testToByteArrayNegativeIndex() != 0 ||
        testToByteArrayBigIndex() != 0 ||
        testToByteArrayArrayIndex() != 0 ||
        testToByteArrayNullUuid() != 0 ||
        testToByteArrayNonNullUuid() != 0 ||
        testToByteArrayNullUuidExtra() != 0 ||
        testToByteArrayNullUuidExtra2() != 0 ||
        testToByteArrayNonNullUuidExtra() != 0 ||
        testToByteArrayNonNullUuidExtra2() != 0
       ) {
        return -1
    }

    return 0
}

// now an array that is too small
func testToByteArraySmall(): Int32 {
    try {
        let test_uuid = UUIDUtil.nilUUID()
        let uuid_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH - 1, item: 0)
        UUIDUtil.toByteArray(test_uuid, uuid_array, 0)
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid offset (0) passed: not enough room in byte array (need 16 bytes)")) {
            return -3
        }
        return 0
    }
    return -4
}

// now an array that is too small
func testToByteArrayNegativeIndex(): Int32 {
    try {
        let test_uuid = UUIDUtil.nilUUID()
        let uuid_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
        UUIDUtil.toByteArray(test_uuid, uuid_array, -1)
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid offset (-1) passed: can not be negative")) {
            return -3
        }
        return 0
    }
    return -4
}

// now an index that is too big
func testToByteArrayBigIndex(): Int32 {
    try {
        let test_uuid = UUIDUtil.nilUUID()
        let uuid_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
        UUIDUtil.toByteArray(test_uuid, uuid_array, Int32(UUID_BYTE_ARRAY_LENGTH))
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid offset (16) passed: not enough room in byte array (need 16 bytes)")) {
            return -3
        }
        return 0
    }
    return -4
}

// now an index that is in the array,
// but without enough bytes to read UUID_BYTE_ARRAY_LENGTH
func testToByteArrayArrayIndex(): Int32 {
    try {
        let test_uuid = UUIDUtil.nilUUID()
        let uuid_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
        UUIDUtil.toByteArray(test_uuid, uuid_array, 1)
    }catch(e: IllegalArgumentException) {
        if(!e.toString().contains("Exception: Invalid offset (1) passed: not enough room in byte array (need 16 bytes)")) {
            return -3
        }
        return 0
    }
    return -4
}

// we'll test making a couple UUIDs and then check that the toByteArray
// gives back the same value in byte form that we used to create it

// here we'll test the null uuid at offset 0
func testToByteArrayNullUuid(): Int32 {
    let test_uuid = UUIDUtil.nilUUID()
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH, item: 0)
    UUIDUtil.toByteArray(test_uuid, test_array, 0)
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
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32(r'x')))
    UUIDUtil.toByteArray(test_uuid, test_array,0)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(NULL_UUID_BYTE_ARRAY[k] != test_array[k]) {
            return -1
        }
    }
    for(k in 0..EXTRA_DATA_LENGTH) {
        if(Int8(UInt32(r'x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH]) {
            return -1
        }
    }

    return 0
}

// now test a null uuid case with extra data in the array
func testToByteArrayNullUuidExtra2(): Int32 {
    let test_uuid = UUIDUtil.nilUUID()
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32(r'x')))
    UUIDUtil.toByteArray(test_uuid, test_array, Int32(EXTRA_DATA_LENGTH/2))
    
    // first check the data (in the middle of the array)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(NULL_UUID_BYTE_ARRAY[k] != test_array[k + EXTRA_DATA_LENGTH/2]) {
            return -1
        }
    }
    // and now check that the surrounding bytes were not changed
    for(k in 0..EXTRA_DATA_LENGTH/2) {
        if(Int8(UInt32(r'x')) != test_array[k]) {
            return -2
        }
        if(Int8(UInt32(r'x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH/2]) {
            return -3
        }
    }

    return 0
}

// test a good uuid case with extra data in the array
@OverflowWrapping
func testToByteArrayNonNullUuidExtra(): Int32 {
    let test_uuid = UUIDUtil.uuid(MIXED_CASE_VALID_UUID_STRING)
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32(r'x')))
    UUIDUtil.toByteArray(test_uuid, test_array, 0)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(Int8(VALID_UUID_BYTE_ARRAY[k]) != test_array[k]) {
            return -1
        }
    }
    for(k in 0..EXTRA_DATA_LENGTH) {
        if(Int8(UInt32(r'x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH]) {
            return -1
        }
    }

    return 0
}

// now test a good uuid case with extra data in the array
// to make sure we aren't blowing the bounds of the buffer
@OverflowWrapping
func testToByteArrayNonNullUuidExtra2(): Int32 {
    let test_uuid = UUIDUtil.uuid(MIXED_CASE_VALID_UUID_STRING)
    let test_array: Array<Int8> = Array<Int8>(UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH, item: Int8(UInt32(r'x')))
    UUIDUtil.toByteArray(test_uuid, test_array, Int32(EXTRA_DATA_LENGTH/2))
    // first check the data (in the middle of the array)
    for(k in 0..UUID_BYTE_ARRAY_LENGTH) {
        if(Int8(VALID_UUID_BYTE_ARRAY[k]) != test_array[k + EXTRA_DATA_LENGTH/2]) {
            return -1
        }
    }
    // and now check that the surrounding bytes were not changed
    for(k in 0..EXTRA_DATA_LENGTH/2) {
        if(Int8(UInt32(r'x')) != test_array[k]) {
            return -1
        }
        if(Int8(UInt32(r'x')) != test_array[k + UUID_BYTE_ARRAY_LENGTH + EXTRA_DATA_LENGTH/2]) {
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

