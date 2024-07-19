//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import uuid4cj.uuid4cj.*
import std.random.*
import fuzz.fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_init(dp: DataProvider): Int32 {
    UUID(dp.consumeInt64(),dp.consumeInt64())
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_init).startFuzz()
    return 0
}