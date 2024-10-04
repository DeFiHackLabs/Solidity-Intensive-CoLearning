---
timezone: Asia/Shanghai
---

---

# Anzhe

1. 自我介绍
大家好，我是 Anzhe，是圖書資訊、資訊工程雙主修的大五學生，對資安領域感興趣，目前一邊補基礎一邊探索資訊、資安各種領域，希望能多多學習各種知識和技術，增加自身能力。
2. 你认为你会完成本次残酷学习吗？
我覺得這次殘酷共學對我來說是了解 Web3、區塊鍊和智能合約的好機會，同時也是對自我的挑戰，我會盡力規劃好時間，努力完成本次的共學目標。
## Notes

<!-- Content_START -->

### 2024.09.23
# Solidty
　　Solidity 是為了全球市值第二的加密貨幣市場乙太坊（Ethereum）創建的程式語言，發布於 2015 年，是為了實現智能合約而設計的物件導向高階程式語言、一種針對以乙太坊虛擬機器的花括號語言，它受到 C++、Python 和 JavaScript 的啟發，用來編寫可以自動執行合約條款的智能合約，更是區塊鍊運行平台的主要使用語言，可以用於創建投票、盲拍、群眾募資、多重簽名錢包等用途的合約。

### Solidity 主要特點
1. 靜態類型語言：編譯時需要指定每個變數的類型。
2. 合約繼承：支持合約的繼承，讓開發者可以重用程式碼。
3. 函數修飾器：用來修改函數的行為，例如限制只有合約擁有者可以調用某個函數。
4. 事件：智能合約可以發送事件，供前端應用或其他合約監聽。
# 智能合約
智能合約是乙太坊最大的創新之一，開發者編寫、部署自動執行合約條款的智能合約到乙太坊區塊鍊上，智能合約在部署到區塊鏈後，能夠不依賴第三方自動執行和記錄交易，並且記錄是不可更改的。
# 乙太坊
乙太坊是一個去中心化的開源區塊鍊平台，主要支援分散式（去中心化）應用和智能合約。和主要用於數字貨幣交易的比特幣和其他區塊鍊平台的差異在於：乙太坊提供了一個能夠執行編程邏輯的區塊鏈環境——乙太坊虛擬機(Ethereum Virtual Machine)，它是一個分散式的計算機網絡，保證每個節點能夠正確執行合約，開發者可以在其上構建和運行去中心化的應用。

---
# Solidity 101
開發工具 `Remix` : [https://remix.ethereum.org](https://remix.ethereum.org)
教程使用 `Remix` 運行 Solidity 合約，`Remix` 是乙太坊推薦基於瀏覽器的智能合約整合式開發環境（IDE）。

## Remix 開發流程
Remix 左側面板，選擇`文件`面板可以新增`檔名.sol`檔案用 Solidity 開始編寫只能合約，快捷鍵 `Ctrl + S` 可以對檔案進行編譯，選擇`部署`面板並點擊 `Deploy` 則可以把智能合約部署到區塊鍊上，`Remix`會分配一些測試帳號給使用者，每個帳號有 100 ETH 的測試幣可以使用，每次部署合約會扣掉一點點。
![](https://i.imgur.com/eBMY37U.png)

## Hello Web3 程式碼
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
### 說明
1. `//` 是單行註解，說明程式碼使用的 License 許可是 `MIT`，註解的內容不會被執行，若不寫許可程式仍可執行，只是編譯時可能會出現警告。
2. Soldity 語句需以 `;` 結尾。
3. `pragma solidity ^0.8.21;` 宣告文件使用的 Solidity 版本，版本不同會有語法差異，`^` 代表向後兼容，表示允許 0.8.21 版本以上的 0.8.x 版本編譯器編譯，但不包括 0.9.x 或更新的版本。
4. `contract HelloWeb3` 是創建合約，並宣告合約的名稱為 `HelloWeb3`，花括弧內則是合約的內容，宣告了一個字串的變數 `_string` 並賦值為 `Hello Web3!`。

部署完畢後，`部署`面板滑到最下方，可以看到名為 `HelloWeb3` 的智能合約，點擊變數 `_string` 可以看到變數儲存的內容。
![](https://i.imgur.com/JE6E9KQ.png)

### 2024.09.24
# Solidity 的變數類型
1. 數值類型（Value Type）
2. 函數類型（Function Type）
3. 引用類型（Reference Type）
4. 映射類型（Mapping Type）
---
# 數值類型
數值類型賦值時可直接傳遞數值，且數值類型的變數是互相獨立的。
分成以下類型：
1. 布林類型：`bool`。
2. 整數類型：`int`、`uint`。
3. 地址類型：`address`、`address payable`。
4. 固定長度位元組陣列：`bytes1`、`bytes32`。
5. 枚舉類型：`enum`。
## 1. 布林類型
`bool` 的值只有 `true` 和 `false` 兩種。
```
bool public _bool = true;
```
### 布林值的運算符：
* `!` NOT，非
* `&&` AND，與
* `||` OR，或
* `==` 等於
* `!=` 不等於
```
bool public _bool1 = !_bool; // 取 NOT，_bool1 結果是 false
bool public _bool2 = _bool && _bool1; // AND，_bool2 結果是 false
bool public _bool3 = _bool || _bool1; // OR，_bool3 結果是 true
bool public _bool4 = _bool == _bool1; // 相等，_bool4 結果是 false
bool public _bool5 = _bool != _bool1; // 不相等，_bool5 結果是 true
```
### 短路規則
* 若存在 f(x) || g(y) 的表達式，如果 f(x) 是 true，結果一定是 true，第二個條件 g(y) 就不會被計算、判斷。
* 若存在 f(x) && g(y) 的表達式，如果 f(x) 是 false，結果一定是 false，第二個條件 g(y) 就不會被計算、判斷。
## 2. 整數類型
* `int` 是有號整數，從 `int8` 、`int16` ……到 `int256`，後面都是接 8 的倍數，表示占幾位元，`int8` 的範圍是 -128 ~ 127。`int256` 可直接由 `int` 表示。
* `uint` 是無號整數，從 `uint8` 到 `uint256`，後面都是接 8 的倍數，表示佔幾位元，`uint8` 的範圍是 0~ 255。`uint256` 可直接由 `uint` 表示。
### 整數運算符
| 比較運算符 | 算術運算符 |
|-----------|-----------|
|`<=` 小於等於 |`+` 加法 |
|`<` 小於 |`-` 減法|
|`==` 等於 |`*` 乘法|
|`!=` 不等於 |`/` 除法|
|`>=` 大於等於 |`%` 取餘數|
|`>` 大於 |`**` 冪次|

```
int public _int = -1; // 整數，包含負數
uint public _uint = 1; // 正整數
uint256 public _number = 20220330; // 256 位元正整數

uint256 public _number1 = _number + 1; // 四則運算，_number1 是 20220331
uint256 public _number2 = 2**2; // 指數，_number2 是 4
uint256 public _number3 = 7 % 2; // 取餘數，_number3 是 1
bool public _numberbool = _number2 > _number3; // 比大小，_number4 是 true
```
## 3. 地址類型
地址類型分成：
* `address`：儲存 20 byte 的乙太坊地址。
* `address payable` 類似 `address` 但比普通地址多了 `transfer` 和 `send` 的成員方法，用於轉帳乙太幣，不過 send 在轉帳失敗時只會回傳 false，而不會回復交易狀態，開發者需要自行處理失敗狀況。
```
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address);
uint256 public balance = _address1.balance; 
_address1.transfer(1);
```
### 說明：
* `payable(_address)` 將普通的 address 轉換為 payable address，用來允許此地址之後可以轉帳、查餘額。
* `_address1.balance` 用來獲取地址持有的乙太幣餘額。
* `_address1.transfer(1);` 從合約的餘額中向 `_address1` 地址發送 `1 wei`（1 以太幣等於 10^18 wei）。transfer() 會在發送失敗時自動回退交易並拋出錯誤，因此它是一個安全進行資金轉移的方式。
## 4. 固定長度位元組陣列
位元組陣列分成固定長度和不固定長度兩種，固定長度的位元組陣列屬於數值類型，陣列長度在宣告之後不能改變，長度分為從 `bytes1`、`bytes8`、……，最多到 `bytes32`。
不定長度的位元組陣列屬於引用類型，在宣告後可以改變長度，包含 `bytes`，之後會提到。
```
bytes32 public _byte32 = "MiniSolidity";
bytes1 public _byte1 = _byte32[0];
bytes2 public _byte2 = _byte32[1];
```
### 說明：
`"MiniSolidity"` 以位元組的方式儲存進變數 _byte32，用 16 進制來看就是 `0x4d696e69536f6c69646974790000000000000000000000000000000000000000`，`_byte32[0]` 擷取第一個位元組 `0x4d` 的部分，存入變數 `_byte1` 中，`_byte32[1]` 擷取第二個位元組 `0x69` 的部分，存入變數 `_byte2` 中。

## 5. 枚舉類型
`enum` 是 Solidity 中由使用者定義的資料類型，主要用在位 `uint` 分配名稱，使程式易於閱讀和維護，他與 C 語言的 enum 類似，使用名稱來代替從 0 開始的 `uint`。
```
enum ActionSet { Buy, Hold, Sell }
ActionSet action = ActionSet.Buy;
function enumToUint() external view returns(uint){
    return uint(action);
}
```
說明：
* `enum ActionSet { Buy, Hold, Sell }` 用 enum 將 uint 0, 1, 2 表示為 Buy, Hold, Sell
* `ActionSet action = ActionSet.Buy;` 建立 enum 變數 action，並將 action 初始化為 ActionSet.Buy，action 變數當前的值對應 enum 中的 Buy，其數值是 0。
* `external` 是一個外部函數，可以被外部合約或外部使用者呼叫。
* `view` 表示這個函數不會改變合約的狀態，只是查看（讀取）資料。
* `returns(uint)` 指定函數的返回類型為 `uint`。
* `return unit(action)` 將 action 的值轉換為 uint，並返回這個值。由於 action 被設為 ActionSet.Buy，其對應的整數值是 0。
* enum 可以和 uint 進行顯式轉換，轉換的正整數需在枚舉長度內，否則會 Error。

### 2024.09.25
今天的內容主要是關於 Solidity 的函數，要注意的是函數概念有分成「函數類型的變數」和「函數」，不是所有函數都有函數類型的變數，但函數可以被賦值給函數類型的變數。
函數分成內部函數和外部函數，內部函數只能在當前合約中呼叫，包括內部函式庫和繼承函數，因為呼叫內部函數透過跳到入口標籤來內部呼叫當前合約的函數。
外部函數由位址和函數簽名組成，可以作為參數傳遞給其他函數，並且也可以從其他函數中返回。
# 函數的語法
```
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
### 說明
* `function` 基本的函數宣告關鍵字。
* `<function name>` 函數名稱。
* `<parameter types>` 傳入到函數內部的參數，要替換成變數類型和變數名稱。
* `{internal|external|public|private}` 是可見性類型，必須指定一個。只有函數變數才預設是 `internal`。
    * `internal` 只能從合約內部訪問，繼承的合約可以用。
    * `external` 只能從合約外部存取（但內部可以透過 this.f() 來調用，f是函數名稱）。
    * `public` 合約內部和外部皆可見。
    * `private` 只能從本合約內部訪問，繼承的合約也不能使用。
    * 註：`public|private|internal` 也可用於修飾**狀態變數**。 `public` 變數會自動產生同名的`getter` 函數，用來查詢數值。未標示可見性類型的狀態變數，預設為`internal`。
* `[pure|view|payable]` 是返回值類型，非必要，決定函數權限、功能的關鍵字。合約的狀態變數儲存在鏈上，改寫鍊上狀態需支付氣費（gas fee），`pure` 和 `view` 不改寫鍊上狀態，所以調用此類函數不用支付氣費。
    * `pure` 函數既不能讀取也不能寫入鏈上的狀態變數。
    * `view` 函數能讀取但也不能寫入狀態變數。
    * `payable` 函數運行時可以給合約轉入乙太幣。
* `[returns ()]` 返回值類型和名稱，非必要。

乙太坊的修改鍊上狀態包括：
1. 寫入狀態變數。
2. 釋放事件。
3. 創建其他合約。
4. 使用 `selfdestruct`
5. 透過調用發送以太幣。
5. 呼叫任何未標記 view 或 pure 的函數。
6. 使用低階呼叫（low-level calls）。
7. 使用包含某些操作碼（Opcodes）的內聯彙編（Inline Assemply）。

---
# 程式碼
## 1. Pure 和 View
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract FunctionTypes{
    uint public number = 0;  // 在合約中定義一個狀態變數 number，public 表示變數合約內部和外部皆可見，初始化為 0
    function add() external{
        number = number + 1;
    }
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number + 1;
    }
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }
}
```
### 說明
* 如果 `add()` 被標記為 `pure` 就會報錯，因為 `pure` 不配合讀取或改寫合約裡的狀態變數；如果 `add()` 函數被標記為 `view` 也會報錯，因為 view 能讀取，但無法改寫狀態變數。
* `addPure()` 傳遞參數 `_number` 並回傳 `_number + 1`，不會有讀取或寫入狀態變數的操作。
![](https://i.imgur.com/mIlAEyI.png)
可以看到當我按 23 次橘色（執行 23 次 add() 函數），number 的值就會增加到 23；而當我執行 `addPure()` 時，我必須輸入一個數字(34)才能執行，執行結果 new_number 是 35，和合約的狀態變量無關，如果不給輸入參數就無法調用 `addPure()`；而當我執行 `addView()` 時，我可以讀取合約的狀態變數 23，所以結果是合約的狀態變數 +1 變成 24。
## 2. internal 和 external
```
    // 接續前面繼續寫
    function minus() internal {
        number = number - 1;
    }
    function minusCall() external{
        minus();
    }
```
重新部署合約後，狀態值會重設，可以發現內部函數 `minus()` 無法調用所以沒有出現，只有新增 `minusCall()` 也是 `external` 可被外部調用，然後間接調用內部函數 `minus()`。
![](https://i.imgur.com/7Q07uxx.png)
## 3. payable
```
    // 接續前面繼續寫
    function minusPayable() external payable returns(uint balance){
        minus();
        balance = address(this).balance;
    }
```
`this` 關鍵字可以引用當前合約地址，然後用 `地址.balance` 返回合約的乙太幣餘額。
在 Deploy 上方可以輸入要轉入多少、選擇幣的單位，然後按 minusPayable() 就可以往合約裡轉入多少幣。
![](https://i.imgur.com/fupwihn.png) ![](https://i.imgur.com/2eQqNzM.png)
註：要注意 minus() 不能把 `number` 扣光，不然會交易失敗然後被 revert。
# 函數輸出
函數輸出的關鍵字 `returns` 在函數名稱後面宣告回傳的變數類型與變數名稱，`return`則是在函數定義中返回指定的變數：
```
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return (1, true, [uint256(1), 2, 5]);
}
```
`returns` 宣告了 `returnMultiple()` 有多個返回值，對應 `return(1, true, [uint256(1),2,5])` 實際的返回值內容。第三個返回值宣告了長度為 3 且類型為 `uint256` 的數列，數列類型的返回值需用 `memory` 修飾。因為 `[1,2,5]` 的型別會默認為 `uint8(3)`，所以強轉第一個元素來宣告陣列元素皆為 `uint256`。
## 命名式回傳
若在 `returns` 中標示回傳變數的名稱，Solidity 會自動初始化這些變數，並自動回傳函數的值，不須使用 `return`。
```
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```
命名式也可以用 `reutrn` 回傳變數：
```
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return (1, true, [uint256(1), 2, 5]);
}
```
## 解構式賦值
Solidity 可以用解構式賦值規則來讀取函數的全部或部分回傳值。
1. 讀取所有返回值：宣告變數，然後依序將要賦值的變數以,隔開。
```
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
2. 讀取部分傳回值：宣告要讀取的回傳值對應的變數，不讀取的留空。
```
bool _bool2;
(, _bool2, ) = returnNamed(); // 只讀取_bool，而不讀取傳回的_number和_array
```
寫進 function 內再執行：
```
function ReadReturn() public pure{
    uint256 _number;
    bool _bool;
    uint256[3] memory _array;
    (_number, _bool, _array) = returnNamed();
    bool _bool2;
    (, _bool2, ) = returnNamed();
}
```
## 執行結果
![](https://i.imgur.com/Bhud5Up.png)

### 2024.09.26
# 引用類型
引用類型變數會存儲引用（類似於指針），賦值時不會直接複製值，兩個變數可能引用同一塊資料，分成以下類型：
1. 字串類型：`string`，動態長度的 UTF-8 字符串。
2. 動態長度位元組陣列：`bytes`，類似於 `string`，但可以存儲任意長度的字位元組資料。
3. 陣列：`uint[]`、`uint[5]`，固定長度和動態長度的數組。
4. 結構：用來定義自訂的複合資料類型。
5. 映射：類似於哈希表，可以將鍵類型對應到值類型，鍵類型可以是 `address`、`uint` 等，值類型可以是任何變數類型。
陣列、結構占用的儲存空間較大，這類變數需宣告資料儲存的位置。
---
## 資料儲存位置
資料儲存位置有三類，`storage`、 `memory` 和 `calldata`，不同儲存位置的 gas 成本不同。
1. `storage` 資料存在鍊上，類似電腦硬碟，消耗較多 gas，合約裡的狀態變數預設都是storage。
2. `memory` 資料臨時存在記憶體，不上鍊，消耗較少 gas，函數裡的參數和臨時變數一般用 `memory`。若函數回傳資料像是 `string`、`bytes`、`array` 和 `struct` 這種比較長的，必須加 `memory` 修飾。
3. `calldata` 類似 `memory`，區別在 `calldata` 變數**不能被修改**（`immutable`），一般用在函數的參數。
```
function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    return(_x); // _x 不能被修改
}
```
### 資料儲存位置與賦值規則
當不同儲存位置類型變數互相賦值時，有時會產生獨立的副本（修改新變數不會影響原變數），有時會產生引用（修改新變數會影響原變數）。
1. 賦值本質上是建立**引用（參考）**指向本體，因此修改本體或引用，資料變化是可以同步的。
    * `storage`（合約的狀態變數）賦值給本地 `storage`（函數內部）時候，會建立引用，改變新變數會影響原變數。例如
    ```
    uint[] x = [1,2,3];
    function fStorage() public{
        uint[] storage xStorage = x; // 宣告一個 storage 的變數 xStorage，指向 x
        xStorage[0] = 100; // x 第一個元素也會被修改成 100
    }
    ```
    * `memory` 賦值給 `memory`，會建立引用，改變新變數會影響原變數。
2. 其他情況賦值創建的是本體的副本，即對二者之一的修改，並不會同步到另一方。
## 變數的作用域
### 1. 狀態變數
狀態變數儲存在鏈上，所有合約內函數都可以訪問，gas 消耗多。狀態變數在合約內、函數外宣告。
#### 狀態變數宣告與更改
```
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
    function foo() external {
        x = 5;
        y = 2;
        z = "Hi~";
    }
}
```
### 2. 局部變數
局部變數僅在函數執行過程中有效，函數外變數無效。局部變數的資料儲存在記憶體裡，不上鏈，gas 消耗少。局部變數在函數內宣告。
```
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```
### 3. 全域變數
全域變數是全域範圍皆可用的變數，都是 solidity 預留關鍵字。全域變數可以在函數內不聲明直接使用。如：`msg.sender` 請求發起地址、`block.number` 目前區塊的編號、`msg.data` 請求資料。
| 全域變數 | 回傳型別 | 說明 |
| --- | --- | --- |
| `blockhash(uint blockNumber) returns (bytes32)` | `bytes32` | 當 blocknumber 是 256 個最新區塊之一時，給定區塊的雜湊值；否則返回零 |
| `blobhash(uint index) returns (bytes32)` | `bytes32` | 傳回跟目前交易關聯的第 index 個 blob 的版本化哈希，如果不存在具有給定索引的 blob，則傳回零。 |
| `gasleft() returns (uint256)` | `uint256` | 剩餘 gas |

| 全域變數 | 型別 | 說明 |
| --- | --- | --- |
| `block.basefee` | `uint` | 目前區塊的基本費用 |
| `block.blobbasefee ` | `uint` | 目前區塊的 blob 基本費用 |
| `block.chainid` | `uint` | 目前區塊鍊的 ID |
| `block.coinbase` | `address payable` | 目前區塊礦工地址 |
| `block.difficulty` | `uint` | 目前區塊難度 |
| `block.gaslimit` | `uint` | 目前區塊 gaslimit |
| `block.number` | `uint` | 目前區塊的編號 |
| `block.prevrandao` | `uint` | 信標鏈提供的隨機數 |
| `block.timestamp` | `uint` | 目前區塊時間戳，以 unix epoch 以來的秒數來計 |
| `msg.data` | `bytes calldata` | 完整的 calldata |
| `msg.sender` | `address` |  請求發起的地址 |
| `msg.sig` | `bytes4` | 呼叫資料的前四個位元組（即函數標識符） |
| `msg.value` | `uint` | 與訊息一起傳送的 wei 數量 |
| `tx.gasprice` | `uint` | 交易的 gas 價格 |
| `tx.origin` | `address` | 交易發起者（完全的調用鍊） |

```
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```
### 4. 全域變數-以太單位與時間單位
#### 以太單位
Solidity 沒有小數點，以 0 代替小數點來確保交易精確度，使用乙太單位避免誤算。
* `wei`：1
* `gwei`：1e9 = 1000000000
* `ether`：1e18 = 1000000000000000000
```
function weiUint() external pure returns(uint) {
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
註： `assert` 是一個用於檢查條件是否為 true 的內建函數，它通常被用來檢測合約中的邏輯錯誤。當 `assert` 的條件不滿足時，會觸發一個錯誤並且回退（revert）整個交易。
![](https://i.imgur.com/B3IRBAd.png)
#### 時間單位
合約中可以規定一個操作必須在一週內完成，或某個事件在一個月後發生，就能讓合約的執行可以更精確，不會因為技術上的誤差而影響合約的結果。因此，時間單位在 Solidity 中是一個重要的概念，可以提高合約的可讀性和可維護性。
* `seconds`: 1
* `minutes`: 60 = 60 seconds
* `hours`: 3600 = 3600 seconds
* `days`: 24 hours = 86400
* `weeks`: 7 days = 604800
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
![](https://i.imgur.com/1RTxMs0.png)
---
## 陣列
可以用來儲存一整組相同變數型別的資料：整數、位元組、地址，分成固定長度與可變長度。
* 固定長度陣列：宣告時指定長度
```
uint[8] array1;
bytes1[5] array2;
address[100] array3;
```
* 動態陣列：宣告時不指定數組的長度
```
uint[] array4;
bytes1[] array5;
address[] array6;
bytes array7; // bytes 是動態長度位元組陣列
```
註：不能用 `byte[]` 宣告單位元組陣列，應使用 `bytes` 或 `bytes1[]`，但 `bytes` 更省 gas。
### 建立陣列的規則
1. 用 `memory` 修飾的動態陣列，可以用 `new` 運算元來創建，但是必須宣告長度，且宣告後長度不能改變。動態陣列需一個個元素賦值。
```
uint[] memory array8 = new uint[](5);
bytes memory array9 = new bytes(9);
```
```
function initArray() external pure returns(uint[] memory){
    uint[] memory x = new uint[](3);
    x[0] = 1;
    x[1] = 3;
    x[2] = 4;
    return(x);
}  
```
2. Array Literals 用方括號包著來初始化陣列，裡面每一個元素的型別以第一個元素為準，如果一個值沒有指定type的話，會根據上下文推斷出元素的類型，預設就是最小單位的型別。
### 陣列成員（陣列操作）
* `length`：陣列有一個包含元素數量的 length 成員，memory 陣列的長度在建立後是固定的。
* `push()`：動態陣列擁有 `push()` 成員，可以在陣列最後加上一個 `0` 元素，並傳回該元素的參考。
* `push(x)`：動態陣列擁有 `push(x)` 成員，可以在陣列最後加上一個 x 元素。
* `pop()`：動態陣列擁有 `pop()` 成員，可以移除陣列最後一個元素。
```
function arrayPush() public returns(uint[] memory){
    uint[2] memory a = [uint(1),2];
    array4 = a;
    array4.push(3);
    return array4;
}
```

---
## 結構
結構中的元素可以是數值類型，也可以是引用類型，結構也可以作為陣列或映射的元素。
```
struct Student{
    uint256 id;
    uint256 score;
}
Student student; // 建立一個結構
```
### 結構賦值
#### 1. 在函數中建立一個 storage 的 struct引用
```
function initStudent() external {
    Student storage _student = student; // storage 賦值 storage 直接引用
    _student.id = 11;
    _student.score = 100;
}
```
#### 2. 直接引用狀態變數的結構
```
function initStudent2() external{
    student.id = 1;
    student.score = 80;
}
```
#### 3. 建構函數式
```
function initStudent3() external{
    student = Student(3, 90);
}
```
#### 4. 用 key value
```
function initStudent4() external {
    student = Student({id: 4, score: 60});
}
```
### 2024.09.27
# 映射類型
映射類型是一種鍵值對（Key-value Pair）資料結構的的變數類型，是引用類型變數的一種，使用者利用鍵值（Key） 查詢對應的值（Value）。語法是 `mapping(<Key type> => <Value Type>)`，`<Key Type>` 和 `<Value Type>` 分別是 Key 的變數類型和 Value 的變數類型。
```
mapping(uint => address) public idToAddress;
mapping(address => address) public SwapPair;
```
## 映射規則
1. Key 只能是 Solidity 的數值類型，不能使用引用類型的自定義結構，但 Vaule 可以使用自定義的結構。
```
struct Student{
    uint256 id;
    uint256 score;
}
mapping(Student => uint) public testVar;
```
2. 映射的儲存位置是 `storage`，可用於合約的狀態變數，作為函數中 `storage` 變數的參數和 `library` 函數的參數，但不可用於 `public` 函數的參數或回傳，因為映射紀錄的是一種關係（Key-value Pair）。
3. 如果映射宣告為 `public`，那麼 Solidity 會自動為映射建立一個 `getter` 函數，透過 Key 來查詢對應的 Value。
4. 映射新增鍵值對的語法為 `_Var[_Key] = _Value
```
function WriteMap(uint _Key, address _Value) public {
    idToAddress[_Key] = _Value;
}
```
5. 映射不儲存任何按鍵（Key）的資訊，也沒有 length 的資訊。
6. 映射原理：使用 `keccak256(abi.encodePacked(key, slot))` 當成 offset 存取 value ，其中 slot 是映射變數定義所在的插槽位置。
7. 因為乙太坊會定義所有未使用的空間為 0，所以未賦值（Value）的鍵（Key）初始值都是各個型別的預設值，如 `uint` 的預設值是 0。
### 結果
先用 WriteMap 輸入兩個參數設定 Key 和 Value，`idToAddress` 映射變數再用 Key 去查， Value 從預設值（0x000...）變成設定的 Value。
![](https://i.imgur.com/dQVOn6e.png)
# 變數初始值
變數在宣告後如果沒有賦值，都有其初始值（預設值）。
| 變數類型 | 初始值 |
|---|---|
| `bool` | `false` |
| `string` | `""` |
| `int` | `0` |
| `uint` | `0` |
| `bytes1` | `0x00` |
| `enum` | 枚舉的第一個元素 |
| `address` | `0x0000000000000000000000000000000000000000` 或 `address(0)`|
| `function` | `internal`、`external` 都是空白函數 |
| `mapping` | 所有元素設為其預設值，mapping 本身會回傳 ValueType 變數類型的的初始值 |
| `struct` | 所有成員設為其預設值 |
| `array` | 動態陣列：`[]`、 靜態陣列：所有成員設為其預設值|
```
uint[8] public _staticArray; // [0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // `[]`
mapping(uint => address) public _mapping;
struct Student{
    uint256 id; // 0
    uint256 score; // 0
}
Student public student;
```
註：mapping 本身會回傳 ValueType 變數類型的的初始值，所以 `_mapping` 的初始值是 address 的預設值 `0x0000000000000000000000000000000000000000`
### delete 操作符
`delete a` 讓變數 `a` 的值變為初始值。
```
bool public _bool2 = true;
function d() external {
    delete _bool2; // _bool2 變成初始值 false
}
```
# 常數
狀態變數宣告 `constant` 和 `immutable` 這兩個關鍵字後，狀態變數就不能在初始化後更改數值，可以提升合約安全性和節省 gas。
只有數值變數可以聲明 `constant` 和 `immutable`；`string` 和 `bytes` 可宣告為 `constant`，但不能是 `immutable`。
## Constant
constant 必須宣告時初始化變數，宣告時必須賦值，之後變數不能再變更數值。
```
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```
## Immutable
immutable 變數可以在宣告時或建構子中初始化，若 immutable 變數既在宣告時初始化，又在 constructor 中初始化，會使用 constructor 初始化的值，用法更靈活。
```
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;
// 利用建構子初始化 immutable 變數
constructor(){
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test(); // 利用函數給 IMMUTABLE_TEST 初始化為 9
}
function test() public pure returns(uint256){
    uint256 what = 9;
    return(what);
}
```
### 2024.09.28
# 控制流
程式的控制流常見的條件控制、迴圈控制在 Solidity 中也有，注意在使用迴圈時，要確保有適當的結束條件，避免潛在的資源浪費和 gas 消耗。另外迴圈也可以使用 `continue` （進入下一個迴圈）和 `break`（跳出目前的迴圈）。
```
function ifElseTest(uint256 _number) public pure returns(string memory){
    if (_number > 0) {
        return "The number is positive.";
    } else if (_number < 0) {
        return "The number is negative.";
    } else {
        return "The number is zero.";
    }
}
```
## 2. `for` 迴圈
```
function sumFor(uint n) public pure returns (uint) {
    uint total = 0;
    for (uint i = 1; i <= n; i++) {
        total += i;
    }
    return total;
}
```
## 3. `while` 迴圈
```
function sumWhile(uint n) public pure returns (uint) {
    uint total = 0;
    uint i = 1;
    while (i <= n) {
        total += i;
        i++;
    }
    return total;
}
```
## 4. `do-while` 迴圈
```
function sumDoWhile(uint n) public pure returns (uint) {
    uint total = 0;
    uint i = 1;
    do {
        total += i;
        i++;
    } while (i <= n); 
    return total;
}
```
## 5. 三元運算子
三元運算子 `?:` 是 Solidity 中唯一接受三個運算元的運算子。
語法：`<condition>?<expression1>:<expression2>`。如果 `<condition>` 的判斷為 true，結果就是 `<expression1>`，如果 `<condition>` 的判斷為 false，結果就是 `<expression2>`。`?:` 經常作為簡化的 `if` 條件語句使用。
```
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
    return x >= y ? x: y; 
}
```
# 插入排序
插入排序是將一組無序的數列由小到大排好，它會從頭開始將每一個數字與前面的數字比較，如果找到比自己大的數字中最小的，插入到它的前一個。
假設數列是 `[2, 5, 3, 1]`。
## 用 python 怎麼寫插入排序
![](https://i.imgur.com/rg4W9k6.png)
i = 1，第 1 圈時，跟 0 比
i = 2，第 2 圈時，跟 1~0 比
i = 3，第 3 圈時，跟 2~0 比
i = 4，第 4 圈時，跟 3~0 比
```
arr = [2,5,3,1]
def insertSort(arr):
    for i in range(1, len(arr)):
        key = arr[i] # 把 i 的元素暫存到 key
        j = i - 1
        while j >= 0 and arr[j] > key: # 當 j 還沒找完且 key 的前面有更大的數
            arr[j+1] = arr[j] # 第 j 個元素往後 1 個
            j -= 1
        arr[j+1] = key # 把 key 替換到前面
    return arr
```
## 用 Solidity 寫插入排序
因為 `uint` 不可以存到負數，否則運行過程會有 underflow Error，而 `j` 變數如果按上面的邏輯寫可能會存到負數，所以把 j 加一讓它在計索引過程中最小是 0 就不會引起 Error。
![](https://i.imgur.com/8EI6bC0.png)
```
function insertSort(uint[] memory a) public pure returns(uint[] memory) {
    for(uint i = 1; i < a.length; i++){
        uint temp = a[i];
        uint j = i;
        while((j >= 1) && (a[j-1] > temp)){ // 當 j 還沒找完且 temp 的前面有更大的數
            a[j] = a[j-1]; // 第 j-1 個元素往後 1 個
            j--;
        }
        a[j] = temp; // 把 temp 替換到前面
    }
    return(a);
}
```
### 運行結果
![](https://i.imgur.com/Ecr9Ybw.png)

### 2024.09.29
今天的主題是前天提過的建構子（Constructor），Solidity 獨有的修飾器（Modifier）。我們可以透過這建構子與修飾器來實現智能合約的權限控制。
# 建構子
每個合約可以定義一個建構子，它會在部署時自動運行一次，可以拿來完成初始化合約的參數（賦值）。
```
address owner;
constructor(address initialOwner){
    owner = initialOwner;
}
```
註：0.4.21 以前的 Solidity 版本使用與合約名稱同名的函數當作合約建構子使用，開發者如果寫錯建構子名稱，建構子就會變成一般函數，導致參數未正確初始化而引發漏洞。
# 修飾器
修飾器（Modifier）是 Solidity 特有的語法，類似於物件導向程式設計中的裝飾器（decorator），宣告函數擁有的特性，並減少冗餘的程式碼，帶有裝飾器的函數會有某些特定的行為。主要使用場域是執行函數前檢查地址、變數、餘額等。
## Modifier 語法
```
modifier <modifierName>() {
    // 前置檢查或操作
    // require(<condition>,<errorMessage>)
    _; // 這個佔位符表示原函數的邏輯
    // 後置檢查或操作
}
```
* `<modifierName>` 是修飾器的名稱。
* `<condition>` 檢查是否符合條件。
* `<errorMessage>` 是錯誤訊息字串，當 `<condition>` 為 false 時，這個訊息會被作為錯誤信息回傳，也可以不寫。
### 修飾器例子
首先，定義一個叫做 `onlyOwner` 的 modifier：
```
modifier onlyOwner {
    require(msg.sender == owner, "Only the owner can call this function."); // 檢查合約發起者是否為 owner 的地址
    _; 如果是的話，就繼續運行函數；否則報 error 並 revert 交易
}
```
帶有 `onlyOwner` 修飾符的函數只能被 `owner` 地址調用：
```
function changeOwner(address _newOwner) external onlyOwner{ // 這邊調用 onlyOwner 確認此請求是由 Owner 發出的，只有符合條件這個函數才會繼續被執行
    owner = _newOwner;
}
藉此可以達到控制智能合約的權限。
```
### 多個修飾器
Solidity 支援多個修飾器的組合使用，這些修飾器會按順序執行。
```
modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function.");
    _;
}
modifier validAddress(address _address) {
    require(_address != address(0), "Invalid address.");
    _;
}
function transferOwnership(address newOwner) public onlyOwner validAddress(newOwner) {
    owner = newOwner;
}
```
`transferOwnership` 函數同時使用了 `onlyOwner` 和 `validAddress` 修飾器，這樣可以在函數執行前同時檢查兩個條件。

補充：`OpenZeppelin` 是一個維護 Solidity 標準化程式碼庫的組織，有一套 [Ownable 的合約模組](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol)，用於實現基本的權限控制，允許合約擁有者對合約進行管理，所以這個模組可以作為其他合約的基礎合約，也提供合約所有者授權的功能。
# Remix 操作
可以先去複製 Owner 的 address。
![](https://i.imgur.com/9xZVV1C.png)
Constructor 需要先給定參數（這邊是地址 `initialOwner`），才能開始初始化、部署合約。
![](https://i.imgur.com/0z51WF4.png) 
部署成功後，調用 owner 可以看到 owner 的地址。
![](https://i.imgur.com/6Ezdx6R.png)
以 owner 位址的使用者身份，呼叫 changeOwner 函數改變 owner，交易成功。
![](https://i.imgur.com/HGkNg8e.png)
點擊藍色 owner 查看地址，msg.sender 仍是 `0x5B38...`，但 owner 地址被改變了。
![](https://i.imgur.com/IX2MZNE.png)
因為 msg.sender（`0x5B38...`） 和 owner（`0x4B20...`）不符合 Modifier 的 condition，所以 `changeOwner` 未成功執行，交易被 revert 了。
![](https://i.imgur.com/jA4ejMe.png)

### 2024.09.30
# 事件
Solidity 的事件（Event）提供了乙太坊虛擬機（EVM）日誌功能之上的抽象，應用程式（如使用 [ether.js](https://learnblockchain.cn/docs/ethers.js/api-contract.html#id18)）可以透過乙太坊客戶端的 RPC（Remote Process Call）介面訂閱和監聽這些事件，然後可以在前端響應事件。當調用事件時，事件會將參數、鍊上發生的事儲存在交易日誌（區塊鍊中的特殊資料結結構）中。
事件可以在定義在檔案層級，也可以定義為合約的**可繼承成員**（包括介面、函式庫），使事件能夠被不同合約使用。
這些日誌會與發出它們的合約的地址相關。只要區塊可訪問，日誌就會保留在區塊鏈上。
EVM 上儲存資料使用事件更有經濟效益，一個是事件大約消耗 2000 gas，鍊上儲存一個新變數需要 20000 gas。
## EVM 日誌
乙太坊虛擬機用日誌（Log）儲存 Solidity 事件，每個日誌記錄都包含主題 `
topics` 和資料 `data` 兩部分。
![](https://www.wtf.academy/assets/images/12-3-06b5d454b3752b96000f8a9477fa31de.png)
### 主題 `topics`
主題是一個描述事件的陣列，長度不超過 4。第一個元素是事件的簽章（Hash），主題最多可以有 3 個 `indexed` 參數，可以當成索引的鍵方便續搜索。每個 `indexed` 參數的大小為固定的 256 bit，如果參數太大了（例如字串），就會自動計算 hash 儲存在 topics 部分。
Transfer 的事件簽章是 `keccak256("Transfer(address,address,uint256)")`，得到 hash 值 `0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef`。
### 資料 `data`
事件中不帶 `indexed` 的參數會儲存在 data 部分，可以理解為事件的「值」。data 部分的變數不能直接檢索，但可以儲存任意大小的數據，通常用來儲存複雜的資料結構，例如陣列和字串等等，因為這些資料超過了256比特，即使儲存在事件的 topics 部分中，也是以雜湊的方式儲存。儲存在 data 部分的變數消耗的 gas 比 topics 更少。
## 事件宣告與釋放
### 宣告
```
event <事件名稱>(<變數類型和名稱>)
```
例如 ERC20 代幣合約中的 `Transfer` 事件：
```
event Transfer(address indexed from, address indexed to, uint256 value);
```
#### 說明
*  `from` 變數：代幣的轉帳地址
*  `to` 變數：代幣的接收地址
*  `value` 變數：轉帳數量
*  `indexed` 關鍵字：保存在以太坊虛擬機器日誌的 `topics` 中，方便之後檢索。
### 釋放
```
emit <事件名稱>(<變數名稱>);
```
可以在函數中釋放事件，例如定義一個 `_transfer` 函數，每次調用 `_transfer` 時都會釋放 `Transfer` 事件，並記錄對應的變數名稱：
```
function _transfer(
    address from,
    address to,
    uint256 amount
) external {
    _balances[from] = 10000000; // 給轉帳地址一些初始代幣
    _balances[from] -= amount； // from 地址減去轉帳數量
    _banances[to] += amount; // to 地址加上轉帳數量
    
    emit Transfer(from, to, amount);
}
```
## 程式碼
`Event.sol`
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Event{
    mapping(address => uint256) public _balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {
        _balances[from] = 10000000; // 給轉帳地址一些初始代幣
        _balances[from] -= amount; // from 地址減去轉帳數量
        _balances[to] += amount; // to 地址加上轉帳數量
        
        emit Transfer(from, to, amount);
    }
}
```
![](https://i.imgur.com/ubkst3p.png)
輸入 `from`, `to`, `amount` 三個參數再調用再點 transact 調用 `_tranfer` 函數。
![](https://i.imgur.com/mTYBiZG.png)
可以從 logs 中看到外層的 from 是產生日誌的合約地址、topic 是事件簽章、args 是事件參數。

### 2024.10.01
# 繼承
繼承可以減少重複的程式碼，可以把合約看作物件，Solidity 也是支持繼承的物件導向程式語言。Solidity 的繼承包括簡單繼承、多重繼承、修飾器繼承和建構子的繼承。
## 關鍵字
`virtual` 和 `overide` 是繼承的關鍵字。
* `virtual`：父合約中的函數，如果希望子合約重寫，則需要加上 `virtual` 關鍵字。
* `overide`：子合約重寫了父合約中的函數，需要加上 `override` 關鍵字。

<!--註：若用 `override` 修飾 `public` 變數，會重寫與變數同名的 `getter` 函數。比如 `mapping(address => uint256) public override balanceOf`;-->

## 簡單繼承
合約之間簡單繼承的語法：`contract <子合約名稱> is <父合約名稱>`，我們可以在子合約中重寫函數，只要加上 `override` 關鍵字即可。
```
contract Grandpa{
    event Log(string msg);
    function f1() public virtual{
        emit Log("Grandpa");
    }
    function f2() public virtual{
        emit Log("Grandpa");
    }
    function grandpa() public virtual{
        emit Log("Grandpa");
    }
}
contract Father is Grandpa{
    function f1() public virtual override{
        emit Log("Father");
    }
    function f2() public virtual override{
        emit Log("Father");
    }

    function father() public virtual{
        emit Log("Father");
    }
}
```
![](https://i.imgur.com/xcHIzOx.png)
分別部署父合約 `Grandpa`、子合約 `Father`。

![](https://i.imgur.com/2IDB7ck.png)
部署 `Father` 子合約後，可以發現 `Father` 子合約中也有 `Grandpa` 父合約的函數，也繼承了未重寫的 `grandpa()` 函數。
![](https://i.imgur.com/zIHBrLI.png)
若父合約 `Grandpa` 調用 `f1()` 函數，可以在 log 中找到日誌對應 `Grandpa.f1()` 的 log 輸出，若子合約 `Father` 調用 `f1()` 函數，因為重寫了 `f1()` 所以日誌輸出和從 `Grandpa` 父合約調用是不同的 log 輸出結果。

## 多重繼承
合約可以繼承多個合約。
### 規則
1. 繼承時要依輩分最高到最低的順序排列。如：`Son` 合約，繼承 `Grandpa` 合約和 `Father` 合約，那麼就要寫成 `contract Son is Grandpa, Father`，而不能寫成 `contract Son is Father, Grandpa`，不然就會報錯。
2. 如果某個函數在多重繼承的合約裡都存在，例如例子中的 `f1` 和 `f2`，在子合約裡必須重寫，不然編譯器無法判斷應該繼承哪個函數會報錯。
3. 重寫在多個父合約中都重名的函數時，`override` 關鍵字後面要加上所有父合約名字，例如 `override(Grandpa, Father)`。

![](https://i.imgur.com/mUEIckX.png)
```
contract Son is Grandpa, Father{
    function f1() public virtual override(Grandpa, Father){
        emit Log("Son");
    }

    function f2() public virtual override(Grandpa, Father) {
        emit Log("Son");
    }
}
```
![](https://i.imgur.com/qpEJ38T.png) ![](https://i.imgur.com/unmOZjB.png)
Son 合約裡面重寫了 `f1()` 和 `f2()` 函數，將輸出改為 "Son"，並分別從 Grandpa  和 Father 合約繼承了 `grandpa()` 和 `father()` 兩個函數。
## 修飾器繼承
修飾器繼承的用法與函數繼承類似，在對應的地方加上 `virtual` 和 `override` 關鍵字即可。
1. 子合約可以直接在程式碼中使用父合約中的修飾器。
```
contract Base{
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}
contract Identifier is Base {
    function getExactDividedBy2And3(uint _dividend) public exactExactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}
```
![](https://i.imgur.com/5owt9HA.png)
部署 `Identifier`合約，`getExactDividedBy2And3(uint _divided)`參數輸入 15，交易會被 revert，因為 `Identifier` 合約繼承了 `Base` 合約的修飾器 `exactDividedBy2And3(_dividend)`，檢查到 15 不能被 2 整除，所以 `getExactDividedBy2And3()` 函數未成功執行。

![](https://i.imgur.com/4rnzu2b.png)
getExactDividedBy2And3WithoutModifier() 函數沒有裝飾器限制參數必須被 2 或 3 整除，所以可以看到回傳的兩個參數分別是 7 和 5。

2. 子合約利用 `override` 關鍵字重寫父合約修飾器。
```
modifier exactDividedBy2And3(uint _a) override {
    _;
    require(_a % 2 == 0 && _a % 3 == 0);
}
```
## 建構子的繼承
```
abstract contract A{
    uint public a;
    constructor(uint _a){
        a = _a;
    }
}
```
1. 在繼承時宣告父建構子的參數，例如：`contract B is A(1)`。
2. 在子合約的建構子中宣告建構子的參數。
```
contract C is A {
    constructor(uint _c) A(_c * _c){}
}
```
![](https://i.imgur.com/hzqqvxO.png)
選擇 `C` 合約部署，給定建構子參數為 10。
![](https://i.imgur.com/G61f7F0.png)
因為繼承了 `A` 合約，所以 `A` 合約的建構子參數被指定為 10 * 10，將 `A` 合約的狀態變數 `a` 修改為 100。

## 呼叫父合約的函數
1. 直接呼叫：子合約可以直接用 `<父合約名>.<函數名>()` 呼叫父合約函數。
```
function callParent() public {
    Grandpa.f2();
}
```
2. 利用 `super` 關鍵字：子合約可以利用 `super.<函數名稱>()` 來呼叫**最近的**父合約函數。Solidity 繼承關係依宣告時從右到左的順序是：`contract Son is Grandpa, Father`，Father 是最近的父合約，`super.f2()` 將呼叫 `Father.f2()` 而不是`Grandpa.f2()`。
```
function callParentSuper() public{
    super.f2();
}
```
![](https://i.imgur.com/Hd0CkS4.png)
新增 `callParent()` 和 `callParentSuper()` 到 `Son` 合約並重新部署 `Son` 合約。
![](https://i.imgur.com/3N3bFcW.png)
可以觀察到子合約函數可以用合約名稱呼叫繼承的父合約的函數。
![](https://i.imgur.com/5Kz9UL3.png)
利用 `super` 呼叫的是最近的父合約函數。

## 鑽石繼承（菱形繼承）
在物件導向程式設計中，鑽石繼承（菱形繼承）指一個衍生類別同時有兩個或兩個以上的基底類別。在多重+菱形繼承鏈上使用 `super` 關鍵字時，需要注意的是使用 `super` 會呼叫繼承鏈上的每一個合約的相關函數，而不是只呼叫最近的父合約。
我們先寫一個合約 `God`，再寫 `Adam` 和 `Eve` 兩個合約繼承 `God` 合約，最後讓創建合約 `people` 繼承自 `Adam` 和`Eve`，每個合約都有 `foo` 和`bar` 兩個函數。
![](https://i.imgur.com/Di06trk.png)
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
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
        super.foo();
    }
    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}
contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
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
在這個範例中，呼叫合約 `people` 中的 `super.bar()` 會依序呼叫 Eve、Adam，最後是 God 合約。雖然 Eve、Adam 都是 God 的子合約，但整個過程中 God 合約只會被呼叫一次。原因是 Solidity 借鑒了 Python 的方式，強制一個由基類構成的 DAG（有向無環圖）使其保證一個特定的順序。
![](https://i.imgur.com/aYgBLGw.png)

### 2024.10.02
# 抽象合約
如果一個智能合約至少有一個未實現的函數，即某個函數缺少主體 {} 中的內容，則必須將該合約標為 `abstract`，不然編譯會報錯。另外，未實現的函數需要加 `virtual`，以便子合約重寫。如果我們還沒想好具體怎麼實現函數，那麼可以把合約標為 `abstract`，之後讓別人補寫上。例如插入排序函數可以先用 `abstract` 標示：
```
abstract contract InsertSort{
    function insertSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```
抽象合約範例：
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
abstract contract Base{
    string public name = "Base";
    function getAlias() public pure virtual returns(string memory);
}

contract BaseImpl is Base {
    function getAlias() public pure override returns(string memory){
        return "BaseTmpl";
    }
}
```
![](https://i.imgur.com/DILmo5F.png)
抽象合約是不能部署的，要選擇非抽象合約部署。
# 介面
介面類似於抽象合約，但它不實現任何功能。
## 介面規則
1. 不能包含狀態變數
2. 不能包含建構子
3. 不能繼承除介面外的其他合約
4. 所有函數都必須是 `external` 且不能有函數本體 `{}`
5. 繼承介面的非抽象合約必須實作介面定義的所有功能
雖然介面不實作任何功能，但它非常重要，是智能合約的骨架，定義了合約的功能以及如何觸發它們。

如果智能合約實現了某種介面（例如ERC20或ERC721），其他 Dapps 和智能合約就知道如何與它互動。因為介面提供了兩個重要的資訊：
1. 合約裡每個函數的 `bytes4` 選擇器，以及函數簽章 `<函數名稱>(每個參數型別)`。
2. 介面 id（[ERC-165](https://eips.ethereum.org/EIPS/eip-165)）。
介面與合約 ABI（Application Binary Interface）等價，可以互相轉換。編譯介面可以得到合約的 ABI，利用 [abi-to-sol 工具](https://gnidan.github.io/abi-to-sol/)，也可以將 `ABI json` 檔轉換為`介面 sol` 檔。

以 ERC721 介面合約 IERC721 為例，它定義了 3 個 event 和 9 個 function，所有 ERC721 標準的 NFT 都實作了這些函數。介面和常規合約的區別在於每個函數都以 `;` 代替函數本體 `{ }` 結尾。
```
interface IERC721 is IERC165{
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function TransferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}
```

### IERC 721 事件
* `Transfer` 事件：在轉帳時被釋放，記錄代幣的發出地址 `from` ，接收地址 `to` 和 `tokenId`。
* `Approval` 事件：在授權時被釋放，記錄授權地址 `owner`，被授權地址 `approved` 和 `tokenId`。
* `ApprovalForAll` 事件：在批量授權時被釋放，記錄批量授權的發出地址 `owner`，被授權地址 `operator` 和是否授權的 `approved`。

### IERC 721 函數
* `balanceOf`：傳回某地址的 NFT 持有量 `balance`。
* `ownerOf`：回傳某 `tokenId` 的主人 `owner`。
* `transferFrom`：普通轉賬，參數為轉出地址 `from`，接收地址 `to` 和 `tokenId`。
* `safeTransferFrom`：安全轉帳（如果接收方是合約位址，會要求實作 `ERC721Receiver` 介面）。
* `approve`：授權另一個位址使用你的 NFT。參數為被授權位址 `approve` 和 `tokenId`。
* `getApproved`：查詢 `tokenId` 被批准給了哪個位址。
* `setApprovedForAll`：將自己持有的該系列 NFT 批次授權給某個地址 `operator`。
* `isApprovedForAll`：查詢某位址的 NFT 是否大量授權給了另一個 `operator` 位址。
* `safeTransferFrom`：安全轉帳的重載函數，參數裡包含了 `data`。

### 介面的使用時機
如果我們知道一個合約實現了 `IERC721` 介面，我們不需要知道它具體程式碼實現，就可以與它互動。

[無聊猿](https://startingedu.com/bayc/) `BAYC` 屬於 `ERC721` 代幣，實現了 `IERC721` 介面的功能。我們不需要知道它的原始碼，只要知道它的合約地址，用 `IERC721` 介面就可以與它互動，例如用 `balanceOf()` 來查詢某個地址的 `BAYC` 餘額，用 `safeTransferFrom()` 來轉帳 `BAYC`。
```
contract interactBAYC{
    // 利用BAYC位址建立介面合約變數（在 ETH 主網）
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
    
    // 透過介面呼叫 BAYC 的 balanceOf() 查詢持倉量
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }
    
    // 透過介面呼叫 BAYC 的 safeTransferFrom() 安全轉賬
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external {
        BAYC.safeTransferFrom(from, to, tokenId);
    }
}
```
介面範例：
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
interface Base{
    function getFirstName() external pure returns(string memory);
    function getLastName() external pure returns(string memory);
}
contract BaseImpl is Base{
    function getFirstName() external pure override returns(string memory){
        return "Amazing";
    }
    function getLastName() external pure override returns(string memory){
        return "Ang";
    }
}
```
![](https://i.imgur.com/UEpvrS1.png)

### 2024.10.04
# 異常
Solidity 有三種拋出異常的方法：`error`、`require` 和 `assert`，三種方法的 gas 消耗不同。寫智能合約常常會出 bug，Solidity 中的異常指令能幫我們 debug。
## Error
`error` 是 solidity 0.8.4 版本新加的內容，方便且高效（省 gas）地向使用者解釋操作失敗的原因，同時還可以在拋出異常的同時攜帶參數，幫助開發者更好地 debug。人們可以在 contract 之外定義異常。
定義一個 `TransferNotOwner` 異常，當使用者不是代幣 `owner` 的時候嘗試轉賬，會拋出錯誤：
```
error TransferNotOwner(); // 自訂 error
```
我們也可以定義一個攜帶參數的異常，來提示嘗試轉帳的帳戶地址：
```
error TransferNotOwner(address sender); // 自訂帶參數的 error
```
在執行當中，`error` 必須搭配 `revert` 指令使用。
```
function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
        // revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```
我們定義了一個 `transferOwner1()` 函數，它會檢查代幣的 `owner` 是不是發起人，如果不是，就會拋出 `TransferNotOwner` 異常；如果是的話，就會轉帳。
## Require
`require` 指令是 solidity 0.8 版本之前拋出異常的常用方法，目前許多主流合約仍然還在使用它。它很好用，唯一的缺點就是 gas 隨著描述異常的字串長度增加，比 `error` 指令要高。使用方法：`require` (檢查條件，"異常的描述")，當檢查條件不成立的時候，就會拋出異常。
用 `require` 指令重寫上面的 `transferOwner1` 函數：
```
function transferOwner2(uint256 tokenId, address newOwner) public {
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    _owners[tokenId] = newOwner;
}
```
## Assert
`assert` 指令一般用於程式設計師寫程式 debug，因為它不能解釋拋出例外的原因（比 `require` 少個字串）。它的用法很簡單，`assert` (檢查條件），當檢查條件不成立的時候，就會拋出異常。
用 `assert` 指令重寫上面的 `transferOwner1` 函數：
```
function transferOwner3(uint256 tokenId, address newOwner) public {
    assert(_owners[tokenId] == msg.sender);
    _owners[tokenId] = newOwner;
}
```
<!-- Content_END -->
