//3rd_party_lib:uuid/build/uuid
//3rd_party_lib:jwt/ci_lib/cryptocj

from std import unittest.*
from std import unittest.testmacro.*
from uuid import uuid.*

@Test
public class Test01{
    @TestCase
    public func test_01():Unit{
        @Assert(1,1)      
    }
   
}