/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class TimeBasedGenerator <: NoArgGenerator{

    protected var _ethernetAddress: Option<EthernetAddress>
    protected var _timer: UUIDTimer
    protected var _uuidL2:Int64

    @overflowWrapping
    public init(ethAddr:Option<EthernetAddress>,timer: UUIDTimer){
        var uuidBytes: Array<UInt8> = Array<UInt8>(16,item:0)
        var ethAddrTemp = ethAddr
        if (ethAddr == None) {
            ethAddrTemp = EthernetAddress.constructMulticastAddress()
        }
        _ethernetAddress = ethAddrTemp
        _ethernetAddress.getOrThrow().toByteArray(uuidBytes, 10)

        let clockSeq:Int32 = timer.getClockSequence()
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE)] = UInt8(clockSeq >> 8)
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE+1)] = UInt8(clockSeq)
        
        let l2: Int64 = UUIDUtil.gatherLong(UInt8ToInt8(uuidBytes), 8)

        _uuidL2 = UUIDUtil.initUUIDSecondLong(l2)
        _timer = timer
    }

    public func getType():UUIDType{
        return UUIDType.TIME_BASED_REORDERED
    }

    public func getEthernetAddress():EthernetAddress{
        return _ethernetAddress.getOrThrow()
    }

    public func generate():UUID{
        let rawTimestamp:Int64 = _timer.getTimestamp()

        let clockHi:Int64 = Int64(rightShift(rawTimestamp,32))
        let clockLo:Int64 = Int64(rawTimestamp)

        var midhi:Int64 = (clockHi << 16) | rightShift(clockHi,16)

        midhi &= !0xF000
        midhi |= 0x1000
        var midhiL:Int64 = Int64(midhi);
        midhiL = rightShift((midhiL << 32), 32)
        var l1: Int64 = (Int64(clockLo) << 32) | midhi
        return UUID(l1, _uuidL2)
    }

}


