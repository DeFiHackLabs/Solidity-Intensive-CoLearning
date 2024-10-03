---
timezone: Asia/Shanghai
---

# LikKee

1. 自我介绍

   > 2021 接触 Solidity，从合约到全端完成了 3 个 NFT 项目，ex-Tech lead 链游

2. 你认为你会完成本次残酷学习吗？
   > 必须的

## Notes

<!-- Content_START -->

### 2024.09.23

#### Chapter 1: Introduction

- `Solidity` is a programming language for Smart Contract development on EVM (Ethereum Virtual Machine).
- `Remix` is a browser-based IDE (Integrated Development Environment) for Solidity development, it have file management, compiler, deployment, interaction and various plugins available.
- A Solidity Smart Contract consists of 3 parts: License type, Solidity version and contract logics.

#### Chapter 2: Variables

- 3 types of Variable: Value, Reference and Mapping

- Value types:
  - `bool` Boolean
  - `uint` Unsigned integer
  - `int` Signed integer
  - `address` Address
  - `bytes` Variable-length bytes arrays
  - `byte` Fixed-length byt arrays
  - `enum` Enumeration

#### Chapter 3: Function

Format of a function

`function <function name>(<parameter types>) [public|private|external|internal] [pure|view|payable] [returns (<return types>)]`

- Function visibility specifiers

  - `public`: Accessible to all
  - `private`: Can only be called within this contract
  - `internal`: Can be called within this contract and contracts deriving from it
  - `external`: Can only be called by external

- Function behavior specifiers
  - `pure`: Cannot read or write state
  - `view`: Read only, doesn't change state
  - `payable`: Allow this function to receive native currency

#### Chapter 4: Function output

```
function testReturn() public pure returns (uint256) {
  return 1;
}
```

- `returns`: to indicate how many and what type of variable for output
- `return`: to output the desired value, and must matched to the `returns` requirements
- **Named returns**: Naming the output variables, eg:
  ```
  function testReturn() public pure returns (uint256 one, uint256 two) {
   one = 1;
   two = 2;
  }
  ```
- To **READ** variables return from function
  ```
  (uint256 one, uint256 two) = testReturn();
  ```
  or
  ```
  (, uint256 two) = testReturn();
  ```

### 2024.09.24

#### Chapter 5: Data Storage and Scope

- Data storage location:

  - `storage`: All state variables are `storage` by default, which are stored on-chain and consumes a lot of `gas`

    - `storage` can use to create as reference to a local variable, eg:

    ```
    uint256[] public x = [1,2,3]; // State variable

    functiuon refStorage() public {
      uint256[] storage ref = x;
      ref[0] = 0; // x's value resulted as: [0,2,3]
    }
    ```

  - `memory`: Variables temporarily stored in memory, for computation, consumes less `gas`

    - `memory` will create an in-memory reference that doesn't affect storage, eg:

    ```
    uint256[] public x = [1,2,3]; // State variable

    functiuon refStorage() public view {
      uint256[] memory ref = x;
      ref[0] = 0; // x's value remain unchanged: [1,2,3]
    }
    ```

  - `calldata`: Variables stored in memory but cannot be modified, generally used for function parameters.

- Variable scope
  - State variables: Delcared inside contract and outside the function
  ```
  contract Variables {
   uint256 public x = 1;
  }
  ```
  - Local variables: Variables inside the function, only valid during function execution
  ```
  function local() public pure {
   uint256 x = 1;
  }
  ```
  - Global variables: Reserved keywords in Solidity
    - `msg.sender`: Transaction sender
    - `block.number`: Current block height
    - `msg.data`: Transaction calldata
    - `blockhash(uint blockNumber)`: Hash of given block
    - `block.coinbase`: The address of current block miner
    - `block.gaslimit`: The gas limit of current block
    - `block.number`: Current block number
    - `block.timestamp`: The timestamp of current block
    - `gasleft()`: Remaining gas
    - `msg.sig`: First four bytes of calldata, i.e: function identifier
    - `msg.value`: Amount of `wei` in the transaction

#### Chapter 6: Array & Struct

- Reference type variables:

  - `array`

  ```
  uint256[] public x = [1,2,3];
  ```

  - `struct`

  ```
  struct Book {
     uint256 id;
     string title;
  }
  ```

  - `mapping`

- Array
  - Fixed-size arrays: Length of array specified during declaration
    `uint256[3] public x = [1,2,3];`
  - Variable-length array: Length of array is not specified during declaration
  ```
  uint256[] public x;
  bytes public b;
  ```
- Rules for creating arrays
  - For `memory` array, it must created with `new` operator, the length fixed during creatioin and cannot be changed:
  ```
  uint256[] memory x = new uint256[](3);
  ```
  - The type of first element in the array literal can be declared, otherwise the smallest storage type is used by default
  ```
  [uint(1), 2, 3]
  [1,2,3] // Default use uint8
  ```
  - Value of array assign one by one
  ```
  x[0] = 1;
  ...
  x[2]
  ```
- Features

  - `length`
  - `push()`: add `0` at the end of the array
  - `push(x)`: add `x` element at the end of the array
  - `pop()`: Remove the last element from the array

- Struct
  - Elements of `struct` can be primitive types or references types
  - `struct` can be the element for array and `mapping`
  - Ways to assign values to `struct`:
    - Method 1: Create a storage struct reference in the function
    ```
    function setBook() external {
      Book storage _book = book;
      _book.id = 1;
      _book.title = "Solidity Ascademy";
    }
    ```
    - Method 2: Directly refer to struct of state variable
    ```
    function setBook() external {
      book.id = 1;
      book.title = "Solidity Academy";
    }
    ```
    - Method 3: `struct` constructor
    ```
    function setBook() external {
      book = Book(1, "Solidity Academy");
    }
    ```
    - Method 4: Key value
    ```
    function setBook() external {
      book = Book({id: 1, title: "Solidity Academy"});
    }
    ```

#### Chapter 7: Mapping

- Mapping
  ```
  mapping(_KeyType => _ValueType)
  mapping(address => uint256) public balances; // Store balances of addresses
  ```
  - Rules of creating `mapping`
    - Rule 1: `_keyType` cannot be a custom `struct`, `_ValueType` can
    - Rule 2: Must be stored in `storage`, but it can't be used as variable in function or as return result
    - Rule 3: `mappi ng` declared as `public` will have a `getter` to query the value with key
    - Rule 4: Adding a key-value pair to a mapping is `var[newKey] = value`
  - Principle of `mapping`
    - Doesn't store `Key` or length information
    - Use `keccak256(abi.encodePacked(key, slot))` as offset to access value, where `slot` is the slot location where the mapping variable is defined
    - EVM define all unused space as `0`, the key of unassigned value will be `0`

### 2024.09.25

#### Chapter 8: Default Value

- Variables declared but not assigned have their default value:
  - `boolean`: `false`
  - `string`: `""`
  - `int`: `0`
  - `uint`: `0`
  - `enum`: first element in enumeration
  - `address`: `0x0000000000000000000000000000000000000000` Zero address
  - Dynamic array: `[]`
  - Fixed-sized array `uint256[3]`: `[0,0,0]`
- `delete` operator
  - Reset the variable to default value

#### Chapter 9: Constant and Immutable

- `constant` variable
  - Value must be initialized during declaration and cannot be changed afterwards
  ```
  uint256 constant QUANTITY = 10000;
  ```
- `immutable` variable

  - Value can be initialized during declaration or in the constructor

  ```
  uint256 public immutable QUANTITY = 10000;
  ```

  - It can be initialized with global variable or function too

  ```
  constructor() {
   QUANTITY = block.number;
   QUANTITY = initQty();
  }

  function initQty() public pure returns (uint256 qty) {
   qty = 1000;
  }
  ```

#### Chapter 10: Control Flow

- `if else`

```
function test() public pure returns (bool) {
  if (block.timestamp > block.number) {
    return true;
  } else {
    return false;
  }
}
```

- `for` loop

```
function test() public pure returns (uint256) {
  uint256 num = 0;
  for(uint256 i; i < 10; i++) {
    num += i;
  }
  return num;
}
```

- `while` loop
  function test() public pure returns (uint256) {
  uint256 num = 0;
  while(num < 10) {
  num += 1;
  }
  return num;
  }
- `do while` loop

```
function test() public pure returns (uint256) {
  uint256 num = 0;
  do {
    num += 1;
  } while(i < 10);
  return num;
}
```

- Conditional operator

```
function test() public pure returns (uint256) {
  return block.timestamp >= block.number ? 1 : 0;
}
```

- `continue`: enter next loop
- `break`: break out from current loop

### 2024.09.26

#### Chapter 11: Constructor & Modifier

- `constructor`

  - A special function, automatically run once during contract deployment.
  - Usually use to initialize parameters of a contract

  ```
  address owner;

  constructor() {
   owner = msg.sender;
  }
  ```

  - **Notes**: Solidity before `0.4.22`, the `constructor` keyword are the name as the contract name.

- `modifier`

  - Used to declare dedicated propoerties of functions and reduce code redundancy
  - A `modifier` to restrict the function can only be called by owner:

  ```
  modifier onlyOwner {
   require(msg.sender == owner);
   _;
  }

  function changeOwner(address _newOwner) external onlyOwner {
   owner = _newOwner;
  }
  ```

### 2024.09.27

#### Chapter 12: Events

- `event`
  - Transaction logs stored by EVM
  ```
  event Transfer(address indexed from, address indexed to, uint256 amount);
  ```
  - Characteristics:
    - Responsive: Applications can subscribe and listen to events through `RPC` and take action accordingly
    - Economical: Store data in events is cheap (2,000 gas) each, store a new variable on-chain cost 20,000 gas
  - `indexed` keyword marked to be stored at a special data structure known as `topics` and can easily queried by application
  - Non-indexed parameters will be stored in the data section of the log, can be larger size and more complex data structures
  - How to `emit` events
  ```
  function transfer(address _from, address _to, uint256 _amount) external {
   ...
   emit Transfer(_from, _to, _amount);
  }
  ```
  - Topics
    - Used to describe events
    - Each event contains a maximum of 4 `topics`
    - The first topic is the event hash, calculated as follows:
    ```
    keccak256("Transfer(address,address,uint256)")
    // 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
    ```

### 2024.09.28

#### Chapter 13: Inheritance

- Rules

  - `virtual`: Added if the functions of parent contract are expected/required to be overridden by children contract
  - `override`: Added if the function of children contract wanted to override parent's function
  - `virtual override`: Added if the function is overriding it parent's function and expect to be overriden by child contract
  - `public` variable with `override` will also override it's `getter` function

  ```
  mapping(address => uint256) public override balanceOf;
  ```

**Simple inheritance**

```
contract Bird {
  event Log(string action);

  function fly() public virtual {
    emit Log("Fly");
  }

  function bird() public virtual {
    emit Log("Bird");
  }
}

contract Rooster is Bird {
  function fly() public virtual override {
    emit Log("Jump");
  }

  function attack() public virtual {
    emit Log("Attack");
  }
}
```

- `Bird` contract have 2 functions, `fly` and `bird` and 1 event `Log`
- Although `Rooster` only have 2 function written `fly` and `attack`, due to inherit of `Bird`, `Rooster` have also `bird` function, and override the `fly` function which logging `"Jump"`.

**Multiple inheritance**

- Rules:
  - Parent contract should be ordered by seniority, eg: `contract Chick is Bird, Rooster`
  - If a function existed in multiple parent contracts, child contract required to override it too
  ```
  function fly() public virtual override(Bird, Rooster) // Chick contract
  ```

**Inheritance of modifiers**

```
contract Bird {
  modifier onlyOwner() virtual {
    require(msg.sender == owner);
    _;
  }
  ...
}

contract Rooster is Bird{
  function feed() public onlyOwner() pure {
    ...
  }
}
```

- `Rooster` can use `onlyOwner` modifier because it inherit of `Bird`

```
modifier onlyOwner() override {
 require(msg.sender != owner);
 _;
}
```

- `Rooster` override the `onlyOwner` modifier

**Inheritance of constructors**

```
abstract contract Bird {
  uint256 public height;

  constructor(uint256 _height) {
    height = _height;
  }
}
```

- Child contract to inherit the `constructor` of parent contract

```
contract Rooster is Bird {
  constructor(uint256 \_height) Bird(\_height){}
}
```

**Calling parent's function**

- Direct calling

```
function attack() public virtual {
  Bird.fly();
}
```

- With `super` keyword

```
function attack() public virtual {
  super.fly();
}
```

- Using `super` will call the nearest inheritance function. If `super.fly()` call in `Chick` contract, due to the nature of order, it will call `Rooster`'s `fly` function but not `Bird`

**Diamond inheritance**

- A contract inheriting two or more parent contracts
- Using `super` keyword on diamond inheritance chain, it will call the relevant function of each contract in the inheritance chain, not just nearest parent contract

```
/*
     Bird
     /  \
Rooster Hen
     \  /
     Chick
*/

contract Bird {
  event Log(string action);

  function fly() public virtual {
    emit Log("Bird is flying");
  }
}

contract Rooster is Bird {
  function fly() public virtual override {
    emit Log("Rooster is flying");
  }
}

contract Hen is Bird {
  function fly() public virtual override {
    emit Log("Hen is flying");
  }
}

contract Chick is Rooster, Hen {
  function fly() public virtual override {
    super.fly();
  }
}
```

- Calling the `fly` function in `Chick` will also trigger `Hen`, `Rooster` and `Bird`'s `fly()`

### 2024.09.29

#### Chapter 14: Abstract and Interface

- Abstract Contract

  - A special contract where it contain at least one unimplemented function, and the function must labeled with `virtual`

  ```
  abstract contract SomeIdea {
   function someFeature(bytes calldata _data) public pure virtual returns (bool);
  }
  ```

- Interface Contract

  - Rules:
    - Cannot contain state variables
    - Cannot contain constructor
    - Cannot inherit non-interface contracts
    - All functions must be external and no content within it
    - Contracts that inherit it must have all functions implemented
  - Why implement interface?
    - It provide `bytes4` selector for each function in the contract, and the function signatures (function `name` and `parameters`)
    - It provide interface id
  - Equivalent to contract `ABI` (Application Binary Interface), can be converted to each other

  ```
  interface IERC20 {
   event Transfer(address indexed from, address indexed to, uint256 amount);

   function balanceOf(address who) external view return (uint256);
  }
  ```

  - Implementing `interface` can let contract interact with it without knowing it detail

  ```
  contract Staking {
    IERC20 someToken = IERC20(0x1234....1234);
    ...
    function checkBalanceBeforeStake(uint256 _address) external {
      if(someToken.balanceOf(_address) < minimumStake) {
        // do something
      }
    }
  }
  ```

#### Chapter 15: Errors

- `error` & `revert`

  - New feature introduce in Solidity `0.8`
  - Recommended way to throw error

  ```
  error InsufficientBalance(address who);

  function checkBalance(address _who) external {
    if(balanceOf(_who) == 0) revert InsufficientBalance(_who);
  }
  ```

- `require`

  - Error handling prior to Solidity `0.8`
  - Cost higher gas

  ```
  function checkBalance(address _who) external {
    require(balanceOf(_who) == 0, "InsufficientBalance");
  }
  ```

- `assert`
  - Conditional statement, usually used for debugging purpose as it doesn't return error
  ```
  function checkBalance(address _who) external {
    assert(balanceOf(_who) > 0);
  }
  ```

End of WTF Solidity 101

### 2024.09.30

#### Chapter 16: Function overloading

Solidity allow function overloading, same function name but different parameters

```
function input(uint256 _number) external {
  ...
}

function input(string memory _str) external {
  ...
}
```

Although both function share the same name, but due to different parameters, the functions will have different function signature/selector.

**_Notes_**: `modifier` cannot be overloading like function

**Argument matching**

```
function input(uint256 _number) external {
  ...
}

function input(uint32 _number) external {

}
```

The contract is able to compile, but when call data meet both function's parameter, for example: `50`, error prompted.

#### Chapter 17: Library Contract

`library` use to reduce code redundancy and gas usage.

The different:

- Cannot contain state variable
- Cannot inherit other contract or to inherit by other contract
- Cannot receive native currency, eg: ETH
- Cannot be destroy

- `public` and `private` functions in the library contract will trigger `delegatecall` when calling
- `internal` functions won't trigger
- `private` functions able to call by other functions within library contract

Some commonly used library:

- [String](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol)
- [Address](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol)
- [Arrays](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Arrays.sol)

Usage

```
contract Lending {
  using Strings for uint256; // using A for B;

  function convert(uint256 _number) public pure returns (string memory) {
    return _number.toHexString();
  }
}
```

or

```
contract Lending {
  function convert(uint256 _number) public pure returns (string memory) {
    return Strings.toHexString(_number); // call directly
  }
}
```

#### Chapter 18: Import

`import` allow contract to refer content of another contracts, maximize reusability and contract security

How to:

```
File
├── Other.sol
└── MyContract.sol

/* ------------------ */
import './Other.sol';

contract MyContract {
  ...
}
```

or (Source URL)

```
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
```

or (`npm`)

```
import '@openzeppelin/contracts/access/Ownable.sol';
```

or (Directive import)

```
import {Other} from './Other.sol';
```

### 2024.10.01

#### Chapter 19: Receive & Fallback

Solidity have two special function, `receive()` and `fallback()`, can be used to:

- Receive native currency like ETH
- Fallback call from undefined function calling
- `receive()` introduced after `0.6.x`

`receive()`

- Called when contract receive `ETH` directly via transfer, etc
- Each contract can have maximum 1 `receive()` function

```
receive() external payable {
  // do something
}
```

- `receive()` doesn't need to include `function` keyword, must not contain `parameters` and return values
- `receive()` not recommend to have complex logic, the default spendable gas for transfer/send ETH usually limit to `2300` only, complex computation in `receive()` might cause `Out of Gas` error.

```
event Received(address sender, uint256 amount);

receive() external payable {
  emit Received(msg.sender, msg.value);
}
```

- `event` can be added into `receive()` function

`fallback()`

- Trigger when undefined function called, can also use to receive `ETH`

```
event FallbackTriggered(address sender, uint256 amount, bytes data);

fallback() external payable {
  emit FallbackTriggered(msg.sender, msg.value, msg.data);
}
```

- `fallback()` doesn't need to include `function` keyword, must have visibility of `external`

How it works

```
fallback() or receive()?
        Receive ETH
              |
       msg.data empty？
            /  \
          Yes   No
          /      \
receive() exist?  fallback()
        / \
      Yes  No
      /     \
receive()   fallback()
```

- Contract without `receive()` or `payable fallback()` will not able to received `ETH`, transfer transaction will executed but failed

#### Chapter 20: Transfer ETH

There are 3 way to transfer `ETH` in contract

- `call()` <- Recommended
  - No gas limit
  - Transaction will still executed even failed to call
  - Have return values of `(bool, bytes memory)` which `bool` indicate calling failed or successful, `bytes` is data return
- `transfer()`
  - Gas limit `2300`, if recipient is contract and it's `fallback()` or `receive()` is complex, transfer will fail
  - Transaction will revert if transfer failed
- `send()`
  - Gas limit `2300`, if recipient is contract and it's `fallback()` or `receive()` is complex, send will fail
  - Transaction will still executed even failed to send, can capture with return `bool` value

```
function callTx(address payable _to) external payable {
  (bool success, ) = _to.call{value: msg.value}("");
  if(!success) {
    revert CallFailed();
  }
}

function transferETH(address payable _to) external payable {
  _to.transfer(msg.value);
}

function sendETH(address payable _to) external payable {
  bool success = _to.send(msg.value);
  if(!success) {
    revert SendFailed();
  }
}
```

### 2024.10.02

#### Chapter 21: Call to Other Contract

In Solidity, one contract able to call another contract deployed or contract going to deploy where contract address to update later once deployed.

```
contract Target {
  function echo() external pure returns (bool) {
    return true;
  }

  function deposit() external payable {
    ...
  }
}

contract Source {
  function callToAddress(address _target) external view returns (bool) {
    return Target(_target).echo();
  }

  function callToContract(Target _target) external view returns (bool) {
    return _target.echo();
  }

  function callToVariable(address _target) external view returns (bool) {
    Target target = Target(_target);
    return target.echo();
  }

  function callToPayable(address _target) external payable {
    Target(_target).deposit{value: msg.value}("");
  }
}
```

#### Chapter 22: Call

`call` is low level function of `address` variable. This function will return `(bool, bytes memory)`, which `bool` indicate calling failed or successful, `bytes` is data return.

- `call` is recommended way to trigger `fallback` or `receive` when transferring `ETH`
- However `call` is not recommended to use for calling another contract, especially to an unknown/malicious contract
-

```
bytes someBytes = abi.encodeWithSignature("functionName(params, ...)", params, ...);

someContract.call(someBytes); // Call without value (ETH)
someContract.call{value: wei, gas: wei}(someBytes); // value and gas are optional

// Call function with 1 ETH and capture return values
(bool success, bytes memory data) = someContract.call{value: 1 ether}(
  abi.encodeWithSignature("someFunction(uint256)", 100)
);
```

- `call` will go to `fallback` if the function calling does not exist.

#### Chapter 23: Delegatecall

`delegatecall` is also a low level function of `address` variable.

- delegate call able to forward the context of origin to another contract, eg

```
// call
Address A -call-> Contract B -call-> Contract C
===============================================
                context=B            context=C
                msg.sender=A         msg.sender=B
                msg.value=A          msg.value=B

// delegatecall
Address A -call-> Contract B -delegatecall-> Contract C
=======================================================
                context=B                    context=B
                msg.sender=A                 msg.sender=A
                msg.value=A                  msg.value=A


// Example
(bool success, bytes memory data) = someContract.delegatecall(
  abi.encodeWithSignature("someFunction(uint256)", 100)
);
```

- Can specific `gas` but not `value`

- When to use:
  - Proxy contract: Which usually separate into State Contract and Logic Contract. All the functions of Logic Contract can call to State Contract through `delegatecall`. Thus Logic Contract can be update/replace when needed.
  - [EIP-2535](https://eips.ethereum.org/EIPS/eip-2535): Also known as Diamonds, Multi-Facet Proxy. The smart contract is modular that can be extended after deployment.

### 2024.10.03

#### Chapter 24: Contract Factory

In Solidity, both EOA and Contract can also create/deploy new Contract. The most popular contract factory is Uniswap's `PairFactory`, which create a smart contract contain two tokens, eg: `USDT/PEPE`.

- There are two ways to create new contract from a contract:
  - CREATE
  ```
  Contract x = new Contract{value: _value}(params);
  // Contract: Name of new contract
  // x: New contract variable
  // value: To transfer ETH into new contract if new contract's constructor is payable
  // params: Parameters of new contract's constructor
  ```
  - CREATE2

How address calculated by CREATE

```
new_contract_address = hash(creator_address, nonce);
// creator_address can be EOA or contract
```

- `nonce` after the transaction count of EOA, or contract created count for contract, increase by 1 every tx/contract made
- The address of new contract is hard to predict as nonce might change often

#### Chapter 25: CREATE2

How address calculated by CREATE2:

```
new_contract_address = hash("0xFF", creator_address, salt, initcode);
// 0xFF: A constant to differentiate from CREATE
// creator_address: The address of contract called CREATE2
// salt: A bytes32 variable prefix by creator
// initcode: New contract byte code with the constructor arguments and logic included
```

How to use:

```
Contract x = new Contract{salt: _salt, value: _value}(params);
```

Example WITH constructor parameters:

```
bytes32 salt = heccak256(abi.encodePacked(params...));

NewContract nc = new NewContract{salt: salt}();

address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        bytes1(0xff),
        address(this),
        salt,
        keccak256(type(NewContract).creationCode)
        )))));
```

Example WITH constructor parameters:

```
bytes32 salt = heccak256(abi.encodePacked(params...));

NewContract nc = new NewContract{salt: salt}(constructorParams...);

address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        bytes1(0xff),
        address(this),
        salt,
        keccak256(abi.encodePacked(type(NewContract).creationCode, abi.encode(constructorParams...)))
        )))));
```

### 2024.10.04

### 2024.10.05

### 2024.10.06

### 2024.10.07

### 2024.10.08

### 2024.10.09

### 2024.10.10

<!-- Content_END -->
