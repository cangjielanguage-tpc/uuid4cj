
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import stdx.crypto.crypto.SecureRandom
import std.random.*

main() {  

    let _random: Random = Random()
    let b: RandomBasedGenerator = Generators.randomBasedGenerator(_random)
    let uuid: UUID = b.generate()

    if(uuid.version() != 4) {
        return -1
    }

    if(b.getType().raw() != 4) {
        return -2
    }
    return 0
    
}
