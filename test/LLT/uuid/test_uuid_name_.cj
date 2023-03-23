// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    let name: Array<UInt8> = "helloworld".toUtf8Array()
    let uuid = UUID.nameUUIDFromBytes(name)
    let least = uuid.getLeastSignificantBits()
    let most = uuid.getMostSignificantBits()
    if(uuid.toString() != "fc5e038d-38a5-3032-8854-41e7fe7010b0" ||
        least != -8623194921845649232 ||
        most != -261767823265288142) {
        return -1
    }

    return 0
}

