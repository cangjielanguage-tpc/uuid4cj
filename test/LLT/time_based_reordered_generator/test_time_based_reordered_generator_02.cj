// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*

main() {    
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var uuid: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address)
    uuid.generate()
    if(uuid.getType().raw() != 6) {
        return -1
    }
    return 0
}

