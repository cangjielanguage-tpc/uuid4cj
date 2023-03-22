from uuid import uuid.*
from std import unittest.testmacro.{Assert, Test, TestCase}

@Test
public class UUIDTest {
    @TestCase
    func should_return_corrct_version(): Unit {
        let uuid = UUID.randomUUID()
        @Assert( 4, uuid.version())
    }

    @TestCase
    func should_return_corrct_variant(): Unit {
        let uuid = UUID.randomUUID()
        @Assert( 1, uuid.variant())
    }
}
