

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
- The key of this mapping is an Ethereum address
- The value associated with each address is an array of strings
- Each address can have multiple tweets (stored as strings in the array)
- The 'public' keyword automatically creates a getter function for this mapping

In the context of a Twitter-like contract, this mapping allows each Ethereum address (user) to have an array of tweets associated with it. Users can add tweets to their array, and anyone can retrieve tweets for a specific address.

以上。

<!-- Content_END -->
