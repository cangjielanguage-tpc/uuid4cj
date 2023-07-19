
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let c: RandomBasedGenerator = Generators.randomBasedGenerator()
    let uuid: UUID = c.generate()

    if(uuid.version() != 4) {
        return -1
    }

    if(c.getType().raw() != 4) {
        return -2
    }
    return 0
}
