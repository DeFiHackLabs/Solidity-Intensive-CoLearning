---
timezone: Asia/Tokyo
---

# Thurendous

1. 自我介绍
   Hi, 我是 Thurendous。30 岁开始转行，现在在做 Web3 相关的开发工作。喜欢新的领域，新的想法。
   希望通过学习巩固自己的已经知道的 Solidity 知识。同时能够培养自己的学习习惯。共勉进步！

2. 你认为你会完成本次残酷学习吗？
   会尽力而为，不中途放弃。培养习惯，提高自己。

## Notes

<!-- Content_START -->

### 2024.09.23

(Day 1)

今天开始复习 solidity 的内容。残酷共学的初衷和学习方式个人非常地喜欢！加油！一起！

学习笔记

#### Hello Web3 (三行代码)

- 学习了 solidity 就可以看懂合约代码，不会的话在区块链世界就会很 low（圈重点）。
- 写智能合约的话，需要做这些事情：
  - 写一个 license
    - License 是有各种各样的版本，MIT 是一个比较宽松和常见的。MIT 意味着任何人可以以任何方式使用，复制，修改，分发。甚至是商用你写的代码。还有一个 GPL 也是宽松的版本控制，但是他是要求你写的代码的源码必须公开。
  - 写版本
  - 写 import
  - 写合约的内容
- 可以使用 Remix 来进行智能合约的书写。
  - 在 Solidity Editor 中写代码
  - 在 Solidity Compiler 中编译
  - 然后进行部署按 deploy 按键
  - 然后就会有一个智能合约的 interaction 的界面，可以进行交互了。

#### 数据类型

值类型

- 布尔型
  - 只有两个值：true 和 false
  - 默认值是 false
- 整型
  - uint 无符号整数，正整数
  - int 有符号整数，正整数和负整数
  - uint 和 int 后面可以跟数字，表示这个整数有多少位。比如 uint8 就是 8 位，uint256 就是 256 位。uint 和 int 的取值范围是 0 到 2^n - 1。比如 uint8 的取值范围是 0 到 255，uint256 的取值范围是 0 到 2^256 - 1。
  - uint 和 int 默认是 uint256 和 int256。
- 地址类型
  - address 是一个 160 位的整数，表示一个以太坊地址。
  - address 可以用来表示一个账户的地址，也可以用来表示一个合约的地址。
  - 可以添加 payable 关键字，表示这个地址可以接收以太币。
- 定长字节数组
  - bytes1 到 bytes32，分别表示 1 到 32 个字节的字节数组。
  - 定长的 bytes 可以节省一些 gas。
  - 定长字节数组的长度是固定的，不能改变。
- 变长字节数组
  - bytes 是一个可变长度的字节数组。
  - bytes 的长度可以改变，可以存储任意长度的数据。
- 枚举 enum
  - 枚举类型是一个用户自定义的类型，可以用来表示一组有限的值。
  - 枚举（enum）是 Solidity 中用户定义的数据类型。它主要用于为 uint 分配名称，使程序易于阅读和维护。它与 C 语言 中的 enum 类似，使用名称来代替从 0 开始的 uint。
  - 枚举可以显式地和 uint 相互转换，并会检查转换的正整数是否在枚举的长度内，

另外的引用类型和映射类型以后会介绍到。

### 2024.09.24

(Day 2)

学习笔记

#### 函数

1. 函数

- 下边就是函数的知识点的全部。

```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

- 需要一个 function 的关键词定义
- name 就是函数名称
- <parameter types>就是参数
- 函数可见性说明
  - internal 是内部可见性，只能在当前合约内访问，不能被外部访问。
  - external 是外部可见性，只能被外部访问，不能在当前合约内访问。
  - public 是公共可见性，可以在当前合约内访问，也可以被外部访问。
  - private 是私有可见性，只能在当前合约内访问，不能被外部访问。
- 函数类型说明
  - pure 是纯函数，不能读取也不能写入状态变量。
  - view 是视图函数，不能写入状态变量，可以读取状态变量。
  - payable 是可支付函数，可以接收以太币。
  - 定义函数需要明确指出可见性。没有默认值。
- 函数返回值

  - 返回值是可选的，可以有返回值，也可以没有返回值。

2. 什么是 pure 和 view

因为区块链上需要支付燃气费用。而 pure 和 view 的函数被外部调用的话，是不需要支付燃气费用的。

以下动作在区块链上是被认为是修改链上的状态的。

- 修改状态变量
- 发出事件
- 创建其他合约
- 使用 selfdestruct 销毁合约
- 发送以太币
- 发送以太坊币
- 调用任何为标记 view 和 pure 的函数
- 使用低级调用（low-level calls）
- 使用包含某些操作码的内联汇编

- pure 函数

  - 不能读取也不能写入状态变量。
  - 不能使用 this
  - 不能访问当前合约的 storage、memory 或 calldata

- view 函数
  - 不能写入状态变量。
  - 可以读取状态变量。

如果函数被标记为乐 pure 或者 view，那这个函数就不能修改链上的状态。如果修改了，就会报错。

3. 什么是 payable 函数

payable 函数可以接收以太币。

4. 什么是 internal 函数

internal 函数是内部可见性，只能在当前合约内访问，不能被外部访问。

5. 什么是 external 函数

external 函数是外部可见性，只能被外部访问，不能在当前合约内访问。

6. 什么是 public 函数

public 函数是公共可见性，可以在当前合约内访问，也可以被外部访问。

7. 什么是 private 函数

private 函数是私有可见性，只能在当前合约内访问，不能被外部访问。

8. 什么是 returns

returns 是返回值，可以有返回值，也可以没有返回值。

#### 函数输出

1. return 和 returns

- returns：跟在函数名后面，用于声明返回的变量类型及变量名。
- return：用于函数主体中，返回指定的变量。

- 还可以同时返回多个变量

```solidity
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
```

这里的数组返回值的`uint256[3] memory`，memory 表示这个数组是存储在内存中的，不是存储在区块链上的。这个必须写上去。

这个数组之中的元素如果是[1,2,3]的话，会被默认称为 uint8 类型的变量。我们需要把第一个元素声明称为 uint256 类型的变量。

返回值的时候还可以如此声明和使用返回值：

```solidity
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```

当然了，你也可以这样来赋值了：

```solidity
// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

2. 结构式赋值

solidity 支持结构式赋值，可以同时返回多个变量。

- 用，隔开值的变量名称，然后赋值。

```solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```

- 还可以这样来赋值。如此赋值的话，就可以只取其中的某一个变量。

```solidity
(, _bool2, ) = returnNamed();
```

### 2024.09.25

(Day 3)

学习笔记

#### 变量数据存储和作用域 storage/memory/calldata

solidity 中的引用类型（Reference Type）

- array 数组、struct 结构体
- 由于这种数据类型比较复杂，占用的存储空间比较大。我们在使用的时候要声明数据的存储的位置。

- 数据的存储位置有三类

  - storage：永久存储在区块链上，直到合约被销毁。
  - memory：临时存储在内存中，函数调用结束后销毁。
  - calldata：只读，用于函数参数，不能修改。

- 数据存储位置的声明

```solidity
function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    //参数为calldata数组，不能被修改
    // _x[0] = 0 //这样修改会报错
    return(_x);
}
```

- 数据的位置和赋值规则
- 赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
  - storage（合约的状态变量）赋值给本地 storage（函数里的）时候，会创建引用，改变新变量会影响原变量。例子：
  - memory 赋值给 memory，会创建引用，改变新变量会影响原变量。

```solidity
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```

变量的作用域
solidity 之中作用域分成三种。分别是状态变量（state variable）、局部变量（local variable）、全局变量（global variable）。

- 状态变量（state variable）：合约的状态变量，永久存储在区块链上，直到合约被销毁。消耗 gas 比较高。
- 局部变量（local variable）：函数内部的变量，临时存储在内存中，函数调用结束后销毁。消耗 gas 比较低。
- 全局变量（global variable）：全局变量，这是 solidity 预留的关键字，他们在函数内不许要声明就可以直接食用。

```solidity
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```

在上面例子里，我们使用了 3 个常用的全局变量：msg.sender，block.number 和 msg.data，他们分别代表请求发起地址，当前区块高度，和请求数据。

全局变量 - 以太的单位和时间

- 以太单位
  Solidity 中不存在小数点，以 0 代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。

- wei: 1
- gwei: 1e9 = 1000000000
- ether: 1e18 = 1000000000000000000

- 时间单位
  可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在 Solidity 中是一个重要的概念，有助于提高合约的可读性和可维护性。

- seconds: 1
- minutes: 60 seconds = 60
- hours: 60 minutes = 3600
- days: 24 hours = 86400
- weeks: 7 days = 604800

### 2024.09.26

(Day 4)

学习笔记

#### 引用类型

- 数组 array
  - 数组是 solidity 的常用的一种变量，用来存储一组数据（整数、字节、地址等等）。数组分为固定长度数组和可变长度数组两种：
- 固定长度数组：数组的长度是固定的，不能改变。用｀ T[k]｀表示，T 是数组类型，k 是数组长度。

```solidity
uint256[8] array1; // 8个元素的数组，元素类型为uint256
bytes1[5] array2; // 5个元素的数组，元素类型为bytes1
address[100] array3; // 100个元素的数组，元素类型为address
```

- 可变长度数组：数组的长度是可变的，可以随时改变。用 `T[]`表示，`T` 是数组类型。

```solidity
uint256[] array4; // 可变长度的数组，元素类型为uint256
bytes1[] array5; // 可变长度的数组，元素类型为bytes1
address[] array6; // 可变长度的数组，元素类型为address
bytes array7; // 可变长度的数组，元素类型为bytes
```

`bytes`很特殊，是一个数组。但是不用加 `[]`。

- 创建数组的规则：

  - 对于 memory 修饰的动态数组。可以使用 new 操作符来创建。但是必须声明长度。并且声明后长度不能改变。
  - 例子：

```solidity
uint256[] memory array8 = new uint256[](3); // 创建一个长度为3的数组，元素类型为uint256
bytes memory array9 = new bytes(5); // 创建一个长度为5的数组，元素类型为bytes
```

- 数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化 array 的一种方式，并且里面每一个元素的 type 是以第一个元素为准的，例如[1,2,3]里面所有的元素都是 uint8 类型，比如`[1,2,3]`里面所有的元素都是 uint8 类型。
- solidity 中，如果一个值没有置顶 type 的话，会根据上下文推断出元素的类型。默认就是最小单位的 type。

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract C {
    function f() public pure {
        g([uint(1), 2, 3]);
    }
    function g(uint[3] memory _data) public pure {
        // ...
    }
}
```

这里的 `uint(1), 2, 3` 是字面常数，`[uint(1), 2, 3]` 是数组字面常数。

```solidity
uint[] memory x = new uint[](3);
x[0] = 1;
x[1] = 3;
x[2] = 4;
```

- 动态数组可以用以上的方式来赋值。

- 结构体 struct
  - 结构体是用户自定义的复合类型，可以用来表示一组相关的数据。

```solidity
// 结构体
struct Student{
    uint256 id;
    uint256 score;
}

Student student; // 初始一个student结构体
```

结构体赋值的 4 种方式：

- 直接赋值

```solidity
//  给结构体赋值
// 方法1:在函数中创建一个storage的struct引用
function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
}
```

记住这里必须使用 storage 的指定方式。否则这里会出现问题的。有的 Defi 协议就因此被黑了。

- 直接引用状态变量的 struct

```solidity
// 方法2:直接引用状态变量的struct
function initStudent2() external{
    student.id = 1;
    student.score = 80;
}
```

- 构造函数式

```solidity
// 方法3:构造函数式
function initStudent3() external {
}
```

- key value 赋值

```solidity
// 方法4:key value
function initStudent4() external {
    student = Student({id: 4, score: 60});
}
```

### 2024.09.27

(Day 5)

学习笔记

#### 映射 mapping

- 映射是 solidity 中的一种数据类型，用来存储一组键值对。
- 映射的类型是 `mapping(_KeyType => _ValueType)`。
- 映射的值类型可以是任何类型，包括数组、结构体、映射等。
- 映射的键类型不能是映射类型。

注：现在的映射可以支持用变量名进行声明。

```solidity
// 映射
mapping(address wallet => string name) students;
```

映射的规则：

- 映射的类型需要使用 solidity 内置的基本类型。比如 uint256、address、string、bytes 等。不可以使用自定义类型。而 value 可以使用自定义类型。
- 映射的存储位置必须是 storage。因此可以使用合约的状态变量。
- 如果映射为 public，那么 solidity 会给你创建一个 getter 函数，可以通过 key 来查询对应的 value。
- 给映射新增的键值对的语法是`var[key]=value`。其中 var 是一个映射变量。

#### 变量初始值

- solidity 中， 声明但没有赋值的变量都有一个默认的初始值。

  - boolean: false
  - string: ""
  - int: 0
  - uint: 0
  - enum: 枚举中的第一个元素
  - address: 0x0000000000000000000000000000000000000000 (或 address(0))
  - function

    - internal: 空白函数
    - external: 空白函数

- mapping：初始值都是所有元素的默认值
- 结构体 struct：所有元素的默认值
- 数组 array：所有元素的默认值

我们来验证初始值是否正确：

```solidity
// Reference Types
uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // `[]`
mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
// 所有成员设为其默认值的结构体 0, 0
struct Student{
    uint256 id;
    uint256 score;
}
Student public student;
```

delete 操作符会让这个变量变为初始值。

```solidity
// delete操作符
bool public _bool2 = true;
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}
```

#### 常数

solidity 的合约之中，通常有两个关键字：constant 和 immutable。

- constant

  - 常数在合约编译时就确定了，不能修改。
  - 常数必须被初始化，不能在函数中初始化。
  - 常数可以被声明为 public，solidity 会自动创建一个 getter 函数，可以通过 key 来查询对应的 value。

- immutable

  - immutable 是不可变的，在合约编译时就确定了，不能修改。
  - immutable 可以被声明为 public，solidity 会自动创建一个 getter 函数，可以通过 key 来查询对应的 value。
  - 如果一个变量在声明时初始化，又在 constructor 之中初始化，那么会优先 constructor 的初始化。

- constant 和 immutable 的区别

  - constant 在合约写下来的时候就确定了，不能修改。
  - immutable 在合约部署时的构造函数之中初始化，之后不能修改，更加的灵活。

- constant 变量初始化之后，尝试改变它的值，会编译不通过并抛出 TypeError: Cannot assign to a constant variable.的错误。
- immutable 变量初始化之后，尝试改变它的值，会编译不通过并抛出 TypeError: Immutable state variable already initialized.的错误。

<!-- Content_END -->