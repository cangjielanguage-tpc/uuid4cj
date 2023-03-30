<div align="center">
<h1>UUID</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.37.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-0%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/> 介绍

UUID（通用唯一标识符），也称为GUID（全局唯一标识符）。UUID长度为128位，可以保证跨空间和时间的唯一性。

参考地址：https://github.com/cowtowncoder/java-uuid-generator 版本 4.1.0 

**特性**：

- 🚀 基于名称生成 UUID 

- 💪 基于时间/位置重新排序生成 UUID

- 🚀 基于当前时间戳、随机数、机器 MAC 地址生成 UUID

- 🌍 基于随机数生成 UUID

- 💡 基于时间纪元生成 UUID 

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

![design](./doc/assets/design.png)

1. 格式

      在其规范的文本表示中，UUID 的 16 个 8 位字节表示为 32 个十六进制数字，由连字符 '-' 分隔成五组显示，形式为“8-4-4-4-12”总共 36 个字符（32 个十六进制数字和 4 个连字符）。

      例如：

      ```
      123e4567-e89b-12d3-a456-426655440000
      ```

2. 变体

      变体字段确定UUID的布局。也就是说所有其他位的解释取决于变体的设置。变体字段由UUID的第8个字节的高3位。RFC 4122定义了4种变体：

      x表示不关心值。

      | Msb0 | Msb1 | Msb2 | 描述                                              |
      | ---- | ---- | ---- | ------------------------------------------------- |
      | 0    | x    | x    | 变体0，保留，NCS向后兼容性。                      |
      | 1    | 0    | x    | 变体1，RFC 4122 UUID定义，也就是2.1.2描述的布局。 |
      | 1    | 1    | x    | 变体2，保留，Microsoft Corporation向后兼容性。    |
      | 1    | 1    | x    | 保留供将来定义使用。                              |

      2.1 变体2布局

      | 名称                      | 长度 （字节） | 字节索引 | 说明                                                 |
      | ------------------------ | ------------ | ------- | --------------------------------------------------- |
      | time_low                  | 4             | 0-3      | 整数：低位 32 bits 时间                              |
      | time_mid                  | 2             | 4-5      | 整数：中间位 16 bits 时间                            |
      | time_hi_and_version       | 2             | 6-7      | 最高有效位中的 4 bits“版本”，后面是高 12 bits 的时间 |
      | clock_seq_hi_and_reserved | 1             | 8        | 最高有效位为 1-3 bits“变体”，后跟13-15 bits 时钟序列 |
      | clock_seq_low             | 1             | 9        | 时钟序列的低位                                       |
      | node                      | 6             | 10-15    | 48 bits 节点 ID                                      |

3. 版本

      对于变体1和变体2，标准中定义了5个版本。

      版本数值位与第6个字节的高4位，即time_hi_and_version 字段的第4到第7位。

      | Msb0 | Msb1 | Msb2 | Msb3 | Version | 意义                             |
      | ---- | ---- | ---- | ---- | ------- | -------------------------------- |
      | 0    | 0    | 0    | 1    | 1       | 基于时间的UUID                   |
      | 0    | 0    | 1    | 0    | 2       | 基于时间的UUID，DEC安全版本      |
      | 0    | 0    | 1    | 1    | 3       | 基于名称空间和MD5散列算法的UUID  |
      | 0    | 1    | 0    | 0    | 4       | 基于随机数的UUID                 |
      | 0    | 1    | 0    | 1    | 5       | 基于名称空间和SHA1散列算法的UUID |

      3.1 版本4算法

      版本4 UUID是从真正随机数或伪随机数生成UUID。

      算法如下：

      将时钟_seq_hi_and_reserve的两个最高有效位（位6和位7）分别设置为零和1。

      将time_hi_and_version字段的四个最高有效位（位12至15）设置为版本4版本号。

      将所有其他位设置为随机（或伪随机）选择的值。

4. 字符串形式

      4.1 标注形式

      ```
      UUID                   = time-low "-" time-mid "-"
                                    time-high-and-version "-"
                                    clock-seq-and-reserved
                                    clock-seq-low "-" node
            time-low               = 4hexOctet
            time-mid               = 2hexOctet
            time-high-and-version  = 2hexOctet
            clock-seq-and-reserved = hexOctet
            clock-seq-low          = hexOctet
            node                   = 6hexOctet
            hexOctet               = hexDigit hexDigit
            hexDigit =
                  "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9" /
                  "a" / "b" / "c" / "d" / "e" / "f" /
                  "A" / "B" / "C" / "D" / "E" / "F"
      ```

      4.2 URN形式

      ```
      urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6
      ```

### 源码目录

```shell
.
├── doc
├── src
│   ├── uuid
└── test
│   ├── HLT
│   ├── LLT
│   └── UT
├── CHANGELOG.md
├── gitee_gate.cfg
├── LICENSE.txt
├── module.json
├── README.md
├── README.OpenSource
```

- `doc` 存放库的设计文档、使用文档、LLT 用例覆盖报告
- `src` 是库源码目录
- `test` 存放 HLT 测试用例、LLT 自测用例和 UT 单元测试用例

### 接口说明

主要核心类和全局函数说明,详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

```
cpm build 
```

### 功能示例

#### 基于名称 MD5 生成 UUID 使用样例

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

#### 基于名称 SHA1 生成 UUID 使用样例

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
#### 基于随机数 生成 UUID 使用样例

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
## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。