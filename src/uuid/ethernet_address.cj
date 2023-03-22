/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

from std import sync.*
from std import collection.*


public class EthernetAddress <: Hashable & ToString & Equatable<EthernetAddress>{

    private static let serialVersionUID:Int64 = 1

    private static let HEX_CHARS:Array<Char> = "0123456789abcdefABCDEF".toCharArray()

    protected static var _rnd = Option<SecureRandom>.None

    private var _address:Int64 = 0

    private var _asString = Option<String>.None

    public init(addrStr:String){

        let len = addrStr.size
        var addr:Int64 = 0
        var i = 0
        for(j in 0..6){

            if(i >= len){
                if(j == 5){
                    addr = addr << 8
                    break
                }
                throw NumberFormatException("Incomplete ethernet address (missing one or more digits")
            }

            var c : Char = addrStr.charAt(i)
            i++
            var value:Int64 = 0
            if(c == ':'){
                value = 0
            }else{
                if(c >= '0' && c <= '9'){
                    value = Int64(charToUInt32(c)-charToUInt32('0'))
                }else if (c >= 'a' && c <= 'f') {
                    value = Int64((charToUInt32(c) - charToUInt32('a') + 10))
                }else if (c >= 'A' && c <= 'F') {
                    value = Int64((charToUInt32(c) - charToUInt32('A') + 10))
                }else{
                     throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                }

                if(i < len){
                    c = addrStr.charAt(i)
                    i++
                    if(c != ':'){
                         value = (value << 4)
                        if (c >= '0' && c <= '9') {
                            value |= Int64((charToUInt32(c) - charToUInt32('0')))
                        }else if (c >= 'a' && c <= 'f') {
                            value |= Int64((charToUInt32(c) - charToUInt32('a') + 10))
                        }else if (c >= 'A' && c <= 'F') {
                            value |= Int64((charToUInt32(c) - charToUInt32('A') + 10))
                        }else{
                            throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                        }
                    }
                }
            }

            addr = (addr << 8) | value

            if (c != ':') {
                if (i < len) {
                    if (addrStr.charAt(i) != ':') {
                        throw NumberFormatException("Expected ':', got ('"+ addrStr.charAt(i).toString()+"')")
                    }
                    i++
                }else if(j < 5){
                    throw NumberFormatException("Incomplete ethernet address (missing one or more digits")
                }
            }
        }
        _address = addr
    }


    func charToUInt32(char:Char):UInt32{
        return UInt32(char)
    }


    public init(addr : Array<UInt8>){
        if(addr.size != 6){
            throw  NumberFormatException("Ethernet address has to consist of 6 bytes")
        }
        var l:Int64 = Int64(addr[0] & 0xFF)
        for (i in 0..6) {
            l = (l << 8) | Int64(addr[i] & 0xFF)
        }
        _address = l
    }

    public init(addr:Int64){
        _address = addr
    }


    public func clone():EthernetAddress{
        return EthernetAddress(_address)
    }

    public static func valueOf(addr:Array<UInt8>):EthernetAddress{
        return EthernetAddress(addr)
    }

    public static func valueOf(addr:Array<Int32>):EthernetAddress{
        var bAddr:Array<UInt8> = Array<UInt8>(addr.size,item:0)
        for (i in 0..addr.size) {
            bAddr[i] = UInt8(addr[i])
        }
        return EthernetAddress(bAddr)
    }

    public static func valueOf(addrStr:String){
        return EthernetAddress(addrStr)
    }

    public static func valueOf(addr:Int64){
        return EthernetAddress(addr)
    }


    public static func constructMulticastAddress():EthernetAddress{
        return constructMulticastAddress(_randomNumberGenerator())
    }



    static let m1: MultiConditionMonitor = MultiConditionMonitor()

    public static func constructMulticastAddress(rnd:SecureRandom):EthernetAddress{
        var dummy:Array<UInt8> =  Array<UInt8>(6,item:0)
        synchronized(m1){
            dummy = rnd.nextBytes(6)
        }
        dummy[0] |= UInt8(0x01)
        return EthernetAddress(dummy)
    }


    public func asByteArray():Array<UInt8>{
        var result:Array<UInt8> = Array<UInt8>(6,item:0)
        toByteArray(result)
        return result
    }


    public func toByteArray():Array<UInt8>{
        return asByteArray()
    }


    public func toByteArray(array:Array<UInt8>):Unit{
        if (array.size < 6) {
            throw IllegalArgumentException("Too small array, need to have space for 6 bytes")
        }
        toByteArray(array, 0)
    }


    public func toByteArray(array:Array<UInt8>,pos:Int64):Unit{
         if (pos < 0 || (pos + 6) > array.size) {
            throw  IllegalArgumentException("Illegal offset ("+pos.toString()+"), need room for 6 bytes")
        }
        var temppos = pos
        var i:Int32 = Int32(_address >> 32)
        temppos++
        array[temppos] = UInt8(i >> 8)
        temppos++
        array[temppos] = UInt8(i)
        i = Int32(_address)
        temppos++
        array[temppos] = UInt8(i >> 24)
        temppos++
        array[temppos] = UInt8(i >> 16)
        temppos++
        array[temppos] = UInt8(i >> 8)
        array[temppos] = UInt8(i)
    }


    public func toLong():Int64{
        return _address
    }

    public func isMulticastAddress():Bool{
        return ((Int32(_address >> 40)) & 0x01) != 0
    }


    public func isLocallyAdministeredAddress():Bool{
        return ((Int32(_address >> 40)) & 0x02) != 0
    }



    public operator func ==(anothor: EthernetAddress): Bool{
         if(this._address == anothor._address){
            return true
         }
        return false
    }



    public operator func !=(anothor: EthernetAddress): Bool{
        if(this._address != anothor._address){
            return true
         }
        return false
    }


    public func hashCode(): Int64{
        return Int64(_address) ^ Int64(rightShift(_address,32))
    }


    // public func compare(rhs: EthernetAddress): Ordering{
    //     let l = this._address - rhs._address
    //     if(l>0){
    //         return Ordering.GT
    //     }else if(l == 0){
    //         return Ordering.EQ
    //     }else{
    //         return Ordering.LT
    //     }
    // }

    public func toString(): String{
        var str = _asString
        if(let Some(i) = str){
            return i
        }

        var b:StringBuilder = StringBuilder()
        var i1:Int32 = Int32(_address >> 32)
        var i2:Int32 = Int32(_address)

        _appendHex(b, Int64(i1 >> 8))
        b.append(':')
        _appendHex(b, Int64(i1))
        b.append(':')
        _appendHex(b, Int64(2 >> 24))
        b.append(':')
        _appendHex(b, Int64(i2 >> 16))
        b.append(':')
        _appendHex(b, Int64(i2 >> 8))
        b.append(':')
        _appendHex(b, Int64(i2))
        _asString = b.toString()
        str = b.toString()
        return str.getOrThrow()
    }




    static let m: MultiConditionMonitor = MultiConditionMonitor()


    protected static func _randomNumberGenerator():SecureRandom{
        synchronized(m) {
            if(let Some(i) = _rnd){

            }else{
                _rnd = Option<SecureRandom>.Some(SecureRandom())
            }
            return _rnd.getOrThrow()
        }
    }


    private func _appendHex(sb:StringBuilder,hex:Int64):Unit{
        sb.append(HEX_CHARS[(hex >> 4) & 0xF])
        sb.append(HEX_CHARS[(hex & 0x0f)])
    }


}
