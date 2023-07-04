/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package uuid

/*
 * The class is now time generators
 * @since 0.37.2
 */
public class UUIDClock{

    /**
     * Returns the current time in toMilliseconds.
     *
     * @return Int64
     */
    public func currentTimeMillis():Int64{
        return DateTime.now().toUnixTimeStamp().toMilliseconds()
    }

}
