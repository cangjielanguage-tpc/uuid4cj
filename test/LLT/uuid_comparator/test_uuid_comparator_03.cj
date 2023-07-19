// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var u1: UUID = Generators.timeBasedEpochGenerator().generate()
    var u2: UUID = Generators.timeBasedEpochGenerator().generate()
    var diff: Int32 = UUIDComparator.compare(u1, u2)
    if(diff == 0) {
        return -1
    }
    return 0
}

