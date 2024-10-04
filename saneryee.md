---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加夏令时间 (UTC-8)

timezone: America/Los_Angeles # 太平洋夏令时间 (UTC-7)

timezone: America/Denver # 山地夏令时间 (UTC-6)

timezone: America/Chicago # 中部夏令时间 (UTC-5)

timezone: America/New_York # 东部夏令时间 (UTC-4)

timezone: America/Halifax # 大西洋夏令时间 (UTC-3)

timezone: America/St_Johns # 纽芬兰夏令时间 (UTC-2:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# YourName

1. 自我介绍
   
   学习 Solidity，想成为一名 Smart contract Auditor。

2. 你认为你会完成本次残酷学习吗？
   
   会。
   
## Notes

<!-- Content_START -->
### 2024.10.04

Day 10

WTF Academy Solidity 101 34_ERC721, 35_DutchAuction

ERC165 and ERC721

Solamte version

```
   function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
         return
               interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
               interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
               interfaceId == 0x5b5e139f; // ERC165 Interface ID for ERC721Metadata
   }
```
OpenZepplion version

```
   function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }
```
Dutch Aution

- In the best interests of the project party
- Avoid gas wars

Dutch Auction mechanism design:

1. Basic Parameters:
   - startAmount: Total auction quantity (e.g., number of NFTs)
   - startPrice: Starting/maximum price
   - reservePrice: Floor price/minimum price
     * Recommendation: reservePrice ≤ startPrice * 50% (floor price not higher than 50% of starting price)
   - duration: Total auction duration
     * Recommendation: Set minimum duration (e.g., 1 hour) to prevent flash sales
     * Recommendation: Set maximum duration (e.g., 7 days) to avoid indefinite extensions

2. Price Decay Mechanism:
   - decayInterval: Price update interval
     * Example: Every 5 minutes, hourly, etc.
     * Recommendation: Not too frequent (gas costs) nor too long (price smoothness)
   - minDecayPerInterval: Minimum price reduction per interval
     * Example: Minimum 2% reduction each time
     * Prevents minimal price drops to circumvent auction mechanism
   - priceFunction: Price decay function
     * Linear decay: (endPrice - startPrice) * (elapsedTime / duration)
     * Exponential decay: startPrice * (1 - decayRate)^(elapsedTime / decayInterval)

3. Constraints:
   
   ```solidity
   // Basic parameter checks
   require(startAmount > 0, "Invalid amount");
   require(startPrice > reservePrice, "Invalid price range");
   require(duration >= MIN_DURATION && duration <= MAX_DURATION, "Invalid duration");

   // Price reduction check
   require(
      reservePrice <= startPrice * 50 / 100,
      "Reserve price too high"
   );

   // Decay interval check
   require(
      decayInterval >= MIN_DECAY_INTERVAL,
      "Decay interval too short"
   );

   // Minimum decay rate check
   require(
      minDecayPerInterval >= MIN_DECAY_RATE,
      "Decay rate too small"
   );
   ```

---
### 2024.10.03

Day 9

WTF Academy Solidity 101 32_Faucet, 33_Airdrop


Mitigate DOS Attack for `Airdrop.sol`

1. Removed the direct transfer logic in the `multiTransferETH` function, replacing it with a record of the ETH amount due to each address.
2. Added a `withdrawETH` function, impllement the **pull payment pattern**. This allows recipients to withdraw their ETH themselves, rather than the contract actively sending it.
3. In the `multiTransferToken` function, we now check the success of each transfer and emit an event if it fails.
4. Added events `TransferFailed` and `WithdrawnFromFailedList` to log important state changes.
5. Added a `receive` function to enable the contract to receive ETH.
6. Renamed `failTransferList` to `failedTransfers` and made it public for easier querying.
7. In `multiTransferToken`, changed `>` to `>=` to allow for exact allowance amounts.

```
// SPDX-License-Identifier: MIT
// By 0xAA (Improved by Assistant)
pragma solidity ^0.8.21;

import "./IERC20.sol";

/// @notice Contract for airdropping ERC20 tokens and ETH to multiple addresses
contract Airdrop {
    mapping(address => uint) public failedTransfers;
    
    event TransferFailed(address indexed recipient, uint256 amount);
    event WithdrawnFromFailedList(address indexed recipient, address indexed to, uint256 amount);

    /// @notice Transfer ERC20 tokens to multiple addresses, requires prior approval
    ///
    /// @param _token Address of the ERC20 token to transfer
    /// @param _addresses Array of recipient addresses
    /// @param _amounts Array of token amounts to transfer (corresponds to each address)
    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        require(
            _addresses.length == _amounts.length,
            "Lengths of Addresses and Amounts NOT EQUAL"
        );
        IERC20 token = IERC20(_token);
        uint _amountSum = getSum(_amounts);
        require(
            token.allowance(msg.sender, address(this)) >= _amountSum,
            "Insufficient allowance"
        );

        for (uint256 i; i < _addresses.length; i++) {
            bool success = token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
            if (!success) {
                emit TransferFailed(_addresses[i], _amounts[i]);
            }
        }
    }

    /// @notice Initiate ETH transfer to multiple addresses
    /// @dev Uses pull payment pattern to avoid DOS attacks
    function multiTransferETH(
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) public payable {
        require(
            _addresses.length == _amounts.length,
            "Lengths of Addresses and Amounts NOT EQUAL"
        );
        uint _amountSum = getSum(_amounts);
        require(msg.value == _amountSum, "Transfer amount error");

        for (uint256 i = 0; i < _addresses.length; i++) {
            failedTransfers[_addresses[i]] += _amounts[i];
        }
    }

    /// @notice Allows recipients to withdraw their ETH
    /// @param _to Address to receive the withdrawn ETH
    function withdrawETH(address payable _to) public {
        uint amount = failedTransfers[msg.sender];
        require(amount > 0, "No ETH to withdraw");
        
        failedTransfers[msg.sender] = 0;
        
        (bool success, ) = _to.call{value: amount}("");
        require(success, "ETH transfer failed");
        
        emit WithdrawnFromFailedList(msg.sender, _to, amount);
    }

    /// @notice Function to sum an array of uint256
    function getSum(uint256[] calldata _arr) public pure returns (uint sum) {
        for (uint i = 0; i < _arr.length; i++) {
            sum += _arr[i];
        }
    }

    /// @notice Allows the contract to receive ETH
    receive() external payable {}
}
```
(Claude helped with code modification)


---
### 2024.10.02

Day 8

WTF Academy Solidity 101 30_TryCatch, 31_ERC20

Try Catch
- `external` or `public` function
- call `constructor` when creating contracts

ERC20

- User's `ERC20Token` store in `mapping(address => uint256) public override balanceOf;` in the ERC20 contract
  - Any transaction of erc20 tokens is an increase or decrease of this mapping `balanceOf`.

- first `appprover` next `transferFrom`

---
### 2024.10.01

Day 7

WTF Academy Solidity 101 27_ABIEncode, 28_Hash, 29_Selector

ABI encode
- has 4 parameters, can use only some of them
- `abi.encode`: 32-bytes
- `abi.encodePacked`: compacts encoding
- `abi.encodeWithSignature`: first parameter - `function signatures`
- `abi.encodeWithSelector`: first parameter - `function selector`
- `abi.encodeCall`: Syntactic sugar vesion of `abi.encodeWithSelector` and `abi.encodeWithSignature`

ABI decode
- `abi.decode`: decode the data of `abi.encode`

ABI Scenarios:

1. low-level call

   ```solidity
      bytes4 selector = contract.getValue.selector;

      bytes memory data = abi.encodeWithSelector(selector, _x);
      (bool success, bytes memory returnedData) = address(contract).staticcall(data);
      require(success);

      return abi.decode(returnedData, (uint256));
   ```
2. enthers.js

   ```
      const wavePortalContract = new ethers.Contract(contractAddress, contractABI, signer);
      /*
         * Call the getAllWaves method from your Smart Contract
         */
      const waves = await wavePortalContract.getAllWaves();
   ```

3. non-open contract, call non signature functions
   
   ```
      bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a));

      (bool success, bytes memory returnedData) = address(contract).staticcall(data);
      require(success);

      return abi.decode(returnedData, (uint256));
   ```
4. The most commonly used method in projects is `abi.encodeCall`. 
   Its advantage is that, compared to `abi.encodeWithSignature` and `abi.encodeWithSelector`, `abi.encodeCall` automatically checks the function signature and parameters at compile time, preventing spelling mistakes and parameter type mismatches. `abi.encodeWithSignature` dynamically accepts a string to represent the function signature, so when you use `abi.encodeWithSignature`, the compiler does not check if the function name or parameters are correct, as it treats the string as regular input data.

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.26;

   interface IERC20 {
      function transfer(address, uint256) external;
   }

   contract Token {
      function transfer(address, uint256) external {}
   }

   contract AbiEncode {
      function test(address _contract, bytes calldata data) external {
         (bool ok,) = _contract.call(data);
         require(ok, "call failed");
      }

      function encodeWithSignature(address to, uint256 amount)
         external
         pure
         returns (bytes memory)
      {
         // Typo is not checked - "transfer(address, uint)"
         return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
      }

      function encodeWithSelector(address to, uint256 amount)
         external
         pure
         returns (bytes memory)
      {
         // Type is not checked - (IERC20.transfer.selector, true, amount)
         return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
      }

      function encodeCall(address to, uint256 amount)
         external
         pure
         returns (bytes memory)
      {
         // Typo and type errors will not compile
         return abi.encodeCall(IERC20.transfer, (to, amount));
      }
   }


   ```

Hash

- Generate a uinque identifier of the data
  ```
      function hash(
         uint _num,
         string memory _string,
         address _addr
         ) public pure returns (bytes32) {
            return keccak256(abi.encodePacked(_num, _string, _addr));
         }
  ```

Selector

```solidity

    // 1. elementary parameters selector
    // Input：param1: 1，param2: 0
    // elementaryParamSelector(uint256,bool) : 0x3ec37834
    function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4       selectorWithElementaryParam){
        emit SelectorEvent(this.elementaryParamSelector.selector);
        return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
    }

    // 2. fixed size parameters selector
    // Input： param1: [1,2,3]
    // fixedSizeParamSelector(uint256[3]) : 0xead6b8bd
    function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
        emit SelectorEvent(this.fixedSizeParamSelector.selector);
        return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
    }

    // 3. non-fixed size parameters selector
    // Input： param1: [1,2,3]， param2: "abc"
    // nonFixedSizeParamSelector(uint256[],string) : 0xf0ca01de
    function nonFixedSizeParamSelector(uint256[] memory param1,string memory param2) external returns(bytes4 selectorWithNonFixedSizeParam){
        emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
        return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
    }


   // 4.
   contract DemoContract {
       // empty contract
   }

   contract Selector{
       // Struct User
       struct User {
           uint256 uid;
           bytes name;
       }
       // Enum School
       enum School { SCHOOL1, SCHOOL2, SCHOOL3 }
       ...
       // mapping parmeters selector
       // Input：demo: 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99， user: [1, "0xa0b1"], count: [1,2,3], mySchool: 1
       // mappingParamSelector(address,(uint256,bytes),uint256[],uint8) : 0xe355b0ce
       function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
           emit SelectorEvent(this.mappingParamSelector.selector);
           return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
       }
       ...
   }
```

---

### 2024.09.30

Day 6

WTF Academy Solidity 101 24-26

- `Create2` is used more often than `Create`.

Opinion of `SELFDESTRUCT` change after Cancun Update

- `SELFDESTRUCT` was initially designed as a safety measure for emergency situations.
- As the ecosystem evolved, `SELFDESTRUCT` began to pose potential systemic risks.
- With increasing interdependence among contracts, the destruction of a single contract could potendially impact the entire eco.
- In most emergency situations, the primary concern is fund security.
- Simply transferring funds is often sufficient to mitigate risks, without the need to completely destroy the contract.
- The recent update represents a refinement of the `SELFDESTRUCT` functionality, striking a balance between risk migitgation and practical utility.

---
### 2024.09.28
Day 5
WTF Academy Solidity 101 20-23

20. Sending ETH

      Recommended:

      - Usage: `receiverAddress.call{value: value in Wei}("")`.
      
      Other:

      - Usage: `receiverAddress.send(value in Wei)`.
      - Usage: `receiverAddress.transfer(value in Wei)`.

21. Interact with other Contract
    
    ```solidity
       // 1. Pass the contract address
       function callSetX(address _Address, uint256 x) external {
            OtherContract(_Address).setX(x);
       }

       // 2. Pass the contract variable
       function callGetX(OtherContract _Address) external view returns(uint x){
            x = Address.getX();
       }

       // 3. Creat contract variable
       function callGetX2(address _Address) external view returns(uint x){
            OtherContract oc = OtherContract(_Address);
            x = oc.getX();
       }

       // 4. Interact with the contract and send `ETH`
       function setXTransferETH(address otherContract, uint256 x) payable external{
            OtherContract(otherContract).setX{value: msg.value}(x)
       }
    ```
22. Call

   - Recommend: Sending ETH  `receiverAddress.call{value: value in Wei}("")`. 
   - Not Recommend: Call other contract.

23. Delegatecall
    
    - Proxy Contract
    - EIP-2535 Diamond

---

### 2024.09.27
Day 5
WTF Academy Solidity 101 16-19

Library
1. State variables are not allowed
2. Cannot inherit or be inherited
3. Cannot receive ether
4. Cannot be destroyed.

Use library contracts
```solidity
   // Using the library with the "using for"
   using Strings for uint256;
   function getString1(uint256 _number) public pure returns(string memory){
      // Library functions are automatically added as members of uint256 variavles
      return _number.toHexSting();
   }
```

```solidity
    // Called directly by the library contract name
    function getString2(uint256 _number) public pure returns(string memory){
        return Strings.toHexString(_number);
    }
```

4 Ways of Import

```solidity
   Hierarchy
   |-- Import.sol
   |__ Yeye.sol

   // Import by relative location of source file
   import './Yeye.sol';
   
   // Import by URL
   import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

   // Import via the npm
   import '@openzeppelin/contracts/access/Ownable.sol';


   // Import contract-specific global symbols by specifying global symbols.
   import {Yeye} from './Yeye.sol';

```

`receive()`
- revceiving `ETH` 
- Some malicious contracts intentionally add codes in `receive()`, which cosume massive `gas` or cause the transaction to get reversted. -- **Pull over push pattern**


`fallback()`

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
---

### 2024.09.26
Day 4 
WTF Academy Solidity 101 13-15

13. Inheritance
    
    - If a `public` state variable is labelled as `override`, it `getter` function will be overridden. For example:
  
      ```solidity
         mapping(address => uint256) public override balanceOf;
      ```
      `getter` function is `balanceOf(address)`

      Why:
      -  Unexpected behavior changes: Callers might expect the original getter behavior. but instead receive the overridden behavior.
      -  Security considerations: Overriding the getter could affect other contracts that depend on the original behavior.

14. Abstract and Interface
    
     Abstract

     - At least oun unimplemented function (empty in `{}` )
     
     Interface

     - no state variavles
     - no constructors
     - no inherit non-interface
     - must be external and empty in `{}`
     - Contract inherits interface must implement all functions

     - like " a manual of the contract "

15. Errors
    
    - `revert` => `error`
    - `require(condition, "error message");`


### 2024.09.25
Day 3
WTF Academy Solidity 101 9-12

**Key Points**

9. Constant and Immutable
   
    - `immutable` variable can be initialized in the **constructor**;

10. Control Flow
11. Constructor & Modifier
    
    Constructor in inheritance
    
      ```solidity
         // father contract

         contract ImmutableState {
            
            IPoolManager public immutable poolManager;

            constructor(IPoolManager _poolManager) {
               poolManager = _poolManager;
            }
         }
         
         // 
         contract SafeCallback is ImmutableState {
            ...
            //using father contract's constructor
            constructor(IPoolManager _poolManager) ImmutableState(_poolManager) {} 
            ...
         }
         

      ```

    Modifier

      ``` solidity
         modifier onlyOwner {
            require(msg.sender == owner);
            _;
         }

         function changeOwner(address _newOwner) external onlyOwner {
            owner = _newOwner;
         }
      ```
12. Event
    ```solidity
      // define event
      event Transfer(address indexed from, address indexed to, uint256 value);
    
      // define _transfer function， execute transfer logic
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
    
    - Events can be seen as a cheap way to store data on-chain, like a database.
    - EVM Log
      - Topics 0: event signature(hash)
      - Topics 1: event indexed parameter0
      - Topics 2: event indexed parameter1
      ...
      - Data: value parameter in event
  

---

### 2024.09.24

Class WTF Academy Solidity 101 5-8

**Key Points**

Data Storage and Scope

Reference Type: `array`, `struct`

| Data location| Usage | location| Others|
| -- | -- | -- |--|
| `storage` | state variables|on-chain||
| `memory`| function parameters | memory, not on-chain|`string`, `bytes`, `array`|
| `calldata`|function parameters, **cannot be modified** |memory, not on-chain||

Assignment behaviour

| Assignment behaviour | Affect the original? |
|--|--|
| State variable (`storage`) -> local `storage` (in a function) | Yes |
| `storage` -> `memory`| Not|
| `memory` -> `memory`| Yes |
| variable -> `storage`| Not |

Variable scope
- State variables (very very important)
- Useful Global variable
  - `msg.sender` (`address payable`): Message sender (current caller)
  - `msg.value` (`bytes4`): number of wei sent with the message
  - `block.number` (`uint`): Current block number
  - `block.timestamp` (`uint`): The timestamp of the current block
  - `wei`: 1
  - `gwei`: 1e9 = 1000000000
  - `ether`: 1e18 = 1000000000000000000
  - `seconds`: 1
  - `minutes`: 60
  - `hours`: 3600
  - `days`: 86400
  - `weeks`: 604800
  
Array

```solidity
   uint[8] array1;
   bytes1[5] array2;
   address[100] array3;

   uint[] array4;
   bytes1[] array5;
   address[] array6;
   bytes array7;

   uint[] memory array8 = new uint[](5);
   bytes memory array9 = new bytes(9);
```

Struct
   - Pay more attention to the changes and impacts of the status of each element in the `struct` within the contract

Mapping
  - Very useful in smart contracts

  -  `_KeyType` should be default types: `uint`, `address`
  -  `_ValueType` can be any type
  -  `storage` location
     -  can as the state variable or `storage` variable inside function
     -  can not in arguments or return results of `public` function
  -  adding a key-value pair `_Var[_Key] = _Value`

```solidity


    mapping(address owner => mapping(address operator => bool isOperator)) public isOperator; // Two levels

    mapping(address owner => mapping(address spender => mapping(uint256 id => uint256 amount))) public allowance; // Three levels


```

**The EVM can read and write to several places**

Write & Read:

- Stack
- Memory
- Storage
- Calldata
- Transient Storage
- Code
- Returndata

Write (not read):

- Logs

Read (not write):

- Chain Data
- Transaction data (& Blobhash)
- Gas data
- Program Counter
- (other)

---

### 2024.09.23

Class: WTF Academy Solidity 101 1-4

Key points：
- `address` size = 20 byte
- `address payable` with memebers `transfer` and `send`
- from `address` type to `payable address` type:  `payable(_address)`
- Fixed-length byte arrays: **value type**
- Variable-length byte arrays **reference type**
- Use cases of byte arrays
  1. Information encoding and decoding: Multiple pieces of information, suce as flags and status,can be encoded into a single byte arrays to save gas.
- Function
   ```solidity
         function <function name> (<parameter types>) [internal|external|public|private] [virtual|override|pure|view|payable] [returns (<return types>)]
   ```

   ```mermaid
      graph TD
         A[Start] --> B{Choose visibility modifier}
         B -->|Externally callable| C[external]
         B -->|Internally callable| D[internal]
         B -->|Callable both externally and internally| E[public]
         B -->|Only callable within current contract| F[private]
         
         C & D & E & F --> G{Requires Ether payment?}
         G -->|Yes| H[payable]
         G -->|No| I{Modifies state?}
         
         I -->|Yes| J[No additional modifier needed]
         I -->|No| K{Reads state?}
         
         K -->|Yes| L[view]
         K -->|No| M[pure]
         
         H & J & L & M --> N{Is it a base class function?}
         N -->|Yes| O[virtual]
         N -->|No| P{Overrides a base class function?}
         
         P -->|Yes| Q[override]
         P -->|No| R[End]
         
         O --> R
         Q --> R
   ```  
- return: Destructuring assignments
  
   ```
      // Named return, still support return
      function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
         return(1, true, [uint256(1),2,5]);
      }
      ...
      uint256 _number;
      bool _bool;
      uint256[3] memory _array;
      (_number, _bool, _array) = returnNamed();
      ...
      (, _bool2, ) = returnNamed();

  ```




<!-- Content_END -->
