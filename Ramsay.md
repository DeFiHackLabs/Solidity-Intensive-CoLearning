---
timezone: America/Los_Angeles
---


# YourName

1. 自我介绍:
   Hi, 我是Ramsay, 对新事物比较感兴趣，自认为是个喜欢学习的人，所以就来参加 Solidity 的学习.

2. 你认为你会完成本次残酷学习吗？
  尽力而为，不中途放弃.
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### 01 Helloworld

##### License header
课程提到的未添加 License 会导致出现编译 warning, 这个是我第一个接触会因为没有注明 License 而告警的编程语言，可能是因为区块链的透明性，所以天然就拥抱开源。

搜索了一下，发现并非 Solidity 并非一开始就有这个特性，而是在 [0.6.8](https://forum.openzeppelin.com/t/solidity-0-6-8-introduces-spdx-license-identifiers/2859) 引入的，只是 Release Note 里面没有注明动机

##### Version mechanism

> 这行代码表示源文件将不允许小于 0.8.21 版本或大于等于 0.9.0 的编译器编译（第二个条件由 ^ 提供）

```solidity
pragma solidity ^0.8.21;
```

课程未说明的是，~^~ 机制是如何运作。在版本管理里面，以 ~0.8.21~ 为例：

- 0: major version
- 8: minor version
- 21: patch version

major version 大于0就意味着发布了稳定版本，稳定版本的意思就是起码 1.0 之后，不升级 major version 不会出现 breaking change, 算是一个 commitment, 而未发布稳定版本就意味着，当下我们还在开发，接口什么的可能会变。

而 ~^version~: 代表 *Compatible with version*, 它有两个含义。

如果发布了稳定版本，那么就意味着会自动帮你升级 minor version 和 patch version, major version 不动. 如 ~^1.2.3~ 就意味着大于 1.2.3 小于 2.0.0 

如果未发布稳定版本，例如 ^0.8.21, 他的意思就是, 可以升级，但是不要变动到版本号中最左边的非零数字, 即 ^0.8.21 is 大于等于 0.8.21, 但小于0.9,  因为升级到0.9 就意味着最左边的非零数字(left-most non-zero)变了.

类似含义的还有 ~~version~: 意味着 *Approximately equivalent to version*, 就是只升级 patch version, 不会变动 major version 和 minor version.

上面提到的其实是Javascript NPM 的规则，Solidity 直接站在 [npm](https://docs.soliditylang.org/en/v0.8.27/layout-of-source-files.html#pragmas) 的肩膀上了, 官网文档:

> It is possible to specify more complex rules for the compiler version, these follow the same syntax used by npm.

##### Nitpick

(属于吹毛求疵类型，如果能改掉就更好了)

示例中的变量不要使用 ~_string~ 这样没有含义的命名

#### 02 Type

value type, reference type, enum, array, vector 这些概念在其他语言中都大同小异，比如Java 中, primitive type 就是 value type, 默认是传值, class 就是 reference type, 默认是传引用，而 C++ 是都可以有，可以自行设计。

> enum 是一个比较冷门的变量，几乎没什么人用。

其实 enum 在定义有限个常量时，是非常有用，类如星期，月份等.

##### Address Type

Address type 是 Solidity 特有的类型，我接触的编程语言都没有这个概念，所以我研读了一下官方文档。

> address: Holds a 20 byte value (size of an Ethereum address).

> address payable: Same as address, but with the additional members transfer and send.

> The idea behind this distinction is that address payable is an address you can send Ether to, while you are not supposed to send Ether to a plain address, for example because it might be a smart contract that was not built to accept Ether.

因为 Solidity 是构建在 EVM 之上的，EVM可以说是 smart contract 的基石，而地址就是EVM这基石的每个砖块的唯一标识符，可以类比成运行在计算机的程序，每个变量都会有自己唯一的内存地址。

而 ~address payable~ 就是一串可以接收 Ethereum 的地址（我可以理解成是合法的 Ethereum 地址）, address 就是一串 20byte 的字符串（或许是合法的地址）

address 只能通过 ~payable(<address>)~ 转换成 ~address payable~, 我估计这个函数的内部会校验 address 地址的合法性.

address type 还内置了一系列的[函数](https://docs.soliditylang.org/en/v0.8.27/units-and-global-variables.html#address-related)

By the way, Solidity 也是我接触的，第一门类型有两个以上关键词的语言，想必这样会增加编译器的解析成语法树的成本，另外可读性也不是很好:

```
address payable x = payable(0x123);
address myAddress = address(this);
```

我很容易把 ~payable~ 当作是变量名, 把 ~address payable~ 合并成 ~adrpay~ 可能更符合我的品味，并且易于编译器处理.

##### Contract Type

Contract 目前在我的理解里就是类比Java 中的Class, 就是用户定义的，包含数据与函数的，运行在虚拟机(JVM/EVM)上的最小代码单元. contract 与 address 之间可以通过 ~address(x)~ 函数进行显式转换.

如果想要把 contract 转换成 address payable, 要么 contract 定义了 ~receive~ 或 ~payable~ 回调函数，要么使用 ~payable(address(x))~ 来作转换

##### User-defined Value type 

> A user-defined value type allows creating a zero cost abstraction over an elementary value type.

zero cost abstraction 这个是我在C++和Rust 之外, 第一次听到有语言标榜 zero cost abstraction ，只是看下来，这个 User-defined value type 就是一个 alias, 其实就是 C++ 的 [~typedef~ 或者 ~using~](https://stackoverflow.com/questions/10747810/what-is-the-difference-between-typedef-and-using) 

和 zero cost abstraction 并没有什么关系.

#### 03 Function

Solidity 这个函数签名方式着实是有点不习惯，可见性修饰符放在参数括号之后。

~pure~ 和 ~view~ 是其他语言所没有的关键的，严格来说是 ~pure~ 没有, ~view~ 类似 C++ 的 ~const~ 关键字，是只读的意思。

虽然作者在教程解释得很有趣，但是 [~pure function~](https://en.wikipedia.org/wiki/Pure_function) 其实是来自函数式编程中的概念，有两个含义：
1. 给定相同的输入，就一定会返回相同的输出，和数学中的函数一样
2. 没有副作用 (side effect), 类如文件读写，或者修改变量的操作.

根据官方文档，另外一个函数有趣的点在于，两个函数类型是可以隐式转换的，只要他们的函数签名，返回类型，可见性，以及状态可变性之间存在包含关系：

> A function type A is implicitly convertible to a function type B if and only if their parameter types are identical, their return types are identical, their internal/external property is identical and the state mutability of A is more restrictive than the state mutability of B. In particular:
> - pure functions can be converted to view and non-payable functions
> - view functions can be converted to non-payable functions
> - payable functions can be converted to non-payable functions

~payable~ 函数可以转换为 ~non-payable~ 函数，因为官方的说法是， ~payable~ 可以收，也可以不收（只收0个ETH），那么也可以看成 ~non-payable~. 但是 ~non-payble~ 不能收就是不能收，没法转成 ~payable~, 所以只能单向转换.

#### 04 Return

Solidity的函数声明实在是太多关键字，这次我第一个见过需要使用 ~returns~ 来标识函数返回值的语言。

既有 C++/Java 这样把函数返回值声明在参数前的，也有 Rust/Golang这样把函数返回值声明在参数之后的，Solidity 还需要个专门的关键字来声明返回值，可能是因为区块链的严谨性，需要显式声明一切。

命名式返回(named return values) 是 [Golang 上](https://go.dev/tour/basics/7)也有的特性，只是我更习惯直接使用 return value 进行返回，既可以实现 early return, 也不用担心重构变量名之后，需要同步修改返回值中的变量名。

解构式赋值(Destructuring assignment), 一个很有用的特性，特别是一个函数会返回多个值的时候，可以直接对多个变量赋值。

#### 05 Data Storage

这个是 Solidity 特有的特性，需要指定数据存储的位置。因为 Solidity 运行在EVM上，存储上链的数据 ~storage~ 需要比较多的 gas, 而存储在内存上 ~memory/calldata~ 则相对便宜，那么 Solidity 的开发人员是否和60-70年代的开发者一样，需要为节省存储空间而绞尽脑汁优化程序呢？

这肯定是个有趣的体验。

从Java的角度来理解， ~storage~ 类似存储在堆上(heap), ~memory/calldata~ 存储在栈上(stack), 所以类(合约)实例的成员变量存储在 heap 上，函数变量存储在栈上

赋值操作在C++和Rust有比较多的规则，因为他们都是给开发者足够的自由度来管理内存，决定是否 copy，或者是 move. Solidity的赋值也给我类似的感觉，因为 gas fee的原因，所以 Solidity的赋值操作要兼具性能和成本考量.

- memory 与 memory 之间的赋值是创建新的引用
- storage 与 local storage 之间的赋值也是创建引用
- 其他情况都是复制值

<!-- Content_END -->
