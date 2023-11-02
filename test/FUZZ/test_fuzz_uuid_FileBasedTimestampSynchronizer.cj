//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from uuid4cj import uuid4cj.*
from std import random.*
from fuzz import fuzz.*
from std import fs.*

var returnFlag: Int32 = 0
var file1 = File("uuid_TimeBasedGenerator_002.txt", OpenOption.CreateOrTruncate(true))
var file2 = File("uuid_TimeBasedGenerator_002_2.txt", OpenOption.CreateOrTruncate(true))
public func test_fuzz_uuid_FileBasedTimestampSynchronizer(dp: DataProvider): Int32 {
    FileBasedTimestampSynchronizer(file1,file2,dp.consumeInt64())
    return returnFlag
}

main(){

    Fuzzer(test_fuzz_uuid_FileBasedTimestampSynchronizer).startFuzz()
    return 0
}