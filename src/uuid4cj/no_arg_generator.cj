/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
package uuid4cj

public abstract class NoArgGenerator <: UUIDGenerator{

    /**
     * generate uuid
     */
    public func generate():UUID

}

