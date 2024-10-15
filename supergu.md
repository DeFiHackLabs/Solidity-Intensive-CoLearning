---
timezone: Asia/Shanghai
---

# SuperGu🐧

1. 自我介绍

   大家好，我是SuperGu，進幣圈已差不多八年了，但從未認真學過Solidity，現在是時候了！

2. 你认为你会完成本次残酷学习吗？

   當然，LFG!
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### Chapter 1: HelloWeb3

- 3 basic element of a solidity file:

   1. Software license `// SPDX-License-Identifier: MIT`
   2. Compiler version `pragma solidity ^0.8.4;`
   3. Contract content `contract HelloWeb3{ ... }`

### 2024.09.24

#### Chapter 2: Value Type

- Variable types
   - Value
      1. Boolean
      2. Integers 
      3. Addresses
      4. Fixed-size byte arrays
      5. Enumeration
   - Reference
      1. String
      2. Array
      3. Struct
      4. Mapping
   - Function

- Integers
   - `int`, `uint`, `uint256` (256-bit +ve int)

- Addresses

   ```solidity
   // Address
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address (can transfer fund and check balance)
    // Members of address
    uint256 public balance = _address1.balance; // balance of address
    _address1.transfer(1); // transfer 1 wei to _address1
    ```

- Enumeration

   ```solidity
   // Let uint 0,  1,  2 represent Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // Create an enum variable called action
    ActionSet action = ActionSet.Buy;
   ```

### 2024.09.25

#### Chapter 3: Function

- Basic syntax of function: `function <function name>(<parameter types>) [internal|external|public|private] [pure|view|payable] [returns (<return types>)]`

- `[internal|external|public|private]`

   - `public`: Visible to all.

   - `private`: Can only be accessed within this contract, derived contracts cannot use it.

   - `external`: Can only be called from other contracts. But can also be called by `this.f()` inside the contract, where `f` is the function name.

   - `internal`: Can only be accessed internal and by contracts deriving from it.

- `[pure|view|payable]`

   - `pure`: can't read or write, gas free

   - `view`: can read, can't write, gas free

   - default is can read and can write

   - `payable`: can send ETH to the contract via this function

#### Chapter 4: Function

- Unnamed return

   ```solidity
   function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
      return(1, true, [uint256(1),2,5]);
   }
   ```

- Named return

   ```solidity
   function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        _number = 2;
        _bool = false; 
        _array = [uint256(3),2,1]; // Casting required otherwise default is int. Other values no need because interpreter infer from the data type of the first value
    }
   ```

- Destructuring assignments

   ```solidity
   (_number, _bool, _array) = returnNamed();
   (, _bool2, ) = returnNamed(); // dropping 2 returned values
   ```

### 2024.09.26

#### Chapter 5: Data Storage and Scope

- Data location

   - `storage`: default, stored on-chain, expensive gas
   - `memory`: temp variables used in function, cheaper gas
   - `calldata`: `memory` that can't be modified

- Only applicable to Reference variable types: `array`, `struct` and `mapping`

### 2024.09.28

| Assignment type | Value change together? | 
|---|---|
| storage = storage | Y | 
| storage = memory | N |
| memory = storage | N | 
| memory = memory | Y |

**Key principle**: same data location then pass by reference

### 2024.10.01

#### Chapter 6: Array & Struct

- Arrays
   - Bytes array
      - `bytes1[]` - dynamic array of single bytes, e.g. [0x01, 0x02, 0x03]
      - `bytes` - cheaper, dynamic array of multiple bytes, e.g. 0x0102030405
   - `memory` arrays
      - array size fixed after creation, but can be dynamic at creation
      - e.g. `uint[2] memory a = [uint(1), 2]` or `uint[] memory a = new uint[](2)`

- struct
   
   ```solidity
   struct Student{
        uint256 id;
        uint256 score; 
   }

   Student student;

   function initStudent1() external{
      Student storage _student = student; // assign a copy of student
      _student.id = 11;
      _student.score = 100;
   }

   // Method 2: Directly refer to the struct of the state variable
   function initStudent2() external{
      student.id = 1;
      student.score = 80;
   }
   // Method 3: struct constructor
   function initStudent3() external {
      student = Student(3, 90);
   }
   
   // Method 4: key value
   function initStudent4() external {
      student = Student({id: 4, score: 60});
   }
   ```

### 2024.10.02

#### Chapter 7: Mapping

```solidity
mapping(uint => address) public idToAddress;
```

- key type can't be struct, but value can be anything
- must be `storage`
- auto getter function for public variable
- no length info beceause all unused keys have 0 value

### 2024.10.03

#### Chapter 8: Initial Value

- boolean: `false`
- string: `""`
- int: `0`
- uint: `0`
- enum: first element in enumeration
- address: `0x0000000000000000000000000000000000000000` (or `address(0)`)

```solidity
delete x; // change x to default value
```

### 2024.10.04

#### Chapter 9: Constant

- Constant
   - value-typed / reference-typed variables
   - must be initialized during declaration
- Immutable
   - value-typed only
   - can be initialized during declaration or in the constructor

### 2024.10.08

#### Chapter 10: Control Flow

```solidity
if (a == 0) {
   ...
} else {
   ...
}
```

```solidity
for (uint i = 0; i < 10; i++) {
   ...
}
```

```solidity
while (i < 10) {
   ...
}
```

```solidity
do {

} while (i < 10);
```

### 2024.10.09

#### Chapter 11: Constructor & Modifier

- constructor
   ```solidity
   constructor() {
      owner = msg.sender;
   }
   ```

- modifier
   ```solidity
   modifier onlyOwner {
      require(msg.sender == owner); // check whether caller is address of owner
      _; // execute the function body
   }

   function changeOwner(address _newOwner) external onlyOwner{
      owner = _newOwner; // only owner address can run this function and change owner
   }
   ```

### 2024.10.10

#### Chapter 12: Constructor & Modifier

```solidity
contract Events {
   // define _balances mapping variable to record number of tokens held at each address
   mapping(address => uint256) public _balances;

   // define Transfer event to record transfer address, receiving address and transfer number of a transfer transaction
   event Transfer(address indexed from, address indexed to, uint256 value);

   // define _transfer function, execute transfer logic
   function _transfer(
      address from,
      address to,
      uint256 amount
   ) external {
      _balances[from] = 1000000; // give some initial tokens to transfer address
      _balances[from] -= amount; // "from" address minus the number of transfer
      _balances[to] += amount; // "to" address adds the number of transfer
      emit Transfer(from, to, amount); // trigger the event
   }
}
```

- topic (`indexed`)
   - at most 4
   - for easy queries
   - first index is hash of function name `keccak256("Transfer(addrses,address,uint256)")`
   - each index 32 bytes, hash of that variable stored if its size > 32 bytes
   - structs can't be indexed
- data
   - can store larger size
   - consume less gas than topic

#### Chapter 13: Inheritance

```Solidity
/* Inheritance tree visualized：
  God
 /  \
Adam Eve
 \  /
people
Linearized order: people --> Eve --> Adam --> God
*/
contract God {
   event Log(string message);
   function foo() public virtual {
      emit Log("God.foo called");
   }
   function bar() public virtual {
      emit Log("God.bar called");
   }
}
contract Adam is God {
   function foo() public virtual override {
      emit Log("Adam.foo called");
      God.foo();
   }
   function bar() public virtual override {
      emit Log("Adam.bar called");
      super.bar();
   }
}
contract Eve is God {
   function foo() public virtual override {
      emit Log("Eve.foo called");
      God.foo();
   }
   function bar() public virtual override {
      emit Log("Eve.bar called");
      super.bar(); // This calls Adam.bar because of L3 linearization rule
   }
}
contract people is Adam, Eve { // multiple inheritance, search from right to left
   function foo() public override(Adam, Eve) { // log Eve.foo, God.foo
      super.foo();
   }
   function bar() public override(Adam, Eve) { // log Eve.bar, Adam.bar, God.bar
      super.bar();
   }
}
```

- multiple inheritance must follows seniority, e.g. `contract people is God, Adam`

#### Chapter 14: Abstract and Interface

- Abstract
   - must contains the keyword `virtual`
   - e.g. `abstract contract A { function foo(uint a) internal virtual returns(uint); } `
- Interface
   - must contain `external`
   - e.g. `interface IERC721 {function balanceOf(address owner) external view returns (uint256 balance);}`

#### Chapter 15: Errors

- Error (cheapest gas)
   ```solidity
   error TransferNotOwner(); // custom error
   revert TransferNotOwner();
   ```
- Require
   ```solidity
   require(condition, "error message");
   ```
- Assert
   ```solidity
   assert(condition);
   ```

### 2024.10.11

#### Chapter 16: Overloading

- Same function name but different input parameters
- Can't overload modifier
- Achievable because selector becomes different

#### Chapter 17: Library

- Method 1
   ```solidity
   using Strings for uint256;
   _number.toHexString(); // automatically becomes Strings.toHexString(_number);
   ```

- Method 2
   ```solidity
   Strings.toHexString(_number);
   ```

### 2024.10.12

#### Chapter 18: Import

- 4 types of import
   ```solidity
   // 通过文件相对位置import
   import './Yeye.sol';
   // 通过`全局符号`导入特定的contract/function/struct
   import {Yeye} from './Yeye.sol';
   // 通过网址引用
   import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
   // 引用OpenZeppelin合约
   import '@openzeppelin/contracts/access/Ownable.sol';
   ```

- usage
   ```solidity
   using Address for address;
   Yeye yeye = new Yeye();
   ```

#### Chapter 19: Receive and Fallback

- Receive: `receive() external payable { ... }`
- Fallback: `fallback() external payable { ... }`
- Receive VS Fallback
   ```
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
- Can't send ETH to a contract if it doesn't have `receive()` or `payable fallback()`

### 2024.10.14

#### Chapter 20: Transfer, Send and Call

- `transfer`
   - `receiver.transfer(ETHamount);`
   - Gas limit 2300, target contract `fallback()` or `receive()` can't be too complicated
   - revert if failed
- `send`
   - `bool success = receiver.send(ETHamount);`
   - Gas limit 2300, target contract `fallback()` or `receive()` can't be too complicated
   - Won't revert if failed
- `call` (recommended)
   - `(bool success, bytes memory returndata) = receiver.call{value: ETHamount}("functionSelector")`
   - No gas limit, support complicated `fallback()` or `receive()`
   - Won't revert if failed


```solidity
contract ReceiveETH {
   // 收到eth事件，记录amount和gas
   event Log(uint amount, uint gas);
   
   // receive方法，接收eth时被触发
   receive() external payable{
      emit Log(msg.value, gasleft());
   }
   
   // 返回合约ETH余额
   function getBalance() view public returns(uint) {
      return address(this).balance;
   }
}

contract SendETH {
   // 构造函数，payable使得部署的时候可以转eth进去
   constructor() payable{}
   // receive方法，接收eth时被触发
   receive() external payable{}

    // Method 1: transfer
   function transferETH(address payable _to, uint256 amount) external payable{
      _to.transfer(amount);
   }

   // Method 2: send
   error SendFailed();
   function sendETH(address payable _to, uint256 amount) external payable{
      // 处理下send的返回值，如果失败，revert交易并发送error
      bool success = _to.send(amount);
      if(!success){
         revert SendFailed();
      }
   }

   // Method 3: call
   error CallFailed();
   function callETH(address payable _to, uint256 amount) external payable{
      // 处理下call的返回值，如果失败，revert交易并发送error
      (bool success,) = _to.call{value: amount}("");
      if(!success){
         revert CallFailed();
      }
   }

}

```

<!-- Content_END -->
