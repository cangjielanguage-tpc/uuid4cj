//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from uuid4cj import uuid4cj.*
from std import random.*
from fuzz import fuzz.*

var returnFlag: Int32 = 0
public func test_fuzz_uuid_EthernetAddress_valueOf3(dp: DataProvider): Int32 {
    EthernetAddress.valueOf(dp.consumeInt64())
    return returnFlag
}

main(){
    Fuzzer(test_fuzz_uuid_EthernetAddress_valueOf3).startFuzz()
    return 0
}