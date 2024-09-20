/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj.uuid4cj

/**
 * Implementation of UUID generator that uses time/location based generation
 * method (variant 1).
 *<p>
 * As all JUG provided implementations, this generator is fully thread-safe.
 * Additionally it can also be made externally synchronized with other
 * instances (even ones running on other JVMs); to do this,
 * use {@link com.fasterxml.uuid.ext.FileBasedTimestampSynchronizer}
 * (or equivalent).
 *
 * since 38.2
 */
public class TimeBasedGenerator <: NoArgGenerator{

    protected var _ethernetAddress: Option<EthernetAddress>
    protected var _timer: UUIDTimer
    protected var _uuidL2:Int64

    /**
     * @param ethAddr Hardware address (802.1) to use for generating
     *   spatially unique part of UUID. If system has more than one NIC
     *
     * @param ethAddr - Option<EthernetAddress>
     * @param timer - UUIDTimer
     */
    @OverflowWrapping
    public init(ethAddr:Option<EthernetAddress>,timer: UUIDTimer){
        var uuidBytes: Array<UInt8> = Array<UInt8>(16,repeat:0)
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

    /**
     * get UUIDType
     *
     * @return UUIDType
     */
    public override func getType(): UUIDType{
        return UUIDType.TIME_BASED
    }

    /**
     * get EthernetAddress
     *
     * @return EthernetAddress
     */
    public func getEthernetAddress():EthernetAddress{
        return _ethernetAddress.getOrThrow()
    }

    /**
     * generate uuid
     *
     * @return uuid
     */
    public override func generate():UUID{
        let rawTimestamp:Int64 = _timer.getTimestamp()
        let clockHi:Int64 = Int64(rightShift(rawTimestamp,32))
        let clockLo:Int64 = Int64(rawTimestamp)

        var midhi:Int64 = (clockHi << 16) | rightShift(clockHi,16)

        midhi &= !0xF000
        midhi |= 0x1000
        var midhiL:Int64 = Int64(midhi);
        midhiL = rightShift((midhiL << 32), 32)
        var l1: Int64 = (Int64(clockLo) << 32) | midhiL

        let timeArray: Array<UInt8> = Int8ToUInt8(UUIDUtil.int64asByteArray(l1, _uuidL2))
        return UUID(timeArray)
    }

}


