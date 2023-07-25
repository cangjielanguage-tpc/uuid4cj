
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid4cj import uuid4cj.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  

    let a: TimeBasedGenerator = Generators.timeBasedGenerator()
    let uuid: UUID = a.generate()
    
    let uuid2: UUID = a.generate()

    let uuid3: UUID = a.generate()

    let var1 = uuid.getMostSignificantBits() == uuid2.getMostSignificantBits()

    let var2 = uuid.getMostSignificantBits() == uuid3.getMostSignificantBits()

    let var3 = uuid2.getMostSignificantBits() == uuid3.getMostSignificantBits()
    if (var1 || var2 || var3) {
        return -1
    }

    let var4 = uuid.getLeastSignificantBits() != uuid2.getLeastSignificantBits()

    let var5 = uuid.getLeastSignificantBits() != uuid3.getLeastSignificantBits()

    let var6 = uuid2.getLeastSignificantBits() != uuid3.getLeastSignificantBits()

    if (var4 || var5 || var6) {
        return -2
    }

    return 0
}

