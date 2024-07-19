// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.random.*

main() {    
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator()
    uuid.generate()
    if(uuid.getType().raw() != 6) {
        return -1
    }
    return 0
}

