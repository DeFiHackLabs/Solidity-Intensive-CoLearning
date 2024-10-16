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

- `Solidity` is a programming language for Smart Contract development on EVM (Ethereum Virtual Machine);
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
    keccak256("transfer(address,address,uint256)")
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
    return Target(_target);echo();
  }

  function callToContract(Target _target) external view returns (bool) {
    return _target.echo();
  }

  function callToVariable(address _target) external view returns (bool) {
    Target target = Target(_target);
    return target.echo();
  }

  function callToPayable(address _target) external payable {
    Target(_target);deposit{value: msg.value}("");
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
        keccak256(type(NewContract);creationCode)
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
        keccak256(abi.encodePacked(type(NewContract);creationCode, abi.encode(constructorParams...)))
        )))));
```

### 2024.10.04

#### Chapter 26: Delete Contract

`selfdestruct`

- To remove/erase the contract bytecode from the chain, then transfer remaining chain native token `ETH` to specific address
- Notes: `selfdestruct` deprecated in v0.8.18, but still available to use as don't have better alternative yet
- `EIP-6780` included along the `Cancun` upgrade have limit the feature of `selfdestruct`, which only transfer the remaining `ETH`, the remove of contract bytecode only work when contract creation + selfdestruct in single transaction. This applied to deployed contract too.

```
selfdestruct(addr);
// addr: Address to receive remaing ETH

// Creation and Destruct
function createContract() external {
  SomeContract sc = new SomeContract();
  sc.doSomething();
  sc.selfdestruct(payable(msg.sender));
}
```

#### Chapter 27: Application Binary Interface (ABI) Encoding & Decoding

ABI is the standard for interacting with EVM's smart contract. Data encoded based on their type; and since the encoding does not contain type information, it is necessary to specify their type when decoding them.
Functions of ABI:

Encoding:

- `abi.encode`
  - Designed to interact with smart contracts by padding each parameter with 32 bytes of data
  ```
  res = abi.encode(params...);
  ```
- `abi.encodePacked`
  - Encodes the given parameter according to its minimum required space. For example, only 1 byte is used to encode uint8 types. Usually used for data hashing or when don't interact with the contract
  ```
  res = abi.encodePacked(params...);
  ```
- `abi.encodeWithSignature`
  - Same as `abi.encode` but with function signature in first param
  - Notes: In signature, variable type `uint` and `int` need to write as `uint256` and `int256` respectively
  ```
  res = abi.encodeWithSignature("someFunction(variableTypes...)", params...);
  ```
- `abi.encodeWithSelector`
  - Same as `abi.encodeWithSignature`, but the first param is first 4 bytes of function selector's hash
  ```
  res = abi.encodeWithSelect(bytes4(keccak256("someFunction(variableTypes...)")), params...);
  ```

Decoding:

- `abi.decode`
  - Decode the binary encoding generated by abi.encode
  ```
  (var...) = abi.decode(data, (variableTypes...));
  ```

Use cases:

- Used with `call` to call to the contract

```
bytes4 selector = someContract.doSomething.selector;

bytes memory data = abi.encodeWithSelector(selector, _x);
(bool success, bytes memory returnedData) = address(someContract);staticcall(data);
```

- Used in ethers.js to implement contract imports and function calls

```
const someContract = new ethers.Contract(contractAddress, contractABI, signer);
const res = await someContract.doSomething();
```

- Used in contract decompiling, most of the functions in non-open-source contract was able to get encoded function hash but not the function signature, but at least can use with `abi.encodeWithSelector`

```
bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a));

(bool success, bytes memory returnedData) = address(someContract);staticcall(data);
require(success);
```

#### Chapter 28: Hash

A hash function is a cryptographic concept that converts a message of arbitrary length into a fixed-length value.
Properties of a Fine Hash:

- Unidirectionary: Hashing is simple and uniquely determined, while the reverse is almost impossible and can only be done by brute force enumeration
- Sensitivity: Any modification of input change the hash a lot
- Efficient: Easy to compute
- Brute force resistance: Almost possible to brute force

Use cases:

- Get a unique identifier
- Signature encryption
- Encryption

Keccak256

- Most commonly used hashing function in Solidity

#### Chapter 29: Function selector

We're actually sending `calldata` to contract when making transaction to it

- First 4 bytes of `calldata` is the function `selector`

`msg.data`

- Is the complete `calldata` sent into the contract

```
Calldata: 0x6a6278420000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
================
Function selector: 0x6a627842
Parameters: 0x0000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
```

`method id` are the first 4 bytes of function signature's keccak256 hash, also the `selector`

```
functionSignature = "someFunction(uint256,bool,...)";
functionSignatureHash = keccak256(functionSignature);
selectorOrMethodId = bytes4(functionSignatureHash);

// To call someFunction
(bool success1, bytes memory data1) = address(this);call(abi.encodeWithSelector(selectorOrMethodId, 1, true));
```

#### Chapter 30: Try catch

Solidity introduce exception handling since `0.6`. `try-catch` can only using with external function or contract creation

```
try someContract.someFunction() {
  // do something if success
} catch {
  // do something if failed
}

// external function of current deployed contract
try this.someFunction() {
  // do something if success
} catch {
  // do something if failed
}

// external function with data returns
try someContract.someFunction returns(returnType var) {
  // do something with var if success
} catch {
  // do something if failed
}

// Conditional catch
try ... {
} catch Error(string memory reason) {
  // catch failing revert() and require()
} catch Panic(uint errorCode) {
  // catch overflow, serious error
} catch (bytes memory lowLevelReason) {
  // catch failing assert()
}
```

End of WTF Solidity 102

### 2024.10.05

#### Chapter 31: ERC20

ERC20

- A token standard on Ethereum, which originated from the EIP20 proposed by Vitalik Buterin in November 2015
- Implements the basic logic of token transfer:
  - Account balance
  - Transfer
  - Approve transfer
  - Total token supply
  - Token information: name, symbol, decimal

IERC20

- Interface contract of `ERC20` token standard
  - Event
    - `event Transfer(address indexed from, address indexed to, uint256 value);`
    - `event Approval(address indexed owner, address indexed spender, uint256 value);`
  - Functions
    - `function totalSupply() external view returns (uint256);`
    - `function balanceOf(address account) external view returns (uint256);`
    - `function transfer(address to, uint256 amount) external returns (bool);`
    - `function allowance(address owner, address spender) external view returns (uint256);`
    - `function approve(address spender, uint256 amount) external returns (bool);`
    - `function transferFrom(address from, address to, uint256 amount) external returns (bool);`

Implementation of ERC20

- State Variables

```
mapping(address => uint256) public override balanceOf;

mapping(address => mapping(address => uint256)) public override allowance;

uint256 public override totalSupply;   // total supply of the token

string public name;   // the name of the token

string public symbol;  // the symbol of the token

uint8 public decimals = 18; // decimal places of the token
```

- Functions

```
// Initializes the token name and symbol
constructor(string memory name_, string memory symbol_){
  name = name_;
  symbol = symbol_;
}

// Handle token transfer
function transfer(address recipient, uint amount) external override returns (bool) {
  balanceOf[msg.sender] -= amount;
  balanceOf[recipient] += amount;
  emit Transfer(msg.sender, recipient, amount);
  return true;
}

// Handle token authorization logic
function approve(address spender, uint amount) external override returns (bool) {
  allowance[msg.sender][spender] = amount;
  emit Approval(msg.sender, spender, amount);
  return true;
}

// Logic for authorized transfer
function transferFrom(address sender, address recipient, uint amount) external override returns (bool) {
  allowance[sender][msg.sender] -= amount;
  balanceOf[sender] -= amount;
  balanceOf[recipient] += amount;
  emit Transfer(sender, recipient, amount);
  return true;
}

// Token minting
function mint(uint amount) external {
  balanceOf[msg.sender] += amount;
  totalSupply += amount;
  emit Transfer(address(0), msg.sender, amount);
}

// Destroy token
function burn(uint amount) external {
  balanceOf[msg.sender] -= amount;
  totalSupply -= amount;
  emit Transfer(msg.sender, address(0), amount);
}
```

### 2024.10.06

#### Chapter 32: Token Faucet

An apps or smart contract for claiming token, usually happen on testnet for dapps testing or learning to interact with blockchain.

- However, the first blockchain faucet was introduced in Bitcoin mainnet during early time, had gave away over 19,700 BTC.

Example of ERC20 Token Faucet

```
contract TokenFaucet {
  uint256 public amountAllowed = 100; // the allowed amount for each request is 100
  address public tokenContract;   // contract address of the token
  mapping(address => bool) public requestedAddress;   // a map contains requested address

  // Event SendToken
  event SendToken(address indexed Receiver, uint256 indexed Amount);

  // Set the ERC20'S contract address during deployment
  constructor(address _tokenContract) {
    tokenContract = _tokenContract; // set token contract
  }

  // Function for users to request tokens
  function requestTokens() external {
    require(requestedAddress[msg.sender] == false, "Can't Request Multiple Times!"); // Only one request per address
    IERC20 token = IERC20(tokenContract); // Create an IERC20 contract object
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // Faucet is empty

    token.transfer(msg.sender, amountAllowed); // Send token
    requestedAddress[msg.sender] = true; // Record the requested address

    emit SendToken(msg.sender, amountAllowed); // Emit SendToken event
  }
}
```

### 2024.10.07

#### Chapter 33: Airdrop

Example of Airdrop Contract

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {MerkleProof} from "./MerkleProof.sol";

interface IToken {
    function mint(address to, uint256 amount) external;
}

contract Airdrop {
    event Claim(address to, uint256 amount);

    IToken public immutable token;
    bytes32 public immutable root;
    mapping(bytes32 => bool) public claimed;

    constructor(address _token, bytes32 _root) {
        token = IToken(_token);
        root = _root;
    }

    function getLeafHash(address to, uint256 amount)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encode(to, amount));
    }

    function claim(bytes32[] memory proof, address to, uint256 amount)
        external
    {
        // NOTE: (to, amount) cannot have duplicates
        bytes32 leaf = getLeafHash(to, amount);

        require(!claimed[leaf], "airdrop already claimed");
        require(MerkleProof.verify(proof, root, leaf), "invalid merkle proof");
        claimed[leaf] = true;

        token.mint(to, amount);

        emit Claim(to, amount);
    }
}
```

This contract use Merkle Tree to check the eligibility of address to receive token airdrop.

- Claim function check the merkle proof submit by address and prevent address from repeated claim

### 2024.10.08

#### Chapter 34: ERC721

ERC165

- To declare the interfaces the smart contract support, for other contracts to check and access.

```
interface IERC165 {
    /**
     * @dev Returns true if contract implements the `interfaceId` for querying.
     * See https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section] for the definition of what an interface is.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// ERC721 implemented ERC165
function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
  return
    interfaceId == type(IERC721);interfaceId ||
    interfaceId == type(IERC165);interfaceId;
}
```

ERC721

- A non-divisible token standard

IERC721

- Interface contract of `ERC71` token standard

  - Event
    - `event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);`
    - `event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);`
    - `event ApprovalForAll(address indexed owner, address indexed operator, bool approved);`
  - Functions
    - `function balanceOf(address owner) external view returns (uint256 balance);`
    - `function ownerOf(uint256 tokenId) external view returns (address owner);`
    - `function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;`
    - `function safeTransferFrom(address from, address to, uint256 tokenId) external;`
    - `function transferFrom(address from, address to, uint256 tokenId) external;`
    - `function approve(address to, uint256 tokenId) external;`
    - `function setApprovalForAll(address operator, bool _approved) external;`
    - `function getApproved(uint256 tokenId) external view returns (address operator);`
    - `function isApprovedForAll(address owner, address operator) external view returns (bool);`

  IERC721Receiver

  - Implement this interface can allow a contract to receive `ERC721` tokens, otherwise it will revert by `safeTransferFrom()` method

  ```
  interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
  }

  // How it works
      function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            return
                IERC721Receiver(to);onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    _data
                ) == IERC721Receiver.onERC721Received.selector;
        } else {
            return true;
        }
    }
  ```

  IERC721Metadata

  - Implements commonly used functions for metadata querying
    - `name()`
    - `symbol()`
    - `tokenURI()`: URL of `metadata
    ```
    interface IERC721Metadata is IERC721 {
      function name() external view returns (string memory);
      function symbol() external view returns (string memory);
      function tokenURI(uint256 tokenId) external view returns (string memory);
    }
    ```

Implementation of ERC20

- State Variables

```
    // Token name
    string public override name;
    // Token symbol
    string public override symbol;
    // Mapping from token ID to owner address
    mapping(uint => address) private _owners;
    // Mapping owner address to balance of the token
    mapping(address => uint) private _balances;
    // Mapping from tokenId to approved address
    mapping(uint => address) private _tokenApprovals;
    //  Mapping from owner to operator addresses' batch approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;
```

- Functions

```
// Initializes the contract by setting a `name` and a `symbol` to the token collection.
constructor(string memory name_, string memory symbol_) {
  name = name_;
  symbol = symbol_;
}

// Implements the supportsInterface of IERC165
function supportsInterface(bytes4 interfaceId) external pure override returns (bool) {
  return
    interfaceId == type(IERC721);interfaceId ||
    interfaceId == type(IERC165);interfaceId ||
    interfaceId == type(IERC721Metadata);interfaceId;
}

// Implements the balanceOf function of IERC721, which uses `_balances` variable to check the balance of tokens in `owner`'s account.
function balanceOf(address owner) external view override returns (uint) {
  require(owner != address(0), "owner = zero address");
  return _balances[owner];
}

// Implements the ownerOf function of IERC721, which uses `_owners` variable to check `tokenId`'s owner.
function ownerOf(uint tokenId) public view override returns (address owner) {
  owner = _owners[tokenId];
  require(owner != address(0), "token doesn't exist");
}

// Implements the isApprovedForAll function of IERC721, which uses `_operatorApprovals` variable to check whether `owner` address's NFTs are authorized in batch to be held by another `operator` address.
function isApprovedForAll(address owner, address operator) external view override returns (bool) {
  return _operatorApprovals[owner][operator];
}

// Implements the setApprovalForAll function of IERC721, which approves all holding tokens to `operator` address. Invokes `_setApprovalForAll` function.
function setApprovalForAll(address operator, bool approved) external override {
  _operatorApprovals[msg.sender][operator] = approved;
  emit ApprovalForAll(msg.sender, operator, approved);
}

// Implements the getApproved function of IERC721, which uses `_tokenApprovals` variable to check authorized address of `tokenId`.
function getApproved(uint tokenId) external view override returns (address) {
  require(_owners[tokenId] != address(0), "token doesn't exist");
  return _tokenApprovals[tokenId];
}

// The approve function, which updates `_tokenApprovals` variable to approve `to` address to use `tokenId` and emits an Approval event.
function _approve(address owner, address to, uint tokenId) private {
  _tokenApprovals[tokenId] = to;
  emit Approval(owner, to, tokenId);
}

    // Implements the approve function of IERC721, which approves `tokenId` to `to` address.
    // Requirements: `to` is not `owner` and msg.sender is `owner` or an approved address. Invokes the _approve function.
    function approve(address to, uint tokenId) external override {
address owner = _owners[tokenId];
require(
    msg.sender == owner || _operatorApprovals[owner][msg.sender],
    "not owner nor approved for all"
);
_approve(owner, to, tokenId);
    }

// Checks whether the `spender` address can use `tokenId` or not. (`spender` is `owner` or an approved address)
function _isApprovedOrOwner(address owner, address spender, uint tokenId) private view returns (bool) {
  return (spender == owner ||
    _tokenApprovals[tokenId] == spender ||
    _operatorApprovals[owner][spender]);
}

// The transfer function, which transfers `tokenId` from `from` address to `to` address by updating the `_balances` and `_owner` variables, emits a Transfer event.
function _transfer(address owner, address from, address to, uint tokenId) private {
  require(from == owner, "not owner");
  require(to != address(0), "transfer to the zero address");

  _approve(owner, address(0), tokenId);
  _balances[from] -= 1;
  _balances[to] += 1;
  _owners[tokenId] = to;

  emit Transfer(from, to, tokenId);
}

// Implements the transferFrom function of IERC721, we should not use it as it is not a safe transfer. Invokes the _transfer function.
function transferFrom(address from,address to,uint tokenId) external override {
  address owner = ownerOf(tokenId);
  require(
    _isApprovedOrOwner(owner, msg.sender, tokenId),
    "not owner nor approved"
  );

  _transfer(owner, from, to, tokenId);
}

// Safely transfers `tokenId` token from `from` to `to`, this function will check that contract recipients are aware of the ERC721 protocol to prevent tokens from being forever locked. It invokes the _transfer and _checkOnERC721Received functions.
function _safeTransfer(address owner, address from, address to, uint tokenId, bytes memory _data) private {
  _transfer(owner, from, to, tokenId);
  require(_checkOnERC721Received(from, to, tokenId, _data), "not ERC721Receiver");
}

// Implements the safeTransferFrom function of IERC721 to safely transfer. It invokes the _safeTransfe function.
function safeTransferFrom(address from, address to, uint tokenId, bytes memory _data) public override {
  address owner = ownerOf(tokenId);
  require(
    _isApprovedOrOwner(owner, msg.sender, tokenId),
    "not owner nor approved"
  );

  _safeTransfer(owner, from, to, tokenId, _data);
}

// an overloaded function for safeTransferFrom
function safeTransferFrom(address from, address to, uint tokenId) external override {
  safeTransferFrom(from, to, tokenId, "");
}

// The mint function, which updates `_balances` and `_owners` variables to mint `tokenId` and transfers it to `to`. It emits an Transfer event.
function _mint(address to, uint tokenId) internal virtual {
  require(to != address(0), "mint to zero address");
  require(_owners[tokenId] == address(0), "token already minted");

  _balances[to] += 1;
  _owners[tokenId] = to;

  emit Transfer(address(0), to, tokenId);
}

// The destroy function, which destroys `tokenId` by updating `_balances` and `_owners` variables. It emits an Transfer event. Requirements: `tokenId` must exist.
function _burn(uint tokenId) internal virtual {
  address owner = ownerOf(tokenId);
  require(msg.sender == owner, "not owner of token");

  _approve(owner, address(0), tokenId);

  _balances[owner] -= 1;
  delete _owners[tokenId];

  emit Transfer(owner, address(0), tokenId);
}

// It invokes IERC721Receiver-onERC721Received when `to` address is a contract to prevent `tokenId` from being forever locked.
function _checkOnERC721Received(address from, address to, uint tokenId, bytes memory _data) private returns (bool) {
  if (to.isContract()) {
    return IERC721Receiver(to);onERC721Received(msg.sender, from, tokenId,_data) == IERC721Receiver.onERC721Received.selector;
  } else {
    return true;
  }
}

// Implements the tokenURI function of IERC721Metadata to query metadata.
function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
  require(_owners[tokenId] != address(0), "Token Not Exist");

  string memory baseURI = _baseURI();
  return bytes(baseURI);length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
}

// Base URI for computing {tokenURI}, which is the combination of `baseURI` and `tokenId`. Developers should rewrite this function accordingly.
function _baseURI() internal view virtual returns (string memory) {
  return "";
}
```

Other ERC165 Interface ID

```
function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
  return
    interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
    interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
    interfaceId == 0x5b5e139f || // ERC165 Interface ID for ERC721Metadata
    interfaceId == 0x780e9d63;   // ERC165 Interface ID for ERC721Enumerable
}
```

### 2024.10.09

#### Chapter 35: Dutch Auction

One of the common auction, also known as descending price auction, where the item begin to sell at preset price and decrease sequentially until it's sold.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/AmazingAng/WTFSolidity/blob/main/34_ERC721/ERC721.sol";

contract DutchAuction is Ownable, ERC721 {
    uint256 public constant COLLECTOIN_SIZE = 10000; // Total number of NFTs
    uint256 public constant AUCTION_START_PRICE = 1 ether; // Starting price (highest price)
    uint256 public constant AUCTION_END_PRICE = 0.1 ether; // End price (lowest price/floor price)
    uint256 public constant AUCTION_TIME = 10 minutes; // Auction duration. Set to 10 minutes for testing convenience
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes; // After how long the price will drop once
    uint256 public constant AUCTION_DROP_PER_STEP =
        (AUCTION_START_PRICE - AUCTION_END_PRICE) /
        (AUCTION_TIME / AUCTION_DROP_INTERVAL); // Price reduction per step

    uint256 public auctionStartTime; // Auction start timestamp
    string private _baseTokenURI; // metadata URI
    uint256[] private _allTokens; // Record all existing tokenIds

    // Get real-time auction price
    function getAuctionPrice()
        public
        view
        returns (uint256)
    {
        if (block.timestamp < auctionStartTime) {
        return AUCTION_START_PRICE;
        }else if (block.timestamp - auctionStartTime >= AUCTION_TIME) {
        return AUCTION_END_PRICE;
        } else {
        uint256 steps = (block.timestamp - auctionStartTime) /
            AUCTION_DROP_INTERVAL;
        return AUCTION_START_PRICE - (steps * AUCTION_DROP_PER_STEP);
        }
    }

    // the auction mint function
    function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // uses local variable to reduce gas
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // checks if the start time of auction has been set and auction has started
        require(
        totalSupply() + quantity <= COLLECTOIN_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // checks if the number of NFTs has exceeded the limit

        uint256 totalCost = getAuctionPrice() * quantity; // calculates the cost of mint
        require(msg.value >= totalCost, "Need to send more ETH."); // checks if the user has enough ETH to pay

        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // refund excess ETH
        if (msg.value > totalCost) {
            payable(msg.sender);transfer(msg.value - totalCost); //please check is there any risk of reentrancy attack
        }
    }

    // the withdraw function, onlyOwner modifier
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this);balance}(""); // how to use call function please see lession #22
        require(success, "Transfer failed.");
    }
}
```

#### Chapter 36: Merkle Tree

A fundamental encryption technology in blockchain

- Encrypted tree constructed from the bottom up, each leaf represent a hash of data,
- And non-leaf represent the hash of two child nodes

Generating a Merkle Tree

- In Javascript, the most used library is [merkletreejs](https://github.com/merkletreejs/merkletreejs)

```
// Sample data
    [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"
    ]

// Merkle tree of sorted keccak256 hash
└─ Root: eeefd63003e0e702cb41cd0043015a6e26ddb38073cc6ffeb0ba3e808ba8c097
   ├─ 9d997719c0a5b5f6db9b8ac69a988be57cf324cb9fffd51dc2c37544bb520d65
   │  ├─ Leaf0：5931b4ed56ace4c46b68524cb5bcbf4195f1bbaacbe5228fbd090546c88dd229
   │  └─ Leaf1：999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb
   └─ 4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c
      ├─ Leaf2：04a10bfd00977f54cc3450c9b25c9b3a502a089eba0097ba35fc33c4ea5fcb54
      └─ Leaf3：dfbe3e504ac4e35541bebad4d0e7574668e16fefa26cd4172f93e18b59ce9486
```

Verification of Merkle Proof

```
// Proof of address 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
[
  "0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb",
  "0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c"
]
```

- `MerkleProof` library in Solidity

```
library MerkleProof {
    /**
     * @dev Returns `true` when the `root` reconstructed from `proof` and `leaf` equals to the given `root`, meaning the data is valid.
     * During reconstruction, both the leaf node pairs and element pairs are sorted.
     */
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool) {
        return processProof(proof, leaf) == root;
    }

    /**
     * @dev Returns the `root` of the Merkle tree computed from a `leaf` and a `proof`.
     * The `proof` is only valid when the reconstructed `root` equals to the given `root`.
     * During reconstruction, both the leaf node pairs and element pairs are sorted.
     */
    function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = _hashPair(computedHash, proof[i]);
        }
        return computedHash;
    }

    // Sorted Pair Hash
    function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }
}
```

Use cases:

- NFT Whitelist: One of the gas-efficient way to allow whitelisted address to mint NFT. Only stored `root` in contract while `proof` compute offline

```
contract MerkleTree is ERC721 {
    bytes32 immutable public root; // Root of the Merkle tree
    mapping(address => bool) public mintedAddress;   // Record the address that has already been minted

    // Constructor, initialize the name and symbol of the NFT collection, and the root of the Merkle tree
    constructor(string memory name, string memory symbol, bytes32 merkleroot)
    ERC721(name, symbol)
    {
        root = merkleroot;
    }

    // Use the Merkle tree to verify the address and mint
    function mint(address account, uint256 tokenId, bytes32[] calldata proof)
    external
    {
        require(_verify(_leaf(account), proof), "Invalid merkle proof"); // Merkle verification passed
        require(!mintedAddress[account], "Already minted!"); // Address has not been minted

        mintedAddress[account] = true; // Record the minted address
        _mint(account, tokenId); // Mint
    }

    // Calculate the hash value of the Merkle tree leaf
    function _leaf(address account)
    internal pure returns (bytes32)
    {
        return keccak256(abi.encodePacked(account));
    }

    // Merkle tree verification, call the verify() function of the MerkleProof library
    function _verify(bytes32 leaf, bytes32[] memory proof)
    internal view returns (bool)
    {
        return MerkleProof.verify(proof, root, leaf);
    }
}
```

#### Chapter 37: Digital Signature

The digital signature algorithm used in Ethereum is Elliptic Curve Digital Signature Algorithm `ECDSA`. An algorithm based on the "private-public key" pair of elliptic curves

- Identity authentication: Prove that the signer is the holder of the private key.
- Non-repudiation: The sender cannot deny having sent the message.
- Integrity: The message cannot be modified during transmission.

`ECDSA` Contract

- Signer use `private key` to create a `signature` for a `message`
- Anyone can use the `signature` and the `message` to recover signer's `public key` and verify the signature

Creating a signature

1. Packing the message

```
// Concatenate the minting address (address type) and tokenId (uint256 type) to form the message msgHash
function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
    return keccak256(abi.encodePacked(_account, _tokenId));
}
```

2. Calculate Ethereum Signature Message

```
/*
 * Create an Ethereum signed message hash.
 * Adds the "\x19Ethereum Signed Message:\n32" string to prevent signing executable transactions.
*/
function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
  // The length of hash is 32
  return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
}
```

3. Signing the hash generated

```
account = "0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2"
hash = "0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c"
ethereum.request({method: "personal_sign", params: [account, hash]})
```

4. Recover Public Key from Signature and Message

```
   // @dev Recovers the signer address from _msgHash and the signature _signature
    function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address) {
        // Checks the length of the signature. 65 is the length of a standard r,s,v signature.
        require(_signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        // Currently, we can only use assembly to obtain the values of r,s,v from the signature.
        assembly {
            /*
            The first 32 bytes store the length of the signature (dynamic array storage rule)
            add(sig, 32) = signature pointer + 32
            Is equivalent to skipping the first 32 bytes of the signature
            mload(p) loads the next 32 bytes of data from the memory address p
            */
            // Reads the next 32 bytes after the length data
            r := mload(add(_signature, 0x20))
            // Reads the next 32 bytes after r
            s := mload(add(_signature, 0x40))
            // Reads the last byte
            v := byte(0, mload(add(_signature, 0x60)))
        }
        // Uses ecrecover(global function) to recover the signer address from msgHash, r,s,v
        return ecrecover(_msgHash, v, r, s);
    }
```

5. Verify Signature

```
// Verify if the signature address is correct via ECDSA. Returns true if correct.
function verify(bytes32 _msgHash, bytes memory _signature, address _signer) internal pure returns (bool) {
    return recoverSigner(_msgHash, _signature) == _signer;
}
```

#### Chapter 38: NFT Exchange

Design Logic

- Seller: Create a listing, revoke the listing, and update the price
- Buyer: Purchase the item via contract
- Sale order: Listing created by seller, include listing price, owner and sales info

Events

```
    event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId);
    event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice);
```

Order

```
    // Define the order structure
    struct Order{
        address owner;
        uint256 price;
    }
    // NFT Order mapping
    mapping(address => mapping(uint256 => Order)) public nftList;
```

Fallback and onERC721Received

```
// A fallback function for contract to receive ETH
    fallback() external payable{}
// Allow contract to receive ERC721 via IERC721Receiver
```

Trading

```
    // List: The seller lists NFT on sale, contract address is _nftAddr, tokenId is _tokenId, price is _price in ether (unit is wei)
    function list(address _nftAddr, uint256 _tokenId, uint256 _price) public{
        IERC721 _nft = IERC721(_nftAddr); // Declare an interface contract variable IERC721
        require(_nft.getApproved(_tokenId) == address(this), "Need Approval"); // The contract is approved
        require(_price > 0); // The price is greater than 0

        Order storage _order = nftList[_nftAddr][_tokenId]; // Set the NFT holder and price
        _order.owner = msg.sender;
        _order.price = _price;
        // Transfer NFT to the contract
        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        // Release List event
        emit List(msg.sender, _nftAddr, _tokenId, _price);
    }

// cancel order: seller cancels the order
function revoke(address _nftAddr, uint256 _tokenId) public {
    Order storage _order = nftList[_nftAddr][_tokenId]; // get the order
    require(_order.owner == msg.sender, "Not Owner"); // must be initiated by the owner
    // declare IERC721 interface contract variables
    IERC721 _nft = IERC721(_nftAddr);
    require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT is in the contract

    // transfer NFT to seller
    _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
    delete nftList[_nftAddr][_tokenId]; // delete order

    // emit Revoke event
    emit Revoke(msg.sender, _nftAddr, _tokenId);
}

    // Adjust Price: Seller adjusts the listing price
    function update(address _nftAddr, uint256 _tokenId, uint256 _newPrice) public {
        require(_newPrice > 0, "Invalid Price"); // NFT price must be greater than 0
        Order storage _order = nftList[_nftAddr][_tokenId]; // Get the Order
        require(_order.owner == msg.sender, "Not Owner"); // It must be initiated by the owner
        // Declare IERC721 interface contract variable
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT is in the contract

        // Adjust the NFT price
        _order.price = _newPrice;

        // Release Update event
        emit Update(msg.sender, _nftAddr, _tokenId, _newPrice);
    }

    // Purchase: A buyer purchases an NFT with ETH attached, the contract address is _nftAddr, tokenId is _tokenId
    function purchase(address _nftAddr, uint256 _tokenId) payable public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // Get Order
        require(_order.price > 0, "Invalid Price"); // The NFT price is greater than 0
        require(msg.value >= _order.price, "Increase price"); // The purchase price is greater than the asking price
        // Declare IERC721 interface contract variable
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // The NFT is in the contract

        // Transfer the NFT to the buyer
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // Transfer ETH to the seller, refund any excess ETH to the buyer
        payable(_order.owner);transfer(_order.price);
        payable(msg.sender);transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // Delete order

        // Release Purchase event
        emit Purchase(msg.sender, _nftAddr, _tokenId, msg.value);
    }
```

### 2024.10.10

#### Chapter 39: Random Number Generation (RNG)

On-chain RNG

```
/**
 * Generating pseudo-random numbers on the chain.
 * Using keccak256() to pack some on-chain global variables/custom variables.
 * Converted to uint256 type when returned.
*/
function getRandomOnchain() public view returns(uint256){
     // Generating blockhash in Remix will result in an error.
     bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));

     return uint256(randomBytes);
}
```

- This method is not secure
  - `block.timestamp`, `msg.sender` and `block.number` are public visible and predictable
  - Miner can manipulate the `block.timestamp` and `block.number` to generate a random number that match with their intent

Off-chain RNG

- `Oracle` is the most used service to obtain off-chain data by smart contract, it include random number
- `Chainlink` provide a VRF Verifiable Random Function, which user pay `LINK` token to get the random number
- It is secure than the on-chain RNG

`Chainlink VRF`

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {VRFConsumerBase} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBase.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * Request testnet LINK and ETH here: https://faucets.chain.link/
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https://docs.chain.link/docs/link-token-contracts/
 */

contract RandomNumberConsumer is VRFConsumerBase {
    event RequestFulfilled(bytes32 requestId, uint256 randomness);

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    /**
     * Constructor inherits VRFConsumerBase
     *
     * Network: Sepolia
     * Chainlink VRF Coordinator address: 0x271682DEB8C4E0901D1a1550aD2e64D568E69909
     * LINK token address: 0x779877A7B0D9E8603169DdbD7836e478b4624789
     * Key Hash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c
     */
    constructor()
        VRFConsumerBase(
            0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625, // VRF Coordinator
            0x779877A7B0D9E8603169DdbD7836e478b4624789 // LINK Token
        )
    {
        keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
    }

    /**
     * Requests randomness
     */
    function getRandomNumber() public returns (bytes32 requestId) {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        return requestRandomness(keyHash, fee);
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(
        bytes32 requestId,
        uint256 randomness
    ) internal override {
        randomResult = randomness;
        emit RequestFulfilled(requestId, randomness);
    }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract
}
```

Both methods have their own advantages and disadvantages: using on-chain random numbers is efficient but insecure, while generating off-chain random numbers relies on third-party oracle services, which is relatively safe but probably not economical if inappropriate used.

#### Chapter 40: ERC1155

A semi-fungible token standard, similar to `ERC721` but each `id` can have more than one.

`IERC1155`

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../34_ERC721_en/IERC165.sol";

/**
 * @dev ERC1155 standard interface contract, realizes the function of EIP1155
 * See: https://eips.ethereum.org/EIPS/eip-1155[EIP].
 */
interface IERC1155 is IERC165 {
    /**
     * @dev single-type token transfer event
     * Released when `value` tokens of type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 value
    );

    /**
     * @dev multi-type token transfer event
     * ids and values are arrays of token types and quantities transferred
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev volume authorization event
     * Released when `account` authorizes all tokens to `operator`
     */
    event ApprovalForAll(
        address indexed account,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Released when the URI of the token of type `id` changes, `value` is the new URI
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Balance inquiry, returns the position of the token of `id` type owned by `account`
     */
    function balanceOf(
        address account,
        uint256 id
    ) external view returns (uint256);

    /**
     * @dev Batch balance inquiry, the length of `accounts` and `ids` arrays have to wait.
     */
    function balanceOfBatch(
        address[] calldata accounts,
        uint256[] calldata ids
    ) external view returns (uint256[] memory);

    /**
     * @dev Batch authorization, authorize the caller's tokens to the `operator` address.
     * Release the {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Batch authorization query, if the authorization address `operator` is authorized by `account`, return `true`
     * See {setApprovalForAll} function.
     */
    function isApprovedForAll(
        address account,
        address operator
    ) external view returns (bool);

    /**
     * @dev Secure transfer, transfer `amount` unit `id` type token from `from` to `to`.
     * Release {TransferSingle} event.
     * Require:
     * - If the caller is not a `from` address but an authorized address, it needs to be authorized by `from`
     * - `from` address must have enough open positions
     * - If the receiver is a contract, it needs to implement the `onERC1155Received` method of `IERC1155Receiver` and return the corresponding value
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev Batch security transfer
     * Release {TransferBatch} event
     * Require:
     * - `ids` and `amounts` are of equal length
     * - If the receiver is a contract, it needs to implement the `onERC1155BatchReceived` method of `IERC1155Receiver` and return the corresponding value
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
```

`IERC1155Receiver`
To allow a smart contract to accept `ERC1155` token

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../34_ERC721_en/IERC165.sol";

/**
 * @dev ERC1155 receiving contract, to accept the secure transfer of ERC1155, this contract needs to be implemented
 */
interface IERC1155Receiver is IERC165 {
    /**
     * @dev accept ERC1155 safe transfer `safeTransferFrom`
     * Need to return 0xf23a6e61 or `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
     */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev accept ERC1155 batch safe transfer `safeBatchTransferFrom`
     * Need to return 0xbc197c81 or `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
     */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}
```

`ERC1155`

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Receiver.sol";
import "./IERC1155MetadataURI.sol";
import "../34_ERC721_en/Address.sol";
import "../34_ERC721_en/String.sol";
import "../34_ERC721_en/IERC165.sol";

/**
 * @dev ERC1155 multi-token standard
 * See https://eips.ethereum.org/EIPS/eip-1155
 */
contract ERC1155 is IERC165, IERC1155, IERC1155MetadataURI {
    using Address for address; // use the Address library, isContract to determine whether the address is a contract
    using Strings for uint256; // use the String library
    // Token name
    string public name;
    // Token code name
    string public symbol;
    // Mapping from token type id to account account to balances
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // Batch authorization mapping from initiator address to authorized address operator to whether to authorize bool
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * Constructor, initialize `name` and `symbol`, uri_
     */
    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        return
            interfaceId == type(IERC1155);interfaceId ||
            interfaceId == type(IERC1155MetadataURI);interfaceId ||
            interfaceId == type(IERC165);interfaceId;
    }

    /**
     * @dev Balance query function implements balanceOf of IERC1155 and returns the number of token holdings of the id type of the account address.
     */
    function balanceOf(
        address account,
        uint256 id
    ) public view virtual override returns (uint256) {
        require(
            account != address(0),
            "ERC1155: address zero is not a valid owner"
        );
        return _balances[id][account];
    }

    /**
     * @dev Batch balance query
     * Require:
     * - `accounts` and `ids` arrays are of equal length.
     */
    function balanceOfBatch(
        address[] memory accounts,
        uint256[] memory ids
    ) public view virtual override returns (uint256[] memory) {
        require(
            accounts.length == ids.length,
            "ERC1155: accounts and ids length mismatch"
        );
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }

    /**
     * @dev Batch authorization function, the caller authorizes the operator to use all its tokens
     * Release {ApprovalForAll} event
     * Condition: msg.sender != operator
     */
    function setApprovalForAll(
        address operator,
        bool approved
    ) public virtual override {
        require(
            msg.sender != operator,
            "ERC1155: setting approval status for self"
        );
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev Batch authorization query.
     */
    function isApprovedForAll(
        address account,
        address operator
    ) public view virtual override returns (bool) {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev Secure transfer function, transfer `id` type token of `amount` unit from `from` to `to`
     * Release the {TransferSingle} event.
     * Require:
     * - to cannot be 0 address.
     * - from has enough balance and the caller has authorization
     * - If to is a smart contract, it must support IERC1155Receiver-onERC1155Received.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // The caller is the holder or authorized
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(to != address(0), "ERC1155: transfer to the zero address");
        // from address has enough balance
        uint256 fromBalance = _balances[id][from];
        require(
            fromBalance >= amount,
            "ERC1155: insufficient balance for transfer"
        );
        // update position
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }
        _balances[id][to] += amount;
        // release event
        emit TransferSingle(operator, from, to, id, amount);
        // Security check
        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
    }

    /**
     * @dev Batch security transfer function, transfer tokens of the `ids` array type in the `amounts` array unit from `from` to `to`
     * Release the {TransferSingle} event.
     * Require:
     * - to cannot be 0 address.
     * - from has enough balance and the caller has authorization
     * - If to is a smart contract, it must support IERC1155Receiver-onERC1155BatchReceived.
     * - ids and amounts arrays have equal length
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // The caller is the holder or authorized
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );
        require(to != address(0), "ERC1155: transfer to the zero address");

        // Update balance through for loop
        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(
                fromBalance >= amount,
                "ERC1155: insufficient balance for transfer"
            );
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
            _balances[id][to] += amount;
        }

        emit TransferBatch(operator, from, to, ids, amounts);
        // Security check
        _doSafeBatchTransferAcceptanceCheck(
            operator,
            from,
            to,
            ids,
            amounts,
            data
        );
    }

    /**
     * @dev Mint function
     * Release the {TransferSingle} event.
     */
    function _mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");

        address operator = msg.sender;

        _balances[id][to] += amount;
        emit TransferSingle(operator, address(0), to, id, amount);

        _doSafeTransferAcceptanceCheck(
            operator,
            address(0),
            to,
            id,
            amount,
            data
        );
    }

    /**
     * @dev Batch mint function
     * Release the {TransferBatch} event.
     */
    function _mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            _balances[ids[i]][to] += amounts[i];
        }

        emit TransferBatch(operator, address(0), to, ids, amounts);

        _doSafeBatchTransferAcceptanceCheck(
            operator,
            address(0),
            to,
            ids,
            amounts,
            data
        );
    }

    /**
     * @dev destroy
     */
    function _burn(address from, uint256 id, uint256 amount) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");

        address operator = msg.sender;

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }

        emit TransferSingle(operator, from, address(0), id, amount);
    }

    /**
     * @dev batch destruction
     */
    function _burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(
                fromBalance >= amount,
                "ERC1155: burn amount exceeds balance"
            );
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), ids, amounts);
    }

    // @dev ERC1155 security transfer check
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IERC1155Receiver(to);onERC1155Received(
                    operator,
                    from,
                    id,
                    amount,
                    data
                )
            returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155 Receiver implementer");
            }
        }
    }

    // @dev ERC1155 batch security transfer check
    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IERC1155Receiver(to);onERC1155BatchReceived(
                    operator,
                    from,
                    ids,
                    amounts,
                    data
                )
            returns (bytes4 response) {
                if (
                    response != IERC1155Receiver.onERC1155BatchReceived.selector
                ) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155 Receiver implementer");
            }
        }
    }

    /**
     * @dev Returns the uri of the id type token of ERC1155, stores metadata, similar to the tokenURI of ERC721.
     */
    function uri(
        uint256 id
    ) public view virtual override returns (string memory) {
        string memory baseURI = _baseURI();
        return
            bytes(baseURI);length > 0
                ? string(abi.encodePacked(baseURI, id.toString()))
                : "";
    }

    /**
     * Calculate the BaseURI of {uri}, uri is splicing baseURI and tokenId together, which needs to be rewritten by development.
     */
    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
}
```

#### Chapter 41: WETH

Wrapped ETH `WETH` is a wrapped version of ETH in `ERC20`. Why do we need to wrap it?

- Improve interoperability between blockchains and allow the use of ETH in decentralized applications (dApps)
- Standardize usage in smart contract with `ERC20`
- Exchanged with `ETH` at 1:1 ratio

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {
    // Events: deposits and withdrawals
    event Deposit(address indexed dst, uint wad);
    event Withdrawal(address indexed src, uint wad);

    // Constructor, initialize the name of ERC20
    constructor() ERC20("WETH", "WETH") {}

    // Callback function, when the user transfers ETH to the WETH contract, the deposit() function will be triggered
    fallback() external payable {
        deposit();
    }

    // Callback function, when the user transfers ETH to the WETH contract, the deposit() function will be triggered
    receive() external payable {
        deposit();
    }

    // Deposit function, when the user deposits ETH, mint the same amount of WETH for him
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    // Withdrawal function, the user destroys WETH and gets back the same amount of ETH
    function withdraw(uint amount) public {
        require(balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        payable(msg.sender);transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}
```

#### Chapter 42: Payment Splitting

Features of Payment Split Contract:

- Stored receivers `payee` and their shares
- `payee` withdraw the amount proportional to their shares

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * PaymentSplit
 * @dev This contract will distribute the received ETH to several accounts according to the pre-determined share.Received ETH will be stored in PaymentSplit, and each beneficiary needs to call the release() function to claim it.
 */
contract PaymentSplit {
    event PayeeAdded(address account, uint256 shares); // Event for adding a payee
    event PaymentReleased(address to, uint256 amount); // Event for releasing payment to a payee
    event PaymentReceived(address from, uint256 amount); // Event for receiving payment to the contract

    uint256 public totalShares; // Total shares of the contract
    uint256 public totalReleased; // Total amount of payments released from the contract

    mapping(address => uint256) public shares; // Mapping to store the shares of each payee
    mapping(address => uint256) public released; // Mapping to store the amount of payments released to each payee
    address[] public payees; // Array  of payees


    /**
     * @dev Constructor to initialize the payees array (_payees) and their shares (_shares);
     *      The length of both arrays cannot be 0 and must be equal.
            Each element in the _shares array must be greater than 0,
            and each address in _payees must not be a zero address and must be unique.
     */
    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // Check that the length of _payees and _shares arrays are equal and not empty
        require(
            _payees.length == _shares.length,
            "PaymentSplitter: payees and shares length mismatch"
        );
        require(_payees.length > 0, "PaymentSplitter: no payees");
        //  Call the _addPayee function to update the payees addresses (payees), their shares (shares), and the total shares (totalShares)
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }

    /**
     * @dev Callback function, receive ETH emit PaymentReceived event
     */
    receive() external payable virtual {
        emit PaymentReceived(msg.sender, msg.value);
    }

    /**
     * @dev Splits funds to the designated payee address "_account". Anyone can trigger this function, but the funds will be transferred to the "_account" address.
     * Calls the "releasable()" function.
     */
    function release(address payable _account) public virtual {
        // The "_account" address must be a valid payee.
        require(shares[_account] > 0, "PaymentSplitter: account has no shares");
        // Calculate the payment due to the "_account" address.
        uint256 payment = releasable(_account);
        // The payment due cannot be zero.
        require(payment != 0, "PaymentSplitter: account is not due payment");
        // Update the "totalReleased" and "released" amounts for each payee.
        totalReleased += payment;
        released[_account] += payment;
        // transfer
        _account.transfer(payment);
        emit PaymentReleased(_account, payment);
    }

    /**
     * @dev Calculate the eth that an account can receive.
     * The pendingPayment() function is called.
     */
    function releasable(address _account) public view returns (uint256) {
        // Calculate the total income of the profit-sharing contract
        uint256 totalReceived = address(this);balance + totalReleased;
        // Call _pendingPayment to calculate the amount of ETH that account is entitled to
        return pendingPayment(_account, totalReceived, released[_account]);
    }

    /**
     * @dev According to the payee address `_account`, the total income of the distribution contract `_totalReceived` and the money received by the address `_alreadyReleased`, calculate the `ETH` that the payee should now distribute.
     */
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // ETH due to account = Total ETH due - ETH received
        return
            (_totalReceived * shares[_account]) /
            totalShares -
            _alreadyReleased;
    }

    /**
     * @dev Add payee_account and corresponding share_accountShares. It can only be called in the constructor and cannot be modified.
     */
    function _addPayee(address _account, uint256 _accountShares) private {
        // Check that _account is not 0 address
        require(
            _account != address(0),
            "PaymentSplitter: account is the zero address"
        );
        // Check that _accountShares is not 0
        require(_accountShares > 0, "PaymentSplitter: shares are 0");
        // Check that _account is not duplicated
        require(
            shares[_account] == 0,
            "PaymentSplitter: account already has shares"
        );
        // Update payees, shares and totalShares
        payees.push(_account);
        shares[_account] = _accountShares;
        totalShares += _accountShares;
        // emit add payee event
        emit PayeeAdded(_account, _accountShares);
    }
}
```

#### Chapter 43: Linear Release

Token vesting is a common method to release token to founding team member, venture capitalist at early stage.

- Smart contract initally locked with an amount of token,
- release at specific rate periodically

```
contract TokenVesting {
    // Event
    event ERC20Released(address indexed token, uint256 amount); // Withdraw event

    // State variables
    mapping(address => uint256) public erc20Released; // Token address -> release amount mapping, recording the number of tokens the beneficiary has received
    address public immutable beneficiary; // Beneficiary address
    uint256 public immutable start; // Start timestamp
    uint256 public immutable duration; // Duration

    /**
     * @dev Initialize the beneficiary address,release duration (seconds),start timestamp (current blockchain timestamp)
     */
    constructor(address beneficiaryAddress, uint256 durationSeconds) {
        require(
            beneficiaryAddress != address(0),
            "VestingWallet: beneficiary is zero address"
        );
        beneficiary = beneficiaryAddress;
        start = block.timestamp;
        duration = durationSeconds;
    }

    /**
     * @dev Beneficiary withdraws the released tokens.
     * Calls the vestedAmount() function to calculate the amount of tokens that can be withdrawn, then transfer them to the beneficiary.
     * Emit an {ERC20Released} event.
     */
    function release(address token) public {
        // Calls the vestedAmount() function to calculate the amount of tokens that can be withdrawn.
        uint256 releasable = vestedAmount(token, uint256(block.timestamp)) -
            erc20Released[token];
        // Updates the amount of tokens that have been released.
        erc20Released[token] += releasable;
        // Transfers the tokens to the beneficiary.
        emit ERC20Released(token, releasable);
        IERC20(token);transfer(beneficiary, releasable);
    }

    /**
     * @dev According to the linear release formula, calculate the released quantity. Developers can customize the release method by modifying this function.
     * @param token: Token address
     * @param timestamp: Query timestamp
     */
    function vestedAmount(
        address token,
        uint256 timestamp
    ) public view returns (uint256) {
        // Total amount of tokens received in the contract (current balance + withdrawn)
        uint256 totalAllocation = IERC20(token);balanceOf(address(this)) +
            erc20Released[token];
        // According to the linear release formula, calculate the released quantity
        if (timestamp < start) {
            return 0;
        } else if (timestamp > start + duration) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start)) / duration;
        }
    }
}
```

#### Chapter 44: Token Lock

A way to lock an amount of token for purposes like liquidity locking, yield-farming, etc

Token Locker Contract

```
contract TokenLocker {
    event TokenLockStart(
        address indexed beneficiary,
        address indexed token,
        uint256 startTime,
        uint256 lockTime
    );
    event Release(
        address indexed beneficiary,
        address indexed token,
        uint256 releaseTime,
        uint256 amount
    );

    // Locked ERC20 token contracts
    IERC20 public immutable token;
    // Beneficiary address
    address public immutable beneficiary;
    // Lockup time (seconds)
    uint256 public immutable lockTime;
    // Lockup start timestamp (seconds)
    uint256 public immutable startTime;

    /**
     * @dev Deploy the time lock contract, initialize the token contract address, beneficiary address and lock time.
     * @param token_: Locked ERC20 token contract
     * @param beneficiary_: Beneficiary address
     * @param lockTime_: Lockup time (seconds)
     */
    constructor(IERC20 token_, address beneficiary_, uint256 lockTime_) {
        require(lockTime_ > 0, "TokenLock: lock time should greater than 0");
        token = token_;
        beneficiary = beneficiary_;
        lockTime = lockTime_;
        startTime = block.timestamp;

        emit TokenLockStart(
            beneficiary_,
            address(token_),
            block.timestamp,
            lockTime_
        );
    }

    /**
     * @dev After the lockup time, the tokens are released to the beneficiaries.
     */
    function release() public {
        require(
            block.timestamp >= startTime + lockTime,
            "TokenLock: current time is before release time"
        );

        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");

        token.transfer(beneficiary, amount);

        emit Release(msg.sender, address(token), block.timestamp, amount);
    }
}
```

#### Chapter 45: Time Lock

Time lock is a locking mechanism usually used in vault

- Create a transaction and add it to the timelock queue
- Execute the transaction after the lock-in period
- Cancel the transaction in timelock queue

```
contract TimeLocker {
    // transaction cancel event
    event CancelTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint executeTime
    );
    // transaction execution event
    event ExecuteTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint executeTime
    );
    // transaction created and queued event
    event QueueTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint executeTime
    );
    // Event to change administrator address
    event NewAdmin(address indexed newAdmin);

    // State variables
    address public admin; // Admin address
    uint public constant GRACE_PERIOD = 7 days; // Transaction validity period, expired transactions are void
    uint public delay; // Transaction lock time (seconds)
    mapping(bytes32 => bool) public queuedTransactions; // Record all transactions in the timelock queue

    // onlyOwner modifier
    modifier onlyOwner() {
        require(msg.sender == admin, "Timelock: Caller not admin");
        _;
    }

    // onlyTimelock modifier
    modifier onlyTimelock() {
        require(msg.sender == address(this), "Timelock: Caller not Timelock");
        _;
    }

 /**
     * @dev Constructor, initialize transaction lock time (seconds) and administrator address
     */
    constructor(uint delay_) {
        delay = delay_;
        admin = msg.sender;
    }

    /**
     * @dev To change the administrator address, the caller must be a Timelock contract.
     */
    function changeAdmin(address newAdmin) public onlyTimelock {
        admin = newAdmin;

        emit NewAdmin(newAdmin);
    }

    /**
     * @dev Create a transaction and add it to the timelock queue.
     * @param target: Target contract address
     * @param value: Send eth value
     * @param signature: The function signature to call (function signature)
     * @param data: call data, which contains some parameters
     * @param executeTime: Blockchain timestamp of transaction execution
     *
     * Requirement: executeTime is greater than the current blockchain timestamp + delay
     */
    function queueTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 executeTime
    ) public onlyOwner returns (bytes32) {
        // Check: transaction execution time meets lock time
        require(
            executeTime >= getBlockTimestamp() + delay,
            "Timelock::queueTransaction: Estimated execution block must satisfy delay."
        );
        // Calculate the unique identifier for the transaction
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // Add transaction to queue
        queuedTransactions[txHash] = true;

        emit QueueTransaction(
            txHash,
            target,
            value,
            signature,
            data,
            executeTime
        );
        return txHash;
    }

    /**
     * @dev Cancel a specific transaction.
     *
     * Requirement: the transaction is in the timelock queue
     */
    function cancelTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 executeTime
    ) public onlyOwner {
        // Calculate the unique identifier for the transaction
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // Check: transaction is in timelock queue
        require(
            queuedTransactions[txHash],
            "Timelock::cancelTransaction: Transaction hasn't been queued."
        );
        // dequeue the transaction
        queuedTransactions[txHash] = false;

        emit CancelTransaction(
            txHash,
            target,
            value,
            signature,
            data,
            executeTime
        );
    }

    /**
     * @dev Execute a specific transaction
     *
     * 1. The transaction is in the timelock queue
     * 2. The execution time of the transaction is reached
     * 3. The transaction has not expired
     */
    function executeTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 executeTime
    ) public payable onlyOwner returns (bytes memory) {
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // Check: Is the transaction in the timelock queue
        require(
            queuedTransactions[txHash],
            "Timelock::executeTransaction: Transaction hasn't been queued."
        );
        // Check: the execution time of the transaction is reached
        require(
            getBlockTimestamp() >= executeTime,
            "Timelock::executeTransaction: Transaction hasn't surpassed time lock."
        );
        // Check: the transaction has not expired
        require(
            getBlockTimestamp() <= executeTime + GRACE_PERIOD,
            "Timelock::executeTransaction: Transaction is stale."
        );
        // remove the transaction from the queue
        queuedTransactions[txHash] = false;

        // get callData
        bytes memory callData;
        if (bytes(signature);length == 0) {
            callData = data;
        } else {
            callData = abi.encodePacked(
                bytes4(keccak256(bytes(signature))),
                data
            );
        }
        // Use call to execute transactions
        (bool success, bytes memory returnData) = target.call{value: value}(
            callData
        );
        require(
            success,
            "Timelock::executeTransaction: Transaction execution reverted."
        );

        emit ExecuteTransaction(
            txHash,
            target,
            value,
            signature,
            data,
            executeTime
        );


        return returnData;
    }

    /**
     * @dev Get the current blockchain timestamp
     */
    function getBlockTimestamp() public view returns (uint) {
        return block.timestamp;
    }

    /**
     * @dev transaction identifier
     */
    function getTxHash(
        address target,
        uint value,
        string memory signature,
        bytes memory data,
        uint executeTime
    ) public pure returns (bytes32) {
        return
            keccak256(abi.encode(target, value, signature, data, executeTime));
    }
}
```

### 2024.10.11

#### Chapter 46: Proxy Contract

Most of the smart contracts deployed on `EVM` chain are immutable

- Advantage: Predictable behaviour
- Disadvantage: Unable to upgrade/modify/fix faulty code

Proxy Pattern

- Separate the data and logic into two contracts. The state variables (data) stored in the proxy contract and logic functions stored in the logic contract
- The proxy contract (Proxy) delegates the function call to the logic contract (Implementation) through delegatecall, and then returns the final result to the caller
- The state variable storage structure of the Logic contract and the Proxy contract must be the same, otherwise `delegatecall` will cause unexpected behavior and security risks
- Benefits:
  - Upgradeable: Point the proxy contract to latest deployed logic contract
  - Gas saving: One logic contract can use by multiple proxy contracts, reduce code redundancy and deployment

Proxy Contract

```
contract Proxy {
    address public implementation; // Address of the logic contract. The data type of the implementation contract has to be the same as that of the Proxy contract at the same position or an error will occur.

    constructor(address implementation_) {
        implementation = implementation_;
    }

    /**
     * @dev fallback function, delegates invocations of current contract to `implementation` contract
     * with inline assembly, it gives fallback function a return value
     */
    fallback() external payable {
        address _implementation = implementation;
        assembly {
            // copy msg.data to memory
            // the parameters of opcode calldatacopy: start position of memory, start position of calldata, length of calldata
            calldatacopy(0, 0, calldatasize())

            // use delegatecall to call implementation contract
            // the parameters of opcode delegatecall: gas, target contract address, start position of input memory, length of input memory, start position of output memory, length of output memory
            // set start position of output memory and length of output memory to 0
            // delegatecall returns 1 if success, 0 if fail
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // copy returndata to memory
            // the parameters of opcode returndata: start position of memory, start position of returndata, length of return data
            returndatacopy(0, 0, returndatasize())

            switch result
            // if delegate call fails, then revert
            case 0 { revert(0, returndatasize()) }
            // if delegate call succeeds, then return memory data(as bytes format) starting from 0 with length of returndatasize()
            default { return(0, returndatasize()) }
        }
    }
}
```

Logic Contract

```
/**
 * @dev Logic contract, executes delegated calls
 */
contract Logic {
    address public implementation; // Keep consistency with the Proxy to prevent slot collision
    uint public x = 99;
    event CallSuccess(); // Event emitted on successful function call

    // This function emits CallSuccess event and returns a uint
    // Function selector: 0xd09de08a
    function increment() external returns(uint) {
        emit CallSuccess();
        return x + 1;
    }
}
```

Demo

```
// The caller can be a contract or `EOA` address
contract Caller{
    address public proxy; // proxy contract address

    constructor(address proxy_){
        proxy = proxy_;
    }

    // Call the increment() function using the proxy contract
    function increment() external returns(uint) {
        ( , bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
        return abi.decode(data,(uint));
    }
}
```

Although the proxy pattern is simple, it is always recommend to use templates, eg: [OpenZeppelin proxy](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/proxy) for better security.

#### Chapter 47: Upgradeable Contract

Replace the existing logic contract by repoint the implementation address of proxy contract.

Example (Proxy)

```
// SPDX-License-Identifier: MIT
// wtf.academy
pragma solidity ^0.8.4;

// simple upgradeable contract, the admin could change the logic contract's address by calling upgrade function, thus change the contract logic
// FOR TEACHING PURPOSE ONLY, DO NOT USE IN PRODUCTION
contract SimpleUpgrade {
    // logic contract's address
    address public implementation;

    // admin address
    address public admin;

    // string variable, could be changed by logic contract's function
    string public words;

    // constructor, initializing admin address and logic contract's address
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback function, delegates function call to logic contract
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // upgrade function, changes the logic contract's address, can only by called by admin
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
```

Example (Logic)

```
// Logic Contract to be replace
contract Logic1 {
    // State variables consistent with Proxy contract to prevent slot conflicts
    address public implementation;
    address public admin;
    // String that can be changed through the function of the logic contract
    string public words;

    // Change state variables in Proxy contract, selector: 0xc2985578
    function foo() public {
        words = "old";
    }
}

// New Logic Contract
contract Logic2 {
    // State variables consistent with proxy contract to prevent slot collisions
    address public implementation;
    address public admin;
    // String that can be changed through the function of the logic contract
    string public words;

    // Change state variables in Proxy contract, selector: 0xc2985578
    function foo() public{
        words = "new";
    }
}
```

How to upgrade

- Deploy the `Logic2` contract
- Calling `upgrade()` of `SimpleUpgrade` with new address

This pattern has a problem of selector conflict and may cause security risks, thus introduce of `Transparent Proxy` and `UUPS`.

#### Chapter 48: Transparent Proxy

Selector Crash

- Function selector is the first 4 bytes of hash of a function, the limited variation of hash might cause crash of selector although those two functions are different in naming or parameters
- For example: `function mint(address,uint256)` and `function airdrop(address)` might have the same selector of `0x135b13c3`
- If proxy contract's upgrade function having selector crash with one of the function of logic contract, calling the function will upgrade the proxy contract to a black hole contract

Transparent Proxy Contract Demo

```
// FOR TEACHING PURPOSE ONLY, DO NOT USE IN PRODUCTION
contract TransparentProxy {
    // logic contract's address
    address implementation;
    // admin address
    address admin;
    // string variable, can be modified by calling loginc contract's function
    string public words;

    // constructor, initializing the admin address and logic contract's address
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback function, delegates function call to logic contract
    // can not be called by admin, to avoid causing unexpected beahvior due to selector clash
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // upgrade function, change logic contract's address, can only be called by admin
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}
```

- Transparent proxy solving the "selector clash" problem by restricting the admin's access to the logic contract.

#### Chapter 49: Universal Upgradeable Proxy Standard (UUPS)

UUPS have the upgrade function in the logic contract. And thus solved the selector crash between proxy and logic contract.

UUPS Proxy Contract Demo

```
contract UUPSProxy {
    // Address of the logic contract
    address public implementation;
    // Address of admin
    address public admin;
    // A string, which can be changed by the function of the logic contract
    string public words;

    // Constructor function, initialize admin and logic contract addresses
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // Fallback function delegates the call to the logic contract
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }
}
```

UUPS Logic Contract Demo

```
// UUPS logic contract(upgrade function inside logic contract)
contract UUPS1{
    // consistent with the proxy contract and prevent slot conflicts
    address public implementation;
    address public admin;
    // A string, which can be changed by the function of the logic contract
    string public words;

    // change state variable in proxy, selector: 0xc2985578
    function foo() public{
        words = "old";
    }

    // upgrade function, change logic contract's address, only admin is permitted to call. selector: 0x0900f010
    // in UUPS, logic contract HAS TO include a upgrade function, otherwise it cannot be upgraded any more.
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}

// new UUPS logic contract
contract UUPS2{
    // consistent with the proxy contract and prevent slot conflicts
    address public implementation;
    address public admin;
    // A string, which can be changed by the function of the logic contract
    string public words;

    // change state variable in proxy, selector: 0xc2985578
    function foo() public{
        words = "new";
    }

    // upgrade function, change logic contract's address, only admin is permitted to call. selector: 0x0900f010
    // in UUPS, logic contract HAS TO include a upgrade function, otherwise it cannot be upgraded any more.。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
```

When `admin` call `upgrade` through `UUPSProxy`, due to the nature of `delegatecall`, it carry the context of `UUPSProxy`, and the state variable `implementation` update to latest deployed address after verified `msg.sender` is same as `admin`.

#### Chapter 50: Multisignature Wallet

A smart contract wallet require authorization from multiple EOA to execute transactions

- Can prevent single point failure like loss of private keys, individual misbehaviour, etc
- [Safe](https://safe.global/) is widely used in Ethereum Ecosystem

Core features of Multisig wallet

1. Add signers and set signature threshold
2. Initiate transaction
3. Sign transaction
4. Execute transaction
5. Cancel/Invalidate transaction

Multisig Wallet Demo

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Multisig {
    address[] public owners; // multisig owners array
    mapping(address => bool) public isOwner; // check if an address is a multisig owner
    uint256 public ownerCount; // the count of multisig owners
    uint256 public threshold; // minimum number of signatures required for multisig execution
    uint256 public nonce; // nonce，prevent signature replay attack

    event ExecutionSuccess(bytes32 txHash); // succeeded transaction event
    event ExecutionFailure(bytes32 txHash); // failed transaction event

    constructor(address[] memory _owners, uint256 _threshold) {
        _setupOwners(_owners, _threshold);
    }

    /// @dev Initialize owners, isOwner, ownerCount, threshold
    /// @param _owners: Array of multisig owners
    /// @param _threshold: Minimum number of signatures required for multisig execution
    function _setupOwners(address[] memory _owners, uint256 _threshold)
        internal
    {
        // If threshold was not initialized
        require(threshold == 0, "WTF5000");
        // multisig execution threshold is less than the number of multisig owners
        require(_threshold <= _owners.length, "WTF5001");
        // multisig execution threshold is at least 1
        require(_threshold >= 1, "WTF5002");

        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            // multisig owners cannot be zero address, contract address, and cannot be repeated
            require(
                owner != address(0) &&
                    owner != address(this) &&
                    !isOwner[owner],
                "WTF5003"
            );
            owners.push(owner);
            isOwner[owner] = true;
        }
        ownerCount = _owners.length;
        threshold = _threshold;
    }

    /// @dev After collecting enough signatures from the multisig, execute transaction
    /// @param to Target contract address
    /// @param value msg.value, ether paid
    /// @param data calldata
    /// @param signatures packed signatures, corresponding to the multisig address in ascending order, for easy checking ({bytes32 r}{bytes32 s}{uint8 v}) (signature of the first multisig, signature of the second multisig...)
    function execTransaction(
        address to,
        uint256 value,
        bytes memory data,
        bytes memory signatures
    ) public payable virtual returns (bool success) {
        // Encode transaction data and compute hash
        bytes32 txHash = encodeTransactionData(
            to,
            value,
            data,
            nonce,
            block.chainid
        );
        // Increase nonce
        nonce++;
        // Check signatures
        checkSignatures(txHash, signatures);
        // Execute transaction using call and get transaction result
        (success, ) = to.call{value: value}(data);
        require(success, "WTF5004");
        if (success) emit ExecutionSuccess(txHash);
        else emit ExecutionFailure(txHash);
    }

    /**
     * @dev checks if the hash of the signature and transaction data matches. if signature is invalid, transaction will revert
     * @param dataHash hash of transaction data
     * @param signatures bundles multiple multisig signature together
     */
    function checkSignatures(bytes32 dataHash, bytes memory signatures)
        public
        view
    {
        // get multisig threshold
        uint256 _threshold = threshold;
        require(_threshold > 0, "WTF5005");

        // checks if signature length is enough
        require(signatures.length >= _threshold * 65, "WTF5006");

        // checks if collected signatures are valid
        // procedure:
        // 1. use ECDSA to verify if signatures are valid
        // 2. use currentOwner > lastOwner to make sure that signatures are from different multisig owners
        // 3. use isOwner[currentOwner] to make sure that current signature is from a multisig owner
        address lastOwner = address(0);
        address currentOwner;
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 i;
        for (i = 0; i < _threshold; i++) {
            (v, r, s) = signatureSplit(signatures, i);
            // use ECDSA to verify if signature is valid
            currentOwner = ecrecover(
                keccak256(
                    abi.encodePacked(
                        "\x19Ethereum Signed Message:\n32",
                        dataHash
                    )
                ),
                v,
                r,
                s
            );
            require(
                currentOwner > lastOwner && isOwner[currentOwner],
                "WTF5007"
            );
            lastOwner = currentOwner;
        }
    }

    /// split a single signature from a packed signature.
    /// @param signatures Packed signatures.
    /// @param pos Index of the multisig.
    function signatureSplit(bytes memory signatures, uint256 pos)
        internal
        pure
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        // signature format: {bytes32 r}{bytes32 s}{uint8 v}
        assembly {
            let signaturePos := mul(0x41, pos)
            r := mload(add(signatures, add(signaturePos, 0x20)))
            s := mload(add(signatures, add(signaturePos, 0x40)))
            v := and(mload(add(signatures, add(signaturePos, 0x41))), 0xff)
        }
    }

    /// @dev hash transaction data
    /// @param to target contract's address
    /// @param value msg.value eth to be paid
    /// @param data calldata
    /// @param _nonce nonce of the transaction
    /// @param chainid evm chain id
    /// @return bytes of transaction hash
    function encodeTransactionData(
        address to,
        uint256 value,
        bytes memory data,
        uint256 _nonce,
        uint256 chainid
    ) public pure returns (bytes32) {
        bytes32 safeTxHash = keccak256(
            abi.encode(to, value, keccak256(data), _nonce, chainid)
        );
        return safeTxHash;
    }
}
```

### 2024.10.12

#### Chapter 51: ERC4626 Tokenized Vault Standard

DeFi nowadays mostly worked across different protocols, from lending, swap, stake, stablecoin and more, we named it Lego. However there is still lack of interopability standard, ERC20 are widely used but not enough yet.

Token Vault

- Vault Contract is the basic layer of DeFi, it stored tokens and generate yield for owners
- Yield-farming: Yearn Finance
- Lending: AAVE
- Staking: Lido

ERC4626 Features

- Tokenization: ERC4626 inherit the ERC20, users receive ERC20-compliant Vault Shares after deposit asset to Vault, eg: ETH -> stETH in Lido
- Liquidity: Vault Shares can be trade freely without first redeem the underlying asset, eg: Swap stETH to USDC, ETH in UniSwap
- Composability: Reduce the friction to integrate other protocols using same set of interface

IERC4626

```// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (interfaces/IERC4626.sol)

pragma solidity ^0.8.20;

import {IERC20} from "../token/ERC20/IERC20.sol";
import {IERC20Metadata} from "../token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @dev Interface of the ERC-4626 "Tokenized Vault Standard", as defined in
 * https://eips.ethereum.org/EIPS/eip-4626[ERC-4626].
 */
interface IERC4626 is IERC20, IERC20Metadata {
    event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);

    event Withdraw(
        address indexed sender,
        address indexed receiver,
        address indexed owner,
        uint256 assets,
        uint256 shares
    );

    /**
     * @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
     *
     * - MUST be an ERC-20 token contract.
     * - MUST NOT revert.
     */
    function asset() external view returns (address assetTokenAddress);

    /**
     * @dev Returns the total amount of the underlying asset that is “managed” by Vault.
     *
     * - SHOULD include any compounding that occurs from yield.
     * - MUST be inclusive of any fees that are charged against assets in the Vault.
     * - MUST NOT revert.
     */
    function totalAssets() external view returns (uint256 totalManagedAssets);

    /**
     * @dev Returns the amount of shares that the Vault would exchange for the amount of assets provided, in an ideal
     * scenario where all the conditions are met.
     *
     * - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
     * - MUST NOT show any variations depending on the caller.
     * - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
     * - MUST NOT revert.
     *
     * NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
     * “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
     * from.
     */
    function convertToShares(uint256 assets) external view returns (uint256 shares);

    /**
     * @dev Returns the amount of assets that the Vault would exchange for the amount of shares provided, in an ideal
     * scenario where all the conditions are met.
     *
     * - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
     * - MUST NOT show any variations depending on the caller.
     * - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
     * - MUST NOT revert.
     *
     * NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
     * “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
     * from.
     */
    function convertToAssets(uint256 shares) external view returns (uint256 assets);

    /**
     * @dev Returns the maximum amount of the underlying asset that can be deposited into the Vault for the receiver,
     * through a deposit call.
     *
     * - MUST return a limited value if receiver is subject to some deposit limit.
     * - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of assets that may be deposited.
     * - MUST NOT revert.
     */
    function maxDeposit(address receiver) external view returns (uint256 maxAssets);

    /**
     * @dev Allows an on-chain or off-chain user to simulate the effects of their deposit at the current block, given
     * current on-chain conditions.
     *
     * - MUST return as close to and no more than the exact amount of Vault shares that would be minted in a deposit
     *   call in the same transaction. I.e. deposit should return the same or more shares as previewDeposit if called
     *   in the same transaction.
     * - MUST NOT account for deposit limits like those returned from maxDeposit and should always act as though the
     *   deposit would be accepted, regardless if the user has enough tokens approved, etc.
     * - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
     * - MUST NOT revert.
     *
     * NOTE: any unfavorable discrepancy between convertToShares and previewDeposit SHOULD be considered slippage in
     * share price or some other type of condition, meaning the depositor will lose assets by depositing.
     */
    function previewDeposit(uint256 assets) external view returns (uint256 shares);

    /**
     * @dev Mints shares Vault shares to receiver by depositing exactly amount of underlying tokens.
     *
     * - MUST emit the Deposit event.
     * - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
     *   deposit execution, and are accounted for during deposit.
     * - MUST revert if all of assets cannot be deposited (due to deposit limit being reached, slippage, the user not
     *   approving enough underlying tokens to the Vault contract, etc).
     *
     * NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
     */
    function deposit(uint256 assets, address receiver) external returns (uint256 shares);

    /**
     * @dev Returns the maximum amount of the Vault shares that can be minted for the receiver, through a mint call.
     * - MUST return a limited value if receiver is subject to some mint limit.
     * - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of shares that may be minted.
     * - MUST NOT revert.
     */
    function maxMint(address receiver) external view returns (uint256 maxShares);

    /**
     * @dev Allows an on-chain or off-chain user to simulate the effects of their mint at the current block, given
     * current on-chain conditions.
     *
     * - MUST return as close to and no fewer than the exact amount of assets that would be deposited in a mint call
     *   in the same transaction. I.e. mint should return the same or fewer assets as previewMint if called in the
     *   same transaction.
     * - MUST NOT account for mint limits like those returned from maxMint and should always act as though the mint
     *   would be accepted, regardless if the user has enough tokens approved, etc.
     * - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
     * - MUST NOT revert.
     *
     * NOTE: any unfavorable discrepancy between convertToAssets and previewMint SHOULD be considered slippage in
     * share price or some other type of condition, meaning the depositor will lose assets by minting.
     */
    function previewMint(uint256 shares) external view returns (uint256 assets);

    /**
     * @dev Mints exactly shares Vault shares to receiver by depositing amount of underlying tokens.
     *
     * - MUST emit the Deposit event.
     * - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the mint
     *   execution, and are accounted for during mint.
     * - MUST revert if all of shares cannot be minted (due to deposit limit being reached, slippage, the user not
     *   approving enough underlying tokens to the Vault contract, etc).
     *
     * NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
     */
    function mint(uint256 shares, address receiver) external returns (uint256 assets);

    /**
     * @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
     * Vault, through a withdraw call.
     *
     * - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
     * - MUST NOT revert.
     */
    function maxWithdraw(address owner) external view returns (uint256 maxAssets);

    /**
     * @dev Allows an on-chain or off-chain user to simulate the effects of their withdrawal at the current block,
     * given current on-chain conditions.
     *
     * - MUST return as close to and no fewer than the exact amount of Vault shares that would be burned in a withdraw
     *   call in the same transaction. I.e. withdraw should return the same or fewer shares as previewWithdraw if
     *   called
     *   in the same transaction.
     * - MUST NOT account for withdrawal limits like those returned from maxWithdraw and should always act as though
     *   the withdrawal would be accepted, regardless if the user has enough shares, etc.
     * - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
     * - MUST NOT revert.
     *
     * NOTE: any unfavorable discrepancy between convertToShares and previewWithdraw SHOULD be considered slippage in
     * share price or some other type of condition, meaning the depositor will lose assets by depositing.
     */
    function previewWithdraw(uint256 assets) external view returns (uint256 shares);

    /**
     * @dev Burns shares from owner and sends exactly assets of underlying tokens to receiver.
     *
     * - MUST emit the Withdraw event.
     * - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
     *   withdraw execution, and are accounted for during withdraw.
     * - MUST revert if all of assets cannot be withdrawn (due to withdrawal limit being reached, slippage, the owner
     *   not having enough shares, etc).
     *
     * Note that some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
     * Those methods should be performed separately.
     */
    function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);

    /**
     * @dev Returns the maximum amount of Vault shares that can be redeemed from the owner balance in the Vault,
     * through a redeem call.
     *
     * - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
     * - MUST return balanceOf(owner) if owner is not subject to any withdrawal limit or timelock.
     * - MUST NOT revert.
     */
    function maxRedeem(address owner) external view returns (uint256 maxShares);

    /**
     * @dev Allows an on-chain or off-chain user to simulate the effects of their redeemption at the current block,
     * given current on-chain conditions.
     *
     * - MUST return as close to and no more than the exact amount of assets that would be withdrawn in a redeem call
     *   in the same transaction. I.e. redeem should return the same or more assets as previewRedeem if called in the
     *   same transaction.
     * - MUST NOT account for redemption limits like those returned from maxRedeem and should always act as though the
     *   redemption would be accepted, regardless if the user has enough shares, etc.
     * - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
     * - MUST NOT revert.
     *
     * NOTE: any unfavorable discrepancy between convertToAssets and previewRedeem SHOULD be considered slippage in
     * share price or some other type of condition, meaning the depositor will lose assets by redeeming.
     */
    function previewRedeem(uint256 shares) external view returns (uint256 assets);

    /**
     * @dev Burns exactly shares from owner and sends assets of underlying tokens to receiver.
     *
     * - MUST emit the Withdraw event.
     * - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
     *   redeem execution, and are accounted for during redeem.
     * - MUST revert if all of shares cannot be redeemed (due to withdrawal limit being reached, slippage, the owner
     *   not having enough shares, etc).
     *
     * NOTE: some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
     * Those methods should be performed separately.
     */
    function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);
}
```

ERC4626 Demo

```
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/ERC4626.sol)

pragma solidity ^0.8.20;

import {IERC20, IERC20Metadata, ERC20} from "../ERC20.sol";
import {SafeERC20} from "../utils/SafeERC20.sol";
import {IERC4626} from "../../../interfaces/IERC4626.sol";
import {Math} from "../../../utils/math/Math.sol";

abstract contract ERC4626 is ERC20, IERC4626 {
    using Math for uint256;

    IERC20 private immutable _asset;
    uint8 private immutable _underlyingDecimals;

    /**
     * @dev Attempted to deposit more assets than the max amount for `receiver`.
     */
    error ERC4626ExceededMaxDeposit(address receiver, uint256 assets, uint256 max);

    /**
     * @dev Attempted to mint more shares than the max amount for `receiver`.
     */
    error ERC4626ExceededMaxMint(address receiver, uint256 shares, uint256 max);

    /**
     * @dev Attempted to withdraw more assets than the max amount for `receiver`.
     */
    error ERC4626ExceededMaxWithdraw(address owner, uint256 assets, uint256 max);

    /**
     * @dev Attempted to redeem more shares than the max amount for `receiver`.
     */
    error ERC4626ExceededMaxRedeem(address owner, uint256 shares, uint256 max);

    /**
     * @dev Set the underlying asset contract. This must be an ERC20-compatible contract (ERC-20 or ERC-777).
     */
    constructor(IERC20 asset_) {
        (bool success, uint8 assetDecimals) = _tryGetAssetDecimals(asset_);
        _underlyingDecimals = success ? assetDecimals : 18;
        _asset = asset_;
    }

    /**
     * @dev Attempts to fetch the asset decimals. A return value of false indicates that the attempt failed in some way.
     */
    function _tryGetAssetDecimals(IERC20 asset_) private view returns (bool ok, uint8 assetDecimals) {
        (bool success, bytes memory encodedDecimals) = address(asset_).staticcall(
            abi.encodeCall(IERC20Metadata.decimals, ())
        );
        if (success && encodedDecimals.length >= 32) {
            uint256 returnedDecimals = abi.decode(encodedDecimals, (uint256));
            if (returnedDecimals <= type(uint8).max) {
                return (true, uint8(returnedDecimals));
            }
        }
        return (false, 0);
    }

    /**
     * @dev Decimals are computed by adding the decimal offset on top of the underlying asset's decimals. This
     * "original" value is cached during construction of the vault contract. If this read operation fails (e.g., the
     * asset has not been created yet), a default of 18 is used to represent the underlying asset's decimals.
     *
     * See {IERC20Metadata-decimals}.
     */
    function decimals() public view virtual override(IERC20Metadata, ERC20) returns (uint8) {
        return _underlyingDecimals + _decimalsOffset();
    }

    /** @dev See {IERC4626-asset}. */
    function asset() public view virtual returns (address) {
        return address(_asset);
    }

    /** @dev See {IERC4626-totalAssets}. */
    function totalAssets() public view virtual returns (uint256) {
        return _asset.balanceOf(address(this));
    }

    /** @dev See {IERC4626-convertToShares}. */
    function convertToShares(uint256 assets) public view virtual returns (uint256) {
        return _convertToShares(assets, Math.Rounding.Floor);
    }

    /** @dev See {IERC4626-convertToAssets}. */
    function convertToAssets(uint256 shares) public view virtual returns (uint256) {
        return _convertToAssets(shares, Math.Rounding.Floor);
    }

    /** @dev See {IERC4626-maxDeposit}. */
    function maxDeposit(address) public view virtual returns (uint256) {
        return type(uint256).max;
    }

    /** @dev See {IERC4626-maxMint}. */
    function maxMint(address) public view virtual returns (uint256) {
        return type(uint256).max;
    }

    /** @dev See {IERC4626-maxWithdraw}. */
    function maxWithdraw(address owner) public view virtual returns (uint256) {
        return _convertToAssets(balanceOf(owner), Math.Rounding.Floor);
    }

    /** @dev See {IERC4626-maxRedeem}. */
    function maxRedeem(address owner) public view virtual returns (uint256) {
        return balanceOf(owner);
    }

    /** @dev See {IERC4626-previewDeposit}. */
    function previewDeposit(uint256 assets) public view virtual returns (uint256) {
        return _convertToShares(assets, Math.Rounding.Floor);
    }

    /** @dev See {IERC4626-previewMint}. */
    function previewMint(uint256 shares) public view virtual returns (uint256) {
        return _convertToAssets(shares, Math.Rounding.Ceil);
    }

    /** @dev See {IERC4626-previewWithdraw}. */
    function previewWithdraw(uint256 assets) public view virtual returns (uint256) {
        return _convertToShares(assets, Math.Rounding.Ceil);
    }

    /** @dev See {IERC4626-previewRedeem}. */
    function previewRedeem(uint256 shares) public view virtual returns (uint256) {
        return _convertToAssets(shares, Math.Rounding.Floor);
    }

    /** @dev See {IERC4626-deposit}. */
    function deposit(uint256 assets, address receiver) public virtual returns (uint256) {
        uint256 maxAssets = maxDeposit(receiver);
        if (assets > maxAssets) {
            revert ERC4626ExceededMaxDeposit(receiver, assets, maxAssets);
        }

        uint256 shares = previewDeposit(assets);
        _deposit(_msgSender(), receiver, assets, shares);

        return shares;
    }

    /** @dev See {IERC4626-mint}. */
    function mint(uint256 shares, address receiver) public virtual returns (uint256) {
        uint256 maxShares = maxMint(receiver);
        if (shares > maxShares) {
            revert ERC4626ExceededMaxMint(receiver, shares, maxShares);
        }

        uint256 assets = previewMint(shares);
        _deposit(_msgSender(), receiver, assets, shares);

        return assets;
    }

    /** @dev See {IERC4626-withdraw}. */
    function withdraw(uint256 assets, address receiver, address owner) public virtual returns (uint256) {
        uint256 maxAssets = maxWithdraw(owner);
        if (assets > maxAssets) {
            revert ERC4626ExceededMaxWithdraw(owner, assets, maxAssets);
        }

        uint256 shares = previewWithdraw(assets);
        _withdraw(_msgSender(), receiver, owner, assets, shares);

        return shares;
    }

    /** @dev See {IERC4626-redeem}. */
    function redeem(uint256 shares, address receiver, address owner) public virtual returns (uint256) {
        uint256 maxShares = maxRedeem(owner);
        if (shares > maxShares) {
            revert ERC4626ExceededMaxRedeem(owner, shares, maxShares);
        }

        uint256 assets = previewRedeem(shares);
        _withdraw(_msgSender(), receiver, owner, assets, shares);

        return assets;
    }

    /**
     * @dev Internal conversion function (from assets to shares) with support for rounding direction.
     */
    function _convertToShares(uint256 assets, Math.Rounding rounding) internal view virtual returns (uint256) {
        return assets.mulDiv(totalSupply() + 10 ** _decimalsOffset(), totalAssets() + 1, rounding);
    }

    /**
     * @dev Internal conversion function (from shares to assets) with support for rounding direction.
     */
    function _convertToAssets(uint256 shares, Math.Rounding rounding) internal view virtual returns (uint256) {
        return shares.mulDiv(totalAssets() + 1, totalSupply() + 10 ** _decimalsOffset(), rounding);
    }

    /**
     * @dev Deposit/mint common workflow.
     */
    function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal virtual {
        // If _asset is ERC-777, `transferFrom` can trigger a reentrancy BEFORE the transfer happens through the
        // `tokensToSend` hook. On the other hand, the `tokenReceived` hook, that is triggered after the transfer,
        // calls the vault, which is assumed not malicious.
        //
        // Conclusion: we need to do the transfer before we mint so that any reentrancy would happen before the
        // assets are transferred and before the shares are minted, which is a valid state.
        // slither-disable-next-line reentrancy-no-eth
        SafeERC20.safeTransferFrom(_asset, caller, address(this), assets);
        _mint(receiver, shares);

        emit Deposit(caller, receiver, assets, shares);
    }

    /**
     * @dev Withdraw/redeem common workflow.
     */
    function _withdraw(
        address caller,
        address receiver,
        address owner,
        uint256 assets,
        uint256 shares
    ) internal virtual {
        if (caller != owner) {
            _spendAllowance(owner, caller, shares);
        }

        // If _asset is ERC-777, `transfer` can trigger a reentrancy AFTER the transfer happens through the
        // `tokensReceived` hook. On the other hand, the `tokensToSend` hook, that is triggered before the transfer,
        // calls the vault, which is assumed not malicious.
        //
        // Conclusion: we need to do the transfer after the burn so that any reentrancy would happen after the
        // shares are burned and after the assets are transferred, which is a valid state.
        _burn(owner, shares);
        SafeERC20.safeTransfer(_asset, receiver, assets);

        emit Withdraw(caller, receiver, owner, assets, shares);
    }

    function _decimalsOffset() internal view virtual returns (uint8) {
        return 0;
    }
}
```

#### Chapter 52: EIP712 Typed structured data hashing and signing

EIP712 introduce a structured signature for complex data

- Security: User can see clearly the data type and values instead of a hash of data

Off-chain signature

```
// Compulsory field
EIP712Domain: [
    { name: "name", type: "string" },
    { name: "version", type: "string" },
    { name: "chainId", type: "uint256" },
    { name: "verifyingContract", type: "address" },
]

// Data structure to sign
const types = {
    Storage: [
        { name: "spender", type: "address" },
        { name: "number", type: "uint256" },
    ],
};

// Data sample
const domain = {
    name: "EIP712Storage",
    version: "1",
    chainId: "1",
    verifyingContract: "0xf8e81D47203A594245E36C48e151709F0C19fBe8",
};
const types = {
    Storage: [
        { name: "spender", type: "address" },
        { name: "number", type: "uint256" },
    ],
};
const message = {
    spender: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    number: "100",
};

// Sign with Javascript library/Wallet extension
const provider = new ethers.BrowserProvider(window.ethereum);
const signature = await signer.signTypedData(domain, types, message);
console.log("Signature:", signature);
```

On-chain signature verification

```
// SPDX-License-Identifier: MIT
// By 0xAA
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EIP712Storage {
    using ECDSA for bytes32;

    bytes32 private constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
    bytes32 private constant STORAGE_TYPEHASH = keccak256("Storage(address spender,uint256 number)");
    bytes32 private DOMAIN_SEPARATOR;
    uint256 number;
    address owner;

    constructor(){
        DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH, // type hash
            keccak256(bytes("EIP712Storage")), // name
            keccak256(bytes("1")), // version
            block.chainid, // chain id
            address(this) // contract address
        ));
        owner = msg.sender;
    }

    /**
     * @dev Store value in variable after verified the signature
     */
    function permitStore(uint256 _num, bytes memory _signature) public {
        require(_signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(_signature, 0x20))
            s := mload(add(_signature, 0x40))
            v := byte(0, mload(add(_signature, 0x60)))
        }

        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(STORAGE_TYPEHASH, msg.sender, _num))
        ));

        address signer = digest.recover(v, r, s);
        require(signer == owner, "EIP712Storage: Invalid signature");

        number = _num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}
```

This standard is widely used nowadays, in Metamask and dApps to secure user's assets.

#### Chapter 53: ERC2612 ERC20Permit

An extension to ERC20 to support permit signature

- Allow user to create a signature for an action, eg: Approve other address to spend an amount of ERC20
- The signature can also send to 3rd party to perform other action
- Reduce transaction cost, it is significant especially when gas is high

IERC20Permit

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC-20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[ERC-2612].
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens, given ``owner``'s signed approval.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be included whenever a signature is generated for {permit}.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}
```

ERC20Permit

```
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/ERC20Permit.sol)

pragma solidity ^0.8.20;

import {IERC20Permit} from "./IERC20Permit.sol";
import {ERC20} from "../ERC20.sol";
import {ECDSA} from "../../../utils/cryptography/ECDSA.sol";
import {EIP712} from "../../../utils/cryptography/EIP712.sol";
import {Nonces} from "../../../utils/Nonces.sol";

/**
 * @dev Implementation of the ERC-20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[ERC-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC-20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on `{IERC20-approve}`, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
contract ERC20Permit is ERC20, IERC20Permit, EIP712, Nonces {
    bytes32 private constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    /**
     * @dev Permit deadline has expired.
     */
    error ERC2612ExpiredSignature(uint256 deadline);

    /**
     * @dev Mismatched signature.
     */
    error ERC2612InvalidSigner(address signer, address owner);

    /**
     * @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
     *
     * It's a good idea to use the same `name` that is defined as the ERC-20 token name.
     */
    constructor(string memory name, string memory symbol) EIP712(name, "1") ERC20(name, symbol){}

    /**
     * @inheritdoc IERC20Permit
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual {
        if (block.timestamp > deadline) {
            revert ERC2612ExpiredSignature(deadline);
        }

        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));

        bytes32 hash = _hashTypedDataV4(structHash);

        address signer = ECDSA.recover(hash, v, r, s);
        if (signer != owner) {
            revert ERC2612InvalidSigner(signer, owner);
        }

        _approve(owner, spender, value);
    }

    /**
     * @inheritdoc IERC20Permit
     */
    function nonces(address owner) public view virtual override(IERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

    /**
     * @inheritdoc IERC20Permit
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view virtual returns (bytes32) {
        return _domainSeparatorV4();
    }
}
```

Safety Note

- ERC20Permit uses off-chain signatures for authorization, which brings convenience to users, but also brings risks. Some hackers will use this feature to conduct phishing attacks, defraud users of signatures and steal assets
- Some contracts will also bring the risk of DoS (denial of service) when integrating permit. Because permit will use up the current nonce value when executing, if the contract function contains permit operations, the attacker can execute permit by preemptively running, causing the target transaction to roll back because the nonce is occupied

### 2024.10.13

#### Chapter 54: Bridge

Bridge allow assets to transfer from origin chain to destination chain, eg from Ethereum Mainnet to Optimism Mainnet.

3 types of bridge architecture:

- Burn/Mint: The assets burnt on origin chain and minting in destination chain. The protocol need the minting permission for the action
- Stake/Mint: The assets staked on origin chain and minting a wrapped version or value-equivalent token in destination chain. It is convinient for protocol with limited permission but risky, the value on destination chain may effect if origin assets hacked
- Stake/Unstake: The assets staked on origin chain and release in destination chain. It require the assets to stored in both chain, need liquidity support

Burn/Mint Bridge Demo

- Deploy ERC20 with burn and mint function on both chain

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CrossChainToken is ERC20, Ownable {

    // Bridge event
    event Bridge(address indexed user, uint256 amount);
    // Mint event
    event Mint(address indexed to, uint256 amount);

    /**
     * @param name Token Name
     * @param symbol Token Symbol
     * @param totalSupply Token Supply
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply
    ) payable ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, totalSupply);
    }

    /**
     * Bridge function
     * @param amount: burn amount of token on the current chain and mint on the other chain
     */
    function bridge(uint256 amount) public {
        _burn(msg.sender, amount);
        emit Bridge(msg.sender, amount);
    }

    /**
     * Mint function
     */
    function mint(address to, uint amount) external onlyOwner {
        _mint(to, amount);
        emit  Mint(to, amount);
    }
}
```

- A script/app on server listening to token events

```
import { ethers } from "ethers";

// Initialize provider of both chains
const providerGoerli = new ethers.JsonRpcProvider("Goerli_Provider_URL");
const providerSepolia = new ethers.JsonRpcProvider("Sepolia_Provider_URL");

// Contract owner with bridge/mint permission
const privateKey = "Your_Key";
const walletGoerli = new ethers.Wallet(privateKey, providerGoerli);
const walletSepolia = new ethers.Wallet(privateKey, providerSepolia);

// Contract address and ABI
const contractAddressGoerli = "address";
const contractAddressSepolia = "address";

const abi = [
    "event Bridge(address indexed user, uint256 amount)",
    "function bridge(uint256 amount) public",
    "function mint(address to, uint amount) external",
];

const contractGoerli = new ethers.Contract(contractAddressGoerli, abi, walletGoerli);
const contractSepolia = new ethers.Contract(contractAddressSepolia, abi, walletSepolia);

const main = async () => {
    try{
        console.log(`Listening to token events`)

        // Listening to Bridge event of token on Sepolia
        contractSepolia.on("Bridge", async (user, amount) => {
            console.log(`Bridge event on Chain Sepolia: User ${user} burned ${amount} tokens`);

            // Response to Bridge event and mint token
            let tx = await contractGoerli.mint(user, amount);
            await tx.wait();

            console.log(`Minted ${amount} tokens to ${user} on Chain Goerli`);
        });

        // Listening to Bridge event of token on Goerli
        contractGoerli.on("Bridge", async (user, amount) => {
            console.log(`Bridge event on Chain Goerli: User ${user} burned ${amount} tokens`);

            let tx = await contractSepolia.mint(user, amount);
            await tx.wait();

            console.log(`Minted ${amount} tokens to ${user} on Chain Sepolia`);
        });
    } catch(e) {
        console.log(e);
    }
}

main();
```

Bridges are the most attacked protocol in the decentralized system. Never trust any bridge protocols, limit the token allowance or revoke approval after each use.

### 2024.10.14

#### Chapter 55: Multicall

`multicall` refer to execute multiple functions in single transaction
Benefits:

- Convenience: Perform multiple action once instead of waiting for previous transaction to execute successfully
- Gas saving: Reduce execution cost, reduce some steps during computation
- Atomic operation: `multicall` can ensure transaction integrity; the transaction is successful if only all functions call success. If any of the function calls fail, the transaction will be reverted

Multicall Contract Demo

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Multicall {
    // Call structure: Target address, allow of failure, encoded call data
    struct Call {
        address target;
        bool allowFailure;
        bytes callData;
    }

    // Result structure
    struct Result {
        bool success;
        bytes returnData;
    }

    function multicall(Call[] calldata calls) public returns (Result[] memory returnData) {
        uint256 length = calls.length;
        returnData = new Result[](length);
        Call calldata calli;

        // Loop and intepret each call
        for (uint256 i = 0; i < length; i++) {
            Result memory result = returnData[i];
            calli = calls[i];
            (result.success, result.returnData) = calli.target.call(calli.callData);
            // If calli.allowFailure and result.success are false，revert it
            if (!(calli.allowFailure || result.success)){
                revert("Multicall: call failed");
            }
        }
    }
}
```

#### Chapter 56: Decentralized Exchange

Automated Market Maker (AMM) is the most used algorithm in decentralized exchange

- Eliminate the need of order book (Sell order, Buy order)
- Require Liquidity Provider (LP) to provide initial fund of two or more tokens and set the ratio according to assets value

Constant Sum Automated Market Maker (CSAMM)

- Formula: `x + y = k`
- Ensure that the relative price of tokens remains unchanged, which is very important in stablecoin exchange
- The liquidity can easily exchausted if the exchange amount near to liquidity pool amount

Constant Product Automated Market Maker (CPAMM)

- Formula: `x * y = k`
- Ensure the constant remain unchanged
- Almost infinite liquidity as the relative price of token change linearly

DEX Demo

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleSwap is ERC20 {
    // Address of tokens
    IERC20 public token0;
    IERC20 public token1;

    // Token amount stored
    uint public reserve0;
    uint public reserve1;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1);
    event Swap(
        address indexed sender,
        uint amountIn,
        address tokenIn,
        uint amountOut,
        address tokenOut
        );

    constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
        token0 = _token0;
        token1 = _token1;
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    // Compute the square root (Babylonian method)
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    // Adding liquidity, transfer the specific amount of both token, mint LP token
    // First time adding, LP amount = sqrt(amount0 * amount1)
    // Or else, LP amount = min(amount0/reserve0, amount1/reserve1)* totalSupply_LP
    // @param amount0Desired token0 amount
    // @param amount1Desired token1 amount
    function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
        token0.transferFrom(msg.sender, address(this), amount0Desired);
        token1.transferFrom(msg.sender, address(this), amount1Desired);

        uint _totalSupply = totalSupply();
        if (_totalSupply == 0) {
            liquidity = sqrt(amount0Desired * amount1Desired);
        } else {
            liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);
        }

        require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

        // Update reserved token amount
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        _mint(msg.sender, liquidity);

        emit Mint(msg.sender, amount0Desired, amount1Desired);
    }

    // Remove liquidity, burn LP token, redeem tokens
    // Tokens amount = (liquidity / totalSupply_LP) * reserve
    // @param liquidity LP amount
    function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
        uint balance0 = token0.balanceOf(address(this));
        uint balance1 = token1.balanceOf(address(this));

        uint _totalSupply = totalSupply();
        amount0 = liquidity * balance0 / _totalSupply;
        amount1 = liquidity * balance1 / _totalSupply;

        require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');

        _burn(msg.sender, liquidity);
        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        emit Burn(msg.sender, amount0, amount1);
    }

    // Calculate the amount of another token to exchange
    // Before swap: k = x * y
    // After swap: k = (x + delta_x) * (y + delta_y)
    // delta_y = - delta_x * y / (x + delta_x)
    // Positive/Negative represent transfer in/out
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
        require(amountIn > 0, 'INSUFFICIENT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
        amountOut = amountIn * reserveOut / (reserveIn + amountIn);
    }

    // Swap token
    // @param amountIn Amount to exchange
    // @param tokenIn Token to exchange with
    // @param amountOutMin Minimum amount to exchange of another token
    function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
        require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
        require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');

        uint balance0 = token0.balanceOf(address(this));
        uint balance1 = token1.balanceOf(address(this));

        if(tokenIn == token0){
            tokenOut = token1;
            amountOut = getAmountOut(amountIn, balance0, balance1);
            require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');

            tokenIn.transferFrom(msg.sender, address(this), amountIn);
            tokenOut.transfer(msg.sender, amountOut);
        }else{
            tokenOut = token0;
            amountOut = getAmountOut(amountIn, balance1, balance0);
            require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');

            tokenIn.transferFrom(msg.sender, address(this), amountIn);
            tokenOut.transfer(msg.sender, amountOut);
        }

        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
    }
}
```

This DEX demo are simplified version without considering fee and security feature.

#### Chapter 57: Flashloan

Flashloan is an example of `multicall`, an atomic operation, where the borrow and pay back of asset and interest in single transaction without the need of collateral.

- Usually have beneficial action between borrow and pay back
- The transaction will be reverted if pay back failed
- Protocol have no risk like bad debt

Flashloan with Uniswap V3 Demo

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract UniswapV3Flash {
    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address caller;
    }

    IUniswapV3Pool private immutable pool;
    IERC20 private immutable token0;
    IERC20 private immutable token1;

    constructor(address _pool) {
        pool = IUniswapV3Pool(_pool);
        token0 = IERC20(pool.token0());
        token1 = IERC20(pool.token1());
    }

    function flash(uint256 amount0, uint256 amount1) external {
        bytes memory data = abi.encode(
            FlashCallbackData({
                amount0: amount0,
                amount1: amount1,
                caller: msg.sender
            })
        );
        IUniswapV3Pool(pool).flash(address(this), amount0, amount1, data);
    }

    function uniswapV3FlashCallback(
        // Pool fee x amount requested
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external {
        require(msg.sender == address(pool), "not authorized");

        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));

        // Write custom code here
        if (fee0 > 0) {
            token0.transferFrom(decoded.caller, address(this), fee0);
        }
        if (fee1 > 0) {
            token1.transferFrom(decoded.caller, address(this), fee1);
        }

        // Repay borrow
        if (fee0 > 0) {
            token0.transfer(address(pool), decoded.amount0 + fee0);
        }
        if (fee1 > 0) {
            token1.transfer(address(pool), decoded.amount1 + fee1);
        }
    }
}

interface IUniswapV3Pool {
    function token0() external view returns (address);
    function token1() external view returns (address);
    function flash(
        address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool);
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}
```

Test with Foundry

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import "../../../src/defi/uniswap-v3-flash/UniswapV3Flash.sol";

contract UniswapV3FlashTest is Test {
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // DAI / WETH 0.3% fee
    address constant POOL = 0xC2e9F25Be6257c210d7Adf0D4Cd6E3E881ba25f8;
    uint24 constant POOL_FEE = 3000;

    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);
    UniswapV3Flash private uni;
    address constant user = address(11);

    function setUp() public {
        uni = new UniswapV3Flash(POOL);

        deal(DAI, user, 1e6 * 1e18);
        vm.prank(user);
        dai.approve(address(uni), type(uint256).max);
    }

    function test_flash() public {
        uint256 dai_before = dai.balanceOf(user);
        vm.prank(user);
        uni.flash(1e6 * 1e18, 0);
        uint256 dai_after = dai.balanceOf(user);

        uint256 fee = dai_before - dai_after;
        console2.log("DAI fee", fee);
    }
}

```

Flashloan with AAVE V3 Demo

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

interface IFlashLoanSimpleReceiver {
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool);
}

contract AaveV3Flashloan {
    address private constant AAVE_V3_POOL =
        0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    ILendingPool public aave;

    constructor() {
        aave = ILendingPool(AAVE_V3_POOL);
    }

    function flashloan(uint256 wethAmount) external {
        aave.flashLoanSimple(address(this), WETH, wethAmount, "", 0);
    }

    // Flashloan fallback, call by AAVE pool only
    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata)
        external
        returns (bool)
    {
        require(msg.sender == AAVE_V3_POOL, "not authorized");
        require(initiator == address(this), "invalid initiator");

        uint fee = (amount * 5) / 10000 + 1;
        uint amountToRepay = amount + fee;

        IERC20(WETH).approve(AAVE_V3_POOL, amountToRepay);

        return true;
    }
}
```

Test with Foundry

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/AaveV3Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV2FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    AaveV3Flashloan private flashloan;

    function setUp() public {
        flashloan = new AaveV3Flashloan();
    }

    function testFlashloan() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);

        uint amountToBorrow = 100 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    function testFlashloanFail() public {
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 4e16);

        uint amountToBorrow = 100 * 1e18;
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
```

Flashloan is widely used in risk-free arbitrage and vulnerability attacks.

End of WTF Solidity 103

### 2024.10.15

#### Ethers.js 101: Interaction with Ethereum

[ethers](https://docs.ethers.org/) is a complete and compact open-source javascript library for interacting with the EVM. The usage has surpass the `web3.js` for a few reasons:

- `ethers` take 116.5 kB while `web3.js` take 590.5 kB
- `ethers` have `Provider` class to manage network connectivity, `Wallet` classs to manage private keys, more flexible
- Native support for Ethereum Name Service (ENS)

Installation
`npm install ethers --save`

Check address balance

```
import { ethers } from "ethers";
const provider = ethers.getDefaultProvider(); // To use specific RPC: ethers.JsonRpcProvider(RPC_URL);
const main = async () => {
    const balance = await provider.getBalance(`vitalik.eth`); // Address or ENS
    console.log(`ETH Balance of vitalik: ${ethers.formatEther(balance)} ETH`);
}
main();
```

Provider class

`jsonRpcProvider` allow users to connect to a specific node service provider

- [ChainList](https://chainlist.org/) have the most comprehensive collections of Chains and RPCs
- Alchemy

```
const ALCHEMY_MAINNET_URL = 'https://eth-mainnet.g.alchemy.com/v2/API_KEY';
const providerETH = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);
const balance = await providerETH.getBalance(`vitalik.eth`);;
const network = await providerETH.getNetwork(); // Retrieve network info
const feeData = await providerETH.getFeeData(); // Retrieve current gas data
const code = await providerETH.getCode("0xc778417e063141139fce010982780140aa0cd5ab"); // Retrieve bytecode of contract
```

Contract class

Read only

```
const contract = new ethers.Contract(contractAddress, contractAbi, provider);
```

Read and write contract

```
const contract = new ethers.Contract(contractAddress, contractAbi, signer);
```

Example of Read/Write WETH Contract

```
const mnemonic = "announce room limb pattern dry unit scale effort smooth jazz weasel alcohol";
const wallet = Wallet.fromMnemonic(mnemonic);

const wethMainnet = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2";
const wethAbi = [
    "function deposit() payable",
    "function totalSupply() view returns (uint)"
];
const weth = new ethers.Contract(wethMainnet, wethAbi, wallet);

await weth.deposit({value: parseEther("1")}); // Wrap 1 ETH to 1 WETH
const totalSupply = await weth.totalSupply(); // Retrieve current supply of WETH
```

Signer class and Wallet class

- `Signer` class is an abstraction of an Ethereum account for signing messages and transactions, but `Signer` class is an abstract class and cannot be instantiated directly, so `Wallet` class which inherits from the `Signer` class is using as above example.

```
const walletRnd = ethers.Wallet.createRandom(); // Create wallet with random private key
const walletPk = new ethers.Wallet(pkString); // Create wallet with known private key
const walletMmn = ethers.Wallet.fromMnemonic(mnemonicString); // Create wallet with mnemonic phrase BIP39
```

Sending transaction

```
const wallet = new ethers.Wallet(pkString, provider);
const receipt = await wallet.sendTransaction({
        to: recipientAddress,
        value: ethers.parseEther("1")
    }); // Transfer 1 ETH to recipient
await receipt.wait() // Wait for the transaction to be confirmed on the chain
console.log(receipt) // Print the transaction details
```

Deploy Contract Demo

```
const abiERC20 = [
    "constructor(string memory name_, string memory symbol_)",
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function totalSupply() view returns (uint256)",
    "function balanceOf(address) view returns (uint)",
    "function transfer(address to, uint256 amount) external returns (bool)",
    "event Transfer(address indexed from, address indexed to, uint256 amount)"
];
const bytecodeERC20 = "608060405260646000553480156100...";
const factoryERC20 = new ethers.ContractFactory(abiERC20, bytecodeERC20, wallet);
const contractERC20 = await factoryERC20.deploy("WTF Token", "WTF");
await contractERC20.waitForDeployment(); // Wait for the transaction to be confirmed on the chain

await contractERC20.name(); // Retrieve ERC20 info after contract deployed
await contractERC20.symbol();
```

Event

- Events emitted by smart contracts are stored in the logs of the Ethereum virtual machine.

Retrieving events

```
const endingBlock = await provider.getBlockNumber();
const startingBlock = endingBlock - 10;
const transferEvents = await contractERC20.queryFilter("Transfer", startingBlock, endingBlock); // Retrieve Transfer event within the 10 blocks
```

Listening events

```
contractERC20.on("Transfer", (from, to, value) => {
    console.log(from, to, value)
}); // Continuosly listening every Transfer event of contractERC20

contractERC20.on("Transfer", (from, to, value) => {
    console.log(from, to, value)
}); // Listen just once
```

Event filtering

- When a contract emits a log (fires an event), it can contain up to 4 indexed items. These indexed data items are hashed and included in a Bloom filter, which is a data structure that allows for efficient filtering

```
// event Transfer(address indexed from, address indexed to, uint256 amount)

contractERC20.filters.Transfer(myAddress); // Retrieve only transfer from myAddress

contractERC20.filters.Transfer(null, myAddress); // Retrieve only transfer to myAddress

contractERC20.filters.Transfer(myAddress, otherAddress); // Retrieve only transfer from myAddress to otherAddress

contractERC20.filters.Transfer(null, [myAddress, otherAddress]); // Retrieve only transfer to myAddress or otherAddress
```

Unit conversion

- In Ethereum, the most used integer variables (`uint256`) are exceed the safe range of JavaScript integers. Thus, `Ethers` use BigInt class to securely perform the mathematical operations.

```
const bigint_one = 1n;
const oneWei = ethers.getBigInt("1");
console.log(bigint_one == oneWei); // True

const oneGwei = ethers.getBigInt("1000000000");
console.log(ethers.formatUnits(oneGwei, 0)); // '1000000000' wei
console.log(ethers.formatUnits(oneGwei, "gwei")); // '1.0' gwei
console.log(ethers.formatUnits(oneGwei, 9)); // '1.0' gwei
console.log(ethers.formatUnits(oneGwei, "ether")); // '0.000000001' eth
console.log(ethers.formatUnits(1000000000, "gwei")); // '1.0' eth
console.log(ethers.formatEther(oneGwei)); // '0.000000001' eth, equivalent to formatUnits(value, "ether")

console.log(ethers.parseUnits("1.0").toString()); // { BigNumber: "1000000000000000000" } wei
console.log(ethers.parseUnits("1.0", "ether").toString()); // { BigNumber: "1000000000000000000" } wei
console.log(ethers.parseUnits("1.0", 18).toString()); // { BigNumber: "1000000000000000000" } wei
console.log(ethers.parseUnits("1.0", "gwei").toString()); // { BigNumber: "1000000000" } wei
console.log(ethers.parseUnits("1.0", 9).toString()); // { BigNumber: "1000000000" } wei
console.log(ethers.parseEther("1.0").toString()); // { BigNumber: "1000000000000000000" } wei, equivalent to parseUnits(value, "ether")
```

### 2024.10.16

#### Ether.js 102: Advanced

`staticCall`

- a method available in the `ethers.Contract` to check whether a transaction will fail before sending it
- eliminate the risk of failure and saving gas

```
const tx = await weth.deposit({value: parseEther("1")}); // Contract call

const tx = await weth.deposit.staticCall({value: parseEther("1")}); // Test run with staticCall, return True if success or error if fail
```

Identify ERC721 via Ethers

```
const selectorERC721 = "0x80ac58cd"; // Interface ID of ERC721
const isERC721 = await contract.supportsInterface(selectorERC721); // via ERC165, return true or false
```

Interface class

- Abstract the ABI encoding and decoding

```
const interface = ethers.Interface(abi); // Generated with ABI

const interface = contract.interface; // Retrieve from initiated contract class

interface.getSighash("balanceOf"); // '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef'

interface.encodeFunctionData("balanceOf", ["0xc778417e063141139fce010982780140aa0cd5ab"]); // Encode the calldata of the function

interface.decodeFunctionResult("balanceOf", resultData); // Decode the return value of the function
```

HD Wallets (Hierarchical Deterministic Wallets)

- A commonly used technique to store the digital keys for blockchain
- Allow to create a series of key pairs from a random seed, providing convenience, security, and privacy
- BIP32
  - Derivation of multiple private keys from a single seed, eg: derivation path m/0/0/1
- BIP44
  - A set of universal specifications for derivation path in BIP32, consists of six levels
  - `m / purpose' / coin_type' / account' / change / address_index`
  - `m/44'/60'/0'/0/0`: 60 represent Ethereum network; Account index starting from 0; Change is usually 0; Address index can start from 0
- BIP39
  - Allow user to store private keys in human-readable mnemonic words, can be 3, 6, 9, 12, 15, 18, 21, 24 words
  - Support multiple languages
  - eg: `air organ twist rule prison symptom jazz cheap rather dizzy verb glare`

Generate Wallets in Batch

```
const mnemonic = ethers.Mnemonic.entropyToPhrase(randomBytes(32)); // Generate a random mnemonic phrase
const hdNode = ethers.HDNodeWallet.fromPhrase(mnemonic); // Create an HD wallet
let basePath = "m/44'/60'/0'/0";
for (let i = 0; i < 10; i++) {
    let hdNodeNew = hdNode.derivePath(basePath + "/" + i); // Create 10 private keys by changing only address index
    let walletNew = new ethers.Wallet(hdNodeNew.privateKey); // Create wallet class with private key
}
```

MerkleTree

- Also known as hash tree, is a fundamental cryptographic technology used in blockchain system
- A bottom-up constructed binary tree, each leaf node represents the hash of data, non-leaf node represents the hash of two child nodes
- Allow for efficient and secure verification of large data structures
- `MerkleTree.js`
  - A JavaScript package for building Merkle Trees and generating Merkle Proof
  - Install via npm `npm install merkletreejs`

```
import { MerkleTree } from "merkletreejs";

const tokens = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"
    ...
]; // A list of data
const leaf = tokens.map(x => ethers.keccak256(x))l // Hash data with keccak256 to match Solidity hashing function
const merkletree = new MerkleTree(leaf, ethers.keccak256, { sortPairs: true }); // Apply keccak256 hashing and keep data sorted

const root = merkletree.getHexRoot(); // Retrieve merkle root
const proof = merkletree.getHexProof(leaf[0]); // Retrieve the proof of a leaf node
```

Digital Signature

- The digital signature algorithm used by Ethereum is called Elliptic Curve Digital Signature Algorithm (ECDSA)
- It serves three main purposes:
  - Identity Authentication: Proves that the signer is the holder of the private key
  - Non-Repudiation: The sender cannot deny sending the message
  - Integrity: The message cannot be modified during transmission

```
const account = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4";
const tokenId = "0";

const msgHash = ethers.solidityKeccak256(
    ['address', 'uint256'],
    [account, tokenId]
); // Equivalent to keccak256(abi.encodePacked(account, tokenId)) in Solidity
const messageHashBytes = ethers.getBytes(msgHash);

const signature = await wallet.signMessage(messageHashBytes); // Get the wallet/signer to sign the message
```

MEV (Maximal Extractable Value)

- In blockchain, miners/validators can profit by packing, excluding, or reordering transactions in the blocks they generate

Mempool

- The transactions send by users will gather in the Mempool
- Miners will then search for transactions with high fees in the Mempool to prioritize packaging and maximize their profits
- Miner/MEV Bot can perform profitable trades by execute sandwich/front-running attack

```
provider.on("pending", async (txHash) => {
    console.log(`[${(new Date).toLocaleTimeString()}]: ${txHash}`); // Retrieve the transaction hash
    let tx = await provider.getTransaction(txHash); // Get transaction detail with transaction hash
});
```

Decoding Transaction Data

```
const functionSignature = 'transferFrom(address,address,uint256)'; // ERC20 TransferFrom function
const selector = iface.getSighash(functionSignature); // Get TransferFrom signature hash

provider.on('pending', async (txHash) => {
if (txHash) {
    const tx = await provider.getTransaction(txHash);
    if (tx !== null && tx.data.indexOf(selector) !== -1) { // Matching function signature hash
        console.log(`[${(new Date).toLocaleTimeString()}]: ${txHash}`);
        console.log(`Decoded transaction details: ${JSON.stringify(iface.parseTransaction(tx), null, 2)}`); // Formatted transaction details
        console.log(`Origin address: ${iface.parseTransaction(tx).args[0]}`); // From
        console.log(`Recipient address: ${iface.parseTransaction(tx).args[1]}`); // To
        console.log(`Transfer amount: ${ethers.utils.formatEther(iface.parseTransaction(tx).args[2])}`); // Amount
        provider.removeListener('pending', this); // Unsubscribe listening to Mempool
    }
}});
```

Vanity Address

- An address usually generated by bruteforcing to get an easy to recognize address, eg: `0x0000000fe6a514a32abdcdfcc076c85243de899b`

```
const regex = /^0x1234.*$/; // Expression to matches addresses starting with 0x1234
let isValid = false;
while(!isValid){
    const wallet = ethers.Wallet.createRandom(); // Generate a random wallet
    isValid = regex.test(wallet.address); // Check the regular expression
}
```

EVM Data

- All data on Ethereum is public, including `private` variable stated in Smart contract (Read via some hacks!)

Smart Contract Storage Layout

- The storage is a mapping of `uint256 -> uint256`
- The size of `uint256` is `32 bytes`, the fixed-size storage space is called a slot
- Contract's data is stored in individual slots, starting from `slot 0`, by default and sequentially
- `private` variables also stored in the storage slot accordingly without a `getter` function

Read contract data

```
const slot = 0;
const paddedAddress = ethers.utils.hexZeroPad(contractAddress, 32);
const paddedSlot = ethers.utils.hexZeroPad(slot, 32);
const concatenated = ethers.utils.concat([paddedAddress, paddedSlot]);
const slotHash = ethers.utils.keccak256(concatenated);
const value = await provider.getStorageAt(contractAddress, slotHash);

```

Front-running Demo

```
//2. Build contract instance
const contractABI = [
    "function mint() public",
];
const contractAddress = '0xC76A71C4492c11bbaDC841342C4Cb470b5d12193'; // Address of the contract
const nft = new ethers.Contract(contractAddress, contractABI, provider);
const iface = new ethers.utils.Interface(contractABI);

const wallet = new ethers.Wallet(privateKey, provider);

provider.on('pending', async (txHash) => {
        const tx = await provider.getTransaction(txHash);
        if (tx.data.indexOf(iface.getSighash("mint")) !== -1 && tx.from !== wallet.address) { // Filter own address
            const frontRunTx = {
                to: tx.to,
                value: tx.value,
                maxPriorityFeePerGas: tx.maxPriorityFeePerGas.mul(2), // Double up gas to let miner prioritize this transaction
                maxFeePerGas: tx.maxFeePerGas.mul(2),
                gasLimit: tx.gasLimit.mul(2),
                data: tx.data
            };
            const sentFR = await wallet.sendTransaction(frontRunTx);
            const receipt = await sentFR.wait();
            console.log(`Transaction hash:${receipt.transactionHash}`); // Frontrun transaction confirmed

            const block = await provider.getBlock(tx.blockNumber); // Retrieve the confirmed block's transactions
            // In the block's transactions, if the later transaction is placed before the earlier transaction, indicating a successful front-run.
        }
    })
```

Identify ERC20 via Ethers

```
// ERC20 Contract Interface
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
}


let code = await provider.getCode(contractAddress)
if(code != "0x"){
        // Check if bytecode includes the selectors of the transfer and totalSupply functions
        if(code.includes("a9059cbb") && code.includes("18160ddd")){
            return true;
        }else{
            return false // Not an ERC20
        }
    }
```

Flashbots

- A research organization committed to mitigating the harm caused by MEV
- Products:
  - Flashbots RPC: Protects users from harmful MEV (sandwich attacks).
  - Flashbots Bundle: Helps MEV searchers extract MEV on Ethereum.
  - mev-boost: Helps Ethereum POS nodes earn more ETH rewards through MEV.

EIP712 Signature

- Typed Data Signatures provides a more advanced and secure method for signatures

```
let contractName = "EIP712Storage"
let version = "1"
let chainId = "1"
let contractAddress = "0xf8e81D47203A594245E36C48e151709F0C19fBe8"
const domain = {
    name: contractName,
    version: version,
    chainId: chainId,
    verifyingContract: contractAddress,
};

let spender = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
let number = "100"

const types = {
    Storage: [
        { name: "spender", type: "address" },
        { name: "number", type: "uint256" },
    ],
};

const message = {
    spender: spender,
    number: number,
};

const signature = await wallet.signTypedData(domain, types, message); // All 3 params are required for EIP712 Signature
const signer = ethers.verifyTypedData(domain, types, message, signature); // Recover the signer address from signature
```

End of WTF Ethers 102

<!-- Content_END -->
