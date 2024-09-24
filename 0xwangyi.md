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

