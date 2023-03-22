/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class LazyRandom{

    private static let shared:SecureRandom = SecureRandom()

    public static func sharedSecureRandom():SecureRandom{
        return shared
    }

}
