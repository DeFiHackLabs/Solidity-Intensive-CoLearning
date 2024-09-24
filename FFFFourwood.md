---
timezone: Asia/Shanghai
---

# FFFFourwood 

1. 自我介绍
Hello everyone, I'm FFFFourwood, but you can call me "Arthur". I work as a software engineer.  JS｜React｜ C#
2. 你认为你会完成本次残酷学习吗？
Fighting!!!!
   
## Notes

<!-- Content_START -->
### 2024.09.23
Solidity 简介
* Solidity 是用于编写以太坊智能合约的编程语言。
* 特点：基于对象、高级。
* 掌握 Solidity 可帮助理解区块链项目，规避风险，提升币圈参与感。

开发工具：Remix
* Remix 是以太坊官方推荐的智能合约开发工具，适合新手。
* 无需安装软件，直接在浏览器中编写、编译和部署合约。
* 网址：[Remix](https://remix.ethereum.org/)
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
```
* 第一行：声明软件许可（MIT），以注释开头。
* 第二行：声明使用的 Solidity 版本（0.8.21）。
* 第三行：定义合约 HelloWeb3，并声明变量 _string，值为 "Hello Web3!"。

Solidity 值类型 个人笔记
1. 布尔型
* 取值：true / false
* 运算符：!（非），&&（与），||（或），==（等于），!=（不等于）
* 短路规则：&& 遇到 false，|| 遇到 true，后续不执行。
  
2. 整型
* 有符号整型 int，无符号整型 uint。
* 运算符：+，-，*，/，%（取余），**（幂运算）。
* 示例：uint256 public _number = 20220330;

3. 地址类型
* 普通地址：address
* 可支付地址：payable address，可以接收以太币并调用 balance 查询余额。

4. 定长字节数组
* 定长字节：bytes1，bytes32，最多 32 字节。
* 示例：bytes32 public _byte32 = "MiniSolidity";

5. 枚举（enum）
* 定义多个状态，值从 0 开始。
* 可以与 uint 相互转换。

函数
* pure 函数不读不写链上状态。
* view 函数仅能读取状态变量。
* payable 函数可以接收以太币。
* 函数可见性（public、private、internal、external）决定函数的访问权限。

函数输出总结
1. 返回值：return 和 returns
* returns：声明函数的返回类型，位于函数名后面。
* return：函数内部使用，返回具体值。

2. 命名式返回
* 在 returns 关键字中声明返回变量的名称，Solidity 会自动初始化并返回这些变量。
* 你可以选择显式使用 return，也可以省略。

3. 解构式赋值
* 可以通过解构赋值读取函数的所有或部分返回值。
* 不需要的返回值可以留空，用 , 隔开。
<!-- Content_END -->
