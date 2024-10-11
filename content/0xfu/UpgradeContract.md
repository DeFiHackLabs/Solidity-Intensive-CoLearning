
### 可升级合约

可升级合约就是一个可以更改逻辑合约的代理合约。 注意状态变量要保持一致, 在本例中
可以使用专门的对应函数实现处理调用委托，而不是在`fallback`中实现[只用来学习]

#### 代理合约

```Solidity 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SimpleUpgrade {
    address public implementation; // 逻辑合约地址
    address public admin; // admin地址
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
    fallback() external payable {
		(bool success,) = implementation.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
		require(implementation != newImplementation, "Can not upgrade to the same implementation");
        implementation = newImplementation;
    }
}
```

#### 旧逻辑合约

```Solidity
// 逻辑合约1
contract Logic1 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation;
    address public admin;
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器： 0xc2985578
    function foo() public{
        words = "old";
    }
}
```

#### 新逻辑合约

```Solidity
// 逻辑合约2
contract Logic2 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation;
    address public admin;
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器：0xc2985578
    function foo() public{
        words = "new";
    }
}
```
