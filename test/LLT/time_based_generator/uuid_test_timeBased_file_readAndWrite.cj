
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*
from std import fs.*
from std import format.Formatter


main() {  

    let filePath: Path = Path("./uuuu_write.txt")
    var file1: File 
    if (File.exists(filePath)) {
        file1 = File(filePath, OpenOption.Open(true, true))
    } else {
        file1 = File(filePath, OpenOption.Create(true))
    }

    var mFile: LockedFile = LockedFile(file1)
  
    mFile.writeStamp(1681287539666 +  10 * 1000)
    file1.close()

    var file2: File = File(filePath, OpenOption.Open(true, true))

    var mFile2: LockedFile = LockedFile(file2)

    var result: Int64 = mFile2.readStamp()

    file2.close()
    if (result != 1681287549666) {
        return -1
    }

    return 0
}