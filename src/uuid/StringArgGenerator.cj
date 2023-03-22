/**
 * Intermediate base class for UUID generators that take one String argument for individual
 * calls. This includes name-based generators, but not random and time-based generators.
 * 
 * @since 3.0
 */

 
package uuid

public abstract class StringArgGenerator <: UUIDGenerator {

    /**
     * Method for generating name-based UUIDs using specified name (serialized to
     * bytes using UTF-8 encoding)
     */
    public func generate(name: String): UUID;

    /**
     * Method for generating name-based UUIDs using specified byte-serialization
     * of name.
     * 
     * @since 3.1
     */
    public func generate(nameByte: Array<Byte>): UUID;

}