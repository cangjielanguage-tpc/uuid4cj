/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a util
 */

package uuid4cj.uuid4cj

/*
 * The class is Unsupported Operation exception
 * @since 0.37.2
 */
public class UnsupportedOperationException <: Exception {
    private var messages: String = ""
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
        this.messages = messages
    }
    public func getMessage(): String {
        return messages
    }
    public override func toString(): String {
        return "UnsupportedOperationException: ${messages}"
    }
}

/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class InterruptedException <: Exception {
    private var messages: String = ""
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
        this.messages = messages
    }
    public func getMessage(): String {
        return messages
    }
    public override func toString(): String {
        return "InterruptedException: ${messages}"
    }
}

/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class NumberFormatException <: Exception {
    private var messages: String = ""
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
        this.messages = messages
    }
    public func getMessage(): String {
        return messages
    }
    public override func toString(): String {
        return "NumberFormatException: ${messages}"
    }
}

/*
 * likeness >>>
 */
func rightShift(value: Int64, bits: Int64): Int64 {
    let max: Int64 = Int64.Max
    let b = max >> (bits - 1)
    return b & (value >> bits)
}

/*
 * Array<UInt8> -> Array<Int8>
 */

@OverflowWrapping
func UInt8ToInt8(arr: Array<UInt8>): Array<Int8> {
    var res: Array<Int8> = Array<Int8>(arr.size, repeat: 0)
    for( i in 0..arr.size) {
        res[i] = Int8(arr[i])
    }
    return res
}

/*
 * Array<Int8> -> Array<UInt8>
 */

@OverflowWrapping
func Int8ToUInt8(arr: Array<Int8>): Array<UInt8> {
    var res: Array<UInt8> = Array<UInt8>(arr.size, repeat: 0)
    for( i in 0..arr.size) {
        res[i] = UInt8(arr[i])
    }
    return res
}