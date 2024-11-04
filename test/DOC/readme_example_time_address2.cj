// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.unittest.*
import std.unittest.testmacro.*
import crypto.crypto.SecureRandom
import std.random.*
import std.time.*
import std.fs.*
import std.format.Formatter

main() {   
    let testReadmeExample = TestReadmeExample()
    testReadmeExample.test1()
    return 0
}

@Test
public class TestReadmeExample {
    @TestCase
    public func test1(): Unit {
        let filePath1: String = "./ggg_readTest.txt"

        var file1: File = openFile(filePath1)


        let filePath2: String = "./zzz_readTest.txt"

        var file2: File = openFile(filePath2)


        var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)
        var ethernetAddress: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")

        let a: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress, oFile)

        let b: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, Option<FileBasedTimestampSynchronizer>.None)

        let uuid: UUID = a.generate()

        let uuid2: UUID = b.generate()

        file1.close()
        file2.close()

        // readStamp

        var file3: File = openFile(filePath1)

        var file4: File = openFile(filePath2)
        var oFileNew: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file3, file4)

        let c: TimeBasedGenerator = Generators.timeBasedGenerator(Option<EthernetAddress>.None, oFileNew)
        c.generate()


        @Assert(1, uuid.version())
        @Assert(1, uuid2.version())
        
    }

    public func openFile (filePath: String): File {
        var file: File

        if (exists(filePath)) {
            file = File(filePath, OpenOption.Open(true, true))
        } else {
            file = File(filePath, OpenOption.Create(true))
        }
        return file
    }
}

