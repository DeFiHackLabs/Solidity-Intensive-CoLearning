---
timezone: Asia/Shanghai
---

---
# 0xiaoyu

1. 自我介绍

   Hotcoin Research的技术研究员、资深 gamer

2. 你认为你会完成本次残酷学习吗？

   努力完成，冲


## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 

- [solidity-101 第一课](https://www.wtf.academy/docs/solidity-101/HelloWeb3)

笔记：

HelloWeb3.sol

```
// SPDX-License-Identifier: MIT
// 开源代码的许可证类型

pragma solidity ^0.8.21;
// 指定编译器版本，表示此合约兼容0.8.21及以上版本，但不兼容0.9.0及以上版本

// 定义一个名为HelloWeb3的智能合约
contract HelloWeb3{

    // 定义一个名为_string的公共字符串变量，并初始化为"Hello Web3!"
    string public _string = "Hello Web3!";
    // public 关键字使得这个变量可以被外部读取
}
```

### 2024.09.24

學習內容: 

- [solidity-101 第二课](https://www.wtf.academy/docs/solidity-101/ValueTypes/)
- [solidity-101 第三课](https://www.wtf.academy/docs/solidity-101/Function/)

笔记：值类型和函数

#### 1. 值类型

Solidity 中的值类型包括：

##### 1.1 布尔型 (bool)

- 取值：`true` 或 `false`
- 运算符：`!`（非）、`&&`（与）、`||`（或）、`==`（等于）、`!=`（不等于）
- 注意：`&&` 和 `||` 遵循短路规则

##### 1.2 整型 (int/uint)

- `int`：包括负数的整数
- `uint`：正整数
- `uint256`：256位正整数
- 运算符：
  - 比较：`<=`、`<`、`==`、`!=`、`>=`、`>`
  - 算术：`+`、`-`、`*`、`/`、`%`（取余）、`**`（幂）

##### 1.3 地址类型 (address)

- 普通地址：存储 20 字节的值
- payable address：可以接收转账，有 `transfer` 和 `send` 方法

##### 1.4 定长字节数组

- 属于值类型
- 类型：`bytes1`, `bytes8`, `bytes32` 等
- 最多存储 32 bytes 数据

##### 1.5 枚举 (enum)

- 用户定义的数据类型
- 可以和 uint 显式转换

#### 2. 函数

Solidity 函数的基本结构：

```
solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

#####  2.1 函数可见性

- `public`：内部和外部均可见
- `private`：只能从本合约内部访问
- `external`：只能从合约外部访问
- `internal`：只能从合约内部和继承的合约访问

#####  2.2 函数权限/功能关键字

- `pure`：不能读取也不能写入状态变量
- `view`：能读取但不能写入状态变量
- `payable`：可以接收 ETH 转账

#####  2.3 状态修改

以下操作被视为修改链上状态：

1. 写入状态变量
2. 释放事件
3. 创建其他合约
4. 使用 `selfdestruct`
5. 通过调用发送以太币
6. 调用任何未标记 `view` 或 `pure` 的函数
7. 使用低级调用
8. 使用包含某些操作码的内联汇编

##### 2.4 注意事项

- 合约中定义的函数需要明确指定可见性
- `public|private|internal` 也可用于修饰状态变量
- 包含 `pure` 和 `view` 关键字的函数直接调用不需要支付 gas 费用


<!-- Content_END -->
