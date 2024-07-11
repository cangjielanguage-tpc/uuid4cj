/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj

from std import random.*
from std import math.*

/*
 * The class is extend Random
 * @since 0.37.2
 */
extend Random {
    @OverflowWrapping
    func nextBytes(length: Int32): Array<UInt8> {
        var bytes: Array<UInt8> = Array<UInt8>(Int64(length), item: 0)
        var i: Int64 = 0
        for(_ in 0..bytes.size) {
            var rnd: Int32 = nextInt32()
            var n: Int64 = min(Int64(length) - i, Int64(4))
            n--
            for(_ in 0..n) {
                rnd >>= 8
                i++
                bytes[i] = UInt8(rnd)
            }
        }
        return bytes
    }
}

