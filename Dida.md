---
timezone: Asia/Taipei
---

---

# Dida 

1. 前端工程師，轉職到 Web3 公司工作，想學習合約開發技術。

2. 會
   
## Notes

<!-- Content_START -->
---
timezone: Asia/Taipei
---

---

# Dida 

1. 前端工程師，轉職到 Web3 公司工作，想學習合約開發技術。

2. 會
   
## Notes

<!-- Content_START -->
### 2024.09.25

####  開發工具

[Remix](https://remix.ethereum.org)，可以直接使用瀏覽器開發，並可以佈署在獨立的測試鏈，提供測試帳號，每個帳號有大約 100 顆ETH測試幣來方便進行測試。

使用 `Ctrl + S` 可以編譯程式碼，編譯後可以點按 `Deploy`，將合約佈署至測試鏈上來進行測試。

### 合約架構
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
分為三個主要部份
1. License 的設套
```
// SPDX-License-Identifier: MIT
```
2. 使用的 Solidity 版本
```
pragma solidity ^0.8.21;
```

3. 合約邏輯主體
```
contract HelloWeb3 {
  string public _string = "Hello Web3!"
}
```



### 變數型態

Solidity 變數型態基本上分成 3 類
1. Value Type: 布林值、整數值等等…，變數存放的是實際資料
2. Reference Type: Array 、Struct，變數存放的是資料所在的記憶體位置
3. Mapping Type: 用來儲存鍵值對的資料類型，就像 HashTable

### Value Type
#### 布林
存放 `true` or `false` 這兩種資料。
布林值能使用的邏輯運算子為：
- !
- &&
- ||
- == 
- !=
```
bool public bool1 = true;
```

需注意的是， `&&` 及 `||` 套用短路原則，當已經有運算結果的時候，就不會將所有邏輯運算都值行完，例如
  ```
    true || false //會直接回傳 true，不會再往後確認
    false && true // 會直接回傳 false，不會再往後確認
  ```


#### 整數
可以存放正、負整數值

可使用的運算子包含:
- 比較運算子： `<=` `>=` `<` `==` `!=-` j`>`
- 計算運算子：`+`，`-`，`*`，`/`，`%`，`**`
```
int public _int = -`
unit public _unit = 1 // 正整數
```
### Address
地址可以分為兩種
- 普通地址`address`： 存放一個20字元的值 (以太坊地址長度)
- 付費地址 `payable address`： 比普通地址多了 ` transfer` 及 `send` 兩個方法，來用於進行轉帳
```
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address);
```
### 字元陣列
字元陣列分為有固定長度及不固定長度兩種：
- 固定長度：屬於 `Value Type` 長度宣告後不能變更，根據資料長度分別有 `bytes1` 、`bytes8`、`bytes32`，最長就是32個字元
- 不固定長度：屬於 `Reference Type) 長度宣告後可以變更
```
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0]; 
```

### enum

一個較為冷門的變數型別，沒什麼人使用。
```
enum ActionSet { Buy, Hold, Sell }
```
<!-- Content_END -->

<!-- Content_END -->
