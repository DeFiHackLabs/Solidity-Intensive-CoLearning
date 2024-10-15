

# YourName

1. 自我介绍

2. 你认为你会完成本次残酷学习吗？
   
## Notes

<!-- Content_START -->

### 2024.09.23

今天學了function, event, static variables, 還有好像是qualifier一樣的東西，constant, internal, private, public。 
function還有modifier，可以設置啟動某function的條件。
還學到了boollean和一些運算式，很多都是比以前學過的東西。
現在就算小小複習一下，明天會更認真學！

### 2024.09.24

**constant**
constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。
**immutable**
immutable变量可以在声明时或构造函数中初始化，因此更加灵活。在Solidity v8.0.21以后，immutable变量不需要显式初始化，未显式初始化的immutable变量将使用数值类型的初始值（见 8. 变量初始值）。反之，则需要显式初始化。 若immutable变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。

### 2024.09.25
今天試著做一個很簡單的計算器還有一個很簡單的Twitter工具，然後deploy，view on etherscan.
另外還去了Ethereum Sepolia Faucet 拿了一點testnet用的Eth。

```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract Calculator {
    uint256 result = 0;
    function add( uint256 num) external {
        result += num;
    }
    function subtract(uint256 num) public {
        result -= num;
    }
    function multiply(uint256 num) public {
        result *= num;
    }
    function get() public view  returns (uint256) {
        return result;
    }
}
```
另外學了Mapping和array。
Mapping，就相當於給每個value 一個 key
每個Array都有對應的從0開始的Index. 
以上。

### 2024.09.27
昨天忘記更新，今天補上，今天嘗試理解了以下的代碼:
```
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Twitter {

    //mapping address to string and call it tweets
    mapping(address => string[]) public tweets;

    function createTwitter (string memory _tweet) public {
    // memory means store as temporary memory
        tweets[msg.sender].push(_tweet);
    }
    // mapping is both key and value, could be addresses to names. So you can find name by address 

    function getTweet(address _owner, uint _i) public view returns (string memory){
        return tweets[_owner][_i];
        // view is more gas efficient
    }

    function getAllTweets(address _owner) public view returns (string[] memory){
        return tweets[_owner];
    }

}

```

試圖了解create function 時整個代碼的結構，這樣寫起來更知道，下一個單詞是為什麼存在的:
總共有九個部分:
1. function keyword
2. function name
3. parameters
4. visibility specifier
5. state mutability keyword
6. return type
7. function body
8. local variable declaration
9. return statement

然後了解了struct，知道怎麼寫，什麼時候用:

When to Use a Struct
- When You Have Multiple Related Data Fields
- When You Want to Improve Code Readability
 -When You Need to Reuse a Logical Grouping of Data
 -When You Need a Data Model in a Mapping or Array

When Not to Use a Struct:

- For Simple Data: If your data is very simple (e.g., just a `uint` or a `string`), using a struct may be overkill. Structs are useful when there are multiple related fields.
- When Performance Is a Concern: Structs in Solidity are stored in memory or storage, which might consume more gas compared to simpler types, especially if the struct is large and complex. Use them wisely, considering the gas cost.

了解MAPPING的結構:
This line of code declares a public mapping in Solidity:

```solidity
mapping(address => string[]) public tweets;

```

Here's what it does:

- It creates a mapping called "tweets"
- The key to this mapping is an Ethereum address
- The value associated with each address is an array of strings
- Each address can have multiple tweets (stored as strings in the array)
- The 'public' keyword automatically creates a getter function for this mapping

In the context of a Twitter-like contract, this mapping allows each Ethereum address (user) to have an array of tweets associated with it. Users can add tweets to their array, and anyone can retrieve tweets for a specific address.

以上。

### 2024.09.29
Ethereum Client

安裝Parity, Open Ethereum, but were all deprecated. 

Installed Go Ethereum

https://geth.ethereum.org/downloads

 Node and 

Node.js Truffle (CLI Ganache)  through the terminal. 

https://medium.com/@1chooo/如何在-mac-安裝-node-js-npm-3d7101d998f4

https://nodejs.org/zh-tw/download/package-manager

https://archive.trufflesuite.com/docs/truffle/how-to/install/

- **Step 1 (`mkdir greeter`)**: Creates a new folder called `greeter` to organize your project files.
- **Step 2 (`cd greeter`)**: Moves into the `greeter` folder so that you can start working on your project.
- **Step 3 (`truffle init`)**: Initializes a new Truffle project inside the `greeter` folder, generating the basic structure needed for Ethereum smart contract development.

Since you're inside the `greeter` directory, you can simply run:

```bash
bash
複製程式碼
ls -l
```

### CLI commands:
Installing `brew` for directory `tree`: `brew install tree`, but brew must be installed first. 

Show all files within every folder:`tree -a`

Notice that the commands specified in the output line up well with the directory structure generated when initializing our application. truffle compile will compile all the contracts in the contracts directory, truffle migrate will deploy our compiled contracts by running the scripts in our migrations directory, and lastly, truffle test will run the tests in our test directory.


### 2024.09.30
Reference Type (要聲明數據儲存位置)

1. Array
2. Struct

數據儲存位置有三類: 

1. Storage: default on-chain
2. Memory: temporary variable, 通常這些數據都不需要上鏈。編譯器不知道在何處儲存這些變量內容。
3. Calldata: similar to memory but immutable. 

變長 (Variable-length):
String, bytes, dynamic array(`uint[]`, `address[]`). 

### 状态变量 State Variable

`gas`消耗高，因為是存在鏈上的數據變量，所有合約函數都可以訪問。

### 局部变量 Local Variable

`gas`低，僅在函數執行過程中有效的變量

### 全局变量 Global Variable

https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions

```solidity
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```

常見全局變量:

- `blockhash(uint blockNumber)`: (`bytes32`) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
- `block.coinbase`: (`address payable`) 当前区块矿工的地址
- `block.gaslimit`: (`uint`) 当前区块的gaslimit
- `block.number`: (`uint`) 当前区块的number
- `block.timestamp`: (`uint`) 当前区块的时间戳，为unix纪元以来的秒
- `gasleft()`: (`uint256`) 剩余 gas
- `msg.data`: (`bytes calldata`) 完整call data
- `msg.sender`: (`address payable`) 消息发送者 (当前 caller)
- `msg.sig`: (`bytes4`) calldata的前四个字节 (function identifier)
- `msg.value`: (`uint`) 当前交易发送的 `wei` 值
- `block.blobbasefee`: (`uint`) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
- `blobhash(uint index)`: (`bytes32`) 返回跟当前交易关联的第 `index` 个blob的版本化哈希（第一个字节为版本号，当前为`0x01`，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。

### **4. 全局变量-以太单位与时间单位**

**以太单位**

`Solidity`中不存在小数点，以`0`代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。

- `wei`: 1
- `gwei`: 1e9 = 1000000000
- `ether`: 1e18 = 1000000000000000000

```
function weiUnit() external pure returns(uint) {
    assert(1 wei == 1e0);
    assert(1 wei == 1);
    return 1 wei;
}

function gweiUnit() external pure returns(uint) {
    assert(1 gwei == 1e9);
    assert(1 gwei == 1000000000);
    return 1 gwei;
}

function etherUnit() external pure returns(uint) {
    assert(1 ether == 1e18);
    assert(1 ether == 1000000000000000000);
    return 1 ether;
}
```

Convert Gwei to Ether:

Convert Ether to USD by multiply its price in USD. 

**时间单位**

可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在`Solidity`中是一个重要的概念，有助于提高合约的可读性和可维护性。

- `seconds`: 1
- `minutes`: 60 seconds = 60
- `hours`: 60 minutes = 3600
- `days`: 24 hours = 86400
- `weeks`: 7 days = 604800

### Mappings in Solidity

Mappings are a data structure in Solidity used to store **key-value pairs**. You can think of them as **hash tables**. Mappings allow you to retrieve a value by providing a key, like looking up a person's wallet address using their ID.

### Declaration

Mappings are declared using the format `mapping(_KeyType => _ValueType)`, where `_KeyType` is the type of the key and `_ValueType` is the type of the value.

Example:

```solidity
solidity
複製程式碼
mapping(uint => address) public idToAddress; // ID mapped to address
mapping(address => address) public swapPair; // Address mapped to another address

```

### Rules for Mappings

1. **Key Type Restrictions**:
    - The key type (`_KeyType`) must be a built-in Solidity type like `uint` or `address`. You **cannot** use custom structs as the key.
    - The value type (`_ValueType`) can be any type, including custom structs.
    
    Example of incorrect usage (this will cause an error):
    
    ```solidity
    struct Student {
        uint256 id;
        uint256 score;
    }
    mapping(Student => uint) public testVar; // Error: Custom struct as key
    
    ```
    
2. **Storage Requirement**:
    
    Mappings must be stored in **storage**, meaning they can be used as **state variables** within contracts, but cannot be used as parameters or return types in public functions because mappings represent relationships (key-value pairs) and not direct data.
    
3. **Automatic Getter**:
    
    If a mapping is declared as `public`, Solidity automatically creates a getter function, allowing you to look up values by providing the key.
    
4. **Adding Key-Value Pairs**:
    
    To add key-value pairs, use the following syntax:
    
    ```solidity
    solidity
    複製程式碼
    _Var[_Key] = _Value;
    
    ```
    
    Example:
    
    ```solidity
    function writeMap(uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
    }
    
    ```
    

### How Mappings Work

1. **No Key Storage**:
    
    Mappings **do not store** any information about the keys and do not have a `length` property.
    
2. **Data Access**:
    
    The value in the mapping is accessed using a hash (`keccak256(abi.encodePacked(key, slot))`), where `slot` is the storage slot where the mapping is declared.
    
3. **Default Values**:
    
    If a key has no associated value, the default value for that type is returned. For example, for `uint`, the default value is `0`.
    

---

### Simplified Summary:

- **Mapping**: A data structure that stores key-value pairs, like a hash table.
- **Key**: Must be a basic type (e.g., `uint`, `address`).
- **Value**: Can be any type, including custom types.
- Mappings are stored in **storage** and cannot be passed as parameters or returned from public functions.
- **No length or key storage**: Mappings don't store the keys or have a `length` property.
- **Default value**: Unused keys return default values (e.g., `0` for `uint`).

---

**Example 4-6. Testing the greeting can be made dynamic**

```jsx
const GreeterContract = artifacts.require("Greeter");
contract("Greeter", () => {
	it("has been deployed successfully", async () => {
		const greeter = await GreeterContract.deployed();
		assert(greeter, "contract failed to deploy");
});

describe("greet()", () => {
	it("returns 'Hello, World!'", async () => {
		const greeter = await GreeterContract.deployed();
		const expected = "Hello, World!";
		const actual = await greeter.greet();

    assert.equal(actual, expected, "greeted with 'Hello, World!'");
    });
  });
});

contract("Greeter: update greeting", () => {
  describe("setGreeting(string)", () => {

it("sets greeting to passed in string", async () => {
    const greeter = await GreeterContract.deployed()
    const expected = "Hi there!";

    await greeter.setGreeting(expected);
    const actual = await greeter.greet();

    assert.equal(actual, expected, "greeting was not updated");
   });
 });
});
```

```
  assert.equal(actual, expected, "greeted with 'Hello, World!'");
});

```

});
});

contract("Greeter: update greeting", () => {
describe("setGreeting(string)", () => {

**Example 4-7. Adding setGreeting() to Greeter**

```solidity

function setGreeting(string calldata greeting) external {
}
```

**Example 4-8. Adding state variable to Greeter contract**

```solidity
pragma solidity >= 0.4.0 < 0.7.0;

contract Greeter {
    string private _greeting;

function greet() external pure returns(string memory) {
        return "Hello, World!";
    }

function setGreeting(string calldata greeting) external {

    }

}
```

**Example 4-10. Reading from our state variable**

```solidity
pragma solidity >= 0.4.0 < 0.7.0;

contract Greeter {
    string private _greeting = "Hello, World!";

function greet() external view returns(string memory) {
        return _greeting;
    }

function setGreeting(string calldata greeting) external {
        _greeting = greeting;
}

}
```
### 2024.10.01
#### Constant and Immutable

In this lesson, we introduce two keywords in Solidity related to constants: `constant` and `immutable`. Once a state variable is declared with either of these keywords, its value cannot be changed after initialization. Using constants in this way enhances the contract’s security and reduces gas costs.

Additionally, only numeric types can be declared with both `constant` and `immutable`. Strings and bytes can be declared as `constant`, but not as `immutable`.

### `constant` and `immutable`

### `constant`

A `constant` variable must be initialized at the time of declaration, and its value cannot be changed afterward. If you try to modify it, the code won’t compile.

```solidity

// A constant variable must be initialized at the time of declaration and cannot be changed
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

```

### `immutable`

An `immutable` variable offers more flexibility because it can be initialized either at the time of declaration or within the constructor. In Solidity version 8.0.21 and later, `immutable` variables don’t need to be explicitly initialized. If not explicitly initialized, they will default to their initial values (based on their type, as discussed in the variable initialization section). If you initialize an `immutable` variable both at the time of declaration and in the constructor, the value from the constructor will be used.

```solidity

// An immutable variable can be initialized in the constructor and cannot be changed afterward
uint256 public immutable IMMUTABLE_NUM = 9999999999;

// In Solidity 8.0.21 and later, the following variables default to their initial values
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;

```

You can use global variables (like `address(this)` or `block.number`) or custom functions to initialize `immutable` variables. In the following example, we use the `test()` function to initialize `IMMUTABLE_TEST` to 9:

```solidity

// The constructor is used to initialize immutable variables
constructor() {
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}

function test() public pure returns(uint256) {
    uint256 value = 9;
    return value;
}

```

This makes `immutable` variables more flexible compared to `constant`, as they can be set at runtime in the constructor, while still offering the same benefits once initialized.

A `constructor` in Solidity is a special function that is automatically executed once when a contract is deployed. It is used to initialize the contract's state variables or perform any setup tasks that are necessary at the time of contract deployment.

### Initial Values of Variables

In Solidity, any variable that is declared but not assigned a value is automatically given an initial or default value. In this lesson, we'll cover the default values for commonly used variables.

### Default Values for Value Types:

- **Boolean**: `false`
- **String**: `""` (empty string)
- **Integer (`int`)**: `0`
- **Unsigned Integer (`uint`)**: `0`
- **Enum**: The first element in the enum list
- **Address**: `0x0000000000000000000000000000000000000000` (or `address(0)`)
- **Functions**:
    - **Internal**: Empty function
    - **External**: Empty function

You can verify these initial values by using the getter functions of public variables:

```solidity
solidity
複製程式碼
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000

enum ActionSet { Buy, Hold, Sell }
ActionSet public _enum; // The first element (Buy) with an index of 0

function fi() internal {} // Empty internal function
function fe() external {} // Empty external function

```

### Default Values for Reference Types:

- **Mappings**: All elements in the mapping are set to their default values.
- **Structs**: All members of the struct are initialized to their default values.
- **Arrays**:
    - **Dynamic Arrays**: `[]` (empty array)
    - **Static Arrays** (fixed-length): All elements are initialized to their default values.

You can also use public variables to verify the default values of reference types:

```solidity

// Reference Types
uint[8] public _staticArray; // Static array where all elements are initialized to 0: [0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // Dynamic array initialized as an empty array: []
mapping(uint => address) public _mapping; // Mapping where all elements default to 0x0000000000000000000000000000000000000000

// Struct with all members initialized to default values (0, 0)
struct Student {
    uint256 id;
    uint256 score;
}
Student public student;

```

`delete` Operator:

The `delete` operator resets a variable to its initial or default value.

```solidity

// delete operator
bool public _bool2 = true;
function d() external {
    delete _bool2; // Using delete will reset _bool2 to its default value, which is false
}

```

By using the `delete` operator, you can revert variables back to their original default state.

### Control Flow

Solidity's control flow is similar to other programming languages and mainly includes the following:

### `if-else`

```solidity
solidity
複製程式碼
function ifElseTest(uint256 _number) public pure returns(bool) {
    if(_number == 0) {
        return true;
    } else {
        return false;
    }
}

```

### `for` Loop

```solidity
solidity
複製程式碼
function forLoopTest() public pure returns(uint256) {
    uint sum = 0;
    for(uint i = 0; i < 10; i++) {
        sum += i;
    }
    return sum;
}

```

### `while` Loop

```solidity
solidity
複製程式碼
function whileTest() public pure returns(uint256) {
    uint sum = 0;
    uint i = 0;
    while(i < 10) {
        sum += i;
        i++;
    }
    return sum;
}

```

### `do-while` Loop

```solidity
solidity
複製程式碼
function doWhileTest() public pure returns(uint256) {
    uint sum = 0;
    uint i = 0;
    do {
        sum += i;
        i++;
    } while(i < 10);
    return sum;
}

```

### Ternary Operator

The ternary operator is the only operator in Solidity that takes three operands. The syntax is: `condition ? expression if true : expression if false`. It is often used as a shortcut for `if` statements.

```solidity

// Ternary operator
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256) {
    // Return the larger of x and y
    return x >= y ? x : y;
}

```

Additionally, the keywords `continue` (which skips to the next iteration of a loop) and `break` (which exits the current loop) can be used in Solidity.

### Insertion Sort in Solidity

Before we begin: Over 90% of people writing insertion sort in Solidity make mistakes.

### Insertion Sort

Sorting algorithms are used to arrange an unordered set of numbers, such as `[2, 5, 3, 1]`, in ascending order. Insertion sort is one of the simplest sorting algorithms, and it's often the first algorithm many people learn. The idea is straightforward: from left to right, compare each number with the ones before it. If the current number is smaller, swap its position with the previous one. Here's an illustration:

### Python Code

Let’s first look at the Python code for insertion sort:

```python

# Python program for implementation of Insertion Sort
def insertionSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1
        while j >= 0 and key < arr[j]:
            arr[j+1] = arr[j]
            j -= 1
        arr[j+1] = key
    return arr

```

### Rewriting it in Solidity (with a bug)

It takes only 8 lines of Python to implement insertion sort. It seems simple. Now, after converting it to Solidity, with corresponding functions, variables, and loops, it takes just 9 lines of code:

```solidity

// Incorrect Insertion Sort
function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {
    for (uint i = 1; i < a.length; i++) {
        uint temp = a[i];
        uint j = i - 1;
        while((j >= 0) && (temp < a[j])) {
            a[j+1] = a[j];
            j--;
        }
        a[j+1] = temp;
    }
    return a;
}

```

But when I ran it in Remix with input `[2, 5, 3, 1]`, BOOM! There was a bug! I tried to fix it for a long time but couldn’t find the issue. I then googled "Solidity insertion sort" and discovered that most tutorials online had mistakes, for example, "Sorting in Solidity without Comparison."

### The Correct Solidity Insertion Sort

After hours of debugging and with help from a friend in the Dapp-Learning community, we finally found the bug. In Solidity, the `uint` type (unsigned integer) cannot hold negative values. In the insertion sort algorithm, the variable `j` might become `-1`, causing an underflow error.

To fix this, we need to adjust the code so that `j` cannot become negative. Here is the correct code:

```solidity
solidity
複製程式碼
// Correct Insertion Sort
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // Note that uint cannot take a negative value
    for (uint i = 1; i < a.length; i++) {
        uint temp = a[i];
        uint j = i;
        while((j >= 1) && (temp < a[j-1])) {
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return a;
}

```

### Result:

Input `[2, 5, 3, 1]`, output `[1, 2, 3, 5]`.

Now it works correctly!

---

### Constructor and Modifier in Solidity: Ownable Example

In this lesson, we'll use the **Ownable** contract as an example to explain the **constructor** and **modifiers** in Solidity.

### Constructor

The **constructor** is a special function in Solidity. Each contract can define one constructor, and it runs automatically **once** when the contract is deployed. It is often used to initialize contract parameters, such as setting the `owner` address of the contract.

For example:

```solidity
solidity
複製程式碼
address owner; // Define an owner variable

// Constructor function
constructor(address initialOwner) {
    owner = initialOwner; // Set the owner to the provided initialOwner address during contract deployment
}

```

**Note**: The syntax for constructors has changed in different versions of Solidity. Before Solidity version 0.4.22, constructors used the same name as the contract. This older method could lead to errors (e.g., a contract named `Parents` might accidentally have a constructor named `parents`, turning the constructor into a regular function). From Solidity 0.4.22 onwards, the constructor keyword was introduced to avoid these issues.

Here’s an example of the old constructor syntax:

```solidity
solidity
複製程式碼
pragma solidity =0.4.21;
contract Parents {
    // The function with the same name as the contract acts as the constructor
    function Parents () public {
    }
}

```

### Modifier

A **modifier** in Solidity is a unique syntax feature, similar to a **decorator** in object-oriented programming. It adds specific characteristics to functions and helps reduce code redundancy. A modifier is like Iron Man's armor: functions that use it get special behavior. Modifiers are commonly used for checks that need to be performed before executing the function body, such as verifying addresses, variables, or balances.

### Example: `onlyOwner` Modifier

We define a modifier called `onlyOwner` to restrict access to certain functions to the contract owner:

```solidity

// Define the modifier
modifier onlyOwner {
    require(msg.sender == owner); // Check if the caller is the owner
    _; // If true, execute the function body; otherwise, revert the transaction
}

```

Now, we can use this `onlyOwner` modifier to ensure that only the owner can execute the following function:

```solidity

function changeOwner(address _newOwner) external onlyOwner {
   owner = _newOwner; // Only the current owner can change the owner
}

```

In this `changeOwner` function, the owner of the contract can be changed, but only if the function is called by the current owner. If anyone else tries to call it, the function will revert and throw an error. This is a common way to control access and permissions in smart contracts.


### 2024.10.02
Testing deployment by Truffle on the terminal. 

```solidity
const GreeterContract = artifacts.require("Greeter");

module.exports = function(deployer) {
  deployer.deploy(GreeterContract);
}
```
Hello World! in javascript. 

```javascript
describe("greet()", () => {
  it("returns 'Hello, World!'", async () => {
    const greeter = await GreeterContract.deployed();
    const expected = "Hello, World!";
    const actual = await greeter.greet();

    assert.equal(actual, expected, "greeted with 'Hello, World!'");
  });
});
```
Adding the greet function to Greeter

```solidity


pragma solidity ^0.8.0;

contract Greeter {

    function greet() external pure returns(string memory) {
        return "Hello, World!";
    }
```
**Overloading**, allow different types of parameters in function, but not for modifier. 

```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```

**Argument Matching**, in overloading if the  ****

```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```

**Library**

1. using for A(library) for B(to any type)

庫A中的函數會自動添加為B類變量的成員（？）

```solidity
// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```

1. 通过库合约名称调用函数

```solidity
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```

Common library:

1. [**Strings**](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Strings.sol)：将**`uint256`**转换为**`String`**
2. [**Address**](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Address.sol)：判断某个地址是否为合约地址
3. [**Create2**](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Create2.sol)：更安全的使用**`Create2 EVM opcode`**
4. [**Arrays**](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Arrays.sol)：跟数组相关的库合约
### 2024.10.03

複習。

三元运算符（Ternary Operator）: 它可以在一行中实现 `if-else` 的功能。

```solidity
规则**条件? 条件为真的表达式:条件为假的表达式**。此运算符经常用作**if**语句的快捷方式。
*// 三元运算符 ternary/conditional operator*
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){    
		*// return the max of x and y*    
		return x >= y ? x: y; 
}
```

Constructor 一個合約會自動運行一次。用來初始化合約的個別參數。

```solidity
prgma solidity ^0.8.21;
contract Parents {
		// 與合約名Parent同名的函數就是構造函數
		function Parents () public {
		}
}
```

modifier

- 可以用来声明函数某些特性
- 主要使用场景是运行函数前的检查
- 可以减少代码冗余
- modifier类似面向对象编程中的decorator

---

### 1. `transfer(address,uint256)` 的函数选择器

- 函数签名：`transfer(address,uint256)`
- 通过 `keccak256` 进行哈希处理，结果是：
    
    ```solidity
    keccak256("transfer(address,uint256)") = 0xa9059cbb00000000000000000000000000000000000000000000000000000000
    ```
    
- 取前4个字节：
    
    ```solidity
    0xa9059cbb
    ```
    

因此，`transfer(address,uint256)` 的函数选择器是 **`0xa9059cbb`**。

---

### 2. `transferFrom(address,address,uint256)` 的函数选择器

- 函数签名：`transferFrom(address,address,uint256)`
- 通过 `keccak256` 进行哈希处理，结果是：
    
    ```solidity
    keccak256("transferFrom(address,address,uint256)") = 0x23b872dd00000000000000000000000000000000000000000000000000000000
    ```
    
- 取前4个字节：
    
    ```solidity
    0x23b872dd
    ```
    

因此，`transferFrom(address,address,uint256)` 的函数选择器是 **`0x23b872dd`**。

---

### 结论

- `transfer(address,uint256)` 的函数选择器是 **`0xa9059cbb`**
- `transferFrom(address,address,uint256)` 的函数选择器是 **`0x23b872dd`**

两个函数的函数选择器是不同的，因为它们的签名不同。

### 函数签名的作用

Solidity 编译器会根据函数签名生成一个 **函数选择器（Function Selector）**，这个选择器是合约调用时用于识别不同函数的。通过对函数签名进行 `keccak256` 哈希，然后截取哈希值的前 4 个字节，得到函数选择器。

### 函数签名的例子

### 1. `transfer(address,uint256)`

- 函数名称：`transfer`
- 参数类型列表：`address,uint256`

这个函数的签名就是：

```scss
scss
複製程式碼
transfer(address,uint256)

```

### 2. `transferFrom(address,address,uint256)`

- 函数名称：`transferFrom`
- 参数类型列表：`address,address,uint256`

这个函数的签名是：

```css
css
複製程式碼
transferFrom(address,address,uint256)

```

### 生成函数选择器的步骤

函数选择器由函数签名生成。步骤如下：

1. 从函数签名构建字符串，例如：`transfer(address,uint256)`。
2. 通过 `keccak256` 对这个字符串进行哈希计算，生成一个 32 字节的哈希值。
3. 取哈希值的前 4 个字节，这就是函数的选择器。

例如：

```solidity
solidity
複製程式碼
keccak256("transfer(address,uint256)") = 0xa9059cbb00000000000000000000000000000000000000000000000000000000

```

函数选择器就是：

```
複製程式碼
0xa9059cbb

```

### 注意

1. **函数名称相同，但参数类型不同**：即使函数名称相同，参数的类型或数量不同，它们的函数选择器也会不同。例如：
    - `foo(uint256 a)` 和 `foo(uint256 a, uint256 b)` 是不同的函数，它们有不同的签名，因此会有不同的选择器。
2. **参数类型相同但名称不同**：如果两个函数的名称相同、参数类型相同（即使参数名称不同），它们会有相同的选择器。例如：
    - `bar(address to, uint256 amount)` 和 `bar(address receiver, uint256 value)` 的函数签名是一样的，因为参数类型完全相同，生成的选择器也相同。

### 2024.10.04
Solidity有三种方法向其他合约发送ETH，他们是：transfer()，send()和call()，其中call()是被鼓励的用法。

接收ETH合约
我们先部署一个接收ETH合约ReceiveETH。ReceiveETH合约里有一个事件Log，记录收到的ETH数量和gas剩余。还有两个函数，一个是receive()函数，收到ETH被触发，并发送Log事件；另一个是查询合约ETH余额的getBalance()函数。

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

Copy
部署ReceiveETH合约后，运行getBalance()函数，可以看到当前合约的ETH余额为0。

20-1

发送ETH合约
我们将实现三种方法向ReceiveETH合约发送ETH。首先，先在发送ETH合约SendETH中实现payable的构造函数和receive()，让我们能够在部署时和部署后向合约转账。

contract SendETH {
    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable{}
    // receive方法，接收eth时被触发
    receive() external payable{}
}

Copy
transfer
用法是接收方地址.transfer(发送ETH数额)。
transfer()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
transfer()如果转账失败，会自动revert（回滚交易）。
代码样例，注意里面的_to填ReceiveETH合约的地址，amount是ETH转账金额：

// 用transfer()发送ETH
function transferETH(address payable _to, uint256 amount) external payable{
    _to.transfer(amount);
}

Copy
部署SendETH合约后，对ReceiveETH合约发送ETH，此时amount为10，value为0，amount>value，转账失败，发生revert。

20-2

此时amount为10，value为10，amount<=value，转账成功。

20-3

在ReceiveETH合约中，运行getBalance()函数，可以看到当前合约的ETH余额为10。

20-4

send
用法是接收方地址.send(发送ETH数额)。
send()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
send()如果转账失败，不会revert。
send()的返回值是bool，代表着转账成功或失败，需要额外代码处理一下。
代码样例：

error SendFailed(); // 用send发送ETH失败error

// send()发送ETH
function sendETH(address payable _to, uint256 amount) external payable{
    // 处理下send的返回值，如果失败，revert交易并发送error
    bool success = _to.send(amount);
    if(!success){
        revert SendFailed();
    }
}

Copy
对ReceiveETH合约发送ETH，此时amount为10，value为0，amount>value，转账失败，因为经过处理，所以发生revert。

20-5

此时amount为10，value为11，amount<=value，转账成功。

20-6

call
用法是接收方地址.call{value: 发送ETH数额}("")。
call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑。
call()如果转账失败，不会revert。
call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理一下。
代码样例：

error CallFailed(); // 用call发送ETH失败error

// call()发送ETH
function callETH(address payable _to, uint256 amount) external payable{
    // 处理下call的返回值，如果失败，revert交易并发送error
    (bool success,) = _to.call{value: amount}("");
    if(!success){
        revert CallFailed();
    }
}

Copy
对ReceiveETH合约发送ETH，此时amount为10，value为0，amount>value，转账失败，因为经过处理，所以发生revert。

20-7

此时amount为10，value为11，amount<=value，转账成功。

20-8

运行三种方法，可以看到，他们都可以成功地向ReceiveETH合约发送ETH。

总结
这一讲，我们介绍Solidity三种发送ETH的方法：transfer，send和call。

call没有gas限制，最为灵活，是最提倡的方法；
transfer有2300 gas限制，但是发送失败会自动revert交易，是次优选择；
send有2300 gas限制，而且发送失败不会自动revert交易，几乎没有人用它。

### 2024.10.05

调用已部署合约
在Solidity中，一个合约可以调用另一个合约的函数，这在构建复杂的DApps时非常有用。本教程将会介绍如何在已知合约代码（或接口）和地址的情况下，调用已部署的合约。

目标合约
我们先写一个简单的合约OtherContract，用于被其他合约调用。
```
contract OtherContract {
    uint256 private _x = 0; // 状态变量_x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取_x
    function getX() external view returns(uint x){
        x = _x;
    }
}
```
Copy
这个合约包含一个状态变量_x，一个事件Log在收到ETH时触发，三个函数：

getBalance(): 返回合约ETH余额。
setX(): external payable函数，可以设置_x的值，并向合约发送ETH。
getX(): 读取_x的值。
调用OtherContract合约
我们可以利用合约的地址和合约代码（或接口）来创建合约的引用：_Name(_Address)，其中_Name是合约名，应与合约代码（或接口）中标注的合约名保持一致，_Address是合约地址。然后用合约的引用来调用它的函数：_Name(_Address).f()，其中f()是要调用的函数。

下面我们介绍4个调用合约的例子，在remix中编译合约后，分别部署OtherContract和CallContract：


1. 传入合约地址
我们可以在函数里传入目标合约地址，生成目标合约的引用，然后调用目标函数。以调用OtherContract合约的setX函数为例，我们在新合约中写一个callSetX函数，传入已部署好的OtherContract合约地址_Address和setX的参数x：

function callSetX(address _Address, uint256 x) external{
    OtherContract(_Address).setX(x);
}

Copy
复制OtherContract合约的地址，填入callSetX函数的参数中，成功调用后，调用OtherContract合约中的getX验证x变为123

2. 传入合约变量
我们可以直接在函数里传入合约的引用，只需要把上面参数的address类型改为目标合约名，比如OtherContract。下面例子实现了调用目标合约的getX()函数。

注意：该函数参数OtherContract _Address底层类型仍然是address，生成的ABI中、调用callGetX时传入的参数都是address类型

function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}

Copy
复制OtherContract合约的地址，填入callGetX函数的参数中，调用后成功获取x的值

call contract3 in remix

3. 创建合约变量
我们可以创建合约变量，然后通过它来调用目标函数。下面例子，我们给变量oc存储了OtherContract合约的引用：

function callGetX2(address _Address) external view returns(uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}

Copy
复制OtherContract合约的地址，填入callGetX2函数的参数中，调用后成功获取x的值

call contract4 in remix

4. 调用合约并发送ETH
如果目标合约的函数是payable的，那么我们可以通过调用它来给合约转账：_Name(_Address).f{value: _Value}()，其中_Name是合约名，_Address是合约地址，f是目标函数名，_Value是要转的ETH数额（以wei为单位）。

OtherContract合约的setX函数是payable的，在下面这个例子中我们通过调用setX来往目标合约转账。
```
function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
}
```
Copy
复制OtherContract合约的地址，填入setXTransferETH函数的参数中，并转入10ETH

call contract5 in remix

转账后，我们可以通过Log事件和getBalance()函数观察目标合约ETH余额的变化。

call contract6 in remix

总结
这一讲，我们介绍了如何通过目标合约代码（或接口）和地址来创建合约的引用，从而调用目标合约的函数。

### 2024.10.06

週日複習前面的內容。
Delegatecall
delegatecall与call类似，是Solidity中地址类型的低级成员函数。delegate中是委托/代表的意思，那么delegatecall委托了什么？

当用户A通过合约B来call合约C的时候，执行的是合约C的函数，上下文(Context，可以理解为包含变量和状态的环境)也是合约C的：msg.sender是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上。

call的上下文

而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。

delegatecall的上下文

大家可以这样理解：一个投资者（用户A）把他的资产（B合约的状态变量）都交给一个风险投资代理（C合约）来打理。执行的是风险投资代理的函数，但是改变的是资产的状态。

delegatecall语法和call类似，也是：

目标合约地址.delegatecall(二进制编码);

Copy
其中二进制编码利用结构化编码函数abi.encodeWithSignature获得：

abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)

Copy
函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)。

和call不一样，delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额

注意：delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。

什么情况下会用到delegatecall?
目前delegatecall主要有两个应用场景：

代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。

EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。 更多信息请查看：钻石标准简介。

delegatecall例子
调用结构：你（A）通过合约B调用目标合约C。

被调用的合约C
我们先写一个简单的目标合约C：有两个public变量：num和sender，分别是uint256和address类型；有一个函数，可以将num设定为传入的_num，并且将sender设为msg.sender。

// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

Copy
发起调用的合约B
首先，合约B必须和目标合约C的变量存储布局必须相同，两个变量，并且顺序为num和sender

contract B {
    uint public num;
    address public sender;
}

Copy
接下来，我们分别用call和delegatecall来调用合约C的setVars函数，更好的理解它们的区别。

callSetVars函数通过call来调用setVars。它有两个参数_addr和_num，分别对应合约C的地址和setVars的参数。

// 通过call来调用C的setVars()函数，将改变合约C里的状态变量
function callSetVars(address _addr, uint _num) external payable{
    // call setVars()
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );
}

Copy
而delegatecallSetVars函数通过delegatecall来调用setVars。与上面的callSetVars函数相同，有两个参数_addr和_num，分别对应合约C的地址和setVars的参数。

// 通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量
function delegatecallSetVars(address _addr, uint _num) external payable{
    // delegatecall setVars()
    (bool success, bytes memory data) = _addr.delegatecall(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );
}

Copy
在remix上验证
首先，我们把合约B和C都部署好

deploy.png

部署之后，查看C合约状态变量的初始值，B合约的状态变量也是一样。

initialstate.png

此时，调用合约B中的callSetVars，传入参数为合约C地址和10

call.png

运行后，合约C中的状态变量将被修改：num被改为10，sender变为合约B的地址

resultcall.png

接下来，我们调用合约B中的delegatecallSetVars，传入参数为合约C地址和100

delegatecall.png

由于是delegatecall，上下文为合约B。在运行后，合约B中的状态变量将被修改：num被改为100，sender变为你的钱包地址。合约C中的状态变量不会被修改。

resultdelegatecall.png

总结
这一讲我们介绍了Solidity中的另一个低级函数delegatecall。与call类似，它可以用来调用其他合约；不同点在于运行的上下文，B call C，上下文为C；而B delegatecall C，上下文为B。目前delegatecall最大的应用是代理合约和EIP-2535 Diamonds（钻石）。


### 2024.10.08

```solidity
contract Pair {
    address public factory;
    address public token0;
    address public token1;
```

- contract named `pair` is defined.
- 3 address variables that named `factory`, `token0`, `token1`.

```solidity
    constructor() payable {
        factory = msg.sender;
    }
```

- `constructor` runs once when the contract is deployed.
- The `factory` variable above is set to `msg.sender` , the address of the entity that deployed this `pair` contract.
- What’s a `msg.sender`?
    
    **If an external user** (like you, using MetaMask) calls a function, `msg.sender` will be **your Ethereum address**.
    

```solidity
function initialize(address _token0, address _token1) external {
    require(msg.sender == factory, 'UniswapV2: FORBIDDEN');
    token0 = _token0;
    token1 = _token1;
}
```

- `require(msg.sender == factory` ensures that only the factory contract can call this function.

By restricting access to the factory contract, this prevents unauthorized parties from initializing the pair with their own tokens. It maintains control over the system and ensures the integrity of the token pairs created.

- 1. How to Identify if a Function is Called at or After Deployment?
    
    **Constructor**: called at deployment
    
    **Regular funtions**: called after deployment (either public, external, internal, or private) that require explicit invoation by someone. 
    
- 2. Why Does a Function Parameter Have a Name Like `_token0`?
    - Distinguishing Between Function Parameters and State Variables
    - Naming Convention and Clarity
- 3. What Does Initializing Mean? Where Does This Command Appear in the `initialize` Function?
    
    **In the `initialize` function**, initializing refers to assigning values to the state variables `token0` and `token1` after the contract has been deployed. This is necessary because, at deployment, these variables don't have the token addresses set yet. By calling `initialize`, you "initialize" the contract with the token pair addresses.
    

```solidity
mapping(address => mapping(address => address)) public getPair;
address[] public allPairs;
```

- State Variables:
    - `getPair`: helps you look up the `pair`contract for a given pair of tokens.
    - The double mapping `mapping(address => mapping(address => address))` means:
        - Given `tokenA` and `tokenB`, you can retrieve the corresponding `Pair` contract address that manages that token pair.
        - Example: `getPair[tokenA][tokenB]` would return the `Pair` contract address for swapping between `tokenA` and `tokenB`.
    - **`allPairs`:**
        - This is an array that stores the addresses of **all created `Pair` contracts**.
        - It keeps track of all the liquidity pools that have been created through this factory.
- The **`createPair`** function is the core of the `PairFactory` contract. It handles the creation of new `Pair` contracts (for token pairs like ETH/DAI) and keeps track of them. Let’s go through the steps:
    1. **Create a New `Pair` Contract**:
    
    ```solidity
    Pair pair = new Pair();
    ```
    
    - This line deploys a new instance of the `Pair` contract. It creates a new smart contract on the blockchain specifically for managing the liquidity pool between `tokenA` and `tokenB`.
    - The `Pair` contract is deployed using its default constructor.
    1. **Call the `initialize` Method on the New `Pair` Contract**:
    
    ```solidity
    pair.initialize(tokenA, tokenB);
    ```
    
    - After creating the `Pair` contract, the factory contract calls the `initialize` function of the newly created `Pair`.
    - It passes `tokenA` and `tokenB` as arguments, which will set the two tokens (like ETH and DAI) in the `Pair` contract.
    - This ensures that the `Pair` contract is now ready to handle swaps between `tokenA` and `tokenB`.
    1. **Update the `Pair` Address Mapping**:
    
    ```solidity
    pairAddr = address(pair);
    allPairs.push(pairAddr);
    getPair[tokenA][tokenB] = pairAddr;
    getPair[tokenB][tokenA] = pairAddr;
    ```
    
    - The `pairAddr` variable is set to the address of the newly created `Pair` contract using `address(pair)`.
    - This address is added to the `allPairs` array to keep track of all the liquidity pools created.
    - The `getPair` mapping is updated twice:
        - `getPair[tokenA][tokenB] = pairAddr`: This lets you query the `Pair` contract for the token pair `tokenA` and `tokenB`.
        - `getPair[tokenB][tokenA] = pairAddr`: This ensures you can also query the pair using the tokens in reverse order (i.e., from `tokenB` to `tokenA`).
    
    This double mapping makes it easy to look up the `Pair` contract regardless of the order of the token addresses.

### 2024.10.10

### Reference Types in Solidity

Reference types in Solidity include arrays and structs. Since these variables are more complex and take up more storage space, we must specify the **data location** when using them.

---

### Data Locations

There are three types of data locations in Solidity: `storage`, `memory`, and `calldata`. Different storage locations have different gas costs. Data in `storage` is stored on the blockchain (similar to a computer's hard drive) and consumes more gas, while `memory` and `calldata` are temporary, residing in memory and consuming less gas.

- **storage**: State variables within the contract are stored in `storage` by default, meaning they are stored on the blockchain.
- **memory**: Used for function parameters and temporary variables that only exist during function execution and do not persist on the blockchain. When returning dynamic data types (like strings, bytes, arrays, or custom structs), you must use the `memory` keyword.
- **calldata**: Similar to `memory` but the key difference is that `calldata` variables are immutable (cannot be modified). It’s generally used for function parameters.

Example:

```solidity
solidity
複製程式碼
function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    // _x is a calldata array and cannot be modified
    // _x[0] = 0; // This would throw an error
    return _x;
}

```

---

### Data Location and Assignment Rules

When assigning between different data locations, sometimes an independent copy is created (modifying the new variable does not affect the original), while other times a reference is created (modifying the new variable will affect the original). The rules are as follows:

- **Assignment creates a reference**: Modifying the reference or the original will reflect the changes in both.

For example:

- Assigning a `storage` state variable to another `storage` variable creates a reference. Changing the new variable will affect the original.

```solidity
solidity
複製程式碼
uint[] x = [1, 2, 3]; // State variable x (in storage)

function fStorage() public {
    // Declare a storage variable xStorage that points to x
    // Modifying xStorage will also affect x
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}

```

Example:

![5-2.png](5-2.png)

- **Memory to memory assignment creates a reference**: Modifying the new variable will affect the original.

In other cases, assignment creates a copy, meaning changes to one will not affect the other.

---

### Variable Scopes

Solidity variables can be categorized into three types based on their scope: **state variables**, **local variables**, and **global variables**.

### 1. **State Variables**

State variables are stored on the blockchain and can be accessed by all functions within the contract. They are costly in terms of gas. State variables are declared within the contract but outside of functions:

```solidity
solidity
複製程式碼
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}

```

You can modify the value of state variables within functions:

```solidity
solidity
複製程式碼
function foo() external {
    // State variables can be modified inside a function
    x = 5;
    y = 2;
    z = "0xAA";
}

```

### 2. **Local Variables**

Local variables only exist during the function's execution and are not stored on the blockchain. They are cheaper in terms of gas. Local variables are declared inside functions:

```solidity
solidity
複製程式碼
function bar() external pure returns(uint) {
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return zz;
}

```

### 3. **Global Variables**

Global variables are predefined by Solidity and can be used anywhere within the contract without declaration. They provide information about the blockchain and the transaction.

```solidity
solidity
複製程式碼
function global() external view returns(address, uint, bytes memory) {
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return (sender, blockNum, data);
}

```

In this example, three common global variables are used: `msg.sender`, `block.number`, and `msg.data`, which represent the sender’s address, the current block number, and the request data, respectively.

Some other commonly used global variables include:

- `blockhash(uint blockNumber)`: Returns the hash of a given block – only works for the most recent 256 blocks.
- `block.coinbase`: The address of the current block’s miner.
- `block.gaslimit`: The gas limit for the current block.
- `block.number`: The current block number.
- `block.timestamp`: The current block’s timestamp (seconds since the Unix epoch).
- `gasleft()`: The remaining gas for the current transaction.
- `msg.data`: The complete calldata.
- `msg.sender`: The address of the caller.
- `msg.sig`: The first four bytes of the calldata (function identifier).
- `msg.value`: The amount of wei sent with the current transaction.

### 2024.10.11

我最近在重新学 Solidity，巩固一下细节，也写一个“WTF Solidity极简入门”，供小白们使用（编程大佬可以另找教程），每周更新 1-3 讲。

推特：@0xAA_Science｜@WTFAcademy_

社区：Discord｜微信群｜官网 wtf.academy

所有代码和教程开源在 github: github.com/AmazingAng/WTF-Solidity

这一讲，我们将介绍映射（Mapping）类型，Solidity中存储键值对的数据结构，可以理解为哈希表。

映射Mapping
在映射中，人们可以通过键（Key）来查询对应的值（Value），比如：通过一个人的id来查询他的钱包地址。

声明映射的格式为mapping(_KeyType => _ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型。例子：

mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址

Copy
映射的规则
规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型。下面这个例子会报错，因为_KeyType使用了我们自定义的结构体：

// 我们定义一个结构体 Struct
struct Student{
    uint256 id;
    uint256 score; 
}
mapping(Student => uint) public testVar;

Copy
规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数（见例子）。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。

规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。

规则4：给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对。例子：

function writeMap (uint _Key, address _Value) public{
    idToAddress[_Key] = _Value;
}

Copy
映射的原理
原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。

原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。

原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

在Remix上验证 (以 Mapping.sol为例)
映射示例 1 部署

7-1

映射示例 2 初始值

7-2

映射示例 3 key-value pair

7-3

总结
这一讲，我们介绍了Solidity中哈希表——映射（Mapping）的用法。至此，我们已经学习了所有常用变量种类，之后我们会学习控制流if-else，while等。
变量初始值
在Solidity中，声明但没赋值的变量都有它的初始值或默认值。这一讲，我们将介绍常用变量的初始值。

值类型初始值
boolean: false
string: ""
int: 0
uint: 0
enum: 枚举中的第一个元素
address: 0x0000000000000000000000000000000000000000 (或 address(0))
function
internal: 空白函数
external: 空白函数
可以用public变量的getter函数验证上面写的初始值是否正确：

bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000

enum ActionSet { Buy, Hold, Sell}
ActionSet public _enum; // 第1个内容Buy的索引0

function fi() internal{} // internal空白函数
function fe() external{} // external空白函数 

Copy
引用类型初始值
映射mapping: 所有元素都为其默认值的mapping
结构体struct: 所有成员设为其默认值的结构体
数组array
动态数组: []
静态数组（定长）: 所有成员设为其默认值的静态数组
可以用public变量的getter函数验证上面写的初始值是否正确：

// Reference Types
uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // `[]`
mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
// 所有成员设为其默认值的结构体 0, 0
struct Student{
    uint256 id;
    uint256 score; 
}
Student public student;

Copy
delete操作符
delete a会让变量a的值变为初始值。

// delete操作符
bool public _bool2 = true; 
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}

Copy
在remix上验证
部署合约查看值类型、引用类型的初始值

8-1.png

值类型、引用类型delete操作后的默认值

8-2.png

总结
这一讲，我们介绍了Solidity中变量的初始值。变量被声明但没有赋值的时候，它的值默认为初始值。不同类型的变量初始值不同，delete操作符可以删除一个变量的值并代替为初始值。

### 2024.10.12

另外學了Mapping和array。
Mapping，就相當於給每個value 一個 key
每個Array都有對應的從0開始的Index. 
以上。


昨天忘記更新，今天補上，今天嘗試理解了以下的代碼:
```
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Twitter {

    //mapping address to string and call it tweets
    mapping(address => string[]) public tweets;

    function createTwitter (string memory _tweet) public {
    // memory means store as temporary memory
        tweets[msg.sender].push(_tweet);
    }
    // mapping is both key and value, could be addresses to names. So you can find name by address 

    function getTweet(address _owner, uint _i) public view returns (string memory){
        return tweets[_owner][_i];
        // view is more gas efficient
    }

    function getAllTweets(address _owner) public view returns (string[] memory){
        return tweets[_owner];
    }
```

今天學了function, event, static variables, 還有好像是qualifier一樣的東西，constant, internal, private, public。 
function還有modifier，可以設置啟動某function的條件。
還學到了boollean和一些運算式，很多都是比以前學過的東西。
現在就算小小複習一下，明天會更認真學！

Copy
映射的原理
原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。

原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。

原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

在Remix上验证 (以 Mapping.sol为例)
映射示例 1 部署

7-1

映射示例 2 初始值

7-2

映射示例 3 key-value pair

7-3

总结
这一讲，我们介绍了Solidity中哈希表——映射（Mapping）的用法。至此，我们已经学习了所有常用变量种类，之后我们会学习控制流if-else，while等。
变量初始值
在Solidity中，声明但没赋值的变量都有它的初始值或默认值。这一讲，我们将介绍常用变量的初始值。

值类型初始值
boolean: false
string: ""
int: 0
uint: 0
enum: 枚举中的第一个元素
address: 0x0000000000000000000000000000000000000000 (或 address(0))
function
internal: 空白函数

### 2024.10.13

数字签名signature 
1 以太坊椭圆曲线数字签名算法ECDSA 
2 私钥：掌握私钥就掌握资产 
3 公钥：是从私钥派生出来，公开用于验证签名，用于生成以太坊地址，是验证所有权和签名过程的关键组成部分 
4 消息：是你想要签名的消息的哈希值（以太坊签名过程中先对消息进行哈希处理（使用keccak256，确保消息传输中不被篡改）然后再进行签名） 
5 以太坊签名消息：经过签名算法ECDSA生成的签名消息的哈希值 
6 签名：由三部分组成（r，s，恢复标志v），签名用于证明消息是由持有私钥一方生成的，并且用于签证签名方的身份 
7 getMessageHash函数：将传入的两个参数（地址和代币ID）拼起来，计算他们的哈希值 
8 keccak256是solidity中加密哈希算法 
9 abi.encodePacked：是一个编码函数，将多个变量打包成一个字节数组（这种打包方式将地址和数字拼接起来，方便对其哈希计算） 
10 EIP-191 以太坊签名标准 
11 返回值是bytes32类型：拼接了前缀后的新消息哈希，这个新哈希值可以作为消息签名的基础，确保安全 
12 personal_sign是以太坊的签名方法去，专门用于签署消息（而不是交易），并会返回签名后的字符串（signnature），调用personal_sign之后，钱包会弹出一个对话框，提示用户确认签名要求 
13 ethereum.request是新的MetaMask API推荐方法 
14 免费的以太坊节点EPC 
15 内联汇编assembly 
16 以太坊的标准签名由65个字节组成，包含r（32字节），s（32字节），v（1字节） 
17 mload函数主要作用就是从内存的某个特定位置读取32字节的数据 
18 Ethereum 虚拟机EVM处理的数据块单位是 32 字节 
19 ecrecover函数是利用 r、s、v 这三个参数和消息哈希（_msgHash）来计算出签名者的地址（签名者的地址可以用来验证消息的发送者，从而确保消息未被篡改且来自私钥的持有人） 
20 address _signer 签名者地址

荷兰拍卖
荷兰拍卖（Dutch Auction）是一种特殊的拍卖形式。 亦称“减价拍卖”，它是指拍卖标的的竞价由高到低依次递减直到第一个竞买人应价（达到或超过底价）时击槌成交的一种拍卖。

荷兰拍卖

在币圈，很多NFT通过荷兰拍卖发售，其中包括Azuki和World of Women，其中Azuki通过荷兰拍卖筹集了超过8000枚ETH。

项目方非常喜欢这种拍卖形式，主要有两个原因

荷兰拍卖的价格由最高慢慢下降，能让项目方获得最大的收入。

拍卖持续较长时间（通常6小时以上），可以避免gas war。

DutchAuction合约
代码基于Azuki的代码简化而成。DucthAuction合约继承了之前介绍的ERC721和Ownable合约：

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";

contract DutchAuction is Ownable, ERC721 {

Copy
DutchAuction状态变量
合约中一共有9个状态变量，其中有6个和拍卖相关，他们是：

COLLECTOIN_SIZE：NFT总量。
AUCTION_START_PRICE：荷兰拍卖起拍价，也是最高价。
AUCTION_END_PRICE：荷兰拍卖结束价，也是最低价/地板价。
AUCTION_TIME：拍卖持续时长。
AUCTION_DROP_INTERVAL：每过多久时间，价格衰减一次。
auctionStartTime：拍卖起始时间（区块链时间戳，block.timestamp）。
    uint256 public constant COLLECTOIN_SIZE = 10000; // NFT总数
    uint256 public constant AUCTION_START_PRICE = 1 ether; // 起拍价(最高价)
    uint256 public constant AUCTION_END_PRICE = 0.1 ether; // 结束价(最低价/地板价)
    uint256 public constant AUCTION_TIME = 10 minutes; // 拍卖时间，为了测试方便设为10分钟
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes; // 每过多久时间，价格衰减一次
    uint256 public constant AUCTION_DROP_PER_STEP =
        (AUCTION_START_PRICE - AUCTION_END_PRICE) /
        (AUCTION_TIME / AUCTION_DROP_INTERVAL); // 每次价格衰减步长
    
    uint256 public auctionStartTime; // 拍卖开始时间戳
    string private _baseTokenURI;   // metadata URI
    uint256[] private _allTokens; // 记录所有存在的tokenId 

Copy
DutchAuction函数
荷兰拍卖合约中共有9个函数，与ERC721相关的函数我们这里不再重复介绍，只介绍和拍卖相关的函数。

设定拍卖起始时间：我们在构造函数中会声明当前区块时间为起始时间，项目方也可以通过setAuctionStartTime()函数来调整：
    constructor() ERC721("WTF Dutch Auctoin", "WTF Dutch Auctoin") {
        auctionStartTime = block.timestamp;
    }

    // auctionStartTime setter函数，onlyOwner
    function setAuctionStartTime(uint32 timestamp) external onlyOwner {
        auctionStartTime = timestamp;
    }

Copy
获取拍卖实时价格：getAuctionPrice()函数通过当前区块时间以及拍卖相关的状态变量来计算实时拍卖价格。
当block.timestamp小于起始时间，价格为最高价AUCTION_START_PRICE；

当block.timestamp大于结束时间，价格为最低价AUCTION_END_PRICE；

当block.timestamp处于两者之间时，则计算出当前的衰减价格。

    // 获取拍卖实时价格
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

Copy
用户拍卖并铸造NFT：用户通过调用auctionMint()函数，支付ETH参加荷兰拍卖并铸造NFT。
该函数首先检查拍卖是否开始/铸造是否超出NFT总量。接着，合约通过getAuctionPrice()和铸造数量计算拍卖成本，并检查用户支付的ETH是否足够：如果足够，则将NFT铸造给用户，并退回超额的ETH；反之，则回退交易。

    // 拍卖mint函数
    function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // 检查是否设置起拍时间，拍卖是否开始
        require(
        totalSupply() + quantity <= COLLECTOIN_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // 检查是否超过NFT上限

        uint256 totalCost = getAuctionPrice() * quantity; // 计算mint成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 检查用户是否支付足够ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多余ETH退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); //注意一下这里是否有重入的风险
        }
    }

Copy
项目方取出筹集的ETH：项目方可以通过withdrawMoney()函数提走拍卖筹集的ETH。
    // 提款函数，onlyOwner
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}(""); // call函数的调用方式详见第22讲
        require(success, "Transfer failed.");
    }

<!-- Content_END -->
