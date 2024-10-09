---
timezone: Asia/Taipei
---

# Mud-Yun

1. 我是Mud-Yun，對程式設計有興趣，尤其是在區塊鏈技術領域。基於這份熱忱，我決定將Solidity作為我將要精通的首選程式語言。Solidity不僅是智能合約開發的核心語言，也是進入以太坊等區塊鏈平台不可或缺的技能。我期待通過深入學習Solidity，能夠在這個快速發展的領域中，創造出具有影響力的應用。

2. 參與殘酷共學是一個挑戰，但也是一次成長和學習的機會。這個過程可能會很艱難，但只要堅持下去，就能從中獲得寶貴的經驗。在這個過程中，不僅能學到新知識，還能提升解決問題的能力。所以，即使是第一次參與，我也保持積極的態度，相信自己能夠完成這個挑戰。
   
## Notes

<!-- Content_START -->
### 2024.09.23
![1](https://github.com/user-attachments/assets/1019707a-2710-4d1d-a1e2-0b07c68db484)

要註解版權聲明，不然會有警告。

"pragma solidity ^0.8.21;"代表只可以使用0.8.21以上，0.9.0之下的編譯器做編譯。

我在HelloWeb3合約中定義了一個字串變量"_String"，data為"Hello Web3"，並將其定義為public。

由於將其定義為public，在編譯該合約後會自動生成一個與該變量同名的getter()，可以看到我在部屬合約後，左下角有一個藍色框框(唯讀)，點下去就可以看見該變量中的data：Hello Web3。


### 2024.09.24

在Solidity程式語言中，變數分為三種主要類型：值類型、引用類型和映射類型。本文將專注於介紹最常用的值類型。

值類型是指那些直接存儲數據值的變數，例如整數。Solidity提供了多種整數類型，其中`uint256`是一個常用的無符號整數類型，適合存儲大數據。例如：

```solidity
uint256 public largeNum = 123456789;
```

在Solidity中，我們可以對這些值進行各種運算，包括基本的算術運算（加`+`、減`-`、乘`*`、除`/`、取餘數`%`、指數`**`）和比較運算（小於`<`、小於等於`<=`、等於`==`、不等於`!=`、大於等於`>=`、大於`>`）。以下是一些例子：

```solidity
uint256 public result = largeNum + 1;  // 加法運算
uint256 public exp = 2 ** 3;           // 指數運算，計算2的三次方
uint256 public remainder = 7 % 2;      // 取餘數運算
```

地址類型（Address）是Solidity中用於存儲以太坊地址的特殊類型。它分為兩種：

- 普通地址（`address`）：僅用於存儲地址。
- 可支付地址（`address payable`）：除了存儲地址外，還可以接收以太幣。

以下是如何聲明和使用這些地址類型的例子：

```solidity
address public wallet = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public payableWallet = payable(wallet);  // 將普通地址轉換為可支付地址
uint256 public balance = payableWallet.balance;          // 查詢地址的餘額
```

定長字節數組（Fixed-size Byte Array）是另一種在Solidity中存儲字節數據的方式。它們的長度是固定的，一旦聲明就無法更改。例如，`bytes32`可以存儲最多32個字節的數據。這裡有一個例子：

```solidity
bytes32 public data = "Solidity";      // 儲存固定長度的字串
bytes1 public firstByte = data[0];     // 取出數組中的第一個字節
```

最後，枚舉（Enum）是一種特殊的數據類型，用於定義一組命名的常量。在Solidity中，枚舉可以使程式碼更加清晰和易於維護。例如，我們可以定義一個代表交易訂單狀態的枚舉：

```solidity
enum Order { Buy, Hold, Sell }
Order public currentOrder = Order.Buy;  // 設置當前訂單狀態為「買入」
```

枚舉值可以轉換為整數，這在某些情況下非常有用：

```solidity
function getOrderValue() public view returns(uint) {
    return uint(currentOrder);  // 將枚舉值轉換為對應的整數
}
```

通過以上介紹，我們可以看到Solidity提供了豐富的變數類型來滿足智能合約開發的需求。每種類型都有其特定的用途和操作方式，為以太坊上的去中心化應用提供了強大的支持。

### 2024.09.25

Solidity 函數的靈活性允許執行多種複雜操作。

1. 基本結構

function <函數名稱>(<參數類型>) {internal|external|public|private} [pure|view|payable] [returns (<回傳類型>)]

function：用於宣告函數的關鍵字。

<函數名稱>：指定的函數名稱。

<參數類型>：定義函數參數的類型和名稱。

{internal|external|public|private}：定義函數的可見性範圍：

public：可在合約內外部訪問。

private：僅限於合約內部使用，繼承合約無法訪問。

external：僅限外部調用，但可透過 this.f() 在合約內部調用。

internal：僅限合約內部及繼承合約使用。

[pure|view|payable]：指定函數的行為修飾符：

pure：不可讀取或修改合約狀態。

view：僅可讀取合約狀態，不可修改。

payable：函數可接收 ETH。

2. Pure 與 View 的差異

這兩個修飾符的使用旨在節約 Gas 費用，當函數不更改鏈上狀態時，無需支付 Gas。

pure：不可讀取或更改鏈上狀態變數。

view：可讀取但不可更改狀態變數。

示例：

uint256 public number = 5;

// pure 函數，不讀取或更改鏈上狀態

function addPure(uint256 _number) external pure returns (uint256 new_number) {
    new_number = _number + 1;
}

// view 函數，讀取但不更改鏈上狀態

### 2024.09.26


在Solidity程式語言中，函數返回值的處理涉及兩個關鍵字：return和returns。它們的使用區別如下：

- returns：位於函數宣告部分，用於指定函數將返回的數據類型和變數名稱。
- return：位於函數的執行主體中，用於返回具體的變數值。

例如，我們可以創建一個函數來返回多個值，如下所示：

```solidity
function returnMultiple() public pure returns (uint256, bool, uint256[3] memory) {
    return (1, true, [uint256(1), 2, 5]);
}
```

在此程式碼片段中，我們通過returns關鍵字宣告了函數returnMultiple將返回多個值，並在函數主體中使用return關鍵字來指定這些返回值。特別是，uint256[3]指定了一個包含三個元素的uint256型別數組作為返回值，並使用memory關鍵字進行標註，這是因為在Solidity中，返回數組類型的數據時，預設需要這樣的標註。

另外，Solidity允許在returns關鍵字中直接命名返回變數，這樣Solidity會自動初始化這些變數並在函數結束時自動返回它們的值，無需顯式使用return關鍵字。例如：

```solidity
function returnNamed() public pure returns (uint256 _number, bool _bool, uint256[3] memory _array) {
    _number = 2;
    _bool = false;
    _array = [uint256(3), 2, 1];
}
```

在上述程式碼中，我們通過returns關鍵字宣告了返回變數的類型和名稱，因此只需在函數主體中為這些變數賦值，它們的值就會在函數結束時自動返回。當然，即使在命名式返回中，我們也可以選擇使用return關鍵字來返回值。

此外，Solidity支援解構式賦值，這允許開發者從函數返回值中讀取全部或部分數據。例如，以下程式碼展示了如何讀取所有返回值：

```solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```

如果只需要部分返回值，可以選擇性地聲明所需的變數，並留空不需要的部分。例如，以下程式碼僅讀取_bool變數的值：

```solidity
(, _bool2, ) = returnNamed();
```

透過這些機制，Solidity提供了靈活且強大的方式來處理函數返回值，使得智能合約的開發更加高效和直觀。


### 2024.09.27

今天學到Solidity中的引用類型和數據位置的應用，以及變量作用域和全局變量的重要概念。以下是這些主題的總結和關鍵點：

引用類型包括數組和結構體，這些複雜的變數因其較大的存儲空間需求，在使用時需要明確指定數據存儲位置。

Solidity中的數據存儲位置分為三類：storage、memory和calldata，它們各自的gas成本有所不同。storage是用於存儲合約狀態變數的位置，這些數據被存儲在區塊鏈上，類似於電腦硬盤，因此gas消耗較高。memory則用於存儲函數的參數或臨時變數，這些數據不會被存儲在區塊鏈上，而是存儲在內存中，適用於函數內部的變長類型變數。calldata與memory相似，但它是不可變的，通常用於存儲函數參數。

在不同的數據存儲位置之間進行賦值時，可能會創建一個數據副本或引用。例如，當storage類型的變數被賦值給另一個storage類型的變數時，會創建一個引用，這意味著對新變數的修改也會影響原始變數。

Solidity提供了靈活的存儲控制機制，使開發者能夠根據需求選擇最合適的數據存儲位置，從而有效地降低gas成本。此外，對變量作用域和全局變量的理解對於智能合約的開發至關重要。這些知識點是構建高效且經濟的智能合約的基礎。


### 2024.09.30

 在Solidity程式設計中，數組和結構體是兩種關鍵的變量類型，它們在合約開發中扮演著不可或缺的角色。數組允許開發者存儲同類型的多個變量，而結構體則提供了一種方式來封裝多個不同類型的數據。

數組可以是固定長度或可變長度，並且可以在聲明時不指定長度，使用格式T[]，其中T代表元素類型。例如，uint[] array4聲明了一個可變長度的無符號整數數組。特別地，bytes類型是一個特殊情況，它代表一個動態大小的字節數組，不需要使用方括號。

創建數組時，可以使用new操作符來創建一個memory修飾的動態數組，這要求指定數組的長度，並且一旦創建，其長度就不能改變。數組的操作包括獲取其長度（length）、向數組添加元素（push()）以及移除元素（pop()）。

結構體在Solidity中用於定義新的數據類型，它可以包含多種類型的數據。例如，一個Student結構體可以包含id和score兩個字段。結構體的賦值可以通過多種方式進行，包括直接操作狀態變量、使用構造函數或key-value賦值方式。

數組和結構體的靈活運用，為Solidity合約開發提供了強大的數據處理能力，使開發者能夠更有效地處理複雜數據結構，從而開發出功能豐富且高效的智能合約。這些基本數據結構的掌握，對於任何希望精進其區塊鏈開發技能的人來說非常重要。

### 2024.10.01

映射是一種在Solidity中用於儲存鍵值對的數據結構，類似於其他編程語言中的哈希表。在映射中，我們可以通過鍵來查詢對應的值。映射的聲明格式為mapping(_KeyType => _ValueType)，其中_KeyType是鍵的類型，而_ValueType是值的類型。

例如，我們可以有一個將ID映射到地址的映射，或者一個將一個地址映射到另一個地址的交易對映射。映射的鍵必須是Solidity支持的內建值類型，如uint或address，而值可以是任何類型，包括自定義的結構體。然而，如果我們嘗試將自定義結構體作為鍵，這將會導致錯誤。

映射必須儲存在storage中，這意味著它們通常作為合約的狀態變量或在函數內部的storage變量使用。映射不能作為公共函數的參數或返回值。當映射被聲明為public時，Solidity會自動生成一個getter函數，允許通過鍵來查詢值。

要向映射中新增鍵值對，我們可以使用_Var[_Key] = _Value的語法。映射的工作原理是不存儲鍵本身的資訊，並且沒有方法來直接查詢鍵的數量。映射通過計算keccak256(abi.encodePacked(key, slot))來存取值，其中slot是映射變量的存儲位置。如果查詢一個未賦值的鍵，映射將返回該類型的默認值。

映射是Solidity中一種非常有用的數據結構，適合於需要快速查找的情境。理解映射的工作原理和限制，特別是在鍵的使用和存儲位置方面，對於有效地使用映射至關重要。這些規則和原理確保了映射在智能合約中的高效和安全性。


### 2024.10.02

在本講中，我們將探討Solidity中變數的初始值，以及如何利用delete運算子將變數重置為其初始值。當變數被宣告但尚未賦值時，它們會根據變數類型自動獲得一個初始值。

值類型變數的初始值如下：
- boolean: false
- string: 空字串("")
- int: 0
- uint: 0
- enum: 枚舉的第一個元素
- address: 0x0000000000000000000000000000000000000000 或 address(0)
- function: 
  - internal: 空白函數
  - external: 空白函數

您可以透過public變數的getter函數來驗證這些初始值。例如：

```solidity
// 驗證值類型變數的初始值
bool public _bool;          // false
string public _string;      // 空字串("")
int public _int;            // 0
uint public _uint;          // 0
address public _address;    // 0x0000000000000000000000000000000000000000

// 枚舉
enum ActionSet { Buy, Hold, Sell }
ActionSet public _enum;     // 默認為Buy，索引為0

// 函數
function fi() internal {}   // internal空白函數
function fe() external {}   // external空白函數
```

引用類型變數的初始值則與值類型不同，其元素會被設定為默認值：
- mapping: 所有元素為其類型的初始值
- struct: 所有成員為其類型的初始值
- array:
  - 動態數組: 空數組([])
  - 靜態數組: 所有成員為默認值

以下是驗證引用類型初始值的範例：

```solidity
// 驗證引用類型變數的初始值
uint[8] public _staticArray;         // [0, 0, 0, 0, 0, 0, 0, 0]
uint[] public _dynamicArray;         // 空數組([])
mapping(uint => address) public _mapping; // 所有key的value為 address(0)

// 結構體初始值
struct Student {
    uint256 id;
    uint256 score;
}
Student public student;              // { id: 0, score: 0 }
```

delete運算子可以將變數重置為其初始值。例如：

```solidity
// delete運算子範例
bool public _bool2 = true; 
function d() external {
    delete _bool2; // 將_bool2重置為false
}
```

delete運算子適用於所有類型的變數，無論是值類型還是引用類型。當應用delete時，變數將被重置為其類型的初始值。

在Remix上進行驗證：
1. 部署合約並檢查各變數的初始值。
2. 使用delete運算子，驗證變數是否被重置為默認值。

總結：
在這一講中，我們了解了Solidity中變數的初始值。變數在宣告時若未賦值，將自動獲得一個初始值，這些初始值因變數類型而異。透過delete運算子，我們能夠將變數重置為其初始值，這對於管理智能合約中的數據生命週期非常重要。


### 2024.10.03

在本節課程中，我們探討了Solidity語言中的兩個重要關鍵字：constant和immutable。這些關鍵字用於定義狀態變數，一旦初始化，就無法更改其值。這不僅增強了智能合約的安全性，還有助於減少gas消耗。

constant與immutable的主要區別在於：
- constant變數必須在宣告時就初始化，且之後不能更改。任何嘗試修改constant變數的行為都會引發編譯錯誤。這類變數適用於數值型別、字符串和字節數組等。
- immutable變數則提供了更大的靈活性，可以在宣告時或在構造函數中初始化。一旦初始化，就不能再被修改，但初始化時機可以延後至構造函數執行時。

以下是一些使用constant和immutable的例子：
```solidity
// constant變數
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

// immutable變數
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;

// 在構造函數中初始化
constructor() {
    IMMUTABLE_ADDRESS = address(this); // 將合約地址設為不可變地址
    IMMUTABLE_NUM = 1118;             // 將數值初始化為1118
    IMMUTABLE_TEST = test();          // 使用自定義函數進行初始化
}

function test() public pure returns (uint256) {
    return 9;
}
```
constant變數在宣告時必須設置初始值，且一旦設置就不能更改。若嘗試修改，將會出現錯誤提示：`TypeError: Cannot assign to a constant variable.`

而immutable變數則可以在宣告時或構造函數中設置初始值，但一旦初始化後就不能更改。若嘗試修改，將會出現錯誤提示：`TypeError: Immutable state variable already initialized.`

使用constant和immutable的優勢包括節省gas和提高安全性。由於這些變數的值是固定不變的，Solidity編譯器能夠進行優化存儲，從而節約gas。此外，通過限制變數的修改權限，可以防止不應該被更改的值被意外或惡意修改，從而提高合約的安全性。

constant和immutable是Solidity中用於定義不可變變數的關鍵字。這些變數一旦初始化就不能更改，這不僅確保了智能合約的安全性，也有助於降低gas成本。constant要求在宣告時就進行初始化，而immutable則提供了更多靈活性，允許在構造函數中初始化。


### 2024.10.04

今天將介紹Solidity中的控制流程，並透過插入排序法（Insertion Sort）的具體範例來展示如何使用Solidity實作此算法。在學習過程中，我們不僅掌握了控制流的基礎結構，還深入了解了Solidity特有的一些陷阱，尤其是處理無符號整數時可能遇到的問題。

控制流簡介：
Solidity的控制流結構與多數編程語言類似，包含以下常見的結構：

if-else條件判斷：
用於根據條件執行不同的程式碼塊。
範例：

```solidity
function ifElseTest(uint256 _number) public pure returns(bool) {
    return _number == 0 ? true : false;
}
```
for迴圈：
用於重複執行程式碼塊，直至條件不再滿足。
範例：

```solidity
function forLoopTest() public pure returns(uint256) {
    uint256 sum = 0;
    for (uint256 i = 0; i < 10; i++) {
        sum += i;
    }
    return sum;
}
```
while迴圈：
類似for迴圈，但更靈活，條件為真時持續執行。
範例：

```solidity
function whileTest() public pure returns(uint256) {
    uint256 sum = 0;
    uint256 i = 0;
    while (i < 10) {
        sum += i;
        i++;
    }
    return sum;
}
```
do-while迴圈：
至少執行一次程式碼塊，再根據條件判斷是否繼續。
範例：

```solidity
function doWhileTest() public pure returns(uint256) {
    uint256 sum = 0;
    uint256 i = 0;
    do {
        sum += i;
        i++;
    } while (i < 10);
    return sum;
}
```
三元運算符：用於簡化if-else結構，使程式碼更為簡潔。



### 2024.10.05

今天探討了Solidity語言中的構造函數和修飾器，並以Ownable合約為例，展示了如何運用這些工具進行合約權限管理。構造函數是合約初始化時執行的特殊函數，而修飾器則為函數提供了額外的邏輯層，常用於實施權限檢查。

例如，onlyOwner修飾器確保只有合約擁有者可以執行特定函數，這是通過比對發送者地址與擁有者地址來實現的。如果不成配對，交易將被撤銷。

OpenZeppelin的Ownable合約是一個標準化的實現，它封裝了基本的所有權邏輯，可以在其官方網站上找到具體的程式碼實現。

在Remix環境中，我們可以通過編譯和部署Ownable合約，並通過傳入初始擁有者地址來測試其功能。你可以使用owner函數來驗證當前的擁有者地址，並嘗試使用changeOwner函數來更改擁有者。只有當前擁有者才能成功執行此操作，任何非擁有者地址的嘗試都會因onlyOwner修飾器而失敗。

如何在Solidity合約中使用構造函數和修飾器進行有效的權限管理，這對於編寫安全且可控的智能合約至關重要。


### 2024.10.06

在這篇文章中，我們將探討Solidity中的事件（Event）概念，並以ERC20代幣的轉帳為例來說明如何宣告和釋放事件，以及這些事件如何在以太坊虛擬機（EVM）的日誌中被記錄和運作。

事件是EVM記錄日誌的一種機制，它具有以下特性：

- 響應性：前端應用可以透過RPC接口訂閱和監聽事件，一旦事件被觸發，前端可以進行相應的反應。
- 經濟性：與直接在區塊鏈上存儲數據相比，事件是一種更為經濟的存儲方式，因為它們的gas消耗相對較低。

宣告事件時，我們使用event關鍵字，後面跟著事件名和需要記錄的變數。例如，在ERC20代幣合約中，Transfer事件的宣告如下：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

這個事件記錄了三個參數：發送者地址（from）、接收者地址（to）和轉帳金額（value）。其中，from和to被標記為indexed，這意味著它們將被存儲在日誌的topics部分，方便之後的檢索。

當合約的某個函數需要觸發事件時，我們使用emit關鍵字來釋放該事件。以下是一個釋放Transfer事件的範例：

```solidity
// 定義_transfer函數，執行轉帳操作
function _transfer(
    address from,
    address to,
    uint256 amount
) external {
    // 初始化發送者地址的餘額
    _balances[from] = 10000000;
    // 從發送者地址扣除轉帳金額
    _balances[from] -= amount;
    // 給接收者地址增加轉帳金額
    _balances[to] += amount;

    // 釋放Transfer事件
    emit Transfer(from, to, amount);
}
```

EVM通過日誌來存儲事件信息，每條日誌由topics和data兩部分組成。今日筆記介紹了Solidity中事件的宣告和釋放過程，以及EVM如何利用日誌記錄這些事件，從而展示了事件在區塊鏈數據存儲和前端互動中的重要作用。透過這些機制，事件不僅提供了一種經濟高效的數據存儲方法，也成為了鏈上與鏈下溝通的關鍵橋樑。


### 2024.10.09

繼承機制能顯著減少代碼重複，增強代碼的可讀性和可維護性。

繼承規則：
- virtual：若希望子合約能夠重寫父合約中的函數，則需在父合約中使用virtual關鍵字。
- override：子合約在重寫父合約中的函數時，必須使用override關鍵字。

基本繼承：
- 合約可以透過is關鍵字實現繼承，並在重寫父合約函數時使用override。
- 例如：Baba合約繼承Yeye合約並重寫hip()和pop()函數。

多重繼承：
- Solidity支援從多個合約繼承，繼承順序應從最遠祖先合約到最近父合約。
- 若多個父合約中存在同名函數，子合約必須重寫該函數，並在override後列出所有父合約。
- 例如：Erzi合約繼承Yeye和Baba合約並重寫hip()和pop()。

修飾器繼承：
- 修飾器（modifier）可被繼承如同函數，並可使用virtual和override進行重寫。
- 例如：exactDividedBy2And3修飾器的繼承與重寫。

構造函數繼承：
- 子合約可透過兩種方式繼承父合約的構造函數：
  - 在繼承時直接宣告父構造函數的參數。
  - 在子合約構造函數中宣告並傳遞給父合約。
- 例如：B和C合約繼承A合約的構造函數。

父合約函數調用：
- 可直接通過父合約名.函數名()調用父合約中的函數。
- 使用super可調用最近的父合約函數，按照繼承順序從右至左。

菱形繼承問題：
- 在多重繼承中，子合約可能同時繼承自兩個父合約，而這兩個父合約又來自同一祖先合約，形成菱形繼承結構。
- 使用super調用函數時，Solidity確保每個基類中的函數只被調用一次。
- 例如：people合約展示了菱形繼承問題，調用super.foo()或super.bar()時，會依次調用Eve、Adam，但God合約的函數只調用一次。

Solidity的繼承功能強大，合理運用繼承可大幅提升開發效率。在處理多重繼承和菱形繼承問題時，合理使用super關鍵字可避免重複調用父合約函數。
<!-- Content_END -->
