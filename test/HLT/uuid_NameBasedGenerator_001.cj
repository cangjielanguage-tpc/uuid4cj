//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*

@Test
public class uuid_NameBasedGenerator_001{
    func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
        var res: Array<Int8> = Array<Int8>(arr.size, repeat: 0)
        for( i in 0..arr.size) {
            res[i] = Int8(arr[i])
        }
        return res
    }
    @TestCase
    public func uuid_NameBasedGenerator_let():Unit{
        println("---------------------------------uuid_NameBasedGenerator_let------------------------------")
        println("NAMESPACE_DNS: ${NameBasedGenerator.NAMESPACE_DNS.toString()}")
        println("NAMESPACE_URL: ${NameBasedGenerator.NAMESPACE_URL.toString()}")
        println("NAMESPACE_OID: ${NameBasedGenerator.NAMESPACE_OID.toString()}")
        println("NAMESPACE_X500: ${NameBasedGenerator.NAMESPACE_X500.toString()}")

        @Assert(NameBasedGenerator.NAMESPACE_DNS.toString(),"6ba7b810-9dad-11d1-80b4-00c04fd430c8")
        @Assert(NameBasedGenerator.NAMESPACE_URL.toString(),"6ba7b811-9dad-11d1-80b4-00c04fd430c8")
        @Assert(NameBasedGenerator.NAMESPACE_OID.toString(),"6ba7b812-9dad-11d1-80b4-00c04fd430c8")
        @Assert(NameBasedGenerator.NAMESPACE_X500.toString(),"6ba7b814-9dad-11d1-80b4-00c04fd430c8")

        println("NAMESPACE_DNS.version(): ${NameBasedGenerator.NAMESPACE_DNS.version()}")
        println("NAMESPACE_URL.version(): ${NameBasedGenerator.NAMESPACE_URL.version()}")
        println("NAMESPACE_OID.version(): ${NameBasedGenerator.NAMESPACE_OID.version()}")
        println("NAMESPACE_X500.version(): ${NameBasedGenerator.NAMESPACE_X500.version()}")
        @Assert(NameBasedGenerator.NAMESPACE_DNS.version(),1)
        @Assert(NameBasedGenerator.NAMESPACE_URL.version(),1)
        @Assert(NameBasedGenerator.NAMESPACE_OID.version(),1)
        @Assert(NameBasedGenerator.NAMESPACE_X500.version(),1)

        @Assert(NameBasedGenerator.NAMESPACE_DNS.variant(),2)
        @Assert(NameBasedGenerator.NAMESPACE_URL.variant(),2)
        @Assert(NameBasedGenerator.NAMESPACE_OID.variant(),2)
        @Assert(NameBasedGenerator.NAMESPACE_X500.variant(),2)
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_001():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_001------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS,MessageDigest(DigestType.SHA1),UUIDType.TIME_BASED)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),1)
        @Assert(uuid.toString(),"823a2f73-a936-16c3-b8b4-03641bd74f35")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_DNS.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_002():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_002------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_URL,Option<MessageDigest>.None,UUIDType.DCE)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),2)
        @Assert(uuid.toString(),"7b3d66ac-cb60-2154-8edf-0bcfd0c418b3")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_URL.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_003():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_003------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_OID,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_MD5)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"5af444b8-bf08-3277-946a-be3800a0349e")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_OID.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_004():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_004------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_X500,MessageDigest(DigestType.MD5),UUIDType.RANDOM_BASED)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),4)
        @Assert(uuid.toString(),"3dba5e6d-ce97-4b41-a58c-686674d18ada")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_X500.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_005():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_005------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_SHA1)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"5eb63bbb-e01e-5ed0-93cb-22bb8f5acdc3")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_006():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_006------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,UUIDType.TIME_BASED_REORDERED)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),6)
        @Assert(uuid.toString(),"2aae6c35-c94f-6fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_007():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_007------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,UUIDType.TIME_BASED_EPOCH)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),7)
        @Assert(uuid.toString(),"2aae6c35-c94f-7fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_008():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_008------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,UUIDType.FREE_FORM)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),8)
        @Assert(uuid.toString(),"2aae6c35-c94f-8fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_009():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_009------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,UUIDType.UNKNOWN)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),0)
        @Assert(uuid.toString(),"2aae6c35-c94f-0fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_init_010():Unit{
        println("---------------------------------uuid_NameBasedGenerator_init_010------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,Option<UUIDType>.None)
        let uuid: UUID = name.generate("hello world")
        let uuid2: UUID = name.generate("hello world")
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"2aae6c35-c94f-5fb4-95db-e95f408b9ce9")
        @Assert(uuid.toString(),uuid2.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_getNamespace_001():Unit{
        println("---------------------------------uuid_NameBasedGenerator_getNamespace_001------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,Option<UUIDType>.None)
        var eMessage = ""
        try {
            name.getNamespace()
        } catch (e:NoneValueException) {
            println(e.message)
            eMessage = "NoneValueException"
        }
        @Assert(eMessage,"NoneValueException")
    }
    @TestCase
    public func uuid_NameBasedGenerator_generate_():Unit{
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,Option<MessageDigest>.None,Option<UUIDType>.None)
        var eMessage = ""
        var array:Array<Int8> = Array<Int8>(0,repeat:0)
        try {
            name.generate(array)
        } catch (e:Exception) {
            println(e.message)
            eMessage = e.message
        }
        @Assert(eMessage,"The data cannot be empty.")
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_001():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_001------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_DNS,MessageDigest(DigestType.SHA1),UUIDType.TIME_BASED)
        var array:Array<Int8> = UInt8ToInt8("hello world".toArray())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),1)
        @Assert(uuid.toString(),"823a2f73-a936-16c3-b8b4-03641bd74f35")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_DNS.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_002():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_002------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_URL,Option<MessageDigest>.None,UUIDType.DCE)
        var array:Array<Int8> = UInt8ToInt8("hello world".toArray())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),2)
        @Assert(uuid.toString(),"7b3d66ac-cb60-2154-8edf-0bcfd0c418b3")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_URL.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_003():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_003------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_OID,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_MD5)
        var array:Array<Int8> = UInt8ToInt8("hello world".toArray())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"5af444b8-bf08-3277-946a-be3800a0349e")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_OID.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_004():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_004------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_X500,MessageDigest(DigestType.MD5),UUIDType.RANDOM_BASED)
        var array:Array<Int8> = UInt8ToInt8("hello world".toArray())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),4)
        @Assert(uuid.toString(),"3dba5e6d-ce97-4b41-a58c-686674d18ada")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_X500.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_005():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_005------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_SHA1)
        var array:Array<Int8> = UInt8ToInt8("hello world".toArray())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),5)
        @Assert(uuid.toString(),"5eb63bbb-e01e-5ed0-93cb-22bb8f5acdc3")
        @Assert(uuid.toString(),uuid2.toString())
    }
}