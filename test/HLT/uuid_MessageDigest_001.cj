//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import random.*

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