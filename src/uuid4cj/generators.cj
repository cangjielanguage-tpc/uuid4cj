/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package uuid4cj

/*
 * The class is UUID generators
 * @since 0.37.2
 */
public class Generators{

    protected static var _sharedTimer = Option<UUIDTimer>.None

    /**
     * Factory method for constructing UUID generator that uses default (shared)
     * random number generator for constructing UUIDs according to standard
     * method number 4.
     * 
     * @return RandomBasedGenerator
     */
    public static func randomBasedGenerator():RandomBasedGenerator{
        return  RandomBasedGenerator(LazyRandom.sharedSecureRandom())
    }

    /*
     * Factory method for constructing UUID generator that uses specified
     * random number generator for constructing UUIDs according to standard
     * method number 4.
     *
     * @param rnd - Random to use
     * @return RandomBasedGenerator
     */
    public static func randomBasedGenerator(rnd: Random):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd)
    }

    /*
     * Factory method for constructing UUID generator that uses specified
     * random number generator for constructing UUIDs according to standard
     * method number 4.
     *
     * @param rnd - SecureRandom to use
     * @return RandomBasedGenerator
     */
    public static func randomBasedGenerator(rnd: SecureRandom):RandomBasedGenerator{
        return  RandomBasedGenerator(rnd)
    }

    /*
     * Factory method for constructing UUID generator that uses specified
     * random number generator for constructing UUIDs according to standard
     * method number 5, but without using a namespace.
     * Digester to use will be SHA-1 as recommened by UUID spec.
     *
     * @return NameBasedGenerator
     */
    public static func nameBasedGenerator(): NameBasedGenerator {
        return NameBasedGenerator(Option<UUID>.None, Option<MessageDigest>.None, Option<UUIDType>.None)
    }

    /**
     * Factory method for constructing UUID generator that uses specified
     * random number generator for constructing UUIDs according to standard
     * method number 5, with specified namespace (or without one if null
     * is specified).
     * Digester to use will be SHA-1 as recommened by UUID spec.
     * 
     * @param namespace UUID that represents namespace to use; see
     *   {@link NameBasedGenerator} for 'standard' namespaces specified by
     *   UUID specs
     * @return NameBasedGenerator
     */
    public static func nameBasedGenerator(namespace: UUID): NameBasedGenerator {
        return NameBasedGenerator(namespace, Option<MessageDigest>.None, Option<UUIDType>.None)
    }

    /**
     * Factory method for constructing UUID generator that uses specified
     * random number generator for constructing UUIDs according to standard
     * method number 3 or 5, with specified namespace (or without one if null
     * is specified), using specified digester.
     * If digester is passed as null, a SHA-1 digester will be constructed.
     * 
     * @param namespace UUID that represents namespace to use; see
     *   {@link NameBasedGenerator} for 'standard' namespaces specified by
     *   UUID specs
     * @param digester Digester to use; should be a MD5 or SHA-1 digester.
     * @return NameBasedGenerator
     */
    public static func nameBasedGenerator(namespace: UUID, digester: MessageDigest): NameBasedGenerator {
        return NameBasedGenerator(namespace, digester, Option<UUIDType>.None)
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 1 (time+location based).
     *
     * using specified Ethernet address
     * No additional external synchronization is used.
     *
     * @return TimeBasedGenerator
     */
    public static func timeBasedGenerator():TimeBasedGenerator{
        return  timeBasedGenerator(Option<EthernetAddress>.None);
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 1 (time+location based).
     *
     * using specified Ethernet address
     * No additional external synchronization is used.
     *
     * @param ethernetAddress - Option<EthernetAddress>
     * @return TimeBasedGenerator
     */
    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>):TimeBasedGenerator{
        return timeBasedGenerator(ethernetAddress, Option<UUIDTimer>.None)
    }
    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 1 (time+location based).
     *
     * using specified Ethernet address
     * specified FileBasedTimestampSynchronizer instance
     *
     * @param ethernetAddress - Option<EthernetAddress>
     * @param timer - Option<FileBasedTimestampSynchronizer>
     * @return TimeBasedGenerator
     */
    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, sync: Option<FileBasedTimestampSynchronizer>):TimeBasedGenerator{
        var timer: UUIDTimer

        try {
            timer = UUIDTimer(SecureRandom(), sync)
        } catch (e: FSException | IllegalArgumentException) {
            throw InterruptedException("Failed to create UUIDTimer with specified synchronizer: " + e.toString())
        }
        
        return  timeBasedGenerator(ethernetAddress, timer);
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 1 (time+location based). 
     *
     * using specified Ethernet address
     * specified UUIDTimer instance
     *
     * @param ethernetAddress - Option<EthernetAddress>
     * @param timer - Option<UUIDTimer>
     * @return TimeBasedGenerator
     */
    public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, timer: Option<UUIDTimer>):TimeBasedGenerator{
        let timerTT = match (timer) {
            case Some(_) => timer
            case None => sharedTimer()
        }
        return  TimeBasedGenerator(ethernetAddress, timerTT.getOrThrow());
    }

    private static func sharedTimer(): Option<UUIDTimer> {
        try {
            _sharedTimer = match (_sharedTimer) {
                case Some(_) => _sharedTimer
                case None => UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None);
            }
        } catch (e: IllegalArgumentException) {
            throw InterruptedException("Failed to create UUIDTimer with specified synchronizer: " + e.toString())
        }

        return _sharedTimer;
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 7 (Unix Epoch time+random based).
     *
     * @return TimeBasedEpochGenerator
     */
    public static func timeBasedEpochGenerator(): TimeBasedEpochGenerator {
        return TimeBasedEpochGenerator()
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 7 (time+random based), using specified Ethernet address
     * as the location part of UUID.
     * No additional external synchronization is used.
     *
     * @param random - Random
     * @return TimeBasedEpochGenerator
     */
    public static func timeBasedEpochGenerator(random: Random): TimeBasedEpochGenerator {
        return TimeBasedEpochGenerator(random)
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 6 (time+location based, reordered for DB locality).
     *
     * @return TimeBasedReorderedGenerator
     */
    public static func timeBasedReorderedGenerator(): TimeBasedReorderedGenerator {
        return TimeBasedReorderedGenerator(Option<EthernetAddress>.None, sharedTimer().getOrThrow())
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 6 (time+location based, reordered for DB locality), using specified
     * Ethernet address as the location part of UUID. No additional external
     * synchronization is used.
     *
     * @param ethernetAddress - Ethernet address
     * @return TimeBasedReorderedGenerator
     *
     */
    public static func timeBasedReorderedGenerator(ethernetAddress: EthernetAddress): TimeBasedReorderedGenerator{
        return TimeBasedReorderedGenerator(ethernetAddress, sharedTimer().getOrThrow())
    }

    /**
     * Factory method for constructing UUID generator that generates UUID using
     * variant 6 (time+location based, reordered for DB locality), using specified
     * Ethernet address as the location part of UUID
     *
     * @param ethernetAddress - Ethernet address
     * @param timer - UUIDTimer
     * @return TimeBasedReorderedGenerator 
     */
    public static func timeBasedReorderedGenerator(ethernetAddress: EthernetAddress, timer: UUIDTimer): TimeBasedReorderedGenerator {
        return TimeBasedReorderedGenerator(ethernetAddress, timer)
    }

}

