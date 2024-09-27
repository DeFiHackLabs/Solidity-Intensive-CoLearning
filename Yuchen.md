---
timezone: Asia/Shanghai
---

---
# Yuchen

1. 自我介绍  
大家好，我是Yuchen，目前就讀於資工系3年級，但在此前完全沒有學習過solidity，但一直想學習撰寫智慧合約並學習與區塊鏈相關的知識，希望透過此次機會與大家一起有規劃的學習:)。

2. 你认为你会完成本次残酷学习吗？  
會，我會盡力在課業之外規劃時間進行學習，相信活動中設計的壓力也可以推動著我努力跟上大家的學習進度。
   
## Notes

<!-- Content_START -->

### 2024.09.23
#### 什麼是智能合約?  
智能合約(Smart Contracts)是一種自動執行的協議，將雙方的協議條款，用代碼形式在區塊鏈上運行，當條件滿足時可以自動執行之前定義的操作，ex.轉帳、處理合約...  
智能合約儲存在一個公共資料庫中，且不能被更改。

智能合約3要素:
1. 自治:合約一啟動就會自動運行，不需要任何人為的干預。
2. 自足:智能合約可以自主控制其計算所涉及的資源，比如有權限調配合約雙方的資金和財產。
3. 去中心化:通過分散式的節點來自動運行，而不用透過中心化的單個伺服器。

乙太坊(Ethereum)把基於智能合約的應用程式稱為去中心化應用程式(Decentralized App , Dapp)。  
智能合約能用來串聯Dapp與區塊鏈，Dapp不同於傳統app，Dapp具備去中心化、數據不可竄改、公開透明的特性，因此會比使用傳統中心化的app更安全。
* APP：前端介面加上一個中心化的伺服器。
* Dapp： 前端介面加上去中心化的智能合約，因為放在區塊鏈上，不需要伺服器。

#### Solidity 簡介
Solidity 為用於編寫智能合約的高階語言，主要針對 Ethereum 區塊鏈平台開發設計。

開發工具：Remix  
網址：https://remix.ethereum.org/  

**第一支程式：Hello Web3!**
```Solidity
// SPDX-License-Identifier: MIT  
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
1. 第 1 行是註釋，說明這段程式所使用的程式許可(MIT許可)，若沒加入許可，編譯時會出現警告，但仍可運行。
2. 第 2 行聲明使用的 Solidity 版本，因為不同版本的語法有差異。  
    這段程式表示不允許使用小於 0.8.21 或大於等於 0.9.0 的編譯器編譯。
3. 第 3 行創建合約，並聲明合約名為 HelloWeb3。
    第 4 行是合約內容，宣告公開 string 變量 _string，賦值"Hello Web3!"。
    ```Solidity
    contract HelloWeb3{
    string public _string = "Hello Web3!";
    }
    ```
部署這個合約後，外部用戶可以調用 Solidity 自動生成的 function `_string() public view returns (string)` 來讀取 `_string` 的值，它會返回 `"Hello Web3!"`。這是最基本的合約示例，用來展示如何在區塊鏈上存儲並公開字符串數據。

* [Solidity 中文翻譯文檔](<https://docs.soliditylang.org/zh/v0.8.19/introduction-to-smart-contracts.html>)

#### Solidity 的變量類型
1. **值類型(Value Type)**：這類變數賦值時直接傳遞數值。
    * 數值類型：
        * `uint`：無符號整數(不包括負數)，$0到2^{256}-1$
        * `int`：有符號整數(包括負數)，$-2^{255}到2^{255}-1$。
        * 比較運算符： `<=`， `<`，`==`， `!=`， `>=`， `>`
        * 算術運算符：`+`， `-`， `*`， `/`， `%`（取餘），`**`（幂）
    * 布林類型：true、false。
        運算符包含：
        | 符號 | 邏輯 |
        | :-- | :-- |
        | `!` | 邏輯非 |
        | `&&` | 邏輯與 |
        | `\|\|` | 邏輯或 |
        | `==` | 等於 |
        | `!=` | 不等於 |

        此外`&&`、`||`遵循短路規則。
    * 位元操作類型：
        * `byte` / `bytes1`到 `bytes32`，表字節從1到最多32bytes。
        * `bytes`：可變長度的字節數據，存儲任意長度的原始二進制數據。
        ```Solidity
        bytes32 public _byte32 = "MiniSolidity"; 
        bytes1 public _byte = _byte32[0];
        ```
    * 地址類型：
        * `address`：儲存以太坊地址。長度為 20 字節(以太坊地址的大小)，通常用來標識合約或帳戶。
        * `address payable`：特殊的 address，比普通地址多了 `transfer` 和 `send` 兩個方法，允許接收以太幣的轉賬。
        ```Solidity
        // 地址
        address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
        address payable public _address1 = payable(_address); // payable address，可以转账、查余额
        // 地址类型的成员
        uint256 public balance = _address1.balance; // balance of address
        ```
    * 枚舉 enum ：Solidity 中用戶定義的數據類型，使用自訂名稱代替從 0 開始的 uint。
    ```Solidity
    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;
    ```
    `enum` 可以和 `uint` 互相轉換
    ```Solidity
    // 將枚舉轉換為 uint
    function enumToUint() external view returns(uint){
        return uint(action); // 將 action 的枚舉值強制轉換為對應的 uint 類型。
    }
    // 將 uint 轉換為 enum
    function uintToEnum(uint _action) external {
        require(_action <= uint(ActionSet.Sell), "Invalid enum value"); // 檢查 _action 是否在 Action 枚舉的範圍內。
        action = ActionSet(_action);
    }
    ```
    <!-- ![alt text](uintToEnum-1.png#w10) -->
   
    <img src="https://github.com/user-attachments/assets/9a7f9550-ed8f-4e1e-8cbc-5961128787d6" height="400px" width="640px" />
3. **引用類型(Reference Type)**：不直接存儲數值，而是存儲指向數據的引用，進行賦值或函數調用時，傳遞的是數據的引用。
    * 字符串類型：`string`
    * 數組類型(`array`)：可在宣告時指定大小`T[k]`，也可動態調整`T[]`，其中的元素可以是任何類型。
        * 由 5 個 `int` 組成的動態 `array` 稱為 `int[][5]`。
        * `push()` 追加0元素，並返回追加的值。
        * `push(value)`。
        * `x[start:end]`。
    * 結構體(`struct`)：
        * 合約之外宣告，此 `struct` 可被多合約共享。
        * 在合約內部宣告，此 `struct` 只能被本合約與繼承合約共享。
4. **映射類型(Mapping Type)**：只能存在 `stroage` 數據位置。  
    * 映射類型使用語法：`mapping(KeyType KeyName? => ValueType ValueName?)`  
    * 映射類型變量使用語法：`mapping(KeyType KeyName? => ValueType ValueName?) VariableName`  
    `KeyType` 可為內置的值類型(ex.string, enum...)，用戶定義、複雜的類型不可(ex.映射, struct, array...)，`ValueType` 可為任何類型(ex.string, 映射, struct...)  
    [mapping 詳細介紹](<https://docs.soliditylang.org/zh/latest/types.html#mapping-types>)

### 2024.09.24

#### 函數
Solidity 函數形式：
```Solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
1. `function`：宣告 function 的固定用法。
2. `<function name>`：函數名。
3. `(<parameter types>)`：寫入函數的參數，包含變量類型與名稱。
4. `{internal|external|public|private}`：函數可見性說明符。  
函數需要明確定義可見性，沒有默認值。
    * `public`：內部與外部均可見。
    * `private`：只能從本合約內部訪問，繼承的合約不可使用。
    * `external`：只能從合約外部訪問(內部可通過 `this.f()` 調用)。
    * `internal`：只能從本合約內部訪問，繼承的合約可使用。

※在修飾變量時可使用 `public|private|internal` 默認為 `internal`，`public` 時會自動生成同名的 `getter` 函數，以查詢數值。

5. `[pure|view|payable]`：決定函數權限/功能的關鍵字。
    * `payable`：可支付的。
    * `pure‵`：不能讀或寫入鏈上的狀態變量。
    * `view`：能讀不能寫入鏈上的狀態變量。

6. `[returns ()]`：函数返回的变量类型和名称。

#### `Pure` 和 `View` 是什麼?
在乙太坊上交易如果改變了鏈上狀態則需要支付氣費(gas free)，但 gas free 很貴，因此創建了 `pure` 和 `view`，包含這兩個關鍵字的函數不改寫鏈上狀態，因此用戶呼叫後不需要付 gas。  
※非 `pure/view` 的函數呼叫 `pure/view` 時需要付gas。

**以下行為視為修改鏈上狀態**  
1. 寫入狀態變量
2. 釋放事件
3. 創建其他合約
4. 使用 `selfdestruct`
5. 通過調用發送乙太幣
6. 呼叫任何未標記 `pure/view` 的函數
7. 使用低級呼叫(low-level calls)
8. 使用包含某些操作碼的內聯匯編

<img src="https://github.com/user-attachments/assets/7cc09e0c-6f4e-4d84-94cb-f0af5913b54a" height="300px" width="640px" />  

`minusPayable()` 間接呼叫 `minus()`，並返回 ETH 餘額，透過 `this` 關鍵字可以引用合約地址，在呼叫 `minusPayable()` 時往合約中轉入 12 個 ETH。  
<img src="https://github.com/user-attachments/assets/a98c4fb5-3482-47c7-b4b7-ea0d1bfa8ffe" height="300px" width="640px" />

#### 函數輸出
**返回值：return/returns**  
* returns：跟在函式名之後，聲明返回的變量類型與變量名。
* return：在函式主體中，返回指定的變量。  
```Solidity
// 返回多變量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1), 2, 5])
}
```
※`uint256[3]` 聲明長度 3 且類型為 `uint256` 的數組為返回值，但若直接寫`[1, 2, 5]`會默認為 `uint8[3]`，因此第一個值須強制轉成 `uint256`，聲明該數組中的元素皆為 `uint256`。

**命令式返回**  
在 `returns` 中標明返回變量的名稱。Solidity 會初始化這些變量，並自動返回，無須使用 `return`。  
```Solidity
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```

**解構式返回**  

* 讀取所有返回值：聲明變量，後將要賦值的變量用 `,` 隔開，依序排列。
```Solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```

* 讀取部分返回值：聲明要讀取的返回值對應的變量，不讀取的留空。
```Solidity
(, _bool2, ) = returnNamed();
```
<img src="https://github.com/user-attachments/assets/384f7fe6-2d2e-482f-a122-d438b4ebea19" height="300px" width="640px" />  

### 2024.09.25

#### 變量數據存儲
**Solidity 的引用類型(Reference Type)**：數組(`array`)、結構體(`struct`)，因為這些類型的變量較複雜，占用的儲存空間較大，因此使用時要聲明數據存放的位置。

**數據儲存位置**：不同位置消耗的 `gas` 不同。  
`storage` 的數據存在鏈上，類似電腦的硬碟，消耗gas多，反之`memory`、`calldata` 消耗的 `gas` 少。
* `storage`：合約中的狀態變量默認都是 `storage`，儲存在鏈上。
* `memory`：函數中的參數和臨時變量，存在記憶體中，不上鏈。
* `calldata`：和 `memory` 類似，不上鏈。但不同點在於 `calldata` 變量是不可修改的(`immutable`)，通常是函數的參數。
    例子：
    ```
    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return(_x);
    }
    ```
**賦值規則**  
* 創建了本體的副本，修改新變量不會影響原變量。
* 創建引用指向本體，修改新變量會影響原變量。
    ```
    uint[] x = [1,2,3]; // 状态变量：数组 x
    function fStorage() public{
        //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }
    ```  
<img src="https://github.com/user-attachments/assets/68d5daa0-5d83-40b6-bbe6-de445ce13094" height="300px" width="600px" />  

<img src="https://github.com/user-attachments/assets/b91d6de8-1e7a-43b5-afd1-e8fa756c9e5c" height="300px" width="600px" />  

#### 變量的作用域
1. 狀態變量：數據存在鏈上的變量，在合約內、函數外宣告，所有合約內函數都可以訪問，`gas` 消耗高。
```Solidity
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}

// 可以在函数里更改状态变量的值
function foo() external{
    x = 5;
    y = 2;
    z = "0xAA";
}
```

2. 局部變量：僅在函數執行過程中才有效的變量，局部變量的數據存在記憶體中，不上鏈，`gas` 低。
```Solidity
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```

3. 全局變量：在全局範圍內工作的變量，都是 `solidity` 預留的關鍵字，可在不宣告的前提下就使用。
[常用的全局變量](<https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions>)
```Solidity
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender; // 請求發起地址
    uint blockNum = block.number; // 當前區塊高度
    bytes memory data = msg.data; // 請求數據
    return(sender, blockNum, data);
}
```

4. 全局變量-乙太單位與時間單位：  

**乙太單位**  
`Solidity` 中部存在小數點，以 `0` 代替小數點以確保交易的精確度損失。
* `wei`: 1e9 = 1
* `gwei`: 1e9 = 1000000000
* `ether`: 1e18 = 1000000000000000000

**時間單位**  
在合約中規定某事件在一定時間後發生，如此可使合約的執行更加精確。
* `seconds`: 1
* `minutes`: 60 seconds = 60
* `hours`: 60 minutes = 3600
* `days`: 24 hours = 86400
* `weeks`: 7 days = 604800

#### 引用類型
**數組 (array)**  
Solidity 常用的變量型態，儲存一組數據(整數、字節、地址...等)
* 固定長度 `array`：  
    ```solidity
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;
    ```

    * 以 `memory` 修飾的動態數組，可用 `new` 操作符創建，但必須宣告長度，且宣告後長度不能改變。
        ```Solidity
        uint[] memory array8 = new uint[](3);
        bytes memory array9 = new bytes(9);
        array8[0] = 1;
        array8[1] = 3;
        array8[2] = 4;
        ```

* 可變長度`array`：  
    ```solidity
    uint[] array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;
    ```
    ※ `bytes`是`array`但不用加`[]`，因為`bytes`為動態大小的字節數組，且它將所有字節緊湊地存儲在一起，這樣可以節省存儲空間，因此`bytes`比`bytes1[]` 省 gas。

* `method`：
    * `length`：取得數組長度，ex.`memory` 數組的長度固定。
    * `push()`：在數組最後加入 `0` 元素。
    * `push(x)`：在數組最後加入 `x` 元素。
    * `pop()`：移除數組最後一個元素。

**結構 (struct)**  
Solidity 可以透過建構`struct`的形式定義新的類型。`struct`中的元素可以是原始類型，也可以是引用類型，`struct`也可以作為數組或映射的元素。  
```Solidity
struct Student{
    uint256 id;
    uint256 score; 
}
Student student; // 初始一个student结构体
```
* 給`struct`賦值的方法：
    * 在函數中創建一個storage的struct引用  
    ```Solidity
    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }
    ```
    * 直接引用狀態變量的`struct`  
    ```Solidity
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }
    ```
    * 構造函數式  
    ```Solidity
    function initStudent3() external {
        student = Student(3, 90);
    }
    ```
    * key value  
    ```Solidity
    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }
    ```


### 2024.09.26

#### 映射(mapping)類型
在映射中，可以通過鍵(`key`)來查詢對應的值(`value`)，例如，藉由`id`查詢姓名。  
宣告映射的格式為`mapping(KeyType => ValueType)`，例子：  
```Solidity
mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址
```

**映射規則**  
1. `KeyType`只能為 Solidity 內置的值類型，ex.`uint`, `address`...，不能用自定義的結構，ex.`struct`，使用後會報錯。
2. 映射的數據必須存在`storage`中，因此可以用於合約的狀態變量，但不能用於`public`函數的參數或返回結果中，因為`mapping`紀錄的是關係(key-value pair)，且是一種動態的、潛在無限長的結構，無法輕易地序列化或打包為交易的有效負載傳遞。
3. `mapping`宣告為`public`時，Solidity 會自動創建一個`getter`函數，可以通過`key`查詢對應的`value`。
4. 為`mapping`新增新的值對：`_Var[_Key] = _Value`，`_Var`是映射變量名，`_Key`和`_Value`是對英的鍵值對。
    ```
    function writeMap (uint _Key, address _Value) public{
        idToAddress[_Key] = _Value;
    }
    ```

**映射原理**  
1. `mapping`不儲存任何鍵(`key`)的資訊，也沒有length。
2. `mapping`並不直接儲存每個鍵值對，而是使用哈希計算：`keccak256(abi.encodePacked(key, slot))`當成 offset 存取 value，`slot`是映射變量定義所在的插槽位置。
3. Ethereumc會定義所有未使用的空間為0，所以未賦值(`value`)的鍵(`key`)初始值都是各個型別的默認值，ex.`uint`的默認值是0。

#### 變量初始值
在 Solidity 中，宣告但沒賦值的變量都有其初始值。  
* `boolean`: `false`
* `string`: `""`
* `int`: `0`
* `uint`: `0`
* `enum`: 枚举中的第一个元素
* `address`: `0x0000000000000000000000000000000000000000` (或 `address(0)`)
* `function`
    * `internal`: 空白函数
    * `external`: 空白函数
    ```Solidity
    bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum; // 第1个内容Buy的索引0

    function fi() internal{} // internal空白函数
    function fe() external{} // external空白函数 
    ```
    <img src="https://github.com/user-attachments/assets/22f1f38e-71bc-4820-84f1-8d1df1398be8" height="400px" width="640px" />
    <img src="https://github.com/user-attachments/assets/7708bdf1-f6d3-46a2-a8a6-0817fea6a932" height="400px" width="640px" />

### 2024.09.27

#### 常數
* `constant`（常量）：宣告的時候就必須初始化(需要顯式初始化)，之後無法改變。
    ```Solidity
    uint256 constant CONSTANT_NUM = 10;
    ```
* `immutable`（不變量）：在8.0.21後，`immutable`不需要顯式初始化(可以使用系統自動分配的默認值)。若`immutable`在宣告時初始化，且在`constructor`中再次初始化，會依最後賦予的值為標準，之後無法改變。
    <img src="https://github.com/user-attachments/assets/29577185-fd41-4949-8111-4843b2979fc9" height="300px" width="640px" />
    <img src="https://github.com/user-attachments/assets/c7f9707c-7304-4392-bd9c-8c1b5837f938" height="300px" width="640px" />

※變量不隨意改變的特性可以節省`gas`，並提升合約的安全性。

> 題目：  
> 2.下面定义变量的语句中，会报错的一项是：  
> 选择一个答案  
> A. string constant x5 = "hello world";  
> B. address constant x6 = address(0);  
> C. string immutable x7 = "hello world";  
> D. address immutable x8 = address(0);  
>
> ANS：  
> 選項 C 會報錯，因為 immutable 變量不能在聲明時初始化字面值，必須在 構造函數 中初始化。而 constant 變量可以在聲明時初始化字面值。
    <img src="https://github.com/user-attachments/assets/b50ecca8-7e27-4f10-9b82-4da17ef25fdf" height="300px" width="640px" />

#### 控制流
1. `if-else`：
    ```Solidity
    function ifElseTest(uint256 _number) public pure returns(bool){
        if(_number == 0){
            return(true);
        }else{
            return(false);
        }
    }
    ```
2. `for loop`：
    ```Solidity
    function forLoopTest() public pure returns(uint256){
        uint sum = 0;
        for(uint i = 0; i < 10; i++){
            sum += i;
        }
        return(sum);
    }
    ```
3. `while`：
    ```Solidity
    function whileTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        while(i < 10){
            sum += i;
            i++;
        }
        return(sum);
    }
    ```
4. `do while`：
    ```Solidity
    function doWhileTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        do{
            sum += i;
            i++;
        }while(i < 10);
        return(sum);
    }
    ```
5. 三元運算子：Solidity 中唯一一個接受三個操作數的運算符，規則條件? 條件為真的表達式:條件為假的表達式。此運算符經常用作if語句的快捷方式。
    ```Solidity
    // 三元运算符 ternary/conditional operator
    function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
        // return the max of x and y
        return x >= y ? x: y; 
    }
    ```
6. `conitnue`：立刻進入下輪循環。
7. `break`：跳出當前循環。

#### 插入排序
```Solidity
    // 插入排序 错误版
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
因為Solidity使用的`uint`只能為正整數，若取到負值則會有`underflow`錯誤，在以上的程式中`j`有可能取到`-1`。
```Solidity
// 插入排序 正确版
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


<!-- Content_END -->
