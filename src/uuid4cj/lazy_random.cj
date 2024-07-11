/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj

/*
 * The class is random generators
 * @since 0.39.8
 */
public class LazyRandom{

    private static let shared:SecureRandom = SecureRandom()
    private static let sharedRandom:Random = Random()

    private static let lock: Monitor = Monitor()

    /**
     *  generate random
     * 
     * @return SecureRandom
     */
    public static func sharedSecureRandom():SecureRandom{
        return shared
    }

    /**
     *  generate random
     * 
     * @return Random
     */
    public static func sharedNewRandom():Random{
        return sharedRandom
    }

    /**
     *  generate lock
     * 
     * @return Monitor
     */
    public static func getMonitor():Monitor{
        return lock
    }
}
