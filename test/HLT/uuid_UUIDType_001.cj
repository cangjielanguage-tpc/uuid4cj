//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import random.*

@Test
public class uuid_UUIDType_001{
    @TestCase
    public func uuid_UUIDType_001():Unit{
        println("UUIDType.TIME_BASED: ${UUIDType.TIME_BASED.raw()}")
        println("UUIDType.DCE: ${UUIDType.DCE.raw()}")
        println("UUIDType.NAME_BASED_MD5: ${UUIDType.NAME_BASED_MD5.raw()}")
        println("UUIDType.RANDOM_BASED: ${UUIDType.RANDOM_BASED.raw()}")
        println("UUIDType.NAME_BASED_SHA1: ${UUIDType.NAME_BASED_SHA1.raw()}")
        println("UUIDType.TIME_BASED_REORDERED: ${UUIDType.TIME_BASED_REORDERED.raw()}")
        println("UUIDType.TIME_BASED_EPOCH: ${UUIDType.TIME_BASED_EPOCH.raw()}")
        println("UUIDType.FREE_FORM: ${UUIDType.FREE_FORM.raw()}")
        println("UUIDType.UNKNOWN : ${UUIDType.UNKNOWN .raw()}")
        @Assert(UUIDType.TIME_BASED.raw(),1)
        @Assert(UUIDType.DCE.raw(),2)
        @Assert(UUIDType.NAME_BASED_MD5.raw(),3)
        @Assert(UUIDType.RANDOM_BASED.raw(),4)
        @Assert(UUIDType.NAME_BASED_SHA1.raw(),5)
        @Assert(UUIDType.TIME_BASED_REORDERED.raw(),6)
        @Assert(UUIDType.TIME_BASED_EPOCH.raw(),7)
        @Assert(UUIDType.FREE_FORM.raw(),8)
        @Assert(UUIDType.UNKNOWN .raw(),0)
    }
}