//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from uuid4cj import uuid4cj.*
from std import random.*
from fuzz import fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_uuid(dp: DataProvider): Int32 {
    UUIDUtil.uuid(dp.consumeInt8s(16))
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_uuid).startFuzz()
    return 0
}