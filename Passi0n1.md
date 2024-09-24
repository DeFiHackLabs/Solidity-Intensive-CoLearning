---
timezone: Asia/Shanghai
---
---

# Passi0n1

1. hi,我是Passi0n1。我对于传统安全比较了解，对于web3安全仅有一些基础，希望可以精进自己的技术。
2. 你认为你会完成本次残酷学习吗？会的。

## Notes

<!-- Content_START -->
### 2024.09.23
#### 学习笔记
函数可见性说明符：
从可见范围，依次变窄的角度去描述：

`public`   合约内外均可访问

`external` 只能从合约外部进行调用，但是如果合约内部真的有调用的需要的花可以通过 `this.f()` 进行调用.

`internal` 只可以由合约内部以及继承的合约调用

`private`  只能从本合约内部访问，即使是继承的合约也不能使用


在此处可以注意一些合约在部署的时候可见性规范不到位，导致的合约漏洞

参考一个由于可见性造成的漏洞
https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7
```
function initWallet(address[] _owners, uint _required, uint _daylimit) {    
  initDaylimit(_daylimit);    
  initMultiowned(_owners, _required);  
}
```
当然，本身 `initWallet` 函数在初始化的时候没有进行调用者身份检查就存在问题。

### 2024.09.24
#### 学习笔记

## 决定函数权限/功能的关键字:

`payable` 此关键字可以说明某个函数可以接收 ETH

```
contract PaymentContract {
    function receivePayment() public payable {
        // 这里可以记录支付信息或执行其他操作
    }
}
```

`pure`  既不能读，也不能写，只适合用来标记哪些不会改变内容的函数。比如下面的 a+b，这里只是返回了 a+b，同样也没有把 a+b 的结果写入某个其他的变量

这里需要辨析的是当 `pure` 函数接收参数并在其内部使用这些参数进行计算时，这不被视为“读取”数据，因为这些参数是函数调用时由外部提供的，而不是从合约状态中获取的。

换句话来说，`view` 和 `pure` 的指的则是合约 storage 内容的读写，所以从外部来的数据的读写必然不算做是读写。




`view`  不可以写，但是可以读


`view` 和 `pure` 都不会消耗 gas。

```
pragma solidity ^0.8.0;

contract Example {
    uint256 public value;

    function pureFunction(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b; // 不会读取或修改value
    }

    function viewFunction() public view returns (uint256) {
        return value; // 可以读取value，但不能修改它
    }

    function modifyFunction() public {
        value = 10; // 可以修改value
    }
}
```


## pure 和 view 的由来

那么既然到了这里。不如进一步的探讨下 `pure` 出现的背景和解决的那些问题：
Solidity 版本: pure 关键字是在 Solidity 0.4.17 版本中引入的，在 `pure` 和 `view` 出现之前，合约还需要通过 `contact` 去标记说明那些不会修改合约状态的函数，

`在 Solidity 0.4.24 及之前的版本中，constant 关键字用于表示函数不会修改合约的状态。即使函数需要读取状态变量，也可以使用 constant 关键字。然而，这种用法可能会引起一些混淆，因为它并不完全准确地反映函数的行为。在后续的版本中，view 关键字被引入来更明确地表示函数不会修改状态，而 pure 关键字用于表示函数既不读取也不修改状态。`


```
pragma solidity ^0.4.24;

contract Example {
    uint256 public value;

    // 这个函数不会修改状态变量value，但可以读取它
    function getValue() public constant returns (uint256) {
        return value;
    }

    // 这个函数既不会读取也不会修改状态变量value
    function calculate(uint256 a, uint256 b) public constant returns (uint256) {
        return a + b;
    }
}
```

那么，pure 和 view 解决的第一个问题就出现了：**去除混淆**。

**去除不必要的理解**：除此之外，solidity 的开发需要多人协作，通过泾渭分明的关键字去表示功能开发人员可以减少很多不必要的工作量。
**明确函数的预期行为**：任何的不明确都可能造成安全的隐患
**降低编译成本**


https://passi0n1.github.io/post/payable%E3%80%81view-he-%20pure.html


<!-- Content_END -->
