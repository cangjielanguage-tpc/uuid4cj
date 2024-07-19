// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")

    let s: Array<UInt8> = uuid.getBytes()
    let s1: Array<UInt8> = [245, 84, 115, 187, 195, 219, 17, 237, 162, 109, 135, 185, 164, 224, 107, 169]
    var isEquals = true
    for( i in 0..s.size) {
        if (s[i] != s1[i]) {
            isEquals = false
            break
        }
    }

    if(!isEquals) {
        return -1
    }
    return 0
}

