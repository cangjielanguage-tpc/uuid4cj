
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let a: TimeBasedGenerator = Generators.timeBasedGenerator()
    let uuid: UUID = a.generate()

    if(uuid.version() != 1) {
        return -1
    }
    return 0
}