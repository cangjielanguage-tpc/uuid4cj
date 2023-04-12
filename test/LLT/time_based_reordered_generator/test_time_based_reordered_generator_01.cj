// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from std import random.*

main() {    
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator()
    uuid.generate()
    if(uuid.getType().raw() != 6) {
        return -1
    }
    return 0
}

