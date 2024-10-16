---
timezone: Asia/Shanghai
---

---
# 卡卡

1. 自我介绍 <br>
一名计算机技术爱好者，从事计算机安全领域的工作。不久前接触到区块链，被去中心化的愿景所吸引。打算深入学习相关的技术，期待与大佬们交流学习！

2. 你认为你会完成本次残酷学习吗？ <br>
一定的！
   
## Notes

<!-- Content_START -->

### 2024.09.15
学习内容：了解规则，完成报名。

### 2024.09.23
学习内容：<br>
学习第一讲的内容，了解了Solidity语言大概的结构，并在Remix上运行hello world程序。

### 2024.09.24
学习内容：<br>
#### 基础数据类型：

布尔类型：`bool`，值为`true`或`false`。

整数类型：有符号整数`int`和无符号整数`uint`。大小均为256 bits

可以指定不同位数，如`int8` `int16` `int32` .... `int256`(也即int)

地址类型：`address`用于存储20字节的以太坊地址。分为payable和非payable两种。



#### 复杂数据结构：

数组`array`：

支持定长数组和动态数组。数组中的元素可以是任何类型。

```
// 定长数组
uint[5] fixedArray = [1, 2, 3, 4, 5];

// 动态数组
uint[] dynamicArray;
```

`bytes`和`string`类型的变量是特殊的`arrays`。他们有一些相应的函数。

字节类型：`bytes`和`byte`。`byte`是定长的字节数组，等价于`bytes1`。`bytes`是动态字节数组。

```
bytes32 fixedByteArray = "Hello"; // 固定长度为32的字节数组
bytes dynamicByteArray = "Hello";  // 动态字节数组
```

字符串：`string`，动态大小的UTF-8编码字符串。

映射`mapping`：

键值对数据结构。键需要为基础数据类型，而值可以是任意类型。映射不支持遍历或取出所有键值对，但可以通过键访问对应的值。

结构体`struct`：

枚举`enum`：用于定义一组离散的常量，便于处理有限状态的情况。



引用类型有：`struct`、`array`、`mapping`。如果使用引用类型，则始终必须显式提供存储该类型的数据区域

每个引用类型都有一个附加注释，即“data location”，说明其存储位置。data location有三个选择：`memory`、`storage`、`calldata`

- memory：其生命周期仅限外部函数调用；
- storage：状态变量存储的位置，其生命周期仅限于合约的生命周期；
- calldata：包含函数参数的特殊数据位置；一个不可修改、非持久的区域，用于存储函数参数。

行为：

- storage和memory（或来自 calldata）之间的赋值总是创建一个独立的副本。
- 从memory到memory的赋值仅创建引用。
- 从storage到本地存储变量(**local**)的赋值也仅分配一个引用。
- 对存储的所有其他分配始终进行复制。这种情况的示例是对状态变量或存储结构类型的局部变量的成员的赋值，即使局部变量本身只是一个引用。???


### 2024.09.25
学习内容：<br>
`require`和`assert`是用于进行条件检查的函数。

`require(condition, "Error message")` 用于确保条件为真，如果条件为假，合约将抛出异常并回滚。

`assert(condition)` 通常用于检查逻辑错误。如果条件为假，将导致所有状态变化被回滚，并消耗所有的 Gas。



Solidity使用状态恢复（state-reverting）异常来处理错误。此类异常会撤销当前调用（及其所有子调用）中对状态所做的所有更改，并向调用者标记错误。

**revert**：

回滚可以被revert语句和revert函数触发。

```
// revert语句
revert CoustomError(arg1,arg2);
// revert函数
revert();
revert("description");
```

使用自定义错误示例通常比字符串描述便宜得多

自定义error

### 2024.09.26
学习内容：<br>
内建函数：msg

- msg.sender：消息调用者
- msg.data：完整的调用数据，不可修改，函数参数存储在其中；
- msg.gas：返回当前交易剩余的可用gas
- msg.sig：函数调用数据的前四个字节，指定要调用的函数；
- msg.value：通过消息发送给合约的wei的数量

gasleft()是一个内置的Solidity函数，它返回当前以太坊交易中剩余的gas量。

### 2024.09.27
**学习内容：**<br>
Interfaces，接口。常用于标准化合约，如ERC20和ERC721等标准。

1. 不能有任何函数实现；
2. 不能继承合约，但可以继承接口；
3. 所有声明的函数必须是`external`，即使它们是`public`的；
4. 不能声明构造器；
5. 不能声明状态变量；
6. 不能声明modifiers；

interfaces中声明的所有函数都是隐式虚拟(`virtual`)的，并且任何重写它们的函数都不需要`override`关键字。

### 2024.09.28
**学习内容：**<br>
- storage和memory（或来自 calldata）之间的赋值总是创建一个独立的副本。
- 从memory到memory的赋值仅创建引用。
- 从storage到本地存储变量(**local**)的赋值也仅分配一个引用。
- 对存储的所有其他分配始终进行复制。这种情况的示例是对状态变量或存储结构类型的局部变量的成员的赋值，即使局部变量本身只是一个引用。

### 2024.09.29
**学习内容：**<br>
在以太坊链上，除了外部账户外，智能合约也可以创建合约。有两种方法：`create`和`create2`。

对于create：

```
new_address = keccak256(sender, nonce);
```

对于create2：

```
new_address = keccak256(0xFF, sender, salt, bytecode);
```



create用法就是new一个合约，并传入新合约构造函数所需的参数：

```
Contract x = new Contract{value: _value}(params)
```



create2的内联汇编方式：

```
function deploy(
        bytes memory bytecode,
        uint _salt
    ) public payable returns (address) {
        address addr;

        assembly {
            addr := create2(
                callvalue(), // wei sent with current call
                // Actual code starts after skipping the first 32 bytes
                add(bytecode, 0x20),
                mload(bytecode), // Load the size of code contained in the first 32 bytes
                _salt // Salt from function arguments
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        return addr;
    }
```
### 2024.09.30
**学习内容：**<br>
Solidity是静态类型语言，需要指定变量的状态和位置。

Solidity中不存在`undefined`、`null`的概念，但变量会有相应的默认值。

值类型（Value Types）:值类型变量将始终按值传递（copy）

`bool`:true/false。`||`与`&&`有短路属性。

**整数类型**：有符号整数`int`和无符号整数`uint`。大小均为256 bits。可以指定不同位数，如`int8` `int16` `int32` .... `int256`(也即int)

操作符：`<=  <  ==  !=  >=  >`、`&  |  ^  ~`、`<<  >>`、`+  -  *  /  %  **`

除法的结果朝0取整。

对于整数类型X，可以`type(X).min  type(X).max`获取该类型的最小值和最大值，如`type(uint).min`

> 有两种模式在这些类型上执行算术：“wrapping”或“unchecked”模式和“checked”模式。默认情况下，算术始终是“checked”的，这意味着如果操作的结果不在类型的值范围之内，则该调用将通过失败的断言恢复。您可以使用unchecked{...}切换到“未选中”模式。有关未检查的部分，请参阅更多细节。

`fixed/ufixed`：固定精度

**地址类型**：`address`用于存储20字节的以太坊地址。分为payable和非payable两种。带有payable可以多两个操作transfer和send。eg：`payable(<address>)`

> Explicit conversions to and from `address` are allowed for `uint160`, integer literals, `bytes20` and contract types.

```solidity
address payable x = payable(0x123);
address myAddress = address(this);
if (x.balance < 10 && myAddress.balance >= 10) x.transfer(10);
```

address类型的成员：balance、transfer、send、call、delegatecall、staticcall、code、codehash。

addr.code查询合约的部署代码，addr.codehash == keccak256(addr.code)，但addr.codehash更cheaper

固定大小的字节数组： `bytes1`, `bytes2`, `bytes3`, …, `bytes32` 。成员`.length`

> The type `bytes1[]` is an array of bytes, but due to padding rules, it wastes 31 bytes of space for each element (except in storage). It is better to use the `bytes` type instead.

常量值：solidity不存在Octal。小数`1.3`、`.3`。

支持科学注释法：`MeE` -> `M * 10**E`

下划线可以分隔常量: `123_000`、`0x2eff_abde`、`1_2e345_678`（科学注释法也适用）

字符串常量可单双引号`"foo"`、`'bar'`，也可以分开`"foo" "bar"` = `"foobar"`，这个特性在处理长字符串会有用。字符串常量没有后置0，`"foo"`就是代表了3个字节。

字符串常量支持转义字符：`\<newline>`、`\\`、`\'`、`\"`、`\n`、`\r`、`\t`.....

适用unicode前缀可以支持utf-8序列:`string memory a = unicode"Hello 😃";`

16进制常量以`hex`为前缀：`hex"001122FF"`、`hex'0011_22_FF'`。空白格可以进行隔离：

`hex""00112233" hex"44556677"` = `hex"0011223344556677"`

Enum是solidity中的一个用户自定义类型，可以显式地与整数类型转换。Enum至少需要一个成员，最多256个。`type(NameOfEnum).min`和`type(NameOfEnum).max`可以获得最小最大值。

User-defined Value Types：`type C is V`，给V取别名，但其有着本质区别。

`C.warp()`从基础类型到别名， `C.unwrap()`从别名到基础类型

函数类型有两种：internal 、external。内部函数只能在当前代码单元调用，外部函数由地址和函数签名组成。默认情况下，函数类型是内部的，可以省略。

```
function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
```

函数类型在参数、返回类型、内外部属性相同时，可以隐式转换，但需要从限制大的变为限制小的。

`pure => view/non-payable` `view => non-payable` `payable => non-payable`

函数变量的成员：`.address`返回函数所在合约的地址，`.selector`返回函数选择器。

在调用函数时，可以指定gas和要发送的ether：`this.f{gas: 10, value: 800}();`

### 2024.10.01
**学习内容：**<br>
ERC, Ethereum Request for Comments. 即：以太坊征求意见。是以太坊开发者的协议提案，是以太坊智能合约开发人员使用的技术文档，为以太坊生态系统中的特定用户组提供方法、创新、研究和特征的规范。这些文档通常由开发人员创建，并且包含有关协议规范和合约说明的信息。

任何人都可以创建ERC，但它需要通过以太坊改进提案（EIP）的流程。

常见：ERC-20、ERC-777为同质化代币标准，ERC-721、ERC-1155为非同质化代币标准。

### 2024.10.02
**学习内容：**<br>
event和emit：

`event` 是Solidity中声明事件的关键字。事件类似于日志记录，允许合约将一些数据记录到区块链的日志中。这些日志可以被外部应用程序监听和处理。

`emit` 是用于触发事件的关键字。当事件被触发时，它会将指定的数据记录到区块链的日志中，并且外部应用可以监听这些日志。

外部应用程序（例如使用Web3.js或Ethers.js的前端应用）可以监听并处理合约触发的事件。

### 2024.10.03
**学习内容：**<br>
引用类型包括：struct、array、mapping。使用引用类型，则必须显式提供数据区域：memory、storage、calldata

> 更改数据位置的赋值或类型转换将始终引发自动复制操作，而同一数据位置内的赋值在某些情况下仅复制存储类型。

固定数组：T[k]，动态数组：T[ ]。eg：`uint[][5]`：含有5个动态数组的数组。.push()和.push(value)用于在动态数组末尾附加新元素。

### 2024.10.04
**学习内容：**<br>
库函数是一种特殊的合约，为提升solidity代码的复用性和减少gas而存在。

与普通合约的不同点：

1. 不能存在状态变量；
2. 不能继承或被继承；
3. 不能接收以太币；
4. 不可以被销毁；

常见的库合约有`String`、`Address`、`Create2`、`Arrays`

### 2024.10.05
**学习内容：**<br>
Hardhat：https://hardhat.org/

配置文件：hardhat.config.js

`npx hardhat compile` 编译合约

单元测试，需要编写js脚本，会用到chai和ethers.js两个库，分别用于测试和链上交互。最好运行测试`npx hardhat test`

部署合约，在remix只需点击`deploy`就可以部署，不过在本地hardhat需要编写部署脚本。hardhat会提供一个默认网络进行部署，`npx hardhat run --network hardhat  scripts/deploy.js`

通过配置hardhat.config.js，也可以部署到非本地测试网

### 2024.10.06
**学习内容：**<br>
合约给用户转账的方法：

1、transfer：会自动转送2300gas给接收方，用于执行其fallback函数。如果fallback函数使用超过2300gas，转账将失败，并回滚交易。（安全性比较好）但0.8版本后，gas限额改变

```
address payable recipient = payable(0xRecipientAddress);
recipient.transfer(1 ether);

```

2、send：

与transfer类似，不过在失败时不会抛出异常，而是返回false，可让合约处理异常情况。（因为需要手动处理失败情况，所以安全性不如transfer）

```
address payable recipient = payable(0xRecipientAddress);
bool success = recipient.send(1 ether);
require(success, "Send failed");
```

3、call方法：

call是一个底层函数，用于发起外部函数调用。因为它蕴蓄指定要发送的gas量，因此也算是可以用于转账。交易失败返回false，需要手动处理异常。

```
(bool success, ) = payable(0xRecipientAddress).call{value: 1 ether}("");
require(success, "Call failed");
```

### 2024.10.07
**学习内容：**<br>
Hardhat中内置了Hardhat Network，一个专门为开发而设计的本地以太坊网络，允许部署合约、运行测试和调试代码。

Hardhat是使用JavaScript编写的，因此需要本地环境配置Node.js（version >= 18.0）。

创建一个新的Hardhat项目，通过npm安装Hardhat

```
npm init   // 初始化npm项目
npm install --save-dev hardhat   // 安装Hardhat
npx hardhat init    // 初始化Hardhat项目
```

Hardhat项目的配置文件：`hardhat.config.js`

Hardhat是围绕**任务**和**插件**的概念设计的。

任务：每次从命令行运行Hardhat时，都看作是在运行一项任务。如：`npx hardhat compile`是要运行编译任务。（也可以创建任务）

```
npx hardhat   // 查看当前可用的任务
npx hardhat help [task]  // 任务手册
```

插件：

> Hardhat 不会对您最终使用的工具发表意见，但它确实带有一些内置默认值。所有这些都可以被覆盖。大多数情况下，使用给定工具的方式是使用将其集成到 Hardhat 中的插件。

推荐的一个插件：`@nomicfoundation/hardhat-toolbox`, 拥有开发智能合约的一切

```
npm install --save-dev @nomicfoundation/hardhat-toolbox  // 安装
```

在`hardhat.config.js`中添加：

```
require("@nomicfoundation/hardhat-toolbox");
```

### 2024.10.08
**学习内容：**<br>
配置环境变量：

```
npx hardhat vars set TEST_API_KEY // 设置环境变量
npx hardhat vars get TEST_API_KEY  // 获取
npx hardhat vars list   // 列出所有变量
npx hardhat vars deletes TEST_API_KEY  // 删除
npx hardhat vars setup  // 列出所有
```



创建智能合约：

新建`contracts`目录，用于存放.sol合约文件。

在项目根目录执行：`npx hardhat compile`进行编译。

### 2024.10.09
**学习内容：**<br>
`IERC721`是`ERC721`标准的接口合约，规定了`ERC721`要实现的基本函数。它利用`tokenId`来表示特定的非同质化代币，授权或转账都要明确`tokenId`；而`ERC20`只需要明确转账的数额即可。

在编写和部署 ERC721 合约时，使用 OpenZeppelin 的实现可以简化很多工作，因为它们已经实现了 IERC721、IERC721Receiver 和 IERC721Metadata 接口。

- **IERC721Receiver**：用于处理 ERC721 代币的安全转账。如果接收方是合约，必须实现这个接口来接受代币。
- **IERC721Metadata**：扩展了 ERC721 标准，允许设置代币的名称、符号和每个代币的 URI。

### 2024.10.10
**学习内容：**<br>
 Gas 优化：

Solidity 中的 Gas 是针对可能导致以太坊网络资源耗尽的攻击的一种防御措施。由于以太坊在去中心化平台上运行智能合约，因此恶意人士可能会试图耗尽所有资源来干扰网络。为了防止这种情况发生，以太坊网络使用一种称为“gas”的系统来限制在单个交易或函数执行中可以完成的工作量。

存储优化：

1. 最小化链上数据：减少存储在合约变量中的数据量。
2. 变量打包：尽可能地将多个变量合并到一个存储槽中。（通过struct）

退款：

1. 释放存储槽：当不在需要存储槽时，将其值设置为零可导致大量gas退款。
2. 使用自毁：Solidity中的`selfdestruct`操作码可用于从区块链中删除合约。使用此操作码销毁合约时，会退还24,000gas。

### 2024.10.11
**学习内容：**<br>
跨链桥是一种区块链协议，它允许在两个或多个区块链之间移动数字资产和信息。（跨链桥不是区块链原生支持的，跨链操作需要可信的第三方来执行）

跨链桥的三种类型：

1. Burn/Mint
2. Stake/Mint
3. Stake/Unstake

通过js脚本作为桥梁，监听一条链上的跨链操作，然后触发，执行另外一条链的反应操作。
### 2024.10.15
**学习内容：**<br>
OpenZeppelin 是一个用于构建、管理和审计智能合约的开源框架，特别在以太坊区块链生态系统中非常流行。它提供了一组经过审计的智能合约库，旨在帮助开发者快速、安全地创建和部署区块链应用程序。

`npm install @openzeppelin/contracts`

<!-- Content_END -->
