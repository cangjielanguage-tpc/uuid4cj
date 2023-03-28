// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from encoding import hex.*

main() {    
    let message: String = "helloworld"
    let message2: String = "djhskafhfkhlafkla"
    let messageDigest: MessageDigest = MessageDigest(DigestType.SHA1)
    messageDigest.update(message.toUtf8Array())
    messageDigest.update(message2.toUtf8Array())
    let ret: Array<UInt8> = messageDigest.digest()
    if(toHexString(ret) != "2fc845444ab8073f64381521eb9e1f64a8c1da2e") {
        return -1
    }   
    return 0
}

