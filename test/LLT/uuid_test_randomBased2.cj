
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  

    let _random: Random = Random()
    let b: RandomBasedGenerator = Generators.randomBasedGenerator(_random)
    let uuid: UUID = b.generate()

    if(uuid.version() != 4) {
        return -1
    }
    return 0
    
}