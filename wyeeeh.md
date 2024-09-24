---
timezone: America/Los_Angeles
---


# Ye

1. 自我介绍
     - 清华-南加大 Communication Data Science 25'硕士在读，链上数据分析2年经验，Dune [@wyeeeh](https://dune.com/wyeeeh)。因为对链上数据的分析离不开合约解析，希望通过共学计划掌握Solidity的基础开发知识，能更好读懂合约的function和event。

2. 你认为你会完成本次残酷学习吗？
   - 有激励就有野心，之前完成过Sixdegree Lab和BuidlerDAO发起的Dune Analytics共学计划。
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### WTF Academy Solidity 101.1 Hello Web3 (三行代码)
- IDE：[Remix IDE](https://remix.ethereum.org)
- 合约：合约是 Solidity 中的一种结构，用于定义智能合约的代码和数据。
  - 许可：如果不写许可，编译时会出现警告（warning），但程序仍可运行。
  - 注释：单行注释 `//` ，多行注释 `/* */`
  - 状态变量：状态变量是合约中声明的变量，用于存储合约的状态。
  - 函数：函数是合约中用于执行特定任务的代码块。
  - 函数修饰器：函数修饰器用于修改函数的行为。
  - 事件：事件是合约中用于记录某些特定事件的代码块。
  - 错误：错误是合约中用于记录某些特定错误信息的代码块。
- 部署：`Ctrl + S` 
  - 默认情况下，Remix 会使用 Remix 虚拟机（以前称为 JavaScript 虚拟机）来模拟以太坊链，运行智能合约，类似在浏览器里运行一条测试链。Remix 还会为你分配一些测试账户，每个账户里有 100 ETH（测试代币）
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 指定编译器版本

contract HelloWeb3 {
    string public _string = "Hello Web3!"; // 创建合约（contract），并声明合约名为 HelloWeb3，状态变量为 _string
}
```
- 测验结果
  - 75/100
  - 100/100

### 2024.09.24

<!-- Content_END -->
