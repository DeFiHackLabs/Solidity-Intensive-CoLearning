---
timezone: Asia/Shanghai
---

# FFFFourwood 

1. 自我介绍
Hello everyone, I'm FFFFourwood, but you can call me "Arthur". I work as a software engineer.  JS｜React｜ C#
2. 你认为你会完成本次残酷学习吗？
Fighting!!!!
   
## Notes

<!-- Content_START -->
### 2024.09.23
Solidity 简介
* Solidity 是用于编写以太坊智能合约的编程语言。
* 特点：基于对象、高级。
* 掌握 Solidity 可帮助理解区块链项目，规避风险，提升币圈参与感。

开发工具：Remix
* Remix 是以太坊官方推荐的智能合约开发工具，适合新手。
* 无需安装软件，直接在浏览器中编写、编译和部署合约。
* 网址：[Remix](https://remix.ethereum.org/)
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
```
* 第一行：声明软件许可（MIT），以注释开头。
* 第二行：声明使用的 Solidity 版本（0.8.21）。
* 第三行：定义合约 HelloWeb3，并声明变量 _string，值为 "Hello Web3!"。

Solidity 值类型 个人笔记
1. 布尔型
* 取值：true / false
* 运算符：!（非），&&（与），||（或），==（等于），!=（不等于）
* 短路规则：&& 遇到 false，|| 遇到 true，后续不执行。
  
2. 整型
* 有符号整型 int，无符号整型 uint。
* 运算符：+，-，*，/，%（取余），**（幂运算）。
* 示例：uint256 public _number = 20220330;

3. 地址类型
* 普通地址：address
* 可支付地址：payable address，可以接收以太币并调用 balance 查询余额。

4. 定长字节数组
* 定长字节：bytes1，bytes32，最多 32 字节。
* 示例：bytes32 public _byte32 = "MiniSolidity";

5. 枚举（enum）
* 定义多个状态，值从 0 开始。
* 可以与 uint 相互转换。

函数
* pure 函数不读不写链上状态。
* view 函数仅能读取状态变量。
* payable 函数可以接收以太币。
* 函数可见性（public、private、internal、external）决定函数的访问权限。

函数输出总结
1. 返回值：return 和 returns
* returns：声明函数的返回类型，位于函数名后面。
* return：函数内部使用，返回具体值。

2. 命名式返回
* 在 returns 关键字中声明返回变量的名称，Solidity 会自动初始化并返回这些变量。
* 你可以选择显式使用 return，也可以省略。

3. 解构式赋值
* 可以通过解构赋值读取函数的所有或部分返回值。
* 不需要的返回值可以留空，用 , 隔开。

### 2024.09.24

变量数据存储和作用域


1. 引用类型

引用类型包括数组和结构体，由于其占用存储空间大，必须明确声明数据存储的位置。常见的存储位置有：

	•	storage：用于合约的状态变量，数据存储在链上，消耗较多的 gas。
	•	memory：用于函数的参数和临时变量，数据存储在内存中，不上链。
	•	calldata：类似于 memory，但不可修改，常用于函数参数。

2. 数据位置的赋值规则

	•	storage to storage：创建引用，修改一个会影响另一个。
	•	memory to memory：创建引用，修改一个会影响另一个。
	•	其他情况：创建副本，修改副本不会影响原始变量。

3. 变量的作用域

Solidity 中变量的作用域分为三类：

	•	状态变量：存储在链上的变量，所有函数可访问，gas 消耗高。
	•	局部变量：仅在函数执行时有效，存储在内存中，gas 消耗低。
	•	全局变量：Solidity 预定义的变量，如 msg.sender、block.number、msg.data 等，函数内无需声明即可使用。

4. 以太单位与时间单位

	•	以太单位：wei、gwei、ether，分别代表不同的精度单位，确保交易精度。
	•	时间单位：seconds、minutes、hours、days、weeks，用于设定合约中的时间条件。


引用类型总结：数组（Array）和结构体（Struct）

1. 数组（Array）
- **固定长度数组**：在声明时指定长度，无法改变。  
- **可变长度数组（动态数组）**：长度不固定，可以动态改变。
- **创建规则**：
  - 动态数组用 `new` 创建，并需指定长度。
  - 数组字面常数初始化类型由第一个元素决定。

- **数组操作**：
  - `length`：获取数组长度。
  - `push()`：向数组末尾添加元素。
  - `pop()`：移除数组最后一个元素。

2. 结构体（Struct）
- 结构体用于创建自定义数据类型，元素可以是原始类型或引用类型。

- **赋值方法**：
  1. 通过 `storage` 引用赋值：
     ```solidity
     Student storage _student = student;
     _student.id = 11;
     ```
  2. 直接引用状态变量：
     ```solidity
     student.id = 1;
     ```
  3. 构造函数式赋值：
     ```solidity
     student = Student(3, 90);
     ```
  4. `key-value` 形式赋值：
     ```solidity
     student = Student({id: 4, score: 60});
     ```

- 数组和结构体是 Solidity 中的常用引用类型。数组支持固定和动态长度，常用成员方法包括 `push()` 和 `pop()`。结构体用于定义自定义数据类型，并有多种赋值方式。

映射类型（Mapping）总结

1. 映射（Mapping）简介
映射是一种存储键值对（key-value）的数据结构，类似哈希表。通过映射，可以根据键（Key）查询对应的值（Value）。

**映射声明格式：**
```solidity
mapping(_KeyType => _ValueType) public mappingName;
```


2. 映射的规则

- **规则1**：`_KeyType` 必须是 Solidity 内置的值类型（如 `uint`、`address`），不能是自定义类型。`_ValueType` 可以是自定义类型。

- **规则2**：映射的存储位置必须是 `storage`，因此映射适用于状态变量或函数中的 `storage` 变量。映射不能作为函数的参数或返回类型。

- **规则3**：声明为 `public` 的映射，Solidity 会自动创建一个 getter 函数来通过键查询值。

- **规则4**：向映射添加键值对的语法：
  ```solidity
  idToAddress[_Key] = _Value;
  ```

3. 映射的原理
- **原理1**：映射不存储键的具体信息，也没有长度（`length`）属性。
  
- **原理2**：映射通过 `keccak256(abi.encodePacked(key, slot))` 的哈希值作为偏移量存取对应的值。
  
- **原理3**：所有未赋值的键会有默认值。例如，`uint` 类型的默认值为 `0`。


4. 总结
映射是 Solidity 中常用的哈希表数据结构，通过键查询值。它不存储键的信息且未赋值的键有默认值。映射的键类型必须是内置值类型，存储位置必须是 `storage`。


### 2024.09.25


变量初始值
- Solidity 中，声明但未赋值的变量会有默认初始值，具体根据变量类型而定。

1. 值类型初始值
- **boolean**: `false`
- **string**: `""`（空字符串）
- **int**: `0`
- **uint**: `0`
- **enum**: 枚举的第一个元素
- **address**: `0x0000000000000000000000000000000000000000`（或 `address(0)`）
- **function**
  - **internal**: 空白函数
  - **external**: 空白函数


2. 引用类型初始值
- **映射（mapping）**: 所有元素都是默认值的映射。
- **结构体（struct）**: 所有成员设为默认值的结构体。
- **数组（array）**
  - **动态数组**: `[]`（空数组）
  - **静态数组（定长）**: 所有成员设为默认值的数组。


`delete` 操作符
- `delete` 操作符可以将变量的值重置为初始值。
  
### 2024.09.26

常量：constant 和 immutable 

常量：`constant` 和 `immutable` 总结

1. `constant` 关键字
- **特点**：`constant` 变量必须在声明时初始化，之后不能再改变。
- **作用**：提高合约的安全性和节省 gas。
- **支持的类型**：数值类型、`string` 和 `bytes` 可以声明为 `constant`，其他类型则不支持。

2. `immutable` 关键字
- **特点**：`immutable` 变量可以在声明时或构造函数（`constructor`）中初始化，但初始化后不能再改变。
- **灵活性**：可以通过构造函数或全局变量来初始化，例如 `address(this)`、`block.number`，或自定义函数返回值。
- **Solidity 版本影响**：在 Solidity v0.8.21 之后，`immutable` 变量不需要显式初始化，否则需要显式初始化。


3. 常见错误
- **修改 `constant` 变量**：会抛出错误 `TypeError: Cannot assign to a constant variable.`。
- **修改 `immutable` 变量**：会抛出错误 `TypeError: Immutable state variable already initialized.`。


- `constant` 和 `immutable` 关键字用于确保某些变量在初始化后不再改变，增加了合约的安全性和降低了 gas 消耗。


控制流与插入排序实现

1. 控制流
Solidity 的控制流与其他编程语言类似，主要包含以下几种：

- **if-else**
- **for 循环**
- **while 循环**
- **do-while 循环**
- **三元运算符**

2. Solidity 插入排序实现

正确的做法是确保 `j` 不会小于 1，从而避免负值问题：
```solidity
function insertionSort(uint[] memory a) public pure returns (uint[] memory) {
    for (uint i = 1; i < a.length; i++) {
        uint temp = a[i];
        uint j = i;
        while (j >= 1 && temp < a[j - 1]) {
            a[j] = a[j - 1];
            j--;
        }
        a[j] = temp;
    }
    return a;
}
```
**运行结果**：输入 `[2,5,3,1]`，输出 `[1,2,3,5]`。

### 2024.09.27

构造函数和修饰器总结

构造函数 (Constructor)
- 构造函数是一种特殊的函数，在合约部署时自动运行一次，用来初始化合约的参数。
- 每个合约可以定义一个构造函数，只能在部署时调用一次。

- **历史变化**: 在 0.4.22 之前，构造函数和合约同名。0.4.22 后改用 `constructor` 语法，避免函数名冲突导致的漏洞。

修饰器 (Modifier)
- 修饰器类似面向对象中的装饰器，主要用于函数运行前进行条件检查，减少代码冗余。
- 用法示例：定义一个 `onlyOwner` 修饰器，确保只有合约的 `owner` 地址能调用某个函数。
  ```solidity
  // 定义修饰器
  modifier onlyOwner {
     require(msg.sender == owner);  // 检查调用者是否是 owner 地址
     _;  // 继续执行函数主体
  }

  // 函数使用 onlyOwner 修饰器
  function changeOwner(address _newOwner) external onlyOwner {
     owner = _newOwner;
  }
  ```

OpenZeppelin的Ownable标准实现
- **OpenZeppelin** 维护了一套标准的 Solidity 合约库，`Ownable.sol` 是其中用于控制合约权限的标准实现。
- 通过定义 `onlyOwner` 修饰器来保护重要函数，仅允许合约所有者调用这些函数。
- 可以通过 Remix 测试 OpenZeppelin 的 Ownable 合约实现。





- **构造函数** 在合约部署时初始化参数，只能调用一次。
- **修饰器** 用于执行条件检查，例如权限控制，减少重复代码。
- **Ownable 合约** 是常见的权限控制实现，确保合约的关键操作只能由特定地址执行。

### 2024.09.28


事件
Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：
- **响应**：应用程序（如ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
- **经济**：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

声明事件
事件的声明由`event`关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。以ERC20代币合约的Transfer事件为例：


继承

继承是面向对象编程很重要的组成部分，可以显著减少重复代码。如果把合约看作是对象的话，Solidity也是面向对象的编程，也支持继承。

规则
- `virtual`: 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字。
- `override`: 子合约重写了父合约中的函数，需要加上`override`关键字。

注意：用`override`修饰public变量，会重写与变量同名的getter函数

多重继承

Solidity的合约可以继承多个合约。规则：

- 继承时要按辈分最高到最低的顺序排。
- 重写在多个父合约中都重名的函数时，`override`关键字后面要加上所有父合约名字。

### 2024.09.29



抽象合约
如果智能合约中至少有一个未实现的函数（即函数没有主体`{}`），该合约必须标为`abstract`，否则编译时会报错。未实现的函数需要加`virtual`关键字，以便子合约可以重写它。


接口
接口类似于抽象合约，但它不实现任何功能，且有以下规则：
- 不能包含状态变量。
- 不能包含构造函数。
- 不能继承除接口外的其他合约。
- 所有函数都必须是`external`且不能有函数体。
- 非抽象合约继承接口后，必须实现接口定义的所有功能。

接口定义了合约的功能及如何与之交互。如果一个合约实现了某个接口（如ERC20或ERC721），其他Dapps和合约就知道如何与它交互。接口提供两个关键信息：
1. 每个函数的`bytes4`选择器及函数签名。
2. 接口ID（EIP165标准）。

接口和合约ABI等价，接口可以转换为ABI，ABI也可用工具转为接口。


IERC721事件
- **Transfer**：转账时释放，记录发出地址`from`，接收地址`to`及`tokenId`。
- **Approval**：授权时释放，记录授权地址`owner`，被授权地址`approved`及`tokenId`。
- **ApprovalForAll**：批量授权时释放，记录发出地址`owner`，授权地址`operator`和授权状态。

IERC721函数
- `balanceOf`：返回某地址的NFT持有量。
- `ownerOf`：返回指定`tokenId`的持有人地址。
- `transferFrom`：普通转账，参数为转出地址、接收地址和`tokenId`。
- `safeTransferFrom`：安全转账，要求接收方（合约地址）实现ERC721Receiver接口。
- `approve`：授权另一个地址使用NFT。
- `getApproved`：查询指定`tokenId`授权给了哪个地址。
- `setApprovalForAll`：将自己持有的NFT批量授权给某个地址。
- `isApprovedForAll`：查询某地址的NFT是否已批量授权给另一个地址。
- `safeTransferFrom`：带有额外`data`参数的安全转账函数。
  
### 2024.09.30

Error
`error` 是 Solidity 0.8.4 版本新加的内容，方便且高效（省 gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数

Require
`require` 命令是 Solidity 0.8 版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是 gas 随着描述异常的字符串长度增加，比 `error` 命令要高。使用方法：`require(检查条件, "异常的描述")`，当检查条件不成立的时候，就会抛出异常。

Assert
`assert` 命令一般用于程序员写程序 debug，因为它不能解释抛出异常的原因（比 `require` 少个字符串）。它的用法很简单，`assert(检查条件)`，当检查条件不成立的时候，就会抛出异常。


三种方法的 gas 比较
我们比较一下三种抛出异常的 gas 消耗，通过 remix 控制台的 Debug 按钮，能查到每次函数调用的 gas 消耗分别如下：（使用 0.8.17 版本编译）

- `error` 方法 gas 消耗：24457 (加入参数后 gas 消耗：24660)
- `require` 方法 gas 消耗：24755
- `assert` 方法 gas 消耗：24473

我们可以看到，`error` 方法 gas 最少，其次是 `assert`，`require` 方法消耗 gas 最多！因此，`error` 既可以告知用户抛出异常的原因，又能省 gas

备注: Solidity 0.8.0 之前的版本，`assert` 抛出的是一个 panic exception，会把剩余的 gas 全部消耗，不会返还。更多细节见官方文档。


### 2024.10.01

重载
Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载
实参匹配（Argument Matching）
在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错

### 2024.10.02
今天好忙，心情也不好，断更打卡

### 2024.10.03
依旧加班 也没时间，心情也不好，断更打卡
<!-- Content_END -->
