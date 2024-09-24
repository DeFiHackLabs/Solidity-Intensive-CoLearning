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

<!-- Content_END -->
