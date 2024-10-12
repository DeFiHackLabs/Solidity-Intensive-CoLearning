---
timezone: Asia/Shanghai
---

---

# Breeze

1. 自我介绍; 
I'm Breeze, a software development engineer specializing in front-end and script development

2. 你认为你会完成本次残酷学习吗？
of course 
   
## Notes

<!-- Content_START -->

### 2024.09.23
I studied lessons 01-03 of the Solidity 101 course from WTF Academy and completed the corresponding tasks
### 2024.09.24
completed lessons 04-06
### 2024.09.26
completed lessons 07-09
### 2024.09.27
completed lessons 10-12
### 2024.09.28
completed lessons 12-15
### 2024.09.29
completed lessons 16-18
### 2024.09.30
completed lessons 19-21
### 2024.10.01
completed lessons 22-24；
### 2024.10.02
completed lessons 25-27；
### 2024.10.05
completed lessons 28-30；

Todo:
- Proxy Contract
- EIP-2535 Diamonds
### 2024.10.06
completed lessons 31-33；

Todo:
- design fintness token by using ERC20

### 2024.10.09
Completed all tasks of Solidity 101 with a score of 100 for each task.

### 2024.10.10
Completed all tasks of Solidity 101 with a score of 100 for each task.

### 2024.10.11
design Tua toekn contract which is follow ERC20, the sourceCode is https://github.com/weifengHuang/fitness-dapp/blob/main/packages/hardhat/contracts/TuaToken.sol

### 2024.10.12

proxy contract:
 - https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies
 - Unstructured Storage Proxies: avoid the Storage collision ; and the proxy contract don't need set the logic proxy variable;


 ```
 pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;
    address public admin;

    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    function upgrade(address newImplementation) external {
        require(msg.sender == admin, "Only admin can upgrade");
        implementation = newImplementation;
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}
 ```

 ```
contract Proxy {
    address private _implementation;
}

contract LogicV1 {
    uint256 private _value;
    // other functions...
}

contract LogicV2 {
    uint256 private _value;
    uint256 private _taxRate; 
    // new variable and function
}
 ```

<!-- Content_END -->
