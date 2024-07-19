// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    var s: Array<Int8> = [104, 101, 108, 108, 111, 119, 111, 114, 108, 100, 115, 100, 102, 115, 103, 115, 116, 103, 119, 103, 115, 103, 115, 103, 102, 115, 103, 101, 114]
    var uuid = UUIDUtil.uuid(s, 1).toString()
    var uuid2 = UUIDUtil.uuid(s, 13).toString()
    if(uuid != "656c6c6f-776f-726c-6473-646673677374") {
        return -1
    }
    if(uuid2 != "73677374-6777-6773-6773-676673676572") {
        return -2
    }
    return 0
}

