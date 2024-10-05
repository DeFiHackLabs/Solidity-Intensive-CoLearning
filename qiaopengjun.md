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

重载
Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。
重载函数在经过编译器编译后，由于不同的参数类型，都变成了不同的函数选择器（selector）。
在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。

库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在。库合约是一系列的函数合集，由大神或者项目方创作，咱们站在巨人的肩膀上，会用就行了。
他和普通合约主要有以下几点不同：

不能存在状态变量
不能够继承或被继承
不能接收以太币
不可以被销毁
库合约中的函数可见性如果被设置为public或者external，则在调用函数时会触发一次delegatecall。而如果被设置为internal，则不会引起。对于设置为private可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。
如何使用库合约
1 利用using for指令
指令using A for B;可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数
2 通过库合约名称调用函数
常用的有：

Strings：将uint256转换为String
Address：判断某个地址是否为合约地址
Create2：更安全的使用Create2 EVM opcode
Arrays：跟数组相关的库合约

import用法

- 通过源文件相对位置导入
- 通过源文件网址导入网上的合约的全局符号
- 通过npm的目录导入
- 通过指定全局符号导入合约特定的全局符号
引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前
通过import关键字，可以引用我们写的其他文件中的合约或者函数，也可以直接导入别人写好的代码，非常方便。

### 2024.09.29

Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：

- 接收ETH
- 处理合约中不存在的函数调用（代理合约proxy contract）
  
receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。

当合约接收ETH的时候，receive()会被触发。receive()最好不要执行太多的逻辑因为如果别人用send和transfer方法发送ETH的话，gas会限制在2300，receive()太复杂可能会触发Out of Gas报错；如果用call就可以自定义gas执行更复杂的逻辑

fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。

receive和fallback的区别
receive和fallback都能够用于接收ETH，他们触发的规则如下：

```javascript
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
```

简单来说，合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。

receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错（你仍可以通过带有payable的函数向合约发送ETH）。
receive()和fallback()，他们主要在两种情况下被使用，处理接收ETH和代理合约proxy contract。

transfer()，send()和call()
transfer
用法是接收方地址.transfer(发送ETH数额)。
transfer()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
transfer()如果转账失败，会自动revert（回滚交易）。
send
用法是接收方地址.send(发送ETH数额)。
send()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
send()如果转账失败，不会revert。
send()的返回值是bool，代表着转账成功或失败，需要额外代码处理一下。
call
用法是接收方地址.call{value: 发送ETH数额}("")。
call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑。
call()如果转账失败，不会revert。
call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理一下。

call没有gas限制，最为灵活，是最提倡的方法；
transfer有2300 gas限制，但是发送失败会自动revert交易，是次优选择；
send有2300 gas限制，而且发送失败不会自动revert交易，几乎没有人用它。

调用已部署合约

1. 传入合约地址 OtherContract(_Address).setX(x);
2. 传入合约变量 function callGetX(OtherContract _Address) external view returns(uint x){
3. 创建合约变量 OtherContract oc = OtherContract(_Address);
4. 调用合约并发送ETH
如果目标合约的函数是payable的，那么我们可以通过调用它来给合约转账：_Name(_Address).f{value: _Value}()，其中_Name是合约名，_Address是合约地址，f是目标函数名，_Value是要转的ETH数额（以wei为单位）。

### 2024.09.30

call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。

call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。
不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数
当我们不知道对方合约的源代码或ABI，就没法生成合约变量；这时，我们仍可以通过call调用对方合约的函数。
目标合约地址.call(字节码);
其中字节码利用结构化编码函数abi.encodeWithSignature获得：
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x,_addr)。
call在调用合约时可以指定交易发送的ETH数额和gas数额：
目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
call不是调用合约的推荐方法，因为不安全。但他能让我们在不知道源代码和ABI的情况下调用目标合约，很有用。

delegatecall与call类似，是Solidity中地址类型的低级成员函数。delegate中是委托/代表的意思
目标合约地址.delegatecall(二进制编码);
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
和call不一样，delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额
注意：delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。
目前delegatecall主要有两个应用场景：

1. 代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。

2. EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约
Solidity中的另一个低级函数delegatecall。与call类似，它可以用来调用其他合约；不同点在于运行的上下文，B call C，上下文为C；而B delegatecall C，上下文为B。目前delegatecall最大的应用是代理合约和EIP-2535 Diamonds（钻石）。

当用户A通过合约B来delegatecall合约C时，执行了C的函数，语境是B，msg.sender和msg.value来自 A， 并且如果函数改变一些状态变量，产生的效果会作用于B的变量上
在合约中创建新合约
在以太坊链上，用户（外部账户，EOA）可以创建智能合约，智能合约同样也可以创建新的智能合约。去中心化交易所uniswap就是利用工厂合约（PairFactory）创建了无数个币对合约（Pair）。
有两种方法可以在合约中创建新合约，create和create2
create的用法很简单，就是new一个合约，并传入新合约构造函数所需的参数
Contract x = new Contract{value: _value}(params)

### 2024.10.01

CREATE2 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址。Uniswap创建Pair合约用的就是CREATE2而不是CREATE
新地址 = hash(创建者地址, nonce)
创建者地址不会变，但nonce可能会随时间而改变，因此用CREATE创建的合约地址不好预测。
用CREATE2创建的合约地址由4个部分决定：

0xFF：一个常数，避免和CREATE冲突
CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
新地址 = hash("0xFF",创建者地址, salt, initcode)

CREATE2 确保，如果创建者使用 CREATE2 和提供的 salt 部署给定的合约initcode，它将存储在 新地址 中。
Contract x = new Contract{salt: _salt, value:_value}(params)
其中Contract是要创建的合约名，x是合约对象（地址），_salt是指定的盐；如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数。
create2的实际应用场景

1. 交易所为新用户预留创建钱包合约地址。

2. 由 CREATE2 驱动的 factory 合约，在Uniswap V2中交易对的创建是在 Factory中调用CREATE2完成。这样做的好处是: 它可以得到一个确定的pair地址, 使得 Router中就可以通过 (tokenA, tokenB) 计算出pair地址, 不再需要执行一次 Factory.getPair(tokenA, tokenB) 的跨合约调用。

selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。
<https://eips.ethereum.org/EIPS/eip-6049>
目前来说：

已经部署的合约无法被SELFDESTRUCT了。
如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。
selfdestruct(_addr)；
其中_addr是接收合约中剩余ETH的地址。_addr 地址不需要有receive()或fallback()也能接收ETH。
在坎昆升级前，合约会被自毁。但是在升级后，合约依然存在，只是将合约包含的ETH转移到指定地址，而合约依然能够调用。

对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。

Solidity中，ABI编码有4个函数：abi.encode, abi.encodePacked, abi.encodeWithSignature, abi.encodeWithSelector。而ABI解码有1个函数：abi.decode，用于解码abi.encode的数据。
abi.encode 将每个参数填充为32字节的数据，并拼接在一起
abi.encodePacked
将给定参数根据其所需最低空间编码。它类似 abi.encode，但是会把其中填充的很多0省略。比如，只用1字节来编码uint8类型。当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked
abi.encodeWithSignature
与abi.encode功能类似，只不过第一个参数为函数签名，比如"foo(uint256,address,string,uint256[2])"。当调用其他合约的时候可以使用。
等同于在abi.encode编码结果前加上了4字节的函数选择器
说明: 函数选择器就是通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用
abi.encodeWithSelector
与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。

ABI的使用场景

1. 在合约开发中，ABI常配合call来实现对合约的底层调用。
2. ethers.js中常用ABI实现合约的导入和函数调用。
3. 对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用。

### 2024.10.02

哈希函数（hash function）是一个密码学概念，它可以将任意长度的消息转换为一个固定长度的值，这个值也称作哈希（hash）
哈希 = keccak256(数据);
SHA3和keccak计算的结果不一样
以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。

```solidity
function hash(
    uint _num,
    string memory _string,
    address _addr
    ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_num, _string, _addr));
}
```

当我们调用智能合约时，本质上是向目标合约发送了一段calldata，在remix中发送一次交易后，可以在详细信息中看见input即为此次交易的calldata
发送的calldata中前4个字节是selector（函数选择器）
msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）
其实calldata就是告诉智能合约，我要调用哪个函数，以及参数是什么。
method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数
函数签名，为"函数名（逗号分隔的参数类型)"
在同一个智能合约中，不同的函数有不同的函数签名，因此我们可以通过函数签名来确定要调用哪个函数
注意，在函数签名中，uint和int要写为uint256和int256。

```solidity
function mintSelector() external pure returns(bytes4 mSelector){
    return bytes4(keccak256("mint(address)"));
}
```

由于计算method id时，需要通过函数名和函数的参数类型来计算。在Solidity中，函数的参数类型主要分为：基础类型参数，固定长度类型参数，可变长度类型参数和映射类型参数。
映射类型参数通常有：contract、enum、struct等。在计算method id时，需要将该类型转化成为ABI类型。

在Solidity中，try-catch只能被用于external函数或创建合约时constructor（被视为external函数）的调用。基本语法如下：

try externalContract.f() {
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
同样可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。
如果调用的函数有返回值，那么必须在try之后声明returns(returnType val)，并且在try模块中可以使用返回的变量；如果是创建合约，那么返回值是新创建的合约变量。
在Solidity使用try-catch来处理智能合约运行中的异常：

只能用于外部合约调用和合约创建。
如果try执行成功，返回变量必须声明，并且与返回的变量类型相同。
 try-catch可以捕获什么异常？
 revert()

 require()

 assert()
 异常返回值类型为bytes的是 assert()
try-catch捕获到异常后不会使try-catch所在的方法调用失败
try代码块内的revert是不会被catch本身捕获？

### 2024.10.03

ERC20是以太坊上的代币标准，来自2015年11月V神参与的EIP20。它实现了代币转账的基本逻辑：

账户余额(balanceOf())
转账(transfer())
授权转账(transferFrom())
授权(approve())
代币总供给(totalSupply())
授权转账额度(allowance())
代币信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())
IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件。
函数分为内部和外部两个内容，一个重点是实现，另一个是对外接口，约定共同数据
IERC20定义了2个事件：Transfer事件和Approval事件，分别在转账和授权时被释放
注意：用override修饰public变量，会重写继承自父合约的与变量同名的getter函数，比如IERC20中的balanceOf()函数。
<https://www.wtf.academy/docs/solidity-103/ERC20/>

### 2024.10.04

```solidity
/// @notice 向多个地址转账ERC20代币，使用前需要先授权
///
/// @param _token 转账的ERC20代币地址
/// @param _addresses 空投地址数组
/// @param _amounts 代币数量数组（每个地址的空投数量）
function multiTransferToken(
    address _token,
    address[] calldata _addresses,
    uint256[] calldata _amounts
    ) external {
    // 检查：_addresses和_amounts数组的长度相等
    require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
    IERC20 token = IERC20(_token); // 声明IERC合约变量
    uint _amountSum = getSum(_amounts); // 计算空投代币总量
    // 检查：授权代币数量 >= 空投代币总量
    require(token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");

    // for循环，利用transferFrom函数发送空投
    for (uint8 i; i < _addresses.length; i++) {
        token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
    }
}

/// 向多个地址转账ETH
function multiTransferETH(
    address payable[] calldata _addresses,
    uint256[] calldata _amounts
) public payable {
    // 检查：_addresses和_amounts数组的长度相等
    require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
    uint _amountSum = getSum(_amounts); // 计算空投ETH总量
    // 检查转入ETH等于空投总量
    require(msg.value == _amountSum, "Transfer amount error");
    // for循环，利用transfer函数发送ETH
    for (uint256 i = 0; i < _addresses.length; i++) {
        // 注释代码有Dos攻击风险, 并且transfer 也是不推荐写法
        // Dos攻击 具体参考 https://github.com/AmazingAng/WTF-Solidity/blob/main/S09_DoS/readme.md
        // _addresses[i].transfer(_amounts[i]);
        (bool success, ) = _addresses[i].call{value: _amounts[i]}("");
        if (!success) {
            failTransferList[_addresses[i]] = _amounts[i];
        }
    }
}
```

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
