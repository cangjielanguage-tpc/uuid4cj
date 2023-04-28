//3rd_party_lib:uuid4cj/build/uuid
//3rd_party_lib:uuid4cj/ci_lib/cryptocj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid import uuid.*
from std import random.*
from std import fs.*
from std import math.*
from crypto import crypto.*

@Test
public class uuid_UUIDClock_001{
    @TestCase
    public func uuid_UUIDClock_currentTimeMillis_001():Unit{
        println("UUIDClock().currentTimeMillis(): ${UUIDClock().currentTimeMillis()}")
        @Assert(UUIDClock().currentTimeMillis() > 0,true)
    }
}