---
timezone: Asia/Shanghai
---

# rorozn

1. 自我介绍:  
   web2 转全职 web3 萌新, 希望找个 remote 工作

2. 你认为你会完成本次残酷学习吗？  
   会！学完试着参加黑客松

## Notes

<!-- Content_START -->

### 2024.09.15

**1.三行代码**

- 软件许可最好写上
- 注意结尾;号
- 注意 pragma 拼写，a 不是 o！

```solidity
// SPDX-License-Identifier:MIT

pragma solidity>=0.8.21; //solidity版本 ^相当于>=

contract HelloWeb3{ //合约内容
    string public _string = "Hello Web3!!";
}
```

- 部署 deploy 向链上写入代码，要消耗 gas 的

**2.值类型**

- payable 关键字：账户相关，可以转账、查余额
- bytes1 有 2 个 16 进制，0xff，bytes32 就有 64 个 16 进制，1 个 16 进制位=2\*\*4，bytes32=32\*2\*4=256 个 0
- [运算符优先级](https://docs.soliditylang.org/zh/v0.8.19/cheatsheet.html)

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract ValueType{
    bool public _bool= true;
    int public  _int = -1;
    uint public _uint =1;
    uint256 public _number= 20240915;
    //address
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1= payable (_address);
    uint256 public balance = _address1.balance;

    bytes32 public _byte32 = "solidity";
    string public text = "text";
    bytes1 public _byte = 0x01;
    bytes1 public _byte2 = 'b';

    //几乎很少用
    enum ActionSet{ Buy, Hold, Sell}
    ActionSet action = ActionSet.Hold;
    //enum转unit
    function enumToUint() external view returns(uint){
        return uint(action);
    }

}
```

### 2024.09.16

**btc 基础**

朋友问了我一个问题，觉得还是应该复习一下基础

- btc 的 fees 和矿工挖矿的收益是 1 个东西吗？  
  比特币的转账手续费（也称为矿工费）和挖矿奖励（block reward）是两个相关但独立的概念。挖矿奖励是矿工成功挖出一个区块时获得的固定数量的新生成的比特币。而交易手续费则是用户在进行比特币交易时支付给矿工的费用，以激励矿工将他们的交易包含在区块中。随着比特币挖矿奖励的减半，交易手续费在矿工收入中所占的比例将逐渐增加，并可能最终成为矿工的主要收入来源。
- btc 和 bch 分叉改了哪里？  
  BCH 的分叉涉及到对原始比特币代码的修改，比如增加区块大小、改变共识算法等。BCH 在 2017 年的分叉为了解决 BTC 的可扩展性问题，通过增加区块大小来允许更多的交易，从而减少费用和交易时间。分叉前链上数据一致，分叉后因为代码本质上就已经不一致了所以数据肯定不一致
- btc 的 fees 和 eth 的 gas 的区别？  
  **明天写**
- btc 的 fees 计算依据？交易失败时 gas 怎么处理？  
  **明天写**
- eth 的 gas 计算依据？交易失败时 gas 怎么处理？  
  笼统的说，根据 evm 里指令消耗算力多少，区块的大小(50%为界)，用户的 tip 设置；当执行 revert/require/assert 函数时,0.8.0 之前，gas 会被消耗掉不返还；0.8.0 之后的版本，revert 和 require 错误现在使用 EVM 的 REVERT 操作码，它允许错误信息被包含在交易回执中，并且剩余的 gas 可以被返还。
- UTXO 模型  
   A 有 7btc(5，2 两个未花费)，现在要转给 B 3btc，从 A 发起交易到 B 钱包查看到钱，发生了什么？换成 eth 的话过程又是怎样的？  
  **明天写**
- 第 1 比交易怎么从发起到写入区块的？在创世区块时，当全网只有 1 个节点机器的时候，代码如何运行的？  
  **明天写**

### 2024.09.17

### 2024.09.18

### 2024.09.19

### 2024.09.20

### 2024.09.21

### 2024.09.22

### 2024.09.23

<!-- Content_END -->
