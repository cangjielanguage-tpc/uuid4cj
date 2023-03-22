// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
    println(uuid.version())
    println(uuid.variant())
    println(uuid.node())
    println(uuid.hashCode())
    println(uuid.getLeastSignificantBits())
    println(uuid.getMostSignificantBits())
    println(uuid.timestamp())
    println(uuid.clockSequence())
    if(uuid.toString() != "f55473bb-c3db-11ed-a26d-87b9a4e06ba9") {
        return -1
    }
    return 0
}

