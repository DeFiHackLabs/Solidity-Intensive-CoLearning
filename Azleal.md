---
timezone: Asia/Shanghai
---

# Azleal

1. 自我介绍
> 全栈开发，重新复习一下solidity

2. 你认为你会完成本次残酷学习吗？
> 可以
   
## Notes

<!-- Content_START -->
### 2024.09.23
1. remix的使用

2. 变量类型
   - 值类型: 赋值时候直接传递数值
   - 引用类型: 包括数组和结构体，这类变量占空间大，赋值时候直接传递地址
   - 映射类型: Mapping
  
### 2024.09.24
1. 函数的基本形式
   `function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [virtual|override] [<modifiers>] [returns (<return types>)]{ <function body> }`
2. 数据存储的位置
   - calldata: 存在内存中，不可变，多用于参数传递
   - memory: 存在内存中，当返回结果为变长类型时必须使用memory
   - storage: 存在链上。
消耗gas的多少如下: calldata < memory < storage

一些节省gas的tips: 函数体内将storage遍历转化为memory变量，能够在后续使用的过程中有效降低gas。

### 2024.09.25
数组是一种引用类型，所以必须在声明定义时，加上三个数据位置（data location）关键字之一： `storage` , `memory` , `calldata` 
1. 静态数组
```
uint[3] memory memArray;
uint[3] storage storageArray;
```
静态数组的大小必须在编译时确定，即不能使用变量来指定数组的大小。如`uint size=2; uint[size][size] memory array;` 这种写法是错误的。

2. 动态数组
```
uint n = 2;
uint[] memory memArray = new uint[](n);
// 仅storage才可以使用下面的方式初始化
uint[] storage storageArray = [uint(1), 2];;
```
### 2024.09.26
1. `mapping`
   - 声明映射的格式为`mapping(_KeyType => _ValueType)`.其中`_KeyType`只能为solidity的内置类型，`_ValueType`可以使用内置类型及自定义的类型(`struct`).
   - `mapping`布局, keccak256(abi.encodePacked(key, slot)).映射元素槽索引是通过keccak256我们想要的元素的键（左侧填充 0 到 32 字节）和映射的声明槽索引的串联哈希来计算的.
2. 变量初始值
```solidity
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000
enum ActionSet { Buy, Hold, Sell}
ActionSet public _enum; // 第1个内容Buy的索引0
function fi() internal{} // internal空白函数
function fe() external{} // external空白函数 
```

<!-- Content_END -->
