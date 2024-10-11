
#### 选择器冲突

智能合约中，函数选择器（selector）是函数签名的哈希的前4个字节。由于函数选择器
仅有4个字节，范围很小，因此两个不同的函数可能会有相同的选择器，称为选择器
冲突(Selector Clash)。

如以下合约：

```Solidity 
// 选择器冲突的例子
contract Foo {
    function burn(uint256) external {}
    function collate_propagate_storage(bytes16) external {}
}
```
这两个函数的选择器都是 `0x42966c68`，这种情况下，EVM无法通过函数选择器分辨用户
调用哪个函数，因此该合约无法通过编译。

由于代理合约和逻辑合约是两个合约，就算他们之间存在“选择器冲突”也可以正常编译，
这可能会导致很严重的安全事故。目前有两个可升级合约标准解决了这一问题：透明
代理Transparent Proxy和通用可升级代理UUPS。

### 透明代理

管理员可能会因为“函数选择器冲突”，在调用逻辑合约的函数时误调用代理合约的可升级函数。
那么限制管理员的权限，不让他调用任何逻辑合约的函数就能解决冲突; 管理员变为工具人，仅
能调用代理合约的可升级函数对合约升级，不能通过回调函数调用逻辑合约。其它用户不能
调用可升级函数，但是可以调用逻辑合约的函数。

所以本质上是在可升级合约中对升级功能和调用逻辑函数功能的权限做了隔离，从而避免了
选择器冲突。

#### 代理合约
```Solidity 
contract TransparentProxy {
    address implementation; // logic合约地址
    address admin; // 管理员
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
    // 不能被admin调用，避免选择器冲突引发意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}
```

#### 逻辑合约

```Solidity
// 旧逻辑合约
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

// 新逻辑合约
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
