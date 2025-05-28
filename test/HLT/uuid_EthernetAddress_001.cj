//3rd_party_lib:uuid4cj/build/uuid4cj
//3rd_party_lib:uuid4cj/ci_lib/crypto4cj
//3rd_party_lib:uuid4cj/ci_lib/charset4cj

import std.unittest.*
import std.unittest.testmacro.*
import uuid4cj.uuid4cj.*
import std.random.*
import crypto.crypto.*

@Test
public class uuid_EthernetAddress_001{
    @TestCase
    public func uuid_EthernetAddress_init_001():Unit{
        println("---------------------------------uuid_EthernetAddress_init_001------------------------------")
        var ethernetAddress = EthernetAddress("00:C0:F0:3D:5B:7C")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_init_002():Unit{
        println("---------------------------------uuid_EthernetAddress_init_002------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3d:5b:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_init_003():Unit{
        println("---------------------------------uuid_EthernetAddress_init_003------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_init_004():Unit{
        println("---------------------------------uuid_EthernetAddress_init_004------------------------------")
        var ethernetAddress = EthernetAddress("::f0:3D:5B:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:00:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_init_005():Unit{
        println("---------------------------------uuid_EthernetAddress_init_005------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c:0")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")      
    }
    @TestCase
    public func uuid_EthernetAddress_init_006():Unit{
        println("---------------------------------uuid_EthernetAddress_init_006------------------------------")
        var eMessage = ""
        try{
            EthernetAddress("00:c0:f0:3D:5B0:7c")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Expected ':', got ('0')")
    }
    @TestCase
    public func uuid_EthernetAddress_init_007():Unit{
        println("---------------------------------uuid_EthernetAddress_init_007------------------------------")
        var array : Array<UInt8> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c]
        var ethernetAddress = EthernetAddress(array)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")      
    }
    @TestCase
    public func uuid_EthernetAddress_init_008():Unit{
        println("---------------------------------uuid_EthernetAddress_init_008------------------------------")
        var array : Array<UInt8> = Array<UInt8>()
        var eMessage = ""
        try{
            EthernetAddress(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_init_009():Unit{
        println("---------------------------------uuid_EthernetAddress_init_009------------------------------")
        var array : Array<UInt8> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c, 0x7c]
        var eMessage = ""
        try{
            EthernetAddress(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_init_010():Unit{
        println("---------------------------------uuid_EthernetAddress_init_010------------------------------")
        var ethernetAddress = EthernetAddress(0xffffffffffffff)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"ff:ff:ff:ff:ff:ff")
        @Assert(ethernetAddress.toLong(),0xffffffffffffff)
        ethernetAddress = EthernetAddress(0x00ffffffffffff)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"ff:ff:ff:ff:ff:ff")
        @Assert(ethernetAddress.toLong(),0x00ffffffffffff)
        ethernetAddress = EthernetAddress(0xff000000000000)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"00:00:00:00:00:00")
        @Assert(ethernetAddress.toLong(),0xff000000000000)
    }
    @TestCase
    public func uuid_EthernetAddress_clone_001():Unit{
        println("---------------------------------uuid_EthernetAddress_init_010------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var ethernetAddress2 = ethernetAddress.clone()
        var ethernetAddress3 = ethernetAddress
        var ethernetAddress4 = EthernetAddress("00:C0:F0:3D:5B:7C")
        var ethernetAddress5 = EthernetAddress(":C0:F0:3D:5B:7C")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress2: ${ethernetAddress2.toString()}")
        println("ethernetAddress3: ${ethernetAddress3.toString()}")
        println("ethernetAddress4: ${ethernetAddress4.toString()}")

        @Assert(ethernetAddress==ethernetAddress2,true)
        @Assert(ethernetAddress==ethernetAddress3,true)
        @Assert(ethernetAddress==ethernetAddress4,true)
        @Assert(ethernetAddress==ethernetAddress5,true)

        @Assert(ethernetAddress!=ethernetAddress2,false)
        @Assert(ethernetAddress!=ethernetAddress3,false)
        @Assert(ethernetAddress!=ethernetAddress4,false)
        @Assert(ethernetAddress!=ethernetAddress5,false)

        var ethernetAddress6 = EthernetAddress(0xffffffffffffff)
        var ethernetAddress7 = EthernetAddress(0x00ffffffffffff)
        println("ethernetAddress6: ${ethernetAddress6.toString()}")
        println("ethernetAddress7: ${ethernetAddress7.toString()}")
        @Assert(ethernetAddress6!=ethernetAddress7,true)
        @Assert(ethernetAddress6==ethernetAddress7,false)
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_011():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_011------------------------------")
        var array : Array<UInt8> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c]
        var ethernetAddress = EthernetAddress.valueOf(array)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")      
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_012():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_012------------------------------")
        var array : Array<UInt8> = Array<UInt8>()
        var eMessage = ""
        try{
            EthernetAddress.valueOf(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_013():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_013------------------------------")
        var array : Array<UInt8> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c, 0x7c]
        var eMessage = ""
        try{
            EthernetAddress.valueOf(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_014():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_014------------------------------")
        var array : Array<Int32> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c]
        var ethernetAddress = EthernetAddress.valueOf(array)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")      
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_015():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_015------------------------------")
        var array : Array<Int32> = Array<Int32>()
        var eMessage = ""
        try{
            EthernetAddress.valueOf(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_016():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_016------------------------------")
        var array : Array<Int32> = [0x0, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c, 0x7c]
        var eMessage = ""
        try{
            EthernetAddress.valueOf(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Ethernet address has to consist of 6 bytes")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_017():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_017------------------------------")

        var array : Array<Int32> = [0x100, 0xc0, 0xf0, 0x3d, 0x5b, 0x7c]
        var ethernetAddress = EthernetAddress.valueOf(array)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_001():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_001------------------------------")
        var ethernetAddress = EthernetAddress.valueOf("00:C0:F0:3D:5B:7C")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_002():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_002------------------------------")
        var ethernetAddress = EthernetAddress.valueOf("00:c0:f0:3d:5b:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_003():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_003------------------------------")
        var ethernetAddress = EthernetAddress.valueOf("00:c0:f0:3D:5B:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_004():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_004------------------------------")
        var ethernetAddress = EthernetAddress.valueOf("::f0:3D:5B:7c")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:00:f0:3d:5b:7c")       
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_005():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_005------------------------------")
        var ethernetAddress = EthernetAddress.valueOf("00:c0:f0:3D:5B:7c:0")
        println("ethernetAddress: ${ethernetAddress.toString()}")
        @Assert(ethernetAddress.toString(),"00:c0:f0:3d:5b:7c")      
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_006():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_006------------------------------")
        var eMessage = ""
        try{
            EthernetAddress.valueOf("00:c0:f0:3D:5B0:7c")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Expected ':', got ('0')")
    }
    @TestCase
    public func uuid_EthernetAddress_valueOf_010():Unit{
        println("---------------------------------uuid_EthernetAddress_valueOf_010------------------------------")
        var ethernetAddress = EthernetAddress.valueOf(0xffffffffffffff)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"ff:ff:ff:ff:ff:ff")
        @Assert(ethernetAddress.toLong(),0xffffffffffffff)
        ethernetAddress = EthernetAddress.valueOf(0x00ffffffffffff)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"ff:ff:ff:ff:ff:ff")
        @Assert(ethernetAddress.toLong(),0x00ffffffffffff)
        ethernetAddress = EthernetAddress.valueOf(0xff000000000000)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress.toLong(): ${ethernetAddress.toLong()}")
        @Assert(ethernetAddress.toString(),"00:00:00:00:00:00")
        @Assert(ethernetAddress.toLong(),0xff000000000000)
    }
    @TestCase
    public func uuid_EthernetAddress_constructMulticastAddress_001():Unit{
        println("---------------------------------uuid_EthernetAddress_constructMulticastAddress_001------------------------------")
        var ethernetAddress = EthernetAddress.constructMulticastAddress()
        var ethernetAddress2 = EthernetAddress.constructMulticastAddress()
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress2: ${ethernetAddress2.toString()}")
        @Assert(ethernetAddress.toString()==ethernetAddress2.toString(),false)
    }
    @TestCase
    public func uuid_EthernetAddress_constructMulticastAddress_SecureRandom_001():Unit{
        println("---------------------------------uuid_EthernetAddress_constructMulticastAddress_SecureRandom_001------------------------------")
        var ethernetAddress = EthernetAddress.constructMulticastAddress(SecureRandom())
        var ethernetAddress2 = EthernetAddress.constructMulticastAddress(SecureRandom())
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress2: ${ethernetAddress2.toString()}")
        @Assert(ethernetAddress.toString()==ethernetAddress2.toString(),false)
    }
    @TestCase
    public func uuid_EthernetAddress_constructMulticastAddress_SecureRandom_002():Unit{
        println("---------------------------------uuid_EthernetAddress_constructMulticastAddress_SecureRandom_002------------------------------")
        var ethernetAddress = EthernetAddress.constructMulticastAddress(SecureRandom(priv: true))
        var ethernetAddress2 = EthernetAddress.constructMulticastAddress(SecureRandom(priv: true))
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress2: ${ethernetAddress2.toString()}")
        @Assert(ethernetAddress.toString()==ethernetAddress2.toString(),false)
    }
    @TestCase
    public func uuid_EthernetAddress_constructMulticastAddress_SecureRandom_003():Unit{
        println("---------------------------------uuid_EthernetAddress_constructMulticastAddress_SecureRandom_003------------------------------")
        var ethernetAddress = EthernetAddress.constructMulticastAddress(SecureRandom(priv: false))
        var ethernetAddress2 = EthernetAddress.constructMulticastAddress(SecureRandom(priv: false))
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("ethernetAddress2: ${ethernetAddress2.toString()}")
        @Assert(ethernetAddress.toString()==ethernetAddress2.toString(),false)
    }
    @TestCase
    public func uuid_EthernetAddress_asByteArray_001():Unit{
        println("---------------------------------uuid_EthernetAddress_asByteArray_001------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = ethernetAddress.asByteArray()
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[0, 192, 240, 61, 91, 124]")
        @Assert(EthernetAddress(array).toString(),ethernetAddress.toString())
    }
    @TestCase
    public func uuid_EthernetAddress_asByteArray_002():Unit{
        println("---------------------------------uuid_EthernetAddress_asByteArray_002------------------------------")
        var ethernetAddress = EthernetAddress(":::::")
        var array = ethernetAddress.asByteArray()
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[0, 0, 0, 0, 0, 0]")
        @Assert(EthernetAddress(array).toString(),ethernetAddress.toString())
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_001():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_001------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = ethernetAddress.toByteArray()
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[0, 192, 240, 61, 91, 124]")
        @Assert(EthernetAddress(array).toString(),ethernetAddress.toString())
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_002():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_002------------------------------")
        var ethernetAddress = EthernetAddress(":::::")
        var array = ethernetAddress.toByteArray()
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[0, 0, 0, 0, 0, 0]")
        @Assert(EthernetAddress(array).toString(),ethernetAddress.toString())
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_003():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_003------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = Array<UInt8>(6,item:0)
        ethernetAddress.toByteArray(array)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[0, 192, 240, 61, 91, 124]")
        @Assert(EthernetAddress(array).toString(),ethernetAddress.toString())
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_004():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_004------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = Array<UInt8>(0,item:0)
        var eMessage = ""
        try{
            ethernetAddress.toByteArray(array)
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Too small array, need to have space for 6 bytes") 
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_005():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_005------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = Array<UInt8>(8,item:100)
        ethernetAddress.toByteArray(array,1)
        println("ethernetAddress: ${ethernetAddress.toString()}")
        println("array: ${array.toString()}")
        @Assert(array.toString(),"[100, 0, 192, 240, 61, 91, 124, 100]")
        
    }
    @TestCase
    public func uuid_EthernetAddress_toByteArray_006():Unit{
        println("---------------------------------uuid_EthernetAddress_toByteArray_006------------------------------")
        var ethernetAddress = EthernetAddress("00:c0:f0:3D:5B:7c")
        var array = Array<UInt8>(8,item:100)
        var eMessage = ""
        try{
            ethernetAddress.toByteArray(array,3)
            println("array: ${array.toString()}")
        } catch (e: Exception){
            eMessage = e.message
        }
        println("eMessage: ${eMessage}")
        @Assert(eMessage,"Illegal offset (3), need room for 6 bytes") 
    }
    @TestCase
    public func uuid_EthernetAddress_isMulticastAddress_001():Unit{
        println("---------------------------------uuid_EthernetAddress_isMulticastAddress_001------------------------------")
        var ethernetAddress = EthernetAddress(239400429082189)
        println("ethernetAddress.isMulticastAddress(): ${ethernetAddress.isMulticastAddress()}")
        @Assert(ethernetAddress.isMulticastAddress(),true) 
    }
    @TestCase
    public func uuid_EthernetAddress_isMulticastAddress_002():Unit{
        println("---------------------------------uuid_EthernetAddress_isMulticastAddress_002------------------------------")
        var ethernetAddress = EthernetAddress(240499940709965)
        println("ethernetAddress.isMulticastAddress(): ${ethernetAddress.isMulticastAddress()}")
        @Assert(ethernetAddress.isMulticastAddress(),false) 
    }
    @TestCase
    public func uuid_EthernetAddress_isLocallyAdministeredAddress_001():Unit{
        println("---------------------------------uuid_EthernetAddress_isLocallyAdministeredAddress_001------------------------------")
        var ethernetAddress = EthernetAddress(239400429082189)
        println("ethernetAddress.isLocallyAdministeredAddress(): ${ethernetAddress.isLocallyAdministeredAddress()}")
        @Assert(ethernetAddress.isLocallyAdministeredAddress(),false) 
    }
    @TestCase
    public func uuid_EthernetAddress_isLocallyAdministeredAddress_002():Unit{
        println("---------------------------------uuid_EthernetAddress_isLocallyAdministeredAddress_002------------------------------")
        var ethernetAddress = EthernetAddress(240499940709965)
        println("ethernetAddress.isLocallyAdministeredAddress(): ${ethernetAddress.isLocallyAdministeredAddress()}")
        @Assert(ethernetAddress.isLocallyAdministeredAddress(),true) 
    }
    @TestCase
    public func uuid_EthernetAddress_hashCode_001():Unit{
        println("---------------------------------uuid_EthernetAddress_hashCode_001------------------------------")
        var ethernetAddress = EthernetAddress(0)
        println("ethernetAddress.hashCode(): ${ethernetAddress.hashCode()}")
        @Assert(ethernetAddress.hashCode(),0)
        
        ethernetAddress = EthernetAddress(100)
        println("ethernetAddress.hashCode(): ${ethernetAddress.hashCode()}")
        @Assert(ethernetAddress.hashCode(),100)
        
        ethernetAddress = EthernetAddress(-100)
        println("ethernetAddress.hashCode(): ${ethernetAddress.hashCode()}")
        @Assert(ethernetAddress.hashCode(),-4294967197) 
    }
}