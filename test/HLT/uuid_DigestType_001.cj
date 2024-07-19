//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*

@Test
public class uuid_DigestType_001{
    @TestCase
    public func uuid_DigestType_001():Unit{
        println("DigestType.MD5: ${DigestType.MD5.toString()}")
        println("DigestType.SHA1: ${DigestType.SHA1.toString()}")
        @Assert(DigestType.MD5.toString(),"MD5")
        @Assert(DigestType.SHA1.toString(),"SHA1")
    }
}