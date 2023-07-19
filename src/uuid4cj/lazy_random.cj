/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package uuid4cj

/*
 * The class is random generators
 * @since 0.37.2
 */
public class LazyRandom{

    private static let shared:SecureRandom = SecureRandom()

    /**
     *  generate random
     * 
     * @return SecureRandom
     */
    public static func sharedSecureRandom():SecureRandom{
        return shared
    }

}
