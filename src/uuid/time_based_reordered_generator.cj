/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

/**
 * Implementation of UUID generator that uses time/location based generation
 * method field compatible with UUIDv1, reorderd for improved DB locality.
 *
 * @since 38.2
 */
public class TimeBasedReorderedGenerator <: NoArgGenerator{

    public static let BYTE_OFFSET_TIME_HIGH = 0
    public static let BYTE_OFFSET_TIME_MID = 4
    public static let BYTE_OFFSET_TIME_LOW = 7

    protected var _ethernetAddress: ?EthernetAddress
    /**
     * Object used for synchronizing access to timestamps, to guarantee
     * that timestamps produced by this generator are unique and monotonically increasings.
     */
    protected var _timer: UUIDTimer
    /**
     * Base values for the second long (last 8 bytes) of UUID to construct
     */
    protected var _uuidL2: Int64 = 0

    /**
     * Construction
     *
     * @param ethAddr - Hardware address to use for generating
     * @param timer - Object used for synchronizing access to timestamps
     */
    @OverflowWrapping
    public init(ethAddr: ?EthernetAddress, timer: UUIDTimer) {
        let uuidBytes:Array<UInt8> = Array<UInt8>(16, item: 0)
        match(ethAddr) {
            case None =>
                _ethernetAddress = EthernetAddress.constructMulticastAddress() 
            case Some(v) =>
                _ethernetAddress = ethAddr
        }
        _ethernetAddress.getOrThrow().toByteArray(uuidBytes, 10)
        // and add clock sequence
        var clockSeq: Int32 = timer.getClockSequence()
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE)] = UInt8(clockSeq >> 8)
        uuidBytes[Int64(UUIDUtil.BYTE_OFFSET_CLOCK_SEQUENCE + 1)] = UInt8(clockSeq)
        var l2: Int64 = UUIDUtil.gatherLong(UInt8ToInt8(uuidBytes), 8)
        _uuidL2 = UUIDUtil.initUUIDSecondLong(l2)
        _timer = timer
    }

    /**
     * get type
     *
     * @return UUIDType
     */
    public override func getType(): UUIDType {
        return UUIDType.TIME_BASED_REORDERED
    }

    /**
     * get the hardware address for generating
     *
     * @return EthernetAddress
     */
    public func getEthernetAddress(): EthernetAddress {
        return _ethernetAddress.getOrThrow()
    }

    @OverflowWrapping
    public func generate(): UUID {
        // Ok, get 60-bit timestamp (4 MSB are ignored)
        let rawTimestamp: Int64 = _timer.getTimestamp()
        // First: discard 4 MSB, next 32 bits (top of 60-bit timestamp) form the
        // highest 32-bit segments
        let timestampHigh: Int64 = rightShift(rawTimestamp, 28) << 32
        // and then bottom 28 bits split into mid (16 bits), low (12 bits)
        let timestampLow: Int32 = Int32(rawTimestamp)
        // and then low part gets mixed with variant identifier
        let timeBottom: Int32 = (((timestampLow >> 12) & 0xFFFF) << 16) | 0x6000 | (timestampLow & 0xFFF)
        var timeBottomL: Int64 = Int64(timeBottom)
        timeBottomL = rightShift((timeBottomL << 32), 32)
        // and reconstruct
        var l1:Int64 = timestampHigh | timeBottomL
        return UUID(l1, _uuidL2)
    }

}


