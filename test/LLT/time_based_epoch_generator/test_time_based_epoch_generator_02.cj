// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.random.*

main() {    
    var uuid: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator(Random())
    uuid.generate()
    if(uuid.getType().raw() != 7) {
        return -1
    }
    return 0
}

