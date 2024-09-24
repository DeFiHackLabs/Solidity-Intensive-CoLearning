---
timezone: Asia/Shanghai
---



# Rumbia

1. 自我介绍
    一个酷爱web3的未来伟大交易者

2. 你认为你会完成本次残酷学习吗？
   要么完成，要么死亡  
   
## Notes

<!-- Content_START -->

### 2024.09.23
一、 git操作
Git是一个分布式版本控制系统
克隆仓库            git clone 
查看分支            git branch(git branch -r 列出远程跟踪分支 git branch -a 本地和远程all分支)
创建分支            git checkout -b <branch-name> 
添加文件到暂存区     git add 
提交修改            git commit -m "message"(将暂存区的修改提交到本地的仓库 message用来描述提交的内容)
推送修改到远程仓库   git push (更新远程仓库状态)
二、solidity 
Solidity 是一种用于编写以太坊虚拟机（EVM）智能合约的编程语言.
Remix -> IDE
//----许可证
// SPDX-License-Identifier: MIT
//----"^"符号-----
“^0.8.21” 表示要求使用的 Solidity 编译器版本至少为 0.8.21，但不包括下一个主版本（0.9.0 及以上版本）。
符号 “^” 在版本范围指定中被称为 “caret” 符号，
它允许使用与指定版本具有相同主版本号和更高的次版本号及补丁版本号，只要不破坏向后兼容性。
pragma solidity ^0.8.21;
//合约
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
### 

<!-- Content_END -->
