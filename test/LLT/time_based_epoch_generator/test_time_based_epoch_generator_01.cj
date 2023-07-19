// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var uuid: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator()
    uuid.generate()
    if(uuid.getType().raw() != 7) {
        return -1
    }
    return 0
}

