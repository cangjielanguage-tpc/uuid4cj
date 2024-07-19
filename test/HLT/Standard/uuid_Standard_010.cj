//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.math.*

@Test
public class uuid_Standard_010{
    @TestCase
    public func uuid_Standard_010():Unit{
        println("---------------------------------uuid_Standard_010------------------------------")
        println(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").clockSequence())
        @Assert(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").clockSequence(),11894)

        var eMessage = ""
        try{
            UUID.fromString("00000000-0000-0000-0000-000000000000").clockSequence()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")

        eMessage = ""
        try{
            UUID.fromString("b19189f9-4548-3aab-b923-47aefbcdd0a7").clockSequence()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")
    }
}