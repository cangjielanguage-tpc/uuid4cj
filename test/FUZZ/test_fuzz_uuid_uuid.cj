//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import uuid4cj.uuid4cj.*
import std.random.*
import fuzz.fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_uuid(dp: DataProvider): Int32 {
    UUIDUtil.uuid(dp.consumeInt8s(16))
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_uuid).startFuzz()
    return 0
}