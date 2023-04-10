// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from std import random.*

main() {    
    var uuid: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator(Random())
    if(uuid.getType().raw() != 7) {
        return -1
    }
    return 0
}

