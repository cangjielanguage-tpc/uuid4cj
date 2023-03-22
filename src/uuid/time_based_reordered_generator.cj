/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class TimeBasedReorderedGenerator <: NoArgGenerator{

    public static let BYTE_OFFSET_TIME_HIGH = 0
    public static let BYTE_OFFSET_TIME_MID = 4
    public static let BYTE_OFFSET_TIME_LOW = 7

    protected var _ethernetAddress = Option<EthernetAddress>.None
    protected var _timer = Option<UUIDTimer>.None
    protected var _uuidL2:Int64 = 0



    public init(ethAddr:Option<EthernetAddress>,timer:UUIDTimer){
        let uuidBytes:Array<UInt8> = Array<UInt8>(16,item:0)
        var ethAddrTemp = ethAddr
        if(let Some(i) = ethAddrTemp){
        }else{
            ethAddrTemp = EthernetAddress.constructMulticastAddress()
        }
        _ethernetAddress = ethAddrTemp
        _ethernetAddress.getOrThrow().toByteArray(uuidBytes, 10)

        let clockSeq:Int32 = timer.getClockSequence()
        //uuidBytes[UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE] = UInt8(clockSeq >> 8)
        //uuidBytes[UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE+1] = UInt8(clockSeq)
        // long l2 = UUIDUtil.gatherLong(uuidBytes, 8)
        // _uuidL2 = UUIDUtil.initUUIDSecondLong(l2)
        _timer = timer
    }




    public func getType():UUIDType{
        return UUIDType.TIME_BASED_REORDERED
    }


    public func getEthernetAddress():EthernetAddress{
        return _ethernetAddress.getOrThrow()
    }


    public func generate():UUID{

        let rawTimestamp:Int64 = 12121211
        let timestampHigh:Int64 = rightShift(rawTimestamp,28) << 32
        let timestampLow:Int32 = Int32(rawTimestamp)
        let timeBottom:Int32 = (((timestampLow >> 12) & 0xFFFF) << 16) | 0x6000 | (timestampLow & 0xFFF)
        var timeBottomL:Int64 = Int64(timeBottom)
        timeBottomL = rightShift((timeBottomL << 32),32)

        var l1:Int64 = timestampHigh | timeBottomL
        return UUID(l1, _uuidL2)
    }

}


