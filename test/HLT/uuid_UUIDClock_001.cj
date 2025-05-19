//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*
import std.fs.*
import std.math.*
import stdx.crypto.crypto.*

@Test
public class uuid_UUIDClock_001{
    @TestCase
    public func uuid_UUIDClock_currentTimeMillis_001():Unit{
        println("UUIDClock().currentTimeMillis(): ${UUIDClock().currentTimeMillis()}")
        @Assert(UUIDClock().currentTimeMillis() > 0,true)
    }
}