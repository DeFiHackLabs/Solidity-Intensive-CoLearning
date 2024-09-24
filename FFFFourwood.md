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

<!-- Content_END -->
