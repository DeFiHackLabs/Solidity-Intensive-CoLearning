---
timezone: Asia/Shanghai
---

---

# YuanboXie

1. 自我介绍: Web3 & AI researcher

2. 你认为你会完成本次残酷学习吗？大概率可以
   
## Notes

- WTF Academy Solidity 101 1-15
- WTF Academy Solidity 102 16-30
- WTF Academy Solidity 103 31-50
- 完成取得 Solidity 101、102 链上证书

<!-- Content_START -->

### 2024.09.23

之前看过这个，但好久没写又忘了。今天重新捡起来复习一下。

- [101-1] 测试题有个地方第一遍打错了：`带有 pragma solidity ^0.8.4; 的智能合约能否被 solidity 0.8版本编译？`，答案是不行，这个0.8.4是只能被>=0.8.4的编译
- [101-2] 类型：value type、reference type、mapping type;
    - solidity 特殊类型：address，以及 payable address: `payable(address)`,后者比普通地址多了 transfer 和 send 方法, 以及可以通过 `address.balance` 查询余额;
    - 定长字节数组、不定长字节数组
    - enum

```solidity
address payable addr;
addr.transfer(1); // 注意这个是从合约给 addr 转账的意思，单位是 wei
```

- [101-3] function: 
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- {internal|external|public|private}：可见性，合约中定义的函数需要明确指定可见性，它们没有默认值。public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
    - public：内部和外部均可见。
    - private：只能从本合约内部访问，继承的合约也不能使用。
    - external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
    - internal: 只能从合约内部访问，继承的合约可以用。
- [pure|view|payable]：决定函数权限/功能的关键字。
    - pure: 既不能读取也不能写入链上的状态变量;
    - view: 能读取但也不能写入状态变量;
    - payable: 带 payable 的 function 可以存 ether;

以太坊交易需要支付 gas fee。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

<!-- Content_END -->
