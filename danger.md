---
timezone: Asia/Shanghai
---


---

# danger

1. 自我介绍：
   
 -  大家好，各位助学老师好，我是一名编程小白，曾在跑节点与撸毛项目中使用ubuntu系统时接触过一些代码，但大部分都是使用一键脚本或直接按照教程复制粘贴代码，对代码内容基本一知半解，希望通过共学教程学习更多的知识。

2. 你认为你会完成本次残酷学习吗？

 -  我相信我可以！
   
## Notes

<!-- Content_START -->
### 2024.09.13
- 通过学习残酷共学GitHub提交教程,进行报名；通过浏览各位学友的自我介绍及代码，优化个人笔记相关内容。
  
### 2024.09.23

   作为一个代码小白，看了Solidity第一课的视频（https://www.youtube.com/watch?v=KWW9Y09erDM&list=PL-edkZcvwC5a7qIaHG4Rsj6DkOM3YH3eT）和网站（https://www.wtf.academy/docs/solidity-101/HelloWeb3/）  上的相关内容，看了之后的大概印象是：Solidity是运行在以太坊虚拟机上（Evm）的智能合约的编程语言，它的开发工具是Remix。

下边是对照网页和搜索引擎提炼的相关学习要点，为以后温习做准备。

学习内容：

- 1、以太坊虚拟机（英文EVM）：
  
之前用VM软件在windows系统的电脑上装过ubuntu系统，以太坊虚拟机从字面意思理解就是运行在eth链上的虚拟机，即为ETH上的VM,简称EVM。

- 2、智能合约（英文smart contract）：
  
智能合约是一种智能协议，在区块链内制定合约时使用，当中内含了代码函数(function),也能和其他合约进行交互、做决策、存储资料及发送以太币等功能。智能合约主要提供验证及执行合约内所订立的条件。智能合约允许在没有第三方的情况下进行可信交易。这些交易可追踪且不可逆转。

- 3、Solidity
  
Solidity是运用在EVM上智能合约的编程语言。

Solidity是一直面相  对象  和  静态类型  的语言。

它支持继承、库和复杂的用户定义类型，使开发人员能用轻松地构建复杂的智能合约。此外Solidity 非常适合开发各种功能，如投票、众筹、拍卖和多重签名钱包。它提供了丰富的内置函数和库，帮助开发人员快速实现这些功能。它的优势在于安全又灵活。静态类型有助于捕捉常见错误，提高代码的安全性，同时，支持各种库和用户自定义类型使开发人员能够灵活得构建复杂的智能合约。

- 4、开发工具：Remix
  
  Remix是以太坊推荐的智能合约集成开发环境（IDE),合适像我这样的小白新手，可以在浏览器里快手开发和部署合约，无需在本地安装任何程序。网站是https://remix.ethereum.org ，用github注册并登录了该网站，以保存相关学习文件
  
   - 4.1 Remix左侧菜单有五个按钮，分别对应文件（编写代码）、搜索、编译（运行代码）、部署和发交易（将合约部署到链上）、git，点击create new file 即可生成格式为.sol的空白Solidity合约。

  ![image](https://github.com/user-attachments/assets/9eefd823-47a7-43ee-9141-346936913130)
### 

   - 4.2 写了名为hellword的第一个Soliduty合约，合约内容如下

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;
    contract helloworld{ 
    string public _string = "hello web3";
    }
 这个程序有一行注释和三行代码，拆解程序，学习Solidity的代码源文件的结构

        // SPDX-License-Identifier: MIT
        
 - 4.2.1 第一行是注释，说明代码使用的软件许可（license），这里使用的是MIT许可，代码使用的软件许可，可以在https://spdx.org/licenses/ 里搜索mit查找，如果不写许可，编译时会出现warning,但程序仍然能运行。注释以“//"开头，后边跟注释内容，注释不会被程序执行。
   
       pragma solidity ^0.8.21;
    
 - 4.2.2 第2行声明源文件所使用的Solidity版本，因为不同版本的语法有所差异，一般都是最新版本的上一个版本。“^0.8.21”表示该程序适用于从当前版本到不大于重大版本更新的所有版本，即适用于0.8.21到<0.9

 - 在版本管理中，0.8.21 一般的代表的意义是:
0: major version 
8: minor version
21: patch version

major version 一般代表是大版本, 大于0 就代表出了一个稳定版本, 不同的大版本之间可能包含 breaking change, 升级大版本就要小心

而 ^ 代表的是 compatible with version, 它有两个意思, 

如果是对于已经有稳定版本的, 比如 ^1.2.3, 那么^ 就代表, major version 不能升级, 其实的小版本或者 patch 版本都可以升级，即 ^.1.2.3 = from 1.2.3 to < 2.0.0

对于还没有发布稳定版本，例如 ^0.8.21, 他的意思就是, 可以升级，但是不要变动到版本号中最左边的非零数字, 即 ^0.8.21 is 大于等于 0.8.21, 但小于0.9,  因为升级到0.9 就意味着 最左边的非零数字(left-most non-zero)变了

Solidity语句以分号;结尾

    contract helloworld{ 
    string public _string = "hello web3";
    }
- 4.2.3 第3、4行是合约部分。第三行创建合约并声明合约名字为helloword。第4行是合约内容，声明了一个string(字符串）变量 _string，并赋值为“hello web3”。

在remix编辑代码的页面，按Ctrl+s 即可编译代码，编译完成后，看是否有报错，根据报错提示修改相应代码，然后进入部署界面选择相应的Remix环境，remxi会分配一些测试账户，每个账户有100个eth测试代币，点击depoly，即可部署所写合约。
部署成功后，在下方会看到名为helloword的合约，点击_string,即可看到“hello web3”。

### 2024.09.24

Solidity中的变量类型
值类型(Value Type)：包括布尔型，整数型等等，这类变量赋值时候直接传递数值。

引用类型(Reference Type)：包括数组和结构体，这类变量占空间大，赋值时候直接传递地址（类似指针）。

映射类型(Mapping Type): Solidity中存储键值对的数据结构，可以理解为哈希表

我们将仅介绍常用类型，不常用的类型不会涉及，本篇将介绍值类型。

值类型
1. 布尔型
2. 整型
3. 地址类型
4. 定长字节数组
5. 枚举 enum

### 2024.09.26

 Solidity 中函数的形式

 Solidity中函数的形式为
 
    function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

主题结构可以简化为 

        function <>(<>) {|||} [||] [(<>)]


即为function 、<>、(<>) 、{|||}、[||]、[(<>)]

即function、 <function name>、 (<parameter types>) 、{internal|external|public|private}、[pure|view|payable]、[returns (<return types>)]


1、function：声明函数时的固定用法，编写函数需要以 function 关键字开头

2、 < function name >：函数名

3、 (<  parameter types  >)：圆括号内写入函数的参数，即输入到函数的变量类型和名称

4、 {internal|external|public|private}：函数可见性说明符，共有4种

4.1、 public：内部和外部均可见

4.2、 private：只能从本合约内部访问，继承的合约也不能使用

4.3、 external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）

4.4、 internal: 只能从合约内部访问，继承的合约可以用

注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值

注意 2：public|private|internal 也可用于修饰状态变量,public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal

方括号中的是可写可不 写的关键字

5、 [pure|view|payable]：决定函数权限/功能的关键字。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。

6、 [returns ()]：函数返回的变量类型和名称



### 2024.09.27

Pure 和View


solidity 引入这两个关键字主要是因为 以太坊交易需要支付气费（gas fee）。

合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。

包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas。

在以太坊中，以下语句被视为修改链上状态：

写入状态变量。

1、释放事件。

2、创建其他合约。

3、使用 selfdestruct.

4、通过调用发送以太币。

5、调用任何未标记 view 或 pure 的函数。

6、使用低级调用（low-level calls）。

7、使用包含某些操作码的内联汇编。




![image](https://github.com/user-attachments/assets/e7484a57-a664-4b6d-8c50-c7132aa9d6f1)

在这幅插图中，将合约中的状态变量（存储在链上）比作碧琪公主，三种不同的角色代表不同的关键字

1、pure，中文意思是“纯”，这里可以理解为”纯打酱油的”。pure 函数既不能读取也不能写入链上的状态变量。就像小怪一样，看不到也摸不到碧琪公主。

2、view，“看”，这里可以理解为“看客”。view函数能读取但也不能写入状态变量。类似马里奥，能看到碧琪公主，但终究是看客，不能入洞房。

3、非 pure 或 view 的函数既可以读取也可以写入状态变量。类似马里奥里的 boss，可以对碧琪公主为所欲为。


pure 和 view 关键字比较难理解，在其他语言中没出现过：view 函数可以读取状态变量，但不能改写；pure 函数既不能读取也不能改写状态变量

### 2024.09.29


 函数输出

Solidity 中与函数输出相关的有两个关键字：return和returns。它们的区别在于：

returns：跟在函数名后面，用于声明返回的变量类型及变量名。

return：用于函数主体中，返回指定的变量。

在上述代码中，我们利用 returns 关键字声明了有多个返回值的 returnMultiple() 函数，然后我们在函数主体中使用 return(1, true, [uint256(1),2,5]) 确定了返回值。

这里uint256[3]声明了一个长度为3且类型为uint256的数组作为返回值。因为[1,2,3]会默认为uint8(3)，因此[uint256(1),2,5]中首个元素必须强转uint256来声明该数组内的元素皆为此类型。数组类型返回值默认必须用memory修饰，在下一个章节会细说变量的存储和作用域。

命名式返回
我们可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。


Solidity 支持使用解构式赋值规则来读取函数的全部或部分返回值。

读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列。

###  2024.09.30

变量数据存储和作用域 storage/memory/calldata

引用类型(Reference Type)：包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。

数据位置

Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少

大致用法：

storage：合约里的状态变量默认都是storage，存储在链上。

memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。

calldata：和memory类似，存储在内存中，不上链

与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。

数据位置和赋值规则

在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。规则如下：

赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：

memory赋值给memory，会创建引用，改变新变量会影响原变量。

其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方

变量的作用域

Solidity中变量按作用域划分有三种，分别是状态变量（state variable），局部变量（local variable）和全局变量(global variable)

1. 状态变量
状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。

2. 局部变量
局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。

3.全局变量是全局范围工作的变量，都是solidity预留关键字。


4. 全局变量-以太单位与时间单位
   
以太单位

Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易

wei: 1

gwei: 1e9 = 1000000000

ether: 1e18 = 1000000000000000000




可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在Solidity中是一个重要的概念，有助于提高合约的可读性和可维护性。

seconds: 1

minutes: 60 seconds = 60

hours: 60 minutes = 3600

days: 24 hours = 86400

weeks: 7 days = 604800

在这一讲，我们介绍了Solidity中的引用类型，数据位置和变量的作用域。重点是storage, memory和calldata三个关键字的用法。他们出现的原因是为了节省链上有限的存储空间和降低gas


引用类型, array, struct



###  2024.10.01

引用类型, array, struct

Solidity中的两个重要变量类型：数组（array）和结构体（struct）

数组（Array）是Solidity常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种：

可变长度数组（动态数组）：在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型，

注意：bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

创建数组的规则

在Solidity里，创建数组有一些规则：

对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。

数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化array的一种方式，并且里面每一个元素的type是以第一个元素为准的，例如[1,2,3]里面所有的元素都是uint8类型，因为在Solidity中，如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是uint8。而[uint(1),2,3]里面的元素都是uint类型，因为第一个元素指定了是uint类型了，里面每一个元素的type都以第一个元素为准。


数组成员

length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。

push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。

push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。

pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素

结构体 struct

Solidity支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法：

给结构体赋值的四种方法：

 给结构体赋值

方法1:在函数中创建一个storage的struct引用

方法2:直接引用状态变量的struct

方法3:构造函数式

方法4:key value


###  2024.10.02

映射（Mapping）类型，Solidity中存储键值对的数据结构，可以理解为哈希表。

映射Mapping
在映射中，人们可以通过键（Key）来查询对应的值（Value），比如：通过一个人的id来查询他的钱包地址。

声明映射的格式为mapping(_KeyType => _ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型

映射的规则
规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。

规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数（见例子）。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。

规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。

规则4：给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对

映射的原理
原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。

原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。

原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

###  2024.10.03

变量初始值


在Solidity中，声明但没赋值的变量都有它的初始值或默认值

boolean: false

string: ""

int: 0

uint: 0

enum: 枚举中的第一个元素

address: 0x0000000000000000000000000000000000000000 (或 address(0))

function

internal: 空白函数

external: 空白函数

bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet { Buy, Hold, Sell} 
    
    ActionSet public _enum; // 第1个内容Buy的索引0

    function fi() internal{} // internal空白函数
    
    function fe() external{} // external空白函数 


    引用类型初始值
映射mapping: 所有元素都为其默认值的mapping

结构体struct: 所有成员设为其默认值的结构体

数组array

动态数组: []

静态数组（定长）: 所有成员设为其默认值的静态数组


可以用public变量的getter函数验证上面写的初始值是否正确：

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

 delete操作符
    
delete a会让变量a的值变为初始值。

变量被声明但没有赋值的时候，它的值默认为初始值。不同类型的变量初始值不同，delete操作符可以删除一个变量的值并代替为初始值。

###  2024.10.04

常数 constant和immutable

Solidity中和常量相关的两个关键字，constant（常量）和immutable（不变量）。状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。

另外，只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。

constant和immutable

constant

constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。

immutable

immutable变量可以在声明时或构造函数中初始化，因此更加灵活。在Solidity v8.0.21以后，immutable变量不需要显式初始化。反之，则需要显式初始化。 若immutable变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。

你可以使用全局变量例如address(this)，block.number 或者自定义的函数给immutable变量初始化。在下面这个例子，我们利用了test()函数给IMMUTABLE_TEST初始化为9：

constant变量初始化之后，尝试改变它的值，会编译不通过并抛出TypeError: Cannot assign to a constant variable.的错误。

immutable变量初始化之后，尝试改变它的值，会编译不通过并抛出TypeError: Immutable state variable already initialized.的错误。


onstant（常量）和immutable（不变量），让不应该变的变量保持不变。这样的做法能在节省gas的同时提升合约的安全性。



###  2024.10.05

控制流

Solidity的控制流与其他语言类似，主要包含以下几种：

if-else

for循环

while循环

do-while循环

三元运算符

三元运算符是Solidity中唯一一个接受三个操作数的运算符，规则条件? 条件为真的表达式:条件为假的表达式。此运算符经常用作if语句的快捷方式

另外还有continue（立即进入下一个循环）和break（跳出当前循环）关键字可以使用。

用Solidity实现插入排序

写在前面：90%以上的人用Solidity写插入算法都会出错。

插入排序

排序算法解决的问题是将无序的一组数字，例如[2, 5, 3, 1]，从小到大依次排列好。插入排序（InsertionSort）是最简单的一种排序算法，也是很多人学习的第一个算法。它的思路很简单，从前往后，依次将每一个数和排在他前面的数字比大小，如果比前面的数字小，就互换位置。

这一讲，我们介绍了Solidity中控制流，并且用Solidity写了插入排序。看起来很简单，但实际很难。这就是Solidity，坑很多，每个月都有项目因为这些小bug损失几千万甚至上亿美元。掌握好基础，不断练习，才能写出更好的Solidity代码。


###  2024.10.06

这一讲，我们将用合约权限控制（Ownable）的例子介绍Solidity语言中构造函数（constructor）和独有的修饰器（modifier）。

构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，

注意：构造函数在不同的Solidity版本中的语法并不一致，在Solidity 0.4.22之前，构造函数不使用 constructor 而是使用与合约名同名的函数作为构造函数而使用，由于这种旧写法容易使开发者在书写时发生疏漏（例如合约名叫 Parents，构造函数名写成 parents），使得构造函数变成普通函数，引发漏洞，所以0.4.22版本及之后，采用了全新的 constructor 写法。

修饰器（modifier）是Solidity特有的语法，类似于面向对象编程中的装饰器（decorator），声明函数拥有的特性，并减少代码冗余。它就像钢铁侠的智能盔甲，穿上它的函数会带有某些特定的行为。modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。




###  2024.10.08

事件

Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：

响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。

经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

声明事件

事件的声明由event关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。以ERC20代币合约的Transfer事件为例：

    event Transfer(address indexed from, address indexed to, uint256 value);

我们可以看到，Transfer事件共记录了3个变量from，to和value，分别对应代币的转账地址，接收地址和转账数量，其中from和to前面带有indexed关键字，他们会保存在以太坊虚拟机日志的topics中，方便之后检索。

释放事件

我们可以在函数里释放事件。在下面的例子中，每次用_transfer()函数进行转账操作的时候，都会释放Transfer事件，并记录相应的变量。

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

EVM日志 Log
以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。 

![image](https://github.com/user-attachments/assets/c8c13ed5-e92f-46fa-9260-5fde3ea53d56)


主题 topics
日志的第一部分是主题数组，用于描述事件，长度不能超过4。它的第一个元素是事件的签名（哈希）。对于上面的Transfer事件，它的事件哈希就是：

keccak256("Transfer(address,address,uint256)")

//0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef

除了事件哈希，主题还可以包含至多3个indexed参数，也就是Transfer事件中的from和to。

indexed标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个 indexed 参数的大小为固定的256比特，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

数据 data

事件中不带 indexed的参数会被存储在 data 部分中，可以理解为事件的“值”。data 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 data 部分可以用来存储复

杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特，即使存储在事件的 topics 部分中，也是以哈希的方式存储。另外，data 部分的变量在存储上消耗的gas相比

于 topics 更少。

在Etherscan上查询事件

我们尝试用_transfer()函数在Sepolia测试网络上转账100代币，可以在Etherscan上查询到相应的tx：网址。

点击Logs按钮，就能看到事件明细：

![image](https://github.com/user-attachments/assets/7415fea8-4dd8-4aa9-9395-8ce33975e347)

Topics里面有三个元素，[0]是这个事件的哈希，[1]和[2]是我们定义的两个indexed变量的信息，即转账的转出地址和接收地址。Data里面是剩下的不带indexed的变量，也就是转账数量。




###  2024.10.10

Solidity中的继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承。

继承

继承是面向对象编程很重要的组成部分，可以显著减少重复代码。如果把合约看作是对象的话，Solidity也是面向对象的编程，也支持继承。

规则

virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。

override：子合约重写了父合约中的函数，需要加上override关键字。

注意：用override修饰public变量，会重写与变量同名的getter函数，

简单继承

我们先写一个简单的爷爷合约Yeye，里面包含1个Log事件和3个function: hip(), pop(), yeye()，输出都是”Yeye”。


contract Yeye {
    event Log(string msg);

    // 定义3个function: hip(), pop(), man()，Log值为Yeye。
    function hip() public virtual{
        emit Log("Yeye");
    }

    function pop() public virtual{
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}

我们再定义一个爸爸合约Baba，让他继承Yeye合约，语法就是contract Baba is Yeye，非常直观。在Baba合约里，我们重写一下hip()和pop()这两个函数，加上override关键字，并将他们的输出改为”Baba”；并且加一个新的函数baba，输出也是”Baba”。

contract Baba is Yeye{
    // 继承两个function: hip()和pop()，输出改为Baba。
    function hip() public virtual override{
        emit Log("Baba");
    }

    function pop() public virtual override{
        emit Log("Baba");
    }

    function baba() public virtual{
        emit Log("Baba");
    }
}

Solidity的合约可以继承多个合约。规则：

继承时要按辈分最高到最低的顺序排。比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，不然就会报错。

如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。

重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。

修饰器的继承

Solidity中的修饰器（Modifier）同样可以继承，用法与函数继承类似，在相应的地方加virtual和override关键字即可。

调用父合约的函数
子合约有两种方式调用父合约的函数，直接调用和利用super关键字。

直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，

super关键字：子合约可以利用super.函数名()来调用最近的父合约函数。Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()：

钻石继承
在面向对象编程中，钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类。

在多重+菱形继承链条上使用super关键字时，需要注意的是使用super会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。

我们先写一个合约God，再写Adam和Eve两个合约继承God合约，最后让创建合约people继承自Adam和Eve，每个合约都有foo和bar两个函数。



Solidity继承的基本用法，包括简单继承，多重继承，修饰器和构造函数的继承、调用父合约中的函数，以及多重继承中的菱形继承问题。


###  2024.10.13

抽象合约和接口

抽象合约
如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为abstract，不然编译会报错；另外，未实现的函数需要加virtual，以便子合约重写。拿我们之前的插入排序合约为例，如果我们还没想好具体怎么实现插入排序函数，那么可以把合约标为abstract，之后让别人补写上。

    abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
    }

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

另外，接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用abi-to-sol工具，也可以将ABI json文件转换为接口sol文件。

我们以ERC721接口合约IERC721为例，它定义了3个event和9个function，所有ERC721标准的NFT都实现了这些函数。我们可以看到，接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。

    interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
     }


IERC721事件

IERC721包含3个事件，其中Transfer和Approval事件在ERC20中也有。

Transfer事件：在转账时被释放，记录代币的发出地址from，接收地址to和tokenId。

Approval事件：在授权时被释放，记录授权地址owner，被授权地址approved和tokenId。

ApprovalForAll事件：在批量授权时被释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。

IERC721函数

balanceOf：返回某地址的NFT持有量balance。

ownerOf：返回某tokenId的主人owner。

transferFrom：普通转账，参数为转出地址from，接收地址to和tokenId。

safeTransferFrom：安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。

approve：授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。

getApproved：查询tokenId被批准给了哪个地址。

setApprovalForAll：将自己持有的该系列NFT批量授权给某个地址operator。

isApprovedForAll：查询某地址的NFT是否批量授权给了另一个operator地址。

safeTransferFrom：安全转账的重载函数，参数里面包含了data。


什么时候使用接口？

如果我们知道一个合约实现了IERC721接口，我们不需要知道它具体代码实现，就可以与它交互。

无聊猿BAYC属于ERC721代币，实现了IERC721接口的功能。我们不需要知道它的源代码，只需知道它的合约地址，用IERC721接口就可以与它交互，比如用balanceOf()来查询某个地址的BAYC余额，用safeTransferFrom()来转账BAYC。


     contract interactBAYC {
    // 利用BAYC地址创建接口合约变量（ETH主网）
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    // 通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }

    // 通过接口调用BAYC的safeTransferFrom()安全转账
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
        BAYC.safeTransferFrom(from, to, tokenId);
    }
    }

###  2024.10.14

异常

写智能合约经常会出bug，Solidity中的异常命令帮助我们debug。

Solidity三种抛出异常的方法：error，require和assert，并比较三种方法的gas消耗。

Error
error是solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。人们可以在contract之外定义异常。下面，我们定义一个TransferNotOwner异常，当用户不是代币owner的时候尝试转账，会抛出错误：

error TransferNotOwner(); // 自定义error

Require

require命令是solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。

Assert

assert命令一般用于程序员写程序debug，因为它不能解释抛出异常的原因（比require少个字符串）。它的用法很简单，assert(检查条件），当检查条件不成立的时候，就会抛出异常。

三种方法的gas比较

我们比较一下三种抛出异常的gas消耗，通过remix控制台的Debug按钮，能查到每次函数调用的gas消耗分别如下： （使用0.8.17版本编译）

error方法gas消耗：24457 (加入参数后gas消耗：24660)

require方法gas消耗：24755

assert方法gas消耗：24473

我们可以看到，error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas，大家要多用！（注意，由于部署测试时间的不同，每个函数的gas消耗会有所不同，但是比较结果会是一致的。）

备注: Solidity 0.8.0之前的版本，assert抛出的是一个 panic exception，会把剩余的 gas 全部消耗，不会返还。更多细节见官方文档。

###  2024.10.14
<!-- Content_END -->
