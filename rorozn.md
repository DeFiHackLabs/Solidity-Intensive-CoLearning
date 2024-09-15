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

### 2024.09.17

### 2024.09.18

### 2024.09.19

### 2024.09.20

### 2024.09.21

### 2024.09.22

### 2024.09.23

<!-- Content_END -->
