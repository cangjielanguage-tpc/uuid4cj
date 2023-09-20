//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid4cj import uuid4cj.*
from std import math.*
from std import format.*

@Test
public class uuid_UUIDUtil_001{
    @TestCase
    public func uuid_UUIDUtil_nilUUID():Unit{
        println("---------------------------------uuid_UUIDUtil_nilUUID------------------------------")
        let uuid = UUIDUtil.nilUUID()
        println("uuid: ${uuid.toString()}")
        @Assert(uuid.toString(),"00000000-0000-0000-0000-000000000000")
    }
    @TestCase
    public func uuid_UUIDUtil_maxUUID():Unit{
        println("---------------------------------uuid_UUIDUtil_maxUUID------------------------------")
        let uuid = UUIDUtil.maxUUID()
        println("uuid: ${uuid.toString()}")
        @Assert(uuid.toString(),"ffffffff-ffff-ffff-ffff-ffffffffffff")
    }
    @TestCase
    public func uuid_UUIDUtil_uuid_String_001():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_String_001------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var uuid_str = uuid.toString()
        println("uuid: ${uuid_str}")
        let uuid2 =  UUIDUtil.uuid(uuid_str)
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString()==uuid2.toString(),true)

        let uuid3 =  UUIDUtil.uuid("2AAE6C35-C94F-5FB4-95db-e95f408b9ce9")
        let uuid4 =  UUIDUtil.uuid("2AAE6C35-C94F-5FB4-95DB-E95F408B9CE9")
        println("uuid3: ${uuid3.toString()}")
        println("uuid4: ${uuid4.toString()}")
        @Assert(uuid3.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(uuid4.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")

    }
    @TestCase
    public func uuid_UUIDUtil_uuid_String_002():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_String_002------------------------------")
        var eMessage = ""
        try{
            UUIDUtil.uuid("")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"UUID has to be represented by the standard 36-char representation")

        eMessage = ""
        try{
            UUIDUtil.uuid("G")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"UUID has to be represented by the standard 36-char representation")

        eMessage = ""
        try{
            UUIDUtil.uuid("00000000-0000--0000-0000-000000000000")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"UUID has to be represented by the standard 36-char representation")

        eMessage = ""
        try{
            UUIDUtil.uuid("00000000-00000000-0000-000000000000")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"UUID has to be represented by the standard 36-char representation")
    }
    @TestCase
    public func uuid_UUIDUtil_uuid_Array_001():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_Array_001------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var arry: Array<Int8> = UInt8ToInt8(UUIDUtil.asByteArray(uuid))
        let uuid2: UUID = UUIDUtil.uuid(arry)
        println("uuid: ${uuid.toString()}")
        println("arry: ${arry}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(arry.toString(),"[42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]")
        @Assert(uuid2.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")    
    }
    @TestCase
    public func uuid_UUIDUtil_uuid_Array_002():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_Array_002------------------------------")
        var arry: Array<Int8> = Array<Int8>(0,item:0)
        var eMessage = ""
        try{
            UUIDUtil.uuid(arry)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid bytes passed: can not be null")
    }
    @TestCase
    public func uuid_UUIDUtil_uuid_Array_003():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_Array_003------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var arry: Array<Int8> = Array<Int8>(20,item:0)
        println("arry: ${arry}")
        println("arry.size: ${arry.size}")
        var j:Int64 = 4
        for (i in UInt8ToInt8(UUIDUtil.asByteArray(uuid))) {
            arry[j] = i
            j++
        }
        println("arry: ${arry}")
        println("arry.size: ${arry.size}")
        let uuid2: UUID = UUIDUtil.uuid(arry,4)
        println("uuid: ${uuid.toString()}")
        println("uuid2: ${uuid2.toString()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(arry.toString(),"[0, 0, 0, 0, 42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]")
        @Assert(uuid2.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")    
    }
    @TestCase
    public func uuid_UUIDUtil_uuid_Array_004():Unit{
        println("---------------------------------uuid_UUIDUtil_uuid_Array_004------------------------------")
        var name: NameBasedGenerator = Generators.nameBasedGenerator()
        let uuid: UUID = name.generate("hello world")
        var arry: Array<Int8> = Array<Int8>(20,item:0)
        println("arry: ${arry}")
        println("arry.size: ${arry.size}")
        var j:Int64 = 4
        for (i in UInt8ToInt8(UUIDUtil.asByteArray(uuid))) {
            arry[j] = i
            j++
        }
        println("arry: ${arry}")
        println("arry.size: ${arry.size}")
        
        var eMessage = ""
        try{
            UUIDUtil.uuid(arry,5)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid offset (5) passed: not enough room in byte array (need 16 bytes)")
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_001():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_001------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-1fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),1)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_002():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_002------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-3fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),3)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_003():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_003------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-4fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),4)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_004():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_004------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),5)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_005():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_005------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-6fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),6)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_006():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_006------------------------------")
        var arry: Array<Int8> = [42, -82, 108, 53, -55, 79, 95, -76, -107, -37, -23, 95, 64, -117, -100, -23]
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH,arry)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        @Assert(uuid.toString(),"2aae6c35-c94f-7fb4-95db-e95f408b9ce9")
        @Assert(uuid.version(),7)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_007():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_007------------------------------")
        var arry: Array<Int8> = Array<Int8>(0,item:0)
        
        var eMessage = ""
        try{
            UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH,arry)
        } catch (e: IndexOutOfBoundsException){
            eMessage = "IndexOutOfBoundsException"
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"IndexOutOfBoundsException")
        
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_008():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_008------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED,1,1)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"00000000-0000-1001-8000-000000000001")
        @Assert(uuid.version(),1)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),1)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_009():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_009------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.NAME_BASED_MD5,2,2)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"00000000-0000-3002-8000-000000000002")
        @Assert(uuid.version(),3)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),3)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_010():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_010------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.RANDOM_BASED,0,0)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"00000000-0000-4000-8000-000000000000")
        @Assert(uuid.version(),4)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),4)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_011():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_011------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.NAME_BASED_SHA1,-1,0)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"ffffffff-ffff-5fff-8000-000000000000")
        @Assert(uuid.version(),5)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),5)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_012():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_012------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED_REORDERED,-1,-1)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"ffffffff-ffff-6fff-bfff-ffffffffffff")
        @Assert(uuid.version(),6)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),6)
    }
    @TestCase
    public func uuid_UUIDUtil_constructUUID_013():Unit{
        println("---------------------------------uuid_UUIDUtil_constructUUID_013------------------------------")
        let uuid: UUID = UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH,-1,-1)
        println("uuid: ${uuid.toString()}")
        println("uuid.version(): ${uuid.version()}")
        println("UUIDUtil.typeOf(uuid): ${UUIDUtil.typeOf(uuid).getOrThrow().raw()}")
        @Assert(uuid.toString(),"ffffffff-ffff-7fff-bfff-ffffffffffff")
        @Assert(uuid.version(),7)
        @Assert(UUIDUtil.typeOf(uuid).getOrThrow().raw(),7)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_001():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_001------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.TIME_BASED)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000001000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_002():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_002------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.NAME_BASED_MD5)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000003000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_003():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_003------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.RANDOM_BASED)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000004000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_004():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_004------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.NAME_BASED_SHA1)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000005000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_005():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_005------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.TIME_BASED_REORDERED)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000006000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_006():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_006------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,UUIDType.TIME_BASED_EPOCH)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000007000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_007():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_007------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,1)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000001000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_008():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_008------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,3)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000003000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_009():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_009------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,4)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000004000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_010():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_010------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,5)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000005000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_011():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_011------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,6)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000006000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_012():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_012------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,7)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000007000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDFirstLong_013():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDFirstLong_013------------------------------")
        let l1: Int64 = UUIDUtil.initUUIDFirstLong(0x1000000000000000,100)
        println("l1: ${l1.format("#x")}")
        @Assert(l1,0x1000000000064000)
    }
    @TestCase
    public func uuid_UUIDUtil_initUUIDSecondLong():Unit{
        println("---------------------------------uuid_UUIDUtil_initUUIDSecondLong------------------------------")
        var l2: Int64 = UUIDUtil.initUUIDSecondLong(0x1000000000000000)
        @Assert(l2,-8070450532247928832)

        l2 = UUIDUtil.initUUIDSecondLong(0)
        @Assert(l2,-9223372036854775808)

        l2 = UUIDUtil.initUUIDSecondLong(-1)
        @Assert(l2,-4611686018427387905)
    }
    @TestCase
    public func uuid_UUIDUtil_typeOf():Unit{
        println("---------------------------------uuid_UUIDUtil_typeOf------------------------------")
        var eMessage = ""
        try{
            UUIDUtil.typeOf(UUIDUtil.uuid("00000000-0000-f000-0000-000000000000")).getOrThrow().raw()
        } catch (e: NoneValueException){
            eMessage = "NoneValueException"
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"NoneValueException")
    }
    @TestCase
    public func uuid_UUIDUtil_toByteArray_001():Unit{
        println("---------------------------------uuid_UUIDUtil_toByteArray_001------------------------------")
        var uuid = UUID.nilUUID()
        var array: Array<Int8> = Array<Int8>(16,item:0)
        UUIDUtil.toByteArray(uuid,array)
        println("array: ${array}")
        @Assert(array.toString(),"[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]")

        uuid = UUIDUtil.uuid("b19189f9-4548-3aab-b923-47aefbcdd0a7")
        UUIDUtil.toByteArray(uuid,array)
        println("array: ${array}")
        @Assert(array.toString(),"[-79, -111, -119, -7, 69, 72, 58, -85, -71, 35, 71, -82, -5, -51, -48, -89]")
    }
    @TestCase
    public func uuid_UUIDUtil_toByteArray_002():Unit{
        println("---------------------------------uuid_UUIDUtil_toByteArray_002------------------------------")
        var uuid = UUID.nilUUID()
        var array: Array<Int8> = Array<Int8>(0,item:0)
        
        var eMessage = ""
        try{
            UUIDUtil.toByteArray(uuid,array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid bytes passed: can not be null")

        var array2: Array<Int8> = Array<Int8>(15,item:0)
        eMessage = ""
        try{
            UUIDUtil.toByteArray(uuid,array2)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid offset (0) passed: not enough room in byte array (need 16 bytes)")
    }
    @TestCase
    public func uuid_UUIDUtil_toByteArray_003():Unit{
        println("---------------------------------uuid_UUIDUtil_toByteArray_003------------------------------")
        var uuid = UUID.nilUUID()
        var array: Array<Int8> = Array<Int8>(17,item:0)
        UUIDUtil.toByteArray(uuid,array,1)
        println("array: ${array}")
        @Assert(array.toString(),"[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]")

        uuid = UUIDUtil.uuid("b19189f9-4548-3aab-b923-47aefbcdd0a7")
        UUIDUtil.toByteArray(uuid,array,1)
        println("array: ${array}")
        @Assert(array.toString(),"[0, -79, -111, -119, -7, 69, 72, 58, -85, -71, 35, 71, -82, -5, -51, -48, -89]")

        var array2: Array<Int8> = Array<Int8>(17,item:0)
        UUIDUtil.toByteArray(UUID.nilUUID(),array2,0)
        println("array: ${array2}")
        @Assert(array2.toString(),"[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]")

        uuid = UUIDUtil.uuid("b19189f9-4548-3aab-b923-47aefbcdd0a7")
        UUIDUtil.toByteArray(uuid,array2,0)
        println("array: ${array2}")
        @Assert(array2.toString(),"[-79, -111, -119, -7, 69, 72, 58, -85, -71, 35, 71, -82, -5, -51, -48, -89, 0]")
    }
    @TestCase
    public func uuid_UUIDUtil_toByteArray_004():Unit{
        println("---------------------------------uuid_UUIDUtil_toByteArray_004------------------------------")
        var uuid = UUID.nilUUID()
        var array: Array<Int8> = Array<Int8>(0,item:0)
        
        var eMessage = ""
        try{
            UUIDUtil.toByteArray(uuid,array,0)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid bytes passed: can not be null")

        var array2: Array<Int8> = Array<Int8>(16,item:0)
        eMessage = ""
        try{
            UUIDUtil.toByteArray(uuid,array2,1)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid offset (1) passed: not enough room in byte array (need 16 bytes)")

        eMessage = ""
        try{
            UUIDUtil.toByteArray(uuid,array2,15)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Invalid offset (15) passed: not enough room in byte array (need 16 bytes)")


    }
}

@OverflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}