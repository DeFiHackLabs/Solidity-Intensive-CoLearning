---
timezone: Asia/Shanghai
---

# Azleal

1. 自我介绍
> 全栈开发，重新复习一下solidity

2. 你认为你会完成本次残酷学习吗？
> 可以
   
## Notes

<!-- Content_START -->
### 2024.09.23
1. remix的使用

2. 变量类型
   - 值类型: 赋值时候直接传递数值
   - 引用类型: 包括数组和结构体，这类变量占空间大，赋值时候直接传递地址
   - 映射类型: Mapping
  
### 2024.09.24
1. 函数的基本形式
   `function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [virtual|override] [<modifiers>] [returns (<return types>)]{ <function body> }`
2. 数据存储的位置
   - calldata: 存在内存中，不可变，多用于参数传递
   - memory: 存在内存中，当返回结果为变长类型时必须使用memory
   - storage: 存在链上。
消耗gas的多少如下: calldata < memory < storage

一些节省gas的tips: 函数体内将storage遍历转化为memory变量，能够在后续使用的过程中有效降低gas。

### 2024.09.25
数组是一种引用类型，所以必须在声明定义时，加上三个数据位置（data location）关键字之一： `storage` , `memory` , `calldata` 
1. 静态数组
```
uint[3] memory memArray;
uint[3] storage storageArray;
```
静态数组的大小必须在编译时确定，即不能使用变量来指定数组的大小。如`uint size=2; uint[size][size] memory array;` 这种写法是错误的。

2. 动态数组
```
uint n = 2;
uint[] memory memArray = new uint[](n);
// 仅storage才可以使用下面的方式初始化
uint[] storage storageArray = [uint(1), 2];;
```
### 2024.09.26
1. `mapping`
   - 声明映射的格式为`mapping(_KeyType => _ValueType)`.其中`_KeyType`只能为solidity的内置类型，`_ValueType`可以使用内置类型及自定义的类型(`struct`).
   - `mapping`布局, keccak256(abi.encodePacked(key, slot)).映射元素槽索引是通过keccak256我们想要的元素的键（左侧填充 0 到 32 字节）和映射的声明槽索引的串联哈希来计算的.
2. 变量初始值
```solidity
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000
enum ActionSet { Buy, Hold, Sell}
ActionSet public _enum; // 第1个内容Buy的索引0
function fi() internal{} // internal空白函数
function fe() external{} // external空白函数 
```

### 2024.09.27
1. `constant`,`immutable`变量
   - 基础类型可以定义为`constant`, `immutable`. `string`类型不能被定义为`immutable`
   - `constant`变量必须在声明的时候初始化，之后再也不能改变。
   - `immutable`变量可以在声明时或构造函数中初始化。
2. 控制流
   - `if-else`
   - `for`循环
   - `while`循环
   - `do-while`循环
   - `三元运算`: `条件` ? `条件为真的表达式` : `条件为假的表达式`

### 2024.09.28
1. `constructor`
   - `0.4.22`之前的版本构造函数是合约的同名方法。之后是由`constructor`定义的构造函数
   - 继承了父合约的自合约构造函数的定义
   ```solidity
      // SPDX-License-Identifier: MIT
      pragma solidity ^0.8.0;
      
      contract Parent {
          uint256 childId;
          constructor(uint256 _childId) {
              childId = _childId;
          }
      }
      
      contract Child1 is Parent(1) {
      }
      
      
      contract Child2 is Parent {
          constructor() Parent(2){}
      }
   ```
   - 父合约的构造函数没有参数时可省略。
2. 修饰器(`modifier`)
   - 作用：声明函数拥有的特性，并减少代码冗余
   - 示例`onlyOwner`，仅允许合约的`owner`调用
   ```solidity
      // SPDX-License-Identifier: MIT
      pragma solidity ^0.8.0;
      
      contract MyContract {
          address owner;
      
          // onlyOwner的定义
          modifier onlyOwner(){
              require(owner == msg.sender, "only owner is allowed");
              _;
          }
      
          constructor(){
              owner = msg.sender;
          }
      
          // onlyOwner的用法
          function withdraw() public onlyOwner{
              payable(owner).transfer(address(this).balance);
          }
   
          receive() external payable { }
      }

   ```
3. 事件(`event`)
   - 作用：链下应用的响应，即可以通过节点的rpc监听事件；比链上存储更经济的存储方式。
   - 声明：`event Transfer(address indexed from, address indexed to, uint256 value);`
   - 释放：`emit Transfer(from, to, amount);`
   - 组成部分：
      - topics:
         - 第一部分是事件的签名
         - 之后的部分(如果存在)，对应事件中定义的`indexed`变量的值，注意最多有3个`indexed`变量。
      - data: 其余的非`indexed`变量的值。
        

### 2024.09.29
1. 继承
  - 规则:
     - 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字
     - 子合约重写了父合约中的函数，需要加上`override`关键字。`override`可以修饰函数或者变量。
  - 多重继承:
     - 顺序: 辈分越高越在前
       ```
       contract Erzi is Yeye, Baba{
          // 继承两个function: hip()和pop()，输出值为Erzi。
          function hip() public virtual override(Yeye, Baba){
              emit Log("Erzi");
          }
      
          function pop() public virtual override(Yeye, Baba) {
              emit Log("Erzi");
          }
       }
       ```
    - `modifier`也可以被继承，需要继承的`modifier`在父类中用`virtual`标识，在子类中用`override`标识
    - 钻石继承`super`的调用顺序


2. 抽象合约和接口
   - 抽象合约：合约用`abstract`标识，其中至少有一个`abstract`方法
   - 接口：
      - 不能包含状态变量
      - 不能包含构造函数
      - 不能继承除接口外的其他合约
      - 所有函数都必须是external且不能有函数体
      - 继承接口的非抽象合约必须实现接口定义的所有功能

3. 异常
   - `error`: 方便且高效（省gas）地向用户解释操作失败的原因.
      - 定义：`error TransferNotOwner(address sender); // 自定义的带参数的error`
      - 使用：`revert TransferNotOwner(msg.sender);`
  
   - `require`: 好用，缺点是gas随着描述异常的字符串长度增加，比error命令要高。
     - 用法：`require(_owners[tokenId] == msg.sender, "Transfer Not Owner");`
   - `assert`: 通常用于合约的执行结果的检查，确认结果是符合预期的。用法很简单，但不能解释抛出异常的原因
      - 用法：`assert(_success);`

### 2024.09.30
1. 函数重载
> solidity允许函数重载，即函数名称相同但参数类型不同的函数可以同时存在，他们被视为不同的函数。但不允许`modifier`重载。
>
> ```
> function saySomething() public pure returns(string memory){
>     return("Nothing");
> }
>
> function saySomething(string memory something) public pure returns(string memory){
>     return(something);
> }
> ```
> 由于方法签名不同，经过编译之后，它们都成为了不同的函数选择器(`selector`).
- 实参匹配：如果调用重载方法时，实际参数可以匹配到多个重载函数，此时会报错。即必须保证参数类型只能匹配到一个函数。
2. 库合约
  - 特点：
     - 不能存在状态变量
     - 不能够继承或被继承
     - 不能接收以太币
     - 不可以被销毁
  - 使用：
     - `using for`: `using Strings for uint256;`
     - `Strings.toHexString(_number);`

### 2024.10.01
1. `import`:
   - 通过网址引用: `import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';`
   - 通过npm导入: `import '@openzeppelin/contracts/access/Ownable.sol';`
   - 通过全局符号导入: `import {Yeye} from './Yeye.sol';`
2. `receive()`
   - 声明: 与普通方法不同，不使用`function`关键字: `receive() external payable { }`
   - `receive()`函数不能有任何的参数，不能返回任何值，必须包含external和payable.
   - 如果调用方通过`send`, `transfer`来向目标合约转移eth, 那么gas将限制在2300以内，因此如果`receive`的逻辑太复杂会出现`out of gas`异常
   - 通过`call`来转移eth, 则可以指定gas

3. `fallback`
   - 声明: `fallback() external payable { }`
   - 当合约被调用不存在的函数时会被触发。
4. 二者关系
```
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()

```

### 2024.10.02

1. 发送ETH
 - `transfer`发送eth:
    - `recipient.transfer(amount)` 表示当前合约向`recipient`发送`amount`数量的eth。
    - gas限制为2300，即`recipient`不能有太复杂的`receive`或者`fallback`逻辑。
    - `trasnfer`失败时，交易**会**`revert`
 - `send`发送eth:
    - `recipient.send(amount)` 表示当前合约向`recipient`发送`amount`数量的eth。
    - gas限制为2300，即`recipient`不能有太复杂的`receive`或者`fallback`逻辑。
    - `send`失败时，交易**不会**`revert`。需要判断`send`的`bool`返回值。
 - `call`发送eth:
    - `recipient.call{value: amount, gas: gas_amount}("")` 表示当前合约使用`gas_amount`的gas向`recipient`发送`amount`数量的eth。
    - 无gas限制，且可以自定义gas,`gas`可省略。在提供足够gas的前提下，`recipient`可以有任意复杂的`receive`或者`fallback`逻辑。
    - `call`失败时，交易**不会**`revert`。需要判断`call`的返回值(bool, bytes).

`call`的调用最为灵活，因此推荐在合约转账时使用`call`进行eth发送

### 2024.10.03

1. 合约调用
   - 合约地址调用: `OtherContract(_Address).setX(x);`
   - 合约变量调用: `OtherContract oc = OtherContract(_Address);  x = oc.getX();`
   - 调用时发送ETH: `OtherContract(otherContract).setX{value: msg.value}(x);`

### 2024.10.04

1. `call`
   - `call`是`address`的低级成员函数，用来与其他合约交互，返回值为`(bool, bytes)`分别对应`call`是否成功以及返回值。
   - `call`是Solidity官方推荐的通过触发`fallback`或`receive`函数发送ETH的方法。
   - 不推荐用`call`来调用另一个合约，因为当你调用**不安全**合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数。
   - 当我们不知道对方合约的源代码或`ABI`，就没法生成合约变量；这时，我们仍可以通过`call`调用对方合约的函数。
   - 用法：`目标合约地址.call(字节码);`,其中字节码利用结构化编码函数abi.encodeWithSignature获得。如：abi.encodeWithSignature("f(uint256,address)", _x, _addr)。
   - `call`的同时发送ETH以及指定gas: `目标合约地址.call{value:发送数额, gas:gas数额}(字节码);`

2. `delegatecall`
   - `delegatecall`是`address`的低级成员函数。
   - 用法：`目标合约地址.delegatecall(二进制编码);`
   - 使用场景：代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过`delegatecall`执行。当升级时，只需要将代理合约指向新的逻辑合约即可。

<!-- Content_END -->
