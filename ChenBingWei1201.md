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

### 2024.09.24

#### Variable Types
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

### 2024.09.25

#### Function

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

###

<!-- Content_END -->
