//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import math.*

@Test
public class uuid_Standard_001{
    @TestCase
    public func uuid_Standard_001():Unit{
        println("---------------------------------uuid_Standard_001------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var uuid_str = uuid.toString()
        println("uuid: ${uuid_str}")
        let uuid2 = UUID.fromString(uuid_str)
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString()==uuid2.toString(),true)

        var eMessage = ""
        try{
            UUID.fromString("")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid UUID string: ")

        eMessage = ""
        try{
            UUID.fromString("G")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid UUID string: G")

        eMessage = ""
        try{
            UUID.fromString("00000000-0000--0000-0000-000000000000")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid UUID string: 00000000-0000--0000-0000-000000000000")

        eMessage = ""
        try{
            UUID.fromString("00000000-00000000-0000-000000000000")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid UUID string: 00000000-00000000-0000-000000000000")
    }
    
}