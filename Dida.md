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


### 2024.09.26

### 函式

```
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- function：宣告函式定義的開始
- <function name>: 函式名稱
- (<parameter types>): 函式允許傳入的參數的基態及名稱
- {internal | external | public | private }: 函式的可見度宣告
  - public: 內外部都可見
  - private: 只能從合約內部進行呼叫，就算是繼承也不可使用
  - external: 只能從合約外部呼叫，而內部可以透過 `this.<function name>()` 的方式來呼叫
  - internal: 只能在合約內部使用，繼承的的合約也可以使用

  > 注意1: 要明確定義可見度，沒有預設值

  > 注意2: 可見度也可以用來定義變數的可見度，當定義為 `public` 的時候會自動生成同名的 `getter` 函式，如果變數未標明可見度的話默認為 internal
- [pure|view|payable]: 
  - pure: 不能讀取也不能入變數，就是一個純粹的函式，因為不會改變鏈上資料，所以不會有 gas fee 產生
  - view: 單純讀取變數，不可改變變數資料
  - paybale: 可以進行支付的函式
- [returns()]: 定義函數要回傳的變數型別及名稱



### 2024.09.28

#### 函式輸出

Solidity 有兩個關鍵字  `return` 及 `returns` 差別在
- `returns`: 用來定義函式的回傳值的型態及名稱
- `return`: 在函式內，用於在設定回傳值
```
// 對回傳參數進行命名
function returnNamed() public pure returns(unit256 _number, bool _bool, unit256[3] memory _array) {
  return(1, true, [unit256(1),2,5])
}
```

#### 解賦值
- 讀取所有返回值
```
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
- 讀取部份返回值
```
// 不讀取的留空，單存只設定要讀取返回值的變量
(, _bool2, ) = returnNamed();
```


### 2024.09.30

#### 變數儲存
Solidity 儲存的位置總共有三種 
- `storage`
  儲存在鏈上，合約狀態變數預設都是儲存在 `storage`
- `meomry`
  函式裡的參數和臨時變數一般是用 `memory`，不上鏈
- `calldata`
  和 `memory` 一樣不上鏈，唯一的差別是 `calldata` 變數不能修改


#### 作用域
作用域主要分三種
- 狀態變數
```
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}
```
合約內函數都可以訪問， `gas` 的清秏高


- 局部變數

```
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```
只有在函式的執行過程中有用，退出後就無效， `gas` 低

- 全局變數
solidity 的保留關鍵字，可以不宣告就直接使用，完整的列表請參考[連結](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)

- 全局變數 - 以太及時間單位
  ##### 以太單位
  - wei: 1
  - gwei: 1e9 = 1000000000
  - ether: 1e18 = 1000000000000000000
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

  ##### 時間單位
  - seconds: 1
  - minutes: 60 seconds = 60
  - hours: 60 minutes = 3600
  - days: 24 hours = 86400
  - weeks: 7 days = 604800
  ```
  function secondsUnit() external pure returns(uint) {
    assert(1 seconds == 1);
    return 1 seconds;
  }

  function minutesUnit() external pure returns(uint) {
      assert(1 minutes == 60);
      assert(1 minutes == 60 seconds);
      return 1 minutes;
  }

  function hoursUnit() external pure returns(uint) {
      assert(1 hours == 3600);
      assert(1 hours == 60 minutes);
      return 1 hours;
  }

  function daysUnit() external pure returns(uint) {
      assert(1 days == 86400);
      assert(1 days == 24 hours);
      return 1 days;
  }

  function weeksUnit() external pure returns(uint) {
      assert(1 weeks == 604800);
      assert(1 weeks == 7 days);
      return 1 weeks;
  }
  ```


<!-- Content_END -->

<!-- Content_END -->
