// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*

main() {    
    var src: Array<String> = [
        "7ef7c38a-bb6e-11e3-9e8f-000000000000",
        "7f905a0b-bb6e-11e3-9e8f-000000000000",
        "8028f08c-bb6e-11e3-9e8f-000000000000",
        "80c1870d-bb6e-11e3-9e8f-000000000000"
    ]
    for(i in 0..(src.size - 1)) {
        var u1 = UUID.fromString(src[i])
        var u2 = UUID.fromString(src[i + 1])
        var x: Int32 = UUIDComparator.compare(u1, u2)
        if(x >= 0) {
            println("Entry # ${i} should have value < 0, had ${x}")
        }
        var y: Int32 = UUIDComparator.compare(u2,u1)
        if(y <= 0) {
            println("Entry # ${i} should have value < 0, had ${x}")
        }
    }
    return 0
}

