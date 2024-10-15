---
timezone: Asia/Shanghai
---

---

# ChenBingWei1201

1. 自我介绍
  大家好我叫Chen Bing Wei，我以前只有學習過往佔前後都開發，從未接觸solidity與smart contract這類的東西，但今年因緣際會下修了一門叫分散式金融導論的課，助教教的非常好，讓我對這個領域充滿極大的興趣，或許未來可以做跨領域的結合，結合網路服務，金融科技，與機器學習等現在所學的知識，創造出能對人類有所貢獻的東西，因此想藉由這次機會挑戰自己，參加此次活動逼迫自己學習。

2. 你认为你会完成本次残酷学习吗？
  會

## Notes

<!-- Content_START -->

### 2024.09.23
<details>
<summary>1. HelloWeb3</summary>

#### WTF is Solidity?
- Solidity is a programming language used for creating smart contracts on the Ethereum Virtual Machine (EVM).
- Solidity has two characteristics:
  1. **Object-oriented**: After learning it, you can use it to make money by finding the right projects.
  2. **Advanced**: If you can write smart contract in Solidity, you are the first class citizen of Ethereum.

#### Development tool: Remix
Remix is an smart contract development IDE (Integrated Development Environment) recommended by Ethereum official.
- Advantages
  1. **Suitable for Beginners**: It allows for quick deployment and testing of smart contracts in the browser, without needing to install any programs on your local machine.
  2. **Gas Estimation Issue**: It will estimation the cost of gas on every functions and display behind them, which can remind developers that wheter functions should be optimized or not.
- Disadvantages
  1. **Limited to Browser**: Since Remix is a browser-based IDE, it can be less stable or responsive compared to desktop IDEs like VSCode, especially when working with larger projects or multiple open files.
  2. **Collaboration Limitations**: Remix doesn’t have built-in features for real-time collaboration or version control like Git, making it more difficult to work in teams.

Website: [remix.ethereum.org](https://remix.ethereum.org)

#### The first Solidity program

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
```
1. The first line is a comment, which denotes the software license (license identifier) used by the program. We are using the MIT license. **If you do not indicate the license used, the program can compile successfully but will report an warning during compilation**. Solidity's comments are denoted with "//", followed by the content of the comment (which will not be run by the program). Details can be found in the [SPDX-License
documentation](https://spdx.org/licenses/).
2. The second line declares the **Solidity version** used by the source file, because the syntax of different versions is different. This line of code means that the source file will not allow compilation by compilers version **lower than v0.8.4 and not higher than v0.9.0** [0.8.4, 0.9.0).
  - There is slight difference among distinct
versions: 0.4.22 -> constructor, 0.8.0 -> safeMath
  - Include the pragma version in every file: Locking the version is preferable, except for libraries.
  - Pattern: pragma solidity x.y.z: e.g. **pragma solidity ^0.8.3 : [0.8.3, 0.9.0)** or **pragma solidity >=0.8.3 <0.8.7**
3. Lines 3 and 4 are the main body of the smart contract. Line 3 creates a contract with the name `HelloWeb3`. Line 4 is the content of the contract. Here, we created a string variable called _string and assign "Hello Web3!" as value to it.

#### Summary
In the first day, I learned what is `Solidity`, `Remix IDE`, and completed our first Solidity program - `HelloWeb3`.
</details>

### 2024.09.24
<details>
<summary>2. Variable Types</summary>

Solidity is statically-type language, which means **the type of each variable needs to be specified in code at compile time**.

1. **Value Type**： This include boolean, integer, etc. These variables directly pass values when assigned.
2. **Reference Type**：including arrays and structures. These variables take up more space, directly pass addresses (similar to pointers) when assigned, and can be modified with multiple variable names.
3. **Mapping Type**: hash tables in Solidity.

#### 1. Value Type

| Type  | Example | Byte  | Default Value |
| ------------- | ------------- | ------------- | ------------- |
| Boolean | `true` / `false` | 1 Byte | False |
| Usigned Integer | `uint128`, `uint256` | uint256 - 32 bytes | 0 |
| Integer | `int128`, `int256` | int256 - 32 bytes | 0 |
| address* / adress payable* | `address public _address = 0x5C69...5aA6` | 20 bytes | address(0) |
| Fixed-Sized bytes array | `bytes32 public _byte32 = "MiniSolidity";` `bytes1 public _byte = _byte32[0];` | bytes32 - 32 bytes | bytes32(0) |
| Enumeration | `enum ActionSet { Buy, Hold, Sell }` | uint 0,  1,  2 | - |

*address payable: Same as address, but with the additional members transfer and send to allow ETH transfers.

*There are two types of accounts: EOA & CA
- EOA(Externally Owned Account): For example, Wallet Address
- CA(Contract Account): For example, Simple Bank Contract

#### 2. Reference Type

| Type  | Example |
| ------------- | ------------- |
| Array | `uint256[], string, bytes (Dynamic Size Bytes Array)` |
| Struct | `struct Demo {uint256 x, uint256 y}` |

#### 3. Mapping Type

| Type  | Example |
| ------------- | ------------- |
| Mapping | `mapping(address=>uint256)`, `mapping(address addr=>uint)`, `mapping(address addr=>uint balance)` |
</details>

### 2024.09.25

<details>
<summary>3. Function</summary>

Here's the format of a function in Solidity:
```solidity
function <function name>(<parameter types>) <visibility> <mutibility> [returns (<return types>)];
```
1. `function`: To write a function, you need to start with the keyword `function`.
2. `<function name>`: The name of the function.
3. `(<parameter types>)`: The input parameter types and names.
4. `<visibility>`: Function visibility specifiers. There are 4 kinds of them and `public` is the default visibility if left empty:
  - `public`: Any account can call -> Be careful with access control issue
  - `external`: Only other contracts and account can call -> It can be bypassed with `this.f()`, where `f` is the function name.
  - `internal`: Can only be called inside contract and child contracts.
  - `private`: Can only be accessed within this contract, derived contracts cannot use it. Only inside the contract that defines the function.
  
  **Note 1**: `public` is the default visibility for functions.
  **Note 2**: **public**|**private**|**internal** can be also used on state variables. Public variables will automatically generate `getter` functions for querying values.
  **Note 3**: The default visibility for state variables is internal.

5. `<mutibility>`: Keywords that dictate a Solidity functions behavior. There are 3 kinds of them:
  - `view`:  Functions containing `view` keyword can read but cannot write on-chain state variables. 
  - `pure`: Functions containing `pure` keyword cannot read nor write state variables on-chain.
  - `payable`: enable this function to receive ethers
  - Without `pure` and `view`: Functions can both read and write state variables.
6. `[returns (<return types>)]`: Return variable types and names.

#### WTF is `pure` and `view` ?

Solidity added these two keywords, because of gas fee. The contract state variables are stored on block chain, and gas fee is very expensive. If you don't rewrite these variables, you don't need to pay gas. You don't need to pay gas for calling `pure` and `view` functions.

The following statements are considered modifying the state:
1. Writing to state variables.
2. Emitting events.
3. Creating other contracts.
4. Using selfdestruct.
5. Sending Ether via calls.
6. Calling any function not marked view or pure.
7. Using low-level calls.
8. Using inline assembly that contains certain opcodes.

#### Code
1. `pure` vs `view`

We define a state variable `number = 5`
```solidity
// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.4;
  contract FunctionTypes{
      uint256 public number = 5;
```
Define an `add()` function, add 1 to `number` on every call.
```solidity
  // default
    function add() external{
        number = number + 1;
    }
```
If `add()` contains `pure` keyword, i.e. `function add() pure external`, it will result in an error. Because `pure` cannot read state variable in contract nor write. So what can `pure` do ? That is, you can **pass a parameter `_number` to function, let function `returns _number + 1`**.
```solidity
  // pure
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number+1;
    }
```
If `add()` contains `view`, i.e. `function add() view external`, it will also result in error. Because `view` can read, but cannot write state variable. We can modify the function as follows:
```solidity
  // view
  function addView() external view returns(uint256 new_number) {
      new_number = number + 1; // can read the state variable outside the function block
  }
```

2. `internal` vs `external`
```solidity
  // internal
  function minus() internal {
      number = number - 1;
  }

  // external
  function minusCall() external {
      minus();
  }
```
Here we defined an `internal minus()` function, `number` will decrease 1 each time function is called. Since `internal` function can only be called within the contract itself. Therefore, we need to define an `external minusCall()` function to call `minus()` internally.

3. `payable`
```solidity
// payable: money (ETH) can be sent to the contract via this function
  function minusPayable() external payable returns(uint256 balance) {
      minus();
      balance = address(this).balance;
  }
``` 
We defined an `external payable minusPayable()` function, which calls `minus()` and return `ETH` balance of the current contract (`this` keyword can let us query current contract address). Since the function is `payable`, we can send 1 `ETH` to the contract when calling `minusPayable()`.
</details>

### 2024.09.26
<details>
<summary>4. Function Output</summary>

#### Return values (`return` and `returns`)
There are two keywords related to function output: `return` and `returns`:
  - `returns` is added after the function name to declare variable type and variable name;
  - `return` is used in the function body and returns desired variables.
```solidity
  // returning multiple variables
    function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
        return(1, true, [uint256(1),2,5]);
    }
```

#### Named returns
We can indicate the name of the return variables in `returns` so that solidity automatically initializes these variables, and automatically returns the values of these functions without adding the `return` keyword.
```solidity
    // named returns
    function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        _number = 2;
        _bool = false; 
        _array = [uint256(3),2,1];
    }
```
We only need to assign values to the variable `_number`, `_bool` and `_array` in the function body, and they will automatically return because the return variable type and variable name with `returns` `(uint256 _number, bool _bool, uint256[3] memory _array)` have been declared.

Of course, you can also return variables with return keyword in named returns:
```solidity
    // Named return, still support return
    function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        return(1, true, [uint256(1),2,5]);
    }
```

#### Destructuring assignments 
Solidity internally allows tuple types, i.e. a list of objects of potentially different types whose number is a constant at compile-time. The tuples can be used to return multiple values at the same time.
- Variables declared with type and assigned from the returned tuple, not all elements have to be specified (but the number must match):
```solidity
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number, _bool, _array) = returnNamed();
```
- Assign part of return values: Components can be left out. In the following code, we only assign the return value `_bool2`, but not `_ number` and `_array`:
```solidity
        (, _bool2, ) = returnNamed();
```
</details>

### 2024.09.27
<details>
<summary>5. Data Storage and Scope</summary>

#### Reference types in Solidity
Reference types(notes on 2024.09.24) differ from value types in that they do not store values directly on their own. Instead, reference types store the address/pointer of the data’s location and do not directly share the data. You can modify the underlying data with different variable names. Reference types `array`, `struct` and `mapping`, which take up a lot of storage space. We need to deal with the location of the data storage when using them.

#### Data location
There are three types of data storage locations in solidity: `storage`, `memory` and `calldata`. Gas costs are different for different storage locations. 

The data of a `storage` variable is stored on-chain, similar to the hard disk of a computer, and consumes a lot of `gas`; while the data of `memory` and `calldata` variables are temporarily stored in memory, consumes less `gas`.

General usage:
1. `storage`: The state variables are `storage` by default, which are stored on-chain.
2. `memory`: The parameters and temporary variables in the function generally use `memory` label, which is stored in memory and not on-chain.
3. `calldata`: Similar to `memory`, stored in memory, not on-chain. The difference from `memory` is that `calldata `variables cannot be modified, and is generally used for function parameters. Example:
```solidity
    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        // The parameter is the calldata array, which cannot be modified.
        // _x[0] = 0 // This modification will report an error.
        return(_x);
    }
```

#### Data location and assignment behaviour
Data locations are not only relevant for persistency of data, but also for the semantics of assignments:
1. When `storage` (a state variable of the contract) is assigned to the local storage (in a function), a **reference will be created**, and changing value of the new variable will **affect the original one**. Example:
```solidity
    uint[] x = [1,2,3]; // state variable: array x

    function fStorage() public{
        // Declare a storage variable xStorage, pointing to x. Modifying xStorage will also affect x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }
```
2. Assigning `storage` to `memory` creates independent copies, and changes to one will **not affect the other; and vice versa**. Example:
```solidity
    uint[] x = [1,2,3]; // state variable: array x
    
    function fMemory() public view{
        // Declare a variable xMemory of Memory, copy x. Modifying xMemory will not affect x
        uint[] memory xMemory = x;
        xMemory[0] = 100;
    }
```
3. Assigning `memory` to `memory` will **create a reference**, and changing the new variable will **affect the original variable**.
4. Otherwise, assigning a variable to `storage` will **create independent copies**, and modifying one will **not affect the other**.

#### Variable scope
There are three types of variables in Solidity according to their scope: state variables, local variables, and global variables.

1. State variables
  
  State variables are variables whose data is stored on-chain and can be accessed by in-contract functions, but their `gas` consumption is high.

  State variables are declared inside the contract and outside the functions:
  ```solidity
  contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
  ```
  We can change the value of the state variable in a function:
  ```solidity
      function foo() external{
        // You can change the value of the state variable in the function
        x = 5;
        y = 2;
        z = "0xAA";
    }
  ```
2. Local variable

  Local variables are variables that are only valid during function execution; they are invalid after function exit. The data of local variables are stored in memory, not on-chain, and their `gas` consumption is low. 
  ```solidity
      function bar() external pure returns(uint){
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }
  ```
3. Global variable

  Global variables are variables that work in the global scope and are **reserved keywords** for solidity. They can be used directly in functions without declaring them:
  ```solidity
      function global() external view returns(address, uint, bytes memory){
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }
  ```
  In the above example, we use three global variables: **msg.sender**, **block.number** and **msg.data**, which represent the sender of the message (current call), current block height, and complete calldata. 

  Below are some commonly used global variables:
  - `blockhash(uint blockNumber)`: (`bytes32`) The hash of the given block - only applies to the 256 most recent block.
  - `block.coinbase`: (`address payable`) The address of the current block miner
  - `block.gaslimit`: (`uint`) The gaslimit of the current block
  - `block.number`: (`uint`) Current block number
  - `block.timestamp`: (`uint`) The timestamp of the current block, in seconds since the unix epoch
  - `gasleft()`: (`uint256`) Remaining gas
  - `msg.data`: (`bytes calldata`) Complete calldata
  - `msg.sender`: (`address payable`) Message sender (current caller)
  - `msg.sig`: (`bytes4`) first four bytes of the calldata (i.e. function identifier)
  - `msg.value`: (`bytes4`) number of wei sent with the message

#### Summary
In this chapter, I learned reference types, data storage locations and variable scopes in Solidity. There are three types of data storage locations: `storage`, `memory` and `calldata`. Gas costs are different for different storage locations. The variable scope include state variables, local variables and global variables.

</details>


### 2024.09.28
<details>
<summary>6. Array & Struct</summary>

#### (1) Array (ref: 2024.09.24)
An `array` is a variable type commonly used in Solidity to store a set of data (integers, bytes, addresses, etc.).

There are two types of arrays: fixed-sized and dynamically-sized arrays.：
- fixed-sized arrays: The length of the array is specified at the time of declaration. An `array` is declared in the format `T[k]`, where `T` is the element type and `k` is the length.
```solidity
    // fixed-length array
    uint[8] array1;
    byte[5] array2;
    address[100] array3;
```
- Dynamically-sized array（dynamic array）：Length of the array is not specified during declaration. It uses the format of `T[]`, where `T` is the element type. 
```solidity
    // variable-length array
    uint[] array4;
    byte[] array5;
    address[] array6;
    bytes array7;
```
**Notice**: `bytes` is special case, it is a dynamic array, but you don't need to add `[]` to it. You can use either `bytes` or `bytes1[]` to declare byte array, but not `byte[]`. `bytes` is recommended and consumes less gas than `bytes1[]`.

#### Rules for creating arrays
- For a `memory` dynamic array, it can be created with the `new` operator, but the length must be declared, and the length cannot be changed after the declaration. For example：
```solidity
    // memory dynamic array
    uint[] memory array8 = new uint[](5);
    bytes memory array9 = new bytes(9);
```
- Array literal are arrays in the form of one or more expressions, and are not immediately assigned to variables; such as `[uint(1),2,3]` (the type of the first element needs to be declared, otherwise the type with the smallest storage space is used by default).
- When creating a dynamic array, you need an element-by-element assignment.
```solidity
    uint[] memory x = new uint[](3);
    x[0] = 1;
    x[1] = 3;
    x[2] = 4;
```

#### Members of Array
- `length`: Arrays have a `length` member containing the number of elements, and the length of a `memory` array is fixed after creation.
- `push()`: Dynamic arrays have a `push()` member function that adds a `0` element at the end of the array.
- `push(x)`: Dynamic arrays have a `push(x)` member function, which can add an `x` element at the end of the array.
- `pop()`: Dynamic arrays have a `pop()` member that removes the last element of the array.

#### (2) Struct
You can define new types in the form of `struct` in Solidity. Elements of `struct` can be primitive types or reference types. And `struct` can be the element for `array` or `mapping`.
```solidity
    // struct
    struct Student{
        uint256 id;
        uint256 score; 
    }

    Student student; // Initially a student structure
```
There are 4 ways to assign values to `struct`:
```solidity
     // Method 1: Directly refer to the struct of the state variable
    function initStudent1() external{
        student.id = 1;
        student.score = 80;
    }
```
```solidity
    // Method 2: struct constructor
    function initStudent2() external {
        student = Student(3, 90);
    }
    
    // Method 3: key value
    function initStudent3() external {
        student = Student({id: 4, score: 60});
    }
```
```solidity
    // assign value to structure
    // Method 4: Create a storage struct reference in the function
    function initStudent4() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }
```

#### Summary
In this lecture, I learned the basic usage of `array` and `struct` in Solidity.

</details>

<details>
<summary>7. Mapping</summary>

#### Mapping (ref: 2024.09.24)
With `mapping` type, people can query the corresponding `Value` by using a `Key`. For example, a person's wallet address can be queried by their `id`.

The format of declaring the `mapping` is `mapping(_KeyType => _ValueType)`, where `_KeyType` and `_ValueType` are the variable types of `Key` and `Value` respectively. For example:
```solidity
    mapping(uint => address) public idToAddress; // id maps to address
    mapping(address => address) public swapPair; // mapping of token pairs, from address to address
```

#### Rules of `mapping`
- **Rule 1**: The `_KeyType` should be selected among default types in solidity such as `uint`, `address`, etc. **No custom `struct` can be used**. However, `_ValueType` can be any custom types. The following example will throw an **error**, because `_KeyType` uses a custom struct:
```solidity
      // define a struct
      struct Student {
          uint256 id;
          uint256 score;
      }
      mapping(Student => uint) public testVar;
```
- **Rule 2**: The storage location of the mapping must be `storage`: it can serve as the state variable or the `storage` variable inside function. But it can't be used in arguments or return results of `public` function.
- **Rule 3**: If the mapping is declared as `public` then Solidity will automatically create a `getter` function for you to query for the `Value` by the `Key`.
- **Rule 4**： The syntax of adding a key-value pair to a mapping is `_Var[_Key] = _Value`, where `_Var` is the name of the mapping variable, and `_Key` and `_Value` correspond to the new key-value pair. For example:
```solidity
    function writeMap(uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
    }
```
#### Principle of `mapping`
- Principle 1: The mapping does not store any `key` information or length information.
- Principle 2: Mapping use `keccak256(key)` as offset to access value.
- Principle 3: Since Ethereum defines all unused space as `0`, all `key` that are not assigned a value will have an initial value of `0`.

#### Summary
In this section，I learned the `mapping` type in Solidity. So far, we've learned all kinds of common variables.

</details>

### 2024.10.01
<details>
<summary>8. Initial Value</summary>

#### Initial values of variables
In Solidity, variables declared but not assigned have their initial/default values.

##### Initial values of value types
- `boolean`: `false`
- `string`: `""`
- `int`: `0`
- `uint`: `0`
- `enum`: first element in enumeration
- `address`: `0x0000000000000000000000000000000000000000` (or `address(0)`)
- `function`
  - `internal`: blank function
  - `external`: blank function
You can use `getter` function of `public` variables to confirm the above initial values:
```solidity
    bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet {Buy, Hold, Sell}
    ActionSet public _enum; // first element 0

    function fi() internal{} // internal blank function
    function fe() external{} // external blank function
```
##### Initial values of reference types
- `mapping`: a `mapping` which all members set to their default values
- `struct`: a `struct` which all members set to their default values
- `array`
  - dynamic array: `[]`
  - static array（fixed-length): a static array where all members set to their default values.

You can use `getter` function of `public` variables to confirm initial values:
```solidity
    // reference types
    uint[8] public _staticArray; // a static array which all members set to their default values[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`
    mapping(uint => address) public _mapping; // a mapping which all members set to their default values
    // a struct which all members set to their default values 0, 0
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student;
```

##### `delete` operator
`delete a` will change the value of variable `a` to its initial value.
```solidity
    // delete operator
    bool public _bool2 = true; 
    function d() external {
        delete _bool2; // delete will make _bool2 change to default(false)
    }
```

#### Summary
In this section, I learned the initial values of variables in Solidity. When a variable is declared but not assigned, its value defaults to the initial value, which is equivalent as 0 represented in its type. The delete operator can reset the value of the variable to the initial value.

</details>

<details>
<summary>9. Constant and Immutable</summary>

If a state variable is declared with `constant` or `immutable`, its value cannot be modified after contract compilation.

Value-typed variables can be declared as constant and immutable; string and bytes can be declared as constant, but not immutable.
#### constant and immutable

##### constant
`constant` variable must be initialized during declaration and cannot be changed afterwards. Any modification attempt will result in error at compilation. 
```solidity
    // The constant variable must be initialized when declared and cannot be changed after that
    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0xAA";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```
##### immutable
The `immutable` variable can be initialized during declaration or in the constructor, which is more flexible.
```solidity
    // The immutable variable can be initialized in the constructor and cannot be changed later
    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;
```
You can initialize the `immutable` variable using a global variable such as `address(this)`, `block.number`, or a custom function. In the following example, we use the `test()` function to initialize the `IMMUTABLE_TEST` variable to a value of `9`:
```solidity
    // The immutable variables are initialized with constructor, so that could use
    constructor(){
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_BLOCK = block.number;
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns(uint256){
        uint256 what = 9;
        return(what);
    }
```
#### Summary
In this section, I learned two keywords to restrict modifications to their state in Solidity: `constant` and `immutable`. They keep the variables that should not be changed unchanged. It will help to save gas while improving the contract's security.

#### Test
2. In the following variable definition statement, the one that will report an error is:
  (a) `string constant x5 = "hello world";`

  (b) `address constant x6 = address(0);`

  (c) `string immutable x7 = "hello world";`

  (d) `address immutable x8 = address(0);`

<details>
<summary>answer</summary>

(d) The `immutable` keyword can only be applied to state variables that are assigned once during contract construction. This means you cannot initialize an `immutable` variable with a value at the time of declaration like you're doing here.

Instead, you should assign the value of an immutable variable inside the constructor. Here’s an example of how you can do it correctly:
```solidity
pragma solidity ^0.8.0;

contract Example {
    string public immutable x7;

    constructor() {
        x7 = "hello world";
    }
}
```
But why (b) is correct?
Because `immutable` variables in Solidity can be assigned either inside the `constructor` or at the time of declaration, but only when they are assigned a constant or known value (like `address(0)`).

Since address(0) is a constant value, this is allowed. Immutable variables just need to be set at some point during the contract's construction process, whether it's in the constructor or during declaration.
```solidity
pragma solidity ^0.8.0;

contract Example {
    address public immutable x8 = address(0);
}
```
This works because `address(0)` is a known constant value, and you're assigning it at the time of declaration.

</details>

</details>

### 2024.10.02
<details>
<summary>10. Control Flow</summary>

#### Control Flow
Solidity's control flow is similar to other languages, mainly including the following components:

1. `if`-`else`
```solidity
function ifElseTest(uint256 _number) public pure returns(bool){
    if(_number == 0){
    return(true);
    }else{
    return(false);
    }
}
```
2. `for` loop
```solidity
function forLoopTest() public pure returns(uint256){
    uint sum = 0;
    for(uint i = 0; i < 10; i++){
    sum += i;
    }
    return(sum);
}
```
3. `while` loop
```solidity
function whileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    while(i < 10){
    sum += i;
    i++;
    }
    return(sum);
}
```
4. `do-while` loop
```solidity
function doWhileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    do{
    sum += i;
    i++;
    }while(i < 10);
    return(sum);
}
```
5. Conditional (`ternary`) operator

The `ternary` operator is the only operator in Solidity that accepts three operands：a condition followed by a question mark (`?`), then an expression `x` to execute if the condition is true followed by a colon (`:`), and finally the expression `y` to execute if the condition is false: `condition ? x : y`.

This operator is frequently used as an alternative to an `if`-`else` statement.

// ternary/conditional operator
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
    // return the max of x and y
    return x >= y ? x: y; 
}

In addition, there are `continue` (immediately enter the next loop) and `break` (break out of the current loop) keywords that can be used.

#### Solidity Implementation of Insertion Sort

##### Insertion Sort

The sorting algorithm solves the problem of arranging an unordered set of numbers from small to large, for example, sorting `[2, 5, 3, 1]` to `[1, 2, 3, 5]`. Insertion Sort (InsertionSort) is the simplest and first sorting algorithm that most developers learn in their computer science class. The logic of InsertionSort:
1. from the beginning of the array x to the end, compare the element x[i] with the element in front of it x[i-1]; if x[i] is smaller, switch their positions, compare it with x[i-2], and continue this process. 

##### Solidity Implementation (with Bug)
Python version of Insertion Sort takes up 9 lines. Let's rewrite it into Solidity by replacing `functions`, `variables`, and `loops` with solidity syntax accordingly. It only takes up 9 lines of code:
```solidity
    // Insertion Sort (Wrong version）
    function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j=i-1;
            while( (j >= 0) && (temp < a[j])){
                a[j+1] = a[j];
                j--;
            }
            a[j+1] = temp;
        }
        return(a);
    }
```
But when we compile the modified version and try to sort `[2, 5, 3, 1]`. BOOM! There are bugs! After 3-hour debugging, I still could not find where the bug was. I googled "Solidity insertion sort", and found that all the insertion algorithms written with Solidity are all wrong, such as: [Sorting in Solidity without Comparison](https://medium.com/coinmonks/sorting-in-solidity-without-comparison-4eb47e04ff0d)

##### Solidity Implementation (Correct)

The most commonly used variable type in Solidity is `uint`, which represent a non-negative integer. If it takes a negative value, we will encounter an `underflow` error. In the above code, the variable `j` will get `-1`, causing the bug.

So, we need to add `1` to `j` so it can never take a negative value. The correct insertion sort solidity code:
```solidity
    // Insertion Sort（Correct Version）
    function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
        // note that uint can not take negative value
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j=i;
            while( (j >= 1) && (temp < a[j-1])){
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return(a);
    }
```

#### Summary

In this lecture, I learned control flow in Solidity and wrote a simple but bug-prone sorting algorithm. Solidity looks simple but have many traps. Every month, projects get hacked and lose millions of dollars because of small bugs in the smart contract. To write a safe contract, we need to master the basics of the Solidity and keep practicing.

</details>

### 2024.10.03
<details>
<summary>11. Constructor & Modifier</summary>

#### Constructor
`constructor` is a special function, which will automatically run once during contract deployment. Each contract can have one `constructor`. It can be used to initialize parameters of a contract, such as an `owner` address:
```solidity
   address owner; // define owner variable

   // constructor
   constructor() {
      owner = msg.sender; //  set owner to the deployer address
   }
```
Note: The syntax of `constructor` in solidity is not consistent for different versions: Before `solidity 0.4.22`, constructors did not use the `constructor` keyword. Instead, the constructor had the same name as the contract name. This old syntax is prone to mistakes: the developer may mistakenly name the contract as `Parents`, while the constructor as `parents`. So in `0.4.22` and later version, the new `constructor` keyword is used. Example of constructor prior to `solidity 0.4.22`:
```solidity
pragma solidity = 0.4.21;
contract Parents {
    // The function with the same name as the contract name(Parents) is constructor
    function Parents () public {
    }
}
```

#### Modifier
`modifier` is similar to `decorator` in object-oriented programming, which is used to declare dedicated properties of functions and reduce code redundancy. `modifier` is Iron Man Armor for functions: the function with `modifier` will have some magic properties. The popular use case of `modifier` is restrict the access of functions.

Let's define a `modifier` called onlyOwner, functions with it can only be called by `owner`:
```solidity
   // define modifier
   modifier onlyOwner {
      require(msg.sender == owner); // check whether caller is address of owner
      _; // execute the function body
   }
```
Next, let us define a `changeOwner` function, which can change the `owner` of the contract. However, due to the `onlyOwner` modifier, only original `owner` is able to call it. This is the most common way of access control in smart contracts.
```solidity
   function changeOwner(address _newOwner) external onlyOwner{
      owner = _newOwner; // only owner address can run this function and change owner
   }
```

#### Summary
In this lecture, I learned `constructor` and `modifier` in Solidity, and wrote an `Ownable` contract that controls access of the contract.

</details>

### 2024.10.04
<details>
<summary>12. Events</summary>

#### Events
The `event` in solidity are the transaction logs stored on the `EVM` (Ethereum Virtual Machine). They can be emitted during function calls and are accessible with the contract address. Events have two characteristics：
- Responsive: Applications (e.g. `ether.js`) can subscribe and listen to these events through `RPC` interface and respond at frontend.
- Economical: It is cheap to store data in events, costing about 2,000 `gas` each. In comparison, store a new variable on-chain takes at least 20,000 `gas`.

##### Declare events
The events are declared with the `event` keyword, followed by event name, then the type and name of each parameter to be recorded. Let's take the `Transfer` event from the `ERC20` token contract as an example：
```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```
`Transfer` event records three parameters: `from`，`to`, and `value`，which correspond to the address where the tokens are sent, the receiving address, and the number of tokens being transferred. Parameter `from` and `to` are marked with `indexed` keywords, which will be stored at a special data structure known as `topics` and easily queried by programs.

##### Emit events
We can `emit` events in functions. In the following example, each time the `_transfer()` function is called, `Transfer` events will be emitted and corresponding parameters will be recorded.
```solidity
    // define _transfer function，execute transfer logic
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {

        _balances[from] = 10000000; // give some initial tokens to transfer address

        _balances[from] -=  amount; // "from" address minus the number of transfer
        _balances[to] += amount; // "to" address adds the number of transfer

        // emit event
        emit Transfer(from, to, amount);
    }
```

#### EVM Log
EVM uses `Log` to store Solidity events. Each log contains two parts: `topics` and `data`.

##### `Topics`
`Topics` is used to describe events. Each event contains a maximum of 4 `topics`. Typically, the first `topic` is the event hash: the hash of the event signature. The event hash of `Transfer` event is calculated as follows:
```solidity
keccak256("Transfer(addrses,address,uint256)")

// 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
```
Besides event hash, `topics` can include 3 `indexed` parameters, such as the `from` and `to` parameters in `Transfer` event. The anonymous event is special: it does not have a event name and can have 4 indexed parameters at maximum.

`indexed` parameters can be understood as the indexed "key" for events, which can be easily queried by programs. The size of each `indexed` parameter is 32 bytes. For the parameter is larger than 32 bytes, such as `array` and `string`, the hash of the underlying data is stored.

##### `Data`
Non-indexed parameters will be stored in the `data` section of the log. They can be interpreted as "value" of the event and can't be retrieved directly. But they can store data with larger size. Therefore, `data` section can be used to store complex data structures, such as `array` and `string`. Moreovrer, `data` consumes less gas compared to `topic`.

#### Summary
In this lecture, I learned how to use and query events in solidity. Many on-chain analysis tools are based on solidity events, such as `Dune Analytics`.

</details>


### 2024.10.05
<details>
<summary>13. Inheritance</summary>

#### Inheritance

Inheritance is one of the core concepts in object-oriented programming, which can significantly reduce code redundancy. It is a mechanism where you can to derive a class from another class for a hierarchy of classes that share a set of attributes and methods. In solidity, smart contracts can be viewed objects, which supports inheritance.

##### Rules

There are two important keywards for inheritance in Solidity:

- `virtual`: If the functions in the **parent** contract are expected to be overridden in its child contracts, they should be declared as `virtual`.
- `override`： If the functions in the **child** contract override the functions in its parent contract, they should be declared as `override`.

**Note 1**: If a function both overrides and is expected to be overridden, it should be labeled as `virtual override`.

**Note 2**: If a public state variable is labeled as `override`, its `getter` function will be overridden. For example:
```solidity
mapping(address => uint256) public override balanceOf;
```

##### Simple inheritance
Let's start by writing a simple `Grandfather` contract, which contains 1 `Log` event and 3 functions: `hip()`, `pop()`, `grandfather()`, which outputs a string `"Grandfather"`.
```solidity
contract Grandfather {
    event Log(string msg);

    // Apply inheritance to the following 3 functions: hip(), pop(), man()，then log "Grandfather".
    function hip() public virtual{
        emit Log("Grandfather");
    }

    function pop() public virtual{
        emit Log("Grandfather");
    }

    function Grandfather() public virtual {
        emit Log("Grandfather");
    }
}
```
Let's define another contract called `Father`, which inherits the `Grandfather` contract. The syntax for inheritance is `contract Father is Grandfather`, which is very intuitive. In the `Father` contract, we rewrote the functions `hip()` and `pop()` with the `override` keyword, changing their output to `"Father"`. We also added a new function called `father`, which output a string `"Father"`.
```solidity
contract Father is Grandfather{
    // Apply inheritance to the following 2 functions: hip() and pop()，then change the log value to "Father".
    function hip() public virtual override{
        emit Log("Father");
    }

    function pop() public virtual override{
        emit Log("Father");
    }

    function father() public virtual{
        emit Log("Father");
    }
}
```
After deploying the contract, we can see that `Father` contract contains 4 functions. The outputs of `hip()` and `pop()` are successfully rewritten with output `"Father"`, while the output of the inherited `grandfather()` function is still `"Gatherfather"`.

##### Multiple inheritance

A solidity contract can inherit multiple contracts. The rules are:
1. For multiple inheritance, parent contracts should be ordered by seniority, from the highest to the lowest. For example: `contract Son is Gatherfather, Father`. A error will be thrown if the order is not correct.
2. If a function exists in multiple parent contracts, it must be overridden in the child contract, otherwise an error will occur.
3. When a function exists in multiple parent contracts, you need to put all parent contract names after the override keyword. For example: `override(Grandfather, Father)`.

Example：
```solidity
contract Son is Grandfather, Father{
    // Apply inheritance to the following 2 functions: hip() and pop()，then change the log value to "Son".
    function hip() public virtual override(Grandfather, Father){
        emit Log("Son");
    }

    function pop() public virtual override(Grandfather, Father) {
        emit Log("Son");
    }
```
After deploying the contract, we can see that we successfully rewrote the `hip()` and `pop()` functions in `Son` contract, changing the output to `"Son"`. While the `grandfather()` and `father()` functions inherited from its parent contracts remain unchanged.

##### Inheritance of modifiers
Likewise, modifiers in Solidity can be inherited as well. Rules for modifier inheritance are similar as the function inheritance, using the `virtual` and `override` keywords.
```solidity
contract Base1 {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {
    // Calculate _dividend/2 and _dividend/3, but the _dividend must be a multiple of 2 and 3
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    // Calculate _dividend/2 and _dividend/3
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}
```
`Identifier` contract can directly use the `exactDividedBy2And3` modifier, because it inherits `Base1` contract. We can also rewrite the modifier in the contract:
```solidity
    modifier exactDividedBy2And3(uint _a) override {
        _;
        require(_a % 2 == 0 && _a % 3 == 0);
    }
```

##### Inheritance of constructors
Constructors can also be inherited. Let first consider a parent contract `A` with a state variable `a`, which is initialized in its constructor:
```solidity
// Applying inheritance to the constructor functions
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
```
There are two ways for a child contract to inherit the constructor from its parent `A`:
1. Declare the parameters of the parent constructor at inheritance:
```solidity
    contract B is A(1){}
```
2. Declare the parameter of the parent constructor in the constructor of the child contract:
```solidity
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```

##### Calling the functions from the parent contracts

There are two ways for a child contract to call the functions of the parent contract:
1. Direct calling： The child contract can directly call the parent's function with `parentContractName.functionName()`. For example:
```solidity
        function callParent() public {
            Grandfather.pop();
        }
```
2. `super` keyword： The child contract can use the `super.functionName()` to call the function in the **neareast** parent contract in the inheritance hierarchy. Solidity inheritance are declared in a right-to-left order: for `contract Son is Grandfather, Father`, `Father` contract is closer than the `Grandfather` contract. Thus, `super.pop()` in the `Son` contract will call `Father.pop()` but not `Grandfather.pop()`.
```solidity
    function callParentSuper() public{
        // call the function one level higher up in the inheritance hierarchy
        super.pop();
    }
```

##### Diamond inheritance

In Object-Oriented Programming, the diamond inheritance refers the scenario that **a derived class has two or more base classes**.

When using the `super` keyword on a diamond inheritance chain, it should be noted that it will call **the relevant function of each contract in the inheritance chain, not just the nearest parent contract**.

First, we write a base contract called `God`. Then we write two contracts `Adam` and `Eve` inheriting from `God` contract. Lastly, we write another contract `people` inheriting from `Adam` and `Eve`. Each contract has two functions, `foo()` and `bar()`:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* Inheritance tree visualized：
  God
 /  \
Adam Eve
 \  /
people
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
        Adam.foo();
    }
    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}
contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        Eve.foo();
    }
    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}
contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }
    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
```
In this example, calling the `super.bar()` function in the people contract will call the `Eve`, `Adam`, and `God `contract's `bar()` function, which is different from ordinary multiple inheritance.

Although `Eve` and `Adam` are both child contracts of the `God` parent contract, the `God` contract will only be called once in the whole process. This is because Solidity borrows the paradigm from Python, forcing a DAG (directed acyclic graph) composed of base classes to guarantee a specific order based on C3 Linearization. For more information on inheritance and linearization, read the official [Solidity docs here](https://docs.soliditylang.org/en/v0.8.17/contracts.html#multiple-inheritance-and-linearization).

#### Summary
In this tutorial, I learned the basic uses of inheritance in Solidity, including simple inheritance, multiple inheritance, inheritance of modifiers and constructors, and calling functions from parent contracts.

</details>

### 2024.10.07
<details>
<summary>14. Abstract and Interface</summary>

#### Abstract contract
If a contract contains at least one unimplemented function (no contents in the function body `{}`), it must be labeled as `abstract`; Otherwise it will not compile. Moreover, the unimplemented function needs to be labeled as `virtual`. Take our previous Insertion Sort Contract as an example, if we haven't figured out how to implement the insertion sort function, we can mark the contract as `abstract`, and let others overwrite it in the future.
```solidity
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```

#### Interface

The `interface` contract is similar to the `abstract` contract, but it requires no functions are implemented. Rules of the interface:
1. Cannot contain state variables.
2. Cannot contain constructors.
3. Cannot inherit non-interface contracts.
4. All functions must be external and cannot have contents in the function body.
5. The contract that inherits the interface contract must implement all the functions defined in it.

Although the interface does not implement any functionality, it is the skeleton of smart contracts. Interface defines what the contract does and how to interact with them: if a smart contract implements an interface (like `ERC20` or `ERC721`), other Dapps and smart contracts will know how to interact with it. Because it provides two important pieces of information:
1. The `bytes4` selector for each function in the contract, and the function signatures `function name (parameter type)`.
2. Interface id (see [EIP165](https://eips.ethereum.org/EIPS/eip-165) for more information)

In addition, the interface is equivalent to the contract `ABI` (Application Binary Interface), and they can be converted to each other: compiling the interface contract will give you the contract `ABI`, and [abi-to-sol tool](https://gnidan.github.io/abi-to-sol/) will convert the `ABI` back to the interface contract.

We take `IERC721` contract, the interface for the `ERC721` token standard, as an example. It consists of 3 events and 9 functions, which all `ERC721` contracts need to implement. In interface, each function ends with `;` instead of the function body `{ }`. Moreover, every function in interface contract is by default `virtual`, so you do not need to label function as `virtual` explicitly.
```solidity
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
}
```

##### IERC721 Event
`IERC721` contains 3 events.
- `Transfer` event: emitted during transfer, records the sending address `from`, the receiving address `to`, and `tokenId`.
- `Approval` event: emitted during approval, records the token owner address `owner`, the approved address `approved`, and `tokenId`.
- `ApprovalForAll` event: emitted during batch approval, records the `owner` address owner of batch approval, the approved address `operator`, and whether the approve is enabled or disabled `approved` .

##### IERC721 Function
`IERC721` contains 3 events.
- `balanceOf`: Count all NFTs held by an owner.
- `ownerOf`: Find the owner of an NFT (`tokenId`).
- `transferFrom`: Transfer ownership of an NFT with `tokenId` from `from` to `to`.
- `safeTransferFrom`: Transfer ownership of an NFT with `tokenId` from `from` to `to`. Extra check: if the receiver is a contract address, it will be required to implement the `ERC721Receiver` interface.
- `approve`: Enable or disable another address to manage your NFT.
- `getApproved`: Get the approved address for a single NFT.
- `setApprovalForAll`: Enable or disable approval for a third party to manage all your NFTs in this contract.
- `isApprovedForAll`: Query if an address is an authorized operator for another address.
- `safeTransferFrom`: Overloaded function for safe transfer, containing data in its parameters.

##### When to use an interface?
If we know that a contract implements the `IERC721` interface, we can interact with it without knowing its detailed implementation.

The Bored Ape Yacht Club `BAYC` is an `ERC721` NFT, which implements all functions in the `IERC721` interface. We can interact with the `BAYC` contract with the `IERC721` interface and its contract address, without knowing its source code. For example, we can use `balanceOf()` to query the `BAYC` balance of an address, or use `safeTransferFrom()` to transfer a BAYC NFT.
```solidity
contract interactBAYC {
    // Use BAYC address to create interface contract variables (ETH Mainnet)
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    // Call BAYC's balanceOf() to query the open interest through the interface
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }

    // Safe transfer by calling BAYC's safeTransferFrom() through the interface
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
        BAYC.safeTransferFrom(from, to, tokenId);
    }
}
```

#### Summary
In this chapter, I learned the `abstract` and `interface` contracts in Solidity, which are used to write contract templates and reduce code redundancy. We also learned the interface of `ERC721` token standard and how to interact with the `BAYC` contract using interface.

#### Question
2. Can contracts marked as abstract be deployed?
A. Yes
B. No
C. If the subcontracts that implement all functions have been deployed, the contract can be deployed.

<details>
<summary>answer</summary>
B. No
</details>

</details>

### 2024.10.08
<details>
<summary>15. Errors</summary>

#### Errors
Solidity has many functions for error handling. Errors can occur at compile time or runtime.

##### Error
`error` statement is a new feature in solidity `0.8`. It saves gas and informs users why the operation failed. It is the recommended way to throw error in solidity. Custom errors are defined using the error statement, which can be used inside and outside of contracts. Below, we created a `TransferNotOwner` error, which will throw an error when the caller is not the token `owner` during transfer:
```solidity
error TransferNotOwner(); // custom error
```
In functions, `error` must be used together with `revert` statement.
```solidity
function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
    }
    _owners[tokenId] = newOwner;
}
```
The `transferOwner1()` function will check if the caller is the owner of the token; if not, it will throw a `TransferNotOwner` error and revert the transaction.

##### Require
`require` statement was the most commonly used method for error handling prior to solidity `0.8`. It is still popular among developers. 

Syntax of require:
```solidity
require(condition, "error message");
```
An exception will be thrown when the condition is not met.

Despite its simplicity, the gas consumption is higher than `error` statement: the gas consumption grows linearly as the length of the error message increases. 

Now, let's rewrite the above `transferOwner` function with the require statement:
```solidity
function transferOwner2(uint256 tokenId, address newOwner) public {
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    _owners[tokenId] = newOwner;
}
```

##### Assert
The `assert` statement is generally used for debugging purposes, because it does not include error message to inform the user. Syntax of `assert`: 
```solidity
assert(condition);
```
If the condition is not met, an error will be thrown.

Let's rewrite the `transferOwner` function with the `assert` statement:
```solidity
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }
```

#### Gas comparison
Let's compare the gas consumption of `error`, `require`, and `assert`. You can find the gas consumption for each function call with the Debug button of the remix console:
1. gas for `error`: 24457 `wei`
2. gas for `require`: 24755 `wei`
3. gas for `assert`: 24473 `wei`

We can see that the `error` consumes the least gas, followed by the `assert`, while the `require` consumes the most gas! Therefore, `error` not only informs the user on the error message, but also saves gas.

#### Summary
In this chapter, I learned 3 statements to handle errors in Solidity: `error`, `require`, and `assert`. After comparing their gas consumption, `error` statement is the cheapest, while `require` has the highest gas consumption.

</details>

### 2024.10.09
<details>
<summary>16. Overloading</summary>

#### Overloading
Solidity allows function overloading, that is, functions with the same name but different input parameter types can exist at the same time, and they are considered different functions. Note that Solidity does not allow `modifier` overloading.

##### function overloading

For example, we can define two functions, both called `saySomething()`, one that takes no parameters and outputs `"Nothing"`, and the other that takes a `string` parameter and outputs the `string`.
```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```

After compiling, all overloading functions become different function selectors due to different parameter types. For specific information on function selectors, please refer to [ WTF Solidity Tutorial: 29. Function Selector](https://github.com/AmazingAng/WTF-Solidity/tree/main/29_Selector).

Take the `Overloading.sol` contract as an example. After compiling and deploying on Remix, the overloaded functions `saySomething()` and `saySomething(string memory something)` are called respectively. You can see that they return different results and are divided into different functions.

##### Argument Matching
When calling an overloaded function, the input parameters will be matched with the variable types of the function parameters. If there are multiple matching overloaded functions, an error will be reported. The following example has two functions called `f()`, the type of one parameter is `uint8` and that of the other is `uint256`:
```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```

We call `f(50)`. Because `50` can be converted to either `uint8` or `uint256`, so an error will be reported.

#### Summary
In this chapter, I learned the basic usage of function overloading in Solidity: functions with the same name but **different input parameter types** can exist at the same time, and they are regarded as **different functions**.

</details>

### 2024.10.10
<details>
<summary>17. Library: Standing on the shoulders of giants</summary>

#### Library Functions
A library function is a special contract that exists to improve the reusability of solidity and reduce gas consumption. Library contracts are generally a collection of useful functions (library functions), which are created by the masters or the project party. We only need to stand on the shoulders of giants and use those functions.

It differs from ordinary contracts in the following points:
1. State variables are not allowed
2. Cannot inherit or be inherited
3. Cannot receive ether
4. Cannot be destroyed

It should be noted that if the visibility of the function in the library contract is set to `public` or `external`, a `delegatecall` will be triggered when the function is called. If it is set to `internal`, it will not be triggered. For functions set to `private` visibility, they are only visible in the library contract and are not available in other contracts.

#### Strings Library Contract
`Strings Library Contract` is a code library that converts a `uint256` to the corresponding `string` type. The sample code is as follows:
```solidity
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) public pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) public pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) public pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
```
It mainly contains two functions, `toString()` converts `uint256` to `string`, `toHexString()` converts `uint256` to hexadecimal, and then converts it to `string`.

##### How to use library contracts
We use the `toHexString()` function in the String library function to demonstrate two ways of using the functions in the library contract.

1. `using for` command
Command `using A for B` can be used to attach library functions (from library `A`) to any type (`B`). After the instruction, **the function in the library `A` will be automatically added as a member of the `B` type variable**, which can be called directly. Note: When calling, this variable will be passed to the function as the first parameter:
```solidity
    // Using the library with the "using for" 
    using Strings for uint256;
    function getString1(uint256 _number) public pure returns(string memory){
        // Library functions are automatically added as members of uint256 variables
        return _number.toHexString();
    }
```
2. Called directly by the library contract name
```solidity
    // Called directly by the library contract name
    function getString2(uint256 _number) public pure returns(string memory){
        return Strings.toHexString(_number);
    }
```

#### Summary

In this lecture, we use the referenced library function `Strings` of `ERC721` as an example to learn the library function (`Library`) in solidity. 99% of developers do not need to write library contracts themselves, they can use the ones written by masters. The only thing we need to know is which library contract to use and where the library is most suitable.

Some commonly used libraries are:
1. [Strings](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Strings.sol): Convert `uint256` to `string`
2. [Address](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Address.sol): Determine whether an address is a contract address
3. [Create2](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Create2.sol): Safer use of Create2 EVM opcode
4. [Arrays](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Arrays.sol): Library functions related to arrays


</details>

### 2024.10.11
<details>
<summary>18. Import</summary>

#### Usage of `import`
- Import by relative location of source file. For example：
```
Hierarchy
├── Import.sol
└── Yeye.sol
```
```solidity
// Import by relative location of source file
import './Yeye.sol';
```
- Import the global symbols of contracts on the Internet through the source file URL. For example：
```solidity
// Import by URL
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
```
- Import via the npm directory. For example:
```solidity
import '@openzeppelin/contracts/access/Ownable.sol';
```
- Import contract-specific global symbols by specifying `global symbols`. For example:：
```solidity
import {Yeye} from './Yeye.sol';
```
- The location of the reference (`import`) in the code: after declaring the version, and before the rest of the code.

#### Test import
We can use the following code to test whether the external source code was successfully imported:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Import by relative location of source file
import './Yeye.sol';
// Import contract-specific global symbols by specifying `global symbols`
import {Yeye} from './Yeye.sol';
// Import by URL
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// Import via the npm directory
import '@openzeppelin/contracts/access/Ownable.sol';

contract Import {
    // Successfully import the Address library
    using Address for address;
    // declare variable "yeye"
    Yeye yeye = new Yeye();

    // Test whether the function of "yeye" can be called
    function test() external{
        yeye.hip();
    }
}
```

#### Summary
In this lecture, I learned the method of importing external source code using the `import` keyword. Through the import, you can refer to contracts or functions in other files written by us, or directly import code written by others, which is very convenient.

</details>

### 2024.10.12
<details>
<summary>19. Receive ETH, receive and fallback</summary>

Solidity has two special functions, `receive()` and `fallback()`, they are primarily used in two circumstances.
1. Receive Ether
2. Handle calls to contract if none of the other functions match the given function signature (e.g. proxy contract)

Note⚠️: Prior to solidity `0.6.x`, only `fallback()` was available, for receiving Ether and as a fallback function.
After version `0.6`, `fallback()` was separated to `receive()` and `fallback()`.

In this tutorial, we focus on receiving Ether.

#### Receiving ETH Function: `receive()`
The `receive()` function is solely used for receiving ETH. A contract can have at most one `receive()` function, declared not like others, no function keyword is needed: `receive() external payable { ... }`. This function cannot have arguments, cannot return anything and must have `external` visibility and `payable` state mutability.

`receive()` is executed on plain Ether transfers to a contract. You should not perform too many operations in `receive()` when sending Ether with `send` or `transfer`, only 2300 gas is available, and complicated operations will trigger an `Out of Gas` error; instead, you should use `call` function which can specify gas limit. (We will cover all three ways of sending Ether later).

We can send an `event` in the `receive()` function, for example:
```solidity
    // Declare event
    event Received(address Sender, uint Value); 
    // Emit Received event
    receive() external payable {
        emit Received(msg.sender, msg.value); 
    }
```
Some malicious contracts intentionally add codes in `receive()` (`fallback()` prior to Solidity `0.6.x`), which consume massive gas or cause the transaction to get reverted. So that will make some refund or transfer functions fail, pay attention to such risks when writing such operations.

#### Fallback Function: fallback()
The `fallback()` function is executed on a call to the contract if none of the other functions match the given function signature, or if no data was supplied at all and there is no receive Ether function. It can be used to receive Ether or in proxy contract. `fallback()` is declared without the function keyword, and must have `external` visibility, it **often** has `payable` state mutability, which is used to receive Ether: `fallback() external payable { ... }`.

Let's declare a `fallback()` function, which will send a `fallbackCalled` event, with `msg.sender`, `msg.value` and `msg.data` as parameters:
```solidity
    event fallbackCalled(address Sender, uint Value, bytes Data); 

    // fallback
    fallback() external payable{
        emit fallbackCalled(msg.sender, msg.value, msg.data); 
    }
```
#### Difference between receive and fallback
```
Execute fallback() or receive()?
         Receive ETH
              |
      msg.data is empty?
            /  \
          Yes   No
          /      \
Has receive()?   fallback()
        / \
      Yes  No
      /     \
receive()   fallback()
```
To put it simply, when a contract receives ETH, `receive()` will be executed if `msg.data` is empty and the `receive()` function is present; on the other hand, `fallback()` will be executed if `msg.data` is not empty or there is no `receive()` declared, in such case `fallback()` must be payable.

If neither `receive()` or `payable` `fallback()` is declared in the contract, receiving ETH will fail.

#### Summary
In this tutorial, I learned two special functions in Solidity, `receive()` and `fallback()`, they are mostly used in receiving ETH, and `proxy contract`.

</details>

### 2024.10.14
<details>
<summary>20. Sending ETH</summary>

There are three ways of sending ETH in Solidity: `transfer()`, `send()` and `call()`, in which `call()` is recommended.

#### Contract of Receiving ETH
Let's deploy a contract `ReceiveETH` to receive ETH. `ReceiveETH` has an event Log, which logs the received ETH amount and the remaining gas. Along with two other functions, one is the `receive()` function, which is executed when receiving ETH, and emits the Log event; the other is the `getBalance()` function that is used to get the balance of the contract.
```solidity
contract ReceiveETH {
    // Receiving ETH event, log the amount and gas
    event Log(uint amount,  uint gas);
    
    // receive() is executed when receiving ETH
    receive() external payable{
        emit Log(msg.value,  gasleft());
    }
    
    // return the balance of the contract
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}
```
After deploying `ReceiveETH`, call the `getBalance()` function, we can see the balance is `0` Ether.

#### Contract of Sending ETH
We will implement three ways to send ETH to the `ReceiveETH` contract. First, let's make the `constructor` of the `SendETH` contract `payable`, and add the `receive()` function, so we can transfer ETH to our contract at deployment and after.
```solidity
contract SendETH {
    // constructor, make it payable so we can transfer ETH at deployment
    constructor() payable{}
    // receive() function, called when receiving ETH
    receive() external payable{}
}
```

##### `transfer`
- Usage: `receiverAddress.transfer(value in Wei)`.
- The gas limit of `transfer()` is `2300`, which is enough to make the transfer, but not if the receiving contract has a gas-consuming `fallback()` or `receive()`.
- If `transfer()` fails, the transaction will revert.

Sample code: note that `_to` is the address of the `ReceiveETH` contract, and `amount` is the value you want to send.
```solidity
// sending ETH with transfer()
function transferETH(address payable _to,  uint256 amount) external payable{
	_to.transfer(amount);
}
```
After deploying the `SendETH` contract, we can send ETH to the `ReceiveETH` contract. If `amount` is `10`, and `value` is `0`, `amount` > `value`, the transaction fails and gets reverted.

If `amount` is `10`, and `value` is `10`, `amount` <= `value`, then the transaction will go through.

In the `ReceiveETH` contract, when we call `getBalance()`, we can see the balance of the contract is `10 Wei`.

##### `send`
- Usage: `receiverAddress.send(value in Wei)`.
- The gas limit of `send()` is `2300`, which is enough to make the transfer, but not if the receiving contract has a gas-consuming `fallback()` or `receive()`.
- If `send()` fails, the transaction will **not** be reverted.
- The return value of `send()` is `bool`, which is the status of the transaction, you can choose to act on that.

Sample Code:
```solidity
// sending ETH with send()
function sendETH(address payable _to,  uint256 amount) external payable{
    // check result of send()，revert with error when failed
    bool success = _to.send(amount);
    if(!success){
    	revert SendFailed();
    }
}
```
Now we send ETH to the `ReceiveETH` contract, if `amount` is `10`, and `value` is `0`, `amount` > `value`, the transaction fails, since we handled the return value, the transaction will be reverted.

If `amount` is `10`, and `value` is `11`, `amount` <= `value`, then the transaction will go through.

##### `call`
- Usage: `receiverAddress.call{value: value in Wei}("")`.
- There is **no gas limit** for `call()`, so it supports more operations in `fallback()` or `receive()` of the receiving contract.
- If `call()` fails, the transaction will **not** be reverted.
- The return value of `call()` is `(bool,  data)`, in which `bool` is the status of the transaction, you can choose to act on that.

Sample Code:
```solidity
// sending ETH with call()
function callETH(address payable _to,  uint256 amount) external payable{
    // check result of call()，revert with error when failed
    (bool success, ) = _to.call{value: amount}("");
    if(!success){
    	revert CallFailed();
    }
}
```
Now we send ETH to the `ReceiveETH` contract, if `amount` is `10`, and `value` is `0`, `amount` > `value`, the transaction fails, since we handled the return value, the transaction will be reverted.

If `amount` is `10`, and `value` is `11`, `amount` <= `value`, the transaction is successful.

With any of these three methods, we send ETH to the `ReceiveETH` contract successfully.

#### Summary

In this tutorial, we talked about three ways of sending ETH in solidity: `transfer`, `send` and `call`.

- There is **no gas limit** for `call`, which is the most flexible and recommended way.
- The gas limit of `transfer` is `2300` gas, transaction will be reverted if it fails, which makes it the second choice.
- The gas limit of `send` is `2300` gas, the transaction will **not** be reverted if it fails, which makes it the worst choice.

</details>

### 
<!-- Content_END -->
