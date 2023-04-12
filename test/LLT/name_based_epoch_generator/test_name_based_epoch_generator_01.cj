// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {    
    var uuid: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator()
    uuid.generate()
    if(uuid.getType().raw() != 7) {
        return -1
    }
    return 0
}

