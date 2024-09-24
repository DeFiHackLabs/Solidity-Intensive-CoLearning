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
### 2024.09.24
一、关于solidity的变量类型
1.值类型(Value Type)
    bool 
    uint（num） -->正整数 num是bit位 e.g： uint256 public _a = 20220330; // 256位正整数
    int 
    **address：**
    一、定义:
        address 是solidity特有的 
        address类型的变量可以存储一个 20 字节的值，代表一个以太坊账户地址。这个地址可以是外部账户（由用户控制的账户，拥有私钥）或合约账户的地址。
        通常以十六进制形式表示，例如0x1234567890abcdef1234567890abcdef12345678。
        二、主要属性和方法
        balance属性：可以使用address.balance来查询一个地址的以太币余额。例如，address payable someAddress; uint256 balance = someAddress.balance;可以获取地址someAddress的以太币余额并存储在变量balance中。    
        transfer方法：用于向一个地址发送以太币。例如，someAddress.transfer(100);将向地址someAddress发送 100 wei（以太坊的最小货币单位）的以太币。这个方法会抛出异常如果发送失败。
        send方法：也用于发送以太币，但它返回一个布尔值表示发送是否成功。例如，bool success = someAddress.send(100);如果发送成功，success将为true，否则为false。
        call方法：可以用于与其他合约进行交互或执行低级别的调用。它接受一个字节数组作为参数，可以指定要调用的函数和传递的参数。例如，(bool success, bytes memory data) = someAddress.call(abi.encodeWithSignature("someFunction()"));执行对地址someAddress上的 “someFunction” 函数的调用。
    **Q1:**
    address payable addr;
    addr.transfer(1);
    **合约向addr 转账 1wei**
    定长字节数组(数值类型):数组长度在声明之后不能改变. e.g.:bytes1 bytes32 其最多存储32bytes数据  
        一字节等于8bit
    enum (太冷门了,无人问津...)
2.引用类型(Reference Type)
    不定长字节数组
3.映射类型(Mapping Type)
4.函数类型(Function Type)
### 
<!-- Content_END -->
