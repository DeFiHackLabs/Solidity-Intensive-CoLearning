---
timezone: America/Los_Angeles 
---

# 0xwangyi

1. Hi，我是0xwangyi，目前在美国从事体力劳动。谢谢你们举办了这个活动，让web3的玩家和从业者学习这个语言。我是2020年入的币圈，一直在玩二级市场，但我一直想学习以太坊这个语言，所以看到你们的推特的消息我就来报名参加，很感谢，真的，谢谢你们给大家这样一个优质的平台。

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
