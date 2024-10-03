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

### 2024.09.28

Holiday

### 2024.09.29

(Day 6)

学习笔记

#### 控制流

Solidity的控制流和其他语言类似。主要包含以下几种。

1. if else 语句

```solidity
if (condition) {
    // 执行代码
} else if (condition) {
    // 执行代码
} else {
    // 执行代码
}
```

2. for 循环

```solidity
for (uint i = 0; i < 10; i++) {
    // 执行代码
}
```

3. while 循环

```solidity
while (condition) {
    // 执行代码
}
```

4. do while 循环

```solidity
do {
    // 执行代码
} while (condition);
```

5. 三元运算符

```solidity
condition ? expression1 : expression2
```

6. break 和 continue也可以使用。


创建一个排序的算法在soliidty之中的时候，会碰到一个坑。这个坑就是

问题的代码：

```solidity
    // 插入排序 错误版
function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {    
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i-1;
        while( (j >= 0) && (temp < a[j])){
            a[j+1] = a[j];
            j--;
        }
        a[j+1] = temp;
    }
    return(a);
}
```

正确的代码：

```solidity
// 插入排序 正确版
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // note that uint can not take negative value
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i; // use `i` not `i-1`
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}
```

这里的错误主要是：

- j的值可能会取到赋值，而这里的j是uint类型的，就会出现一个underflow的错误。所以必须要按照正确的代码的样式来写代码才能正常运行。


#### 构造函数和修饰器

- 构造函数
  - 构造函数是一个特殊的函数，他只会在被部署的时候运行一次。用来初始化我们的函数。
  - 注意，构造函数在不同的solidity的版本之中有不同的运行规则的。语法也不太一样的。
-> 构造函数在不同的Solidity版本中的语法并不一致，在Solidity 0.4.22之前，构造函数不使用 constructor 而是使用与合约名同名的函数作为构造函数而使用，由于这种旧写法容易使开发者在书写时发生疏漏（例如合约名叫 Parents，构造函数名写成 parents），使得构造函数变成普通函数，引发漏洞，所以0.4.22版本及之后，采用了全新的 constructor 写法。

构造函数的旧写法代码示例：
```solidity
pragma solidity =0.4.21;
contract Parents {
    // 与合约名Parents同名的函数就是构造函数
    function Parents () public {
    }
}
```

构造函数的最新写法代码示例：

```solidity
pragma solidity >=0.4.22;
contract Parents {
    constructor() public {
    }
}
```


- 修饰器

修饰器是一种特殊的函数，它可以在函数执行之前或之后执行一些额外的代码。修饰器通常用于验证函数调用者的权限、检查某些条件是否满足等。

修饰器的语法如下：

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
}

function someFunction() public onlyOwner {
    // 只有所有者可以调用这个函数
}
```

### 2024.09.30

(Day 7)

学习笔记

#### 事件

事件就是solidity中的events。这个event是EVM上的一个日志的抽象。
它具有两个特点：
- 响应：event可以被区块链之外的工具所响应。比如可以被前端应用所响应。前端可以通过rpc订阅这个event，然后做出响应。
- 经济：事件是EVM之上比较经济的存储数据的方式。每个大概消耗2,0000gas。相比之下，链上存储一个数据起码要消耗20,000gas。

事件的语法：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);

// 定义_transfer函数，执行转账逻辑
function _transfer(
    address from,
    address to,
    uint256 amount
) external {

    _balances[from] = 10000000; // 给转账地址一些初始代币

    _balances[from] -=  amount; // from地址减去转账数量
    _balances[to] += amount; // to地址加上转账数量

    // 释放事件
    emit Transfer(from, to, amount);
}
```

- 其中from和to前面带有indexed关键字，他们会保存在以太坊虚拟机日志的topics中，方便之后检索。
- 事件的名称：Transfer
- 事件的参数：address indexed from, address indexed to, uint256 value

主题（topics）

日志的第一部分是主题的数组。用于描述事件，长度不超过4。他的第一个元素是事件的签名。

当我们看这个Transfer的event在etherscan之上的时候，我们看到的是：
- 0是这个event的哈希。
- 1是这个from的地址
- 2是这个to的地址
- data之中时这个转账的value的值

#### 继承

继承是面向对象编程的一个重要的组成。可以显著减少代码。

- 规则
  - virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
  - override：子合约重写了父合约中的函数，需要加上override关键字。

- 语法

```solidity
// 父合约
contract Parent {
    function inheritFunction() public virtual returns (string memory);
}

// 子合约
contract Child is Parent {
    function inheritFunction() public override returns (string memory) {
        return "Child function";
    }
}
```

多重继承
- Solidity的合约可以继承多个合约。规则：

继承时要按辈分最高到最低的顺序排。比如我们写一个`Erzi`合约，继承`Yeye`合约和`Baba`合约，那么就要写成`contract Erzi is Yeye, Baba`，而不能写成`contract Erzi is Baba, Yeye`，不然就会报错。

如果某一个函数在多个继承的合约里都存在，比如例子中的`hip()`和`pop()`，在子合约里必须重写，不然会报错。

重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。

修饰起的继承

```solidity
contract Base1 {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}
```

Identifier合约可以直接使用这个修饰起了。

```solidity
modifier exactDividedBy2And3(uint _a) override {
    _;
    require(_a % 2 == 0 && _a % 3 == 0);
}
```

构造函数的继承

```solidity
// 构造函数的继承
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
```

构造函数有两种继承方式：
1. 在继承的时候声明父构造函数的参数，例如：`contract C is A(2)`
2. 在构造函数中声明父构造函数的参数，例如下面的代码：

```solidity
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```

调用父合约的函数
- 子合约有两种方式调用父合约的函数，直接调用和利用super关键字。

- 直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，例如Yeye.pop()

```solidity
function callParent() public{
    Yeye.pop();
}
```


很重要的点：
- **super关键字：子合约可以利用super.函数名()来调用最近的父合约函数。Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()：**

```solidity

function callParentSuper() public{
    // 将调用最近的父合约函数，Baba.pop()
    super.pop();
}
```

钻石继承

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {
    event Log(string message);

    function foo() public virtual {
        emit Log("God.foo called");
    }

    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {
    function foo() public virtual override {
        emit Log("Adam.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
```

这个合约之中，如果呼叫bar函数的话，那么会先呼叫Eve合约的bar，然后是Adam合约的bar，最后是God合约的bar。

### 2024.10.1

(Day 8)

学习笔记

#### 抽象合约和接口

- 抽象合约

抽象合约里边有一个函数没有被实现。即这个函数缺少主体的{}内容。那么这个合约就应该被定义为抽象合约（abstract），否则编译器会报错。

未实现的函数必须加上一个关键字：`virtual`。以便合约重写。比如以下的例子：

```solidity
abstract contract A {
    function f() public virtual returns (string memory);
}
```

- 接口

接口和抽象合约很像，但是接口之中的函数都是没有实现的。接口之中的函数都是抽象的。接口之中的函数都是没有实现的。接口之中的函数都是没有实现的。

- 不能有状态变量
- 不能有构造函数
- 不能继承除了接口之外的其他合约
- 不能有函数实现
- 所有函数都需要是external且不能有函数体
- 继承接口的非抽象合约必须实现接口定义的所有的功能

举例：
```solidity
interface I {
    function f() external returns (string memory);
}
```

接口合约虽然不能实现任何功能，但是他非常的重要。接口是智能合约的骨架，定义了合约的功能以及如何触发他们：如果合约实现了某接口，那么其他的Dapps和智能合约就知道该如何与之交互了。因为接口提供了两个重要的信息：

1. 合约中每个函数的bytes4的函数选择器，以及函数签名`function(type argumentName)`.
2. 接口的id

另外，接口和ABI等价，可以互相转换：编译接口可以得到合约的ABI，ABI也可以转换为接口的sol文件。


#### 异常
这一讲我们讲3种solidity的抛出异常的方法：

1. error
2. require
3. assert


1. Error

error是solidity 0.8.4引入的新的异常处理方式。方便高效，节省gas。可以给用户解释操作失败的原因。方便开发者调试。

```solidity
error NotEnoughBalance(uint256 balance, uint256 required);

function withdraw(uint256 amount) public {
    if (balance < amount) {
        revert NotEnoughBalance({balance: balance, required: amount});
    }
}
```


2. Require

require的命令是0.8.0之前的抛出异常的方式。目前很多的主流的合约仍然在使用它。很好用。
唯一的缺点就是gas随着描述异常的字符串长度增加而增加。

使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。

```solidity
function transferOwner2(uint256 tokenId, address newOwner) public {
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    _owners[tokenId] = newOwner;
}
```

3. Assert

assert的命令是用于检查内部错误。比如，当一个变量应该总是为真的时候，就可以使用assert。

assert命令一般用于程序员写程序debug，因为它不能解释抛出异常的原因（比require少个字符串）。它的用法很简单，assert(检查条件），当检查条件不成立的时候，就会抛出异常。


```solidity
function transferOwner3(uint256 tokenId, address newOwner) public {
    assert(_owners[tokenId] == msg.sender);
    _owners[tokenId] = newOwner;
}
```

- 三种方法的gas比较

1. error: 24457(加入参数后的gas消耗: 24660)
2. require: 24755
3. assert: 24473

我们可以看到，这里的error方法的gas是最少的。其次是assert，require方法消耗的gas最多！
assert在0.8.0之后的版本之中，不会消耗掉所有的剩余gas而是和revert一样，回滚然后返还gas给用户。

#### 函数重载

函数重载是指在同一个合约中，可以有多个函数名相同但参数类型或数量不同的函数。

```solidity
function myFunction(uint256 a) public pure returns (uint256) {
    return a * 2;
}
```

注意solidity不允许修饰器重载。

如果两个函数名相同，但是参数类型不同，那么这两个函数就是不同的函数。因为最终重载函数在经过编译器编译后，由于不同的参数类型，都变成了不同的函数选择器（selector）。


- 实参匹配（Argument Matching）
在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。下面这个例子有两个叫f()的函数，一个参数为uint8，另一个为uint256

```solidity
function f(uint8 a) public pure returns (uint8) {
    return a * 2;
}

function f(uint256 a) public pure returns (uint256) {
    return a * 2;
}
```
我们调用f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。


### 2024.10.2

(Day 9)

学习笔记

#### 库合约

库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在。

库合约是solidity中的一种合约类型，它和普通的合约不同，库合约不能被继承，也不能被销毁。库合约的目的是提供一些常用的函数，可以在多个合约中复用。

库合约的语法：

```solidity
library Math {
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}
```

他和普通合约主要有以下几点不同：

- 不能存在状态变量
- 不能够继承或被继承
- 不能接收以太币
- 不可以被销毁

需要注意的是，库合约重的函数可见性如果被设置为public或者external，则在调用函数时会触发一次delegatecall。而如果被设置为internal，则不会引起。对于设置为private可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

Strings合约库

```solidity
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) public pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) public pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) public pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
```

这里我们来理解一下这个`toString`函数吧。
- 首先函数检查这里的函数输入值是否为0，如果为0，那么直接返回"0"。
- 如果不为0，那么函数会进行一个循环，这个循环的目的是计算出这个输入值有多少位数。比如12345，那么他的位数就是5。使用除以10的方式来计算的。
- 然后，函数会创建一个bytes类型的变量，这个变量的长度就是输入值的位数。
- 接下来，从个位开始，逐位构建字符串：
```solidity
   while (value != 0) {
       digits -= 1;
       buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
       value /= 10;
   }
```

- value % 10 得到当前位的数字（0-9）
- 48 + uint256(value % 10) 将数字转换为对应的ASCII码（'0'的ASCII码是48）
- bytes1(uint8(...)) 将ASCII码转换为单个字节
- 从buffer的末尾开始填充，因为我们是从个位开始处理的
- 最后，函数返回这个bytes变量。


- 如何使用库合约
  - 利用using for指令
```solidity
// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```
  - 库合约的函数调用
```solidity
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```
Some usually used library contracts:

- Strings：将uint256转换为String
- Address：判断某个地址是否为合约地址
- Create2：更安全的使用Create2 EVM opcode
- Arrays：跟数组相关的库合约


### 2024.10.3

(Day 10)

学习笔记

#### import
在Solidity中，import语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。本教程将向你介绍如何在Solidity中使用import语句。

- import 的用法
  - import 可以在源文件之中使用，导入另一个文件。
  - 通过源文件网址导入网上的合约的全局符号

```solidity
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
```

  - 通过npm的目录导入，例子：

```solidity
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
```

- 通过指定全局符号导入合约特定的全局符号，例子：
```solidity
import {Yeye} from './Yeye.sol';
```




<!-- Content_END -->
