// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import uuid4cj.uuid4cj.*
import std.convert.Formattable
import crypto.crypto.SecureRandom
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main() {    
    let uuidTest = UUIDTest()
    uuidTest.test1()
    uuidTest.test2()
    uuidTest.test3()
    uuidTest.test4()
    uuidTest.test5()
    uuidTest.test6()
    uuidTest.test7()
    uuidTest.test8()
    uuidTest.test9()
    uuidTest.test10()
    uuidTest.test11()
    uuidTest.test12()
    uuidTest.test13()
    uuidTest.test14()
}


@Test
public class UUIDTest {

    @TestCase
    public func test1(): Unit {
        let uuid = UUID.nilUUID()
        let uuid2 = UUID(Array(16, repeat: 0xff))

        @Assert(uuid.toString(), "00000000-0000-0000-0000-000000000000")
        @Assert(uuid2.toString(), "ffffffff-ffff-ffff-ffff-ffffffffffff")
    }

    @TestCase
    public func test2(): Unit {
        let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        @Assert(uuid.clockSequence(), 8813)
        
    }

    @TestCase
    public func test3(): Unit {
        let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        let uuid2 = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        let uuid3 = UUID.fromString("35a83239-c3dc-11ed-ba36-bd215a723aba")

        @Assert(uuid.equals(uuid2), true)
        @Assert(uuid.equals(uuid3), false)

    }

    @TestCase
    public func test4(): Unit {
        try {
            UUID.fromString("b053e9b3-c1f2-444b-9299")
        }catch(e: IllegalArgumentException) {
            @Assert(e.toString(), "IllegalArgumentException: Invalid UUID string: b053e9b3-c1f2-444b-9299")
        }
    }

    @TestCase
    public func test5(): Unit {
        let uuid = UUID.fromString("b053e9b3-c1f2-444b-9299-df2c236b23c1")
        @Assert(uuid.toString(), "b053e9b3-c1f2-444b-9299-df2c236b23c1")
    }

    @TestCase
    public func test6(): Unit {
        let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        @Assert(uuid.node(), 149231404870569)
    }

    @TestCase
    public func test7(): Unit {
        let uuid = UUID.randomUUID()
        @Assert(uuid.version(), 4)
    }

    @TestCase
    public func test8(): Unit {
        let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        @Assert(uuid.timestamp(), 138982512999560123)
    }

    @TestCase
    public func test9(): Unit {
        let uuid = UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba9")
        @Assert(uuid.variant(), 2)
    }

    @TestCase
    public func test10(): Unit {
        let name = "398f00f4-208b-11ee-bac3-7f13f714b88c"

        let uuid = UUID.fromString(name)
        @Assert(uuid.variant(), 2)
        @Assert(uuid.timestamp(), 139084420833280244)
        @Assert(uuid.clockSequence(), 15043)
        @Assert(uuid.version(), 1)
    }

    @TestCase
    public func test11(): Unit {
        let name = "398f00f4-208b-11ee-bac3-7f13f714b88c"

        let uuid = UUID.fromString(name)
        @Assert(uuid.toString(), "398f00f4-208b-11ee-bac3-7f13f714b88c")
        @Assert(uuid.node(), 139723726436492)
        @Assert(uuid.hashCode(), 450226856567941703)

    }

    @TestCase
    public func test12(): Unit {
        var arr: Array<Int8> = [57, 43, 0, 44, 32, 39, 17, 38, 86, 95, 27, 19, 47, 20, 84, 40]
        let uuid = UUID.nameUUIDFromBytes(arr)

        @Assert(uuid.version(), 3)
        @Assert(uuid.variant(), 2)
    }

    @TestCase
    public func test13(): Unit {
        var arr: Array<UInt8> = [57, 43, 0, 44, 32, 39, 17, 38, 86, 95, 27, 19, 47, 20, 84, 40, 66]
        try {
            UUID(arr)
        } catch(e: IllegalArgumentException) {
            @Assert(e.toString(), "IllegalArgumentException: data must be 16 bytes in length")
        }
    }

    @TestCase
    public func test14(): Unit {
        try {
            UUID.fromString("f55473bb-c3db-11ed-a26d-87b9a4e06ba966")
        } catch(e: IllegalArgumentException) {
            @Assert(e.toString(), "IllegalArgumentException: Invalid UUID string: f55473bb-c3db-11ed-a26d-87b9a4e06ba966")
        }
        
    }

}