---
timezone: America/New_York
---

---

# isparkyou

1. Friedrich Ludwig

2. Yes!
   
## Notes

<!-- Content_START -->

### 2024.09.23
### Solidity
### Remix
[Remix](https://remix.ethereum.org)
### 注释：
// SPDX-License-Identifier: MIT
### 版本：
pragma solidity ^0.8.21;
### 合约：
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
### 编译：
Ctrl + S
### 部署：
Deploy
### 2024.09.24
### value type
1. bool
```
bool public _bool = true;
```
```
// 布尔运算
bool public _bool1 = !_bool; false// 取非
bool public _bool2 = _bool && _bool1; false// 与
bool public _bool3 = _bool || _bool1; true// 或
bool public _bool4 = _bool == _bool1; false// 相等
bool public _bool5 = _bool != _bool1; true// 不相等
```
### “短路规则”
一般出现在逻辑与（&&）和逻辑或（||）中。 当逻辑与（&&）的第一个条件为false时，就不会再去判断第二个条件； 当逻辑或（||）的第一个条件为true时，就不会再去判断第二个条件，这就是短路规则。

2. int
   ```
   // 整型
int public _int = -1; // 整数，包括负数
uint public _uint = 1; // 正整数
uint256 public _number = 20220330; // 256位正整数
```
```
// 整数运算
uint256 public _number1 = _number + 1; 20220331// +，-，*，/
uint256 public _number2 = 2**2; 4// 指数
uint256 public _number3 = 7 % 2; 1// 取余数
bool public _numberbool = _number2 > _number3; true// 比大小
```
3. address
address:存储一个20字节的值
payable address：多transfer和send两个成员方法
```
// 地址
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address); // payable address，可以转账、查余额
// 地址类型的成员
uint256 public balance = _address1.balance; // balance of address
```
4. byte
定长字节数组：属于值类型，数组长度在声明之后不能改变。
不定长字节数组：属于引用类型，数组长度在声明之后可以改变。
```
// 固定长度的字节数组
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0]; 
```
5. enum
用户定义的数据类型，主要用于uint分配名称，使程序易于阅读和维护。
```
// 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
enum ActionSet { Buy, Hold, Sell }
// 创建enum变量 action
ActionSet action = ActionSet.Buy;
// enum可以和uint显式的转换
function enumToUint() external view returns(uint){
    return uint(action);
}
```

### reference type

### mapping type

### 2024.09.25
### 函数
```
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
合约中定义的函数需要明确指定可见性，它们没有默认值。
public|private|internal 也可用于修饰状态变量。
public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

public：内部和外部均可见。
private：只能从本合约内部访问，继承的合约也不能使用。
external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
internal: 只能从合约内部访问，继承的合约可以用。

#### 在以太坊中，以下语句被视为修改链上状态：
1. 写入状态变量。
2. 释放事件。
3. 创建其他合约。
4. 使用 selfdestruct.
5. 通过调用发送以太币。
6. 调用任何未标记 view 或 pure 的函数。
7. 使用低级调用（low-level calls）。
8. 使用包含某些操作码的内联汇编。

pure，pure 函数既不能读取也不能写入链上的状态变量。
view，view函数能读取但也不能写入状态变量。
非 pure 或 view 的函数既可以读取也可以写入状态变量。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract FunctionTypes{
    uint256 public number = 5;
// 默认function
function add() external{
    number = number + 1;
}
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
// view: 看客
function addView() external view returns(uint256 new_number) {
    new_number = number + 1;
}
// internal: 内部函数
function minus() internal {
    number = number - 1;
}

// 合约内的函数可以调用内部函数
function minusCall() external {
    minus();
}
// payable: 递钱，能给合约支付eth的函数
function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}
}
```

### 返回值：return和returns
returns：跟在函数名后面，用于声明返回的变量类型及变量名。
return：用于函数主体中，返回指定的变量。
```
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
```
这里uint256[3]声明了一个长度为3且类型为uint256的数组作为返回值。因为[1,2,3]会默认为uint8(3)，因此[uint256(1),2,5]中首个元素必须强转uint256来声明该数组内的元素皆为此类型。数组类型返回值默认必须用memory修饰

### 命名式返回
我们可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。
```
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```
也可以在命名式返回中用 return 来返回变量：
```
// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

### 解构式赋值
读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列。
```
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
读取部分返回值：声明要读取的返回值对应的变量，不读取的留空。在下面的代码中，我们只读取_bool，而不读取返回的_number和_array：
```
(, _bool2, ) = returnNamed();
```

### 2024.09.26


<!-- Content_END -->
