//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from uuid4cj import uuid4cj.*
from std import random.*
from fuzz import fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_initUUIDFirstLong(dp: DataProvider): Int32 {
    UUIDUtil.initUUIDFirstLong(dp.consumeInt64(),UUIDType.TIME_BASED)
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_initUUIDFirstLong).startFuzz()
    return 0
}