
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
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

    if ((uuid.getMostSignificantBits() == uuid2.getMostSignificantBits()) 
        || (uuid.getMostSignificantBits() == uuid3.getMostSignificantBits())
        || (uuid2.getMostSignificantBits() == uuid3.getMostSignificantBits()) ) {
        return -1
    }

    if ((uuid.getLeastSignificantBits() != uuid2.getLeastSignificantBits())
        || (uuid.getLeastSignificantBits() != uuid3.getLeastSignificantBits())
        || (uuid2.getLeastSignificantBits() != uuid3.getLeastSignificantBits()) ) {
        return -2
    }

    return 0
}

