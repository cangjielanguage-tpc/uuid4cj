/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class Generators{


    public static func randomBasedGenerator(rnd: Random):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd);
    }

    public static func randomBasedGenerator(rnd: SecureRandom):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd);
    }

}