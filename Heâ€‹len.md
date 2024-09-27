---
timezone: Asia/Shanghai
---

# Heâ€‹len

1. 自我介绍
   
   凡事都有第一次，喜歡體驗新事物的小女子。
  
2. 你认为你会完成本次残酷学习吗？
   
   我會盡我洪荒之力盡量完成本次共學目標，但有時以大我為目標，有時也會量力而為，比昨天的自己再進步一點就滿足。
   
## Notes

<!-- Content_START -->
### 2024.09.26
進度：值类型

3. ||（邏輯或，OR）VS `&&`（邏輯與）
|| 是邏輯或運算符，只要任一操作數為 true，結果就是 true。只有當兩個操作數都為 false 時，結果才是 false。

範例：
```solidity
bool public _bool3 = _bool || _bool1;  // _bool3 為 true
                    //True or False
```
4. `==`（等於，Equality）
`==` 用來判斷兩個pool是否相等。如果兩者相等，結果為 true，否則為 false。
範例：
```solidity
bool public _bool4 = _bool == _bool1;  // _bool4 為 false
                    // True== False(以右邊值為主）
```
5. `!=`（不等於，Inequality）
`!=` 用來判斷兩個布林值是否不相等。如果兩者不相等，結果為 true，否則為 false。
```solidity
bool public _bool5 = _bool != _bool1;  // _bool5 為 true
                    // True != False(負負得正）
```

### 2024.09.25
進度：值类型 & 熟悉Github 語言
# 布林型（二值變量）與邏輯運算

布林型（Boolean）是編程語言中的基本資料類型之一，只有兩個可能的取值：`true`（真）或`false`（假）。布林型主要用於條件判斷和控制流程中，通過邏輯運算符進行操作。

在這裡，我們將通過簡單的 Solidity 程式碼，來介紹常見的布林運算符，包括：
- `!`（邏輯非）
- `&&`（邏輯與）
- `||`（邏輯或）
- `==`（等於）
- `!=`（不等於）

## 布林值運算

```solidity
// 定義布林變量
bool public _bool = true;

// 布林運算範例
bool public _bool1 = !_bool;           // 取非: _bool1 為 false
bool public _bool2 = _bool && _bool1;  // 與: _bool2 為 false
bool public _bool3 = _bool || _bool1;  // 或: _bool3 為 true
bool public _bool4 = _bool == _bool1;  // 相等: _bool4 為 false
bool public _bool5 = _bool != _bool1;  // 不相等: _bool5 為 true
```
1. !（邏輯非，NOT）
`!` 是邏輯非運算符，用於取反一個布林值。如果變數的值為 `true`，那麼取非後的結果就是 `false`，反之亦然。

範例：
```
bool public _bool1 = !_bool;  // _bool1 為 false
```
這裡，變數 `_bool` 的初始值是 `true`，使用邏輯非 `!_bool` 會將其取反，得到 `_bool1 = false`。

2. &&（邏輯與，AND）
`&&` 是邏輯與運算符，當`兩個`操作數都為 `true` 時，結果才是 `true`。如果任一操作數為 `false`，結果就為 `false`。
範例：
```
bool public _bool2 = _bool && _bool1;  // _bool2 為 false
```
接續No.1 範例的定義，
由於 `_bool` 是 true，但 `_bool1` 是 false，`_bool2`結果為 false。



### 2024.09.24

# 今日筆記-除錯
1.確認 Solidity 版本的相容性
檢視發現 Compiler 版本與合約版本不一致（0.8.27 V.S 0.8.21)，統一改為Solidity 合約中自訂版本

2.檢視[影片](https://www.youtube.com/watch?v=rKKRGRHUiiQ)確認操作沒問題

3.合約已發佈

### 2024.09.23
# Real Note
進度：01_HelloWeb3
使用开发工具：Remix 練習寫一個[智能合約](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.26+commit.8a97fa7a.js),熟悉部署程序
```
// SPDX-License-Identifier: MIT
// 智能合約命名Heâ€len
// 內容：Hello my world!
// 完成編譯後，要按compile
pragma solidity ^0.8.21;
contract len{
    string public _string = "Hello my world";
}

```
但卡住了,evm version:cancun

## Sample Notes
學習內容: 
- A 系列的 Ethernaut CTF, 之前做了差不多了. POC: [ethernaut-foundry-solutions](https://github.com/SunWeb3Sec/ethernaut-foundry-solutions)
- A 系列的 QuillAudit CTF 題目的網站關掉了, 幫大家收集了[題目](./Writeup/SunSec/src/QuillCTF/), 不過還是有幾題沒找到. 有找到題目的人可以在發出來.
- A 系列的 DamnVulnerableDeFi 有持續更新, 題目也不錯. [Damn Vulnerable DeFi](https://github.com/theredguild/damn-vulnerable-defi/tree/v4.0.0).
- 使用 [Foundry](https://book.getfoundry.sh/) 在本地解題目, 可以參考下面 RoadClosed 為例子
- ``forge test --match-teat testRoadClosedExploit -vvvv``
#### [QuillAudit CTF - RoadClosed](./Writeup/SunSec/src/QuillCTF/RoadClosed.sol)
```
  function addToWhitelist(address addr) public {
    require(!isContract(addr), "Contracts are not allowed");
    whitelistedMinters[addr] = true;
  }

  function changeOwner(address addr) public {
    require(whitelistedMinters[addr], "You are not whitelisted");
    require(msg.sender == addr, "address must be msg.sender");
    require(addr != address(0), "Zero address");
    owner = addr;
  }

  function pwn(address addr) external payable {
    require(!isContract(msg.sender), "Contracts are not allowed");
    require(msg.sender == addr, "address must be msg.sender");
    require(msg.sender == owner, "Must be owner");
    hacked = true;
  }

  function pwn() external payable {
    require(msg.sender == pwner);
    hacked = true;
  }
```
- 解決這個題目需要成為合約的 owner 和 hacked = true.
- On-chain: 可以透過 ``cast send`` 或是 forge script 來解.
- Local: 透過 forge test 通常是在local解題, 方便 debug.
- RoadClosed 為例子我寫了2個解題方式. testRoadClosedExploit 和 testRoadClosedContractExploit (因為題目有檢查msg.sender是不是合約, 所以可以透過constructor來繞過 isContract)
- [POC](./Writeup/SunSec/test/QuillCTF/RoadClosed.t.sol) 

### 

<!-- Content_END -->
