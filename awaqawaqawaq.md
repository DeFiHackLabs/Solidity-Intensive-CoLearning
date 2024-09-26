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

### 2024.09.24
时间：90min  學習內容: solidity101 5~10
- array：
  - bytes比较特殊，是数组，但是不用加[]
  - memory动态数组，可以用new操作符来创建，但是必须声明长度
  - 如果创建的是动态数组，你需要一个一个元素的赋值

- struct
- Mapping，struct和array不可以作为mapping的key
- 变量初始值
- 0x00 = 1 byte
- constant和immutable
  -string可以是constant，但是不能是immutable，**constant的值在编译时确定，immutable的值在部署时确定**。
- 定义时赋值为显示赋值，构造函数为隐式赋值
  
### 2024.09.25
时间：90min  學習內容: solidity101 11~15
- 构造函数
- modifier  类似decorator
- event  
  - Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：
  
      响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。

      经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

  - event <event name>(<parameter types>);  // 声明事件
  - emit <event name>(<parameter values>);  // 触发事件
  - indexed 记的参数可以理解为检索事件的索引“键”
- require和revert
  - error 可自定义，可包含信息，revert error()  **gas最低**
  - require(condition, "error message");  // 如果条件为false，则回滚交易并返回错误信息
  - revert("error message");  // 回滚交易并返回错误信息
- assert
  - assert(condition);  // 如果条件为false，则回滚交易并返回错误信息，并且不会返回任何错误信息
- 继承 
  - virtual 和 override
  - 钻石继承（菱形继承）使用super会调用继承链条上的每一个合约的相关函数
- 抽象合约  接口
  - 接口与合约ABI（Application Binary Interface）等价，可以相互转换，通过 IERC721 IERC721等可以调用实现接口功能的合约
  - 接口不能包含状态变量，只能包含函数声明
  - 接口不能包含构造函数，也不能包含函数体
  - 接口不能继承其他合约，只能继承其他接口

### 2024.09.26
时间：90min  學習內容: solidity102 16~20
- overloading 重载 
- 库合约 
  - using A for B;语法糖 B.xxx()调用A函数 
  - A.xxx()
  - Strings：将uint256转换为String
  
    Address：判断某个地址是否为合约地址

    Create2：更安全的使用Create2 EVM opcode

    Arrays：跟数组相关的库合约

- import
- receive 和 fallback
- 接收ETH调用 receive，fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。一般external payable修饰
- transfer send call
- tansfer和send的区别在于，如果接收者合约没有receive函数，那么transfer会回滚交易，而send会返回一个布尔值，表示交易是否成功。
- call和send的区别在于，call可以调用合约的任何函数，而send只能发送ETH。call可以返回一个布尔值，表示交易是否成功，也可以返回一个字节数组，表示函数的返回值。
- (bool success,) = _to.call{value: amount}(""); // 使用call发送ETH, **("")为msg，如果receive()无法处理，就会调用fallback()**
  
<!-- Content_END -->
