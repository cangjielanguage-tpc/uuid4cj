// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    let uuid = UUID.fromString("b053e9b3-c1f2-444b-9299-df2c236b23c1")
    println(uuid.version())
    println(uuid.variant())
    //println(uuid.node())
    println(uuid.hashCode())
    println(uuid.getLeastSignificantBits())
    println(uuid.getMostSignificantBits())
    if(uuid.toString() != "b053e9b3-c1f2-444b-9299-df2c236b23c1") {
        return -1
    }
    return 0
}

