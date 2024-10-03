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

###  2024.10.03



<!-- Content_END -->
