/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

from std import random.*

public class TimeBasedEpochGenerator{

    protected let _random: Random

    public init(rnd:Random){
        this._random = rnd
    }

    public func getType():UUIDType{
        return UUIDType.TIME_BASED_EPOCH
    }


}
