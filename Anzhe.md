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
7. 使用包含某些操作碼（Opcodes）的行內組語（Inline Assemply）。

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

### 2024.10.03
# 異常
Solidity 有三種拋出異常的方法：`error`、`require` 和 `assert`，三種方法的 gas 消耗不同。寫智能合約常常會出 bug，Solidity 中的異常指令能幫我們 debug。
## Error
`error` 是 solidity 0.8.4 版本新加的內容，方便且高效（省 gas）地向使用者解釋操作失敗的原因，同時還可以在拋出異常的同時攜帶參數，幫助開發者更好地 debug。人們可以在 contract 之外定義異常。
定義一個 `TransferNotOwner` 異常，當使用者不是代幣 owner 的時候嘗試轉賬，會拋出錯誤：
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

# 程式碼
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

error TransferNotOwner(); // 自訂帶參數的 error
// error TransferNotOwner(address sender); // 自訂帶參數的 error

contract ErrorContract{
    mapping(uint256 => address) private _owners; // 紀錄每個 tokenId 的 owner

    // 1. Error 方法
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if(_owners[tokenId] != msg.sender){
            revert TransferNotOwner();
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    // 2. require 方法
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;

    }

    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }

}
```
## 說明
![](https://i.imgur.com/36270ih.png)
Error：當地址不符合條件時會 revert 交易，並拋出 TransferNotOwner 的錯誤。耗費 27185 gas。

![](https://i.imgur.com/Sz83BAQ.png)
Require：當地址不符合條件時會 revert 交易，並印出錯誤字串，錯誤字串越長耗費的 gas 比 Error 多越多。耗費 27229 gas。

![](https://i.imgur.com/lHzBali.png)
Assert：當地址不符合條件時只拋出了異常並 revert 交易，並不知道異常原因。耗費 27207 gas。
## 比較
理論上消耗的 gas 應該是：
require 方法 > assert 方法 > error 方法帶參數 > error 方法無參數

### 2024.10.04
# 重載
Solidity 中允許函數進行重載（overloading），即名字相同但輸入參數類型不同的函數可以同時存在，他們被視為不同的函數。但 Solidity 不允許修飾器（modifier）重載。
## 函數重載
舉個例子，我們可以定義兩個都叫saySomething()的函數，一個沒有任何參數，輸出"Nothing"；另一個接收一個string參數，輸出這個string。
```
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```
最終重載函數在經過編譯器編譯後，由於不同的參數類型，都變成了不同的函數選擇器（selector）。關於函數選擇器的具體內容可參考WTF Solidity極簡入門: 29. 函數選擇器Selector。
以 Overloading.sol 合約為例，在 Remix 上編譯部署後，分別調用重載函數 saySomething() 和 saySomething(string memory something)，可以看到他們返回了不同的結果，被區分為不同的函數。
## 參數匹配（Argument Matching）
在呼叫重載函數時，會把輸入的實際參數和函數參數的變數類型做成匹配。 如果出現多個符合的重載函數，則會報錯。下面這個例子有兩個叫f()的函數，一個參數是uint8，另一個為uint256：
```
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```
我們呼叫f(50)，因為50既可以被轉換為uint8，也可以轉換為uint256，因此會報錯。
# 庫合約
庫合約是一種特殊的合約，為了提升Solidity程式碼的複用性和減少gas而存在，庫合約是一系列的函數合集，和普通合約主要有以下幾點不同：
1. 不能存在狀態變數
2. 不能繼承或被繼承
3. 不能接收以太幣
4. 不可以被銷毀
需要注意的是，庫合約重的函數可見性如果被設定為public或external，則在呼叫函數時會觸發一次delegatecall。而如果被設定為internal，則不會引起。對於設定為private可見性的函數來說，其僅能在庫合約中可見，在其他合約中不可用。
## Strings庫合約
Strings庫合約是將uint256類型轉換為對應的string類型的程式碼庫，範例程式碼如下：
```
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) public pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) public pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) public pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
```
他主要包含兩個函數，toString()將uint256轉為string，toHexString()將uint256轉換為16進制，在轉換為string。
## 如何使用庫合約
用Strings庫合約的toHexString()來示範兩種使用庫合約中函數的辦法。
1. 利用using for指令
指令using A for B;可用於附加庫合約（從庫 A）到任何類型（B）。新增指令後，函式庫A中的函數會自動加入為B類型變數的成員，可以直接呼叫。注意：在呼叫的時候，這個變數會被當作第一個參數傳遞給函數。
```
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 庫合約中的函數會自動加入為uint256型變數的成員
    return _number.toHexString();
}
```
2. 透過庫合約名稱呼叫函數
```
// 直接透過庫合約名調用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```
### 2024.10.05
在寫接收 ETH 合約時，會用到有兩個特殊的函數：`receive()` 和 `fallback()`。
寫發送合約則可以用 `transfer()`、`send()` 和`call()` 三種方法。
# 接收 ETH
Solidity 支援兩種特殊的回退函數，`receive()` 和 `fallback()`，他們主要在兩種情況下被使用：
1. 接收ETH
2. 處理合約中不存在的函數呼叫（代理合約 proxy contract）

註：Solidity 0.6.x 版本之前，語法上只有 fallback() 函數，用來接收用戶發送的 ETH 時調用以及在被調用函數簽名沒有匹配到時來調用。 0.6 版本之後，Solidity 才將 fallback() 函式拆分成 receive() 和 fallback() 兩個函式。
## 接收 ETH 函數 `receive`
`receive()` 函數是在合約收到 ETH 轉帳時被呼叫的函數。一個合約最多有一個`receive()` 函數，宣告方式與一般函數不一樣，不需要 function 關鍵字，語法：
```
receive() external payable { ... }
```
`receive()` 函數不能有任何的參數，不能傳回任何值，必須包含 `external` 和`payable`。
當合約接收 ETH 的時候，`receive()` 會被觸發。 `receive()` 最好不要執行太多的邏輯，因為如果別人用 `send` 和 `transfer` 方法發送 ETH 的話，gas 會限制在 2300，`receive()` 太複雜可能會觸發 Out of Gas 報錯；如果用 `call` 就可以自訂 gas 執行更複雜的邏輯（這三種發送ETH的方法之後會提）。
在 `receive()` 裡發送一個 `event`：
```
// 定義事件
event Received(address Sender, uint Value);
// 接收 ETH 時釋放 Received 事件
receive() external payable {
    emit Received(msg.sender, msg.value);
}
```
有些惡意合約，會在 `receive()` 函數（舊版就是 `fallback()` 函數）嵌入惡意消耗 gas 的內容或使得執行故意失敗的程式碼，導致一些包含退款和轉帳邏輯的合約不能正常運作，因此寫包含退款等邏輯的合約時候，一定要注意這種情況。
## 回退函數 `fallback`
`fallback()` 函數會在呼叫合約不存在的函數時被觸發。可用於接收 ETH，也可以用於代理合約 proxy contract。`fallback()` 聲明時不需要 `function` 關鍵字，必須由 `external` 修飾，一般也會用 `payable` 修飾，用來接收 ETH，語法：
```
fallback() external payable { ... }
```
定義一個 `fallback()` 函數，被觸發時候會釋放 `fallbackCalled` 事件，並輸出 `msg.sender`、`msg.value` 和 `msg.data`:
```
event fallbackCalled(address Sender, uint Value, bytes Data);

// fallback
fallback() external payable{
    emit fallbackCalled(msg.sender, msg.value, msg.data);
}
```
## `receive` 和 `fallback` 的差別
receive 和 fallback 都能夠用來接收 ETH，他們觸發的規則如下：
```
觸發fallback() 還是 receive()?
           接收ETH
              |
        msg.data是空？
             /  \
           是    否
          /        \
 receive()存在?    fallback()
       /  \
     是    否
     /      \
receive()  fallback()
```
簡單來說，合約接收 ETH 時，`msg.data` 為空且存在 `receive()` 時，會觸發 `receive()`；`msg.data` 不為空或不存在 `receive()` 時，會觸發 `fallback()`，此時 `fallback()` 必須為 `payable`。 `receive()` 和 `payable fallback()` 皆不存在的時候，向合約直接發送 ETH 將會報錯（你仍可以透過帶有 `payable` 的函數向合約發送 ETH）。
## 接收 ETH 合約
我們先部署一個接收 ETH 合約 `ReceiveETH`。 `ReceiveETH` 合約裡有一個事件 Log，記錄收到的 ETH 數量和 gas 剩餘。還有兩個函數，一個是 `receive()` 函數，收到 ETH 被觸發，並且傳送 Log 事件；另一個是查詢合約 ETH 餘額的 `getBalance()` 函數。
```
contract ReceiveETH {
    // 收到 ETH 事件，記錄 amount 和 gas
    event Log(uint amount, uint gas);
    
    // receive 方法，接收 eth 時被觸發
    receive() external payable{
        emit Log(msg.value, gasleft());
    }
    
    // 返回合約 ETH 餘額
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}
```
# 發送 ETH
Solidity 有三種方法向其他合約發送 ETH：`transfer()`、`send()` 和`call()`，其中 `call()` 是比較好的作法。
首先定義一個 `SendETH` 合約，實現 `payable` 的建構子和 `receive`，讓我們在部署時和部署後可以向 `ReceiveETH` 合約發送ETH。
```
contract SendETH {
    // 建構函數，payable 使得部署的時候可以轉 ETH 進去
    constructor() payable{}
    // receive 方法，接收 ETH 時被觸發
    receive() external payable{}
}
```
## 1. `transfer` 函數
```
    <接收方位址>.transfer(<發送ETH金額>)
```
* `transfer()` 的 gas 限制是 2300，足夠用於轉賬，但對方合約的 `fallback()` 或` receive()` 函數不能實現太複雜的邏輯。
* `transfer()` 如果轉帳失敗，會自動 revert（回滾交易）。
* 範例：`_to` 寫 `ReceiveETH` 合約的地址，`amount` 是 ETH 轉帳金額
    ```
    // 用 transfer() 發送 ETH
    function tranferETH(address payable _to, uint256 amount) external payable{
        _to.transfer(amount);
    }
    ```
    <!--部署 SendETH 合約後，對 ReceiveETH 合約發送 ETH，此時 amount 為 10，value 為 0，amount > value，轉帳失敗，發生 revert。-->
## 2. `send` 函數
```
<接收方位址>.send(<發送ETH金額>)
```
* `send()` 的 gas 限制是 2300，足夠用於轉賬，但對方合約的 `fallback()` 或`receive()` 函數不能實現太複雜的邏輯。
* `send()` 如果轉帳失敗，不會 revert。
* `send()` 的回傳值是 `bool`，代表轉帳成功或失敗，需要額外程式碼處理一下。
* 範例：
    ```
    error SendFailed(); // 用 send 發送 ETH 失敗 error

    // send() 發送 ETH
    function sendETH(address payable _to, uint256 amount) external payable{
        // 處理下 send 的回傳值，如果失敗，revert 交易並傳送 error
        bool success = _to.send(amount);
        if(!success){
            revert SendFailed();
        }
    }
    ```
## 3. `call` 函數
```
<接收方位址>.call{value: <發送ETH金額>}("")
```
* `call()` 沒有 gas 限制，可以支援對方合約 `fallback()` 或 `receive()` 函數實現複雜邏輯。
* `call()` 如果轉帳失敗，不會 revert。
* `call()` 的回傳值是 `(bool, bytes)`，其中 bool 代表著轉帳成功或失敗，需要額外程式碼處理一下。
* 範例：
    ```
    error CallFailed(); // // 使用 call 發送 ETH 失敗 error

    // call() 發送 ETH
    function callETH(address payable _to, uint256 amount) external payable{
        // 處理下 call 的回傳值，如果失敗，revert 交易並發送 error
        (bool success,) = _to.call{value: amount}("");
        if(!success){
            revert CallFailed();
        }
    }
    ```

## 發送 ETH 函數比較
* `call` 沒有 gas 限制，最靈活，是最提倡的方法
* `transfer` 有 2300 gas 限制，但發送失敗會自動 revert 交易，是次優選擇
* `send` 有 2300 gas 限制，而且發送失敗不會自動 revert 交易，幾乎沒有人使用它

### 2024.10.06
在 Solidity 中，一個合約可以呼叫另一個合約的函數，這對建立複雜的 DApps 時非常有用，而在已知合約程式碼（或介面）和位址的情況下，可以呼叫已部署的合約。
# 調用其他合約
## 目標合約
目標合約，用於被其他合約調用：
```
contract OtherContract {
    uint256 private _x = 0; // 狀態變數_x
    // 收到 ETH 的事件，記錄 amount 和 gas
    event Log(uint amount, uint gas);
    
    // 回傳合約ETH餘額
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以調整狀態變數_x的函數，並且可以往合約轉ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果轉入 ETH，則釋放 Log 事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 讀取_x
    function getX() external view returns(uint x){
        x = _x;
    }
}
```
## 呼叫目標合約
可以利用合約的位址和合約程式碼（或介面）來建立合約的參考：`_Name(_Address)`，其中 `_Name` 是合約名，應與合約程式碼（或介面）中標註的合約名稱保持一致，`_Address` 是合約位址。然後用合約的參考來呼叫它的函數：`_Name(_Address).f()`，其中 `f()` 是要呼叫的函數。
範例：
```
contract CallContract{
    // 1. 傳入合約地址
    function callSetX(address _Address, uint256 x) external{
        OtherContract(_Address).setX(x);
    }
    // 2. 傳入合約變數
    function callGetX(OtherContract _Address) external view returns(uint x){
        x = _Address.getX();
    }
    // 3. 建立合約變數
    function callGetX2(address _Address) external view returns(uint x){
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }
    // 4. 呼叫合約並發送 ETH
    function setXTransferETH(address otherContract, uint256 x) payable external{
        OtherContract(otherContract).setX{value: msg.value}(x);
    }
}
```
分別編譯和部署 `OtherContract` 和 `CallContract`。
## 說明
### 1. 傳入合約地址
在函數裡傳入目標合約位址，產生目標合約的引用，然後呼叫目標函數。以呼叫 `OtherContract` 合約的 `setX` 函數為例，我們在新合約中寫一個 `callSetX` 函數，傳入已部署好的 `OtherContract` 合約位址 `_Address` 和 `setX` 的參數 `x`。
### 2. 傳入合約變數
直接在函數裡傳入合約的引用，只需要把上面參數的 `address` 類型改為目標合約名，例如`OtherContract`。上面範例實作了呼叫目標合約的 `getX()` 函數。
注意：此函數參數 `OtherContract _Address` 底層類型仍然是 `address`，產生的 ABI 中、呼叫 `callGetX` 時傳入的參數都是 `address` 類型
### 3. 建立合約變數
建立合約變量，然後通過它來呼叫目標函數。範例給變數 `oc` 儲存了 `OtherContract` 合約的引用。
### 4. 呼叫合約並發送 ETH
如果目標合約的函數是 payable 的，那麼我們可以透過呼叫它來給合約轉帳：`_Name(_Address).f{value: _Value}()`，其中 `_Name` 是合約名，`_Address` 是合約位址，`f`是目標函數名，`_Value`是要轉的 ETH 金額（以 wei 為單位）。

# Call
`call` 可以發送ETH，也可以用來呼叫合約。
`call` 是 `address` 類型的低階成員函數，它用來與其他合約互動。它的回傳值為 `(bool, bytes memory)`，分別對應 call 是否成功以及目標函數的回傳值。
* `call` 是 Solidity 官方推薦的透過觸發 `fallback` 或 `receive` 函數發送 ETH 的方法。
* 不建議用 `call` 來呼叫另一個合約，因為當你呼叫不安全合約的函數時，你就把主動權交給了它。建議的方法仍是宣告合約變數後呼叫函數。
* 當我們不知道對方合約的原始碼或 ABI，就無法產生合約變數；這時，我們仍可以透過 `call` 呼叫對方合約的函數。
```
<目標合約位址>.call(<位元組碼>);
```
其中 Bytecode 利用結構化編碼函數 `abi.encodeWithSignature` 獲得：
```
abi.encodeWithSignature("函數簽章", 逗號分隔的特定參數)
```
函數簽章為 `"函數名稱（逗號分隔的參數類型"`，例如 `abi.encodeWithSignature("f(uint256,address)", _x, _addr)`。
call 在呼叫合約時可以指定交易發送的 ETH 和 gas 的數額：
```
<目標合約位址>.call{value:<發送數額>, gas:<gas數額>}(<位元組碼>);
```
## Call 呼叫合約範例
### 目標合約
```
contract OtherContract {
    uint256 private _x = 0; // 狀態變數_x
    // 收到 ETH 的事件，記錄 amount 和 gas
    event Log(uint amount, uint gas);
    
    // 加入 fallback 函數
    fallback() external payable{}
    ...
}
```
### 用 call 呼叫目標合約
```
contract Call{
    // 1. Response 事件
    // 定義 Response 事件，輸出 call 回傳的結果 success 和 data
    event Response(bool success, bytes data);

    function callSetX(address payable _addr, uint256 x) public payable {
        // 2. 呼叫 setX 函數
        // call setX()，同時可以發送 ETH
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint256)", x)
        );

        emit Response(success, data);
    }

    function callGetX(address _addr) external returns(uint256){
        // 3. 呼叫 getX 函數
        // call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Response(success, data);
        return abi.decode(data, (uint256));
    }

    function callNonExist(address _addr) external{
        // 4. 呼叫不存在的函數
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo(uint256)")
        );

        emit Response(success, data);
    }
}
```
## 說明
### 1. Response 事件
寫一個 `Call` 合約來呼叫目標合約函數。先定義一個 Response 事件，輸出 call 回傳的 `success` 和 `data`，方便我們觀察回傳值。
### 2. 呼叫 setX 函數
定義 `callSetX` 函數來呼叫目標合約的 `setX()`，轉入 `msg.value` 數額的 ETH，並釋放 `Response` 事件輸出 `success` 和 `data`。
### 3. 呼叫 getX 函數
呼叫 `getX()` 函數，它將傳回目標合約 `_x` 的值，類型為 `uint256`。我們可以利用 `abi.decode` 來解碼 call 的回傳值 `data`，並讀出數值。
### 4. 呼叫不存在的函數
如果我們給 `call` 輸入的函數不存在於目標合約，那麼目標合約的 `fallback` 函數會被觸發。我們 call 了不存在的 `foo` 函數。 call 仍能執行成功，並回傳 `success`，但其實呼叫的目標合約 `fallback` 函數。

### 2024.10.07
# Delegatecall
`delegatecall` 與 `call` 類似，是 Solidity 中位址類型的低階成員函數。 delegate 是委託/代表的意思，那麼 delegatecall 委託了什麼？
## Call
當使用者 A 透過合約 B 來 call 合約 C 的時候，執行的是合約 C 的函數，上下文(Context，可以理解為包含變數和狀態的環境)也是合約 C 的：`msg.sender` 是 B 的位址，如果函數改變一些狀態變量，產生的效果會作用在合約 C 的變數上。
![](https://i.imgur.com/j3BMCsC.png)
## delegatecall
當使用者 A 透過合約 B 來 delegatecall 合約 C 的時候，執行的是合約 C 的函數，但是上下文仍是合約 B 的：msg.sender是 A 的位址，並且如果函數改變一些狀態變量，產生的效果會作用於合約 B 的變數上。
![](https://i.imgur.com/pdY13St.png)
可以理解為：一個投資人（使用者 A）把他的資產（B 合約的狀態變數）都交給一個創業投資代理（C 合約）來打理。執行的是創業投資代理的函數，但是改變的是資產的狀態。
### 語法
```
<目標合約位址>.delegatecall(<二進位編碼>);
```
其中二進位編碼利用結構化編碼函數 `abi.encodeWithSignature` 取得：`abi.encodeWithSignature("函數簽章", 逗號分隔的特定參數)`，例如`abi.encodeWithSignature("f(uint256,address)", _x, _addr)`。
與 call 不同，delegatecall 在呼叫合約時可以指定交易發送的 gas，但不能指定發送的 ETH 金額。delegatecall 有安全隱患，使用時要確保當前合約和目標合約的狀態變數儲存結構相同，且目標合約安全，不然會造成資產損失。
### 使用場景
1. 代理合約（Proxy Contract）：將智能合約的儲存合約和邏輯合約分開：代理合約（Proxy Contract）儲存所有相關的變數，並且保存邏輯合約的位址；所有函數存在邏輯合約（Logic Contract）裡，透過 delegatecall 執行。當升級時，只需要將代理合約指向新的邏輯合約即可。
2. EIP-2535 Diamonds（鑽石）：鑽石是一個支持建構可在生產中擴展的模組化智能合約系統的標準。鑽石是具有多個實施合約的代理合約。
### 例子
你（A）透過合約 B 調用目標合約 C。
合約 B 必須和目標合約 C 的變數儲存佈局必須相同，兩個變量，且順序為 `num` 和 `sender`。
```
// 被呼叫的合約 C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

// 發起呼叫的合約B
contract B {
    uint public num;
    address public sender;
    
    // 透過 call 來呼叫 C 的 setVars() 函數，將改變合約 C 裡的狀態變數
    // 兩個參數 _addr 和 _num，分別對應合約 C 的位址和 setVars 的參數
    function callSetVars(address _addr, uint _num) external payable{
        // call setVars()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
    // 透過 delegatecall 來呼叫 C 的 setVars() 函數，將改變合約 B 裡的狀態變數
    function delegatecallSetVars(address _addr, uint _num) external payable{
        // delegatecall setVars()
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}
```

### 2024.10.08
# 在合約中創建新合約
在以太坊鏈上，使用者（外部帳戶，EOA）可以創造智能合約，智能合約也可以創造新的智能合約。去中心化交易所 uniswap 就是利用工廠合約（PairFactory）創建了無數個幣對合約（Pair）。今天會用簡化版的 uniswap 介紹如何透過合約創建合約。
有兩種方法 `CREATE` 和 `CREATE2` 可以在合約中創建合約。
## CREATE
### 用法：
new 一個合約，並傳入新合約建構子所需的參數：
```
Contract x = new Contract{Value: _value}(params)
```
其中 `Contract` 是要建立的合約名，x 是合約物件（地址），如果建構子是 `payable`，可以建立時轉入 `_value` 數量的 ETH，`params` 是新合約建構子的參數。

### 用 `CREATE` 實作極簡版的 `Uniswap`
`Uniswap V2` 核心合約中包括兩個合約：
1. UniswapV2Pair：幣對合約，用於管理幣對地址、流動性、買賣。
2. UniswapV2Factory：工廠合約，用於創建新的幣對，並管理幣對地址。

#### Pair 合約
* `Pair` **幣對合約**負責管理幣對地址，包含 3 個狀態變數：`factory`、`token0`和 `token1`。
* 建構函式 `constructor` 在部署時將 `factory` 賦值為工廠合約地址。
* `initialize` 函數會由工廠合約在部署完成後手動呼叫以初始化代幣地址，將 `token0` 和 `token1` 更新為幣對中兩種代幣的地址。
    ```
    contract Pair{
        address public factory; // 工廠合約地址
        address public token0; // 代幣 1
        address public token1; // 代幣 2
        
        constructor() payable {
            factory = msg.sender;
        }
        
        // 工廠部署時分配一次
        function initialize(address _token0, address _token1) external {
            require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // 充分檢查
            token0 = _token0;
            token1 = _token1;
        }
    }
    ```
> Q：為什麼 uniswap 不在 constructor 中將 token0 和 token1 地址更新？
> A：因為 uniswap 使用的是 `CREATE2` 建立合約，產生的合約位址可以實現預測。

#### PairFactory 合約
* `PairFactory` **工廠合約**用於創建新的幣對，並管理幣對地址。
* 工廠合約（PairFactory）有兩個狀態變數
    * `getPair` 是兩個代幣地址到幣對地址的 map，方便根據代幣找到幣對地址
    * `allPairs` 是幣對地址的陣列，儲存了所有代幣地址。
* `PairFactory` 合約只有一個 `createPair` 函數，根據輸入的兩個代幣地址 `tokenA` 和 `tokenB` 來創建新的 `Pair` 合約。
    ``` 
    contract PairFactory{
       mapping(address => mapping(address => address)) public getPair; // 通過兩個代幣地址查 Pair 地址
       address[] public allPairs; // 保存所有 Pair 地址
       
       function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
           // 創建新合約
           Pair pair = new Pair();
           
           // 呼叫新合約的 initialize 方法
           pair.initialize(tokenA, tokenB);
           
           // 更新地址 map
           pairAddr = address(pair);
           allPairs.push(pairAddr);
           getPair[toeknA][tokenB] = pairAddr;
           getPair[tokenB][tokenA] = pairAddr;
       }
    }
    ```
## CREATE2
CREATE2 操作碼讓我們在智能合約部署在以太坊網路之前，就能預測合約的位址。 Uniswap 創建 Pair 合約用的是 CREATE2 而不是 CREATE。
### CREATE 如何計算地址
智能合約可以由**其他合約**和**普通帳戶**利用 CREATE 操作碼建立。這兩種情況下，新合約的地址都以相同的方式計算：創建者的地址(通常為部署的錢包地址或合約地址)和`nonce` (該地址發送交易的總數，對於合約帳戶是創建的合約總數，每創建一個合約`nonce+1`)的 Hash。
```
新地址 = hash(創建者地址, nonce)
```
創建者地址不會改變，但 `nonce` 可能會隨時間而改變，因此用 CREATE 創建的合約地址不好預測。
### CREATE2 如何計算地址
CREATE2 的目的是為了讓合約地址獨立於未來的事件。不管未來區塊鏈上發生了什麼，你都可以把合約部署在事先計算好的地址上。用 CREATE2 建立的合約地址由 4 個部分決定：
* `0xFF`：一個常數，避免和 CREATE 衝突
* `CreatorAddress`：呼叫 CREATE2 的目前合約（建立合約）地址。
* `salt`（鹽）：一個創建者指定的 `bytes32` 類型的值，它的主要目的是用來影響新創建的合約的地址。
* `initcode`：新合約的初始 Bytecode（合約的 Creation Code 和建構子的參數）。
```
地址 = hash("0xFF",創建者地址, salt, initcode)
```
#### CREATE2 使用
CREATE2 的用法和 CREATE 類似，同樣是 new 一個合約，並傳入新合約建構子所需的參數，只不過要多傳一個 `salt` 參數。
```
Contract x = new Contract{salt: _salt, value: _value}(params)
```
其中 Contract 是要建立的合約名，`x` 是合約物件（地址），`_salt` 是指定的鹽；如果建構子是 `payable`，可以建立時轉入 `_value` 數量的 ETH，`params` 是新合約建構子的參數。

### 用 `CREATE2` 實作極簡版的 `Uniswap`
#### Pair 合約
* `Pair` **幣對合約**負責管理幣對地址，包含 3 個狀態變數：`factory`、`token0`和 `token1`。
* 建構函式 `constructor` 在部署時將 `factory` 賦值為工廠合約地址。
* `initialize` 函數會由工廠合約在部署完成後手動呼叫以初始化代幣地址，將 `token0` 和 `token1` 更新為幣對中兩種代幣的地址。
    ```
    contract Pair{
        address public factory; // 工廠合約地址
        address public token0; // 代幣 1
        address public token1; // 代幣 2
        
        constructor() payable {
            factory = msg.sender;
        }
        
        // 工廠部署時分配一次
        function initialize(address _token0, address _token1) external {
            require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // 充分檢查
            token0 = _token0;
            token1 = _token1;
        }
    }
    ```
#### PairFactory2 合約
* `PairFactory` **工廠合約**用於創建新的幣對，並管理幣對地址。
* 工廠合約（PairFactory）有兩個狀態變數
    * `getPair` 是兩個代幣地址到幣對地址的 map，方便根據代幣找到幣對地址
    * `allPairs` 是幣對地址的陣列，儲存了所有代幣地址。
* `PairFactory` 合約只有一個 `createPair` 函數，根據輸入的兩個代幣地址 `tokenA` 和 `tokenB` 來創建新的 `Pair` 合約。
* `salt` 為 `token1` 和 `token2` 的 hash
    ``` 
    contract PairFactory{
       mapping(address => mapping(address => address)) public getPair; // 通過兩個代幣地址查 Pair 地址
       address[] public allPairs; // 保存所有 Pair 地址
       
       function createPair2(address tokenA, address tokenB) external returns (address pairAddr) {
           require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); // 避免 tokenA 和 tokenB 產生相同的衝突
           
           // 用 tokenA 和 tokenB 地址計算 salt
           // 將 tokenA 和 tokenB 按大小順序排列
           (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
           bytes32 salt = keccak256(abi.encodePacked(token0, token1));
           
           // 用 CREATE2 創建新合約
           Pair pair = new Pair{salt: salt}();
           
           // 呼叫新合約的 initialize 方法
           pair.initialize(tokenA, tokenB);
           
           // 更新地址 map
           pairAddr = address(pair);
           allPairs.push(pairAddr);
           getPair[toeknA][tokenB] = pairAddr;
           getPair[tokenB][tokenA] = pairAddr;
       }
    }
    ```
    
#### 事先計算 Pair 地址
用 `calculateAddr` 函數來事先計算 `tokenA` 和 `tokenB` 將會產生的 Pair 位址。透過它，我們可以驗證我們事先計算的地址和實際地址是否相同。
```
function calculateAddr(address tokenA, address tokenB) public view returns(address predictedAddress) {
    require(tokenA != tokenB, 'IDENTICAL_ADDRESSES');
    (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); // 將 tokenA 和 tokenB 按大小順序排列
    bytes32 salt = keccak256(abi.encodePacked(token0, token1));
    // 計算合約位址方法 hash()
    predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        bytes(0xff),
        addrss(this),
        salt,
        keccack256(type(Pair).creationCode)
    )))))
    
}
```

部署 `PairFactory2` 合約後，可以查看呼叫 `createPair2` 對幣地址是否與事先計算的地址相同。

### 2024.10.09
# 刪除合約
## selfdestruct
`selfdestruct` 指令可以用來刪除智能合約，並將合約剩餘的 ETH 轉到指定的地址。 
`selfdestruct` 是為了回應合約出錯的極端情況而設計的。它最早被命名為 `suicide`（自殺），但這個詞太敏感。為了保護憂鬱的程式設計師（XD），改名為 `selfdestruct`，在v0.8.18 版本中，`selfdestruct` 關鍵字被標記為「不再建議使用」，在某些情況下它會導致預期之外的合約語義，但由於目前還沒有取代方案，目前只是對開發者做了編譯階段的警告，相關內容可以查 看EIP-6049。
### 用法
```
selfdestruct(_addr);
```
其中 `_addr` 是接收合約中剩餘 ETH 的地址。`_addr` 地址不需要有 `receive()` 或`fallback()` 也能接收 ETH。
### 轉移ETH功能範例
```
contract DeleteContract {
    uint public value = 10;
    constructor() payable {}
    receive() external payable {}
    function deleteContract() external {
        // 呼叫 selfdestruct 銷毀合約，並把剩餘的 ETH 轉給 msg.sender
        selfdestruct(payable(msg.sender));
    }
    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}
```
部署好合約後，可向 `DeleteContract` 合約轉入 1 ETH。這時，`getBalance()` 會回傳 1 ETH，`value` 變數是 10。
當我們呼叫 `deleteContract()` 函數，合約將觸發 `selfdestruct` 操作。在坎昆升級前，合約會被自毀。但升級後，合約依然存在，只是將合約包含的 ETH 轉移到指定地址，而合約依然能夠呼叫。
### 同筆交易內實現合約創建-自毀範例
```
contract DeployContract {

    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }

    constructor() payable {}

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }

    function demo() public payable returns (DemoResult memory){
        DeleteContract del = new DeleteContract{value:msg.value}();
        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });
        del.deleteContract();
        return res;
    }
}
```

# ABI 編碼解碼
ABI (Application Binary Interface，應用二進位介面)是與以太坊智能合約互動的標準。資料基於他們的類型編碼；並且由於編碼後不包含類型訊息，解碼時需要註明它們的類型。
Solidity 中，ABI 編碼有 4 個函數：`abi.encode`、`abi.encodePacked`、 `abi.encodeWithSignature`、`abi.encodeWithSelector`。而 ABI 解碼有 1 個函數：`abi.decode`，用於解碼 `abi.encode` 的資料。

# Hash
雜湊函數（hash function）是密碼學概念，它可以將任意長度的訊息轉換成固定長度的值，這個值也稱為雜湊（hash）。
## 性質
* 單向：從輸入的訊息到它的雜湊的正向運算簡單且唯一確定，但反過來運算非常困難，只能靠暴力枚舉，需要花費非常多算力與時間成本。
* 靈敏：Input 的訊息改變一點對哈希的結果改變很大。
* 高效：從輸入的訊息到哈希的運算效率高。
* 均一：每個雜湊值被取到的機率應該基本上相等。
* 抗碰撞性：
    * 弱抗碰撞性：給定一個訊息 `x`，找出另一個訊息 `x'`，使得 `hash(x) = hash(x')` 是困難的。
        * 
    * 強抗碰撞性：找出任意 `x` 和`x'`，使得 `hash(x) = hash(x')` 是困難的。
## Keccak256
Keccak256 函數是 Solidity 中最常用的雜湊函數，用法：
```
<哈希值> = keccak256(<資料>);
```
## SHA3
sha3 由 keccak 標準化而來，在許多場景下 Keccak 和 SHA3 是同義詞，但在 2015 年 8 月 SHA3 最終完成標準化時，NIST 調整了填充演算法。所以 SHA3 就和 keccak 計算的結果不一樣，所以在實際開發上要注意。
以太坊在開發的時候 sha3 還在標準化中，所以採用了 keccak，所以 Ethereum 和 Solidity 智能合約程式碼中的 SHA3 是指 Keccak256，而不是標準的 NIST-SHA3，為了避免混淆，直接在合約程式碼中寫成 Keccak256 是最清楚的。
## 應用
* 加密簽名
* 安全加密
* 產生資料唯一標識
    利用 keccak256 來產生一些資料的唯一識別。例如我們有幾個不同類型的資料：`uint`、`string`、`address`，我們可以先用 abi.encodePacked 方法將他們打包編碼，然後再用 keccak256 來產生唯一識別：
    ```
    function hash(
        uint _num,
        string memory _string,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_num, _string, _addr));
    }
    ```
# 函數選擇器
當我們呼叫智能合約時，本質上是向目標合約發送了一段 calldata，在 remix 中發送一次交易後，可以在詳細資訊中看見 input 即為此次交易的 calldata。發送的calldata中前4個位元組是selector（函數選擇器）。
## msg.data
msg.data 是 Solidity 中的全域變數，值為完整的 calldata（呼叫函數時傳入的資料）。
我們可以透過 Log 事件來輸出呼叫 mint 函數的 calldata：
```
// event 回傳 msg.data
event Log(bytes data);

function mint(address to) external{
    emit Log(msg.data);
}
```
當參數為 `0x2c44b726ADF1963cA47Af88B284C06f30380fC78` 時，輸出的 calldata 為： 0x6a6278420000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
這段位元組碼可以分成
1. 前 4 個位元組為函數選擇器 selector：0x6a627842
2. 後面 32 個位元組為輸入的參數：0x0000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
calldata 就是告訴智能合約，我要呼叫哪個函數，以及參數是什麼。
### method id、selector
method id 定義為函數簽署的 Keccak 雜湊後的前 4 個位元組，當 selector（calldata 的前 4 個位元組）與 method id 相符時，即表示呼叫函數。
由於計算 method id 時，需要透過函數名稱和函數的參數類型來計算。Solidity 中函數的參數類型主要分為：基礎類型參數，固定長度類型參數，可變長度類型參數和映射類型參數。
### 函數簽章
`mint` 的函式簽章為 `"mint(address)"`。在同一個智能合約中，不同的函數有不同的函數簽章，因此我們可以透過函數簽章來確定要呼叫哪個函數。
註：在函數簽章中，`uint` 和 `int` 要寫為 `uint256` 和 `int256`。

## Selector 的使用
可以利用 selector 來呼叫目標函數。例如我想呼叫 `elementaryParamSelector` 函數，我只需要利用 abi.encodeWithSelector 將 `elementaryParamSelector` 函數的method id 作為 selector 和參數打包編碼，傳給 call 函數：
```
// 使用selector來呼叫函數
function callWithSignature() external{
...
    // 呼叫 elementaryParamSelector 函數
    (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
...
}
```
# Try Catch
Solidity 中，try-catch 只能用於 `external` 函數或創建合約時 `constructor`（被視為 `external` 函數）的呼叫。基本語法如下：
```
try externalContract.f() {
    // call 成功的情況下 運行一些程式碼
} catch {
    // call 失敗的情況下 運行一些程式碼
}
```
catch模組支援捕捉特殊的異常原因：
```
try externalContract.f() returns(returnType){
    // call 成功的情況下 運行一些程式碼
} catch Error(string memory /*reason*/) {
    // 捕獲revert("reasonString") 和 require(false, "reasonString")
} catch Panic(uint /*errorCode*/) {
    // 捕獲Panic導致的錯誤 例如assert失敗 溢位 除零 陣列存取越界
} catch (bytes memory /*lowLevelData*/) {
    // 如果發生了revert且上面2個異常類型匹配都失敗了 會進入該分支
    // 例如revert() require(false) revert自訂類型的error
}
```

### 2024.10.10
# ERC20
`ERC20` 是以太坊上的代幣標準，來自 2015 年 11 月的 [EIP20](https://eips.ethereum.org/EIPS/eip-20)。它實現了代幣轉帳的基本邏輯：
* 帳戶餘額 `balanceOf()`
* 轉帳 `transfer()`
* 授權轉帳 `transferFrom()`
* 授權 `approve()`
* 代幣總供給 `totalSupply()`
* 授權轉帳額度 `allowance()`
* 代幣資訊（可選）：名稱 `name()`、代號 `symbol()`、小數位數 `decimals()`
## IERC20
IERC20 是 ERC20 代幣標準的介面合約，規定了 ERC20 代幣需要實現的函數和事件。有了介面的規範後，就存在所有的 ERC20 代幣都通用的函數名稱、輸入參數與輸出參數。在介面函數中，只需要定義函數名稱，輸入參數，輸出參數，並不關心函數內部如何實現。所以函數就分為內部和外部的內容，一個重點是實現，另一個是對外接口，約定共同資料。這就是為什麼需要 `ERC20.sol` 和 `IERC20.sol` 兩個檔案實現一個合約。
### 事件
IERC20 定義了2個事件：Transfer 事件和 Approval 事件，分別在轉帳和授權時被釋放：
```
/**
 * @dev 釋放條件：當 value 單位的貨幣從帳戶 (from) 轉移到另一個帳戶 (to) 時
 */
event Transfer(address indexed from, address indexed to, uint256 value);

/**
 * @dev 釋放條件：當 value 單位的貨幣從帳戶 (owner) 授權給另一個帳戶 (spender)時
 */
event Approval(address indexed owner, address indexed spender, uint256 value);
```
### 函數
IERC20 定義了 6 個函數，提供了轉移代幣的基本功能，並允許代幣獲得批准，以便其他鏈上第三方使用。
* `totalSupply()` 回傳代幣總供給。
   ```
   function totalSupply() external view returns (uint256);
   ```
* `balanceOf()` 回傳帳戶餘額。
   ```
   function balanceOf(address account) external view returns (uint256);
   ```
* `transfer()` 轉賬：從呼叫者帳戶轉帳 `amount` 單位代幣，如果成功，回傳 `true`，然後釋放 `{Transfer}` 事件。
   ```
   function transfer(address to, uint256 amount) external returns (bool);
   ```
* `allowance()` 回傳授權額度：回傳 `owner` 帳戶授權給 `spender` 帳戶的額度，預設為 0，當 `approve()` 或 `transferFrom()` 被呼叫時，`allowance`會改變。
   ```
   function allowance(address owner, address spender) external view returns (uint256);
   ```
* `approve()` 授權：呼叫者帳戶給`spender`帳戶授權 `amount`數量代幣，如果成功，回傳 `true`，然後釋放 `{Approval}` 事件。
   ```
   function approve(address spender, uint256 amount) external returns (bool);
   ```
* `transferFrom()` 授權轉帳：透過授權機制，從 `from` 帳戶轉帳 `amount` 數量代幣到 `to` 帳戶。轉帳的部分會從呼叫者的 `allowance` 中扣除。如果成功，回傳 `true`，然後釋放 `{Transfer}` 事件。
   ```
   function transferFrom(
       address from,
       address to,
       uint256 amount
   ) external returns (bool);
   ```
## 實現 ERC20
寫一個ERC20，將 IERC20 規定的函數簡單實作。
### 狀態變數
我們需要狀態變數來記錄帳戶餘額，授權額度和代幣資訊。其中 `balanceOf`、 `allowance` 和 `totalSupply` 為 `public` 類型，會自動產生一個同名的 getter 函數，實作 IERC20 規定的 `balanceOf()`、`allowance()` 和 `totalSupply()`。而 `name`、`symbol`、`decimals` 則對應代幣的名稱、代號和小數位數。
註：用 `override` 修飾 `public` 變數，會重寫繼承自父合約的與變數同名的 getter 函數，例如 IERC20 中的 `balanceOf()` 函數。
```
mapping(address => uint256) public override balanceOf;

mapping(address => mapping(address => uint256)) public override allowance;

uint256 public override totalSupply;   // 代幣總供給

string public name;   // 名稱
string public symbol;  // 代號

uint8 public decimals = 18; // 小數位數
```
### 函數
* 建構子：初始化代幣名稱、代號。
    ```
    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
    }
    ```
* `transfer()` 函數：實作 IERC20 中的 `transfer` 函數：代幣轉帳邏輯。呼叫者扣除`amount` 數量代幣，接收方增加對應代幣。<!--土狗幣會魔改這個函數，加入稅收、分紅、抽獎等邏輯。-->
    ```
    function transfer(address recipient, uint amount) public override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    ```
* `approve()` 函數：實作 IERC20 中的 `approve` 函數：代幣授權邏輯。被授權方 `spender` 可以支配授權方 `amount` 數量的代幣。`spender` 可以是 EOA(Externally Owned Account) 帳戶，也可以是合約帳戶：當你用 uniswap 交易代幣時，你需要將代幣授權給 uniswap 合約。
    ```
    function approve(address spender, uint amount) public override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    ```
* `transferFrom()` 函數：實作 IERC20 中的 `transferFrom` 函數：授權轉帳邏輯。被授權方將授權方 `sender` 的 `amount` 數量代幣轉帳給接收方 `recipient`。
    ```
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) public override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    ```
* `mint()` 函數：鑄造代幣函數，不在 IERC20 標準中。任何人可以鑄造任意數量的代幣，實際應用中會加權限管理，只有 `owner` 可以鑄造代幣：
    ```
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
    ```
* `burn()` 函數：銷毀代幣函數，不在 IERC20 標準中。
    ```
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    ```

### 發行ERC20代幣
有了 ERC20 標準後，在 ETH 鏈上發行代幣變得非常簡單，我們可以發行屬於自己的測試幣：
1. 在 Remix 上編譯好 ERC20 合約 → 在部署列輸入建構子的參數，`name_`
 和 `symbol_` 都設為 "WTF"，然後點選 transact 鍵進行部署。這樣，我們就創建好了 WTF 代幣。
 
2. 運行 `mint()` 函數來為自己鑄造一些代幣：
點開 Deployed Contract 中的 ERC20 合約，在 mint 函數那一欄輸入 100 並點選 mint 按鈕，為自己鑄造 100 個 WTF 代幣。

3. 點開右側的 Debug 按鈕，查看下面具體的 logs，應包含
* 事件：Transfer
* 鑄幣地址：0x0000000000000000000000000000000000000000
* 接收地址：0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
* 代幣金額：100

4. 利用 balanceOf() 函數來查詢帳戶餘額。輸入我們目前的帳戶，可以看到餘額變成100，鑄造成功。
# 代幣水龍頭
當人想要免費代幣的時候，就要去代幣水龍頭（Faucut）領，代幣水龍頭就是讓用戶免費領代幣的網站或應用程式。
最早的代幣水龍頭是比特幣（BTC）水龍頭：現在 BTC 一枚要 $30,000，但是在 2010 年，BTC 的價格不到 $0.1，而且持有人很少。為了擴大影響力，比特幣社群的 Gavin Andresen 開發了 BTC 水龍頭，讓別人可以免費領 BTC。
## ERC20 水龍頭合約實作
將一些 ERC20 代幣轉到水龍頭合約裡，使用者可以透過合約的 `requestToken()` 函數來領取 100 單位的代幣，每個地址只能領一次。
### 狀態變數
* `amountAllowed` 設定每次能領取代幣數量（預設為 100，不是一百枚，因為代幣有小數位數）。
* `tokenContract` 記錄發放的 ERC20 代幣合約地址。
* `requestedAddress` 記錄曾經領過代幣的地址。
```
uint256 public amountAllowed = 100; // 每次能領取代幣數量
address public tokenContract;   // 記錄發放的 ERC20 代幣合約地址
mapping(address => bool) public requestedAddress;   // 記錄曾經領過代幣的地址
```
### 事件
水龍頭合約中定義了 1 個 SendToken 事件，記錄了每次領取代幣的地址和數量，在`requestTokens()` 函數被呼叫時釋放。
```
event SendToken(address indexed Receiver, uint256 indexed Amount); 
```
### 函數
* 建構子：初始化 `tokenContract` 狀態變量，確定發放的 ERC20 代幣地址。
    ```
    // 部署時設定 ERC20 代幣合約
    constructor(address _tokenContract) {
        tokenContract = _tokenContract; // set token contract
    }
    ```
* `requestTokens()` 函數，使用者呼叫它可以領取 ERC20 代幣。
```
function requestTokens() external {
    require(!requestedAddress[msg.sender], "Can't Request Multiple Times!"); // 每個地址只能領一次
    IERC20 token = IERC20(tokenContract); // 創建 IERC20 合約物件
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // 水龍頭空了

    token.transfer(msg.sender, amountAllowed); // 發送代幣
    requestedAddress[msg.sender] = true; // 記錄領取地址
    
    emit SendToken(msg.sender, amountAllowed); // 釋放 SendToken 事件
}
```

# 空投 Airdrop
空投是幣圈中一種行銷策略，專案方將代幣免費發放給特定用戶群。為了拿到空投資格，使用者通常需要完成一些簡單的任務，例如測試產品、分享新聞、介紹朋友等。專案方透過空投可以獲得種子用戶，而用戶可以獲得一筆財富，兩全其美。 因為每次接收空投的用戶很多，所以項目方不可能一筆一筆的轉帳。利用智慧合約批量發放ERC20代幣，可顯著提高空投效率。
## 空投代幣合約
Airdrop空投合約邏輯非常簡單：利用循環，一筆交易將ERC20代幣發送給多個地址。合約中包含兩個函數
1. getSum()函數：傳回uint陣列的和。
    ```
    function getSum(uint256[] calldata _arr) public pure returns(uint sum){
        for(uint i = 0; i < _arr.length; i++)
            sum = sum + _arr[i];
    }
    ```
* multiTransferToken()函數：傳送ERC20代幣空投，包含3個參數：
    * _token：代幣合約地址（address類型
    * _addresses：接收空投的使用者位址陣列（address[]類型）
    * _amounts：空投數量數組，對應_addresses裡每個地址的數量（uint[]類型）
    * 函數有兩個檢查：第一個require檢查了_addresses和_amounts兩個數組長度是否相等；第二個require檢查了空投合約的授權額度大於要空投的代幣數量總和。
    ```
    /// @notice 向多個地址轉帳ERC20代幣，使用前需先授權
    ///
    /// @param _token 轉帳的ERC20代幣地址
    /// @param _addresses 空投位址數組
    /// @param _amounts 代幣數量數組（每個地址的空投數量）
    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
        ) external {
        // 檢查：_addresses和_amounts數組的長度相等
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        IERC20 token = IERC20(_token); // 聲明IERC合約變量
        uint _amountSum = getSum(_amounts); // 計算空投代幣總量
        // 檢查：授權代幣數量 >= 空投代幣總量
        require(token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");

        // for循環，利用transferFrom函數發送空投
        for (uint8 i; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }
    ```
2. multiTransferETH()函數：傳送ETH空投，包含2個參數：
    * _addresses：接收空投的使用者位址陣列（address[]類型）
    * _amounts：空投數量數組，對應_addresses裡每個地址的數量（uint[]類型）
    ```
    /// 向多個地址轉帳ETH
    function multiTransferETH(
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) public payable {
        // 檢查：_addresses和_amounts數組的長度相等
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        uint _amountSum = getSum(_amounts); // 計算空投ETH總量
        // 檢查轉入ETH等於空投總量
        require(msg.value == _amountSum, "Transfer amount error");
        // for循環，利用transfer函數發送ETH
        for (uint256 i = 0; i < _addresses.length; i++) {
            // 註解程式碼有Dos攻擊風險, 且transfer 也是不推薦寫法
            // Dos攻擊具體參考 https://github.com/AmazingAng/WTF-Solidity/blob/main/S09_DoS/readme.md
            // _addresses[i].transfer(_amounts[i]);
            (bool success, ) = _addresses[i].call{value: _amounts[i]}("");
            if (!success) {
                failTransferList[_addresses[i]] = _amounts[i];
            }
        }
    }
    ```
### 2024.10.11
BTC 和 ETH 這類代幣都屬於同質化代幣，礦工挖出的第 1 個 BTC 與第 10000 個 BTC 是等價的，但世界上許多物品是不同質的，其中包括房產、古董、虛擬藝術品等等，這類物品無法用同質化代幣抽象化。因此，以太坊 EIP721 提出了 ERC721 標準，來抽象化非同質化的物品。今天要來理解 ERC721 標準，並利用它發行一款 NFT。
# EIP 與 ERC
## EIP
EIP 全名為 Ethereum Improvement Proposals(以太坊改進建議), 是以太坊開發者社區提出的改進建議，是一系列以編號排定的文件，類似網路上 IETF 的 RFC。
而 EIP 可以是乙太坊生態中任意領域的改進，例如新特性、ERC、協定改進、程式設計工具等等。
## ERC
ERC 全名為 Ethereum Request For Comment (以太坊意見徵求稿)，用來記錄以太坊上應用級的各種開發標準和協議。如典型的 Token 標準(ERC20, ERC721)、名字註冊(ERC26, ERC13)、URI範式(ERC67)、Library/Package 格式(EIP82)、包格式(EIP75,EIP85)。ERC 協議標準也是影響以太坊發展的重要因素，像 ERC20、ERC223、 ERC721、ERC777 等，都是對以太坊生態產生了很大影響。**而 EIP 包含了 ERC**。
### ERC165
透過 [ERC165](https://eips.ethereum.org/EIPS/eip-165) 標準，智能合約可以宣告它支援的介面，供其他合約檢查。簡單的說，ERC165 就是檢查一個智能合約是不是支援了 ERC721、ERC1155 的介面。
IERC165 介面合約只聲明了一個 `supportsInterface` 函數，輸入要查詢的`interfaceId` 介面id，若合約實作了該介面 id，則傳回 `true`：
```
interface IERC165 {
    /**
     * @dev 如果合約實作了查詢的 `interfaceId`，則傳回 true
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
```
然後 ERC721 實作 `supportsInterface()` 函數：
```
function supportsInterface(bytes4 interfaceId) external pure override returns (bool)
{
    return
        interfaceId == type(IERC721).interfaceId ||
        interfaceId == type(IERC165).interfaceId;
}
```
當查詢的是 IERC721 或 IERC165 的介面 id 時，回傳 true，反之回傳 false。
### IERC721
IERC721 是 ERC721標準的介面合約，規定了 ERC721 要實現的基本函數。它利用 `tokenId` 來表示特定的非同質化代幣，授權或轉帳都要明確 `tokenId`；而 ERC20 只需要明確轉帳的金額即可。
```
/**
 * @dev ERC721 標準介面
 */
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function setApprovalForAll(address operator, bool _approved) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function isApprovedForAll(address owner, address operator) external view returns (bool);
}
```
#### IERC721事件
IERC721 包含 3 個事件，其中 Transfer 和 Approval 事件在 ERC20 中也有。
* Transfer 事件：在轉帳時被釋放，記錄代幣的發出地址 from，接收地址 to 和tokenid。
* Approval 事件：在授權時釋放，記錄授權位址 owner，被授權位址 approved 和tokenid。
* ApprovalForAll 事件：在批次授權時釋放，記錄批量授權的發出位址 owner，被授權位址 operator 和授權與否的 approved。
#### IERC721 函數
* balanceOf：傳回某位址的NFT持有量balance。
* ownerOf：回傳某tokenId的主人owner。
* transferFrom：普通轉賬，參數為轉出地址from，接收地址to和tokenId。
* safeTransferFrom：安全轉帳（如果接收方是合約位址，會要求實作ERC721Receiver介面）。參數為轉出位址from，接收位址to和tokenId。
* approve：授權另一個位址使用你的NFT。參數為被授權位址approve和tokenId。
* getApproved：查詢tokenId被批准給了哪個位址。
* setApprovalForAll：將自己持有的該系列NFT批次授權給某個地址operator。 
* isApprovedForAll：查詢某個位址的NFT是否批次授權給了另一個operator位址。 
* safeTransferFrom：安全轉帳的重載函數，參數裡麵包含了data。
#### IERC721Receiver
如果一個合約沒有實現 ERC721 的相關函數，轉入的 NFT 就進了黑洞，永遠轉不出來了。為了防止誤轉賬，ERC721 實作了 safeTransferFrom() 安全轉帳函數，目標合約必須實作了 IERC721Receiver 介面才能接收 ERC721 代幣，不然會 revert。 IERC721Receiver 介面只包含一個 onERC721Received() 函數。
```
// ERC721接收者介面：合約必須實作這個介面來透過安全轉帳接收ERC721
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
```
# 荷蘭拍賣
荷蘭拍賣（Dutch Auction）是一種特殊的拍賣形式，亦稱為「減價拍賣」，它是指拍賣標的的競價由高到低依次遞減直到第一個競買人應價（達到或超過底價）時擊槌成交的一種拍賣。
在幣圈，許多NFT透過荷蘭拍賣發售，其中包括 Azuki 和 World of Women，其中 Azuki 透過荷蘭拍賣籌集了超過 8000 枚 ETH。
專案方非常喜歡這種拍賣形式，主要有兩個原因：
1. 荷蘭拍賣的價格由最高慢慢下降，能讓專案方獲得最大的收入。
2. 拍賣持續較長（通常6小時以上），可以避免 gas war。
## DutchAuction合約
程式碼基於 Azuki 的程式碼簡化而成。DucthAuction 合約繼承了先前介紹的 ERC721 和 Ownable 合約：
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";

contract DutchAuction is Ownable, ERC721 {
    uint256 public constant COLLECTOIN_SIZE = 10000; // NFT 總數
    uint256 public constant AUCTION_START_PRICE = 1 ether; // 起拍價（最高價）
    uint256 public constant AUCTION_END_PRICE = 0.1 ether; // 結束價(最低價/地板價)
    uint256 public constant AUCTION_TIME = 10 minutes; // 拍賣時間，為了測試方便設為10分鐘
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes; // 每過多久時間，價格衰減一次
    uint256 public constant AUCTION_DROP_PER_STEP =
        (AUCTION_START_PRICE - AUCTION_END_PRICE) /
        (AUCTION_TIME / AUCTION_DROP_INTERVAL); // 每次價格衰減步長
    
    uint256 public auctionStartTime; // 拍賣開始時間戳
    string private _baseTokenURI;   // metadata URI
    uint256[] private _allTokens; // 記錄所有存在的 tokenId
```
### DutchAuction 狀態變數
合約中總共有 9 個狀態變數，其中有 6 個和拍賣相關：
* COLLECTOIN_SIZE：NFT 總量。
* AUCTION_START_PRICE：荷蘭拍賣起拍價，也是最高價。
* AUCTION_END_PRICE：荷蘭拍賣結束價，也是最低價/地板價。
* AUCTION_TIME：拍賣持續時長。
* AUCTION_DROP_INTERVAL：每過多久時間，價格衰減一次。
* auctionStartTime：拍賣起始時間（區塊鏈時間戳，`block.timestamp`）。
### DutchAuction 函數
荷蘭拍賣合約中共有 9 個函數，與 ERC721 相關的函數我們這裡不再重複介紹，只介紹和拍賣相關的函數。
* 設定拍賣起始時間：我們在建構子中會宣告當前區塊時間為起始時間，專案方也可以透過 `setAuctionStartTime()` 函數來調整：
    ```
    constructor() ERC721("WTF Dutch Auctoin", "WTF Dutch Auctoin") {
        auctionStartTime = block.timestamp;
    }

    // auctionStartTime setter 函數，onlyOwner
    function setAuctionStartTime(uint32 timestamp) external onlyOwner {
        auctionStartTime = timestamp;
    }
    ```
* 取得拍賣即時價格：`getAuctionPrice()` 函數透過當前區塊時間以及拍賣相關的狀態變數來計算即時拍賣價格。
    * 當 `block.timestamp` 小於起始時間，價格為最高價 AUCTION_START_PRICE
    * 當 `block.timestamp` 大於結束時間，價格為最低價 AUCTION_END_PRICE
    * 當 `block.timestamp` 處於兩者之間時，則計算出目前的衰減價格
    ```
        // 取得拍賣即時價格
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
    ```
* 使用者拍賣並鑄造 NFT：使用者透過呼叫 `auctionMint()` 函數，支付 ETH 參加荷蘭拍賣並鑄造 NFT。
    * 此函數首先檢查拍賣是否開始/鑄造是否超出 NFT 總量。接著，合約透過 `getAuctionPrice()` 和鑄造數量計算拍賣成本，並檢查使用者支付的 ETH 是否足夠：如果足夠，則將 NFT 鑄造給使用者，並退回超額的 ETH；反之，則回退交易。
    ```
        // 拍賣 mint 函數
    function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立 local 變數，減少 gas 花費
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // 檢查是否設定起拍時間，拍賣是否開始
        require(
        totalSupply() + quantity <= COLLECTOIN_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // 檢查是否超過 NFT 上限

        uint256 totalCost = getAuctionPrice() * quantity; // 計算 mint 成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 檢查使用者是否支付足夠 ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多餘 ETH 退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); // 注意這裡是否有重入的風險
        }
    }
    ```
* 專案方取出籌集的 ETH：專案方可以透過 `withdrawMoney()` 函數提走拍賣會籌集的 ETH
    ```
        // 提款函數，onlyOwner
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}(""); // call 函數呼叫
        require(success, "Transfer failed.");
    }
    ```
### 2024.10.12
# Merkle Tree
Merkle Tree，也稱為梅克爾樹或哈希樹，是區塊鏈的底層加密技術，被比特幣和以太坊區塊鏈廣泛採用。Merkle Tree 是一種由下而上建構的加密樹，每個葉子是對應資料的 Hash，而每個非葉子為它的 2 個子節點的 Hash。
![](https://i.imgur.com/WrVL5XB.png)
Merkle Tree 允許對大型資料結構的內容進行有效且安全的驗證（Merkle Proof），對於有 N 個葉子結點的 Merkle Tree，在已知 root 根值的情況下，驗證某個資料是否有效（屬於 Merkle Tree 葉子結點）只需要 ceil (log₂N) 個資料（也叫 proof），非常有效率，如果資料有誤，或給的 proof 錯誤，則無法還原出 root 根植。

在下面的例子中，葉子 L1 的 Merkle proof 為Hash 0-1 和 Hash 1：知道這兩個值，就能驗證 L1 的值是不是在 Merkle Tree 的葉子中。為什麼呢？因為透過葉子 L1 我們就可以算出 Hash 0-0，我們又知道了 Hash 0-1，那麼 Hash 0-0 和 Hash 0-1 就可以聯合算出 Hash 0，然後我們又知道 Hash 1，Hash 0 和 Hash 1 就可以聯合算出 Top Hash，也就是 root 節點的 hash。
![](https://i.imgur.com/8IuVaHx.png)

## 生成 Merkle Tree
我們可以利用[網頁](https://lab.miguelmota.com/merkletreejs/example/)或 Javascript 函式庫 [merkletreejs](https://github.com/merkletreejs/merkletreejs) 來產生 Merkle Tree。
這裡我們用網頁來產生4個位址當葉子結點的Merkle Tree。葉子結點輸入：
```
    [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", 
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"
    ]
```
在選單裡選 Keccak-256、hashLeaves 和 sortPairs 選項，然後點選 Compute，Merkle Tree 就生成好了。 
![](https://i.imgur.com/M6RFZzV.png)
Merkle Tree 展開為：
![](https://i.imgur.com/pnVVe3e.png)

## Merkle Proof 驗證
透過網站，我們可以得到地址 0 的 proof 如下：


利用 MerkleProof 函式庫來驗證：
```
library MerkleProof {
    /**
     * @dev 當透過`proof`和`leaf`重建的`root`與給定的`root`相等時，傳回`true`，資料有效。
     * 重建時，葉子節點對和元素對都是排序過的。
     */
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool) {
        return processProof(proof, leaf) == root;
    }

    /**
     * @dev Returns 透過Merkle樹用`leaf`和`proof`計算出`root`. 當重建出的`root`和給定的`root`相同時，`proof`才是有效的。
     * 在重建時，葉子節點對和元素對都是排序過的。
     */
    function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = _hashPair(computedHash, proof[i]);
        }
        return computedHash;
    }

    // Sorted Pair Hash
    function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }
}
```
MerkleProof 函式庫有三個函數：
* verify()函數：利用proof數來驗證leaf是否屬於根為root的Merkle Tree中，如果是，則傳回true。它呼叫了processProof()函數。
* processProof()函數：利用proof和leaf依序計算出Merkle Tree的root。它呼叫了_hashPair()函數。
* _hashPair()函數：用keccak256()函數計算兩個非根節點對應的子節點的雜湊（排序後）。
## 利用 Merkle Tree 發放 NFT 白名單
一份擁有 800 個地址的白名單，更新一次所需的 gas fee 很容易超過 1 個 ETH。而由於 Merkle Tree 驗證時，leaf 和 proof 可以存在後端，鏈上只需儲存一個 root 的值，非常節省g as，專案方常用它來發放白名單。許多 ERC721 標準的 NFT 和 ERC20 標準代幣的白名單/空投都是利用 Merkle Tree 發出的，例如 optimism 的空投。
```
contract MerkleTree is ERC721 {
    bytes32 immutable public root; // Merkle樹的根
    mapping(address => bool) public mintedAddress;   // 記錄已經mint的位址

    // 建構子，初始化NFT合集的名稱、代號、Merkle樹的根
    constructor(string memory name, string memory symbol, bytes32 merkleroot)
    ERC721(name, symbol)
    {
        root = merkleroot;
    }

    // 利用Merkle樹驗證地址並完成mint
    function mint(address account, uint256 tokenId, bytes32[] calldata proof)
    external
    {
        require(_verify(_leaf(account), proof), "Invalid merkle proof"); // Merkle檢驗通過
        require(!mintedAddress[account], "Already minted!"); // 地址沒有mint過
        _mint(account, tokenId); // mint
        mintedAddress[account] = true; // 記錄mint過的地址
    }

    // 計算Merkle樹葉子的 hash
    function _leaf(address account)
    internal pure returns (bytes32)
    {
        return keccak256(abi.encodePacked(account));
    }

    // Merkle樹驗證，呼叫MerkleProof函式庫的verify()函數
    function _verify(bytes32 leaf, bytes32[] memory proof)
    internal view returns (bool)
    {
        return MerkleProof.verify(proof, root, leaf);
    }
}
```
MerkleTree 合約繼承了 ERC721 標準，並利用了 MerkleProof 函式庫。
### 狀態變數
* root儲存了Merkle Tree的根，部署合約的時候賦值。
* mintedAddress是一個mapping，記錄了已經mint過的地址，某地址mint成功後進行賦值。
### 函數
* 建構子：初始化NFT的名稱和代號，還有Merkle Tree的root。
* mint()函數：利用白名單鑄造NFT。參數為白名單地址account，鑄造的tokenId，和proof。首先驗證address是否在白名單中，驗證通過則把序號為tokenId的NFT鑄造給該地址，並將它記錄到mintedAddress。此過程中呼叫了_leaf()和_verify()函數。
* _leaf()函數：計算了Merkle Tree的葉子地址的雜湊。
* _verify()函數：呼叫了MerkleProof函式庫的verify()函數，進行Merkle Tree驗證。
# Signature
如果用過 opensea 交易 NFT，對簽名就不會陌生。從 Metamask 錢包進行簽署時彈出的窗口，可以證明你擁有私鑰的同時不需要對外公佈私鑰。以太坊使用的數位簽章演算法叫做雙橢圓曲線數位簽章演算法（ECDSA），是基於雙橢圓曲線「私鑰-公鑰」對的數位簽章演算法。它主要起到了三個作用：
1. 身分認證：證明簽章方是私鑰的持有人。
2. 不可否認：發送方不能否認發送過這個訊息。
3. 完整性：透過驗證針對傳輸訊息產生的數位簽名，可以驗證訊息是否在傳輸過程中被竄改。
## ECDSA 合約
ECDSA標準中包含兩個部分：
1. 簽署者利用私鑰（private）對訊息（public）創建簽名（public）。
2. 其他人則使用訊息（public）和簽名（public）恢復簽署者的公鑰（public）並驗證簽名。
```
私鑰: 0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b
公鑰: 0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2
訊息: 0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
以太坊簽名訊息: 0xb42ca4636f721c7a331923e764587e98ec577cea1a185f60dfcc14dbb9bd900b
簽名: 0x390d704d7ab732ce034203599ee93dd5d3cb0d4d1d7c600ac11726659489773d559b12d220f99f41d17651b0c1c6a669d346a397f8541760d6b32a5725378b241c
```
### 建立簽名
1. 打包訊息： 在以太坊的 ECDSA 標準中，被簽署的訊息是一組資料的 keccak256 hash，為 bytes32 類型。我們可以把任何想要簽署的內容利用 abi.encodePacked() 函數打包，然後用 keccak256() 計算 hash，作為訊息。例子中的訊息是由一個 address 類型變數和一個 uint256 類型變數得到的：
    ```
    function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_account, _tokenId));
    }
    ```
2. 計算以太坊簽章訊息：訊息可以是能被執行的交易，也可以是其他任何形式。為了避免使用者誤簽了惡意交易，EIP191 提倡在訊息前加上 `"\x19Ethereum Signed Message:\n32"` 字串，並再做一次 keccak256 哈希，作為以太坊簽名訊息。經過`toEthSignedMessageHash()` 函數處理後的訊息，不能被用來執行交易:
    ```
        /**
         * @dev 回傳以太坊簽名訊息
         * `hash`：訊息
         * 遵從以太坊簽名標準：https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`]
         * 以及`EIP191`:https://eips.ethereum.org/EIPS/eip-191
         * 添加"\x19Ethereum Signed Message:\n32"字串，防止簽名的是可執行交易。
         */
        function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
            // 哈希的長度為32
            return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        }
    ```
3. (1) 利用錢包簽章： 在日常操作中，大部分使用者都是透過這種方式進行簽署。在取得到需要簽名的訊息之後，我們需要使用 Metamask 錢包進行簽名。Metamask 的 personal_sign 方法會自動把訊息轉換為以太坊簽章訊息，然後發起簽章。所以我們只需要輸入訊息和簽名者錢包 account。要注意的是輸入的簽署者錢包 account 需要和 metamask 目前連接的 account 一致才能使用。
因此需把例子中的私鑰導入到 Metamask 錢包，然後打開瀏覽器的 console 頁面。在連接錢包的狀態下（如連接 opensea，否則會出現錯誤），依序輸入以下指令進行簽署
    ```
    ethereum.enable()
    account = "0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2" // 公鑰
    hash = "0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c" // 訊息
    ethereum.request({method: "personal_sign", params: [account, hash]})
    ```
    在 console 頁面傳回的結果（Promise 的 PromiseResult）可以看到建立好的簽章。不同帳戶有不同的私鑰，創建的簽名值也不同。
3. (2) 利用 web3.py 簽名： 批次呼叫中更傾向於使用程式碼進行簽名，以下是基於web3.py的實作。
    ```
    from web3 import Web3, HTTPProvider
    from eth_account.messages import encode_defunct

    private_key = "0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b"
    address = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
    rpc = 'https://rpc.ankr.com/eth'
    w3 = Web3(HTTPProvider(rpc))

    #打包訊息
    msg = Web3.solidity_keccak(['address','uint256'], [address,0])
    print(f"消息：{msg.hex()}")
    #建構可簽名訊息
    message = encode_defunct(hexstr=msg.hex())
    #簽名
    signed_message = w3.eth.account.sign_message(message, private_key=private_key)
    print(f"簽名：{signed_message['signature'].hex()}")
    ```
    運行計算的簽名結果應該和前面的案例一致。

### 驗證簽名
為了驗證簽名，驗證者需要擁有訊息、簽名和簽名使用的公鑰。我們能驗證簽名的原因是只有私鑰的持有者才能夠針對交易產生這樣的簽名，而別人不能。

4. 透過簽名和訊息恢復公鑰：簽名是由數學演算法產生的。這裡我們使用的是 rsv 簽名，簽名包含 r, s, v 三個值的資訊。而後，我們可以透過 r, s, v 及以太坊簽章訊息來求公鑰。下面的 recoverSigner() 函數實現了上述步驟，它利用以太坊簽署訊息 _msgHash 和簽署 _signature 恢復公鑰（使用了簡單的行內組語）：
    ```
        // @dev 從_msgHash和簽名_signature中恢復signer地址
    function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address){
        // 檢查簽名長度，65是標準r,s,v簽名的長度
        require(_signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        // 目前只能用assembly (行內組語)來從簽名中獲得r,s,v的值
        assembly {
            /*
            前32 bytes儲存簽章的長度 (動態陣列儲存規則)
            add(sig, 32) = sig的指標 + 32
            等效為略過signature的前32 bytes
            mload(p) 載入從記憶體位址 p 起始的接下來 32 bytes資料
            */
            // 讀取長度資料後的 32 bytes
            r := mload(add(_signature, 0x20))
            // 讀取之後的 32 bytes
            s := mload(add(_signature, 0x40))
            // 讀取最後一個 byte
            v := byte(0, mload(add(_signature, 0x60)))
        }
        // 使用ecrecover(全域函數)：利用 msgHash 和 r,s,v 來恢復 signer 位址
        return ecrecover(_msgHash, v, r, s);
    }
    ```
5. 比較公鑰並驗證簽章：接下來只需要比對復原的公鑰與簽署者公鑰 _signer 是否相等，若相等，則簽章有效；否則，簽章無效：
    ```
        /**
     * @dev @dev 透過ECDSA，驗證簽章位址是否正確，如果正確則回傳true
     * _msgHash為訊息的hash
     * _signature為簽名
     * _signer為簽名地址
     */
    function verify(bytes32 _msgHash, bytes memory _signature, address _signer) internal pure returns (bool) {
        return recoverSigner(_msgHash, _signature) == _signer;
    }
    ```
## 利用簽名發放白名單
NFT 專案方可以利用 ECDSA 的這個特性發放白名單。由於簽名是鏈下的，不需要 gas，因此這種白名單發放模式比 Merkle Tree 模式還要經濟實惠。方法非常簡單，專案方利用專案方帳戶把白名單發放地址簽名（可以加上地址可以鑄造的 tokenId）。然後 mint 的時候利用 ECDSA 檢驗簽章是否有效，如果有效，則給他 mint。但由於使用者要請求中心化介面去取得簽名，不可避免的犧牲了一部分去中心化。另外還有一個好處是白名單可以動態變化，而不是提前寫死在合約裡面，因為專案方的中心化後端介面可以接受任何新地址的請求並給予白名單簽名。
SignatureNFT 合約實現了利用簽名發放 NFT 白名單：
```
contract SignatureNFT is ERC721 {
    address immutable public signer; // 簽名地址
    mapping(address => bool) public mintedAddress;   // 記錄已經mint的位址

    // 建構子，初始化 NFT 合集的名稱、代號、簽名地址
    constructor(string memory _name, string memory _symbol, address _signer)
    ERC721(_name, _symbol)
    {
        signer = _signer;
    }

    // 利用ECDSA驗證簽章並mint
    function mint(address _account, uint256 _tokenId, bytes memory _signature)
    external
    {
        bytes32 _msgHash = getMessageHash(_account, _tokenId); // 將_account和_tokenId打包訊息
        bytes32 _ethSignedMessageHash = ECDSA.toEthSignedMessageHash(_msgHash); // 計算以太坊簽名訊息
        require(verify(_ethSignedMessageHash, _signature), "Invalid signature"); // ECDSA檢驗通過
        require(!mintedAddress[_account], "Already minted!"); // 地址沒有mint過
        _mint(_account, _tokenId); // mint
        mintedAddress[_account] = true; // 記錄mint過的地址
    }

    /*
     * 將mint位址（address類型）和tokenId（uint256類型）拼成訊息msgHash
     * _account: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
     * _tokenId: 0
     * 對應的訊息: 0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
     */
    function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_account, _tokenId));
    }

    // ECDSA驗證，呼叫ECDSA函式庫的verify()函數
    function verify(bytes32 _msgHash, bytes memory _signature)
    public view returns (bool)
    {
        return ECDSA.verify(_msgHash, _signature, signer);
    }
}
```
### 說明
#### 狀態變數
* signer：公鑰，專案方簽署地址。
* mintedAddress：是一個 mapping，記錄了已經 mint 過的地址。
#### 函數
* 建構子：初始化 NFT 的名稱和代號，還有 ECDSA 的簽章地址 signer
* mint()函數：接受地址 address、tokenId 和 _signature 三個參數，驗證簽名是否有效：如果有效，則把 tokenId 的 NFT 鑄造給 address 地址，並將它記錄到 mintedAddress。它呼叫了 getMessageHash()、ECDSA.toEthSignedMessageHash() 和 verify() 函數。
* etMessageHash() 函數：將 mint 位址（address 類型）和tokenId（uint256 類型）拼成訊息。
* verify() 函數呼叫了 ECDSA 函式庫的 verify() 函數，來進行 ECDSA 簽章驗證。

# NFT交易所
Opensea 是以太坊上最大的 NFT 交易平台，總交易總量達到了 $300 億。 Opensea 在交易中抽成 2.5%，因此它透過使用者交易獲利了至少 $7.5億。另外，它的運作並不去中心化，也不準備發幣補償用戶。 NFT 玩家苦 Opensea 久矣，今天我們就利用智能合約搭建一個零手續費的去中心化 NFT 交易所：NFTSwap。
## 設計邏輯
* 賣家：出售 NFT 的一方，可以掛單 list、取消單 revoke、修改價格 update。
* 買家：購買 NFT 的一方，可以購買 purchase。
* 訂單：賣家發布的 NFT 鏈上訂單，一個系列的同一 tokenId 最多存在一個訂單，其中包含掛單價格 price 和持有人 owner 資訊。當一個訂單交易完成或被撤單後，其中資訊清除。
## NFTSwap 合約
### 事件
```
    event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price); // 掛單
    event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price); // 
    event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId); // 撤單
    event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice); // 修改價格
```
### 訂單
NFT 訂單抽象化為 Order 結構，包含掛單價格 price 和持有人 owner 資訊。nftList 映射記錄了訂單是對應的 NFT 系列（合約地址）和 tokenId 資訊。
```
// 定義訂單結構
struct Order{
    address owner;
    uint256 price; 
}
// NFT 訂單映射
mapping(address => mapping(uint256 => Order)) public nftList;
```

### 回退函數
在 NFTSwap 中，使用者用 ETH 購買 NFT。因此，合約需要實作 fallback() 函數來接收 ETH。
```
fallback() external payable{}
```
### onERC721Received
ERC721 的安全轉帳函數會檢查接收合約是否實作了 onERC721Received() 函數，並傳回正確的選擇器 selector。使用者下單之後，需要將 NFT 發送給 NFTSwap 合約。因此 NFTSwap 繼承 IERC721Receiver 介面，並實現 onERC721Received() 函數：
```
contract NFTSwap is IERC721Receiver{
    // 實現{IERC721Receiver}的onERC721Received，能夠接收ERC721代幣
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }
```
### 交易
合約實現了4個交易相關的函數：
* 掛單list()：賣家建立 NFT 並建立訂單，然後釋放 List 事件。參數為 NFT 合約地址 _nftAddr，NFT 對應的 _tokenId，掛單價格 _price（單位是 wei）。成功後，NFT 會從賣家轉到 NFTSwap 合約。
    ```
        // 掛單: 賣家上架NFT，合約地址為_nftAddr，tokenId為_tokenId，價格_price為以太坊（單位是wei）
    function list(address _nftAddr, uint256 _tokenId, uint256 _price) public{
        IERC721 _nft = IERC721(_nftAddr); // 宣告 IERC721 介面合約變數
        require(_nft.getApproved(_tokenId) == address(this), "Need Approval"); // 合約得到授權
        require(_price > 0); // 價格大於0

        Order storage _order = nftList[_nftAddr][_tokenId]; //設定NF持有者和價格
        _order.owner = msg.sender;
        _order.price = _price;
        // 將NFT轉帳到合約
        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        // 釋放List事件
        emit List(msg.sender, _nftAddr, _tokenId, _price);
    }
    ```
* 撤單 revoke()：賣家撤回掛單，並釋放 Revoke 事件。參數為 NFT 合約位址 _nftAddr，NFT 對應的 _tokenId。成功後，NFT 會從 NFTSwap 合約轉回賣家。
    ```
        // 撤單： 賣家取消掛單
    function revoke(address _nftAddr, uint256 _tokenId) public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得 Order        
        require(_order.owner == msg.sender, "Not Owner"); // 必須由持有人發起
        // 宣告IERC721介面合約變數
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合約中
        
        // 將NFT轉給賣家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        delete nftList[_nftAddr][_tokenId]; // 刪除order
      
        // 釋放Revoke事件
        emit Revoke(msg.sender, _nftAddr, _tokenId);
    }
    ```
* 修改價格 update()：賣家修改 NFT 訂單價格，並釋放 Update 事件。參數為 NFT 合約地址 _nftAddr，NFT 對應的 _tokenId，更新後的掛單價格 _newPrice（單位是wei）。
    ```
        // 調整價格：賣家調整掛單價格
    function update(address _nftAddr, uint256 _tokenId, uint256 _newPrice) public {
        require(_newPrice > 0, "Invalid Price"); // NFT價格大於0
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得 Order        
        require(_order.owner == msg.sender, "Not Owner"); // 必須由持有人發起
        //  宣告IERC721介面合約變數
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合約中
        
        // 調整NFT價格
        _order.price = _newPrice;
      
        // 釋放Update事件
        emit Update(msg.sender, _nftAddr, _tokenId, _newPrice);
    }
    ```
* 購買 purchase：買家支付 ETH 購買掛單的 NFT，並釋放 Purchase 事件。參數為 NFT 合約地址 _nftAddr，NFT 對應的 _tokenId。成功後，ETH 將轉給賣家，NFT 將從NFTSwap 合約轉給買家。
    ```
        // 購買: 買家購買NFT，合約為_nftAddr，tokenId為_tokenId，呼叫函數時要附帶ETH
    function purchase(address _nftAddr, uint256 _tokenId) payable public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.price > 0, "Invalid Price"); // NFT價格大於0
        require(msg.value >= _order.price, "Increase price"); // 購買價格大於標價
        // 宣告IERC721介面合約變數
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合約中

        // 將NFT轉給買家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 將ETH轉給賣家，多餘ETH給買家退款
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // 刪除order

        // 釋放Purchase事件
        emit Purchase(msg.sender, _nftAddr, _tokenId, _order.price);
    }
    ```
### 2024.10.13
# 鏈上隨機數
許多以太坊上的應用都需要用到隨機數，例如 NFT 隨機抽取 tokenId、抽盲盒、gamefi 戰鬥中隨機分勝負等等。但由於以太坊上所有資料都是公開透明（public）且確定性（deterministic）的，它沒法像其他程式語言一樣提供開發者產生隨機數的方法。今天將介紹鏈上（雜湊函數）和鏈下（chainlink 預言機）隨機數產生的兩種方法，並利用它們做一款 tokenId 隨機鑄造的NFT。
## 鏈上隨機數生成
我們可以將一些鏈上的全域變數當作種子，利用 keccak256() **雜湊函數**來取得偽隨機數。這是因為雜湊函數具有靈敏度和均一性，可以得到「看似」隨機的結果。下面的 getRandomOnchain() 函數利用全域變數 block.timestamp、msg.sender 和 blockhash(block.number-1) 作為種子來取得隨機數：
```
    /** 
    * 鏈上偽隨機數生成 
    * 利用keccak256()打包一些鏈上的全域變數/自訂變數
    * 返回時轉換成uint256類型
    */
    function getRandomOnchain() public view returns(uint256){
        // remix運行blockhash會報錯
        bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));
        
        return uint256(randomBytes);
    }
```
注意：這個方法不安全，因為 block.timestamp、msg.sender 和 blockhash(block.number-1) 這些變數都是公開的，使用者可以預測出用這些種子產生的隨機數，並挑出他們想要的隨機數執行合約，礦工可以操縱 blockhash 和 block.timestamp，使得產生的隨機數符合他的利益。
## 鏈下隨機數生成
我們可以在鏈下產生隨機數，然後透過**預言機（Chainlink）**把隨機數上傳到鏈上。Chainlink 提供 VRF（可驗證隨機函數）服務，鏈上開發者可以支付 LINK 代幣來取得隨機數。Chainlink VRF有兩個版本，第二個版本需要官網註冊並預付費，比第一個版本多許多操作，需要花費更多的 gas，但取消訂閱後可以拿回剩餘的 Link，這裡介紹第二個版本 Chainlink VRF V2。
### Chainlink VRF 使用步驟
1. 智能合約應用發送隨機數請求
2. Chainlink 產生隨機數並將證明發送到 VRF 合約
3. VRF 合約驗證隨機數
4. 智能合約應用接收隨機數

我們將用一個簡單的合約介紹使用 Chainlink VRF的步驟。 RandomNumberConsumer 合約可以向 VRF 請求隨機數，並儲存在狀態變數 randomWords 中。
1. 申請 Subscription 並轉入 Link 代幣
    在 [Chainlink VRF 網站](https://vrf.chain.link/)上創建一個 Subscription，其中信箱和專案名稱都是選填。創建完成後往 Subscription 中轉入一些 Link 代幣。Sepolia 測試網的 LINK 代幣可以從 [LINK 水龍頭](https://faucets.chain.link/)領取。
2. 使用者合約繼承 VRFConsumerBaseV2
    為了使用 VRF 取得隨機數，合約需要繼承 VRFConsumerBaseV2 合約，並在建構子中初始化 VRFCoordinatorV2Interface 和 Subscription Id。（不同鏈對應不同的[參數](https://docs.chain.link/vrf/v2/subscription/supported-networks)）
    ```
    // SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomNumberConsumer is VRFConsumerBaseV2{

    //請求隨機數需要呼叫VRFCoordinatorV2Interface介面
    VRFCoordinatorV2Interface COORDINATOR;
    
    // 申請後的subId
    uint64 subId;

    //存放得到的 requestId 和 隨機數
    uint256 public requestId;
    uint256[] public randomWords;
    
    /**
     * 使用chainlink VRF，建構子需要繼承 VRFConsumerBaseV2
     * 不同鏈的參數填的不一樣，可參 https://docs.chain.link/vrf/v2/subscription/supported-networks
     * 網路: Sepolia測試網
     * Chainlink VRF Coordinator 地址: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625
     * LINK 代幣地址: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     * 30 gwei Key Hash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c
     * Minimum Confirmations 最小確認塊數 : 3 （數字大安全性高，一般填12）
     * callbackGasLimit gas限制 : 最大 2,500,000
     * Maximum Random Values 一次可以得到的隨機數個數 : 最大 500         
     */
    address vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625;
    bytes32 keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 200_000;
    uint32 numWords = 3;
    
    constructor(uint64 s_subId) VRFConsumerBaseV2(vrfCoordinator){
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        subId = s_subId;
    }
    ```
3. 使用者合約申請隨機數
    使用者可以呼叫從 VRFCoordinatorV2Interface 介面合約中的 requestRandomWords 函數申請隨機數，並傳回申請識別碼 requestId。這個申請會傳遞給 VRF 合約。合約部署後，需要把合約加入 Subscription 的 Consumers 中，才能發送申請。
    ```
     /** 
     * 向VRF合約申請隨機數
     */
    function requestRandomWords() external {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }
    ```
4. Chainlink 節點鏈下產生隨機數和數字簽名，並發送給 VRF 合約。
5. VRF 合約驗證簽名有效性
6. 使用者合約接收並使用隨機數
    在 VRF 合約驗證簽章有效之後，會自動呼叫使用者合約的回退函數 fulfillRandomness()，將鏈下產生的隨機數傳送過來。使用者要把消耗隨機數的邏輯寫在這裡。使用者申請隨機數時呼叫的 requestRandomness() 和 VRF 合約傳回隨機數時呼叫的回退函數 fulfillRandomness() 是兩筆交易，呼叫者分別是使用者合約和 VRF 合約，後者比前者晚幾分鐘（不同鏈延遲不一樣）。
    ```
     /**
     * VRF合約的回傳函數，驗證隨機數有效之後會自動被調用
     * 消耗隨機數的邏輯寫在這裡
     */
    function fulfillRandomWords(uint256 requestId, uint256[] memory s_randomWords) internal override {
        randomWords = s_randomWords;
    }
    ```
## tokenId 隨機鑄造的 NFT
我們將利用鏈上和鏈下隨機數字來做一款tokenId隨機鑄造的NFT。 Random合約繼承ERC721和VRFConsumerBaseV2合約。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Random is ERC721, VRFConsumerBaseV2{
    // NFT相關
    uint256 public totalSupply = 100; // NFT總供給
    uint256[100] public ids; // 數組，用於計算可供mint的tokenId，請參閱pickRandomUniqueId()函數。
    uint256 public mintCount; // 已經mint的數量

    // Chainlink VRF相關參數
    
    // VRFCoordinatorV2Interface
    VRFCoordinatorV2Interface COORDINATOR; // 呼叫VRFCoordinatorV2Interface介面
    
    /**
     * 使用chainlink VRF，建構子需要繼承 VRFConsumerBaseV2
     * 不同鏈的參數填的不一樣，可參 https://docs.chain.link/vrf/v2/subscription/supported-networks
     * 網路: Sepolia測試網
     * Chainlink VRF Coordinator 地址: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625
     * LINK 代幣地址: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     * 30 gwei Key Hash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c
     * Minimum Confirmations 最小確認塊數 : 3 （數字大安全性高，一般填12）
     * callbackGasLimit gas限制 : 最大 2,500,000
     * Maximum Random Values 一次可以得到的隨機數個數 : 最大 500         
     */
    address vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625; // VRF 合約地址
    bytes32 keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c; // VRF唯一識別符
    uint16 requestConfirmations = 3; // 確認區塊數
    uint32 callbackGasLimit = 1_000_000; // VRF手續費
    uint32 numWords = 1; // 請求的隨機數個數
    uint64 subId; // 申請的Subscription Id
    uint256 public requestId; // 申請標識符
    
    // 記錄申請VRF用於mint的使用者地址
    mapping(uint256 => address) public requestToSender;
```
### 建構子
初始化繼承的 VRFConsumerBaseV2 和 ERC721 合約的相關變數。
```
    constructor(uint64 s_subId) 
        VRFConsumerBaseV2(vrfCoordinator)
        ERC721("WTF Random", "WTF"){
            COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
            subId = s_subId;
    }
```
### 函數
```
    // 輸入uint256數字，回傳一個可以mint的tokenId
    function pickRandomUniqueId(uint256 random) private returns (uint256 tokenId) {
        //先計算減法，再計算++，注意(a++，++a)區別
        uint256 len = totalSupply - mintCount++; // 可mint數量
        require(len > 0, "mint close"); // 所有tokenId被mint完了
        uint256 randomIndex = random % len; // 取得鏈上隨機數

        //隨機數取模，得到tokenId，作為數組下標，同時記錄value為len-1，如果取模得到的值已存在，則tokenId取該數組下標的value
        tokenId = ids[randomIndex] != 0 ? ids[randomIndex] : randomIndex; // 取得tokenId
        ids[randomIndex] = ids[len - 1] == 0 ? len - 1 : ids[len - 1]; // 更新ids 列表
        ids[len - 1] = 0; // 刪除最後一個元素，能返還gas
    }

    /** 
    * 鏈上偽隨機數生成
    * keccak256(abi.encodePacked()中填上一些鏈上的全域變數/自訂變數
    * 返回時轉換成uint256型
    */
    function getRandomOnchain() public view returns(uint256){
        /*
         * 本例鏈上隨機只依賴區塊哈希，呼叫者位址，和區塊時間，
         * 想提高隨機性可以再增加一些屬性例如nonce等，但不能根本解決安全問題
         */
        bytes32 randomBytes = keccak256(abi.encodePacked(blockhash(block.number-1), msg.sender, block.timestamp));
        return uint256(randomBytes);
    }

    // 利用鏈上偽隨機數鑄造NFT
    function mintRandomOnchain() public {
        uint256 _tokenId = pickRandomUniqueId(getRandomOnchain()); 
        _mint(msg.sender, _tokenId);
    }

    /** 
     * 呼叫VRF取得隨機數，並mintNFT
     * 要呼叫requestRandomness()函數獲取，消耗隨機數的邏輯寫在VRF的回呼函數fulfillRandomness()中
     * 在呼叫之前，需要在Subscriptions中轉入足夠的Link
     */
    function mintRandomVRF() public {
        // 呼叫requestRandomness取得隨機數
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requestToSender[requestId] = msg.sender;
    }

    /**
     * VRF的回傳函數，由VRF Coordinator呼叫
     * 消耗隨機數的邏輯寫在本函數
     */
    function fulfillRandomWords(uint256 requestId, uint256[] memory s_randomWords) internal override{
        address sender = requestToSender[requestId]; // 从requestToSender中获取minter用户地址
        uint256 tokenId = pickRandomUniqueId(s_randomWords[0]); // 利用VRF返回的随机数生成tokenId
        _mint(sender, tokenId);
    }
```
* pickRandomUniaueId()：輸入隨機數，取得可供mint的tokenId
   演算法過程可理解為：totalSupply個空杯子（0初始化的ids）排成一排，每個杯子旁邊放一個球，編號為[0, totalSupply - 1]。 每次從場上隨機拿走一個球（球可能在杯子旁邊，這是初始狀態；也可能是在杯子裡，說明杯子旁邊的球已經被拿走過，則此時新的球從末尾被放到了杯子裡） 再把最後的一個球（還是可能在杯子裡也可能在杯子旁邊）放進被拿走的球的杯子裡，循環totalSupply次。相較於傳統的隨機排列，省去了初始化ids[]的gas。
* getRandomOnchain()：取得鏈上隨機數（不安全）。
* mintRandomOnchain()：利用鏈上隨機數鑄造NFT，呼叫了getRandomOnchain()和pickRandomUniqueId()。
* mintRandomVRF()：申請Chainlink VRF用於鑄造隨機數。由於使用隨機數鑄造的邏輯在回調函數fulfillRandomness()，而回調函數的呼叫者是VRF合約，而非鑄造NFT的用戶，這裡必須利用requestToSender狀態變數記錄VRF申請識別碼對應的用戶位址。 
* fulfillRandomWords()：VRF的回調函數，由VRF合約在驗證隨機數真實性後自動調用，用返回的鏈下隨機數鑄造NFT。

使用鏈上隨機數高效，但是不安全；而鏈下隨機數生成依賴於第三方提供的預言機服務，比較安全，但是沒那麼簡單經濟。專案方要根據業務場景來選擇適合自己的方案。

# EIP1155
ERC1155標準支援一個合約包含多種代幣。並且我們可以發行一個魔改的無聊猿（ BAYC1155）：它包含 10000 種代幣，且元資料與 BAYC 一致。

　　不論是 ERC20 或 ERC721 標準，每個合約都對應一個獨立的代幣。假設我們要在以太坊上打造一個類似《魔獸世界》的大型遊戲，這需要我們對每個裝備都部署一個合約。上千種裝備就要部署和管理上千個合約，這非常麻煩。因此，以太坊 EIP1155 提出了一個多代幣標準 ERC1155，允許一個合約包含多個同質化和非同質化代幣。ERC1155 在 GameFi 應用最多，Decentraland、Sandbox 等知名鏈遊都使用它。
　　簡單來說，ERC1155 與先前介紹的非同質化代幣標準 ERC721 類似：在 ERC721 中，每個代幣都有一個 tokenId 作為唯一標識，每個 tokenId 只對應一個代幣；而在 ERC1155 中，每一種代幣都有一個 id 作為唯一標識，每個 id 對應一種代幣。這樣，代幣種類就可以非同質的在同一個合約裡管理了，而且每種代幣都有一個網址 uri 來儲存它的元數據，類似 ERC721 的 tokenURI。下面是 ERC1155 的元資料介面合約 IERC1155MetadataURI：
```
/**
 * @dev ERC1155的可選介面，加入了uri()函數查詢元數據
 */
interface IERC1155MetadataURI is IERC1155 {
    /**
     * @dev 回傳第`id`種類代幣的URI
     */
    function uri(uint256 id) external view returns (string memory);
```
那麼要怎麼區分 ERC1155 中的某類代幣是同質化還是非同質化代幣呢？其實很簡單：如果某一 id 對應的代幣總量為 1，那麼它就是非同質化代幣，類似 ERC721；如果某 id 對應的代幣總量大於 1，那麼他就是同質化代幣，因為這些代幣都分享同一個 id，類似 ERC20。
## IERC1155 介面合約
IERC1155 介面合約抽象化了 EIP1155 需要實現的功能，其中包含 4 個事件和 6 個函數。與 ERC721 不同，因為 ERC1155 包含多類代幣，它實現了批量轉帳和批量餘額查詢，一次操作多種代幣：
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

/**
 * @dev ERC1155標準的介面合約，實現了EIP1155的功能
 * 詳見：https://eips.ethereum.org/EIPS/eip-1155[EIP]
 */
interface IERC1155 is IERC165 {
    /**
     * @dev 單類代幣轉帳事件
     * 當`value`個`id`種類的代幣被`operator`從`from`轉帳到`to`時釋放
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev 批量代幣轉帳事件
     * ids和values為轉帳的代幣種類和數量陣列
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev 批量授權事件
     * 當`account`將所有代幣授權給`operator`時釋放
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev 當`id`種類的代幣的URI發生變化時釋放，`value`為新的URI
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev 持倉查詢，回傳`account`擁有的`id`種類的代幣的持倉量
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * 批量持倉查詢，`accounts`和`ids`陣列的長度要相等
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev 批量授權，將呼叫者的代幣授權給`operator`地址。
     * 釋放{ApprovalForAll}事件
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev 批次授權查詢，如果授權位址`operator`被`account`授權，則傳回`true`
     * 見 {setApprovalForAll}函數
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev 安全轉賬，將`amount`單位`id`種類的代幣從`from`轉帳給`to`
     * 釋放{TransferSingle}事件
     * 要求:
     * - 如果呼叫者不是`from`位址而是授權位址，則需要得到`from`的授權
     * - `from`地址必須有足夠的持倉
     * - 如果接收方是合約，則需要實作`IERC1155Receiver`的`onERC1155Received`方法，並傳回對應的值
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev 批量安全轉帳
     * 釋放{TransferBatch}事件
     * 要求：
     * - `ids`和`amounts`長度相等
     * - 如果接收方是合約，則需要實作`IERC1155Receiver`的`onERC1155BatchReceived`方法，並傳回對應的值
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
```
### IERC1155 事件
* TransferSingle事件：單類代幣轉帳事件，在單幣種轉帳時釋放。
* TransferBatch事件：大量代幣轉帳事件，在多幣種轉帳時釋放。
* ApprovalForAll事件：批次授權事件，在批次授權時釋放。
* URI事件：元資料位址變更事件，在uri變化時釋放。
### IERC1155 函數
* balanceOf()：單幣種餘額查詢，傳回account擁有的id種類的代幣的持倉量。
* balanceOfBatch()：多幣種餘額查詢，查詢的位址accounts陣列和代幣種類ids陣列的長度要相等。
* setApprovalForAll()：大量授權，將呼叫者的代幣授權給operator位址。
* isApprovedForAll()：查詢批次授權訊息，如果授權地址operator被account授權，則傳回true。
* safeTransferFrom()：安全單幣轉賬，將amount單位id種類的代幣從from地址轉帳給to地址。如果to位址是合約，則會驗證是否實作了onERC1155Received()接收函數。
* safeBatchTransferFrom()：安全多幣轉賬，與單幣轉帳類似，只不過轉帳數量amounts和代幣種類ids變成數組，且長度相等。如果to位址是合約，則會驗證是否實作了onERC1155BatchReceived()接收函數。
## ERC1155 接收合約
與 ERC721 標準類似，為了避免代幣被轉入黑洞合約，ERC1155 要求代幣接收合約繼承 IERC1155Receiver 並實現兩個接收函數：
* onERC1155Received()：單幣轉帳接收函數，接受ERC1155安全轉帳safeTransferFrom 需要實作並傳回自己的選擇器0xf23a6e61。
* onERC1155BatchReceived()：多幣轉帳接收函數，接受ERC1155安全多幣轉帳safeBatchTransferFrom 需要實作並傳回自己的選擇器0xbc197c81。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

/**
 * @dev ERC1155接收合約，要接受ERC1155的安全轉賬，就需要實現這個合約
 */
interface IERC1155Receiver is IERC165 {
    /**
     * @dev 接受ERC1155安全轉帳`safeTransferFrom`
     * 需要回傳 0xf23a6e61 或 `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
     */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev 接受ERC1155批量安全轉帳`safeBatchTransferFrom`
     * 需要回傳 0xbc197c81 或 `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
     */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}
```
## ERC1155 主合約
ERC1155主合約實現了IERC1155介面合約規定的函數，以及單幣/多幣的鑄造和銷毀函數。
### ERC1155 變數
ERC1155 主合約包含 4 個狀態變數：
* name：代幣名稱
* symbol：代幣代號
* _balances：代幣持倉映射，記錄代幣種類id下某地址account的持倉量balances。 
* _operatorApprovals：批次授權映射，記錄持有位址給另一個位址的授權情況。
### ERC1155 函數
* 建構子：初始化狀態變數name和symbol。
* supportsInterface()：實現ERC165標準，聲明它支援的接口，供其他合約檢查。 
* balanceOf()：實作IERC1155的balanceOf()，查詢持倉量。與ERC721標準不同，這裡要輸入查詢的持倉地址account以及幣種id。
* balanceOfBatch()：實作IERC1155的balanceOfBatch()，批次查詢持倉量。 
* setApprovalForAll()：實作IERC1155的setApprovalForAll()，批次授權，釋放ApprovalForAll事件。
* isApprovedForAll()：實作IERC1155的isApprovedForAll()，查詢批次授權資訊。
* safeTransferFrom()：實作IERC1155的safeTransferFrom()，單幣種安全轉賬，釋放TransferSingle事件。與ERC721不同，這裡不僅需要填發出方from，接收方to，代幣種類id，還需要填轉帳金額amount。
* safeBatchTransferFrom()：實作IERC1155的safeBatchTransferFrom()，多幣種安全轉賬，釋放TransferBatch事件。
* _mint()：單幣種鑄造函數。
* _mintBatch()：多幣種鑄造函數。
* _burn()：單幣種銷毀函數。
* _burnBatch()：多幣種銷毀函數。
* _doSafeTransferAcceptanceCheck：單幣種轉帳的安全檢查，被safeTransferFrom()調用，確保接收方為合約的情況下，實作了onERC1155Received()函數。
* _doSafeBatchTransferAcceptanceCheck：多幣種轉帳的安全檢查，，被safeBatchTransferFrom調用，確保接收方為合約的情況下，實現了onERC1155BatchReceived()函數。
* uri()：傳回ERC1155的第id種代幣儲存元資料的網址，類似ERC721的tokenURI。
* baseURI()：返回baseURI，uri就是把baseURI和id拼接在一起，需要開發重寫。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Receiver.sol";
import "./IERC1155MetadataURI.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/Address.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/String.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

/**
 * @dev ERC1155多代幣標準
 * 見 https://eips.ethereum.org/EIPS/eip-1155
 */
contract ERC1155 is IERC165, IERC1155, IERC1155MetadataURI {
    using Address for address; // 使用Address庫，用isContract來判斷地址是否為合約
    using Strings for uint256; // 使用String庫
    // Token名稱
    string public name;
    // Token代號
    string public symbol;
    // 代幣種類id 到帳戶account 到餘額balances 的映射
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // address 到 授權地址 的批次授權映射
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * 建構子，初始化`name` 和`symbol`, uri_
     */
    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return
            interfaceId == type(IERC1155).interfaceId ||
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    /**
     * @dev 持倉查詢 實現IERC1155的balanceOf，返回account地址的id種類代幣持倉量。
     */
    function balanceOf(address account, uint256 id) public view virtual override returns (uint256) {
        require(account != address(0), "ERC1155: address zero is not a valid owner");
        return _balances[id][account];
    }

    /**
     * @dev 批量持倉查詢
     * 要求:
     * `accounts` 和 `ids` 陣列長度相等
     */
    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public view virtual override
        returns (uint256[] memory)
    {
        require(accounts.length == ids.length, "ERC1155: accounts and ids length mismatch");
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }

    /**
     * @dev 批量授權，調用者授權operator使用其所有代幣
     * 釋放{ApprovalForAll}事件
     * 條件：msg.sender != operator
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(msg.sender != operator, "ERC1155: setting approval status for self");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev 查詢批量授權
     */
    function isApprovedForAll(address account, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev 安全轉賬，將`amount`單位的`id`種類代幣從`from`轉賬到`to`
     *  釋放 {TransferSingle} 事件
     * 要求:
     * - to 不能是0位址
     * - from擁有足夠的持倉量，且呼叫者擁有授權
     * - 如果 to 是智能合約，他必須支援 IERC1155Receiver-onERC1155Received
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // 呼叫者是持有者或是被授權
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(to != address(0), "ERC1155: transfer to the zero address");
        // from地址有足夠持倉
        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "ERC1155: insufficient balance for transfer");
        // 更新持倉量
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }
        _balances[id][to] += amount;
        // 釋放事件
        emit TransferSingle(operator, from, to, id, amount);
        // 安全檢查
        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);    
    }

    /**
     * @dev 批量安全轉賬，將`amounts`數組單位的`ids`數組種類代幣從`from`轉賬到`to`
     * 釋放 {TransferSingle} 事件
     * 要求:
     * - to 不能是0位址
     * - from擁有足夠的持倉量，且呼叫者擁有授權
     * - 如果 to 是智能合約, 他必須支援 IERC1155Receiver-onERC1155BatchReceived
     * - ids和amounts陣列長度相等
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // 呼叫者是持有者或是被授權
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");
        require(to != address(0), "ERC1155: transfer to the zero address");

        // 透過for循環更新持倉
        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "ERC1155: insufficient balance for transfer");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
            _balances[id][to] += amount;
        }

        emit TransferBatch(operator, from, to, ids, amounts);
        // 安全檢查
        _doSafeBatchTransferAcceptanceCheck(operator, from, to, ids, amounts, data);    
    }

    /**
     * @dev 鑄造
     * 釋放 {TransferSingle} 事件
     */
    function _mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");

        address operator = msg.sender;

        _balances[id][to] += amount;
        emit TransferSingle(operator, address(0), to, id, amount);

        _doSafeTransferAcceptanceCheck(operator, address(0), to, id, amount, data);
    }

    /**
     * @dev 批量鑄造
     * 釋放 {TransferBatch} 事件
     */
    function _mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            _balances[ids[i]][to] += amounts[i];
        }

        emit TransferBatch(operator, address(0), to, ids, amounts);

        _doSafeBatchTransferAcceptanceCheck(operator, address(0), to, ids, amounts, data);
    }

    /**
     * @dev 銷毀
     */
    function _burn(
        address from,
        uint256 id,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");

        address operator = msg.sender;

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }

        emit TransferSingle(operator, from, address(0), id, amount);
    }

    /**
     * @dev 批量銷毀
     */
    function _burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), ids, amounts);
    }

    // @dev ERC1155的安全轉帳檢查
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    // @dev ERC1155的批量安全轉帳檢查
    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try IERC1155Receiver(to).onERC1155BatchReceived(operator, from, ids, amounts, data) returns (
                bytes4 response
            ) {
                if (response != IERC1155Receiver.onERC1155BatchReceived.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    /**
     * @dev 返回ERC1155的id種類代幣的uri，存放metadata，類似ERC721的tokenURI
     */
    function uri(uint256 id) public view virtual override returns (string memory) {
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, id.toString())) : "";
    }

    /**
     * 計算{uri}的BaseURI，uri就是把baseURI和tokenId拼接在一起，需要開發重寫
     */
    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
}
```

## BAYC，但ERC1155
我們魔改下 ERC721 標準的無聊猿 BAYC，創造一個免費鑄造的 BAYC1155。我們修改_baseURI()函數，讓 BAYC1155 的 uri 和 BAYC 的 tokenURI 一樣。這樣，BAYC1155元資料會與無聊猿的相同：
```
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./ERC1155.sol";

contract BAYC1155 is ERC1155{
    uint256 constant MAX_ID = 10000; 
    // 建構子
    constructor() ERC1155("BAYC1155", "BAYC1155"){
    }

    //BAYC的baseURI為ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }
    
    // 鑄造函數
    function mint(address to, uint256 id, uint256 amount) external {
        // id 不能超过10,000
        require(id < MAX_ID, "id overflow");
        _mint(to, id, amount, "");
    }

    // 批量鑄造函數
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts) external {
        // id 不能超過10000
        for (uint256 i = 0; i < ids.length; i++) {
            require(ids[i] < MAX_ID, "id overflow");
        }
        _mintBatch(to, ids, amounts, "");
    }
}
```
### 2024.10.14
# WETH
WETH（Wrapped ETH）是 ETH 的包裝版本。我們常見的 WETH、WBTC、WBNB，都是帶包裝的原生代幣。那我們為什麼要包裝它們？
2015 年，ERC20 標準出現，此代幣標準旨在為以太坊上的代幣制定一套標準化的規則，從而簡化了新代幣的發布，並使區塊鏈上的所有代幣相互可比。不幸的是，以太幣本身並不符合 ERC20 標準。 WETH 的開發是為了提高區塊鏈之間的互通性，並使 ETH 可用於去中心化應用程式（dApps）。它就像是給原生代幣穿了一件智能合約做的衣服：穿上衣服的時候，就變成了 WETH，符合 ERC20 同質化代幣標準，可以跨鏈，可以用於 dApp；脫下衣服，它可 1:1 兌換ETH。
## WETH 合約
目前在用的主網 WETH 合約寫於 2015 年，非常老，那時 solidity 是 0.4 版本。我們用 0.8 版本重寫一個 WETH。
WETH 符合 ERC20 標準，它比普通的 ERC20 多了兩個功能：
1. 存款：包裝，使用者將 ETH 存入 WETH 合約，並獲得等量的 WETH。
2. 提款：拆包裝，使用者銷毀 WETH，並獲得等量的 ETH。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20{
    // 事件：存款和提款
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    // 建構子，初始化ERC20的名字和代號
    constructor() ERC20("WETH", "WETH"){
    }

    // 回傳函數，當使用者往WETH合約轉ETH時，會觸發deposit()函數
    fallback() external payable {
        deposit();
    }
    // 回傳函數，當使用者往WETH合約轉ETH時，會觸發deposit()函數
    receive() external payable {
        deposit();
    }

    // 存款函數，當使用者存入ETH時，給他鑄造等量的WETH
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    // 提款函數，用戶銷毀WETH，取回等量的ETH
    function withdraw(uint amount) public {
        require(balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}
```
## 繼承
WETH 符合 ERC20 代幣標準，因此 WETH 合約繼承了 ERC20 合約。
## 事件
WETH 合約共有 2 個事件：
* Deposit：存款事件，在存款的時候釋放。
* Withdraw：取款事件，在取款的時候釋放。
## 函數
除了 ERC20 標準的函數外，WETH 合約有 5 個函數：
* 建構子：初始化 WETH 的名字和代號。
* 回傳函數：fallback() 和 receive()，當使用者往 WETH 合約轉 ETH 的時候，會自動觸發 deposit() 存款函數，獲得等量的 WETH。
* `deposit()`：存款函數，當使用者存入 ETH 時，給他鑄造等量的 WETH。
* `withdraw()`：提款函數，讓使用者銷毀 WETH，並歸還等量的 ETH。
# 分帳
分帳合約允許將 ETH 按權重轉給一組帳戶後，進行分帳。程式碼部分由 OpenZeppelin 函式庫的 PaymentSplitter 合約簡化而來。
分帳就是依照一定比例分錢財。在現實中，經常會有「分贓不均」的事情發生；而在區塊鏈的世界裡 Code is Law，我們可以事先把每個人應分的比例寫在智能合約中，獲得收入後，再由智能合約來進行分帳。
## 分帳合約
分帳合約（PaymentSplit）具有以下幾個特點：
1. 在創建合約時定好分帳受益人 payees 和每人的份額 shares。
2. 份額可以是相等，也可以是其他任意比例。
3. 在該合約收到的所有 ETH 中，每個受益人將能夠提取與其分配的份額成比例的金額。
4. 分帳合約遵循 Pull Payment 模式，付款不會自動轉入帳戶，而是保存在此合約中。受益人透過呼叫 release() 函數觸發實際轉帳。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * 分帳合約
 * @dev 這個合約會把收到的ETH按事先定好的份額分給幾個帳戶。收到ETH會存在分帳合約中，需要每個受益人呼叫release()函數來領取。
 */
contract PaymentSplit{
    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合約收款事件
    
    // 狀態變數
    uint256 public totalShares; // 總份額，為shares的和
    uint256 public totalReleased; // 總支付，從分帳合約向受益人支付出去的ETH，為 released 的和

    mapping(address => uint256) public shares; // address到uint256的映射，記錄每個受益人的份額
    mapping(address => uint256) public released; // address到uint256的映射，記錄分帳合約支付給每個受益人的金額
    address[] public payees; // address陣列，記錄受益人地址
    
    // 函數
    /**
     * @dev 建構子：始化受益人陣列_payees和分帳份額陣列_shares
     * 陣列長度不能為0，兩個陣列長度要相等。 _shares中元素要大於0，_payees中位址不能為0位址且不能有重複位址。
     */
    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // 檢查_payees和_shares儲存容量相同，且不為0
        require(_payees.length == _shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(_payees.length > 0, "PaymentSplitter: no payees");
        // 呼叫_addPayee，更新受益人地址payees、受益人份額shares和總份額totalShares
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }

    /**
     * @dev 回傳函數，在分帳合約收到ETH時釋放PaymentReceived事件
     */
    receive() external payable virtual {
        emit PaymentReceived(msg.sender, msg.value);
    }

    /**
     * @dev 分帳函數，為有效受益人地址_account分配對應的ETH。任何人都可以觸發這個函數，但ETH會轉給受益人地址account。
     * 呼叫了releasable()函數。
     */
    function release(address payable _account) public virtual {
        // account必須是有效受益人
        require(shares[_account] > 0, "PaymentSplitter: account has no shares");
        // 計算account應得的eth
        uint256 payment = releasable(_account);
        // 應得的eth不能為0
        require(payment != 0, "PaymentSplitter: account is not due payment");
        // 更新總支付totalReleased和支付給每個受益人的金額released
        totalReleased += payment;
        released[_account] += payment;
        // 轉帳
        _account.transfer(payment);
        emit PaymentReleased(_account, payment);
    }

    /**
     * @dev 計算一個受益人地址應領取的ETH。
     * 呼叫了pendingPayment()函數。
     */
    function releasable(address _account) public view returns (uint256) {
        // 計算分帳合約總收入totalReceived
        uint256 totalReceived = address(this).balance + totalReleased;
        // 呼叫_pendingPayment計算帳戶應得的ETH
        return pendingPayment(_account, totalReceived, released[_account]);
    }

    /**
     * @dev 根據受益人地址_account, 分帳合約總收入_totalReceived和該地址已領取的錢_alreadyReleased，計算該受益人現在應分的ETH。
     */
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // account應得的ETH = 總應得ETH - 已領到的ETH
        return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased;
    }

    /**
     * @dev 新增受益人函數及其份額函數。在合約初始化的時候被呼叫，之後不能修改。
     */
    function _addPayee(address _account, uint256 _accountShares) private {
        // 檢查_account不為0地址
        require(_account != address(0), "PaymentSplitter: account is the zero address");
        // 檢查_accountShares不為0
        require(_accountShares > 0, "PaymentSplitter: shares are 0");
        // 檢查帳戶不重複
        require(shares[_account] == 0, "PaymentSplitter: account already has shares");
        // 更新payees，shares和totalShares
        payees.push(_account);
        shares[_account] = _accountShares;
        totalShares += _accountShares;
        // 釋放增加受益人事件
        emit PayeeAdded(_account, _accountShares);
    }
```
# 代幣歸屬條款
在傳統金融領域，有些公司會向員工和管理階層提供股權。但大量股權同時釋出會在短期產生拋售壓力，拖累股價。因此，公司通常會引入一個歸屬期來延遲承諾資產的所有權。同樣的，在區塊鏈領域，Web3 新創公司會分配給團隊代幣，同時也會將代幣低價賣給風險投資和私募。如果他們把這些低成本的代幣同時提到交易所變現，幣價將被砸穿，散戶直接成為接盤俠。
所以，專案方一般會約定代幣歸屬條款（token vesting），在歸屬期內逐步釋放代幣，減緩拋壓，並防止團隊和資本方過早躺平。
## 線性釋放
線性釋放指的是代幣在歸屬期內勻速釋放。舉個例子，某私募持有 365000 枚 ICU 代幣，歸屬期為 1 年（365天），那麼每天會釋放 1,000 枚代幣。
下面是一個鎖倉並線性釋放 ERC20 代幣的合約 TokenVesting：
1. 專案方規定線性釋放的起始時間、歸屬期和受益人。
2. 專案方將鎖倉的 ERC20 代幣轉帳給 TokenVesting 合約。
3. 受益人可以呼叫 release 函數，從合約中取出釋放的代幣。
```
contract TokenVesting {
    // 事件
    event ERC20Released(address indexed token, uint256 amount); // 提幣事件，當受益人提取釋放代幣時釋放
    
    // 狀態變數
    mapping(address => uint256) public erc20Released; // 代幣地址->釋放數量的映射，記錄受益人已領取的代幣數量
    address public immutable beneficiary; // 受益人地址
    uint256 public immutable start; // 歸屬期起始時間戳記
    uint256 public immutable duration; // 歸屬期，單位為秒
    
     
    // 函數
     /**
     * @dev 建構子：初始化受益人地址，釋放週期(秒), 起始時間戳記(當前區塊鏈時間戳)
     * 參數為受益人地址beneficiaryAddress和歸屬期durationSeconds。
     * 為了方便，起始時間戳使用部署時的區塊鏈時間戳block.timestamp。
     */
    constructor(
        address beneficiaryAddress,
        uint256 durationSeconds
    ) {
        require(beneficiaryAddress != address(0), "VestingWallet: beneficiary is zero address");
        beneficiary = beneficiaryAddress;
        start = block.timestamp;
        duration = durationSeconds;
    }

    /**
     * @dev 提取代幣函數，將已釋放的代幣轉帳給受益人
     * 呼叫了vestedAmount()函數計算可提取的代幣數量，然後將代幣transfer給受益人
     * 參數為代幣地址token
     * 釋放ERC20Released事件
     */
    function release(address token) public {
        // 呼叫vestedAmount()函數計算可提取的代幣數量
        uint256 releasable = vestedAmount(token, uint256(block.timestamp)) - erc20Released[token];
        // 更新已釋放代幣數量   
        erc20Released[token] += releasable; 
        // 轉代幣給受益人
        emit ERC20Released(token, releasable);
        IERC20(token).transfer(beneficiary, releasable);
    }

    /**
     * @dev 根據線性釋放公式，查詢已釋放的代幣數量。開發者可以透過修改這個函數，自訂釋放方式。
     * @param token: 代幣地址
     * @param timestamp: 查詢的時間戳
     */
    function vestedAmount(address token, uint256 timestamp) public view returns (uint256) {
        // 合約裡總共收到了多少代幣（當前餘額 + 已經提取）
        uint256 totalAllocation = IERC20(token).balanceOf(address(this)) + erc20Released[token];
        // 根據線性釋放公式，計算已經釋放的數量
        if (timestamp < start) {
            return 0;
        } else if (timestamp > start + duration) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start)) / duration;
        }
    }
```

# 代幣鎖
代幣鎖(Token Locker)是一種簡單的時間鎖合約，它可以把合約中的代幣鎖倉一段時間，受益人在鎖倉期滿後可以取走代幣。代幣鎖一般是用來鎖倉流動性提供者 LP 代幣的。
## LP 代幣
區塊鏈中，使用者在去中心化交易所(DEX)上交易代幣，例如 Uniswap 交易所。DEX 和中心化交易所(CEX)不同，去中心化交易所使用自動做市商(AMM，Automated Market Maker)機制，需要使用者或專案方提供資金池，以使得其他用戶能夠即時買賣。簡單來說，使用者/專案方需要質押相應的幣對（例如ETH/DAI）到資金池中，作為補償，DEX 會給他們鑄造相應的流動性提供者 LP 代幣憑證，證明他們質押了相應的份額，供他們收取手續費。
## 為什麼要鎖定流動性？
如果專案方毫無徵兆的撤出流動性池中的 LP 代幣，那麼投資者手中的代幣就無法變現，直接歸零了。這種行為也叫 rug-pull，光是 2021 年，各種 rug-pull 騙局就從投資者那裡騙取了價值超過28億美元的加密貨幣。
但如果 LP 代幣是鎖倉在代幣鎖合約中，在鎖倉期結束前，專案方無法撤出流動性池，也沒辦法 rug pull。因此代幣鎖可以防止專案方過早跑路（要小心鎖倉期滿跑路的情況）。
## 代幣鎖合約
下面是一個鎖倉 ERC20 代幣的合約 TokenLocker：
1. 開發者在部署合約時規定鎖倉的時間，受益人地址，以及代幣合約。
2. 開發者將代幣轉入TokenLocker合約。
3. 在鎖倉期滿時，受益人可以取走合約裡的代幣。
```
contract TokenLocker {
    // 事件
    event TokenLockStart(address indexed beneficiary, address indexed token, uint256 startTime, uint256 lockTime); // 鎖倉開始事件，在合約部署時釋放，記錄受益人地址，代幣地址，鎖倉起始時間，和結束時間。
    event Release(address indexed beneficiary, address indexed token, uint256 releaseTime, uint256 amount); // 代幣釋放事件，在受益人取出代幣時釋放，記錄記錄受益人地址，代幣地址，釋放代幣時間，和代幣數量。
    
    // 狀態變數
    IERC20 public immutable token; // 被鎖倉的ERC20代幣合約
    address public immutable beneficiary; // 受益人地址
    uint256 public immutable lockTime; // 鎖倉時間(秒)
    uint256 public immutable startTime; // 鎖倉起始時間戳(秒)
    
    // 函數
    /**
     * @dev 初始化代幣合約，受益人地址，以及鎖倉時間
     * @param token_: 被鎖倉的 ERC20 代幣合約
     * @param beneficiary_: 受益人地址
     * @param lockTime_: 鎖倉時間(秒)
     */
    constructor(
        IERC20 token_,
        address beneficiary_,
        uint256 lockTime_
    ) {
        require(lockTime_ > 0, "TokenLock: lock time should greater than 0");
        token = token_;
        beneficiary = beneficiary_;
        lockTime = lockTime_;
        startTime = block.timestamp;

        emit TokenLockStart(beneficiary_, address(token_), block.timestamp, lockTime_);
    }

    /**
     * @dev 在鎖倉時間過後，將代幣釋放給受益人。
     * 需要受益人主動調用release()函數提取代幣
     */
    function release() public {
        require(block.timestamp >= startTime+lockTime, "TokenLock: current time is before release time");

        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");

        token.transfer(beneficiary, amount);

        emit Release(msg.sender, address(token), block.timestamp, amount);
    }
}
```

### 2024.10.15
# 時間鎖
時間鎖（Timelock）是銀行金庫和其他高安全性容器中常見的鎖定機制。它是一種計時器，目的是為了防止保險箱在預設時間之前被打開，即使開鎖的人知道正確密碼。
區塊鏈中，時間鎖被 DeFi 和 DAO 大量採用。它是一段程式碼，可以將智能合約的某些功能鎖定一段時間，可以大大改善智能合約的安全性：假如有一個駭客駭了 Uniswap 的多簽，準備提走金庫的錢，但金庫合約加了 2 天鎖定期的時間鎖，那麼駭客從創建提錢的交易，到實際把錢提走，需要 2 天的等待期。在這段時間，專案方可以找應對辦法，投資人可以提前拋售代幣減少損失。
## 時間鎖合約
範例的時間合約程式碼由 Compound 的 [Timelock 合約](https://github.com/compound-finance/compound-protocol/blob/master/contracts/Timelock.sol) 簡化而來。
在建立 Timelock 合約時，專案方可以設定鎖定期，並把合約的管理員設為自己，時間鎖主要有三個功能：
1. 建立交易，並加入到時間鎖佇列。
2. 在交易的鎖定期滿後，執行交易。
3. 若後悔了，取消時間鎖定佇列中的某些交易。
專案方一般會把時間鎖合約設為重要合約的管理員，例如金庫合約，再透過時間鎖操作他們。時間鎖合約的管理員一般為專案的多簽錢包，以保證去中心化。
```
contract Timelock{
    // 事件
    // 交易取消事件
    event CancelTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    // 交易執行事件
    event ExecuteTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    // 交易建立並進入佇列事件
    event QueueTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature, bytes data, uint executeTime);
    // 修改管理員地址的事件
    event NewAdmin(address indexed newAdmin);
    
    // 狀態變數
    address public admin; // 管理員地址
    uint public constant GRACE_PERIOD = 7 days; // 交易有效期限，過期的交易作廢
    uint public delay; // 交易鎖定時間 （秒）
    mapping (bytes32 => bool) public queuedTransactions; // 進入時間鎖佇列交易的識別碼txHash到bool的映射，記錄所有在時間鎖佇列中的交易。
}
    
    // 修飾器
    /** @dev onlyOwner modifier
     * 被修飾的函數只能由管理員執行。
     */
    modifier onlyOwner() {
        require(msg.sender == admin, "Timelock: Caller not admin");
        _;
    }

    /** onlyTimelock modifier
     * 被修飾的函數只能被時間鎖合約執行。 
     */
    modifier onlyTimelock() {
        require(msg.sender == address(this), "Timelock: Caller not Timelock");
        _;
    }
    
    // 函數
    /**
     * @dev 建構子：初始化交易鎖定時間（秒）和管理員位址。
     */
    constructor(uint delay_) {
        delay = delay_;
        admin = msg.sender;
    }

    /**
     * @dev 修改管理員地址，只能被Timelock合約呼叫。
     */
    function changeAdmin(address newAdmin) public onlyTimelock {
        admin = newAdmin;

        emit NewAdmin(newAdmin);
    }

    /**
     * @dev 立交易並新增到時間鎖佇列中。參數比較複雜，因為要描述一個完整的交易：
     * @param target: 目標合約地址
     * @param value: 發送ETH數額
     * @param signature: 要呼叫的函數簽名（function signature）
     * @param data: 交易的call data，裡面是一些參數
     * @param executeTime: 交易執行的區塊鏈時間戳記。
     *
     * 要求：executeTime 大於目前區塊鏈時間戳+delay。進入佇列的交易會更新在queuedTransactions變數中，並釋放QueueTransaction事件。
     */
    function queueTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner returns (bytes32) {
        // 檢查：交易執行時間滿足鎖定時間
        require(executeTime >= getBlockTimestamp() + delay, "Timelock::queueTransaction: Estimated execution block must satisfy delay.");
        // 計算交易的唯一識別符：所有參數的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 將交易新增至佇列
        queuedTransactions[txHash] = true;

        emit QueueTransaction(txHash, target, value, signature, data, executeTime);
        return txHash;
    }

    /**
     * @dev 取消特定交易。參數與queueTransaction()相同。
     *
     * 要求：被取消的交易在佇列中，會更新queuedTransactions並釋放CancelTransaction事件。
     */
    function cancelTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner{
        // 計算交易的唯一識別符：所有參數的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 檢查：交易在時間鎖佇列中
        require(queuedTransactions[txHash], "Timelock::cancelTransaction: Transaction hasn't been queued.");
        // 將交易移出隊列
        queuedTransactions[txHash] = false;

        emit CancelTransaction(txHash, target, value, signature, data, executeTime);
    }

    /**
     * @dev 執行特定交易。參數與queueTransaction()相同。
     *
     * 要求：
     * 1. 交易在時間鎖佇列中
     * 2. 達到交易的執行時間
     * 3. 交易沒過期
     * 執行交易時用到了solidity的低階成員函數call。
     */
    function executeTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public payable onlyOwner returns (bytes memory) {
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 檢查：交易是否在時間鎖佇列中
        require(queuedTransactions[txHash], "Timelock::executeTransaction: Transaction hasn't been queued.");
        // 檢查：達到交易的執行時間
        require(getBlockTimestamp() >= executeTime, "Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
        // 檢查：交易沒過期
       require(getBlockTimestamp() <= executeTime + GRACE_PERIOD, "Timelock::executeTransaction: Transaction is stale.");
        // 將交易移出佇列
        queuedTransactions[txHash] = false;

        // 取得call data
        bytes memory callData;
        if (bytes(signature).length == 0) {
            callData = data;
        } else {
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
        }
        // 利用call執行交易
        (bool success, bytes memory returnData) = target.call{value: value}(callData);
        require(success, "Timelock::executeTransaction: Transaction execution reverted.");

        emit ExecuteTransaction(txHash, target, value, signature, data, executeTime);

        return returnData;
    }

    /**
     * @dev 取得當前區塊鏈時間戳
     */
    function getBlockTimestamp() public view returns (uint) {
        return block.timestamp;
    }

    /**
     * @dev 傳回交易的標識符，為很多交易參數的hash。
     */
    function getTxHash(
        address target,
        uint value,
        string memory signature,
        bytes memory data,
        uint executeTime
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(target, value, signature, data, executeTime));
    }
```
# 代理合約
Solidity合約部署在鏈上之後，程式碼是不可變的（immutable）。這樣既有優點，也有缺點：
* 優點：使用者大部分時候知道會發生什麼，安全性較高。
* 缺點：就算合約中存在bug，也不能修改或升級，只能部署新合約。但是新合約的地址與舊的不一樣，且合約的資料也需要花費大量 gas 進行遷移。
## 代理模式
透過代理模式就可以在合約部署後進行修改或升級，代理模式將合約資料和邏輯分開，分別保存在不同合約中。
![](https://i.imgur.com/pdY13St.png)
![](https://i.imgur.com/IaMLhH8.png)
上圖是簡單的代理合約示意圖，可以對照 delegatecall 的用法，把資料（狀態變數）儲存在代理合約中，而邏輯（函數）則保存在另一個邏輯合約中。代理合約（Proxy）透過 delegatecall，將函數呼叫全權委託給邏輯合約（Implementation）執行，再把最終的結果回傳給呼叫者（Caller）。
## 代理合約
下面介紹一個簡單的代理合約，它是由 OpenZeppelin 的 [Proxy 合約](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol)簡化而來。它有三個部分：
* 代理合約 Proxy
* 邏輯合約 Logic
* 呼叫範例 Caller。
它的執行邏輯：
1. 部署邏輯合約Logic。
2. 建立代理合約 Proxy，狀態變數 implementation 記錄 Logic 合約位址。
3. Proxy 合約利用 fallback 函數，將所有呼叫委託給 Logic 合約
4. 部署呼叫範例 Caller 合約，呼叫 Proxy 合約。
Logic 合約和 Proxy 合約的狀態變數儲存結構相同，不然delegatecall會產生意想不到的行為，有安全隱患。Proxy 合約不長，但用到了內聯彙編，因此比較難理解。它只有一個狀態變數，一個建構子，和一個回調函數。狀態變數 implementation，在建構子中初始化，用來保存 Logic 合約位址。
```
contract Proxy {
    address public implementation; // 邏輯合約地址。 implementation合約同一個位置的狀態變數型別必須和Proxy合約的相同，不然會報錯。

    /**
     * @dev 初始化邏輯合約地址
     */
    constructor(address implementation_){
        implementation = implementation_;
    }
    
    /**
    * @dev 回傳函數，將外部對本合約的呼叫委託給 Logic 合約。
    * 利用行內組語（inline assembly）讓本來不能有回傳值的fallback函數有了回傳值
    */
    fallback() external payable {
        address _implementation = implementation;
        assembly {
            // 將msg.data複製到記憶體裡
            // calldatacopy操作碼的參數: 記憶體起始位置，calldata起始位置，calldata長度
            calldatacopy(0, 0, calldatasize())

            // 利用delegatecall調用implementation合約
            // delegatecall操作碼的參數：gas, 目標合約位址，input mem起始位置，input mem長度，output area mem起始位置，output area mem長度
            // output area起始位置和長度位置，所以設為0
            // delegatecall成功返回1，失敗返回0
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // 將return data複製到記憶體
            // returndata操作碼的參數：記憶體起始位置，returndata起始位置，returndata長度
            returndatacopy(0, 0, returndatasize())

            switch result
            // 如果delegate call失敗，revert
            case 0 {
                revert(0, returndatasize())
            }
            // 如果delegate call成功，回傳mem起始位置為0，長度為returndatasize()的資料（格式為bytes）
            default {
                return(0, returndatasize())
            }
        }
    }
```
## 邏輯合約
```
/**
 * @dev 邏輯合約，執行被委託的呼叫
 */
contract Logic {
    address public implementation; // 佔位變數，與Proxy合約保持一致，專門用來存放代理相關的訊息，防止插槽衝突。
    uint public x = 99; 
    event CallSuccess(); // 在呼叫成功時釋放

    // 會被Proxy合約調用，釋放CallSuccess事件，並回傳一個uint
    // 函數selector: 0xd09de08a
    function increment() external returns(uint) {
        emit CallSuccess();
        return x + 1;
    }
}
```
如果直接呼叫 increment() 會返回 100，但透過 Proxy 呼叫它會回傳 1，因為 delegatecall 會在 Proxy 合約的上下文中執行 Logic 合約的程式碼，導致 Logic 合約的狀態變數將會讀取和修改 Proxy 合約的存儲，所以 x 的值不再是來自 Logic 合約的存儲，而是 Proxy 合約的存儲。
## 呼叫者合約 Caller
```
/**
 * @dev Caller合約，呼叫代理合約，並取得執行結果
 */
contract Caller{
    address public proxy; // 代理合約地址

    // 建構子，在部署合約時初始化proxy變數
    constructor(address proxy_){
        proxy = proxy_;
    }

    /** 透過代理合約呼叫increment()函數
     * 利用call來呼叫代理合約的increment()函數，並傳回一個uint。
     * 在呼叫時，我們利用abi.encodeWithSignature()取得了increment()函數的selector。
     * 在回傳時，利用abi.decode()將回傳值解碼為uint類型。
     */
    function increment() external returns(uint) {
        ( , bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
        return abi.decode(data,(uint));
    }
}
```
# 可升級合約
可升級合約就是一個可以更改邏輯合約的代理合約。
下面是一個實作範例，包含：
* 代理合約
* 舊邏輯合約
* 新邏輯合約
## 代理合約
這個代理合約比較簡單，沒有在它的 fallback() 函數中使用行內組語，只用了 implementation.delegatecall(msg.data)，所以 fallback 函數沒有回傳值，生產環境中不宜這樣用。
```
// SPDX-License-Identifier: MIT
// wtf.academy
pragma solidity ^0.8.21;

// 簡單的可升級合約，管理員可以透過升級函數來變更邏輯合約位址，從而改變合約的邏輯
contract SimpleUpgrade {
    address public implementation; // 邏輯合約地址
    address public admin; // admin地址
    string public words; // 字串，可以透過邏輯合約的函數來改變

    // 建構子，初始化admin和邏輯合約位址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函數，將呼叫委託給邏輯合約
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升級函數，改變邏輯合約位址，只能由admin呼叫
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
```
## 舊邏輯合約
這個邏輯合約包含 3 個狀態變數，與代理合約保持一致，防止插槽衝突。它只有一個函數 foo()，負責將代理合約中的 words 的值改為 "old"。
```
// 舊邏輯合約
contract Logic1 {
    // 狀態變數需和proxy合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變數，選擇器： 0xc2985578
    function foo() public{
        words = "old";
    }
}
```
## 新邏輯合約
這個邏輯合約包含 3 個狀態變數，與代理合約保持一致，防止插槽衝突。它只有一個函數 foo()，負責將代理合約中的 words 的值改為 "new"。
```
// 新邏輯合約
contract Logic2 {
    // 狀態變數需和proxy合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變數，選擇器： 0xc2985578
    function foo() public{
        words = "new";
    }
}
```
### 2024.10.16
# 透明代理
透明代理（Transparent Proxy）用於解決代理合約的選擇器衝突（Selector Clash），教學程式碼由 OpenZeppelin 的 TransparentUpgradeableProxy 簡化而來，不應用於生產環境。
## 選擇器衝突
在智能合約中，函數選擇器（selector）是函數簽署的雜湊的前4個位元組。例如 mint(address account) 的選擇器為 bytes4(keccak256("mint(address)"))，也就是0x6a627842。
由於函數選擇器只有4個位元組，範圍很小，因此兩個不同的函數可能會有相同的選擇器：
```
// 選擇器衝突的例子
contract Foo {
    function burn(uint256) external {}
    function collate_propagate_storage(bytes16) external {}
}
```
上面兩個函數的選擇器都是 0x42966c68，EVM 無法透過函數選擇器分辨使用者呼叫哪個函數，因此該合約無法通過編譯。

由於代理合約和邏輯合約是兩個合約，就算他們之間存在「選擇器衝突」也可以正常編譯，這可能會導致很嚴重的安全事故。舉個例子，如果邏輯合約的 a 函數和代理合約的升級函數的選擇器相同，那麼管理人就會在呼叫 a 函數的時候，將代理合約升級成一個黑洞合約，造成巨大損失。

目前，有兩個可升級合約標準解決了這個問題：透明代理 Transparent Proxy 和通用可升級代理 UUPS。

透明代理的邏輯非常簡單：管理員可能會因為「函數選擇器衝突」，在呼叫邏輯合約的函數時，誤呼叫成代理合約的可升級函數。所以透明代理的概念是限制管理員的權限，不讓他呼叫任何邏輯合約的函數，就能解決衝突：
* 管理員變成工具人，僅能呼叫代理合約的可升級函數對合約升級，不能透過 fallback 函數呼叫邏輯合約。
* 其它使用者不能呼叫可升級函數，但是可以呼叫邏輯合約的函數。
### 透明代理的代理合約
fallback() 函數限制了管理員地址的呼叫:
```
contract TransparentProxy {
    address implementation; // logic合約地址
    address admin; // 管理員
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 建構函數，初始化admin和邏輯合約位址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函數，將呼叫委託給邏輯合約
    // 不能被admin調用，避免選擇器衝突引發意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升級函數，改變邏輯合約位址，只能由admin調用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}
```
### 透明代理的邏輯合約
邏輯合約包含3個狀態變量，與保持代理合約一致，防止插槽衝突；包含一個函數foo()，舊邏輯合約會將words的值改為"old"，新的會改為"new"。
```
// 舊邏輯合約
contract Logic1 {
    // 狀態變數和proxy合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變數，選擇器： 0xc2985578
    function foo() public{
        words = "old";
    }
}

// 新邏輯合約
contract Logic2 {
    // 狀態變數和proxy合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; //  字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變數，選擇器： 0xc2985578
    function foo() public{
        words = "new";
    }
}
```
透明代理的邏輯簡單，透過限制管理員呼叫邏輯合約解決「選擇器衝突」問題。它也有缺點，每次使用者呼叫函數時，都會多一步是否為管理員的檢查，消耗更多gas。但瑕不掩瑜，透明代理商仍是多數專案方選擇的方案。
# UUPS
通用可升級代理標準（UUPS，universal upgradeable proxy standard）是選擇器衝突（Selector Clash）的另一個解決辦法，UUPS 將升級函數放在邏輯合約中，如果有其它函數與升級函數存在選擇器衝突，編譯時就會報錯。
### 普通可升級代理、透明代理、UUPS 比較
| 標準 | 升級函數位置 | 是否會選擇器衝突 | 缺點 |
|---|---|---|---|
| 可升級代理 | Proxy 合約 | Yes | 選擇器衝突 |
| 透明代理 | Proxy 合約 | No | 較耗 gas |
| UUPS | Logic 合約 | No | 較複雜 |

## UUPS 合約
![](https://i.imgur.com/pdY13St.png)
如果使用者 A 透過合約 B（代理合約）去 delegatecall 合約C（邏輯合約），上下文仍是合約 B 的上下文， msg.sender 仍是使用者 A 而不是合約 B。因此，UUPS 合約可以將升級函數放在邏輯合約中，並**檢查呼叫者是否為管理員**。

### UUPS 的代理合約
UUPS 的代理合約看起來像是個不可升級的代理合約，因為升級函數被放在了邏輯合約中。
```
contract UUPSProxy {
    address implementation; // logic合約地址
    address admin; // 管理員
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 建構函數，初始化admin和邏輯合約位址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函數，將呼叫委託給邏輯合約
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }
}
```
### UUPS 的邏輯合約
UUPS 的邏輯合約多了個升級函數。狀態變量與保持代理合約一致以防插槽衝突。
```
// UUPS邏輯合約（升級函數寫在邏輯合約內）
contract UUPS1{
    // 狀態變數和 proxy 合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變數，選擇器： 0xc2985578
    function foo() public{
        words = "old";
    }

    // 升級函數，改變邏輯合約位址，只能由admin呼叫。選擇器：0x0900f010
    // UUPS中，邏輯合約中必須包含升級函數，不然就不能再升級了。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}

// 新的UUPS邏輯合約
contract UUPS2{
    // 狀態變數和proxy合約一致，防止插槽衝突
    address public implementation; 
    address public admin; 
    string public words; // 字串，可以透過邏輯合約的函數改變

    // 改變proxy中狀態變量，選擇器： 0xc2985578
    function foo() public{
        words = "new";
    }

    // 升級函數，改變邏輯合約位址，只能由 admin 呼叫。選擇器：0x0900f010
    // UUPS 中，邏輯合約中必須包含升級函數，不然就不能再升級了。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
```
# 多簽錢包
多簽錢包是一種電子錢包，特點是交易被多個私鑰持有者（多簽人）授權後才能執行：例如錢包由 3 個多簽案人管理，每筆交易需要至少 2 人簽章授權。多簽錢包可以防止單點故障（私鑰遺失、單人作惡），更加去中心化，更加安全，被許多去中心化自治組織採用。
Gnosis Safe 多簽錢包是以太坊最受歡迎的多簽錢包，管理近 400 億美元資產，合約經過審計和實戰測試，支援多鏈（以太坊、BSC、Polygon 等），並提供豐富的 DAPP 支援。
## 多簽錢包合約
以太坊上的多簽錢包其實是智能合約，屬於合約錢包。下面是一個極簡版的多簽錢包 MultisigWallet 合約：
1. 設定多簽人和門檻（鏈上）：部署多簽合約時，我們需要初始化多簽人清單和執行門檻（至少n個多簽人簽名授權後，交易才能執行）。
2. 創建交易（鏈下）：一筆待授權的交易包含以下內容
    * to：目標合約。
    * value：交易發送的以太坊數量。
    * data：calldata，包含呼叫函數的選擇器和參數。
    * nonce：初始為0，隨著多簽合約每筆成功執行的交易遞增的值，可以防止簽章重播攻擊。
    * chainid：鏈id，防止不同鏈的簽章重播攻擊。
3. 收集多簽簽名（鏈下）：將上一步驟的交易 ABI 編碼並計算 hash，得到交易 hash，然後讓多簽人簽名，並拼接到打包簽名。
    ```
    交易哈希: 0xc1b055cf8e78338db21407b425114a2e258b0318879327945b661bfdea570e66

    多簽人A簽名: 0x014db45aa753fefeca3f99c2cb38435977ebb954f779c2b6af6f6365ba4188df542031ace9bdc53c655ad2d4794667ec2495196da94204c56b1293d0fbfacbb11c
    
    多簽人B簽名: 0xbe2e0e6de5574b7f65cad1b7062be95e7d73fe37dd8e888cef5eb12e964ddc597395fa48df1219e7f74f48d86957f545d0fbce4eee1adfbaff6c267046ade0d81c
    
    打包簽名：
    0x014db45aa753fefeca3f99c2cb38435977ebb954f779c2b6af6f6365ba4188df542031ace9bdc53c655ad2d4794667ec2495196da94204c56b1293d0fbfacbb11cbe2e0e6de5574b7f65cad1b7062be95e7d73fe37dd8e888cef5eb12e964ddc597395fa48df1219e7f74f48d86957f545d0fbce4eee1adfbaff6c267046ade0d81c
    ```
4. 呼叫多簽合約的執行函數，驗證簽名並執行交易（鏈上）。
```
// SPDX-License-Identifier: MIT
// author: @0xAA_Science from wtf.academy
pragma solidity ^0.8.21;

/// 基於簽名的多簽錢包，由gnosis safe合約簡化而來，教學使用。
contract MultisigWallet {
    event ExecutionSuccess(bytes32 txHash);    // 交易成功事件，交易成功則釋放交易哈希
    event ExecutionFailure(bytes32 txHash);    // 交易失敗事件，交易失敗則釋放交易哈希
    address[] public owners;                   // 多簽持有人陣列
    mapping(address => bool) public isOwner;   // 記錄一個地址是否為多簽持有人
    uint256 public ownerCount;                 // 多簽持有人數量
    uint256 public threshold;                  // 多簽執行門檻，交易至少有n個多簽人簽名才能被執行
    uint256 public nonce;                      // nonce，隨著多簽合約每筆成功執行的交易遞增的值，防止簽章重播攻擊

    receive() external payable {}

    // 建構子，初始化owners、isOwner、ownerCount、threshold，初始化和多簽持有人和執行門檻相關的變數
    constructor(        
        address[] memory _owners,
        uint256 _threshold
    ) {
        _setupOwners(_owners, _threshold);
    }

    /// @dev 初始化owners、isOwner、ownerCount、threshold，在合約部署時被建構函數調用，初始化owners，isOwner，ownerCount，threshold狀態變數。傳入的參數中，執行門檻需大於等於1且小於等於多簽人數；多簽地址不能為0地址且不能重複。
    /// @param _owners: 多簽持有人陣列
    /// @param _threshold: 多簽執行門檻，至少有幾個多簽人簽署了交易
    function _setupOwners(address[] memory _owners, uint256 _threshold) internal {
        // threshold未初始化過
        require(threshold == 0, "WTF5000");
        // 多簽執行門檻 小於 多簽人數
        require(_threshold <= _owners.length, "WTF5001");
        // 多簽執行門檻至少為1
        require(_threshold >= 1, "WTF5002");

        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            // 多簽人不能為0地址、本合約地址，不能重複
            require(owner != address(0) && owner != address(this) && !isOwner[owner], "WTF5003");
            owners.push(owner);
            isOwner[owner] = true;
        }
        ownerCount = _owners.length;
        threshold = _threshold;
    }

    /// @dev 收集足夠的多簽簽名後，驗證簽名並執行交易
    /// @param to 目標合約地址
    /// @param value msg.value，支付的以太坊數額
    /// @param data calldata資料
    /// @param signatures 打包的簽名，打包到一個[bytes]資料中，對應的多簽地址由小到大，以便檢查。 ({bytes32 r}{bytes32 s}{uint8 v}) (第一個多簽的簽名, 第二個多簽的簽名 ... )
    function execTransaction(
        address to,
        uint256 value,
        bytes memory data,
        bytes memory signatures
    ) public payable virtual returns (bool success) {
        // 編碼交易資料，計算哈希
        bytes32 txHash = encodeTransactionData(to, value, data, nonce, block.chainid);
        nonce++;  // 增加nonce
        checkSignatures(txHash, signatures); // 檢查簽名是否有效、數量是否達到執行門檻
        // 利用call執行交易，並取得交易結果
        (success, ) = to.call{value: value}(data);
        require(success , "WTF5004");
        if (success) emit ExecutionSuccess(txHash);
        else emit ExecutionFailure(txHash);
    }

    /**
     * @dev 檢查簽名和交易資料的哈希是否對應，數量是否達到門檻。如果是無效簽名，交易會revert。單一簽章長度為 65 byte，因此打包簽章的長度要大於 threshold * 65
     * @param dataHash 交易資料哈希
     * @param signatures 幾個多簽簽名打包在一起
     */
    function checkSignatures(
        bytes32 dataHash,
        bytes memory signatures
    ) public view {
        // 讀取多簽執行門檻
        uint256 _threshold = threshold;
        require(_threshold > 0, "WTF5005");

        // 檢查簽名長度夠長
        require(signatures.length >= _threshold * 65, "WTF5006");

        //透過一個循環，檢查收集的簽名是否有效
        // 大概思路：
        // 1. 用ecdsa先驗證簽名是否有效
        // 2. 利用 currentOwner > lastOwner 確定簽章來自不同多簽（多簽地址遞增）
        // 3. 利用 isOwner[currentOwner] 確定簽名者為多簽持有人
        address lastOwner = address(0); 
        address currentOwner;
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 i;
        for (i = 0; i < _threshold; i++) {
            (v, r, s) = signatureSplit(signatures, i); // 呼叫 signatureSplit() 分離出單一簽章。
            // 利用ecrecover檢查簽名是否有效
            currentOwner = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", dataHash)), v, r, s);
            require(currentOwner > lastOwner && isOwner[currentOwner], "WTF5007");
            lastOwner = currentOwner;
        }
    }
    
    /// 將單一簽名從打包的簽名中分離出來
    /// @param signatures 打包的多簽
    /// @param pos 要讀取的簽章位置index.
    /// 利用了行內組語，將簽名的r、s和 v三個值分開出來。
    function signatureSplit(bytes memory signatures, uint256 pos)
        internal
        pure
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        // 簽名的格式：{bytes32 r}{bytes32 s}{uint8 v}
        assembly {
            let signaturePos := mul(0x41, pos)
            r := mload(add(signatures, add(signaturePos, 0x20)))
            s := mload(add(signatures, add(signaturePos, 0x40)))
            v := and(mload(add(signatures, add(signaturePos, 0x41))), 0xff)
        }
    }

    /// @dev 交易資料編碼，將交易資料打包併計算哈希
    /// @param to 目標合約地址
    /// @param value msg.value，支付的以太坊
    /// @param data calldata
    /// @param _nonce 交易的nonce.
    /// @param chainid 鏈id
    /// @return 交易哈希bytes.
    function encodeTransactionData(
        address to,
        uint256 value,
        bytes memory data,
        uint256 _nonce,
        uint256 chainid
    ) public pure returns (bytes32) {
        bytes32 safeTxHash =
            keccak256(
                abi.encode(
                    to,
                    value,
                    keccak256(data),
                    _nonce,
                    chainid
                )
            );
        return safeTxHash;
    }
}
```
<!-- Content_END -->
