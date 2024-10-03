---
timezone: America/Los_Angeles 
---

# 0xwangyi

1. Hi，我是0xwangyi，谢谢你们举办了这个活动，我一直想学习以太坊这个语言，所以看到你们的推特的消息我就来报名参加，很感谢，真的，谢谢你们给大家这样一个优质的平台。

2. 你认为你会完成本次残酷学习吗？
   回答：我会完成这次活动。
   
## Notes

<!-- Content_START -->
## 2024.09.23
Day1
Solidity 101-1 Hello Web3（三行代码）
1 以太坊虚拟机 EVM
2 以太坊智能合约集成开发环境Remix IDE
3 Remix左侧按钮：文件file、编译compile、部署deploy
4 第一行是licence（MIT许可）
5 第二行是声明源文件使用的版本
6 Solidity语句以分号；结尾
7 按Ctrl+S检查代码

Solidity 101-2（值类型）
1 Solidity变量类型：值类型Value Type、引用类型Reference Type、映射类型Mapping Type
2 值类型Value Type-布尔型bool（true 或false，! 取反，&& and，|| or，== 等于，!= 不等于，短路规则）
3 值类型Value Type-整型（int整数，uint正整数，uint256 256位正整数，比较运算符，算术运算符，注意：%取余，**幂）
4 值类型Value Type-地址类型（address普通地址，payable address（比address多了transfer和send，用于接收转账））
5 值类型Value Type-定长子节数组（bit 是汁算机中最小的数据単位（表示二进制中的0或1），1 byte = 2个16 进制数，1个16 进制数 = 4 bits，1 byte = 8 bits）

Solidity 101-3（function函数）
1 function（要编写函数，就以function关键词开头）
2 <function name>函数名字
3 (<parameter types>)圆括号内写函数的参数（输入到函数的变量类型和名称）
4 {internal /external /public /private}（函数可见说明符，合约中定义的函数需要明确指定可见性，它们没有默认值）
5 [pure /view /payable]（决定函数权限或功能关键字）
6 [return()]（函数返回的变量类型和名称
7 view函数可以读取状态变量，但不能改写
8 pure函数既不能读取也不能改写状态变量

Solidity 101-4函数输出
1 returns跟在函数名后边用于声明返回的变量类型及变量名
2 return用于函数主体中，返回指定的变量
3 命名式返回
4 解构式赋值读取函数全部/部分返回值
<!-- Content_END -->

<!-- Content_START -->
### 2024.09.24
Day2
Solidity 101-5 变量数据储存和作用域
1 引用类型reference type包括：数组array，结构体struct
2 要声明数据储存的位置
3 solidity数据储存位置有三类：storage，memory，calldata（storage类型数据存在链上，消耗gas最多；合约里的状态变量默认都是storage；
4 函数里的参数和临时变量一般用memory，存贮在内存中，不上链
5 calldata储存在内存中，不上链，calldata变量不能修改（immutable）
6 storage（合约的状态变量）赋值给本
storage（函数里的）时候，会创建引用，改变新变量会影响原变量
7 memory赋值给memory，会创建引用，改变新变量会影响原变量
8 solidity变量按作用域划分有三种：状态变量state variable，局部变量local variable，全局变量global variable
9 状态变量state variable是数据储存在链上的变量，所有合约内函数都可以访问，gas消耗高
10 局部变量local variable仅在函数执行过程中有效的变量，函数退出后，变量无效，储存数据不上链，gas低
11 全局变量global variable是全局范围工作的变量，可以在函数内不声明，直接使用
12 全局变量global variable有：
blockhash（unit blockNumber）给定区块的哈希值
block.coinbase当前区块矿工的地址
block.gaslimit当前区块的gaslimit
block.number当前区块的number
block.timestamp当前区块的时间戳（为unix纪元以来的秒
block.blobbasefee当前区块blob基础费用（这是Cancun升级新增的全局变量）
blobhash（unit index）返回跟当前交易关联的第index个blob的版本化哈希
gasleft剩余gas
msg.data:(bytes calldata)完整calldata
msg.sender:(address payable)消息发送者（当前caller）
msg.sig:(bytes4)calldata的前四个字节（function identifier）
msg.value:(unit)当前交易发送的wei值
13 全局变量-以太单位
wei ：1 （wei是以太坊最小单位）
gwei ：1e9 = 1后面有9个零的wei
ether ：1e18 = 1后面有18个零的wei
14 gwei是常用gas价格单位
15 msg是消息message缩写
16 EOA外部账户（用户通过私钥控制管理的账户）
17 以太坊两种账户类型：EOA私人账户，contract account合约账户
18 uint是unsigned integer无符号整数的缩写
19 u代表unsigned 无符号的
20 int是integer整数的缩写
21 int有符号整数（正数，负数，零）
22 uint无符号整数（正数，零）
23 注意：正整数是大于零的整数（不包括零）
<!-- Content_END -->
<!-- Content_START -->
### 2024.09.25
Day3
Solidity 101-6 引用类型、array、struct
1 array数组是一种变量类型，用来储存一组数据（int，bytes，address等）
2 array数据分为固定长度数组和可变长度数组
3 固定长度数组，比如unit[8] array1;
4 可变长度数组（动态数组），比如unit[ ] array2
5 bytes类型本身就是动态字节数组，理解成byte[ ]的简写，已经内置了动态数组功能，直接声明bytes array3即可，不需要再加上[ ]
5 对于memory修饰的动态数组，用关键字new来创建，要声明长度，声明后长度不能改变，比如 unit [ ] memory array8 = new unit [ ] (5);
6 数组字面常数array literals是通过使用方括号[ ]包围一组元素来初始化数组的方式
7 数组字面量的元素类型是根据上下文推断，特别是以第一个元素类型为准，比如 [unit (1), 2, 3]
8如果没有显式的制定元素的类型，solidity会默认选择最小的类型unit8来容纳这些值
9 数组成员-length，用来查看或调整storage数组的长度数量（但对于memory数组来说，长度是固定的，不适用memory数组）
10 数组成员-push( )，向动态storage数组末尾添加一个元素
11 数组成员-pop( )，向动态storage数组移除最后一个元素
12 数组成员-push(x)，向动态storage数组末尾添加一个具体的元素x
13 结构体struct，struct是定义结构体的关键字
14 uint256的默认值是0

Solidity 101-7 映射类型 mapping
1 声明映射的格式为mapping(KeyType => ValueType)，其中KeyType和ValueType分别是Key和Value的变量类型
2 映射的key只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体struct
3 映射的value可以使用自定义的类型，如struct
4 映射的存储位置必须是storage
5 mapping记录的是一种关系 (key-value pair)
6 如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value
7 给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对（注意是方括号）

Solidity 101-8 变量初始值
1 在Solidity中，声明但没赋值的变量都有它的初始值（默认值）
2 值类型初始值 boolean：false
3 值类型初始值 string：“ ”
4 值类型初始值 int：0
5 值类型初始值 uint：0
6 值类型初始值 enum：枚举中第一个元素
7 值类型初始值 address：0x后边40个0
8 值类型初始值 bytes1: 0x00
9 值类型初始值 function internal：空白函数
10 值类型初始值 function external：空白函数
11 引用类型初始值 映射mapping：所有元素都为其默认值的mapping
12 引用类型初始值 结构体struct：所有成员设为其默认值的结构体
13 引用类型初始值 数组array 动态数组：[ ]
14 引用类型初始值 数组array 静态数组（定长数组）：所有成员设为其默认值的静态数组
15 delete操作符：delete a会让a的值变成初始值

Solidity 101-9 常数constant和immutable
1 变量constant必须在声明时赋值（之后不能更改，完全静态，编译时就确定了值，在合约生命周期内保持不变）
2 变量immutable是能在合约的构造函数(关键词constructor)中赋值（初始化）（之后不能更改）
3 address(this)表示当前合约的地址
4 initialize v初始化
5 address(0)表示零地址(空地址)（0x后边40个0，全零地址，用于表示无效或未赋值的地址，或用于销毁代币）
6 在构造函数中赋值 = 在部署合约时赋值
<!-- Content_END -->
<!-- Content_START -->
### 2024.09.26
Day4
Solidity 101-10 控制流 用solidity实现插入排序
1 solidity控制流：if-else
2 solidity控制流：for循环
3 solidity控制流：while循环
4 solidity控制流：do-while循环
5 silidity控制流：三元运算符ternary operator实现两个数之间的大小比较，并返回其中最大值（return x >= y ? x : y;）
6 用solidity实现插入排序InsertionSort（注意⚠️：90%以上的人用solidity写插入算法都会出错，坑很多，每个月都有项目因为这些小bug损失钱）
7 常见错误：开发者错误地假设 Solidity 提供了类似于 Python 或 JavaScript 中的insert 方法，而实际上需要手动实现插入逻辑
8 Solidity 本身的局限性：Solidity 没有提供像其他高级语言那样的数组操作功能，需要开发者手动处理插入逻辑
9 i++在每次循环结束时执行，将i的值增加1
10 solidity控制流关键字：continue（跳过当前循环的剩余部分，直接进入下一次循环
11 solidity控制流关键字：break（立即终止整个循环）

Solidity 101-11 构造函数和修饰器
1 构造函数constructor：每一个合约可以定义一个构造函数constructor，并在部署合约的时候自动运行一次，可以用来初始化合约的一些参数
2 合约权限控制Ownable（Ownable合约是Openzeppelin中常见合约，为智能合约提供了一个基本的所有权控制机制
3 OpenZeppelin 是一个开源的智能合约库，它为开发者提供了一套经过审计的、安全的智能合约模块（安全性，标准化，模块化，可扩展性）
4 修饰器modifier（类似OOP中的装饰器decorator），主要用于运行函数前的检查，比如地址，变量，余额等
5 Cloudflare公司（内容分发网络CDN，DDoS攻击防护，DNS服务）

Solidity 101-12 事件event
1 事件event是EVM上日志的抽象
2 事件event特点：应用程序ether.js可以通过RPC接口订阅和监听这些事件，并在前端做响应；事件event是EVM上比较经济的储存数据的方式
3 声明事件：事件的声明又关键词event开头，接着是事件名称，然后（）里边写好事件需要记录的变量类型和变量名
4 Transfer事件：event Transfer (address indexed from, address indexed to, uint256 value);
5 indexed关键字，会保存在以太坊虚拟主机日志的topics中，方便检索
6 释放事件：emit Transfer (from, to, amount); //使用emit触发Transfer事件，记录转账细节
7 emit关键字用于触发事件，它告诉EVM记录一个事件到区块链日志中，以便外部系统可以监听和处理该事件
8 address indexed from代币转出地址
9 address indexed to代币接收地址
10 uint256 value转移代币数量
11 EVM日志log：以太坊虚拟机EVM用日志log来储存solidity事件，每条日志记录都包含主题topics和数据data两部分
12 主题topics包括：哈希keccak256（事件的签名），from，to（除了哈希，topics还可以包括最多3个indexed参数）
13 数据data：事件event中不带indexed的参数会被储存在data中（可以理解成事件event的值value）
<!-- Content_END -->
<!-- Content_START -->
### 2024.09.27
Day5
Solidity 101-13 继承inheritance
1 virtual：父合约中的函数，如果希望子合约重写，需要加上virtual关键字
2 override：子合约重写了父合约中的函数，需要加上override关键字
3 继承时要按辈分最高到最低的顺序排
4 如果某一个函数在多个继承的合约里都存在，在子合约里必须重写，不然会报错
5 重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)
6 调用父合约函数-直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，如Yeye.pop()
7 调用父合约函数-super关键字：子合约可以利用super.函数名()来调用最近的父合约函数
8 is关键字：表示继承（Child is Parent意思是Child合约继承了Parent合约的功能）
<!-- Content_END -->
<!-- Content_START -->
### 2024.09.29
Day7
Solidity 102-17库合约Library Contracts
1 using A for B：使用库合约A的函数来扩展类型B的功能（B类型的变量可以直接调用库合约A的函数）

Solidity 102-18 import
1 import导入
2 npm ：Node Package Manager，随Node.js 一起发布的包管理工具
3 Solidity中import的作用是：导入其他合约中的全局符号
4 import导入文件的来源可以是：源文件网址，npm的目录，本地文件
5 import导入文件中的全局符号可以单独指定其中的：合约，纯函数，结构体类型
6 被导入文件中的全局符号想要被其他合约单独导入，应该：与合约并列在文件结构中
7 导入的本地文件会被编译成字节码部署到链上
8 在import 语句中使用*是为了导入一个Solidity 文件中的所有内容，并通过一个命名空间来访问这些内容
<!-- Content_END -->
<!-- Content_START -->
### 2024.09.30
Day8
Solidity 102-19 接收ETH receive和fallback
1 receive( ) external payable { } 注意⚠️：receive( )函数不能有任何参数，不能返回任何值，必须包含external和payable
2 fallback( )函数会在调用合约不存在的函数时被触发，可以用于接收eth，也可以用于代理合约proxy contract
3 fallback( ) external payable 也可以接收eth
4 bytes data在solidity中表示原始的字节数据
5 receive( )函数用于处理纯粹的eth发送
6 fallback( )函数用于处理带有数据的调用或调用不存在的函数时接收eth
7 Dapp = decentralized application 去中心化应用

Solidity 102-20 发送ETH transfer, send, call
1 call没有gas限制，最为灵活，提倡使用
2 transfer有2300 gas限制，但发送失败会自动revert( )回滚交易，次优选则
3 send有2300 gas限制，而且发送失败不会自动revert( )回滚交易，几乎没人用

Solidity 102-21 调用其他合约
1 Name(address).f( ) 解析：name是目标合约或接口名字，address是目标合约地址，f是要调用的目标合约中的函数
2 安全性依赖合约设计
3 UI = user interface 用户界面
4 interface 接口 （关键字interface表示你定义了一个接口）
<!-- Content_END -->
<!-- Content_START -->
### 2024.10.01
Day9
Solidity 102-22 call
1 call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值
2 ABI（Application Binary Interface，应用二进制接口） 是合约与外界（如用户或其他合约）之间交互的标准接口
3 address类型主要内置函数有：transfer，send，call

Solidity 102-23 delegatecall
1 delegate是address类型的成员函数
2 当用户A通过合约B来delegatecall合约C时，执行了C的函数，语境（上下文）是B，msg.sender和msg.value来自A，并且如果函数改变一些状态变量，产生的效果会作用于B的变量上（B call C，上下文为C；B delegatecall C，上下文为B；这就是call和delegate区别）
3 delegatecall在调用合约时候：可以指定交易发送的gas，但不可以指定发送的eth数额
4 使用delegatecall对当前合约和目标合约的状态变量要求是：变量名，变量类型，声明顺序都必须相同
5 在代理合约中，储存所有相关的变量的是代理合约，储存所有函数的是逻辑合约，同时代理合约delegatecall逻辑合约
6 代理合约Proxy Contracts
<!-- Content_END -->
<!-- Content_START -->
### 2024.10.02
Day10 
Solidity 102-24 在合约中创建新合约
1 solidity中新建合约的关键字是：new
2 一个工厂合约PairFactory创建Pair合约的最大数量一般由PairFactory合约逻辑决定
3 params是parameters缩写，参数

Solidity 102-25 Create2
1 Create2与Create的不同之处在于：Create2可以让合约地址独立于未来的事件
2 nonce随机数，是number only used once缩写，防止攻击，确保每个操作唯一，并且通常递增
3 salt是一个随机生成的值，增加随机性，避免生成相同输出而使用
4 initcode 是合约的初始化代码，它包含合约的字节码和构造函数参数，用于部署时生成合约的最终逻辑

Solidity 102-26 删除合约
1 删除合约的命令，现在常用：selfdestruct
2 坎昆升级后，合约依然存在，只是将合约包含的eth转移到指定地址，而合约依然能够调用
<!-- Content_END -->
<!-- Content_START -->
### 2024.10.03
Day11
Solidity 102-27 ABI编码解码
1 abi.decode 的逆向操作函数（反函数）是abi.encode
2 abi.encode( )是 Solidity 提供的函数、用干对传入的变量讲行 ABI编码
3 在以太坊中，数据必须编码成字节码才能和智能合约交互

Solidity 102-28 Hash
1 哈希函数hash function可以将任意长度的消息转化为一个固定长度的值，这个值也叫哈希hash
2 最常用的哈希函数为：keccak-256
3 好的哈希函数特性：单向性，灵敏性，高效性，均一性，抗碰撞性

Solidity 102-29 函数选择器selector
1 函数签名是函数名和参数类型的组合（如：transfer(address,uint256)）
2 函数选择器selector和Method ID是通过对函数签名哈希后生成的前 4 个字节，用于标识函数；selector = method id
3 每个合约中的函数都会有一个唯一的函数选择器（也就是Method ID），用于区分不同的函数

Solidity 102-30 try-catch
1 try-catch用于处理外部合约调用时的错误
2 try模块在调用成功的情况下运行，而catch模块则在调用失败时运行
3 revert() 是 Solidity 中的一个函数，用于显式触发异常，并且它会返回 bytes 类型的数据
<!-- Content_END -->
