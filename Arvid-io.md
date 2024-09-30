

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
    solidity
    複製程式碼
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
    solidity
    複製程式碼
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





<!-- Content_END -->
