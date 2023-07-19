// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from encoding import hex.*

main() {    
    let messageDigest1: MessageDigest = MessageDigest(DigestType.MD5)
    let messageDigest2: MessageDigest = MessageDigest(DigestType.SHA1)
    if(
        messageDigest1.getAlgorithm().toString() != "MD5" ||
        messageDigest2.getAlgorithm().toString() != "SHA1"
    ) {

    }
    return 0
}

