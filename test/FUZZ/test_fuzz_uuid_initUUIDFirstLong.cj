//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import uuid4cj.uuid4cj.*
import std.random.*
import fuzz.fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_initUUIDFirstLong(dp: DataProvider): Int32 {
    UUIDUtil.initUUIDFirstLong(dp.consumeInt64(),UUIDType.TIME_BASED)
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_initUUIDFirstLong).startFuzz()
    return 0
}