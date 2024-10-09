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
(bool success, bytes memory returnedData) = address(someContract).staticcall(data);
```

- Used in ethers.js to implement contract imports and function calls

```
const someContract = new ethers.Contract(contractAddress, contractABI, signer);
const res = await someContract.doSomething();
```

- Used in contract decompiling, most of the functions in non-open-source contract was able to get encoded function hash but not the function signature, but at least can use with `abi.encodeWithSelector`

```
bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a));

(bool success, bytes memory returnedData) = address(someContract).staticcall(data);
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
(bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(selectorOrMethodId, 1, true));
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
    interfaceId == type(IERC721).interfaceId ||
    interfaceId == type(IERC165).interfaceId;
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
                IERC721Receiver(to).onERC721Received(
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
    interfaceId == type(IERC721).interfaceId ||
    interfaceId == type(IERC165).interfaceId ||
    interfaceId == type(IERC721Metadata).interfaceId;
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
    return IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId,_data) == IERC721Receiver.onERC721Received.selector;
  } else {
    return true;
  }
}

// Implements the tokenURI function of IERC721Metadata to query metadata.
function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
  require(_owners[tokenId] != address(0), "Token Not Exist");

  string memory baseURI = _baseURI();
  return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
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
            payable(msg.sender).transfer(msg.value - totalCost); //please check is there any risk of reentrancy attack
        }
    }

    // the withdraw function, onlyOwner modifier
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}(""); // how to use call function please see lession #22
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
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // Delete order

        // Release Purchase event
        emit Purchase(msg.sender, _nftAddr, _tokenId, msg.value);
    }
```

### 2024.10.10

### 2024.10.11

### 2024.10.12

### 2024.10.13

### 2024.10.14

### 2024.10.15

### 2024.10.16

<!-- Content_END -->
