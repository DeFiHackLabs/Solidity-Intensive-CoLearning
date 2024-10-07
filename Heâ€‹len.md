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
### 2024.10.07
pure 和 view 關鍵字在 Solidity 中非常重要，對於初學者來說可能比較難理解，因為其他編程語言中並沒有類似的概念。這兩個關鍵字的引入主要是為了管理以太坊交易中的 Gas 費用。

為什麼需要 `Pure `和 `View`？
在以太坊上，合約的狀態變量是存儲在區塊鏈上的，每次修改這些狀態變量時，都需要消耗 Gas 費。而 pure 和 view 這兩個關鍵字是為了區分那些不需要修改鏈上狀態的操作，從而節省不必要的 Gas 費用。
### 2024.10.04

1. `public` 函數
在10.03的範例中，`setNumber` 函數是一個 `public` 函數，可以被內部和外部的任何人調用。
```solidity
function setNumber(uint256 _number) public {
    number = _number;
}
```
 `public` 函數會修改合約中的狀態變量 `number`，因此`需要`支付 gas。

 2. `view `函數
`getNumber` 函數是一個 view 函數，`它只能讀取 number 的值`，`不能`修改。
調用 view 函數`不會`改變鏈上的數據，直接從本地調用時`不需要`支付 gas。
```solidity
function getNumber() public view returns (uint256) {
    return number;
}
```
3. `pure` 函數
pure 函數既不會讀取也不會修改鏈上的狀態變量。它們純粹是`計算函數`，像 add 函數一樣，執行簡單的加法運算。
```solidity
function add(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
```
結論
Solidity 中的函數十分靈活，包含不同的可見性和功能修飾符，可以根據合約的需求進行各種操作。`pure` 和 `view` 函數特別用來處理不會改變鏈上狀態的操作，而 `payable` 函數則允許合約接收 ETH。理解這些函數的特性，對開發智能合約至關重要。

如果對於 pure 和 view 還有疑問，可以想像它們在合約中如同遊戲中的角色一樣，pure 只是一個純打酱油的角色，而 view 是一個`看`角色，能看不能改！

### 2024.10.03
### 函數的結構 (發現仍有點陌生重讀）
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
以上是 Solidity 中函數的基本格式。接下來逐項解釋（方括號中的關鍵字是可選的）

Solidity 中`函數`的基本格式。

1. function：函數的關鍵字，用來聲明函數。
2. function name：函數名稱。
3. (parameter types)：圓括號中是函數的參數類型和名稱（輸入到函數的變量）。
4. internal、external、public、private：函數的可見性修飾符，共有 4 種
   
    (1) `public`：內部和外部`都`可以訪問。
   
    (2) `private`：只能從合約內部訪問，`繼承`的合約`無法`使用。
   
    (3) `external`：只能從合約外部訪問，但可以用 `this.f()` 在內部調用（`f `是函數名稱）。
   
    (4) `internal`：只能從合約內部訪問，`繼承`的合約`可以`使用。
   
注意 1：所有函數都需要明確指定可見性，`沒有`默認值。

注意 2：public、private 和 internal 也可用於`修飾狀態變量`。
       public 變量會`自動`生成同名的 `getter `函數。


5. pure|view|payable：這些關鍵字決定函數的行為

(1) pure：函數既`不能讀取`也`不能寫入`狀態變量。

(2) view：函數`可以讀取`狀態變量，但`不能`寫入。

(3) payable：允許函數`接收`以太幣（ETH）。

6. returns (return types)：函數的`返回值``類型`和名稱。

範例：
```solidity
pragma solidity ^0.8.0;

contract Example {
    uint256 public number;

    // public 函數：可以被內部或外部訪問
    function setNumber(uint256 _number) public {
        number = _number;
    }

    // view 函數：僅能讀取狀態變量，不會修改它
    function getNumber() public view returns (uint256) {
        return number;
    }

    // pure 函數：不讀取或修改狀態變量
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // payable 函數：允許接收以太幣
    function deposit() public payable {}

    // external 函數：只能從外部訪問
    function external Function() external pure returns (string memory) {
        return "This is an external function";
    }
}
```


### 2024.10.02
1. 執行Poolin運算
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract ValueTypes{
    // 布尔值
    bool public _bool = true;
    // 布尔运算
    bool public _bool1 = !_bool; //取非
    bool public _bool2 = _bool && _bool1; //与(&&（邏輯與，AND） && 是邏輯與運算符，當兩個操作數都為 true 時，結果才是 true。如果任一操作數為)
    bool public _bool3 = _bool || _bool1; //或( || 是邏輯或運算符，只要任一操作數為 true，結果就是 true。只有當兩個操作數都為 false 時，結果才是 false)
    bool public _bool4 = _bool == _bool1; //相等(用來判斷兩個pool是否相等。如果兩者相等，結果為 true，否則為 false。)
    bool public _bool5 = _bool != _bool1; //不相等


    // 整数
    int public _int = -1;
    uint public _uint = 1;
    uint256 public _number = 20220330;
    // 整数运算
    uint256 public _number1 = _number + 1; // +，-，*，/
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小


    // 地址
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address
    
    
    // 固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity"; // bytes32: 0x4d696e69536f6c69646974790000000000000000000000000000000000000000
    bytes1 public _byte = _byte32[0]; // bytes1: 0x4d
    
    
    // Enum
    // 将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;

    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }
}
```

### 2024.10.01

## 4. 定長字節數組（Fixed-Length Byte Arrays）

在 Solidity 中，字節數組分為兩種類型：

(1)`定長字節數組`（Fixed-Length Byte Arrays）：其`大小`在宣告後`不能`改變，屬於`值類`型。常見的類型有 `bytes1`, `bytes8`, `bytes32` 等。

(2)`不定長字節數組`（Dynamically Sized Byte Arrays）：其大小可以在`程式運行`時`改變`，屬於`引用`類型，主要類型是 `bytes`。
範例
```solidity
// 固定長度的字節數組
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0];  // 取得 _byte32 的第一個字節
```
在這段程式碼中：
(1) 變數 _byte32 以字節的方式存儲了字串 MiniSolidity，若將其轉換成 16 進制表示，結果為：
結果為：
```solidity
0x4d696e69536f6c69646974790000000000000000000000000000000000000000
```
這表示字串以 bytes32 的格式儲存，_byte 變數的值為 _byte32 的第一個字節，即 0x4d，這是字母 M 的 16 進制 ASCII 編碼。

(2) 取出第二個字節：
```
bytes1 public _byte2 = _byte32[1];  // 取得第二個字節，結果為 0x69 (字母 'i')
```
(3) 創建 16 字節數組：

```solidity
bytes16 public _byte16 = "Hello, World!";
```
_byte16 將會儲存前 16 個字節，並補零至 16 個字節長。


### 2024.09.30
## 3. 地址類型（Address）
在 Solidity 中，address 是一種專門用於儲存以太坊地址的資料類型。地址類型有兩種類型：

(1) 普通地址（address）：用於儲存一個 20 字節長的以太坊地址。
(2) 支付地址（`payable` address）：這類地址可以接收`以太幣`（ETH），並且有 `transfer` 和 `send` 這兩個方法可以進行轉帳。
範例：
```solidity
// 地址類型示範
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;  // 普通地址
address payable public _address1 = payable(_address);                  // 可支付地址，可以進行轉帳操作
```

(3) 地址類型的成員變數
```solidity
uint256 public balance = _address1.balance;  // 獲取地址的餘額（以 wei 為單位）
```
在上述範例中：

_address 是一個普通的以太坊地址。
_address1 是一個 payable 類型的地址，可以接收以太幣。
使用 balance 成員變數可以查詢某個地址的以太幣餘額。


### 2024.09.29
## 2. 整型

在 Solidity 中，整型（Integer）表示的是整數，最常用的整型類型包括：
- `int`：可以儲存`正數`與`負數的`整數。
- `uint`：`僅`儲存正整數。
- `uint256`：最大可以儲存 256 位元的正整數。

```solidity
// 整型示範
int public _int = -1;         // 整數，包含負數
uint public _uint = 1;        // 正整數
uint256 public _number = 20220330;  // 256 位正整數
```
### 常用整型運算符
[1].比較運算符（返回Boolean-二值變量）：

`<=`：小於等於
`<`：小於
`==`：等於
`!=`：不等於
`>=`：大於等於
`>`：大於

[2].算術運算符：

`+`：加法
`-`：減法
`*`：乘法
`/`：除法
`%`：取餘數
`**`：幂次方（指數運算）

// 整數運算範例
```solidity
uint256 public _number1 = _number + 1;   // 加法，_number1 為 20220331
uint256 public _number2 = 2**2;          // 指數，2 的 2 次方，結果為 4
uint256 public _number3 = 7 % 2;         // 餘數運算，7 除以 2 餘數為 1
bool public _numberbool = _number2 > _number3;  // 比較，_number2 是否大於 _number3，結果為 true
```


### 2024.09.28
進度：短路規則（Short-Circuiting）

Short-Circuiting在邏輯運算中可優化計算效率，對於已知的事實，直接產出結果：

XXX `condition`

例1：
 `&&`（邏輯與），當左邊的條件為 false 時，`右邊的條件不再被計算`，因為無論右邊的條件是什麼，結果`必然`是 `false`。
 
註：`&&` 是邏輯與運算符，當`兩個`操作數都為 `true` 時，結果才是 `true`。如果任一操作數為 `false`，結果就為 `false`。
 

```
bool condition = false && expensiveFunction();
// `expensiveFunction()` 不會被執行
```
例2：
對於 `||`（邏輯或），當左邊的條件為 true 時，右邊的條件不會再被計算，因為結果已經是 true。
(|| 是邏輯或運算符，只要任一操作數為 true，結果就是 true。)

```
bool condition = true || expensiveFunction();
// `expensiveFunction()` 不會被執行
```

這種短路行為可以避免不必要的計算，特別是在運算代價高昂的情況下，降低多於運算可減少成本並提高效率。


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
## 1. 布林型（二值變量）與邏輯運算

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
