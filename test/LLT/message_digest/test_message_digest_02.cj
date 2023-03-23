// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from encoding import hex.*

main() {    
    let message: String = "helloworld"
    let messageDigest: MessageDigest = MessageDigest(DigestType.SHA1)
    let ret: Array<UInt8> = messageDigest.digest(message.toUtf8Array())
    if(toHexString(ret) != "6adfb183a4a2c94a2f92dab5ade762a47889a5a1") {
        return -1
    }
    return 0
}

