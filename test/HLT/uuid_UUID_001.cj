//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.math.*

@Test
public class uuid_UUID_001{
    @TestCase
    public func uuid_UUID_Most_Least_init():Unit{
        println("---------------------------------uuid_UUID_Most_Least_init------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var bytes = uuid.getBytes()
        let uuid2: UUID = UUID(bytes)
        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid2.toString(),uuid.toString())
        @Assert(uuid2.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")

    }
    @TestCase
    public func uuid_UUID_init():Unit{
        println("---------------------------------uuid_UUID_init------------------------------")
        let uuid: UUID = UUID(Array(16, item: 0xff))
        println("uuid: ${uuid.toString()}")
        @Assert(uuid.toString(),"ffffffff-ffff-ffff-ffff-ffffffffffff")

        let uuid2: UUID = UUID.nilUUID()
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid2.toString(),"00000000-0000-0000-0000-000000000000")

        let bytes: Array<UInt8> = [0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 200]
        let uuid3: UUID = UUID(bytes)
        println("uuid3: ${uuid3.toString()}")
        @Assert(uuid3.toString(),"00000000-0000-007b-0000-0000000001c8")
    }

    @TestCase
    public func uuid_UUID_nilUUID():Unit{
        println("---------------------------------uuid_UUID_nilUUID------------------------------")
        let uuid: UUID = UUID.nilUUID()
        println("uuid: ${uuid.toString()}")
        @Assert(uuid.toString(),"00000000-0000-0000-0000-000000000000")
    }
    @TestCase
    public func uuid_UUID_randomUUID():Unit{
        println("---------------------------------uuid_UUID_randomUUID------------------------------")
        let uuid: UUID = UUID.randomUUID()
        let uuid2: UUID = UUID.randomUUID()
        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString()==uuid2.toString(),false)
    }
    @TestCase
    public func uuid_UUID_Array_001():Unit{
        println("---------------------------------uuid_UUID_Array_001------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var arry: Array<Int8> = UInt8ToInt8(UUIDUtil.asByteArray(uuid))
        let uuid2: UUID = UUID.nameUUIDFromBytes(arry)
        println("uuid: ${uuid.toString()}")
        println("arry: ${arry}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(arry.toString(),"[42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]")
        @Assert(uuid2.toString(),"3daea605-0cdf-3de3-b405-77884bfe4f6f")    
    }
    @TestCase
    public func uuid_UUID_Array_002():Unit{
        println("---------------------------------uuid_UUID_Array_002------------------------------")
        var arry: Array<Int8> = Array<Int8>(0,item:0)
        var eMessage = ""
        try{
            UUID.nameUUIDFromBytes(arry)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"The data cannot be empty.")
    }
    @TestCase
    public func uuid_UUID_fromString():Unit{
        println("---------------------------------uuid_UUID_fromString------------------------------")
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
    @TestCase
    public func uuid_UUID_timestamp():Unit{
        println("---------------------------------uuid_UUID_timestamp------------------------------")
        println(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").timestamp())
        @Assert(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").timestamp(),139017021317120153)

        var eMessage = ""
        try{
            UUID.fromString("00000000-0000-0000-0000-000000000000").timestamp()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")

        eMessage = ""
        try{
            UUID.fromString("b19189f9-4548-3aab-b923-47aefbcdd0a7").timestamp()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")
    }
    @TestCase
    public func uuid_UUID_clockSequence():Unit{
        println("---------------------------------uuid_UUID_clockSequence------------------------------")
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
    @TestCase
    public func uuid_UUID_node():Unit{
        println("---------------------------------uuid_UUID_node------------------------------")
        println(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").node())
        @Assert(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").node(),155267800506338)

        var eMessage = ""
        try{
            UUID.fromString("00000000-0000-0000-0000-000000000000").node()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")

        eMessage = ""
        try{
            UUID.fromString("b19189f9-4548-3aab-b923-47aefbcdd0a7").node()
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Not a time-based UUID")
    }
    @TestCase
    public func uuid_UUID_hashCode():Unit{
        println("---------------------------------uuid_UUID_hashCode------------------------------")
        println(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").hashCode())
        @Assert(UUID.fromString("8d570099-e33e-11ed-ae76-8d371a181fe2").hashCode(),6006174210588282058)

        println(UUID.fromString("00000000-0000-0000-0000-000000000000").hashCode())
        @Assert(UUID.fromString("00000000-0000-0000-0000-000000000000").hashCode(),1383799676518214173)

        println(UUID.fromString("b19189f9-4548-3aab-b923-47aefbcdd0a7").hashCode())
        @Assert(UUID.fromString("b19189f9-4548-3aab-b923-47aefbcdd0a7").hashCode(),-4271242665235116607)
    }
    @TestCase
    public func uuid_UUID_equals_001():Unit{
        println("---------------------------------uuid_UUID_equals_001------------------------------")
        
        var name: NameBasedGenerator = Generators.nameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS, MessageDigest(DigestType.MD5))
        let uuid: UUID = name.generate("hello world")
        var uuid2 = uuid
        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.equals(uuid),true)
        @Assert(uuid2.equals(uuid),true)
        @Assert(uuid.equals(uuid2),true)

        let uuid3: UUID = name.generate("hello world")
        println("uuid3: ${uuid3.toString()}")
        @Assert(uuid3.equals(uuid),true)
        @Assert(uuid.equals(uuid3),true) 
    }
    @TestCase
    public func uuid_UUID_equals_002():Unit{
        println("---------------------------------uuid_UUID_equals_002------------------------------")
        let uuid = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(1, 0)))// UUID(1,0)
        let uuid2 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(0,1)))
        let uuid3 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(1,1)))

        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        println("uuid3: ${uuid3.toString()}")

        @Assert(uuid.equals(uuid2),false)
        @Assert(uuid.equals(uuid3),false) 

    }
    @TestCase
    public func uuid_UUID_compareTo():Unit{
        println("---------------------------------uuid_UUID_compareTo------------------------------")
        let uuid = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2, 0)))
        let uuid2 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(0, 2)))
        let uuid3 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2, 2)))
        let uuid4 = UUID(Int8ToUInt8(UUIDUtil.int64asByteArray(2, 2)))

        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        println("uuid3: ${uuid3.toString()}")
        println("uuid4: ${uuid4.toString()}")

        println("uuid.compareTo(uuid): ${uuid.compareTo(uuid)}")
        println("uuid.compareTo(uuid2): ${uuid.compareTo(uuid2)}")
        println("uuid.compareTo(uuid3): ${uuid.compareTo(uuid3)}")
        println("uuid3.compareTo(uuid4): ${uuid3.compareTo(uuid4)}")
        
        @Assert(uuid.compareTo(uuid),0)
        @Assert(uuid.compareTo(uuid2),1)
        @Assert(uuid.compareTo(uuid3),-1)
        @Assert(uuid3.compareTo(uuid4),0)
    }
}

@OverflowWrapping
func Int8ToUInt8(arr: Array<Int8>): Array<UInt8> {
    var res: Array<UInt8> = Array<UInt8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = UInt8(arr[i])
    }
    return res
}

@OverflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}