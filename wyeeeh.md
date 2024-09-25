---
timezone: America/Los_Angeles
---


# Ye

1. 自我介绍
     - 清华-南加大 Communication Data Science 25'硕士在读，链上数据分析2年经验，Dune [@wyeeeh](https://dune.com/wyeeeh)。因为对链上数据的分析离不开合约解析，希望通过共学计划掌握Solidity的基础开发知识，能更好读懂合约的function和event。

2. 你认为你会完成本次残酷学习吗？
   - 有激励就有野心，之前完成过Sixdegree Lab和BuidlerDAO发起的Dune Analytics共学计划。
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### WTF Academy Solidity 101.1 Hello Web3 (三行代码)
- IDE：[Remix IDE](https://remix.ethereum.org)
- 合约：合约是 Solidity 中的一种结构，用于定义智能合约的代码和数据。
  - 许可：如果不写许可，编译时会出现警告（warning），但程序仍可运行。
  - 注释：单行注释 `//` ，多行注释 `/* */`
  - 状态变量：状态变量是合约中声明的变量，用于存储合约的状态。
  - 函数：函数是合约中用于执行特定任务的代码块。
  - 函数修饰器：函数修饰器用于修改函数的行为。
  - 事件：事件是合约中用于记录某些特定事件的代码块。
  - 错误：错误是合约中用于记录某些特定错误信息的代码块。
- 部署：`Ctrl + S` 
  - 默认情况下，Remix 会使用 Remix 虚拟机（以前称为 JavaScript 虚拟机）来模拟以太坊链，运行智能合约，类似在浏览器里运行一条测试链。Remix 还会为你分配一些测试账户，每个账户里有 100 ETH（测试代币）
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 指定编译器版本

contract HelloWeb3 {
    string public _string = "Hello Web3!"; // 创建合约（contract），并声明合约名为 HelloWeb3，状态变量为 _string
}
```
- 测验结果
  - 75/100
  - 100/100

### 2024.09.24
#### WTF Academy Solidity 101.2 值类型

值类型：Value Type，用于存储具体的值。
- 布尔类型：`true` 和 `false`。
- 整数类型：整数类型包括有符号整数（int）和无符号整数（uint）。

- 地址类型：地址类型用于存储以太坊地址。
  - 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
  - payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账。
- 字节数组
  - 定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 bytes1, bytes8, bytes32 等类型。定长字节数组最多存储 32 bytes 数据，即bytes32。
  - 不定长字节数组: 属于引用类型（之后的章节介绍），数组长度在声明之后可以改变，包括 bytes 等。
- 枚举 enum
  - 枚举（enum）是 Solidity 中用户定义的数据类型。它主要用于为 uint 分配名称，使程序易于阅读和维护。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ValueTypes {
    // 布尔值
    bool public _bool = true; 

    // 布尔运算
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等

    // 整型
    int public _int = -1; // 整数，包括负数
    uint public _uint = 1; // 正整数
    uint256 public _number = 20220330; // 256位正整数

    // 整数运算
    uint256 public _number1 = _number + 1; 
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小

    // 地址
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address

    // 固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity"; 
    bytes1 public _byte = _byte32[0]; 

    // 枚举 enum
    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;

    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }

}

//deploy后可以在VALUETYPES找到声明的变量。
```
- 测验错题
  1. solidity中数值类型(Value Type)不包括float
  2. 下列代码的意思是
   
      ```solidity
      address payable addr;
      addr.transfer(1);
      ```

    - `address payable addr;`：声明了一个可支付的以太坊地址变量 `addr`。`payable` 关键字表示这个地址可以接收以太币（Ether）。
    -  `addr.transfer(1);`：将 1 wei（以太坊的最小单位）转账到 `addr` 地址。`transfer` 方法用于从合约中转移以太币到指定的 `payable` 地址。
    -  这段代码定义了一个可以接收以太币的地址，并向该地址转账 1 wei。
  3. bytes4类型具有8个16进制位

### 2024.09.25
#### WTF Academy Solidity 101.3 函数

<!-- Content_END -->
