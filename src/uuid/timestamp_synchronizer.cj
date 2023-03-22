/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public abstract class TimestampSynchronizer{

    protected init(){

    }

    protected func initialize():Int64

    protected func deactivate():Unit

    protected func update(now:Int64):Int64


}
