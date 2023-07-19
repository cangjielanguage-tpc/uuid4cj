/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid4cj

public abstract class NoArgGenerator <: UUIDGenerator{

    /**
     * generate uuid
     */
    public func generate():UUID

}

