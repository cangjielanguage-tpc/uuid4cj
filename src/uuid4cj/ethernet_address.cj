/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/**
 * EthernetAddress encapsulates the 6-byte MAC address defined in
 * IEEE 802.1 standard.
 */
public class EthernetAddress <: Hashable & ToString & Equatable<EthernetAddress>{

    private static let HEX_CHARS:Array<Rune> = "0123456789abcdefABCDEF".toRuneArray()

    protected static var _rnd = Option<SecureRandom>.None

    private var _address:Int64 = 0

    private var _asString = Option<String>.None

    
    /**
     * String constructor; given a 'standard' ethernet MAC address string
     * (like '00:C0:F0:3D:5B:7C'), constructs an EthernetAddress instance.
     *
     * Note that string is case-insensitive, and also that leading zeroes
     * may be omitted. Thus '00:C0:F0:3D:5B:7C' and '0:c0:f0:3d:5b:7c' are
     * equivalent, and a 'null' address could be passed as ':::::' as well
     * as '00:00:00:00:00:00' (or any other intermediate combination).
     *
     * @param addrStr - String representation of the ethernet address
     */
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

            var c : Rune = addrStr.toRuneArray()[i]
            i++
            var value:Int64 = 0
            if(c == r':'){
                value = 0
            }else{
                if(c >= r'0' && c <= r'9'){
                    value = Int64(charToUInt32(c)-charToUInt32(r'0'))
                }else if (c >= r'a' && c <= r'f') {
                    value = Int64((charToUInt32(c) - charToUInt32(r'a') + 10))
                }else if (c >= r'A' && c <= r'F') {
                    value = Int64((charToUInt32(c) - charToUInt32(r'A') + 10))
                }else{
                     throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                }

                if(i < len){
                    c = addrStr.toRuneArray()[i]
                    i++
                    if(c != r':'){
                         value = (value << 4)
                        if (c >= r'0' && c <= r'9') {
                            value |= Int64((charToUInt32(c) - charToUInt32(r'0')))
                        }else if (c >= r'a' && c <= r'f') {
                            value |= Int64((charToUInt32(c) - charToUInt32(r'a') + 10))
                        }else if (c >= r'A' && c <= r'F') {
                            value |= Int64((charToUInt32(c) - charToUInt32(r'A') + 10))
                        }else{
                            throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                        }
                    }
                }
            }

            addr = (addr << 8) | value

            if (c != r':') {
                if (i < len) {
                    if (addrStr.toRuneArray()[i] != r':') {
                        throw NumberFormatException("Expected ':', got ('"+ addrStr.toRuneArray()[i].toString()+"')")
                    }
                    i++
                }else if(j < 5){
                    throw NumberFormatException("Incomplete ethernet address (missing one or more digits")
                }
            }
        }
        _address = addr
    }


    func charToUInt32(char:Rune):UInt32{
        return UInt32(char)
    }

    /**
     * Binary constructor that constructs an instance given the 6 byte
     *      * (48-bit) address. Useful if an address is saved in binary format
     *      * (for saving space for example).
     *
     * @param addr - Array address
     */
    public init(addr : Array<UInt8>){
        if(addr.size != 6){
            throw  NumberFormatException("Ethernet address has to consist of 6 bytes")
        }
        var l:Int64 = Int64(addr[0] & 0xFF)
        for (i in 1..6) {
            l = (l << 8) | Int64(addr[i] & 0xFF)
        }
        _address = l
    }

    /**
     * Another binary constructor; constructs an instance from
     *
     * the given
     * long argument; the lowest 6 bytes contain the address.
     *
     * @param addr - Int64 that contains the MAC address in 6 least significant
     *    bytes.
     */
    public init(addr:Int64){
        _address = addr
    }

    /**
     * Default cloning behaviour (bitwise copy) is just fine...
     */
    public func clone():EthernetAddress{
        return EthernetAddress(_address)
    }

    /**
     * Constructs a new EthernetAddress given the byte array that contains
     * binary representation of the address.
     *
     * Note that calling this method returns the same result as would
     * using the matching constructor.
     *
     * @param addr - Array representation of the ethernet address
     */
    public static func valueOf(addr:Array<UInt8>):EthernetAddress{
        return EthernetAddress(addr)
    }

    /**
     * Constructs a new EthernetAddress given the byte array that contains
     * binary representation of the address.
     *
     * Note that calling this method returns the same result as would
     * using the matching constructor.
     *
     * @param addr - Array Binary representation of the ethernet address
     */
    @OverflowWrapping 
    public static func valueOf(addr:Array<Int32>):EthernetAddress{
        var bAddr:Array<UInt8> = Array<UInt8>(addr.size,repeat:0)
        for (i in 0..addr.size) {
            bAddr[i] = UInt8(addr[i])
        }
        return EthernetAddress(bAddr)
    }

    /**
     * Constructs a new EthernetAddress given a string representation of
     * the ethernet address.
     *
     * Note that calling this method returns the same result as would
     * using the matching constructor.
     *
     * @param addrStr - String representation of the ethernet address
     */
    public static func valueOf(addrStr:String){
        return EthernetAddress(addrStr)
    }

    /**
     * Constructs a new EthernetAddress given the long int value (64-bit)
     * representation of the ethernet address (of which 48 LSB contain
     * the definition)
     *
     * Note that calling this method returns the same result as would
     * using the matching constructor.
     *
     * @param addr - Int64 int representation of the ethernet address
     */
    public static func valueOf(addr:Int64){
        return EthernetAddress(addr)
    }

    /**
     * Factory method that can be used to construct a random multicast
     * address; to be used in cases where there is no "real" ethernet
     * address to use. Address to generate should be a multicast address
     * to avoid accidental collision with real manufacturer-assigned
     * MAC addresses.
     *<p>
     * Internally a {@link SecureRandom} instance is used for generating
     * random number to base address on.
     *
     * @return EthernetAddress
     */
    public static func constructMulticastAddress():EthernetAddress{
        return constructMulticastAddress(_randomNumberGenerator())
    }

    static let m1: MultiConditionMonitor = MultiConditionMonitor()

    /**
     * Factory method that can be used to construct a random multicast
     * address; to be used in cases where there is no "real" ethernet
     * address to use. Address to generate should be a multicast address
     * to avoid accidental collision with real manufacturer-assigned
     * MAC addresses.
     *<p>
     * Address is created using specified SecureRandom number generator.
     *
     * @param rnd - SecureRandom
     * @return EthernetAddress
     */
    public static func constructMulticastAddress(rnd:SecureRandom):EthernetAddress{
        var dummy:Array<UInt8> =  Array<UInt8>(6,repeat:0)
        synchronized(m1){
            dummy = rnd.nextBytes(6)
        }
        dummy[0] |= UInt8(0x01)
        return EthernetAddress(dummy)
    }

    /**
     * Returns 6 byte byte array that contains the binary representation
     * of this ethernet address; byte 0 is the most significant byte
     * (and so forth)
     *
     * @return 6 UInt8 array that contains the binary representation
     */
    public func asByteArray():Array<UInt8>{
        var result:Array<UInt8> = Array<UInt8>(6,repeat:0)
        toByteArray(result)
        return result
    }

    /**
     * Synonym to 'asByteArray()'
     *
     * @return 6 UInt8 array that contains the binary representation
     */
    public func toByteArray():Array<UInt8>{
        return asByteArray()
    }

    /**
     * Synonym to 'toByteArray'
     *
     * @param array - Array<UInt8>
     * @return Unit
     */
    public func toByteArray(array:Array<UInt8>):Unit{
        if (array.size < 6) {
            throw IllegalArgumentException("Too small array, need to have space for 6 bytes")
        }
        toByteArray(array, 0)
    }

    /**
     * Synonym to 'toByteArray'
     *
     * @param array - Array<UInt8>
     * @return Unit
     */
    @OverflowWrapping
    public func toByteArray(uuidBytesArray:Array<UInt8>,pos:Int64):Unit{
         if (pos < 0 || (pos + 6) > uuidBytesArray.size) {
            throw  IllegalArgumentException("Illegal offset (${pos}), need room for 6 bytes")
        }
        var temppos = pos
        var i:Int32 = Int32(_address >> 32)
        uuidBytesArray[temppos] = UInt8(i >> 8)
        temppos++
        uuidBytesArray[temppos] = UInt8(i)
        temppos++
        i = Int32(_address)
        uuidBytesArray[temppos] = UInt8(i >> 24)
        temppos++
        uuidBytesArray[temppos] = UInt8(i >> 16)
        temppos++
        uuidBytesArray[temppos] = UInt8(i >> 8)
        temppos++
        uuidBytesArray[temppos] = UInt8(i)
    }

    /**
     * get address
     *
     * @return Int64
     */
    public func toLong():Int64{
        return _address
    }

    /**
     * MulticastAddress or not
     *
     * @return Bool
     */
    public func isMulticastAddress():Bool{
        return ((Int32(_address >> 40)) & 0x01) != 0
    }

    /**
     * LocallyAdministeredAddress or not
     *
     * @return Bool
     */
    public func isLocallyAdministeredAddress():Bool{
        return ((Int32(_address >> 40)) & 0x02) != 0
    }

    /**
     * equal or not
     *
     * @param anothor - EthernetAddress
     * @return Bool
     */
    public operator func ==(anothor: EthernetAddress): Bool{
         if(this._address == anothor._address){
            return true
            
         }
        return false
    }

    /**
     * equal or not
     *
     * @param anothor - EthernetAddress
     * @return Bool
     */
    public operator func !=(anothor: EthernetAddress): Bool{
        if(this._address != anothor._address){
            return true
         }
        return false
    }

    /**
     * get hashcode
     *
     * @return Int64
     */
    public func hashCode(): Int64{
        return Int64(_address) ^ Int64(rightShift(_address,32))
    }

    /**
     * toString
     *
     * @return String
     */
    @OverflowWrapping
    public func toString(): String{
        var str = _asString
        if(let Some(i) <- str){
            return i
        }

        var b:StringBuilder = StringBuilder()
        var i1:Int32 = Int32(_address >> 32)
        var i2:Int32 = Int32(_address)

        _appendHex(b, Int64(i1 >> 8))
        b.append(':')
        _appendHex(b, Int64(i1))
        b.append(':')
        _appendHex(b, Int64(i2 >> 24))
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
            _rnd = match (_rnd) {
                case Some(_) => _rnd
                case None => SecureRandom()
            }
            return _rnd.getOrThrow()
        }
    }

    private func _appendHex(sb:StringBuilder,hex:Int64):Unit{
        sb.append(HEX_CHARS[(hex >> 4) & 0xF])
        sb.append(HEX_CHARS[(hex & 0x0f)])
    }

}
