---
timezone: Asia/Shanghai
---


# WaterBoat

1. 自我介绍

Hi，我是WaterBoat，目前在深圳自由要饭中。

2. 你认为你会完成本次残酷学习吗？

会的

## Notes

<!-- Content_START -->

### 2024.09.23

##### Solidity 是什么

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7af14412fd1483cbf7330ca717823ce~tplv-k3u1fbpfcp-image.image#?w=1300&#x26;h=1300&#x26;s=1665&#x26;e=svg&#x26;a=1&#x26;b=000000" alt="Solidity logo" width="150">

Solidity 是一门面向合约的、为实现智能合约而创建的高级编程语言。这门语言受到了 C++，Python 和 Javascript 语言的影响，设计的目的是能在以太坊虚拟机（EVM）上运行。

Solidity 是静态类型语言，支持继承、库和复杂的用户定义类型等特性。

##### 开发工具

###### Remix

`remix`是以太坊官方推荐的智能合约开发IDE（集成开发环境），适合新手，可以在浏览器中快速部署测试智能合约，你不需要在本地安装任何程序。

网址：[remix.ethereum.org](https://remix.ethereum.org/)

进入`remix`，我们可以看到最左边的菜单有三个按钮，分别对应文件（写代码的地方），编译（跑代码），部署（部署到链上）。我们点新建（`Create New File`）按钮，就可以创建一个空白的`solidity`合约

![808fa2e3af25459cbc069f4fe976f05f_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232238085.jpg)

我们来编写一段代码

```solidity
// SPDX-License-Identifier: MIT // 不写这个编辑器会警告,但是不影响运行
pragma solidity ^0.8.0; // 指定编译器版本 不允许小于 0.8.0 或大于 0.9.0的编译器编译

contract HelloWorld { // 创建合约(contract) 名字为 HelloWorld
    // 定义变量类型为 string 变量名威 _string 赋值为 HelloWorld
    string public _string = "HelloWorld!";
}
```

编写好代码之后我们点击左侧的编译

![18c051af6f0d49989dc8ff4abb2a49ea_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232239365.jpg)

然后点击部署

![12](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240038.jpg)

点击即可查看到值

######  VSCode

如果你不喜欢在线的编译工具我们可以使用本地环境来进行编译代码

在 VScode 中搜索插件 [Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity) 进行安装,作用是让代码进行高亮和补充一些代码提示

![111](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240976.jpg)

接下来我们打开 [remix](https://remix.ethereum.org/)

来到首页点击`Access File System`

![10f56a71c479438db788f17610ab7097_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232241733.jpg)

出现提示让我们安装一个 npm 包,我们根据文档的说明进行一下安装

```sh
npm install -g @remix-project/remixd
```

然后我们创建一个 sol 文件并在终端中找到他的文件夹所在地输入命令 `remixd`

![1a651ca9d68248c0a9c2d685a49bb6b7_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232242918.jpg)

并在网页上点击`content`进行连接即可完成

![image-20240426153811790](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/96b2e832ac8649b581574c1cd6922b18~tplv-k3u1fbpfcp-jj-mark:0:0:0:0:q75.image#?w=1066\&h=1024\&s=193843\&e=png\&b=212235)

##### 总结

这一讲,我们介绍了 solidity 、开发工具 remix 并且介绍了一下 vscode 和 remix 如何进行联动编写 HelloWorld。





### 2024.09.24



#### Solidity 数据类型

在 Solidity 中数据类型分为:

1. 值类型 (Value Type): 布尔类型、整型等，因为它们的变量通过值传递
2. 引用类型 (Reference Type): 数组、结构体，赋值的时候传递的是地址
3. 映射类型 (Mapping Type):类似于JS中的对象存储键值对,也可以理解为哈希表



#### 值类型

##### 1.布尔型(bool)

布尔类型只有两个值,`true`或`false`



```sol
bool public _bool = true
```



布尔值的运算符包括：

- `!` （逻辑非）
- `&&` （逻辑与，"and"）
- `||` （逻辑或，"or"）
- `==` （等于）
- `!=` （不等于）

短路运算



```sol
true || false // true
true && false // true

false || true // true
false && true // false

```

在 `||` 运算中第一个条件为 `true`时则中断运算返回 `true`

在 `&&` 运算中第一个条件为 `false` 时则中断运算返回`false`



##### 2.整型

整型举例

```sol
int public _int = 1 // 整数,包括负数
uint public _uint = -1 // 正整数
uint256 public _number = 114514 // 256位正整数
```

常用的整型运算符包括：

- 比较运算符（返回布尔值）： `<=`， `<`，`==`， `!=`， `>=`， `>`
- 算数运算符： `+`， `-`， `*`， `/`， `%`（取余），`**`（幂）

> 注意`0**0` 被EVM定义为 `1`



##### 3.地址类型

地址类型(address)有两类：

- 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
- payable address: 比普通地址多了 `transfer` 和 `send` 两个成员方法，用于接收转账。



```sol
// 地址
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address); // payable address，可以转账、查余额
// 地址类型的成员
uint256 public balance = _address1.balance; // balance of address
```



##### 4.字节数组



字节数组分为定长和不定长两种：

- 定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 `bytes1`, `bytes8`, `bytes32` 等类型。定长字节数组最多存储 32 bytes 数据，即`bytes32`。
- 不定长字节数组: bytes、string属于引用类型（之后的章节介绍），数组长度在声明之后可以改变。



```sol
// 固定长度的字节数组
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0]; 


bytes public data;
string public _string = "1232131";
```



##### 5. 枚举

枚举（`enum`）是 Solidity 中用户定义的数据类型。它主要用于为 `uint` 分配名称，使程序易于阅读和维护。类似于 Typescript 中的枚举类型

```solidity
// 用enum将uint 0， 1，表示为 teacher, student
enum School {teacher, student }
School action = School.student;
```

枚举可以显式地和 `uint` 相互转换，并会检查转换的正整数是否在枚举的长度内，否则会报错：

```solidity
// enum可以和uint显式的转换
function enumToUint() external view returns(uint){
    return uint(action);
}
```



#### 总结

学习了 Solidity 中值类型，包括布尔型、整型、地址、定长字节数组和枚举



### 2024.09.25



#### 函数



语法格式

```sol
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

1. function:关键字用于声明函数
2. `<function name>`:函数名
3. parameter types: 传入的参数类型和参数名
4. { internal | external | public | private } 函数可见性说明符
   1. internal : 只能从合约内部访问,继承的合约可以使用
   2. external : 只能从合约外部访问(内部可以通过 `this.f()` 调用,`f`是函数名)
   3. public : 内部和外部均可访问
   4. private : 只能从合约内部访问,继承的合约也不可以使用

**注意 1**：合约中定义的函数需要明确指定可见性，它们没有默认值。

**注意 2**：`public|private|internal` 也可用于修饰状态变量。`public`变量会自动生成同名的`getter`函数，用于查询数值。未标明可见性类型的状态变量，默认为`internal`

5. `[pure|view|payable]`：决定函数权限/功能的关键字。`payable`（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。`pure` 和 `view` 的介绍见下一节。
6. `[returns ()]`：函数返回的变量类型和名称。



#### 到底什么是 `Pure` 和`View`？

在 Solidity 中,存在 `prue` 和 `view` 关键字其原因是因为以太坊交易需要支付气费(gas fee)。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 `pure` 和 `view` 关键字的函数不会改写链上状态,因此用户直接调用它们是不需要支付 gas 的(注意,合约中非 `pure`/`view`函数调用`pure`/`view`函数时需要付gas)

在以太坊中，以下语句被视为修改链上状态：

1. 写入状态变量。
2. 释放事件。
3. 创建其他合约。
4. 使用 `selfdestruct`.
5. 通过调用发送以太币。
6. 调用任何未标记 `view` 或 `pure` 的函数。
7. 使用低级调用（low-level calls）。
8. 使用包含某些操作码的内联汇编。



#### 代码

##### 1. pure 和 view

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FunctionTypes {
    uint256 public number = 5;

    // 定义一个 add() 函数，每次调用会让 number 增加 1。
    function add() external {
        number += 1;
    }

    //如果 add() 函数被标记为 pure，比如 function add() external pure，就会报错。因为 pure 是不配读取合约里的状态变量的，更不配改写。那 pure 函数能做些什么？举个例子，你可以给函数传递一个参数 _number，然后让他返回 _number + 1，这个操作不会读取或写入状态变量。
    function addPure(uint256 _number)
        external
        pure
        returns (uint256 new_number)
    {
        new_number = _number + 1;
    }
}

```

##### 2.internal v.s. external

```sol
// internal: 内部函数
function minus() internal {
    number = number - 1;
}

// 合约内的函数可以调用内部函数
function minusCall() external {
    minus();
}
```

我们定义一个 `internal` 的 `minus()` 函数，每次调用使得 `number` 变量减少 1。由于 `internal` 函数只能由合约内部调用，我们必须再定义一个 `external` 的 `minusCall()` 函数，通过它间接调用内部的 `minus()` 函数。



#### 3.payable

```sol
// payable: 递钱，能给合约支付eth的函数
function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}
```

我们定义一个 `external payable` 的 `minusPayable()` 函数，间接的调用 `minus()`，并且返回合约里的 ETH 余额（`this` 关键字可以让我们引用合约地址）。我们可以在调用 `minusPayable()` 时往合约里转入1个 ETH。



#### 总结

`view` 函数可以读取状态变量，但不能改写；`pure` 函数既不能读取也不能改写状态变量。





### 2024.09.26

#### 函数输出

#### 返回值 : return 和 returns

在 Solidity 中 `return` 和 `returns` 的区别 :

- `returns`：跟在函数名后面，用于声明返回的变量类型及变量名。
- `return`：用于函数主体中，返回指定的变量。



```sol
function returnMulitple() puiblc pure returns(uint256,bool,uint256[3] memory){
	return(1,ture,[uint256(1),2,5]);
}
```

在上述代码中，我们利用 `returns` 关键字声明了有多个返回值的 `returnMultiple()` 函数，然后我们在函数主体中使用 `return(1, true, [uint256(1),2,5])` 确定了返回值。

这里`uint256[3]`声明了一个长度为`3`且类型为`uint256`的数组作为返回值。因为`[1,2,3]`会默认为`uint8(3)`，因此`[uint256(1),2,5]`中首个元素必须强转`uint256`来声明该数组内的元素皆为此类型。数组类型返回值默认必须用memory修饰



#### 命名式返回

我们可以在 `returns` 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 `return`。

```sol
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```

在上述代码中，我们用 `returns(uint256 _number, bool _bool, uint256[3] memory _array)` 声明了返回变量类型以及变量名。这样，在主体中只需为变量 `_number`、`_bool`和`_array` 赋值，即可自动返回。

当然，你也可以在命名式返回中用 `return` 来返回变量：

```solidity
// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```



#### 解构式赋值

Solidity 支持使用解构式赋值规则来读取函数的全部或部分返回值。

- 读取所有返回值：声明变量，然后将要赋值的变量用`,`隔开，按顺序排列。

```sol
    function readReturn() public pure {
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number, _bool, _array) = returnNamed();
    }
```

- 读取部分返回值：声明要读取的返回值对应的变量，不读取的留空。在下面的代码中，我们只读取`_bool`，而不读取返回的`_number`和`_array`：

```sol
    function readReturn() public pure {
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number, _bool, _array) = returnNamed();


        bool _bool2;
        // 读取部分返回值
        (,_bool2,)=returnNamed();
    }
```



### 2024.09.27

#### 变量数据存储和作用域

#### Solidity中的引用类型

引用类型(Reference) : 包括数组 (Array) 和结构体(Struct),由于这类变量比较复杂,占用存储空间大,我们在使用时必须要声明数据存储的位置。

#### 数据位置

Solidiy 数据存储位置有三种类型: storage、memory和 calldata。不同存储位置的 gas 成本不同。storage 类型的数据存在链上，类似计算机的硬盘，消耗 gas 多；memory 和 calldata 类型的临时存在于内存中，消耗 gas 少。大致用法如下：

1. `storage`：合约里的状态变量默认都是`storage`，存储在链上。
2. `memory` : 函数中的参数和临时变量一般用`memory`,存储在内存中,不上链.尤其是如果返回数据类型变长的情况下,必须加 memory 修饰,例如 string、byts、array和自定义结构。
3. `calldata`: 和 memory 类型,存储在内存中,不上链。与 `memory`的不同点在于 `calldata` 变量不能修改 (immutable),一般用于函数的参数。例子：

```sol
function fCalldata(uint[] calldata _test) public prue returns(uint[] calldata){
    //参数为calldata数组，不能被修改
    // _x[0] = 0 //这样修改会报错
    return(_x);
}
```

#### 数据位置和赋值规则

在不同存储类型相互赋值时候,有时会产生独立的副本(修改新变量不会影响原变量),有时产生引用(修改新变量会影响原变量)。规则如下：

- 赋值本质上是创建**引用**指向本体，因此修改本体或者是引用，变化可以被同步：

- `storage`（合约的状态变量）赋值给本地`storage`（函数里的）时候，会创建引用，改变新变量会影响原变量。例子：

```sol
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```

- - `memory`赋值给`memory`，会创建引用，改变新变量会影响原变量。
- 其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方



#### 变量的作用域

`Solidity`中变量按作用域划分有三种，分别是状态变量（state variable），局部变量（local variable）和全局变量(global variable)

##### 1. 状态变量

状态变量是数据存储在链上的变量，所有合约内函数都可以访问，`gas`消耗高。状态变量在合约内、函数外声明：

```solidity
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}
```

在函数里更改状态变量的值：

```sol
function foo() external{
    // 可以在函数里更改状态变量的值
    x = 5;
    y = 2;
    z = "0xAA";
}
```

##### 2. 局部变量

局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，`gas`低。局部变量在函数内声明：

```sol
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```

##### 3.全局变量

全局变量是全局范围工作的变量，都是`solidity`预留关键字。他们可以在函数内不声明直接使用：

```sol
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```

在上面例子里，我们使用了3个常用的全局变量：`msg.sender`，`block.number`和`msg.data`，他们分别代表请求发起地址，当前区块高度，和请求数据。下面是一些常用的全局变量，更完整的列表请看这个[链接](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)：

- `blockhash(uint blockNumber)`: (`bytes32`) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
- `block.coinbase`: (`address payable`) 当前区块矿工的地址
- `block.gaslimit`: (`uint`) 当前区块的gaslimit
- `block.number`: (`uint`) 当前区块的number
- `block.timestamp`: (`uint`) 当前区块的时间戳，为unix纪元以来的秒
- `gasleft()`: (`uint256`) 剩余 gas
- `msg.data`: (`bytes calldata`) 完整call data
- `msg.sender`: (`address payable`) 消息发送者 (当前 caller)
- `msg.sig`: (`bytes4`) calldata的前四个字节 (function identifier)
- `msg.value`: (`uint`) 当前交易发送的 `wei` 值
- `block.blobbasefee`: (`uint`) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
- `blobhash(uint index)`: (`bytes32`) 返回跟当前交易关联的第 `index` 个blob的版本化哈希（第一个字节为版本号，当前为`0x01`，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。

##### 4.全局变量-以太单位与时间单位

###### 以太单位

`Solidity`中不存在小数点，以`0`代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易

- `wei`: 1
- `gwei`: 1e9 = 1000000000
- `ether`: 1e18 = 1000000000000000000



```sol
function weiUnit() external pure returns(uint) {
    assert(1 wei == 1e0);
    assert(1 wei == 1);
    return 1 wei;
}

function gweiUnit() external pure returns(uint) {
    assert(1 gwei == 1e9);
    assert(1 gwei == 1000000000);
    return 1 gwei;
}

function etherUnit() external pure returns(uint) {
    assert(1 ether == 1e18);
    assert(1 ether == 1000000000000000000);
    return 1 ether;
}
```

###### 时间单位

可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在`Solidity`中是一个重要的概念，有助于提高合约的可读性和可维护性。

- `seconds`: 1
- `minutes`: 60 seconds = 60
- `hours`: 60 minutes = 3600
- `days`: 24 hours = 86400
- `weeks`: 7 days = 604800

```sol
function secondsUnit() external pure returns(uint) {
    assert(1 seconds == 1);
    return 1 seconds;
}

function minutesUnit() external pure returns(uint) {
    assert(1 minutes == 60);
    assert(1 minutes == 60 seconds);
    return 1 minutes;
}

function hoursUnit() external pure returns(uint) {
    assert(1 hours == 3600);
    assert(1 hours == 60 minutes);
    return 1 hours;
}

function daysUnit() external pure returns(uint) {
    assert(1 days == 86400);
    assert(1 days == 24 hours);
    return 1 days;
}

function weeksUnit() external pure returns(uint) {
    assert(1 weeks == 604800);
    assert(1 weeks == 7 days);
    return 1 weeks;
}
```

#### 总结

介绍了`Solidity`中的引用类型，数据位置和变量的作用域。重点是`storage`, `memory`和`calldata`三个关键字的用法。他们出现的原因是为了节省链上有限的存储空间和降低`gas`





### 2024.09.28

#### 引用类型,array,struct

##### 数组 array

数组（`Array`）是`Solidity`常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种：

- 固定长度数组：在声明时指定数组的长度。用`T[k]`的格式声明，其中`T`是元素的类型，`k`是长度，例如：

```sol
// 固定长度 Array
uint[8] array1;
bytes1[5] array2;
address[100] array3;
```

- 可变长度数组（动态数组）：在声明时不指定数组的长度。用`T[]`的格式声明，其中`T`是元素的类型，例如：

```sol
// 可变长度 Array
uint[] array4;
bytes1[] array5;
address[] array6;
bytes array7;
```

#### 创建数组的规则

在Solidity里，创建数组有一些规则：

- 对于`memory`修饰的`动态数组`，可以用`new`操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：

```sol
// memory动态数组
uint[] memory array8 = new uint[](5);
bytes memory array9 = new bytes(9);
```

- 数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化array的一种方式，并且里面每一个元素的type是以第一个元素为准的，例如`[1,2,3]`里面所有的元素都是`uint8`类型，因为在Solidity中，如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是`uint8`。而`[uint(1),2,3]`里面的元素都是`uint`类型，因为第一个元素指定了是`uint`类型了，里面每一个元素的type都以第一个元素为准。

下面的例子中，如果没有对传入 `g()` 函数的数组进行 `uint` 转换，是会报错的



```sol
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

- 如果创建的是动态数组，你需要一个一个元素的赋值。

  ```solidity
  uint[] memory x = new uint[](3);
  x[0] = 1;
  x[1] = 3;
  x[2] = 4;
  ```



##### 数组方法

- `length`: 数组有一个包含元素数量的`length`成员，`memory`数组的长度在创建后是固定的。
- `push()`: `动态数组`拥有`push()`成员，可以在数组最后添加一个`0`元素，并返回该元素的引用。
- `push(x)`: `动态数组`拥有`push(x)`成员，可以在数组最后添加一个`x`元素。
- `pop()`: `动态数组`拥有`pop()`成员，可以移除数组最后一个元素。

#### 结构体 struct

`Solidity`支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法：

```sol
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体
```

给结构体赋值的四种方法：

```solidity
//  给结构体赋值
// 方法1:在函数中创建一个storage的struct引用
function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
}
```



### 2024.09.29

#### 映射Mapping

在映射中，人们可以通过键（`Key`）来查询对应的值（`Value`），比如：通过一个人的`id`来查询他的钱包地址。

声明映射的格式为`mapping(_KeyType => _ValueType)`，其中`_KeyType`和`_ValueType`分别是`Key`和`Value`的变量类型。例子：

```sol
mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址
```

#### 映射的语法规则

**规则1**：映射的`_KeyType`只能选择Solidity内置的值类型，比如`uint`，`address`等，不能用自定义的结构体。而`_ValueType`可以使用自定义的类型。下面这个例子会报错，因为`_KeyType`使用了我们自定义的结构体：

```sol
// 我们定义一个结构体 Struct
struct Student{
    uint256 id;
    uint256 score; 
}
mapping(Student => uint) public testVar;
```

- **规则2**：映射的存储位置必须是`storage`，因此可以用于合约的状态变量，函数中的`storage`变量和library函数的参数（见[例子](https://github.com/ethereum/solidity/issues/4635)）。不能用于`public`函数的参数或返回结果中，因为`mapping`记录的是一种关系 (key - value pair)。

- **规则3**：如果映射声明为`public`，那么Solidity会自动给你创建一个`getter`函数，可以通过`Key`来查询对应的`Value`。
- **规则4**：给映射新增的键值对的语法为`_Var[_Key] = _Value`，其中`_Var`是映射变量名，`_Key`和`_Value`对应新增的键值对。例子：

```sol
function writeMap (uint _Key, address _Value) public{
    idToAddress[_Key] = _Value;
}
```

#### 映射的原理

- **原理1**: 映射不储存任何键（`Key`）的资讯，也没有length的资讯。
- **原理2**: 映射使用`keccak256(abi.encodePacked(key, slot))`当成offset存取value，其中`slot`是映射变量定义所在的插槽位置。
- **原理3**: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（`Value`）的键（`Key`）初始值都是各个type的默认值，如uint的默认值是0。

#### 2024.09.30

#### 变量初始值

概念性东西看一下有个印象就行了

- `boolean`: `false`

- `string`: `""`

- `int`: `0`

- `uint`: `0`

- `enum`: 枚举中的第一个元素

- `address`: `0x0000000000000000000000000000000000000000` (或 `address(0)`)

- ```
  function
  ```

  - `internal`: 空白函数
  - `external`: 空白函数

- 映射`mapping`: 所有元素都为其默认值的`mapping`

- 结构体`struct`: 所有成员设为其默认值的结构体

- 数组

  ```
  array
  ```

  - 动态数组: `[]`
  - 静态数组（定长）: 所有成员设为其默认值的静态数组



#### `delete`操作符

`delete a`会让变量`a`的值变为初始值。

```solidity
// delete操作符
bool public _bool2 = true; 
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}
```

#### 2024.10.01

#### 常数 constant 和 immutable

`constant`（常量）和`immutable`（不变量）。状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省`gas`。

另外，只有数值变量可以声明`constant`和`immutable`；`string`和`bytes`可以声明为`constant`，但不能为`immutable`。



#### constant 和 immutable

##### constant 常量

常量必须声明的时候初始化,之后无法进行更改

```sol
uint256 constant CONSTANT_NUM = 10;
```



##### immutable 不变量

不变量可以在声明时或构造函数中初始化,因此更加灵活。

在`Solidity v8.0.21`以后，`immutable`变量不需要显式初始化。反之，则需要显式初始化。 

若`immutable`变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。



```sol
// immutable变量可以在constructor里初始化，之后不能改变
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;
```

你可以使用全局变量例如`address(this)`，`block.number` 或者自定义的函数给`immutable`变量初始化。在下面这个例子，我们利用了`test()`函数给`IMMUTABLE_TEST`初始化为`9`

```sol
// 利用constructor初始化immutable变量，因此可以利用
constructor(){
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}

function test() public pure returns(uint256){
    uint256 what = 9;
    return(what);
}
```





<!-- Content_END -->