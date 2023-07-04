//3rd_party_lib:uuid4cj/build/uuid
//3rd_party_lib:uuid4cj/ci_lib/cryptocj
//3rd_party_lib:uuid4cj/ci_lib/charset

from std import unittest.*
from std import unittest.testmacro.*
from uuid import uuid.*

@Test
public class uuid_NameBasedGenerator_001{
    func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
        var res: Array<Int8> = Array<Int8>(arr.size, item: 0)
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
        @Assert(uuid.toString(),"cbd88ca2-d47a-1ecc-bf09-73d2beeb84c7")
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
        @Assert(uuid.toString(),"430af79a-55ad-2570-b7af-420c1c95823b")
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
        @Assert(uuid.toString(),"e358ca3c-f9fc-3846-8322-d8c511a3a11b")
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
        @Assert(uuid.toString(),"054faba8-fc2f-402b-ad0f-6cb01c9c3f89")
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
        var array:Array<Int8> = Array<Int8>(0,item:0)
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
        var array:Array<Int8> = UInt8ToInt8("hello world".toUtf8Array())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),1)
        @Assert(uuid.toString(),"cbd88ca2-d47a-1ecc-bf09-73d2beeb84c7")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_DNS.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_002():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_002------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_URL,Option<MessageDigest>.None,UUIDType.DCE)
        var array:Array<Int8> = UInt8ToInt8("hello world".toUtf8Array())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),2)
        @Assert(uuid.toString(),"430af79a-55ad-2570-b7af-420c1c95823b")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_URL.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_003():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_003------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_OID,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_MD5)
        var array:Array<Int8> = UInt8ToInt8("hello world".toUtf8Array())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),3)
        @Assert(uuid.toString(),"e358ca3c-f9fc-3846-8322-d8c511a3a11b")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_OID.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_004():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_004------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(NameBasedGenerator.NAMESPACE_X500,MessageDigest(DigestType.MD5),UUIDType.RANDOM_BASED)
        var array:Array<Int8> = UInt8ToInt8("hello world".toUtf8Array())
        let uuid: UUID = name.generate(array)
        let uuid2: UUID = name.generate(array)
        println("UUIDType: ${name.getType().raw()}")
        println("UUID: ${uuid.toString()}")
        println("getNamespace: ${name.getNamespace()}")
        @Assert(name.getType() is UUIDType,true)
        @Assert(name.getType().raw(),4)
        @Assert(uuid.toString(),"054faba8-fc2f-402b-ad0f-6cb01c9c3f89")
        @Assert(uuid.toString(),uuid2.toString())
        @Assert(name.getNamespace().toString(),NameBasedGenerator.NAMESPACE_X500.toString())
    }
    @TestCase
    public func uuid_NameBasedGenerator_generateArray_005():Unit{
        println("---------------------------------uuid_NameBasedGenerator_generateArray_005------------------------------")
        var name: NameBasedGenerator = NameBasedGenerator(Option<UUID>.None,MessageDigest(DigestType.MD5),UUIDType.NAME_BASED_SHA1)
        var array:Array<Int8> = UInt8ToInt8("hello world".toUtf8Array())
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