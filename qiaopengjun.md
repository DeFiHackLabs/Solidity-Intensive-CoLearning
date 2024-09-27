---
timezone: Asia/Shanghai # 中国标准时间 (UTC+8)
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加夏令时间 (UTC-8)

timezone: America/Los_Angeles # 太平洋夏令时间 (UTC-7)

timezone: America/Denver # 山地夏令时间 (UTC-6)

timezone: America/Chicago # 中部夏令时间 (UTC-5)

timezone: America/New_York # 东部夏令时间 (UTC-4)

timezone: America/Halifax # 大西洋夏令时间 (UTC-3)

timezone: America/St_Johns # 纽芬兰夏令时间 (UTC-2:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# YourName

1. 自我介绍
  Qiao Pengjun 乔鹏军。有Python、Go、Rust、solidity的开发经验。大约是去年开始了解Web3，最近在学习solidity。对区块链技术很感兴趣。了解了一点Solana、Sui、Starknet... 正在继续学习。希望本次学习能让我更深入的了解Web3。拥抱Web3，拥抱未来。

2. 你认为你会完成本次残酷学习吗？
  我认为我会完成本次残酷学习，因为我有信心，并且我相信我能够克服任何困难。

## Notes

<!-- Content_START -->

### 2024.09.23

默认情况下，Remix 会使用 Remix 虚拟机（以前称为 JavaScript 虚拟机）来模拟以太坊链，运行智能合约，类似在浏览器里运行一条测试链。Remix 还会为你分配一些测试账户，每个账户里有 100 ETH（测试代币），随意使用。点击 Deploy（黄色按钮），即可部署我们编写的合约。

Solidity中的变量类型
值类型(Value Type)：包括布尔型，整数型等等，这类变量赋值时候直接传递数值。

引用类型(Reference Type)：包括数组和结构体，这类变量占空间大，赋值时候直接传递地址（类似指针）。

映射类型(Mapping Type): Solidity中存储键值对的数据结构，可以理解为哈希表

地址类型(address)有两类：

普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账。

{internal|external|public|private}：函数可见性说明符，共有4种。

public：内部和外部均可见。
private：只能从本合约内部访问，继承的合约也不能使用。
external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
internal: 只能从合约内部访问，继承的合约可以用。

注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。

注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。

包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

在以太坊中，以下语句被视为修改链上状态：

写入状态变量。
释放事件。
创建其他合约。
使用 selfdestruct.
通过调用发送以太币。
调用任何未标记 view 或 pure 的函数。
使用低级调用（low-level calls）。
使用包含某些操作码的内联汇编。

view 函数可以读取状态变量，但不能改写；pure 函数既不能读取也不能改写状态变量。

### 2024.09.24

Solidity 中与函数输出相关的有两个关键字：return和returns。它们的区别在于：

returns：跟在函数名后面，用于声明返回的变量类型及变量名。
return：用于函数主体中，返回指定的变量。
数组类型返回值默认必须用memory修饰
在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。

storage：合约里的状态变量默认都是storage，存储在链上。

memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。

calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。

赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
memory赋值给memory，会创建引用，改变新变量会影响原变量。

其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方
状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明， 我们可以在函数里更改状态变量的值
局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明
全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用
Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。

wei: 1
gwei: 1e9 = 1000000000
ether: 1e18 = 1000000000000000000

seconds: 1
minutes: 60 seconds = 60
hours: 60 minutes = 3600
days: 24 hours = 86400
weeks: 7 days = 604800
数组分为固定长度数组和可变长度数组两种：
固定长度数组：在声明时指定数组的长度。用T[k]的格式声明，其中T是元素的类型，k是长度，
可变长度数组（动态数组）：在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型
注意：bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变
[1,2,3]里面所有的元素都是uint8类型，因为在Solidity中，如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是uint8。而[uint(1),2,3]里面的元素都是uint类型，因为第一个元素指定了是uint类型了，里面每一个元素的type都以第一个元素为准。
如果创建的是动态数组，你需要一个一个元素的赋值
给结构体赋值的四种方法：

```solidity
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体

//  给结构体赋值
// 方法1:在函数中创建一个storage的struct引用
function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
}

// 方法2:直接引用状态变量的struct
function initStudent2() external{
    student.id = 1;
    student.score = 80;
}

// 方法3:构造函数式
function initStudent3() external {
    student = Student(3, 90);
}

// 方法4:key value
function initStudent4() external {
    student = Student({id: 4, score: 60});
}
```

### 2024.09.25

映射（Mapping）类型，Solidity中存储键值对的数据结构，可以理解为哈希表。
声明映射的格式为mapping(_KeyType =>_ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型。
规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型，比如结构体。
规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。

规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。

规则4：给映射新增的键值对的语法为_Var[_Key] =_Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对。
在Solidity中，声明但没赋值的变量都有它的初始值或默认值。
值类型初始值
boolean: false
string: ""
int: 0
uint: 0
enum: 枚举中的第一个元素
address: 0x0000000000000000000000000000000000000000 (或 address(0))
function
internal: 空白函数
external: 空白函数
引用类型初始值
映射mapping: 所有元素都为其默认值的mapping
结构体struct: 所有成员设为其默认值的结构体
数组array
动态数组: []
静态数组（定长）: 所有成员设为其默认值的静态数组
delete操作符
delete a会让变量a的值变为初始值。

在 Solidity 中，`bytes1` 类型的初始值是 `0x00`，也就是 1 个字节的值全为 0。可以理解为二进制的 `00000000`，也就是 `0x00`。
constant（常量）和immutable（不变量）。状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。
只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。
constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。
immutable变量可以在声明时或构造函数中初始化，因此更加灵活。
若immutable变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。
你可以使用全局变量例如address(this)，block.number 或者自定义的函数给immutable变量初始化。

### 2024.09.26

控制流
if-else
for循环
while循环
do-while循环
三元运算符
三元运算符是Solidity中唯一一个接受三个操作数的运算符，规则条件? 条件为真的表达式:条件为假的表达式。此运算符经常用作if语句的快捷方式。
continue
break

```solidity
// 插入排序 正确版
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // note that uint can not take negative value
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i;
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}
```

对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：

// memory动态数组
uint[] memory array8 = new uint[](5);
bytes memory array9 = new bytes(9);
构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，例如初始化合约的owner地址
构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，例如初始化合约的owner地址

Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：

响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

事件的声明由event关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名

以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。

日志的第一部分是主题数组，用于描述事件，长度不能超过4。它的第一个元素是事件的签名（哈希）。
除了事件哈希，主题还可以包含至多3个indexed参数
indexed标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个 indexed 参数的大小为固定的256比特，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

事件中不带 indexed的参数会被存储在 data 部分中，可以理解为事件的“值”。data 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 data 部分可以用来存储复杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特，即使存储在事件的 topics 部分中，也是以哈希的方式存储。另外，data 部分的变量在存储上消耗的gas相比于 topics 更少。

很多链上分析工具包括Nansen和Dune Analysis都是基于事件工作的

### 2024.09.27

Solidity中的继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承。
virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。

override：子合约重写了父合约中的函数，需要加上override关键字。
注意：用override修饰public变量，会重写与变量同名的getter函数
Solidity的合约可以继承多个合约。规则：
继承时要按辈分最高到最低的顺序排
如果某一个函数在多个继承的合约里都存在，在子合约里必须重写，不然会报错。
重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。
Solidity中的修饰器（Modifier）同样可以继承，用法与函数继承类似，在相应的地方加virtual和override关键字即可。
子合约有两种方法继承父合约的构造函数。
在继承时声明父构造函数的参数，例如：contract B is A(1)
在子合约的构造函数中声明构造函数的参数
子合约有两种方式调用父合约的函数，直接调用和利用super关键字。
直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，例如Yeye.pop()
super关键字：子合约可以利用super.函数名()来调用最近的父合约函数。Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()
钻石继承
在面向对象编程中，钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类。

在多重+菱形继承链条上使用super关键字时，需要注意的是使用super会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。

抽象合约 （Abstract Contract）
如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为abstract，不然编译会报错；另外，未实现的函数需要加virtual，以便子合约重写。
接口
接口类似于抽象合约，但它不实现任何功能。接口的规则：

不能包含状态变量
不能包含构造函数
不能继承除接口外的其他合约
所有函数都必须是external且不能有函数体
继承接口的非抽象合约必须实现接口定义的所有功能
虽然接口不实现任何功能，但它非常重要。接口是智能合约的骨架，定义了合约的功能以及如何触发它们：如果智能合约实现了某种接口（比如ERC20或ERC721），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：

合约里每个函数的bytes4选择器，以及函数签名函数名(每个参数类型）。

接口id（更多信息见EIP165）
接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用abi-to-sol工具，也可以将ABI json文件转换为接口sol文件。
<https://gnidan.github.io/abi-to-sol/>
接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。
Solidity三种抛出异常的方法：error，require和assert
error是solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。
在执行当中，error必须搭配revert（回退）命令使用。
require命令是solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。
assert命令一般用于程序员写程序debug，因为它不能解释抛出异常的原因（比require少个字符串）。它的用法很简单，assert(检查条件），当检查条件不成立的时候，就会抛出异常。
error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas，大家要多用！
error既可以告知用户抛出异常的原因，又能省gas。

- `require` 方法通常用于条件判断，如果条件不成立，会抛出异常，并且可以带上错误信息。它是用于输入验证和防止非法操作的主要工具之一。

- `assert` 方法用于检测代码中的不可变条件或严重的逻辑错误，失败时会消耗所有剩余的 gas，通常在调试或确保代码不变时使用，不建议频繁使用。备注: Solidity 0.8.0之前的版本，assert抛出的是一个 panic exception，会把剩余的 gas 全部消耗，不会返还。更多细节见官方文档。

- `error` 方法是自定义错误类型的声明，必须结合 `revert` 来手动抛出，但在这个问题的选项中， `require` 更符合直接抛出异常的标准用法。

### 2024.09.28

笔记内容

### 2024.09.29

笔记内容

### 2024.09.30

笔记内容

### 2024.10.01

笔记内容

### 2024.10.02

笔记内容

### 2024.10.03

笔记内容

### 2024.10.04

笔记内容

### 2024.10.05

笔记内容

### 2024.10.06

笔记内容

### 2024.10.07

笔记内容

### 2024.10.08

笔记内容

### 2024.10.09

笔记内容

### 2024.10.10

笔记内容

### 2024.10.11

笔记内容

### 2024.10.12

笔记内容

### 2024.10.13

笔记内容

### 2024.10.14

笔记内容

### 2024.10.15

笔记内容

### 2024.10.16

笔记内容

<!-- Content_END -->
