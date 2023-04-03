
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let _sRandom: SecureRandom = LazyRandom.sharedSecureRandom();
    let a: RandomBasedGenerator = Generators.randomBasedGenerator(_sRandom)
    let uuid: UUID = a.generate()

    if(uuid.version() != 4) {
        return -1
    }

    if(a.getType().raw() != 4) {
        return -2
    }
    return 0
}
