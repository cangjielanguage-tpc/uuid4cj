// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from encoding import hex.*

main() {    
    let message: String = "helloworld"
    let messageDigest: MessageDigest = MessageDigest(DigestType.MD5)
    let ret: Array<UInt8> = messageDigest.digest(input: message.toUtf8Array())
    if(toHexString(ret) != "fc5e038d38a57032085441e7fe7010b0" ||
      messageDigest.getAlgorithm().toString() != "MD5") {
        return -1
    }
    return 0
}

