
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let a: TimeBasedGenerator = Generators.timeBasedGenerator()
    let uuid: UUID = a.generate()

    if(a.getEthernetAddress().toLong() == 0) {
        return -3
    }

    if(a.getType().raw() != 1) {
        return -4
    }

    if(uuid.version() != 1) {
        return -1
    }
    if(uuid.variant() != 2) {
        return -2
    }
    return 0
}