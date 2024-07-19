//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import uuid4cj.uuid4cj.*
import std.random.*
import fuzz.fuzz.*
import std.fs.*

var returnFlag: Int32 = 0
var file1 = File("uuid_TimeBasedGenerator_002.txt", OpenOption.CreateOrTruncate(true))
var file2 = File("uuid_TimeBasedGenerator_002_2.txt", OpenOption.CreateOrTruncate(true))
var fbts = FileBasedTimestampSynchronizer(file1,file2) 
public func test_fuzz_uuid_update(dp: DataProvider): Int32 {
    fbts.update(dp.consumeInt64())
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_update).startFuzz()
    return 0
}