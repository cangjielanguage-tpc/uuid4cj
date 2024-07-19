
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import crypto.crypto.SecureRandom
import std.random.*

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
