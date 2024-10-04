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
### 2024.09.28

#### 構造函數和修飾器
以合約權限(`Ownable`)的例子介紹。  
* `constructor`構造函數：每個合約可以定義一個，在部屬合約後會自動運行一次，可以用來初始化合約的參數。  
```Solidity
address owner; // 定义owner变量
// 构造函数
constructor(address initialOwner) {
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}
```
※在0.4.22前，構造函數命名為與合約同名。


* `modifier`修飾器：Solidity特有的語法，主要使用在運行函數前的檢查，ex.地址、變量、餘額等...。  
```Solidity
// 定义modifier
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是否为owner地址
   _; // 如果是的话，继续运行函数主体；否则报错并revert交易
}
```  
圖中示意：以 owner 地址的身分呼叫`changeOwner`，交易成功。  
<img src="https://github.com/user-attachments/assets/7e3ba257-9ff7-47a6-ba99-5880982bd550" height="380px" width="640px" />  

※[OpenZeppelin](<https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol>)是維護標準化程式庫的組織。

#### 事件
Solidity 的事件是`EVM`(乙太坊虛擬機)上的日誌抽象
以轉帳ERC20為例。  

* 特點：
    * 響應：應用程式`ether.js`可以通過`RPC`接口訂閱及監聽事件，而實現與區塊鏈的互動。當合約觸發事件時，前端應用程式可以根據事件的數據做出相應的響應。  
    ex.觸發轉帳成功，前端捕捉到此事件後，告知用戶已轉帳成功。
    * 經濟：`event`是`EVM`上相對經濟的存儲方式。觸發一個事件大概消耗2000 gas，而在區塊鏈上儲存一個新的變量至少需要20000 gas，因此`event`可以有效節省資源。
        * 事件的數據會存儲在 交易日誌 中，這些日誌儲存在區塊鏈上，但不會被合約內部直接存取，只能通過外部工具查詢和訂閱。
        * 日誌存儲在區塊鏈的交易日誌部分，而不是持久化存儲中，這使得它的操作更經濟。
* 宣告方式：用`event`宣告，接者加上事件名稱。
ex.  
    ```Solidity
    event Transfer(address indexed from, address indexed to, uint256 value);
    ```  
    以上程式中，共紀錄了3個變量`from`、`to`、`value`，分別對應代幣的轉帳地址、接收地址、轉帳數量...  
此外，`from`、`to`前面帶有`indexed`關鍵字，會保存到虛擬日誌的`topics`中，以便日後檢索。

* 釋放事件：在函數中釋放事件。  
以下例子中，每次用`_transfer()`函數轉帳時都會釋放`Transfer`事件，並記錄相應變量。  
    ```Solidity
    // 定义_transfer函数，执行转账逻辑
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {

        _balances[from] = 10000000; // 给转账地址一些初始代币

        _balances[from] -=  amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量

        // 释放事件
        emit Transfer(from, to, amount);
    }
    ```

#### `EVM`日誌(log)：
`EVM`使用`log`儲存Solidity事件，每條日誌都包含主題`topics`與數據`data`兩部分。  
* `topics`：log的第一部分是主題數組，用於標識事件類型，長度不能超過`4`，第一個元素是事件的hash，對於上例的`Transfer`事件：
    ```Solidity
    keccak256("Transfer(address,address,uint256)")

    //0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
    ```

    除了hash主題還可以包含最多3個`indexed`參數，也是`Transfer`事件中的`from`和`to`。 
    * 檢索效率：indexed 參數用作主題的索引，方便區塊鏈上的事件查詢。通過將參數標記為 `indexed`，可以將其設置為檢索鍵，這樣可以過濾事件，只返回指定參數值的事件。
    *  固定大小限制：每個 `indexed` 參數的大小固定為 256 bytes。如果參數過大，例如字符串或數組，Solidity 會自動將它們哈希化後存儲在主題中。
   
* `data`：這是事件觸發時記錄的具體數據，包括事件的非索引參數。這些數據可以在交易日誌中找到。  
    * 事件中不帶`indexed`的參數會被存在`data`中，這部分的變量不能被直接檢索但可以儲存任意大小的數據。
    * `data`這部分的變量在儲存上消耗的`gas`比`topics`更少。

### 2024.09.29

#### 繼承
* 規則：
    * `virtual`：父合約中的函數，在子合約中若需要重寫，要加上`virtual`關鍵字。
    * `override`：若在子合約中重寫了父合約中的函數，則需要加上`override`關鍵字。
    ※若`override`修飾`public`變量，則會重寫與變量同名的`getter`函數。
        ```Solidity
        mapping(address => uint256) public override balanceOf;
        ```
* 簡單繼承  
* 多重繼承：  
    <img src="https://github.com/user-attachments/assets/17214f31-0096-4916-a729-d7933688a3fc" height="360px" width="640px" />
* 修飾器的繼承：  
    <img src="https://github.com/user-attachments/assets/3be399d9-db0d-46cf-85ba-c2e14c635ed5" height="360px" width="640px" />
* 構造函數的繼承：  
    <img src="https://github.com/user-attachments/assets/41b6900f-810b-4372-90ce-bada2f1918af" height="360px" width="640px" />
* 調用父合約：  
    1. 直接調用：直接用`父合約名.函數名()`的方式調用父合約函數。
    2. `super`關鍵字：子合約可以利用`super.函數名()`調用最近的父合約函數。  
    以多重繼承下方的圖片為例，`super.pop()`將呼叫`Baba.pop()`。

* 鑽石(菱形)繼承：  
    ```
    /* 继承树：
    God
    /  \
    Adam Eve
    \  /
    people
    */
    ```
    <img src="https://github.com/user-attachments/assets/3e33e3ea-c1fb-4a69-8812-2c726a37b267" height="360px" width="640px" />


#### 抽象(abstract)合約
合約中若至少有一個未實現的函數，即某個函數缺少主體`{}`中的內容，則此合約必須標為`abstract`，且未實現的函數須加上`virtual`，以便子合約重寫。  
ex.
```Solidity
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```
### 2024.09.30

#### 接口(interface)
類似抽象合約，但不實現任何功能。  
* 規則：
    1. 不能包含狀態變量
    2. 不能包含構造函數
    3. 不能繼承接口以外的其他合約
    4. 所有函數都必須是external且不能有函數體
    5. 繼承 interface 的非抽象合約必須實現 interface 定義的所有功能  

interface 是智能合約的骨架，定義了合約的功能及如何觸發，若合約實現了某種接口，ex.`ERC20`、`ERC721`，其他`Dapps`和合約就知道該如何與此智能合約交互。  
* 作用：
    1. 標準化交互：  
    如果某個智能合約實現了一個通用的接口（如 ERC20 或 ERC721），那麼其他合約或應用程序就能根據這個接口來與其互動，有助於跨平台、跨合約之間的兼容性。
    2. 定義合約中的功能：  
    接口會定義每個函數的名稱和參數類型，以及這些函數如何被調用，這相當於描述了合約的公共 API。
    3. 定義每個函數哈希(`bytes4`選擇器)、函數簽名(`函數名(每個參數類型)`)，以通過對函數的簽名進行哈希後得到獨特的4字節哈希。  
        ```Solidity
        keccak256("transfer(address,uint256)").slice(0, 4)
        ```
    4. 接口 ID：  
    接口 ID 是一個唯一的標識符，用來表示某個合約是否實現了某個接口。


```Solidity
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
}
```

#### 什麼時候使用interface?
若知道一個合約實現了`IERC721`，不需要知道他的具體程式實現就可以與之交互。  
ex.  
```Solidity
contract interactBAYC {
    // 利用BAYC地址创建接口合约变量（ETH主网）
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    // 通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }

    // 通过接口调用BAYC的safeTransferFrom()安全转账
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
        BAYC.safeTransferFrom(from, to, tokenId);
    }
}
```

#### 異常
異常命令可以幫助尋找錯誤。  
* `error`：可以在`contract`之外拋出異常，高效且方便的向用戶解釋操作失敗的原因，且在拋出異常時可攜帶參數。  
ex.定義`TransferNotOwner`異常，當用戶不是貨幣`owner`時轉帳會拋出錯誤。  
    ```Solidity
    error TransferNotOwner(); // 自定义error

    // 攜帶參數的異常，以提示轉帳的帳戶地址
    error TransferNotOwner(address sender); // 自定义的带参数的error
    ```
    `error`需搭配`revert`命令使用：  
    當用戶不是貨幣`owner`時轉帳會拋出錯誤，否則成功轉帳。  
    ```Solidity
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if(_owners[tokenId] != msg.sender){
            revert TransferNotOwner();
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }
    ```
* `require`：消耗的gas比`error`高，且會隨著描述異常的字符串長度增加，gas也隨之增加。  
    * 使用方法：`require(檢查條件，"異常的描述")`，檢查條件不成立時，拋出異常。  
    ```Solidity
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;
    }
    ```
* `assert`：不能解釋拋出異常的原因(相較`require`少了字符串)，但仍會在檢查條件不成立時拋出異常。
    ```Solidity
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }
    ```
#### 驗證
輸入任意數字、非0地址，呼叫以各種語法寫的異常訊息。  
<img src="https://github.com/user-attachments/assets/eb044a25-9abd-401b-9fa1-3ecaf76f8d55" height="160px" width="640px" />  
<img src="https://github.com/user-attachments/assets/fe715ee9-c9be-4db7-ae31-168af6192a1e" height="155px" width="640px" />  
<img src="https://github.com/user-attachments/assets/5c7d044b-ac35-48b5-afe6-62e615b4a2ce" height="115px" width="640px" />  

* `error`方法`gas`消耗：24457(加入參數後`gas`消耗：24660)
* `require`方法`gas`消耗：24755
* `assert`方法`gas`消耗：24473  
`error`方法`gas`消耗最少，`require`方法消耗最多，因此在求最小`gas`消耗下可以多加使用`error`。

### 2024.10.01

#### 重載`overload`
重載意即名稱相同但輸入參數類型不同的函數可以同時存在，且視為不同的函數。  
```Solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```  
#### 實參匹配`Argument Matching`  
在呼叫`overload`函數時，會把輸入的實際參數和函數參數的變量做匹配。若出現多個匹配的重載函數，會報錯。  
ex.若呼叫`f()`，且傳入`50`，因為`50`可以被轉換為`uint8`，也可以被轉換為`uint256`，因此會報錯。
```Solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```

> Solidity中是否允许修饰器（modifier）> 重载？  
> 选择一个答案  
> A. 允许
> B. 不允许
>
> ANS：B. 不允许  
>解釋：
>Solidity 中不允許修飾器（modifier）重載。修飾器是用來修改函數行為的一段代碼邏輯，它不能像函數那樣通過不同的參數來進行重載。每個修飾器必須有唯一的名稱，且不能有相同名稱但不同參數的多個修飾器。

> 下面两个函数的函数选择器是否相同？
> ```solidity
> function f(uint8 _in) public pure returns (uint8 out) { 
> out = _in; 
> } 
>
> function f(uint256 _in) public pure returns (uint256 out) { 
> out = _in; 
> }
> 
> A. 相同
> B. 不相同
> ANS:B

#### 庫合約
為一種特殊的合約，目的是為了提升程式的復用性和減少gas。庫合約是一系列的函數合集。  
* 相較普通合約的特殊點：
    1. 不能存在狀態變量
    2. 不能繼承或被繼承
    3. 不能接收以太幣
    4. 不可以被銷毀  

庫合約中函數的可見性若被設為`public`或`external`，則在呼叫函數時會觸發一次`delegatecall`。設為`internal`，則不會引起。設為`private`的函數僅能在庫合約中可見。

#### Strings庫合約
`Strings庫合約`是將`uint256`類型轉換為`string`類型的程式庫。  

ex.以下的程式主要包含兩個函數，`toString()`將`uint256`轉換為`string`，`toHexString()`將`uint256`轉換為`16進制`，再轉換為`string`。  
```Solidity
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

#### 如何使用庫合約
1. 利用using for指令：  
`using A for B;`，用於附加合約(從庫A)到任何類型(B)。執行完畢後，庫A中的函數會自動添加為B類型變量的成員，並可以直接呼叫。  
```Solidity
// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```

2. 通過庫合約名稱呼叫函數：
```Solidity
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```

> Q：库合约和普通合约的区别，下列描述错误的是：  
> 
> A. 库合约不能存在状态变量  
> B. 库合约不能继承  
> C. 库合约可以被继承  
> D. 库合约不能被销毁  
> 
> A：C，庫合約不能被繼承，這使得它與普通合約不同。


**常用庫合約**  
* `Strings`：將`uint256`轉換為`String`。
* `Address`：判斷某個地址是否為合約的地址。
* `Create2`：更安全的使用`Create2 EVM opcode`。
* `Arrays`：跟數組相關的庫合約。

### 2024.10.02
#### `import`
`import`可以用來在一個文件中引用另一個文件的內容，提高程式的可重用性、組織性。  

**用法：**  
* 通過源文件相對位置導入：  
    ```Solidity
    文件结构
    ├── Import.sol
    └── Yeye.sol

    // 通过文件相对位置import
    import './Yeye.sol';
    ```
* 通過源文件網址導入網上合約的全局符號：  
    ```Solidity
    // 通过网址引用
    import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
    ```
* 通過`npm`的目錄導入：  
    ```Solidity
    import '@openzeppelin/contracts/access/Ownable.sol';
    ```
* 通過指定`全局符號`導入合約特定的全局符號。  
    ```Solidity
    import {Yeye} from './Yeye.sol';
    ```
<img src="https://github.com/user-attachments/assets/b89ea127-e9a5-4d3f-bd5e-3997e88a4a32" height="400px" width="600px" />  

> Q：Solidity中import的作用是：
>
> A. 导入其他合约中的接口  
> B. 导入其他合约中的私有变量  
> **C. 导入其他合约中的全局符号**  
> D. 导入其他合约中的内部变量  
> 
> Ans：import 可以導入所有全局可用的符號（如函數、結構、事件等），這是最全面的描述。

> Q：import导入文件中的全局符号可以单独指定其中的：
> 
> A. 合约  
> B. 纯函数  
> C. 结构体类型  
> **D. 以上都可以**
>
> Ans：  
> A. 合約：可以單獨導入合約，例如 import {Yeye} from "./Yeye.sol";。
> 
> B. 纯函数：可以導入純函數（如果存在），例如 import {someFunction} from "./SomeLib.sol";。
> 
> C. 结构体类型：結構體類型也可以單獨導入，例如 import {SomeStruct} from "./SomeStruct.sol";。

> Q：被导入文件中的全局符号想要被其他合约单独导入，应该怎么编写？
> 
> A. 将合约结构包含  
> B. 包含在合约结构中  
> **C. 与合约并列在文件结构中** 
> 
> Ans：在 Solidity 中，如果你想要導入某個文件中的全局符號（例如合約、函數、結構體等），這些符號必須在文件的最外層與合約並列定義，而不是在合約內部。這樣才能被其他合約單獨導入。 

### 2024.10.03

#### 接收ETH
Solidity支持兩種特殊的回調函數，`receive()`和`fallback()`。  
* 使用情況：
    1. 接收ETH
    2. 處理合約中不存在的函數調用 (代理合約proxy contract)

※ 在Solidity 0.6.x版本之前，只有`fallback()`函數，0.6版本之後`fallback()`函数才被拆分成`receive()`和`fallback()`。


**`receive()`**  
* 用途：`receive()` 函數在合約收到 ETH 轉帳時被呼叫的函數。
* 特點：
    * 只能有一個 receive() 函數
    * 宣告時不用`function`關鍵字
    * 不接受任何參數，並且沒有返回值，且必須包含`external`和`payable`。
    * 合約接收 ETH 的時候，`receive()`會被觸發，函數中不能執行太多邏輯，因為當用`send`、`transfer`方法發送 ETH 時，gas 會被限制在`2300`，此時`receive()`太複雜會觸發`Out of Gas`報錯；如果用`call`就可以自定義gas以執行更複雜的邏輯。
    

    ```Solidity
    // 定义事件
    event Received(address Sender, uint Value);
    // 接收ETH时释放Received事件
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    ```
    ※ 有些恶意合约，会在receive() 函数（老版本的话，就是 fallback() 函数）嵌入恶意消耗gas的内容或者使得执行故意失败的代码，导致一些包含退款和转账逻辑的合约不能正常工作，因此写包含退款等逻辑的合约时候，一定要注意这种情况。


**`fallback()`**  
* 用途：`fallback()` 函數會在呼叫不存在的函數時被觸發。可用於接收 ETH；也可用於代理合約`proxy contract`。
* 特點：
    * 宣告時不用`function`關鍵字
    * 必須由`external`和`payable`修飾，用於接收ETH:`fallback() external payable { ... }`。
event fallbackCalled(address Sender, uint Value, bytes Data);

    ex.以下程式，觸發時會釋放`fallbackCalled`事件，並輸出`msg.sender`，`msg.value`和`msg.data`：
    ```Solidity
    // fallback
    fallback() external payable{
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }
    ```

**`receive`和`fallback`的區別**  
`receive`和`fallback`都能用於接收 ETH，觸發規則如下：
```
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
```  
※ 合約接收到 ETH 時，`msg.data`為空且存在`receive()`時，會觸發`receive()`；`msg.data`不為空或不存在`receive()`時，會觸發`fallback()`，此時`fallback()`必須為`payable`。  

`receive()`和`payable fallback()`均不存在時，向合約直接發送 ETH 將會報錯(但仍可以通過帶有`payable`的函數向合約發送 ETH)。


### 2024.10.04
#### 發送 ETH
Solidity 中向其他合約發送`ETH`的方法共有三種：`transfer()`、`send()`、`call()`(最鼓勵使用)。  

**接收 ETH 合約**  
部署一個接收`ETH`的合約 `ReceiveETH`，其中有一個事件`Log`，事件會記錄收到的`ETH`數量和`gas`剩餘；兩個函數(1)`receive()`，收到`ETH`後被觸發，(2)`getBalance()`，查詢合約的`ETH`餘額。
```Solidity
contract ReceiveETH {
    // 收到eth事件，紀錄amount和gas
    event Log(uint amount, uint gas);

    // receive 方法，接收eth時被觸發
    receive() external payable{
        emit Log(msg.value, gasleft());
    }

    // 返回合約ETH餘額
    function getBalance() view public returns(uint) {
        retuen address(this).balance;
    }
}
```

**發送 ETH 合約**  
實作三種方法向`ReceiveETH`合約發送`ETH`。先在發送ETH合約的`SendETH`中實現`payable`的`constructor`和`receive()`，使我們能在部署時和部署後向合約轉帳。  
```Solidity
contract SendETH{
    // 構造函數，payable使的部署的時向合約發送eth
    constructor() payable{}
    // receuve方法，接收eth時被觸發
    receive() external payable{}
}
```
**transfer**  
* `接收方地址.transfer(發送ETH數額)`
* `transfer()`的`gas`限制是`2300`，足夠用於轉帳，但對方合約的`fallback()`、`receive()`不能實作太複雜的邏輯。
* `transfer()`如果轉帳失敗，會自動`revert`(回滾交易)。
```Solidity
// 用transfer()發送ETH
function transferETH(address payable  _to, uint256 amount) external payable{
    _to.transfer(amount); // 接收方地址.transfer(發送ETH數額)
}
```

**send**  
* `接收方地址.send(發送ETH數額)`
* `send()`的`gas`限制是`2300`，足夠用於轉帳，但對方合約的`fallback()`、`receive()`不能實作太複雜的邏輯。
* `send()`如果轉帳失敗，不會自動`revert`。
* `send()`的返回值是`bool`，代表轉帳成功或失敗。
```Solidity
error SendFailed(); // 用send發送ETH失敗

// send()發送ETH
function sendETH(address payable _to, uint256 amount) external payable{
    // 處理send的返回值，如果失敗，revert交易並發送error
    bool success = _to.send(amount);
    if(!success){
        revert SendFailed();
    }
}
```

**call**  
* `接收方地址.call{value: 發送ETH數額}("")`
* `call()`沒有`gas`限制，可支持對方合約實作複雜邏輯。
* `call()`如果轉帳失敗，不會自動`revert`。
* `call()`的返回值是`(bool, bytes)`，`bool`代表轉帳成功或失敗。
```Solidity
error CallFailed(); // 用call發送ETH失敗

// call()發送ETH
function callETH(address payable _to, uint256 amount) external payable{
    // 處理call的返回值，如果失敗，revert交易並發送error
    (bool success,) = _to.call{value: amount}("");
    if(!success){
        revert CallFailed();
    }
}

```


<!-- Content_END -->
