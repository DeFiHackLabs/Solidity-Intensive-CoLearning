---
timezone: Asia/Shanghai
---



# awaqawaqawaq

1. 区块链新人,没有经验，啥也不会，不过总有开始的一步(
 
2. 你认为你会完成本次残酷学习吗？ maybe(70%)
   
## Notes

<!-- Content_START -->

### 2024.09.23
时间：45min  學習內容: solidity101 1~5

- [Solidity](https://www.wtf.academy/docs/solidity-101/HelloWeb3/) 是一种用于编写以太坊虚拟机（EVM）智能合约的编程语言。

- 值类型(Value Type)/引用类型(Reference Type)/映射类型(Mapping Type)
- 函数格式
```solidity  
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- 注意：Pure函数是不修改状态，纯计算函数
- internal external payable
- 返回值：return 和 returns
  returns (<return types>) 是函数的返回值声明，用于指定函数的返回类型。它必须紧跟在函数名和参数列表之后，并且用圆括号括起来。
  

  ```solidity
  function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array)
  ```
    returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。
- storage，memory和calldata
  
storage（合约的状态变量）赋值给本地storage（函数里的）,memory赋值给memory，会创建引用 
- tansfer的默认单位是wei
### 

<!-- Content_END -->
