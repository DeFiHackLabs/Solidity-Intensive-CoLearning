---
timezone: Asia/Shanghai
---

# Univ
1. 自我介绍
我是Univ，想藉由這次共學機會深入學習Solidity與智能合約相關知識，跟大家一起的感覺比較有學習的動力

2. 你认为你会完成本次残酷学习吗？
我可以完成這次共學，每天排出時間更新學習進度
   
## Notes
<!-- Content_START -->


### 2024.09.23
## 01_HelloWeb3
```solidity
// SPDX-License-Identifier: MIT 
// 這一行是註釋，表示了MIT license，不寫的話會有warning，但程式還是可以跑
pragma solidity ^0.8.21; // 這一行表示版本

contract HelloWeb3 { // 這裡是合約的定義
   string public _string = "Hello Web3!"; // 宣告一個public的string型態變數，並賦值
}
```

## 02_ValueTypes
有分三種
#### 1. Value Type
- boolean：布林型別 (! && || == !=)
- int、uint、uint256：整數型別
- address：地址型別
- byte1、byte32：字節型別
- enum：列舉型別

#### 2. Reference Type
包括 array、struct、mapping 等複雜資料型別

#### 3. Mapping Type
一種特殊的資料型別，用來建立鍵值對映的數據結構

### 2024.09.24
## 03_Function

#### 1. 函數的基本結構
Solidity 中的函數結構有點複雜，但按照固定的格式來寫函數就可以：
- `function <函數名>(<參數類型>) {internal|external|public|private} [pure|view|payable] [returns (<返回類型>)]`

#### 2. 可見性修飾符
四種函數可見性修飾符，來控制函數的訪問範圍：
- **public**：內外部均可見
- **private**：僅限於本合約內部，繼承合約也無法使用
- **external**：僅限於合約外部訪問（但內部可以通過 `this.f()` 來調用）
- **internal**：僅限於合約內部，繼承的合約可以使用

#### 3. pure 和 view
Solidity 引入 `pure` 和 `view` 關鍵字來控制函數是否改變區塊鏈上的狀態，這是因為以太坊的交易需要支付 gas 費用：
- **pure**：不能讀取也不能修改合約中的狀態變量。它僅僅執行不依賴合約狀態的邏輯運算，因為不需要讀取或改變鏈上的數據，所以不需要支付 gas
- **view**：僅能讀取合約的狀態變量，但不能修改狀態。這種函數的運行也不會花費 gas，除非是合約內部調用時

#### 4. internal 和 external 函數
- **internal**：只能在合約內部或者繼承的合約中被調用，這在需要隱藏某些內部邏輯時非常有用
- **external**：只能從合約外部訪問，但可以在合約內部通過 `this.functionName()` 調用

#### 5. payable 函數
- **payable**：允許合約接收 ETH，帶有這個關鍵字的函數在執行時可以接收以太幣並更新合約的餘額

#### 6. 實例代碼
教程中提供了數個簡單的實例來展示如何使用 `pure`、`view`、`internal`、`external` 以及 `payable` 等關鍵字修飾函數：
- **`add()`** 函數展示了如何操作狀態變量並引入 `pure` 和 `view` 的用法
- **`minus()`** 函數展示了 `internal` 函數的使用
- **`minusPayable()`** 函數展示了 `payable` 函數如何接收 ETH 並更新合約餘額

### 2024.09.25
## 04_Return
- **`returns`** 這個關鍵字用在函數名稱後面，用來告訴大家這個函數會返回什麼樣的數據，比如返回什麼類型的數字、陣列或布林值（true 或 false），就像你在函數開始之前，先跟大家說：「這個函數會給你什麼東西」
- **`return`** 這個關鍵字用在函數的主體裡面，用來實際把數據返回出去。就像是函數結束時，你用 return 把事先說好的東西交給大家

#### 命名式返回
- 在 Solidity 中，可以在 returns 這裡直接給返回的值取名字，這樣在函數裡面只要把這些變數賦值，系統會自動把這些值返回，不用再手動用 return
在這裡，我們給每個返回的值取了名字 `_number`、`_bool` 和 `_array`，然後直接賦值，它們就會自動返回
```solidity
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```
當然還是可以用 return 來返回這些命名式的變數
```solidity
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
    return (1, true, [uint256(1),2,5]);
}
```
解構式賦值是一種方便的方式，可以讓你一次把函數返回的多個值分配給不同的變數。如果你不需要所有的返回值，也可以只取部分，其他的就留空
```solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
### 2024.09.26
## 05_DataStorage
#### 引用類型
引用類型包括：array和 struct<br>
這些類型的變數較為複雜，佔用較多存儲空間，因此需要明確聲明數據存儲的位置

#### 數據存儲位置
Solidity 中的數據存儲位置有三類：`storage`、`memory`和`calldata`，每種位置的 gas 消耗不同：

- **`storage`**：合約中的狀態變數默認存儲在 storage，數據存在鏈上，消耗較多 gas，類似電腦的硬碟
- **`memory`**：函數中的參數和臨時變數通常用 memory，數據存在內存中，不上鏈，消耗較少 gas，適用於返回變長數據類型
- **`calldata`**：類似於 memory，但數據不可修改，用於函數參數

#### 數據位置與賦值規則
- **引用**：當`storage`賦值給另一個`storage`或`memory`賦值給另一個`memory`時，會創建引用，修改一方會影響另一方
- **副本**：其他情況下賦值會創建副本，修改其中一方不會影響另一方

#### 變數的作用域
- **狀態變數**：存儲在鏈上，合約內所有函數可訪問，gas 消耗高，合約內、函數外聲明
- **局部變數**：僅在函數執行過程中有效，存儲在內存中，不上鏈，gas 消耗低，函數內聲明
- **全局變數**：Solidity 預留的關鍵字，在函數內可直接使用，如 msg.sender、block.number 等

#### 以太單位與時間單位
##### 以太單位：Solidity 中無法使用小數點，使用`wei`、`gwei`、`ether`等單位來表示不同的以太值，確保交易的精確性。
- **`wei`**:   1
- **`gwei`**:  1e9
- **`ether`**: 1e18

#### 時間單位：可使用 seconds、minutes、hours 等來設置合約中的時間，確保操作的準確性。
- **`seconds`**:   1
- **`minutes`**:   60
- **`hours`**:     3600
- **`days`**:      86400
- **`weeks`**:     604800

### 2024.09.27
## 06_ArrayAndStruct
#### 數組是用來存儲一組數據的變量類型，可分為固定長度數組和可變長度數組兩種：
- **固定長度數組**：
在聲明時指定長度，格式為`T[k]`，其中`T`是元素類型，k 是長度<br>例如：uint[8] array1;
- **可變長度數組**：
在聲明時不指定長度，格式為`T[]`<br>例如：uint[] array4;

#### 創建數組的規則：
- 使用`memory`修飾的動態數組可以用`new`操作符創建，必須指定長度，且創建後長度不能改變<br>例如：uint;
數組字面常數用來初始化數組<br>例如 [uint(1), 2, 3]，元素類型以第一個元素為準

#### 數組成員：
- **`length`**: 表示數組的長度
- **`push()`**: 在動態數組末尾添加一個元素
- **`pop()`**: 移除數組末尾的元素

#### 結構體（Struct）
- 結構體允許自定義類型，其元素可以是原始類型或引用類型。結構體可以作為數組或映射的元素

#### 創建結構體的方法：
- 存儲引用：在函數中創建一個 storage 的 struct 引用
```solidity
Student storage _student = student;
_student.id = 11;
_student.score = 100;
```

- 直接引用狀態變量的 struct
```solidity
student.id = 1;
student.score = 80;
```

- 構造函數
```solidity
student = Student(3, 90);
```

- 鍵值對
```solidity
student = Student({id: 4, score: 60});
```

### 2024.09.28
## 07_Mapping
在 Solidity 中，`Mapping`是一種資料結構，可以通過鍵`Key`查詢對應的`Value`<br>例如，可以通過一個人的 ID 查詢他的钱包地址

#### 映射聲明格式
```solidity
mapping(_KeyType => _ValueType)
```
_KeyType 和 _ValueType 分別代表鍵和值的變量類型

```solidity
mapping(uint => address) public idToAddress; // ID 映射到地址
mapping(address => address) public swapPair; // 幣對的映射，地址到地址
```
#### 映射的規則
- 鍵類型限制：映射的 _KeyType 只能是 Solidity 內置的值類型<br>如 uint、address 等，不能使用自定義的結構體

- 錯誤範例：
```solidity
struct Student {
    uint256 id;
    uint256 score; 
}
mapping(Student => uint) public testVar; // 錯誤，因為 _KeyType 是自定義結構體
```
- **存儲位置限制**：映射的存儲位置必須是 storage，因此可以用於合約的狀態變量、函數中的 storage 變量和 library 函數的參數中
- **自動生成`Getter`函數**：如果映射聲明為 public，Solidity 會自動生成一個 getter 函數，可以通過鍵來查詢對應的值

#### 新增鍵值對的語法：
- _Var 是映射變量名，_Key 和 _Value 對應新增的鍵值對。
```solidity
_Var[_Key] = _Value;
```
```solidity
function writeMap(uint _Key, address _Value) public {
    idToAddress[_Key] = _Value;
}
```
#### 映射的原理
- **不儲存鍵的資訊**：映射不儲存任何鍵的資訊，也沒有長度資訊
- **默認值**：未賦值的鍵初始值都是該類型的默認值，例如`uint`的默認值是 0
- **存取方式**：映射使用 keccak256(abi.encodePacked(key, slot)) 作為偏移量來存取值，其中 slot 是映射變量所在的插槽位置

### 2024.09.29
## 08_InitialValue

##### 變量初始值
- 在 Solidity 中，宣告但未賦值的變量會有其初始值或預設值

#### 值類型初始值
- **`int`**: `0`
- **`uint`**: `0`
- **`string`**: `""`
- **`boolean`**: `false`
- **`enum`**: 枚舉中的第一個元素
- **`address`**: `0x0000000000000000000000000000000000000000`（或 `address(0)`）
- **`function`**
  - **`internal`**: 空白函數
  - **`external`**: 空白函數

#### 範例驗證初始值：
```solidity
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000
enum ActionSet { Buy, Hold, Sell }
ActionSet public _enum; // 第1個內容Buy的索引0

function fi() internal {} // internal空白函數
function fe() external {} // external空白函數
```
#### 引用類型初始值
- **`mapping`**: 所有元素為其預設值的 mapping
- **`struct`**: 所有成員設為其預設值的結構體
- **`array`**:
   - **`動態array`**: []
   - **`定長array`**: 所有成員設為其預設值的靜態數組

#### 範例驗證初始值
```solidity
// Reference Types
uint[8] public _staticArray; // 所有成員設為其預設值的靜態數組 [0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // []
mapping(uint => address) public _mapping; // 所有元素都為其預設值的 mapping
// 結構體，所有成員設為預設值 0, 0
struct Student {
    uint256 id;
    uint256 score;
}
Student public student;
```

- delete 操作符
delete a 會將變量 a 的值重設為初始值
```solidity
bool public _bool2 = true;
function d() external {
    delete _bool2; // delete 會將 _bool2 重設為預設值 false
}
```

### 2024.09.30
## 09_Constant

- Solidity 中兩個與常量相關的關鍵字：`constant`和 `immutable`
- 當狀態變量聲明了這兩個關鍵字後，初始化後便不能更改數值，這樣可以提升合約的安全性並節省 gas

##### `constant`和`immutable`的區別
- **`constant`**：必須在聲明時初始化，之後無法再更改值
- **`immutable`**：可以在聲明時或透過constructor初始化，初始化後也不能更改值，比 `constant` 更靈活

### constant
- **`constant`** 變量需要在聲明的同時初始化，之後無法再更改。
```solidity
// constant 變量在聲明時初始化，之後不能更改
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```
### immutable
immutable 變量可以在聲明時或構造函數中初始化。
自 Solidity v8.0.21 之後，immutable 變量不需要顯式初始化，未初始化的 immutable 變量將使用數值類型的初始值。  若在聲明時和構造函數中都進行初始化，會以構造函數中的值為準。
```solidity
// immutable 變量可在構造函數中初始化，之後不能更改
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;
```
```solidity
constructor() {
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}
```
```solidity
function test() public pure returns (uint256) {
    return 9;
}
```

- 使用 Remix 上的 getter 函數檢視`constant`和`immutable`變量的初始化值
<br>嘗試更改 constant 變量的值會導致編譯失敗，並拋出錯誤：TypeError: Cannot assign to a constant variable.
<br>嘗試更改 immutable 變量的值也會導致編譯失敗，並拋出錯誤：TypeError: Immutable state variable already initialized.

### 2024.10.01
## 10_InsertionSort

#### 控制流
- if-else
- for迴圈
- while迴圈
- do-while
- 三元運算

#### Insertion Sort 用Python直轉solidity會出錯
- 將插入排序的 Python 代碼直接轉換為 Solidity 時，變量 j 可能取到負值，導致 underflow 錯誤。
- 修改算法，使 j 的最小值不會小於 0，從而避免 underflow 錯誤。

#### 錯誤版
```solidity
function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {    
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i-1;
        while( (j >= 0) && (temp < a[j])){
            a[j+1] = a[j];
            j--;
        }
        a[j+1] = temp;
    }
    return(a);
}
```

#### 正確版
```solidity
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // note that uint can not take negative value
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i;
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}
```

### 2024.10.02
## 11_Modifier

#### 構造函數
- 每個合約只能定義一個，在合約部署時自動執行一次。
- 常用於初始化合約的參數，例如設置合約的 owner 地址。
- Solidity 0.4.22 之後才使用 constructor

#### modifier
- 是一種控制函數行為的語法，類似於裝飾器 decorator 。
- 在運行函數之前進行檢查，例如檢查是否為特定地址或條件

- onlyOwner：
   - 用於檢查調用者是否為合約 owner，如果不是則會報錯並回滾交易。
   - modifier應用在 changeOwner 函數中，只有當前的 owner 才能改變合約的 owner。

### 2024.10.03
## 12_Event

### What?
事件就像是一個信號，當某些事情發生時，我們可以把這個信號「發送」出去，告訴其他人或應用程式。
- 響應：像是一些應用程式（比如 ethers.js）可以監聽這些信號，做出相應的反應，讓前端知道有事情發生了。
- 省油費：相較於其他方法，事件更節省資源（只需要大概 2,000 gas），比起直接在區塊鏈上存一個新變量（至少要 20,000 gas）更划算。

### How?
- 在 ERC20 代幣中，轉帳會用到一個叫 Transfer 的事件：
```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```
- from：轉帳的人
- to：接收代幣的人
- value：轉帳的數量
from 和 to 被標記為 indexed，這表示可以方便檢索

### How to release?
- 當發生轉帳時，我們可以用`emit`來釋放事件，告訴其他人這件事發生了。  這是如何在 Solidity 的函數中釋放 Transfer 事件的例子：
```solidity
emit Transfer(from, to, amount);
```
### EVM(Log)
- topics：這裡存放的是事件的索引。比如轉帳的 from 和 to 地址會存到這裡
- data：這裡存放的是具體的值，像是轉帳的數量

### How to lookup Etherscan event?
在 Etherscan 上查詢到這個交易的詳細信息，點擊「Logs」按鈕，可以看到事件的細節，包括轉帳的地址和數量

## 13_Inheritance
Solidity允許合約之間的代碼重用，避免重覆編寫相同的代碼
#### 簡單繼承
Solidity 支持一個合約繼承另一個合約。  繼承的語法是 contract 子合約名 is 父合約名。  在繼承過程中，父合約中的函數可以被子合約覆蓋（重寫），但必須遵循兩個關鍵字的規則：
- **virtual**：在父合約中的函數如果想被覆蓋，必須標記為 virtual。
- **override**：子合約重寫父合約的函數時，必須使用 override 關鍵字。
```solidity
contract Yeye {
    event Log(string msg);

    function hip() public virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye {
    function hip() public virtual override {
        emit Log("Baba");
    }
}
```
在這裡，Baba 繼承了 Yeye，並重寫了 hip() 函數。
#### 多重繼承
Solidity 允許一個合約繼承多個父合約。  在繼承多個合約時，必須按照輩分從高到低的順序撰寫合約名稱。  如果多個父合約中有相同的函數名稱，那麼在子合約中必須重寫該函數，並使用 override(父合約1, 父合約2) 的格式來指定它覆蓋的是哪些父合約的函數。
```solidity
contract Erzi is Yeye, Baba {
    function hip() public override(Yeye, Baba) {
        emit Log("Erzi");
    }
}
```
#### 修飾器的繼承
修飾器（Modifier）在 Solidity 中也可以繼承，並且可以像函數一樣被重寫。
```solidity
contract Base1 {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}
```
在 Identifier 合約中，重寫了來自 Base1 的修飾器 exactDividedBy2And3。
```solidity
contract Identifier is Base1 {
    modifier exactDividedBy2And3(uint _a) override {
        _;
        require(_a % 2 == 0 && _a % 3 == 0);
    }
}
```
#### 構造函數的繼承
Solidity 中的子合約可以繼承父合約的構造函數，並且有兩種方式傳遞參數：
- 在繼承時直接指定父合約構造函數的參數。
- 在子合約的構造函數中傳遞參數給父合約的構造函數。
```solidity
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
```
```solidity
 // 第一種方式
contract B is A(1) {}
```
```solidity
 // 第二種方式
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```
#### 調用父合約的函數
子合約可以直接調用父合約的函數，通過以下兩種方式：
- **直接調用**：使用 父合約名.函數名() 調用父合約的函數。
- **super關鍵字**：使用 super.函數名() 調用最近的父合約函數。
```solidity
contract Erzi is Yeye, Baba {
    // 直接調用
    function callParent() public {
        Yeye.pop(); 
    }
    // 使用 super 調用
    function callParentSuper() public {
        super.pop(); 
    }
}
```
#### 菱形繼承
一個子合約同時繼承兩個父合約，而這兩個父合約又繼承同一個祖父合約。  
在這種情況下，為了避免同一個函數在父合約中被調用多次，Solidity 引入了有向無環圖（DAG）的繼承模式，確保每個基類中的函數只會被調用一次。

## 14_Interface
Solidity中，抽象合約（abstract contract）和 接口（interface）是兩種不同的工具
#### 抽象合約(Abstract Contract)
抽象合約是一種合約模板，當合約中至少有一個未實現的函數（即沒有函數體）時，該合約必須被標記為 abstract。這表示它不能被單獨部署，而是需要其他合約繼承它，並且實現其中的函數。
```solidity
abstract contract InsertionSort {
    function insertionSort(uint[] memory a) public pure virtual returns (uint[] memory);
}
```

#### 接口(Interface)
接口是一個完全抽象的合約，所有函數都不包含函數體，並且不能有狀態變量或構造函數。接口的主要作用是定義合約應該有哪些功能，並且這些功能如何被外部調用。
#### 接口的規則：
- 不能有狀態變量或構造函數。
- 不能繼承其他類型的合約，僅能繼承接口。
- 所有函數必須是 external 並且沒有函數體。
- 繼承接口的合約必須實現接口中定義的所有函數。

## 15_Errors
#### error 方法
- `error`是在 Solidity 0.8.4 版本中引入的新功能，用於向用戶提供操作失敗的原因。
- 一種高效且省 gas 的方法，並且允許攜帶參數，幫助開發者進行調試。
```solidity
error TransferNotOwner();
```
帶參數的 error：
```solidity
error TransferNotOwner(address sender);
```
- error 通常與 revert 一起使用，當條件不滿足時，拋出異常並rollback交易。
- 在 transferOwner1 函數中，如果發起人不是代幣的 owner，就會觸發 TransferNotOwner 錯誤。
#### require 方法
- `require`是 Solidity 0.8 版本之前最常用的異常處理方式，許多合約仍在使用。
- 它檢查某個條件是否為真，如果為假，則拋出異常。
- 缺點：`require`方法會隨著錯誤描述的字符串長度增加 gas 消耗，這使得它比`error`更昂貴。
- 在`transferOwner2`函數中，`require`用來檢查發起人是否為代幣的`owner`
- 如果不是，會拋出 "Transfer Not Owner" 的異常信息。
#### assert 方法
- assert 用於檢查合約內部的邏輯錯誤，通常在開發和調試過程中使用。
- 它無法提供具體的錯誤信息，只會回滾交易。
- 當條件不成立時，assert 會直接拋出異常。
- 在`transferOwner3`函數中，`assert`檢查發起人是否為`owner`，但不會給出具體的錯誤描述。

##### 使用 Remix 測試不同方法的 gas 消耗（基於 Solidity 0.8.17 編譯版本）：
- `error`方法消耗最少的 gas，約 24457（帶參數時為 24660）。
- `require`方法消耗最多，約 24755。
- `assert`方法 gas 消耗稍低於 require，為 24473。

### 2024.10.04
## 16_Overloading
- **函數重載**：在 Solidity 中允許函數名稱相同，但輸入參數類型不同的函數共存，這些函數會被視為不同的函數。
- 雖然函數可以重載，但 Solidity 不允許modifier進行重載。
- 可以定義兩個名稱相同的函數 saySomething()，但參數不同：
   - 一個不接受參數，輸出 "Nothing"。
   -    一個接受一個 string 類型的參數，並輸出該字符串。
```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}
```
```solidity
function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```
#### Selector
- 在編譯過程中，重載的函數根據不同的參數類型生成不同的函數選擇器 selector 。<br>儘管這些函數名稱相同，每個函數選擇器都是唯一的。

#### Argument Matching
- 在調用重載函數時，編譯器會根據輸入的實際參數來匹配函數。<br>如果有多個匹配的函數，則會報錯。
```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}
```
```solidity
function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```
如果調用 f(50)，由於 50 可以同時匹配 uint8 和 uint256，因此會產生匹配衝突並報錯。

## 17_Library
#### 庫合約
- 是一種特殊的合約，提高代碼的重用性
- 通過共享函數來減少重複代碼和降低 gas 消耗
* 庫合約與普通合約相比有以下特點：
   * 不能有狀態變量：庫合約中無法存儲狀態變量<br>
   * 不能繼承或被繼承：庫合約無法繼承其他合約，也不能被其他合約繼承<br>
   * 不能接收以太幣：庫合約無法接收以太幣<br>
   * 無法被銷毀：庫合約無法使用 selfdestruct 銷毀<br>
- 庫合約的函數可見性對其行為有影響：
   - Public/External 函數：在調用時會觸發 delegatecall<br>
   - Internal 函數：不會觸發 delegatecall<br>
   - Private 函數：僅在庫合約內部可見，其他合約無法使用<br>
#### Strings 庫合約
- 以 ERC721 合約中引用的 Strings 庫合約為例，該庫的主要功能是將 uint256 數據轉換為字符串格式，常見於 NFT 合約中用來處理 Token ID 和 URI。
##### Strings 庫的函數
- toString(uint256 value)：將 uint256 數據轉換為十進制的字符串表示。
   - 將數值轉換為對應的字符組成的字符串。
- toHexString(uint256 value)：將 uint256 數據轉換為十六進制的字符串表示。
   - 將數值轉換為十六進制格式，並以 0x 為前綴。
- toHexString(uint256 value, uint256 length)：將 uint256 數據轉換為定長的十六進制字符串表示。
   - 根據指定長度來轉換數值，並自動填充。
#### 使用庫合約
兩種主要使用方式：
- using for 指令
   - 使用 using A for B; 來將庫合約 A 的函數附加到某類型 B 上。這樣，類型 B 的變量可以直接調用庫 A 中的函數，並且這個變量會自動作為函數的第一個參數。
```solidity
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    return _number.toHexString(); // 直接調用Strings庫的函數
}
```
- 直接調用庫合約函數
   - 直接使用庫合約的名稱來調用函數，不需要將庫合約附加到具體類型。
```solidity
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number); // 使用庫合約名稱調用函數
}
```
#### 常用的庫合約
`Strings`、`Address`、`Create2`、`Arrays`

### 2024.10.05
## 18_Import
- 通過檔案相對位置導入
- 通過網址引用合約
- 通過 npm 目錄導入
- 通過指定全局符號導入

### 2024.10.06
## Fallback
receive() 和 fallback() 是兩種特殊的回調函數，主要用於以下兩種情況：
1. 接收 ETH：
   - 當合約接收 ETH 時，會觸發這些函數。
2. 處理不存在的函數調用：
   - 當合約中不存在被調用的函數時，會觸發 fallback()，這個功能常見於代理合約 proxy contract。
* Solidity 0.6.x 版本之前，只有 fallback() 函數來處理接收 ETH 和處理函數未匹配的情況。從 0.6.x 版本開始，fallback() 函數被拆分為 receive() 和 fallback()。

### receive() 函數
#### receive()函數專門用於處理合約接收 ETH 的情況，每個合約最多只能定義一個 receive() 函數。<br>它有以下特點：
- 不需要`function`關鍵字。
- 必須使用`external`和`payable`修飾詞。
- 不能接受參數，也不會返回任何值。
- 當合約收到`ETH`並且`msg.data`為空時會觸發。
- `receive()`不應執行過於複雜的邏輯，否則可能因 gas 限制（2300 gas）導致合約報錯。
```solidity
// 定義事件
event Received(address Sender, uint Value);
// 接收ETH時釋放事件
receive() external payable {
    emit Received(msg.sender, msg.value);
}
```
### fallback() 函數
#### fallback() 函數在以下情況下會被觸發：
- 當調用合約中不存在的函數。
- 當合約接收 ETH 並且 msg.data 不為空，或 receive() 函數不存在。
```solidity
// 定義事件
event fallbackCalled(address Sender, uint Value, bytes Data);
// fallback 函數
fallback() external payable {
    emit fallbackCalled(msg.sender, msg.value, msg.data);
}
```
### receive() 和 fallback() 的區別
#### 這兩個函數的主要區別在於何時觸發：
- 當合約接收 ETH 且 msg.data 為空，並且 receive() 存在時，會觸發 receive()。
- 如果 msg.data 不為空或 receive() 不存在，則會觸發 fallback()。

### 2024.10.07
## 21_CallContract
#### 傳入合約地址
- 在合約函數中直接傳入目標合約的地址，然後調用目標合約的函數。<br>
#### 傳入合約變量
- 直接傳入一個合約的引用，而不是僅僅傳入地址。
#### 創建合約變量
- 在內部創建合約變量，然後使用它來調用合約函數。
#### 調用合約並發送 ETH
- 如果要調用的合約函數是 payable，可以在函數調用時發送 ETH 給目標合約。

### 2024.10.08
## 22_Call
#### 目標合約 OtherContract
- getBalance()：返回合約的 ETH 餘額。
- setX(uint256)：設置狀態變量 x，同時允許發送 ETH。
- getX()：讀取變量 x 的值。
#### 利用 call 調用目標合約
- 定義 Response 事件： 用於輸出 call 的結果，顯示 success（成功與否）和 data（返回值）。
- 調用 setX 函數： 使用 call 調用目標合約的 setX() 函數，並發送 ETH。若成功，會觸發 Response 事件。
- 調用 getX 函數： 使用 call 調用 getX()，返回變量 x 的值，並用 abi.decode 解碼返回的 data
- 調用不存在的函數： 如果 call 輸入了一個不存在的函數簽名，那麼目標合約的 fallback 函數會被觸發。

### 2024.10.09
## 23_Delegatecall
#### call 與 delegatecall 的區別
- call：執行目標合約的函數，上下文是目標合約。
   - msg.sender 是發起合約。
   - 狀態變量的修改會作用於目標合約。
- delegatecall：執行目標合約的函數，上下文是發起合約。
   - msg.sender 是發起調用的外部地址。
   - 狀態變量的修改作用於發起合約。
目前，delegatecall 最常見的應用場景是Proxy Contract和EIP-2535 Diamonds。

## 24_Create
#### 動態創建新合約
```solidity
Contract x = new Contract{value: _value}(params);
```
#### Uniswap
- Uniswap 是去中心化交易所的代表性項目，它通過工廠合約 (Factory Contract) 創建各種幣對合約來管理流動性池。
##### Pair 合約
- Pair 合約的作用是管理代幣對，包含三個主要狀態變量：
   - factory: 記錄創建它的工廠合約地址。
   - token0 和 token1: 這對應於代幣對的兩種代幣地址。
- 初始化時，factory 記錄為創建它的合約地址，並且 initialize 函數在合約部署後被手動調用，用來設置兩個代幣的地址。
##### PairFactory 合約
- PairFactory 是工廠合約，負責創建新的代幣對 (Pair) 合約。工廠合約的主要功能是：
   - getPair: 一個mapping，允許通過兩個代幣地址查找對應的代幣對合約地址。
   - allPairs: 存儲所有創建的代幣對合約地址。

## 24_Create
`CREATE2 是一個以太坊操作碼，用於在智能合約部署之前就能預測合約的地址。這與 CREATE 操作碼不同，CREATE2 允許我們生成可預測的合約地址，無論未來的事件如何變化。`
#### CREATE 和 CREATE2 地址計算的區別
#### CREATE 地址計算
- CREATE 操作碼的合約地址由以下內容決定：
   - 創建者的地址（可以是外部帳戶或合約地址）。
   - 創建者的 nonce（代表該地址發出的交易或合約創建的次數）。
   - 由於 nonce 隨時間增加，因此很難預測未來使用 CREATE 創建的合約地址。   
#### CREATE2 地址計算
- CREATE2 提供了一種方式，可以在合約部署之前計算出地址，無需依賴未來的 nonce 或事件。<br>CREATE2 計算合約地址時，使用的是：
   - 0xFF（一個常數）。
   - 創建合約的地址。
   - salt（由創建者指定的值，通常是 bytes32）。
   - 合約的 initcode（合約的創建代碼）。
```solidity
//CREATE
新地址 = keccak256(rlp.encode([創建者地址, nonce]))
//CREATE2
新地址 = keccak256(abi.encodePacked(0xFF, 創建者地址, salt, keccak256(initcode)))
```
- CREATE2 保證了只要提供相同的 salt 和 initcode，即使在不同的時間段，合約的地址都是相同且可預測的。
### CREATE2 用法
- CREATE2 的語法與 CREATE 類似，但多了一個 salt 參數，用來確定合約地址：
```solidity
Contract x = new Contract{salt: _salt, value: _value}(params);
```
_salt 是用來影響合約地址的參數。<br>
_value 是創建時轉入的 ETH（如果構造函數是 payable）。
- CREATE2 的實際應用場景
   - 交易所錢包地址預留
   - Uniswap V2 的交易對創建

## 26_DeleteContract
`用於刪除智能合約，並將合約中剩餘的 ETH 轉移到指定地址。`
最早被命名為 suicide，後來改名為 selfdestruct 以避免敏感詞。<br>指令的初衷是為了應對合約運行中的緊急情況<br>例如合約發生嚴重錯誤時，可以自毀來停止進一步的運行
- 已經部署的合約無法被 selfdestruct 完全刪除。
- 只有在同一筆交易中創建和銷毀的合約才能真正被刪除。
```solidity
selfdestruct(_addr);
```
_addr 是接收合約中剩餘 ETH 的地址。<br>這個地址不需要具備 receive() 或 fallback() 函數來接收 ETH，selfdestruct 會自動轉移資金。
## 27_ABIEncode
### ABI 編碼函數
1. abi.encode 用於將給定參數按照 ABI 規則進行編碼，每個參數會填充為 32 字節長度的數據，這是與合約交互時使用的主要方法。<br>編碼的結果每個變量會填充為 32 字節，適合與智能合約進行交互。
```solidity
function encode() public view returns(bytes memory result) {
    result = abi.encode(x, addr, name, array);
}
```

2. abi.encodePacked
   - abi.encodePacked 和 abi.encode 類似，但會將填充的 0 省略，緊湊地編碼數據。這對於節省空間和計算哈希特別有用，但不適合與合約直接交互，因為缺少具體的填充。
```solidity
function encodePacked() public view returns(bytes memory result) {
    result = abi.encodePacked(x, addr, name, array);
}
```
3. abi.encodeWithSignature
   - abi.encodeWithSignature 與 abi.encode 類似，但第一個參數是函數的簽名 (函數名稱和參數類型)，適合用於調用合約中的具體函數。
```solidity
function encodeWithSignature() public view returns(bytes memory result) {
    result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
}
```
4. abi.encodeWithSelector
   - abi.encodeWithSelector 類似於 abi.encodeWithSignature，但第一個參數是具體的函數選擇器，可以通過 Keccak 哈希計算得到。
```solidity
function encodeWithSelector() public view returns(bytes memory result) {
    result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
}
```
### ABI 解碼函數
#### abi.decode
- abi.decode 用於解碼使用 abi.encode 編碼的數據，將其還原為原始的參數。使用時需要指定數據的類型，以正確還原數據。
```solidity
function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
    (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
}
```
## 28_Hash
一種密碼學概念，能夠將任意長度的輸入數據轉換成一個固定長度的哈希值。
#### Keccak256 是 Solidity 中最常用的哈希函數
在 Ethereum 和 Solidity 開發時，使用的是 Keccak，而不是 NIST 標準的 SHA3。<br>為了避免混淆，在 Solidity 中使用 Keccak256 函數。
#### 使用 Keccak256 生成數據唯一標識
有一組不同類型的數據（如uint，string 和 address）<br>可以先用 abi.encodePacked 將數據打包，然後再用 keccak256 計算其唯一標識。
#### 弱抗碰撞性
```solidity
function weak(
    string memory string1
    )public view returns (bool){
    return keccak256(abi.encodePacked(string1)) == _msg;
}
```
#### 強抗碰撞性
```solidity
function weak(
    string memory string1
    )public view returns (bool){
    return keccak256(abi.encodePacked(string1)) == _msg;
}
```
## 29_Selector
當我們在以太坊上調用智能合約的函數時，實際上是發送了一段 calldata 給合約。<br>這段 calldata 中包含了函數選擇器 (selector) 和傳遞的參數，用於告訴智能合約調用哪個函數和使用什麼參數。
#### msg.data 和 calldata
msg.data 是 Solidity 中的一個全局變量，表示交易的完整 calldata。<br>當調用合約中的函數時，calldata 中的前 4 個字節是函數選擇器，剩下的部分是函數的參數。
- 前 4 個字節 (0x6a627842) 是函數選擇器 (selector)。
- 後面的字節 是參數 (0x2c44b726adf1963ca47af88b284c06f30380fc78)。
#### 函數簽名和函數選擇器
函數選擇器是根據函數簽名生成的。函數簽名的格式是 "函數名(參數類型1,參數類型2,...)"。<br>函數選擇器是函數簽名的 Keccak 哈希的前 4 個字節。
#### 函數參數類型
1. 基礎類型參數
2. 固定長度類型參數
3. 可變長度類型參數
4. 映射類型參數
#### 使用函數選擇器調用函數
使用函數選擇器來調用目標函數，通過 abi.encodeWithSelector 將選擇器與參數打包傳遞給合約進行低級調用

## 30_TryCatch
```solidity
try externalContract.f() {
    // 成功時運行的代碼
} catch {
    // 失敗時運行的代碼
}
```

### 2024.10.10
核心功能
- balanceOf
- transfer
- transferFrom
- approve
- allowance
- totalSupply
ERC20 事件
- Transfer 事件
- Approval 事件
IERC20 接口 : 是 ERC20 標準的接口，規定了代幣所需實現的函數和事件。<br>這是 ERC20 的協議部分，用來保證所有 ERC20 代幣的函數和參數結構保持一致。

### 2024.10.11
## 32_Faucet
#### 代幣水龍頭概述
代幣水龍頭是一個應用，讓用戶能夠免費領取少量的代幣。最早的代幣水龍頭是比特幣BTC水龍頭，當時比特幣的價格很低，Gavin Andresen創建了這個水龍頭來鼓勵更多人使用比特幣。現代的區塊鏈項目，也經常通過水龍頭向用戶免費發放測試或推廣用的代幣。

#### ERC20 水龍頭合約
ERC20 水龍頭合約允許用戶從一個合約中領取免費的 ERC20 代幣，並且每個地址只能領一次。這個合約簡單易用，下面將介紹它的邏輯和實現。

#### 合約的狀態變量
`amountAllowed`：設定每個用戶每次能領取的代幣數量，默認為100單位。<br>
`tokenContract`：記錄需要發放的 ERC20 代幣合約的地址。<br>
`requestedAddress`：通過一個mapping來記錄哪些地址已經領取過代幣，確保每個地址只能領取一次。<br>
```solidity
uint256 public amountAllowed = 100; // 每次領取100單位代幣
address public tokenContract;       // ERC20代幣合約地址
mapping(address => bool) public requestedAddress; // 記錄已領取的地址
```
#### 事件
合約定義了一個事件 SendToken，每次成功領取代幣後，這個事件會記錄領取的地址和數量，方便追蹤操作。
```solidity
event SendToken(address indexed Receiver, uint256 indexed Amount);
```
#### 函數
##### 構造函數
在合約部署時，將 ERC20 代幣合約的地址傳入，並初始化 tokenContract 變量。
```solidity
constructor(address _tokenContract) {
    tokenContract = _tokenContract; // 設定發放的ERC20代幣合約
}
```
##### requestTokens() 函數
用戶調用此函數來領取代幣。<br>該函數包含幾個關鍵步驟：
1. 檢查用戶是否已經領取過代幣，若已領取則拋出錯誤。
2. 確認水龍頭合約中是否還有足夠的代幣。
3. 使用 IERC20 的 transfer 函數將代幣轉帳給調用者。
4. 記錄調用者地址，防止重複領取。
5. 釋放 SendToken 事件。
```solidity
function requestTokens() external {
    require(!requestedAddress[msg.sender], "Can't Request Multiple Times!");
    IERC20 token = IERC20(tokenContract);
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!");
    token.transfer(msg.sender, amountAllowed);
    requestedAddress[msg.sender] = true;
    emit SendToken(msg.sender, amountAllowed);
}
```
## 33_Airdrop
#### ERC20 空投合約
主要用於批量發送 ERC20 代幣 或 ETH，具有以下功能：
- 利用循環批量發送代幣。
- 利用 IERC20 接口和 transferFrom 函數實現代幣轉帳。
- 批量發送 ETH，避免重複調用。

`getSum()`：計算array內所有元素的總和
```solidity
function getSum(uint256[] calldata _arr) public pure returns(uint sum){
    for(uint i = 0; i < _arr.length; i++)
        sum = sum + _arr[i];
}
```
`multiTransferToken()`：
   - 參數
      - _token: 代幣的合約地址。
      - _addresses: 接收空投的用戶地址數組。
      - _amounts: 對應每個地址的代幣數量。
   - 包含兩個檢查：
      - 檢查地址數組和代幣數量數組是否長度一致。
      - 檢查發送的代幣總量是否小於或等於授權的代幣數量。
`multiTransferETH()`：<br>
   - `_addresses`: 接收空投 ETH 的用戶地址數組。<br>
   - `_amounts`: 對應每個地址的 ETH 數量。

## 34_ERC721
ERC721 是一個用於在以太坊上實現非同質化代幣（NFT）的標準協議，它允許每一個代幣都擁有獨特的屬性，因此無法互換。
#### ERC 與 EIP 的區別
EIP (Ethereum Improvement Proposals) 是以太坊改進建議，ERC (Ethereum Request for Comment) 是 EIP 中針對應用級別的標準提案。ERC 包含代幣標準，如 ERC20 和 ERC721。

#### ERC165 — 用於檢查合約接口
ERC165 定義了一個標準方法來檢查合約是否實現了某個接口。<br>這樣可以確保合約是否符合某些標準，比如 ERC721。ERC165 的核心功能是 supportsInterface()，用來返回合約是否支持特定的接口。

#### ERC721 — NFT 標準
ERC721 是 ERC165 的擴展，用來定義 NFT 的操作規範。<br>ERC721 使用 tokenId 來標識每個唯一的代幣，這與 ERC20 代幣不同。<br>
以下是 ERC721 的主要功能：
- balanceOf(): 返回某地址擁有的 NFT 數量。
- ownerOf(): 返回某個 tokenId 的擁有者。
- transferFrom(): 將 tokenId 從一個地址轉移到另一個地址。
- safeTransferFrom(): 進行安全的代幣轉移，如果接收方是合約則必須實現 IERC721Receiver 接口。
- approve(): 授權另一個地址管理特定的 tokenId。
- setApprovalForAll(): 批量授權管理所有代幣。

## 35_DutchAuction
- 價格下降：價格從起拍價逐漸下降，直到達到最低價格或被購買為止。
- 避免Gas War：由於拍賣時間較長，競爭者不用在同一時間搶購，從而減少網絡擁堵。
---
1. 設置拍賣時間：
```solidity
function setAuctionStartTime(uint32 timestamp) external onlyOwner {
    auctionStartTime = timestamp;
}
```
---
2. 計算當前拍賣價格：<br>
   getAuctionPrice() 根據當前時間來計算價格是起始價、結束價還是處於兩者之間的衰減價格：
```solidity
function getAuctionPrice() public view returns (uint256) {
    if (block.timestamp < auctionStartTime) {
        return AUCTION_START_PRICE;
    } else if (block.timestamp - auctionStartTime >= AUCTION_TIME) {
        return AUCTION_END_PRICE;
    } else {
        uint256 steps = (block.timestamp - auctionStartTime) / AUCTION_DROP_INTERVAL;
        return AUCTION_START_PRICE - (steps * AUCTION_DROP_PER_STEP);
    }
}
```
---
3. 鑄造NFT：<br>
   用戶可以通過auctionMint() 支付當前價格來購買NFT，並進行鑄造。該函數會根據用戶支付的ETH來進行鑄造操作，並退還多餘的ETH：
```solidity
function auctionMint(uint256 quantity) external payable {
    require(block.timestamp >= auctionStartTime, "sale has not started yet");
    require(totalSupply() + quantity <= COLLECTOIN_SIZE, "not enough remaining reserved for auction");
    uint256 totalCost = getAuctionPrice() * quantity;
    require(msg.value >= totalCost, "Need to send more ETH.");

    for (uint256 i = 0; i < quantity; i++) {
        _mint(msg.sender, totalSupply());
    }

    if (msg.value > totalCost) {
        payable(msg.sender).transfer(msg.value - totalCost);
    }
}
```
---
4. 項目方提取ETH：<br>
   用戶支付的ETH可以通過withdrawMoney()由項目方提取到其個人地址：
```solidity
function withdrawMoney() external onlyOwner {
    (bool success, ) = msg.sender.call{value: address(this).balance}("");
    require(success, "Transfer failed.");
}
```
---
## 36_MerkleTree
默克爾樹或哈希樹
- 是區塊鏈技術中的重要加密結構
- 自下而上構建的樹狀數據結構，葉子節點是數據的哈希值
- 每個非葉子節點是其子節點的哈希值
- Merkle Tree 的主要用途是快速驗證某一數據是否存在於特定的數據集內
---
- 可以用merkletreejs來生成 Merkle Tree
- 每個地址生成一個哈希值作為葉子節點，通過哈希操作計算出根節點，並從中獲得每個葉子節點的 Proof。
---
- 利用 Merkle Tree 發放 NFT 白名單
- 只需存儲一個 root 值，用戶提供 proof 和地址即可驗證是否在白名單中。

### 2024.10.12
## 37_Signature
在Ethereum，用 ECDSA（Elliptic Curve Digital Signature Algorithm，橢圓曲線數字簽名算法）來保證數據的完整性和簽名者的身份驗證。
- 身份認證：證明簽名方是私鑰的持有人。
- 不可否認性：發送方不能否認自己發送了這個消息。
- 完整性驗證：簽名可以驗證消息在傳輸過程中是否被篡改。
#### ECDSA 操作流程
1. 創建簽名<br>
生成簽名的步驟包括打包消息、計算哈希、生成以太坊簽名消息，並使用錢包或代碼進行簽名。
2. 驗證簽名<br>
驗證過程是根據消息和簽名來恢復出簽名者的公鑰，並與簽名者的地址進行匹配。如果公鑰匹配，則簽名有效。
#### 簽名發放 NFT 白名單
項目方可以通過 ECDSA 來實現白名單的發放方式。<br>這種方式節省了很多 Gas 費用，因為簽名是在鏈下完成的，鏈上只需進行簽名驗證。此方法適用於動態變更白名單。

### 2024.10.13
## 38_NFTSwap
#### 搭建零手續費的去中心化 NFT 交易所：NFTSwap
### 設計邏輯
NFTSwap 是一個去中心化的零手續費 NFT 交易平台，設計上模仿了現有的 NFT 市場如 OpenSea，但不會抽成交易費。<br>
以下是設計的核心邏輯：<br>
賣家功能：<br>
- 上架 NFT（list()）
- 撤單（revoke()）
- 修改價格（update()）
買家功能：
- 購買 NFT（purchase()）
訂單結構：
- 包含 price（價格）和 owner（持有人）的訂單結構，儲存在合約中的 nftList 映射中。
使用步驟：
- 部署和授權：部署 NFT 和 NFTSwap 合約後，賣家需要授權 NFT 給 NFTSwap 合約，以允許 NFTSwap 進行轉移操作。
- 掛單：通過 list() 函數將 NFT 上架，設置價格。
- 撤單與修改價格：使用 revoke() 和 update() 函數來進行訂單的撤回和價格修改。
- 購買 NFT：買家通過 purchase() 函數支付 ETH 購買上架的 NFT，ETH 將自動轉給賣家。
### 2024.10.14
## 39_Random
### 鏈上偽隨機數和鏈下隨機數
鏈上隨機數生成
- 用 keccak256 哈希函數 和一些全局變量來生成偽隨機數
   - 缺點：
      - 可預測：因為變量如 block.timestamp 和 msg.sender 是公開的，攻擊者可以推測出結果。
      - 礦工操控：礦工可以修改區塊時間戳或使用特定的區塊哈希來操縱隨機數生成過程。
      - 儘管這些問題存在，許多項目仍然使用這種方式生成隨機數，因此成為了攻擊者利用的目標。
鏈下隨機數生成 (Chainlink VRF)
- 通過 Chainlink VRF 預言機上傳至區塊鏈。該方法基於 可驗證隨機函數，能夠提供可靠的隨機數，並保證無法被操縱。
   - Chainlink VRF 的工作流程：
      - 創建 Subscription 並存入 LINK 代幣，這些代幣將用於支付隨機數生成的費用。
      - 用戶合約繼承 VRFConsumerBaseV2 並向 VRF 請求隨機數。Chainlink 節點生成隨機數並將結果回傳至用戶合約。
      - 用戶合約接收隨機數並完成業務邏輯。

## 40_ERC1155
以太坊 EIP1155 多代幣標準
- EIP1155 提出了一個允許一個合約包含多個代幣的標準，既可以是同質化代幣（如 ERC20），也可以是非同質化代幣（如 ERC721）。
- 這種靈活性使其非常適合遊戲中的多種資產管理。
- ERC1155 提供了一個更高效的多代幣處理方法，並且引入了批量轉帳和批量持倉查詢的功能。
ERC1155 標準的核心概念
- 同質化與非同質化
   - 同質化代幣：如 ERC20，每個代幣是可互換的，沒有區別。
   - 非同質化代幣：如 ERC721，每個代幣都是獨一無二的。 在 ERC1155 中，如果某個 id 對應的代幣總量為1，那就是非同質化代幣；如果 id 對應的總量大於1，那就是同質化代幣。
- 主要功能
   - 批量操作：可以批量查詢代幣餘額、批量轉帳。
   - 事件通知：ERC1155 有豐富的事件通知，如單個代幣轉帳、批量轉帳等。
   - 接收合約：類似於 ERC721，ERC1155 也要求接收合約實現對應的接收函數，確保代幣不會被轉入一個不支持的合約。
- 操作流程
   1. 部署 BAYC1155 合約：首先，我們在 Remix 中部署 BAYC1155 合約。

   2. 查看元數據：URI部署合約後，可以使用 uri() 函數查看代幣的元數據地址，確認是否指向正確的 IPFS 路徑。

   3. 單個鑄造操作：通過 mint() 函數鑄造單個代幣，這裡的 id 代表要鑄造的代幣類型，amount 代表鑄造的數量。如果 amount 為 1，則該代幣是非同質化的（如 ERC721）；如果 amount 大於 1，則該代幣是同質化的（如 ERC20）。

   4. 批量鑄造操作：使用 mintBatch() 可以一次鑄造多種代幣，這在需要大批量創建資產時非常有用。

   5. 批量轉帳操作：ERC1155 允許批量轉帳，我們可以通過 safeBatchTransferFrom() 函數一次性轉移多個代幣給一個接收者地址。
      
### 2024.10.15
## 41_WETH
Wrapped ETH是 ETH 的包裝版本，符合 ERC20 標準的代幣版本的 ETH。<br>
由於以太坊原生 ETH 並不遵循 ERC20 標準，因此需要通過 WETH 這種方式來使 ETH 可以在需要 ERC20 代幣的去中心化應用程序 (dApp) 中進行交互。<br>
用戶可以將 ETH 轉換為 WETH，參與各類基於 ERC20 代幣的操作，並且隨時可以將 WETH 兌換回 ETH。
#### WETH 合約的功能
- 存款（deposit）：用戶將 ETH 轉入 WETH 合約，合約會鑄造等量的 WETH 並發送給用戶。
- 取款（withdraw）：用戶可以銷毀（burn）WETH，並取回等量的 ETH。

## 42_PaymentSplit
#### 分帳合約的原理
- 分帳合約是一種允許多個帳戶根據預定的權重比例來分配收到的ETH的智能合約。
- 當合約收到ETH後，根據每個受益人的份額，受益人可以自行調用合約來領取應得的部分。

#### 分帳合約的特點
- 受益人和份額固定：<br>
  在合約部署時，指定受益人地址和每個受益人的份額。
- Pull Payment 模式：<br>
  合約不會自動將收到的款項發給受益人，而是保留在合約中，受益人需要主動調用 release() 函數來領取。

## 43_TokenVesting
#### Token Vesting
在一段時間內逐步釋放代幣的機制，旨在防止代幣持有者（例如，團隊成員或投資者）在短時間內大量拋售代幣，從而對市場價格產生巨大影響。<br>
這是一種對代幣解鎖進行管理的機制，確保代幣逐步釋放，以減緩市場拋壓。<br>
在區塊鏈項目中，通常會將代幣逐步釋放給團隊、風投和其他利益相關者。<br>
代幣解鎖的過程可能是線性釋放，也可以是分階段釋放。<br>
#### 線性釋放合約
一種常見的代幣歸屬方式，代幣在設定的歸屬期內按照固定的速率釋放。以下是實現線性釋放的ERC20代幣合約示例，該合約允許受益人根據時間提取逐步釋放的代幣。
步驟<br>
#### 部署ERC20代幣合約：
首先部署一個ERC20代幣合約，並鑄造一定數量的代幣給自己（例如10,000枚）。
#### 部署TokenVesting合約：
設置受益人地址以及代幣歸屬期（例如100秒）。
#### 轉帳代幣至TokenVesting合約：
將ERC20代幣從自己地址轉到剛剛部署的 TokenVesting 合約中。
#### 提取代幣：
根據釋放規則，受益人可以隨時調用 release() 函數提取已經釋放的代幣。

## 44_TokenLocker
在去DEX中，用戶可以成為流動性提供者（Liquidity Provider，LP），將資金存入資金池中。<br>
這些資金可供其他用戶進行即時交易，而流動性提供者則根據提供的資金獲取交易手續費的分成。<br>

當用戶向資金池中提供資金時，DEX 會給予流動性提供者一個流動性憑證，就是 LP 代幣。<br>
這些代幣代表了流動性提供者在資金池中的所有權份額，用戶可以隨時根據 LP 代幣的數量來贖回其提供的流動性和獲得的收益。<br>
鎖定流動性主要是為了防止項目方或其他流動性提供者突然撤出資金池。<br>
這種情況會導致資金池中的流動性減少，使得其他投資者無法交易，導致幣價崩潰。<br>
這種行為被稱為 Rug Pull，是一種常見的詐騙方式。<br>

## 45_Timelock
Timelock是一種防止智能合約的關鍵功能在沒有預先通知或等待的情況下立即被執行的機制。<br>
在設定的等待期內，任何更改或關鍵交易都無法立即生效，需要經過預先指定的時間延遲。<br>
Timelock有助於提高智能合約的安全性，防止黑客或惡意行為者快速提取資金，也給項目方和用戶更多時間來檢查和反應。<br>

需要Timelock的原因
增強安全性：<br>
即使合約遭受攻擊，交易執行前的等待期讓項目方有機會發現異常並採取行動。<br>
減少 Rug Pull 風險：<br>
項目方無法立即撤走流動性或修改合約，降低投資者損失風險。<br>
提高透明度：<br>
時間鎖為社區提供了監督和反應的機會，有助於保持項目治理的透明性。<br>
***
核心函數
queueTransaction()：將交易排入時間鎖隊列，必須滿足時間延遲條件。<br>
cancelTransaction()：取消排入時間鎖的交易。<br>
executeTransaction()：執行隊列中的交易，必須滿足時間條件且交易未過期。<br>
getBlockTimestamp()：返回當前區塊鏈的時間戳。<br>
getTxHash()：生成交易的唯一標識符，用於檢查隊列中的交易。<br>
***
1. 部署 Timelock 合約，設定鎖定期，例如 120 秒。
2. 創建並排入交易，構造目標合約地址、函數簽名和相關參數，並將其加入時間鎖隊列。
3. 執行交易，鎖定期滿後，調用 executeTransaction() 執行交易。
4. 取消交易，在鎖定期內，若需要取消交易，調用 cancelTransaction() 取消交易。

46_ProxyContract
一種設計模式，它將合約的數據和邏輯分離，使得合約可以在部署後仍然進行升級。<br>
當我們需要更新合約中的邏輯時，不需要重新部署新合約，只需要更新代理合約指向的新邏輯合約即可，實現合約的可升級性。<br>
這種模式在DeFi、DAO領域被廣泛使用。<br>

優勢是：
- 可升級：可以通過更新代理合約的邏輯合約地址來修改合約行為，而無需遷移數據。
- 節省 Gas：多個代理合約可以共享一個邏輯合約，減少重複部署邏輯合約的開銷。

代理合約的工作原理：
代理合約通過 delegatecall 將所有調用委託給邏輯合約，使用邏輯合約中的函數和邏輯，但狀態變量存儲在代理合約中。<br>
這種方式使得我們可以替換邏輯合約而不改變狀態變量。<br>

代理合約的實現：<br>
- 代理合約（Proxy）：存儲數據並將調用委託給邏輯合約。
- 邏輯合約（Logic）：處理具體業務邏輯。
- 調用者合約（Caller）：演示如何通過代理合約調用邏輯合約。

### 2024.10.16
## 47_Upgrade
Upgradeable Contract）是智能合約的一種設計模式。<br>
優勢：
- 可升級性：可以通過更新邏輯合約來實現升級，不需要重新部署數據部分。
- 節省 Gas：代理合約可以復用邏輯合約，大大節省合約的部署成本。


## 48_TransparentProxy
## 49_UUPS
## 50_MultisigWallet
## 51_ERC4626
## 52_EIP712
## 53_ERC20Permit
## 54_CrossChainBridge
## 55_MultiCall
## 56_DEX
## 57_Flashloan


<!-- Content_END -->
