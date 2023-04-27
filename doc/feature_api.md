# UUID4CJ库

## 介绍

UUID 全称：Universally Unique Identifier，即通用唯一识别码， 定义为一个字符串主键，采用 32 位数字组成，编码采用 16 进制，定义了在时间和空间都完全唯一的系统信息。 

UUID 的标准格式：xxxxxxxx-xxxx-Axxx-Bxxx-xxxxxxxxxxxx ，形式为 8-4-4-4-12 的 32 个字符，如：550e8400-e29b-41d4-a716-446655440000。

## 1 java-uuid-generator 基于多种方式，生成的 uuid 唯一值

前置条件：NA 

场景：

1. 基于当前时间戳、随机数和机器MAC地址
2. 基于名字
3. 基于随机数
4. 基于数据库
5. 基于时间纪元

约束：NA

依赖：

1. 仓颉标准库的 SecureRandom
2. 三方库 cryptocj 的 MD5、SHA1
3. 三方库 charset

性能： NA

可靠性： NA

### 1.1 UUIDType 为 3 —— 基于名字 MD5 加密生成唯一 UUID

利用 MessageDigest 的 MD5 算法对指定字符串生成摘要，利用摘要值生成唯一 UUID。

#### 1.1.1 主要接口

```cangjie
/**
 * 构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 UUIDType 为 3 构造 UUID，
 * 具有指定的命名空间，使用指定的 MD5 摘要。
 * 
 * 参数 namespace - 命名空间的 UUID，可选：
 *                   NAMESPACE_DNS，NAMESPACE_URL，NAMESPACE_OID，NAMESPACE_X500
 * 参数 digester - MD5 摘要
 * 返回值 NameBasedGenerator - 基于名字的生成器
 */
public static func nameBasedGenerator(namespace: UUID, digester: MessageDigest): NameBasedGenerator
```

#### 1.1.2 示例

```cangjie
from uuid import uuid.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var name: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.MD5))
    let uuid: UUID = name.generate("helloworld")
    println("UUIDType: ${name.getType().raw()}")
    println("基于MD5摘要生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 3
基于MD5摘要生成的UUID: c464cb54-da68-36d5-a15b-6ebbd2bd02ec
```
### 1.2 UUIDType 为 5 —— 基于名字 SHA1 加密生成唯一 UUID

利用 MessageDigest 的 SHA1 算法对指定字符串生成摘要，利用摘要值生成唯一 UUID。

#### 1.2.1 主要接口

```cangjie
/**
 * 用于构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 UUIDType 为 5 构造UUID，
 * 但不使用命名空间。默认使用的 Digester 将为 SHA1。
 * 
 * 返回值 NameBasedGenerator - 基于名字的生成器
 */
public static func nameBasedGenerator(): NameBasedGenerator

/**
 * 用于构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器根据标准方法 5 构造 UUID，
 * 具有指定的命名空间,默认使用的 Digester 为 SHA-1。
 * 
 * 参数 namespace - 命名空间的 UUID，可选：
 *                   NAMESPACE_DNS，NAMESPACE_URL，NAMESPACE_OID，NAMESPACE_X500
 * 返回值 NameBasedGenerator - 基于名字的生成器
 */
public static func nameBasedGenerator(namespace: UUID): NameBasedGenerator

/**
 * 构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 5 构造 UUID，
 * 具有指定的命名空间，使用指定的 SHA1 摘要。
 * 
 * 参数 namespace - 命名空间的 UUID，可选：
 *                   NAMESPACE_DNS，NAMESPACE_URL，NAMESPACE_OID，NAMESPACE_X500
 * 参数 digester - SHA1 摘要
 * 返回值 NameBasedGenerator - 基于名字的生成器
 */
public static func nameBasedGenerator(namespace: UUID, digester: MessageDigest): NameBasedGenerator

```

#### 1.2.2 示例

##### 1.2.2.1 Generators.nameBasedGenerator() 使用示例

```cangjie
from uuid import uuid.*

main() {   
    var name: NameBasedGenerator = Generators.nameBasedGenerator()
    let uuid: UUID = name.generate("helloworld")
    println("UUIDType: ${name.getType().raw()}")
    println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 5
基于SHA1摘要生成的UUID: 6adfb183-a4a2-594a-af92-dab5ade762a4
```

##### 1.2.2.2 Generators.nameBasedGenerator(namespace: UUID) 使用示例

```cangjie
from uuid import uuid.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var name: NameBasedGenerator = Generators.nameBasedGenerator(namespace)
    let uuid: UUID = name.generate("helloworld")
    println("UUIDType: ${name.getType().raw()}")
    println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 5
基于SHA1摘要生成的UUID: 4684684f-d5ae-5e83-95e4-adecc6bb2135
```

##### 1.2.2.3 Generators.nameBasedGenerator(namespace: UUID, digester: MessageDigest) 使用示例

```cangjie
from uuid import uuid.*

main() {   
    var namespace: UUID = NameBasedGenerator.NAMESPACE_DNS
    var name: NameBasedGenerator = Generators.nameBasedGenerator(namespace, MessageDigest(DigestType.SHA1))
    let uuid: UUID = name.generate("helloworld")
    println("UUIDType: ${name.getType().raw()}")
    println("基于SHA1摘要生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 5
基于SHA1摘要生成的UUID: 4684684f-d5ae-5e83-95e4-adecc6bb2135
```
### 1.3 UUIDType 为 4 —— 基于随机数 加密生成唯一 UUID

利用 Random类或者SecureRandom类提供的随机数 对指定字符串生成摘要，利用摘要值生成唯一 UUID。

#### 1.3.1 主要接口

```cangjie
/**
 * 构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 UUIDType 为 4 构造 UUID，
 * 默认使用crypto包提供用于生成加密安全的伪随机数类 SecureRandom。
 * 
 * 返回值 RandomBasedGenerator- 基于随机数的生成器
 */
public static func randomBasedGenerator(): RandomBasedGenerator
```
```cangjie
/**
 * 构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 UUIDType 为 4 构造 UUID，
 * 使用random 包提供用于生成伪随机数的类 Random。
 * 
 * 参数 rnd- Random对象
 * 返回值 RandomBasedGenerator- 基于随机数的生成器
 */
public static func randomBasedGenerator(rnd: Random): RandomBasedGenerator
```
```cangjie
/**
 * 构造 UUID 生成器的工厂方法，该方法使用指定的随机数生成器，根据标准方法 UUIDType 为 4 构造 UUID，
 * 使用crypto包提供用于生成加密安全的伪随机数类 SecureRandom。
 * 
 * 参数 rnd- SecureRandom对象
 * 返回值 RandomBasedGenerator- 基于随机数的生成器
 */
public static func randomBasedGenerator(rnd: SecureRandom): RandomBasedGenerator
```

#### 1.3.2 示例
##### 1.3.2.1 randomBasedGenerator() 使用示例
```cangjie
from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let c: RandomBasedGenerator = Generators.randomBasedGenerator()
    let uuid: UUID = c.generate()

    if(uuid.version() != 4) {
        return -1
    }

    if(c.getType().raw() != 4) {
        return -2
    }
    return 0
}
```
执行结果如下：

```
UUIDType: 4
基于SecureRandom随机生成的UUID: 1c290f65-05c7-4426-a90f-6505c7f426e6
```
##### 1.3.2.2 randomBasedGenerator(rnd: Random) 使用示例
```cangjie
from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  

    let _random: Random = Random()
    let b: RandomBasedGenerator = Generators.randomBasedGenerator(_random)
    let uuid: UUID = b.generate()
    println("基于Random随机生成的UUID: ${uuid.toString()}")
    if(uuid.version() != 4) {
        return -1
    }
    return 0
    
}
```
执行结果如下：

```
UUIDType: 4
基于Random随机生成的UUID: c259ecfd-bbf0-4e28-8ea2-03d10194b80a
```
##### 1.3.2.3 randomBasedGenerator(rnd: SecureRandom) 使用示例
```cangjie
from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*

main() {  
    
    let _sRandom: SecureRandom = LazyRandom.sharedSecureRandom();
    let a: RandomBasedGenerator = Generators.randomBasedGenerator(_sRandom)
    let uuid: UUID = a.generate()
    println("基于SecureRandom随机生成的UUID: ${uuid.toString()}")
    if(uuid.version() != 4) {
        return -1
    }
    return 0
}
```
执行结果如下：

```
UUIDType: 4
基于SecureRandom随机生成的UUID: 1c290f65-05c7-4426-a90f-6505c7f426e6
```

### 1.4 UUIDType 为 6 —— 基于时间的重新排序生成唯一 UUID

使用基于时间/位置生成的 UUID 的生成器的实现，重新排序以改进数据库局部性。

#### 1.4.1 主要接口

```cangjie
/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 返回值 TimeBasedReorderedGenerator- 基于时间的重新排序生成器
 */
public static func timeBasedReorderedGenerator(): TimeBasedReorderedGenerator

/**
 * 使用硬件地址构造 UUID 生成器的工厂方法
 * 
 * 参数 ethernetAddress- EthernetAddress对象，用于生成硬件地址
 * 返回值 TimeBasedReorderedGenerator- 基于时间的重新排序生成器
 */
public static func timeBasedReorderedGenerator(ethernetAddress: EthernetAddress): TimeBasedReorderedGenerator

/**
 * 使用硬件地址和时间构造 UUID 生成器的工厂方法
 * 
 * 参数 ethernetAddress- EthernetAddress 对象，用于生成硬件地址
 * 参数 timer- UUIDTimer 对象，用于生成时间
 * 返回值 TimeBasedReorderedGenerator- 基于时间的重新排序生成器
 */
public static func timeBasedReorderedGenerator(ethernetAddress: EthernetAddress, timer: UUIDTimer): TimeBasedReorderedGenerator
```

#### 1.4.2 示例
##### 1.4.2.1 timeBasedReorderedGenerator() 使用示例

```cangjie
from uuid import uuid.*

main() {  
    var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator()
    let uuid: UUID = time.generate()
    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 6
生成的UUID: 1eddccb0-d3a9-6c62-aa57-558bc85f0a6d
```

##### 1.4.2.2 timeBasedReorderedGenerator(ethernetAddress: EthernetAddress) 使用示例

```cangjie
from uuid import uuid.*

main() {  
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address)
    var uuid: UUID = time.generate()
    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 6
生成的UUID: 1eddccc0-0829-64ae-aaf8-87f59306d30c
```

##### 1.4.2.3 timeBasedReorderedGenerator(ethernetAddress: EthernetAddress, timer: UUIDTimer) 使用示例

```cangjie
from uuid import uuid.*

main() {  
    var address: EthernetAddress = EthernetAddress("87:f5:93:06:D3:0C")
    var timer: UUIDTimer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
    var time: TimeBasedReorderedGenerator = Generators.timeBasedReorderedGenerator(address, timer)
    var uuid: UUID = time.generate()
    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 6
生成的UUID: 1eddccca-4e78-6aa5-96c5-87f59306d30c
```

### 1.5 UUIDType 为 7 —— 基于时间的纪元生成唯一 UUID

使用基于 Unix 纪元时间戳生成 UUID。

#### 1.4.1 主要接口

```cangjie
/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 返回值 TimeBasedEpochGenerator- 基于时间纪元生成器
 */
public static func timeBasedEpochGenerator(): TimeBasedEpochGenerator

/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 参数 random- Random 随机数
 * 返回值 TimeBasedEpochGenerator- 基于时间纪元生成器
 */
public static func timeBasedEpochGenerator(random: Random): TimeBasedEpochGenerator
```

#### 1.5.2 示例
##### 1.5.2.1 timeBasedEpochGenerator() 使用示例

```cangjie
from uuid import uuid.*

main() {  
    var time: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator()
    let uuid: UUID = time.generate()
    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 7
生成的UUID: 01878d39-54c2-7db7-aa02-cb98e6732ee4
```

##### 1.5.2.2 timeBasedEpochGenerator(ethernetAddress: EthernetAddress) 使用示例

```cangjie
from uuid import uuid.*
from std import random.*

main() {  
    var time: TimeBasedEpochGenerator = Generators.timeBasedEpochGenerator(Random())
    var uuid: UUID = time.generate()
    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 7
生成的UUID: 01878d39-58d2-7162-80e2-a635375f7673
```

### 1.6 UUIDType 为 1 —— 基于时间+默认地址生成唯一 UUID

基于时间+默认地址生成唯一 UUID。

#### 1.6.1 主要接口

```cangjie
/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 返回值 TimeBasedGenerator- 基于默认时间+默认地址生成器
 */
public static func timeBasedGenerator(): TimeBasedGenerator

/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 参数 ethernetAddress- Option<EthernetAddress> 地址类
 * 返回值 TimeBasedGenerator- 基于默认时间+地址
 */
public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>): TimeBasedGenerator

/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 参数 ethernetAddress- Option<EthernetAddress> 地址类
 * 参数 sync- Option<FileBasedTimestampSynchronizer> 使用文件来存储时间戳
 * 返回值 TimeBasedGenerator- 基于时间+地址生成器
 */
public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, sync: Option<FileBasedTimestampSynchronizer>): TimeBasedGenerator

/**
 * 构造 UUID 生成器的工厂方法
 * 
 * 参数 ethernetAddress- Option<EthernetAddress> 地址类
 * 参数 timer- Option<UUIDTimer> 时间戳管理类
 * 返回值 TimeBasedGenerator- 基于时间+默认地址生成器
 */ 
public static func timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, timer: Option<UUIDTimer>): TimeBasedGenerator
```

#### 1.6.2 示例
##### 1.6.2.1 timeBasedGenerator() 使用示例

```cangjie
from uuid import uuid.*

main() {  
    let time: TimeBasedGenerator = Generators.timeBasedGenerator()
    let uuid: UUID = time.generate()

    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 1
生成的UUID: 01878d39-54c2-7db7-aa02-cb98e6732ee4
```

##### 1.6.2.2 timeBasedGenerator(ethernetAddress: Option<EthernetAddress>) 使用示例

```cangjie
from uuid import uuid.*

main() {  
    var ethernetAddress1: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")
    let time: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1)
    let uuid: UUID = time.generate()

    println("UUIDType: ${time.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")
    return 0
}
```
执行结果如下：

```
UUIDType: 1
生成的UUID: 01878d39-54c2-7db7-aa02-cb98e6732ee4
```

##### 1.6.2.3 timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, sync: Option<FileBasedTimestampSynchronizer>) 使用示例

```cangjie
from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*
from std import fs.*
from std import format.Formatter

main() {  
    let filePath1: Path = Path("./ggg.txt")

    var file1: File

    if (File.exists(filePath1)) {
        file1 = File(filePath1, OpenOption.Open(true, true))
    } else {
        file1 = File(filePath1, OpenOption.Create(true))
    }

    let filePath2: Path = Path("./zzz.txt")

    var file2: File

    if (File.exists(filePath2)) {
        file2 = File(filePath2, OpenOption.Open(true, true))
    } else {
        file2 = File(filePath2, OpenOption.Create(true))
    }

    var oFile: Option<FileBasedTimestampSynchronizer> =  FileBasedTimestampSynchronizer(file1, file2)

    var ethernetAddress1: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")

    let a: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1, oFile)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1, Option<FileBasedTimestampSynchronizer>.None)

    let uuid: UUID = a.generate()

    let uuid2: UUID = b.generate()

    println("UUIDType: ${a.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")

    println("UUIDType: ${b.getType().raw()}")
    println("生成的UUID2: ${uuid2.toString()}")

    file1.close()
    file2.close()
    return 0
}
```
执行结果如下：

```
UUIDType: 1
生成的UUID: 01878d39-58d2-7162-80e2-a635375f7673

UUIDType: 1
生成的UUID2: 01878d39-58d2-7162-80e2-a635375f7674
```

##### 1.6.2.4 timeBasedGenerator(ethernetAddress: Option<EthernetAddress>, timer: Option<UUIDTimer>) 使用示例

```cangjie
from uuid import uuid.*
from crypto import crypto.SecureRandom
from std import random.*
from std import time.*

main() {
    var ethernetAddress1: Option<EthernetAddress> =  EthernetAddress("87:f5:93:06:d3:0c")

    var timer = UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None)
    let a: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1, timer)

    let b: TimeBasedGenerator = Generators.timeBasedGenerator(ethernetAddress1, Option<UUIDTimer>.None)


    let uuid: UUID = a.generate()

    let uuid2: UUID = b.generate()

    println("UUIDType: ${a.getType().raw()}")
    println("生成的UUID: ${uuid.toString()}")

    println("UUIDType: ${b.getType().raw()}")
    println("生成的UUID2: ${uuid2.toString()}")
    
    return 0
}
```
执行结果如下：

```
UUIDType: 1
生成的UUID: 01878d39-58d2-7162-80e2-a635375f7675

UUIDType: 1
生成的UUID2: 01878d39-58d2-7162-80e2-a635375f7676
```

## 2 其他接口

### 2.1 基础 UUID 类

```cangjie
public class UUID <: ToString {

    /**
     * 使用指定的数据构造一个 UUID
     *
     * 参数  mostSigBits- 最高有效64位
     * 参数  leastSigBits - 最低有效64位
     */
    public init(mostSigBits: Int64, leastSigBits: Int64)

    /**
     * 00000000-0000-0000-0000-000000000000
     *
     * 返回值  UUID
     */
    public static func nilUUID(): UUID

    /**
     * 用加密强伪随机数生成 UUID
     *
     * 返回值 UUID
     */
    public static func randomUUID(): UUID

    /**
     * 基于指定字节数组生成 UUID
     *
     * 参数 name - 用于构造 UUID 的字节数组
     * 返回值 UUID
     */
    public static func nameUUIDFromBytes(name: Array<Int8>): UUID

    /**
     * 根据 UUID 的 toString 方法中描述的字符串标准创建 UUID
     *
     * 参数 name - 指定 UUID 的字符串
     * 返回值  UUID
     */
    public static func fromString(name: String): UUID

    /**
     * 返回表示此 UUID 的 String 对象
     *
     * UUID 字符串各部分简述:
     * 
     * UUID                   = <time_low> "-" <time_mid> "-"
     *                          <time_high_and_version> "-"
     *                          <variant_and_sequence> "-"
     *                          <node>
     * time_low               = 4*<hexOctet>
     * time_mid               = 2*<hexOctet>
     * time_high_and_version  = 2*<hexOctet>
     * variant_and_sequence   = 2*<hexOctet>
     * node                   = 6*<hexOctet>
     * hexOctet               = <hexDigit><hexDigit>
     * hexDigit               =
     *       "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
     *       | "a" | "b" | "c" | "d" | "e" | "f"
     *       | "A" | "B" | "C" | "D" | "E" | "F"
     *
     * 返回值 String - UUID 的字符串表示形式
     */
    public func toString(): String

    /**
     * 返回此 UUID 的 128 位值中最低有效的 64 位
     *
     * 返回值 Int64 - 最低有效的 64 位
     */
    public func getLeastSignificantBits(): Int64

    /**
     * 返回此 UUID 的 128 位值的最高有效 64 位
     *
     * 返回值 Int64 - 最高有效 64 位
     */
    public func getMostSignificantBits(): Int64

    /**
     * 与此 UUID 关联的版本号，版本号描述了这个 UUID 是如何生成的。
     *
     * 版本号具有以下含义：
     * 
     * 1  Time-based UUID 基于时间戳生成
     * 3  Name-based UUID 基于命名空间和MD5散列算法
     * 4  Randomly generated UUID 基于随机数生成的
     * 5  Name-based UUID 基于命名空间和SHA1散列算法
     * 6  Time-based UUID 基于时间重新排序
     * 7  Time-based UUID 基于时间的纪元
     *
     * 返回值 Int32 - 此 UUID 的版本号
     */
    public func version(): Int32 

    /**
     * 返回 UUID 的变体值
     *
     * UUID 的变体描述了 UUID 的布局。变体值的可能值及意义如下：
     *
     * 2 - 变体2，保留，Microsoft Corporation 向后兼容性
     *
     * 返回值 Int32 - 此 UUID 的变体
     */
    public func variant(): Int32

    /**
     * 此 UUID 关联的时间戳值
     *
     * 返回值 Int64 - 此 UUID 关联的时间戳值
     */
    public func timestamp(): Int64  

    /**
     * 与此 UUID 关联的时钟序列值
     *
     * 14 位时钟序列值是由该 UUID 的时钟序列字段构成的
     * 时钟序列字段用于保证基于时间的 UUID 中的时间唯一性
     *
     * clockSequence 值只有在版本类型为 1 的基于时间的 UUID 中才有意义。
     * 如果此 UUID 不是基于时间的 UUID，则此方法将抛出 not a time-based UUID 
     *
     * 返回值 Int32- 与此 UUID 关联的时钟序列值
     */
    public func clockSequence(): Int32 

    /**
     * 与此 UUID 关联的节点值
     *
     * 48 位的节点值是由该 UUID 的节点字段构成的。
     * 此字段用于保存生成此 UUID 的机器的 IEEE 802 地址，以确保空间唯一性
     *
     * 节点值只有在版本类型为 1 的基于时间的 UUID 中才有意义。
     * 如果此 UUID 不是基于时间的 UUID，则此方法将抛出 not a time-based UUID 
     *
     * 返回值 Int64 - 与此 UUID 关联的节点值
     */
    public func node(): Int64

    /**
     * 返回此 UUID 的哈希值
     *
     * 返回值 Int32 - 哈希值
     */
    @overflowWrapping
    public func hashCode(): Int32

    /**
     * 将此对象与指定的对象进行比较。当且仅当 UUID 具有相同的变体，
     * 并且包含与此 UUID 逐位相同的值时，结果为 true。
     *
     * 参数 obj - 比较的 UUID
     *
     * 返回值 Bool
     */
    public func equals(obj: UUID): Bool

    /**
     * 将此 UUID 与指定的 UUID 进行比较。
     *
     * 如果 UUID 不同的最高有效字段对于第一个 UUID 更大，则两个 UUID 中的第一个大于第二个。
     *
     * 参数  val - 比较的 UUID
     *
     * 返回值 Int32 - -1: 小于 val
     *                0: 等于 val
     *                1: 大于 val
     */
    public func compareTo(val: UUID): Int32
}
```

### 2.2 UUIDUtil - UUID 生成工具类

```cangjie
public class UUIDUtil {

    /**
     * 00000000-0000-0000-0000-000000000000
     *
     * 返回值 UUID
     */
    public static func nilUUID(): UUID

    /**
     * ffffffff-ffff-ffff-ffff-ffffffffffff
     *
     * 返回值 UUID
     */
    public static func maxUUID(): UUID
    
    /**
     * 用规范字符串创建UUID的方法
     *
     * 参数 id - 生成的 UUID 的规范字符串
     *           十六进制字符可以是大写，UUID类将始终以小写形式输出它们
     *                     
     * 返回值 UUID
     */
    public static func uuid(id: String): UUID

    /**
     * 从给定的 16 个字节构造 UUID 实例的方法
     * 注意：由于绝对不会对内容进行验证，因此只有在已知内容有效的情况下才应使用此方法
     *
     * 参数 bytes - 有效数组
     * 返回值 UUID
     */
    public static func uuid(bytes: Array<Int8>): UUID

    /**
     * 从给定的 16 个字节构造 UUID 实例的方法
     * 注意：由于绝对不会对内容进行验证，因此只有在已知内容有效的情况下才应使用此方法
     * 
     * 参数 bytes - 包含有效 UUID 的 16 字节序列的数组
     * 参数 offset - 16 个字节中第一个字节的偏移量
     * 返回值 UUID
     */
    public static func uuid(bytes: Array<Int8>, offset: Int32): UUID

    /**
     * 用于构造具有适当类型的 UUID 实例的 Helper 方法
     * 
     * 参数 types - UUIDType
     * 参数 uuidBytes - 16 字节序列的数组
     * 返回值 UUID
     */
    @overflowWrapping
    public static func constructUUID(types: UUIDType, uuidBytes: Array<Int8>): UUID
    
    /**
     * 用于构造具有适当类型的 UUID 实例的 Helper 方法
     * 
     * 参数 types - UUIDType
     * 参数 l1 - 该 UUID 的 128 比特值的最高有效 64 比特
     * 参数 l2 - 该 UUID 的 128 比特值的最低有效 64 比特
     * 返回值 UUID
     */
    public static func constructUUID(types: UUIDType, l1: Int64, l2: Int64): UUID
    
    /**
     * 据类型初始化此 UUID 的 128 位值中的最高有效 64 位
     * 
     * 参数 l1 - 该 UUID 的 128 位的最高有效 64 位
     * 参数 types - UUIDType
     * 返回值 Int64
     */
    public static func initUUIDFirstLong(l1: Int64, types: UUIDType): Int64

    /**
     * 根据类型初始化此 UUID 的 128 位值中的最高有效 64 位
     * 
     * 参数 l1 - UUID 的 128 位值中的最高有效 64 位
     * 参数 rawType - UUIDType.raw() 值
     * 返回值 Int64
     */
    public static func initUUIDFirstLong(l1: Int64, rawType: Int32): Int64

    /**
     * 初始化 128 位值的最低有效 64 位
     * 
     * 参数 l2 - 该 UUID 的 128 位的最低有效 64 位
     * 返回值 Int64
     */
    public static func initUUIDSecondLong(l2: Int64): Int64
    
    /**
     * 用于确定给定 UUID 是哪种类型的 UUID 的方法
     * 
     * 参数 uuid - UUID
     * 
     * 返回值 ？UUIDType - Option<UUIDType>             
     */
    @overflowWrapping
    public static func typeOf(uuid: UUID): ?UUIDType

    /**
     * 获取 UUID 的数组
     * 
     * 参数 uuid - UUID
     * 
     * 返回值 Array<Int8>
     */
    @overflowWrapping
    public static func asByteArray(uuid: UUID): Array<Int8>

    /**
     * 设置缓冲区
     * 
     * 参数 uuid - UUID
     * 参数 buffer - 缓冲区
     * 返回值 Unit
     */
    public static func toByteArray(uuid: UUID, buffer: Array<Int8>): Unit

    /**
     * 设置缓冲区，偏移量为 offset
     * 
     * 参数 uuid - UUID
     * 参数 buffer - 缓冲区
     * 参数 offset - 追加的位置
     * 返回值 Unit
     */
    @overflowWrapping
    public static func toByteArray(uuid: UUID, buffer: Array<Int8>, offset: Int32): Unit
}
```


### 2.3 NameBasedGenerator

UUID 生成器的实现，该生成器使用基于名称的生成方法之一（变体3（MD5）和5（SHA1））

```cangjie
public class NameBasedGenerator <: StringArgGenerator {

    /**
     * 名称为 DNS 名称时使用的命名空间
     */
    public static let NAMESPACE_DNS: UUID = UUID.fromString("6ba7b810-9dad-11d1-80b4-00c04fd430c8")

    /**
     * 名称为 URL 时使用的命名空间
     */
    public static let NAMESPACE_URL: UUID = UUID.fromString("6ba7b811-9dad-11d1-80b4-00c04fd430c8")

    /**
     * 名称为 OID 时使用的命名空间
     */
    public static let NAMESPACE_OID: UUID = UUID.fromString("6ba7b812-9dad-11d1-80b4-00c04fd430c8")

    /**
     * 名称为 X500 标识符时使用的命名空间
     */
    public static let NAMESPACE_X500: UUID = UUID.fromString("6ba7b814-9dad-11d1-80b4-00c04fd430c8") 
   
    /**
     * 初始化
     *
     * 参数 namespace - 命名空间-如规范所定义。
     *                 UUID 有 4 个预定义的 “标准” 名称空间字符串，可以传递给 UUID 构造函数（见上面成员变量）。
     *                 请注意，此参数是可选的；如果不需要名称空间（例如，当名称包括名称空间前缀时），则可以传递 Option<UUID>.None
     * 参数 digester - 要使用的哈希算法
     *                 Option<MessageDigest>.None 默认使用 SHA1 算法
     * 参数 types - UUIDType
     *             Option<UUIDType>.None
     *              
     */
    public init(namespace: ?UUID, digester: ?MessageDigest, types: ?UUIDType)

    /**
     * 获取UUIDType
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    
    /**
     * 获取 命名空间
     *
     * 返回值 UUID - 有：返回 UUID
     *            - 无：NoneValueException
     */
    public func getNamespace(): UUID

    /**
     * 通过名称生成 UUID
     *
     * 参数 name - string
     * 返回值 UUID
     */    
    public override func generate(name: String): UUID
    
    /**
     * 通过名称生成 UUID
     *
     * 参数 nameBytes - Array<Int8>
     * 返回值 UUID
     */
    @overflowWrapping
    public override func generate(nameBytes: Array<Int8>): UUID
}
```

### 2.4 RandomBasedGenerator

利用 Random类或者SecureRandom类提供的随机数 对指定字符串生成摘要，利用摘要值生成唯一 UUID。

```cangjie
public class RandomBasedGenerator <: NoArgGenerator {

    /**
     * 初始化
     *
     * 参数 rnd - 使用random 包提供用于生成伪随机数的类 Random
     */
    public init(rnd: Random)

    /**
     * 初始化
     *
     * 参数 rnd - 使用crypto包提供用于生成加密安全的伪随机数类 SecureRandom
     */
    public init(rnd: SecureRandom)

    /**
     * 获取UUIDType
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType

    /**
     * 通过random 或者 SecureRandom 随机生成 UUID
     *
     * 返回值 UUID
     */    
    public override func generate(): UUID
}
```

### 2.5 MessageDigest

提供 MD5 和 SHA1 摘要

```cangjie
public enum DigestType <: ToString{
    | MD5 
    | SHA1

    /*
     * 摘要类型的 String 形式
     *
     * 返回值 String
     */
    public func toString(): String
}

public class MessageDigest {

    /*
     * 初始化
     *
     * 参数 algorithm - 摘要类型
     */
    public init(algorithm: DigestType)

    /*
     * 获取摘要类型
     *
     * 返回值 DigestType - 摘要类型
     */
    public func getAlgorithm(): DigestType
}
```

### 2.6 UUIDType

提供 UUID 的类型

```cangjie
public enum UUIDType {
    | TIME_BASED
    | DCE
    | NAME_BASED_MD5
    | RANDOM_BASED
    | NAME_BASED_SHA1
    | TIME_BASED_REORDERED
    | TIME_BASED_EPOCH
    | FREE_FORM
    | UNKNOWN

    /*
     * 获取UUID类型
     *
     * 返回值 Int64 - UUID类型对应值如下：
     *       TIME_BASED => 1
     *       DCE => 2
     *       NAME_BASED_MD5 => 3
     *       RANDOM_BASED => 4
     *       NAME_BASED_SHA1 => 5
     *       TIME_BASED_REORDERED => 6
     *       TIME_BASED_EPOCH => 7
     *       FREE_FORM => 8
     *       UNKNOWN => 0     
     */
    public func raw(): Int64
}
```

### 2.7 TimeBasedReorderedGenerator

使用基于时间/位置生成 UUID 生成器的实现，重新排序以改进数据库局部性。

```cangjie
public class TimeBasedReorderedGenerator <: NoArgGenerator {

    /**
     * 初始化
     *
     * 参数 ethAddr - 用于生成的硬件地址
     * 参数 timer - 用于同步访问时间戳的对象         
     */
    @overflowWrapping
    public init(ethAddr: ?EthernetAddress, timer: UUIDTimer)

    /**
     * 获取UUIDType
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    
    /**
     * 获取用于生成的硬件地址
     *
     * 返回值 EthernetAddress - 硬件地址
     */
    public func getEthernetAddress(): EthernetAddress

    /**
     * 生成 UUID
     *
     * 返回值 UUID
     */ 
    @overflowWrapping   
    public func generate(): UUID
}
```

### 2.8 TimeBasedEpochGenerator

使用基于时间纪元生成 UUID。

```cangjie
public class TimeBasedEpochGenerator <: NoArgGenerator {

    /**
     * 初始化        
     */
    public init()

    /**
     * 初始化
     *
     * 参数 rnd - Random 随机数        
     */
    public init(rnd: Random)

    /**
     * 获取UUIDType
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    
    /**
     * 生成 UUID
     *
     * 返回值 UUID
     */   
    public func generate(): UUID
}
```

### 2.9 EthernetAddress

用于生成符合地址格式的地址

```cangjie
public class EthernetAddress <: Hashable & ToString & Equatable<EthernetAddress>{
    
    /**
     * 字符串构造函数
     *
     * 参数 - 符合地址格式的地址，像（00:C0:F0:3D:5B:7C）
     * 请注意，字符串不区分大小写，并且前导为零，可以省略，
     * 00:C0:F0:3D:5B:7C 和 0:C0:F0:3D:5B:7C 等效
     */  
    public init(addrStr: String)

    /**
     * 数组构造函数
     *
     * 参数 - 6 位字节数组
     *        不符合则会报错 Ethernet address has to consist of 6 bytes
     */ 
    public init(addr: Array<UInt8>)

    /**
     * Int64 类型的构造函数
     *
     * 参数 - Int64
     */ 
    public init(addr: Int64)

    /**
     * 复制地址
     *
     * 返回值 - EthernetAddress
     */
    public func clone(): EthernetAddress

    /**
     * 构造一个新的 EthernetAddress，给定包含地址的 UInt8 数组表示
     *
     * 参数 addr - 地址的数组表示（小于或大于6个字节长度的数组无效）
     * 返回值 - EthernetAddress
     */
    public static func valueOf(addr: Array<UInt8>): EthernetAddress

    /**
     * 构造一个新的 EthernetAddress，给定包含地址的 Int32 数组表示
     *
     * 参数 addr - 地址的数组表示（小于或大于6个字节长度的数组无效）
     * 返回值 - EthernetAddress
     */
    public static func valueOf(addr: Array<Int32>): EthernetAddress

    /**
     * 构造一个新的 EthernetAddress，给定包含地址的 string 表示
     *
     * 参数 addrStr - 地址的字符串表示
     * 返回值 - EthernetAddress
     */
    public static func valueOf(addrStr: String)

    /**
     * 构造一个新的 EthernetAddress，给定包含地址的 Int64 表示
     *
     * 参数 addrStr - 地址的 Int64 表示
     * 返回值 - EthernetAddress
     */
    public static func valueOf(addr: Int64)

    /**
     * 构造一个随机的 EthernetAddress
     *
     * 返回值 - EthernetAddress
     */
    public static func constructMulticastAddress(): EthernetAddress

    /**
     * 构造一个随机的 EthernetAddress
     *
     * 参数 rnd - 安全随机数
     * 返回值 - EthernetAddress
     */
    public static func constructMulticastAddress(rnd: SecureRandom): EthernetAddress

    /**
     * 返回字节数组类型的 EthernetAddress
     *
     * 返回值 - Array<UInt8>
     */
    public func asByteArray(): Array<UInt8>

    /**
     * 返回字节数组类型的 EthernetAddress，作用同 asByteArray
     *
     * 返回值 - Array<UInt8>
     */
    public func toByteArray(): Array<UInt8>

    /**
     * 将地址转成 UInt8 数组
     *
     * 参数 array - 字节数组
     * 返回值 - Unit
     */
    public func toByteArray(array: Array<UInt8>): Unit

    /**
     * 将地址转成 UInt8 数组
     *
     * 参数 array - 字节数组
     * 参数 pos - 位置
     * 返回值 - Unit
     */
    @overflowWrapping
    public func toByteArray(uuidBytesArray: Array<UInt8>, pos: Int64): Unit

    /**
     * 获取地址 Int64 值
     *
     * 返回值 - Int64
     */
    public func toLong(): Int64

    /**
     * 检查地址是否引用多播地址
     *
     * 返回值 - Bool
     */
    public func isMulticastAddress(): Bool

    /**
     * 检查地址是否引用本地管理地址
     *
     * 返回值 - Bool
     */
    public func isLocallyAdministeredAddress(): Bool

    /**
     * 判断地址是否相等
     *
     * 返回值 - Bool
     */
    public operator func ==(anothor: EthernetAddress): Bool

    /**
     * 判断地址是否不等
     *
     * 返回值 - Bool
     */
    public operator func !=(anothor: EthernetAddress): Bool

    /**
     * 获取地址哈希值
     *
     * 返回值 - Int64
     */
    public func hashCode(): Int64

    /**
     * 获取地址 String 形式
     *
     * 返回值 - String
     */
    @overflowWrapping
    public func toString(): String
}
```

### 2.10 UUIDComparator

比较两个 UUID

```
public class UUIDComparator {

    /**
     * UUID 比较
     *
     * 参数 u1 - UUID
     * 参数 u2 - UUID
     * 返回 Int32 - 结果 >0 表示 ui > u2
     *              结果 <0 表示 ui < u2
     *              结果 = 0 表示 ui = u2
     */
    public static func compare(u1: UUID, u2:UUID): Int32

}
```

### 2.11 UUIDGenerator

```
public abstract class UUIDGenerator {

    /**
     * UUID 生成器
     *
     * 返回 UUIDType - UUID 的 type
     */
    public func getType(): UUIDType

}
```
### 2.12 StringArgGenerator

```
public abstract class StringArgGenerator <: UUIDGenerator {

    /**
     * UUID 生成器
     * 
     * 参数 name - 符合 UUID 标准的名称
     * 返回 UUIDType - UUID 的 type
     */
    public func generate(name: String): UUID

    /**
     * UUID 生成器
     * 
     * 参数 nameByte - 指定字节数组
     * 返回 UUIDType - UUID 的 type
     */
    public func generate(nameByte: Array<Int8>): UUID

}
```

### 2.13 TimeBasedGenerator

基于时间+默认地址生成唯一 UUID。

```cangjie
public class TimeBasedGenerator <: NoArgGenerator {

    /**
     * 初始化
     *
     * 参数 ethAddr - Option<EthernetAddress> 默认物理地址
     * 参数 timer - UUIDTimer 时间戳生成类
     */
    public init(ethAddr:Option<EthernetAddress>,timer: UUIDTimer)

    /**
     * 获取UUIDType
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType

    /**
     * 获取EthernetAddress
     *
     * 返回值 EthernetAddress
     */
    public func getEthernetAddress(): EthernetAddress
    
    /**
     * 生成 UUID
     *
     * 返回值 UUID
     */   
    public func generate(): UUID
}
```

### 2.14 FileBasedTimestampSynchronizer

保存时读取间戳的文件工具类。

```cangjie
public class FileBasedTimestampSynchronizer {

    /**
     * 初始化
     */
    public init()

    /**
     * 初始化
     *
     * 参数 lockFile1 - File 时间戳保存文件一
     * 参数 lockFile2 - File 时间戳保存文件二
     */
    public init(lockFile1: File, lockFile2: File)

    /**
     * 初始化
     *
     * 参数 lockFile1 - File 时间戳保存文件一
     * 参数 lockFile2 - File 时间戳保存文件二
     * 参数 interval - Int64 时间间隔
     */
    public init(lockFile1: File, lockFile2: File, interval: Int64)

    /**
     * 设置时间间隔
     *
     * 参数 interval - Int64 时间间隔
     */
    public func setUpdateInterval(interval: Int64)

    /**
     * 更新文件里的时间戳
     *
     * 参数 now - Int64 系统时间
     * 返回值 更新后的时间戳
     */
    public func update(now:Int64): Int64
    
}
```

### 2.15 UUIDTimer

时间戳工具类

```cangjie
public class UUIDTimer {

    /**
     * 初始化
     *
     * 参数 rnd - SecureRandom 随机数生成类
     * 参数 sync - Option<FileBasedTimestampSynchronizer> 保存时读取时间戳的文件工具类。传入Option<FileBasedTimestampSynchronizer>.None默认文件为uuid1.txt， 
     * uuid2.txt
     */
    public init(rnd:SecureRandom,sync:Option<FileBasedTimestampSynchronizer>)

    /**
     * 初始化
     *
     * 参数 rnd - SecureRandom 随机数生成类
     * 参数 sync - Option<FileBasedTimestampSynchronizer> 保存时读取时间戳的文件工具类
     * 参数 clock - UUIDClock 时钟
     */
    public init(rnd:SecureRandom,sync:Option<FileBasedTimestampSynchronizer>,clock:UUIDClock)

    /**
     * 获取时钟序列
     *
     * 返回值 时钟序列
     */
    public func getClockSequence():Int32

    /**
     * 获取时间戳
     *
     * 返回值 时间戳
     */
    public func getTimestamp(): Int64

}
```

### 2.16 UUIDClock

系统时间工具类

```cangjie
public class UUIDClock {

    /**
     * 获取当前系统时间
     *
     * 返回值 系统时间戳
     */
    public func currentTimeMillis(): Int64

}
```
### 2.17 NoArgGenerator

```
public abstract class NoArgGenerator {
    /**
     * UUID 生成器
     * 
     * 返回 UUID
     */
    public func generate():UUID
}

```
