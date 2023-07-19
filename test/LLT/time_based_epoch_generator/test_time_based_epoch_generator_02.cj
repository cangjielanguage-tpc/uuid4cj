// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from std import random.*

main() {    
    var uuid: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator(Random())
    uuid.generate()
    if(uuid.getType().raw() != 7) {
        return -1
    }
    return 0
}

