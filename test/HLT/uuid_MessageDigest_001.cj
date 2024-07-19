//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*

@Test
public class uuid_MessageDigest_001{
    @TestCase
    public func uuid_MessageDigest_001():Unit{
        println("MessageDigest(DigestType.MD5).getAlgorithm().toString(): ${MessageDigest(DigestType.MD5).getAlgorithm().toString()}")
        println("MessageDigest(DigestType.SHA1).getAlgorithm().toString(): ${MessageDigest(DigestType.SHA1).getAlgorithm().toString()}")
        @Assert(MessageDigest(DigestType.MD5).getAlgorithm().toString(),"MD5")
        @Assert(MessageDigest(DigestType.SHA1).getAlgorithm().toString(),"SHA1")
    }
}