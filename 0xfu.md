---
timezone: Asia/Shanghai
---


# 0xfu

1. 自我介绍

  大家好，我是0xfu，有5年 Golang 开发经验，熟悉 Solidity 和 React，加入共学营和大家一起学习!

2. 你认为你会完成本次残酷学习吗？

  一定可以的!!!

## Notes

已经学习过101、102课程并且获得WTF链上证书，本次共学以学习103课程为主，同时巩固之前的学习。

学习计划：

- 103课程从31-57节从27节课程，在22天的共学期间完成学习

- 对于有深度的章节进行拓展学习，并输出技术文章	



<!-- Content_START -->

### 2024.09.23

#### ERC20代币标准

ERC20代币标准规定了一个同质化代币（合约）要满足的基本功能（函数）, 如下：

- 账户余额(balanceOf())
- 转账(transfer())
- 授权转账(transferFrom())
- 授权(approve())
- 代币总供给(totalSupply())
- 授权转账额度(allowance())

由 **IERC20** 接口合约定义规范，**IERC20** 是 **ERC20** 代币标准的接口合约，接口和 Golang 中的接口一样，只定义规范不定义实现，由继承接口的合约完成函数的实现。对于外部调用者来说，合约通过继承接口的方式约定了其可以被调用的函数集合（实现的功能）。

#### 拓展

由接口原理可知 **ERC20** 合约不是必须要继承 **IERC20** 接口的，只要实现了 **ERC20** 标准需要的功能函数就可以算是一个 **ERC20** 合约；但是继承接口可以确保合约实现 **ERC20** 标准所需的所有功能和事件，从而保证与其他合约和工具的兼容性; 不继承可能导致与其他依赖 **ERC20** 标准的工具或合约的兼容性问题，所以现在继承 **IERC20** 接口是普遍的做法。

对于调用方来说，尤其一个功能复杂的 Dapp， 为了避免意外的错误，可以用 **supportsInterface** 方法检查合约是否符合预期的标准接口，帮助调用者动态确认合约的功能，避免在调用不存在的方法时导致错误，同时提高合约的灵活性和安全性。

**supportsInterface** 是 **ERC165** 提出的，**ERC165** 合约用于检测合约是否支持特定的接口。其主要目的是允许合约在运行时声明它们支持的接口，从而实现更好的互操作性。 对于一个ERC20合约，可以通过继承 **ERC165** 合约来支持这种检测。

**supportsInterface** 实现：

```Solidity

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is IERC20, ERC165 {
    // 实现 IERC20 的方法...

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC20).interfaceId || super.supportsInterface(interfaceId);
    }
}

```

为什么有的著名的 **ERC20** 合约没有继承 **IERC20** 和 **ERC165** ？

由于历史原因，很多著名合约发布时 **IERC20** 标准和 **ERC165** 标准还没有普遍采用，许多早期合约并没有成熟的标准可以参考，所以都没有继承这些后期确定的标准。


### 

<!-- Content_END -->
