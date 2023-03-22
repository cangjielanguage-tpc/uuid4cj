/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class UUIDClock{

    public func currentTimeMillis():Int64{
        return Time.now().unixTimeStamp().nanoseconds() / 1000 /1000
    }

}
