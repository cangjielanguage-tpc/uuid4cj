// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from encoding import hex.*

main() {    
    let message: String = ""
    let messageDigest: MessageDigest = MessageDigest(DigestType.SHA1)
    
    try {
        let ret: Array<UInt8> = messageDigest.digest(message.toUtf8Array())
    }catch(e: UUIDException) {
        if(!e.toString().contains("The input cannot be empty!")) {
            return -1
        }
        return 0
    }
    return -2
}

