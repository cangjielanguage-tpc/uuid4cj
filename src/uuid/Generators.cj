/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public class Generators{


    public static func randomBasedGenerator(rnd: Random):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd)
    }

    public static func randomBasedGenerator(rnd: SecureRandom):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd)
    }

    public static func nameBasedGenerator(): NameBasedGenerator {
        return NameBasedGenerator(Option<UUID>.None, Option<MessageDigest>.None, Option<UUIDType>.None)
    }

    public static func nameBasedGenerator(namespace: UUID): NameBasedGenerator {
        return NameBasedGenerator(namespace, Option<MessageDigest>.None, Option<UUIDType>.None)
    }

    public static func nameBasedGenerator(namespace: UUID, digester: MessageDigest): NameBasedGenerator {
        return NameBasedGenerator(namespace, digester, Option<UUIDType>.None)
    }
}