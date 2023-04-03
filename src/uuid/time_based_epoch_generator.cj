/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

from std import random.*
from std import time.*


public class TimeBasedEpochGenerator{

    protected let _random: Random

    public init(rnd:Random){
        this._random = rnd
    }

    public func getType():UUIDType{
        return UUIDType.TIME_BASED_EPOCH
    }

    protected static func  _toLong(buffer:Array<UInt8>,offset:Int64):Int64{
        var l1:Int64 = _toInt(buffer, offset)
        var l2:Int64 = _toInt(buffer, offset+4)
        let l = (l1 << 32) + rightShift((l2 << 32),32)
        return l
    }


    private static func _toInt(buffer:Array<UInt8>,offset:Int64){
         return (Int64(buffer[offset]) << 24)+ ((Int64(buffer[offset+1]) & 0xFF) << 16)+ ((Int64(buffer[offset+2]) & 0xFF) << 8)+ (Int64(buffer[offset+3]) & 0xFF)
    }

    private static func _toShort(buffer:Array<UInt8>,offset:Int64){
         return ((Int64(buffer[offset]) & 0xFF) << 8) + (Int64(buffer[offset+1]) & 0xFF)
    }


}
