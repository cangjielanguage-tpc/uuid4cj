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
    if(
       testToByteArrayNullUuid() != 0 ||      
       testToByteArrayNonNullUuid() != 0
       ) {
        return -1
    }

    return 0
}


//we'll test the null uuid
func testToByteArrayNullUuid(): Int32 {
    let test_uuid = UUIDUtil.nilUUID()
    UUIDUtil.asByteArray(test_uuid)
    if(UUIDUtil.asByteArray(test_uuid).size != UUID_BYTE_ARRAY_LENGTH ||
    UUIDUtil.asByteArray(test_uuid) != NULL_UUID_BYTE_ARRAY) {
        return -1
    }
    return 0
}
// test a non-null uuid
func testToByteArrayNonNullUuid(): Int32 {
    let test_uuid = UUIDUtil.uuid(MIXED_CASE_VALID_UUID_STRING)
    if(UUIDUtil.asByteArray(test_uuid).size != UUID_BYTE_ARRAY_LENGTH ||
    UUIDUtil.asByteArray(test_uuid) != UInt8ToInt8(VALID_UUID_BYTE_ARRAY)) {
        return -1
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

