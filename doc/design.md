# uuid 库设计说明

## 1. 需求场景分析

​	 	UUID 的是让[分布式系统](https://so.csdn.net/so/search?q=分布式系统&spm=1001.2101.3001.7020)中的所有元素都能有唯一的辨识信息，而不需要通过中央控制端来做辨识信息的指定。如此一来，每个人都可以创建不与其它人冲突的 UUID。在这样的情况下，就不需考虑数据库创建时的名称重复问题。 

UUID 全称：Universally Unique Identifier，即通用唯一识别码， 定义为一个字符串主键，采用32位数字组成，编码采用16进制，定义了在时间和空间都完全唯一的系统信息。 

 UUID 的标准格式：xxxxxxxx-xxxx-Axxx-Bxxx-xxxxxxxxxxxx ，形式为 8-4-4-4-12 的 32 个字符，如：550e8400-e29b-41d4-a716-446655440000。

A 代表版本号，由于 UUID 的标准实现有 5 个版本，所以只会是 1,2,3,4,5
B 只会是8,9,a,b 

## 2. 三方库对外提供特性

1. 基于名称的 UUID 生成器
2. 随机 UUID 生成器
3. 基于时间的纪元 UUID 生成器
4. 基于时间的 UUID 生成器
5. 基于时间的重新排序 UUID 生成器

## 3. License分析

Apache License 2.0

| Permissions    | Limitations   |
| -------------- | ------------- |
| Commercial use | Trademark use |
| Modification   | Liability     |
| Distribution   | Warranty      |
| Patent use     |               |
| Private use    |               |

## 4. 依赖分析

cangjie 标准库依赖

```
from crypto import crypto.SecureRandom
from std import log.*
from std import random.*
from serialization import serialization.*
from std import core.Comparator
```

其他三方库依赖

    from cryptocj import md5cj.*
    from cryptocj import sha1cj.*
    from charset import charset.*

## 5. 代码量（不计算用例/注释）

    4039

## 6. 特性设计文档

<p align="center"><img src="./assets/design.png"></p>

### 6.1  获取 UUID 通用唯一识别码

#### 6.1.1 特性介绍

​	1、随机生成唯一的UUID 识别码

​	2、通过SHA1、MD5 摘要生成唯一 UUID 识别码

​	3、根据一个符合 UUID 格式的字符串获取

#### 6.1.2 实现方案

```
public class UUID <: Serializable & ToString & Hashable & Comparable<UUID> {
    public init(mostSigBits: Int64, leastSigBits: Int64)
    
    /*
     * 随机生成唯一的 UUID 识别码
     *
    public static func randomUUID(): UUID
    
    /*
     * 根据一个字节数组获取，一般要求给定的字节数组不重复,内部为对name进行摘要算法
     * 
     * 参数 - name 给定的字节数组
     * 返回值 - UUID
     */
    public static func nameUUIDFromBytes(name: Array<Byte>): UUID
    
    /*
     * 根据一个符合 UUID 格式的字符串获取
     * 
     * 参数 - name 给定的字符串，需要符合 UUID 格式
     * 返回值 - UUID
     */
    public static func fromString(name: String): UUID
    
    /*
     * 获取这128位中的最低有效64位。
     * 
     * 返回值 - Int64
     */
    public func getLeastSignificantBits(): Int64
    
    /*
     * 获取这128位中的最高有效64位。
     * 
     * 返回值 - Int64
     */
    public func getMostSignificantBits(): Int64
    /*
     * UUID 生成的版本号
     */
    public func version(): Int32
    /*
     * UUID 变体编号
     */
    public func variant(): Int32
    /*
     * 此 UUID 链接的时间戳
     */
    public func timestamp(): Int64
    /*
     * UUID 链接的时钟序列
     */
    public func clockSequence(): Int32
    /*
     * UUID的链接节点
     */
    public func node(): Int64
    /*
     * UUID 转为string
     */
    public func toString(): String
    /*
     * UUID hasecode
     */
    public func hashCode(): Int32
    /*
     * 判断 uuid 是否相等
     */
    public func equals(obj: Object): Bool
    /*
     * 比较两个UUID对象
     */
    public func compareTo(val: UUID): Int32
}

```

### 6.2 SR 基于名称的 UUID 生成器

#### 6.2.1 特性介绍

生成基于名称（DNS、URL、OID、X500） 的 UUID。

#### 6.2.3 实现方案

```
public class NameBasedGenerator <: StringArgGenerator
{
    public let static  _utf8: Charset 
    public let static NAMESPACE_DNS: UUID = UUID.fromString("6ba7b810-9dad-11d1-80b4-00c04fd430c8")
    public let static NAMESPACE_URL: UUID = UUID.fromString("6ba7b811-9dad-11d1-80b4-00c04fd430c8")
    public let static NAMESPACE_OID: UUID = UUID.fromString("6ba7b812-9dad-11d1-80b4-00c04fd430c8")
    public let static NAMESPACE_X500: UUID = UUID.fromString("6ba7b814-9dad-11d1-80b4-00c04fd430c8")
	
	/*
     * 初始化
     *
     * 参数 namespace - 要用作前缀的命名空间
     * 参数 digester - 信息摘要
     * 参数 type - 不同类型的 UUID 
     */
    public init(namespace!: UUID, digester!: String, type!: UUIDType)
    /*
     * 获取类型
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType 
    /*
     * 生成器
     *
     * 参数 name - 名字
     * 返回值 UUID
     */
    public override func generate(name: String): UUID
    /*
     * 生成器
     *
     * 参数 nameBytes - Array<Byte>类型的名字
     * 返回值 UUID
     */
    public override func generate(nameBytes: Array<Byte>): UUID
    /*
     * 获取命名空间
     *
     * 返回值 UUID
     */
    public func getNamespace(): UUID
}

```
### 6.3 使用基于时间/位置的生成的 UUID 生成器的实现，重新排序以改进数据库局部性。

#### 6.3.1 特性介绍

生成基于时间/位置的 ID，重新排序以改进数据库局部性

#### 6.3.2  实现方案

生成数据库中数据 ID 

```
public class TimeBasedGenerator <: NoArgGenerator
{
    public static let BYTE_OFFSET_TIME_HIGH: Int32 = 0;
    public static let BYTE_OFFSET_TIME_MID: Int32 = 4;
    public static let BYTE_OFFSET_TIME_LOW: Int32 = 7;
    /*
     * 初始化
     *
     * 参数 ethAddr - 位置
     * 参数 timer - 时间
     */
    public init(ethAddr: EthernetAddress, timer: UUIDTimer)
    /*
     * 获取类型
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    /*
     * 获取地址
     *
     * 返回值 EthernetAddress
     */
    public func getEthernetAddress(): EthernetAddress
    /*
     * 生成器
     *
     * 返回值 UUID
     */
    public override func generate(): UUID

```

### 6.4 基于当前时间戳、随机数和机器MAC地址。

#### 6.4.1 特性介绍

基于当前时间戳、随机数和机器MAC地址

#### 6.4.2  实现方案

```
public class TimeBasedReorderedGenerator <: NoArgGenerator
{
    
    /*
     * 初始化
     *
     * 参数 ethAddr - 位置
     * 参数 timer - 时间
     */
    public init(ethAddr: EthernetAddress, timer: UUIDTimer)
    /*
     * 获取类型
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    /*
     * 获取地址
     *
     * 返回值 EthernetAddress
     */
    public func getEthernetAddress(): EthernetAddress
    /*
     * 生成器
     *
     * 返回值 UUID
     */
    public override func generate(): UUID

```

### 6.5 基于随机数

#### 6.5.1 特性介绍

基于随机数

#### 6.5.2  实现方案

```
public class RandomBasedGenerator <: NoArgGenerator
{
    
    /*
     * 初始化
     *
     * 参数 ethAddr - 位置
     * 参数 timer - 时间
     */
    public init(rnd: Random)
    /*
     * 获取类型
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    /*
     * 生成器
     *
     * 返回值 UUID
     */
    public override func generate(): UUID

```

### 6.6 使用基于时间纪元 UUID 生成器的实现

#### 6.6.1 特性介绍

生成基于时间纪元的 ID

#### 6.6.2  实现方案

```
public class TimeBasedEpochGenerator extends NoArgGenerator
{

    /*
     * 初始化
     *
     * 参数 rnd - 随机数生成器
     */
    public init(rnd:Random)
    /*
     * 获取类型
     *
     * 返回值 UUIDType
     */
    public override func getType(): UUIDType
    /*
     * 生成器
     *
     * 返回值 UUID
     */
    public override func generate(): UUID

```

### 6.7 其他依赖包

#### 6.7.1 MessageDigest

信息摘要 MD5 SHA1

```
from cryptocj import md5cj.*
from cryptocj import sha1cj.*

/*
 * 基于名称（MD5，SHA1）的 UUID 生成器 
 */
public enum DigestType <: ToString{
    | MD5 
    | SHA1
	
	/*
     * 判断两个摘要类型是否相等 
     */
    public operator func ==(b: DigestType): Bool
    /*
     * string 形式
     */
    public func toString(): String 
}
public class MessageDigest {
	/*
	 * 初始化
	 */
    public init(algorithm: DigestType)
    /*
	 * 获取摘要类型
	 */
    public static func getAlgorithm(): DigestType
    /*
	 * 对数据进行摘要
	 */
    public static func digest(input: Array<Int8>): Array<Int8>
}
```

#### 6.7.2 EthernetAddress

以太网地址

##### 6.7.2.1 风险

*该类需获取网卡的硬件地址，对标java库的java.net.NetworkInterface类 。需找核心库确认是否有类似的功能*

```
public class EthernetAddress <: Serializable, Cloneable, Comparable<EthernetAddress>{
    /*
     * 构造函数
     *
     * 参数 addrStr - 字符串类型的地址
     */
    public init(addrStr: String)
    /*
     * 构造函数
     *
     * 参数 addr - 数组类型的地址
     */
    public init(addr: Array<Int8>)
    /*
     * 构造函数
     *
     * 参数 addr - Int64 类型的地址
     */
    public init(addr: Int64)
     /*
     * 默认克隆行为（按位复制）
     *
     * 返回值 EthernetAddress
     */
    public func clone(): EthernetAddress
    /*
     * 在给定包含以下内容的字节数组的情况下构造一个新的以太网地址 地址的二进制表示形式。
     *
     * 参数 addr - 给定的字节数组
     * 返回值 EthernetAddress
     */
    public static func valueOf(addr: Array<Int8>): EthernetAddress
    /*
     * 在给定包含以下内容的字节数组的情况下构造一个新的以太网地址 地址的二进制表示形式。
     *
     * 参数 addr - 给定的字节数组
     * 返回值 EthernetAddress
     */
    public static func valueOf(addr: Array<Int32>): EthernetAddress
    /*
     * 在给定包含以下内容的字符串的情况下构造一个新的以太网地址 地址的二进制表示形式。
     *
     * 参数 addr - 给定的字符串
     * 返回值 EthernetAddress
     */
    public static func valueOf(addrStr: String): EthernetAddress
     /*
     * 在给定包含以下内容的Int64的情况下构造一个新的以太网地址 地址的二进制表示形式。
     *
     * 参数 addr - 给定的Int64
     * 返回值 EthernetAddress
     */
    public static func valueOf(addr: Int64): EthernetAddress
    /*
     * 查找具有一个合适的mac地址（以太网卡等），并返回该地址。如果有多个适用的接口，返回其中一个。
     *
     * 返回值 EthernetAddress
     */
     // import java.net.NetworkInterface; 不确定
    public static func fromInterface(): EthernetAddress
    /*
     * 可用于构造随机多种地址;用于没有“真实”以太网的情况要使用的地址
     *
     * 返回值 EthernetAddress
     */
    public static func constructMulticastAddress(): EthernetAddress
    /*
     * 可用于构造随机多种地址;用于没有“真实”以太网的情况要使用的地址
     *
     * 返回值 EthernetAddress
     */
    public static func constructMulticastAddress(rnd: Random): EthernetAddress
    /*
     * 返回包含二进制表示形式的 6 字节字节数组的以太网地址;字节 0 是最高有效字节
     *
     * 返回值 Array<Int8>
     */
    public func asByteArray(): Array<Int8>
    /*
     * 是 asByteArray
     *
     * 返回值 Array<Int8>
     */
    public func toByteArray(): Array<Int8>
    /*
     * 转 Array<Int8>
     *
     * 参数 array - Array<Int8>
     */
    public func toByteArray(array: Array<Int8>): Unit
    /*
     * 转 Array<Int8>
     *
     * 参数 array - Array<Int8>
     * 参数 pos - 起始位置
     */
    public func toByteArray(array: Array<Int8>, pos: Int32): Unit
    /*
     * 地址长度
     *
     * 返回值 Int64
     */
    public func toLong(): Int64
    /*
     * 可用于检查此地址是否是多种地址
     *
     * 返回值 Bool
     */
    public func isMulticastAddress(): Bool
    /*
     * 可用于检查此地址是否引用到“本地管理的地址
     *
     * 返回值 Bool
     */
    public func isLocallyAdministeredAddress(): Bool
    /*
     * 判断连两个地址是否相等
     *
     * 参数 - o
     * 返回值 Bool
     */
    public func equals(o: EthernetAddress): Bool
    /*
     * 获取地址的 hashcode 值
     *
     * 返回值 Int32
     */
    public func hashCode(): Int32
    /*
     * 将此以太网地址与传入做比较
     *
     * 参数 other - EthernetAddress
     * 返回值 Int32
     */
    public func compareTo(other: EthernetAddress): Int32 
    /*
     * 返回此以太网地址的规范字符串表示形式
     *
     * 返回值 String
     */
    public func toString(): String
}
```

#### 6.7.3 UUIDTimer

 生成基于时间的 UUID 所需的时间戳 

```
public class UUIDTimer {
	/*
     * 初始化构造
     *
     * 参数 rnd - 随机数
     * 参数 sync - 基于时间的 UUID 单调递增，使系统时钟在重新启动后向后移动
     */
    public init(rnd: Random, sync: TimestampSynchronizer)
    /*
     * 初始化构造
     *
     * 参数 rnd - 随机数
     * 参数 sync - 基于时间的 UUID 单调递增，使系统时钟在重新启动后向后移动
     * 参数 clock - 系统当前时间
     */
    public init(rnd: Random, sync: TimestampSynchronizer, clock: UUIDClock) 
	/*
     * 获取时钟序列
     *
     * 返回值 Int32
     */
    public func getClockSequence(): Int32
  	/*
     * 基于时间的 UUID 单调递增值
     *
     * 返回值 Int64
     */
    public func getTimestamp(): Int64
 }
```

#### 6.7.4 UUIDClock

当前系统时间

```
public class UUIDClock {
    /*
     * 获取当前时间
     */
    public func currentTimeMillis(): Int64
}

```

