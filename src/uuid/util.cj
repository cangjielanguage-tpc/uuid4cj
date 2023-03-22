/*
 * Copyright (c) Cangjie Library Team 2023-2024. All rights resvered.
 */

/**
 * @file
 *
 * This is a util
 */

package uuid

/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class UUIDException <: Exception {
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
    }
}


/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class InterruptedException <: Exception {
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
    }
}

/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class ReadWriteException <: Exception {
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
    }
}


/*
 * The class is uuid exception handling
 * @since 0.37.2
 */
public class NumberFormatException <: Exception {
    init() {
        super()
    }
    init(messages: String) {
        super(messages)
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
