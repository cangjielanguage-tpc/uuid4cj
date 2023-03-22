/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

package uuid

public enum UUIDType{

    | TIME_BASED
    | DCE
    | NAME_BASED_MD5
    | RANDOM_BASED
    | NAME_BASED_SHA1
    | TIME_BASED_REORDERED
    | TIME_BASED_EPOCH
    | FREE_FORM
    | UNKNOWN


    public func raw():Int64{
        match(this){
            case TIME_BASED => return 1
            case DCE => return 2
            case NAME_BASED_MD5 => return 3
            case RANDOM_BASED => return 4
            case NAME_BASED_SHA1 => return 5
            case TIME_BASED_REORDERED => return 6
            case TIME_BASED_EPOCH => return 7
            case FREE_FORM => return 8
            case UNKNOWN => return 0
        }
    }

}
