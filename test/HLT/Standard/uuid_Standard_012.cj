//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.math.*

@Test
public class uuid_Standard_012{
    @TestCase
    public func uuid_Standard_012():Unit{
        println("---------------------------------uuid_Standard_012------------------------------")
        let uuid: UUID = UUID.nilUUID()
        println("uuid: ${uuid.toString()}")
        @Assert(uuid.toString(),"00000000-0000-0000-0000-000000000000")
    }
}