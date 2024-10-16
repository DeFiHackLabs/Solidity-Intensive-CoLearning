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
### 2024.10.05

#### 調用已部署合約
Solidity 中，一個合約可以調用另一個合約的函數，在建構 DAPP 時非常有用。

**目標合約**  
假設現在有一個簡單的合約`OtherContract`，用於被其他合約調用。  
其中包含狀態變量`_x`，事件`Log`在收到`ETH`時觸發，三個函數：`getBalance()`、`seX()`、`getX()`。
```Solidity
contract OtherContract {
    uint256 private _x = 0; // 状态变量_x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取_x
    function getX() external view returns(uint x){
        x = _x;
    }
}
```
1. 傳入合約地址  
    在函數中傳入目標合約地址，生成目標合約的引用，然後調用目標函數。  
    ```Solidity
    function callSetX(address _Address, uint256 x) external{
        OtherContract(_Address).setX(x);
    }
    ```  
    <img src="https://github.com/user-attachments/assets/3406e27f-908e-4710-ad58-6fc2da0d0d59" height="360px" width="640px" />  

2. 傳入合約變量  
    直接在函數裡傳入合約的引用。  
    ```Solidity
    function callGetX(OtherContract _Address) external view returns(uint x){
        x = _Address.getX();
    }
    ```
    <img src="https://github.com/user-attachments/assets/940b17e9-9eeb-44b2-bdc2-1c271e8f436b" height="360px" width="640px" />  

3. 創建合約變量  
    創建新合約變量，並通過合約變量來調用目標函數。  
    ```Solidity
    function callGetX2(address _Address) external view returns(uint x){
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }
    ```
    <img src="https://github.com/user-attachments/assets/bf1c009f-6160-40ad-a7c4-9903487c5936" height="360px" width="640px" />  

4. 調用合約並發送`ETH`  
    如果目標合約的函數是`payable`的，可通過調用其來給合約轉帳。  
    `_Name(_Address).f{value: _Value}()`，其中`_Name`是合约名，`_Address`是合约地址，`f`是目标函数名，`_Value`是要转的`ETH`数额（以`wei`为单位）。  
    ```Solidity
    function setXTransferETH(address otherContract, uint256 x) payable external{
        OtherContract(otherContract).setX{value: msg.value}(x);
    }
    ```
    <img src="https://github.com/user-attachments/assets/095b828f-adbe-4e85-938d-4709c7636194" height="360px" width="640px" />  
    <img src="https://github.com/user-attachments/assets/0ee4ba76-40cd-4261-9709-30334d81f5d2" height="120px" width="640px" />  

> Q:假设我们部署了合约 OtherContract （合约内容见下）  
> 其合约地址为 0xd9145CCE52D386f254917e481eB44e9943F39138。我们希望在另一个合约中调用该合约，考虑如下两种方式：
> ```
> //OtherContract 合约如下：
> // SPDX-License-Identifier: MIT
> pragma solidity ^0.8.6;
> 
> interface IOtherContract {
>     function getBalance() external returns(uint);
>     function setX(uint256 x) external payable;
>     function getX() external view returns(uint x);
> }
> 
> contract OtherContract is IOtherContract{
>     uint256 private _x = 0;
>     event Log(uint amount, uint gas);
>     
>     function getBalance() external view override returns(uint) {
>         return address(this).balance;
>     }
> 
>     function setX(uint256 x) external override payable{
>         _x = x;
>         if(msg.value > 0){
>             emit Log(msg.value, gasleft());
>         }
>     }
> 
>     function getX() external view override returns(uint x){
>         x = _x;
>     }
> }
> ```
> ```
> (1) OtherContract other = OtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138)
> (2) IOtherContract other = IOtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138)
> ```
> 下列说法正确的是：  
> A. (1)(2) 两种写法均会报错  
> B. 仅 (1) 是调用其他合约的正确写法，(2) 会报错  
> C. 仅 (2) 是调用其他合约的正确写法，(1) 会报错  
> D. (1)(2) 均是调用其他合约的正确写法  
> 
> Ans:D  
> (1) 直接实例化合约 OtherContract：这是通过已知的合约地址实例化一个合约对象。这种方式在合约内部执行的操作和直接在其他合约中执行是等价的，因为合约 OtherContract 已经被部署，并且已知其地址。
>
> (2) 通过接口 IOtherContract 实例化：这是一种更灵活的方式，通过接口可以在合约的不同版本之间更轻松地进行交互。只要目标合约实现了 IOtherContract 接口，便可以通过该接口的方式进行调用。这也同样是正确的调用方法。

### 2024.10.06
#### Call
`call`是`address`類型的低級成員函數，運行時動態調用其他合約的函數。返回值為`(bool, bytes memory)`，分别對應`call`是否成功以及目標函數的返回值。
* `Gas`：調用者可以控制調用時提供的 `gas`，多餘的 `gas` 會退還给調用者。
* `call`是solidity官方推薦的通過觸發`fallback`或`receive`函數發送`ETH`的方法。
* 不建議用`call`調用另一個合約，因為當調用的是不安全合約的函數時，就等於將主動權交給了它。建議使用先宣告合約變量再調用函數的方式。
* 當不知道對方合約的源代碼或者ABI時，就沒辦法生成合約變量，此時仍可以通過`call`調用對方合約的函數。

**call使用規則**
```Solidity
目标合约地址.call(字节码);
```
其中`字節碼`利用結構化編碼函數`abi.encodeWithSignature`獲得：

```Solidity
// abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)

(bool success, bytes memory data) = targetContract.call(
    abi.encodeWithSignature("someFunction(uint256)", 123)
);
```
`函數簽名`為`"函數名（逗號分隔的參數類型）"`。例如`abi.encodeWithSignature("f(uint256,address)", _x, _addr)`。

另外`call`在調用合約時可以指定交易發送的`ETH`數額和`gas`數額：
```Solidity
目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
```

**目標合約**
與上章的`OtherContract`基本相同，但多了`fallback`函數。
```Solidity
contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth的事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    fallback() external payable{}

    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns(uint x){
        x = _x;
    }
}
```

**利用`call`調用目標合約**

1.Response事件
我們寫一個`call`合約來呼叫目標合約的函數，首先定義一個`Response`事件，輸出`call`返回的`success`和`data`，以觀察返回值。

```solidity
// 定义Response事件，输出call返回的结果success和data
event Response(bool success, bytes data);
```

2.調用setX函數
定義`callSetX`函數去調用目標合約的`setX()`，轉入`msg.value`數額的`ETH`，並釋放`Response`事件輸出`success`和`data`:
```solidity
function callSetX(address payable _addr, uint256 x) public payable {
    // call setX()，同时可以发送ETH
    (bool success, bytes memory data) = _addr.call{value: msg.value}(
        abi.encodeWithSignature("setX(uint256)", x)
    );

    emit Response(success, data); //释放事件
}
```
接著調用`callSetX`把狀態變量`_x`改為5，參數為`OtherContract`地址和`5`，由於目標函數`setX()`沒有返回值，因此`Response`事件輸出的`data`為`0x`，意即空。  
<img src="https://github.com/user-attachments/assets/f0942773-38a4-4cd4-b576-c8ca371f6541" height="320px" width="600px" />  

3.調用getX函數

調用`getX`函數，將返回目標合約`_x`的值，類型為`uint256`。可以用`abi.decode`解碼`call`的返回值`data`，並輸出數值。

```Solidity
function callGetX(address _addr) external returns(uint256){
    // call getX()
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("getX()")
    );

    emit Response(success, data); //释放事件
    return abi.decode(data, (uint256));
}
```  
<img src="https://github.com/user-attachments/assets/e95459d3-8916-4e39-a701-3ffbd0855874" height="200px" width="600px" /> 


4.調用不存在的函數
如果輸入`call`的目標函數不存在目標合約，那麼目標合約的`fallback`被觸發。

```Solidity
function callNonExist(address _addr) external{
    // call 不存在的函数
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("foo(uint256)")
    );

    emit Response(success, data); //释放事件
}
```
<img src="https://github.com/user-attachments/assets/f37fc1bf-4da7-4590-824a-1aff8f86d161" height="100px" width="600px" /> 

### 2024.10.07

#### Delegatecall
`delegatecall`與`call`類似，是 Solidity 中地址類型的低級成員函數。與`cal`的區別是會在調用者合約的上下文中執行被調用合約的程式。`delegate`意即`委託`。  

當用戶`A`通過合約`B`來`call`合約`C`的時候，執行的是合約`C`的函數，上下文(`content`，理解為包含變量和狀態的環境)是合約`c`的。  
<img src="https://github.com/user-attachments/assets/56b71df3-dc9f-41af-a61c-6797ea0a5c6e" height="230px" width="600px" />  
當用戶`A`通過合約`B`來`delegatecall`合約`C`的時候，執行的是合約`C`的函數，上下文是合約`b`的，且若函數改變一些狀態變量，產生的效果會作用在合約`B`的變量上。  
想像成：投資者(A)將資產(B)交給風險投資者(C)。執行者是C，但改變的是B。
<img src="https://github.com/user-attachments/assets/fce7d048-c081-4b84-951b-87256a7a16b0" height="230px" width="600px" />  

**語法**  
```Solidity
目标合约地址.delegatecall(二进制编码);
```  
其中二进制编码利用结构化编码函数abi.encodeWithSignature获得：  
```Solidity
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
```  
`函数签名`为`"函数名（逗号分隔的参数类型）"`。例如`abi.encodeWithSignature("f(uint256,address)", _x, _addr)`。  
與`call`不一樣，`delegatecall`在調用合約時可以指定教意發送的`gas`，但不能指定發送的`ETH`數額。

**※ 注意：**`delegatecall`有安全隱患，使用時要保證當前合約和目標合約的狀態變量存儲結構相同，並且目標合約相同，不然會造成資產損失。

#### 什麼情況下會用到`delegatecall`?
1. 代理合約(`Proxy Contract`)：將智能合約的儲存合約跟邏輯合約(`Logic Contract`)分開，`Proxy Contract`存儲所有相關變量，並保存邏輯合約的地址；所有函數存在邏輯合約中，藉由`delegatecall`執行。當升級時，只需要將代理合約指向新的邏輯合約。
2. EIP-2535 Diamonds(鑽石)：鑽石是一個支持構建可在生產中擴展的模塊化智能合約系統的標準。鑽石是具有多個實施合約的代理合約。  
[鑽石標準簡介](<https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard>)


#### `delegatecall`例子
結構：你(A)通過合約B調用目標合約C。  
* 被調用的合約C  
先寫一個簡單的目標合約C：  
兩個`public`變量：`uint num`、`address sender`  
函數`setVars(uint _num)`，可將`num`設定為傳入的`_num`，並將`sender`設為`msg.sender`。  
```Solidity
// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}
```
* 發起調用的合約B  
合約`B`與目標合約`C`的變量存儲布局必須相同，兩個變量順序需要相同(先`num`後`sender`，變量名稱可以不同)。  
```Solidity
contract B {
    uint public num;
    address public sender;
}
```  


```Solidity
// 通过call来调用C的setVars()函数，将改变合约C里的状态变量
// _addr 對應合約c的地址
// _num 對應合約c的參數
function callSetVars(address _addr, uint _num) external payable{
    // call setVars()
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );
}
```

```Solidity
// 通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量
function delegatecallSetVars(address _addr, uint _num) external payable{
    // delegatecall setVars()
    (bool success, bytes memory data) = _addr.delegatecall(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );
}
```

#### call vs delegatecall 的主要區別

| 特性 | call | delegatecall |
| :-- | :-- | :-- |
| 狀態變量上下文 | 目標合約(C)的狀態變量 | 調用者合約(B)的狀態變量 | 
| `msg.sender` | 目標合約的 `msg.sender` | 調用者合約的 `msg.sender` | 
| `msg.value` | 目標合約接收到的 `msg.value` | 調用者合約接收到的 `msg.value` | 
| 存儲修改 | 修改目標合約的存储 | 修改調用者合約的存储 | 
| 適用場景 | 常規的合約調用、發送 ETH | 代理合約模式、庫合約復用 | 
| 函數執行上下文 | 在目標合約中執行 | 在調用者合約的上下文中執行 | 


> 2.当用户A通过合约B来delegatecall合约C时，执行了__的函数，语境是__，msg.sender和msg.value来自__， 并且如果函数改变一些状态变量，产生的效果会作用于__的变量上。  
> A. C;B;A;B  
> B. C;C;B;C  
> C. B;B;A;B  
> D. C;B;A;C  
> 
> Ans:A  
> * 執行了合約 C 的函數，因為 delegatecall 是調用合約 C 的函數代碼。  
> * 語境 是合約 B，這是因為 delegatecall 繼承了合約 B 的上下文，即使用合約 B 的存儲空間和狀態變量。  
> * msg.sender 和 msg.value 來自用戶 A，這些參數在 delegatecall 中保持不變。  
> * 如果函數改變了一些狀態變量，這些改變會作用於合約 B 的變量上，因為 delegatecall 使用了合約 B 的存儲。  

> 3.delegatecall在调用合约时__________________________  

> A. 可以指定交易发送的gas，也可以指定发送的ETH数额  
> B. 可以指定交易发送的gas，但不可以指定发送的ETH数额  
> C. 不可以指定交易发送的gas，也不可以指定发送的ETH数额  
> D. 不可以指定交易发送的gas，但可以指定发送的ETH数额  
> 
> Ans:B  
> * 它可以指定交易發送的 gas，因為 delegatecall 的語法允許透過 {gas: xxx} 來設定 gas 限制。
> * 但 delegatecall 不能 發送 ETH，因為它僅傳遞執行上下文，不會攜帶任何資金轉移。


> 6.在代理合约中，存储所有相关的变量的是___，存储所有函数的是___，同时____________  

> A. 代理合约; 逻辑合约; 代理合约delegatecall逻辑合约  
> B. 代理合约; 逻辑合约; 逻辑合约delegatecall代理合约  
> C. 逻辑合约; 代理合约; 代理合约delegatecall逻辑合约  
> D. 逻辑合约; 代理合约; 逻辑合约delegatecall代理合约  
> 
> Ans:A  
> * 代理合約（Proxy Contract）存儲所有相關的狀態變量，因為所有狀態的變更都會發生在代理合約的存儲空間。
> * 邏輯合約（Logic Contract）存儲所有函數，實際的邏輯運行是在邏輯合約中定義的函數中完成的。
> * 代理合約使用 delegatecall 呼叫邏輯合約來執行函數，這樣變更會影響代理合約的存儲。

### 2024.10.08

#### 在合約中創建新合約
在乙太坊鏈上，用戶(外部帳戶，EOA)和智能合約都具備創建新的智能合約的能力。這種功能的實現使的合約之間可以互相交互、組合，並實現更複雜的去中心化應用(DApps)。  
中心化交易所`uniswap`就是利用工廠合約(`PairFactory`)創建和管理無數個交易對合約(`Pair Contract`)，每個交易對合約代表一個特定的代幣對（如 ETH/DAI）。  

**`create`**  
有兩種方法可以在合約中創建新合約，`create`和`create2`。  
`create`的用法很簡單，就是`new`一個合約，並傳入新合約構造函數所需的參數：  
`Contract`是要創建的合約名，`x`是合約對象(地址)，如果構造函數是`payable`，可以創建時傳入`_value`數量的`ETH`，`params`是新合約構造函數的參數。  
```Solidity
Contract x = new Contract{value: _value}(params)
```  

#### 極簡Uniswap
`Uniswap V2`核心合約中包含兩個合約：  
1. UniswapV2Pair: 幣對合約，用於管理幣對地址、流動性、買賣。  
2. UniswapV2Factory: 工廠合約，用於創建新幣對，並管理幣對地址。  

以下用`create`方法實現簡易版的`Uniswap`。  

**`Pair`合約**  
```Solidity
contract Pair{
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }
}
```  
`Pair`合約很簡單，包含3個狀態變量：`factory`, `token0`和`token1`。  
構造函數`construct`在部署時將`factory`賦值為工廠合約的地址。`initialize`函數會由工廠合約在部署完成後手動調用已初始化代幣地址，將`token`和`token1`更新為幣對中兩種代幣的地址。  

> 为什么uniswap不在constructor中将token0和token1地址更新好？
> 
> 因为uniswap使用的是create2创建合约，生成的合约地址可以实现预测，更多详情请阅读第25讲。

**`PairFactory`**  
```Solidity
contract PairFactory{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
        // 创建新合约
        Pair pair = new Pair(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }
}
```  

工廠合約(PairFactory)有兩個狀態變量`getPair`是兩個代幣地址到幣對地址的map，方便根據代幣找到幣對地址。  

`PairFactory`合約只有一個`createPair`函數，根據輸入的兩個代幣地址`tokenA`、`TokenB`來創建新的`Pair`合約。  
以下為創建合約的程式：  
```Solidity
Pair pair = new Pair(); 
```  

```
WBNB地址: 0x2c44b726ADF1963cA47Af88B284C06f30380fC78
BSC链上的PEOPLE地址: 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c
```

### 2024.10.09

#### Create2
`create2`使在智慧合約部署在乙太坊網路之前就能預測合約的地址。而`CREATE`在部署合約前無法確定其具體地址。  
`CREATE2`可以根據一組已知的參數來生成一個確定的合約地址，這樣的特性被廣泛應用於去中心化應用中，特別是像`Uniswap`，用來創建`Pair`合約。

**為什麼使用 `CREATE2`？**  
* 預測合約地址：CREATE2 能夠預測合約的最終部署地址，這在構建去中心化應用時具有極大的優勢。開發者可以提前知道合約地址，並進行相關的鏈上交互。
* 可重複部署：由於合約地址是基於一些固定參數計算出的，如果之前的合約被刪除，可以在同樣的地址重新部署合約。
* 提高確定性：能夠在不部署合約的情況下進行地址計算，有助於提升合約開發與部署的確定性和靈活性。

#### CREATE 如何計算地址
當使用`CREATE`部署新合約時，合約的地址是基於以下兩個參數計算的：  
1. 部署者地址：發起合約創建的 EOA 或合約的地址。
2. 部署者的`nonce`：部署者的交易計數，表示該部署者在當前狀態下發送的交易數量。  
這兩個參數會通過 Ethereum 的哈希函數`keccak256`進行哈希，得出合約的最終地址。  
```
新地址 = hash(創建者地址, nonce)
```
創建者地址不會變，但`nonce`可能隨時間而改變，因此用`CREATE`創建的合約地址不好預測。

#### CREATE2 如何計算地址
`CREATE2`的合約地址是根據以下四個因素計算得出的：  
1. `0xFF`：一个常數，避免和`CREATE`冲突。
2. `CreatorAddress`(合約部署者地址)：調用`CREATE2`的當前合約（創建合約）地址。
3. `salt`（鹽值）：一個隨機數(`bytes32`)，通常用於生成獨特的合約地址。
4. `initcode`：新合約的初始字節碼，用來創建合約的編碼數據。
```
新地址 = hash("0xFF",创建者地址, salt, initcode)
```
其中`0xff`是一個常數，用來區分`CREATE2`生成的地址和`CREATE`生成的地址。  
`CREATE2`確保若使用者使用`CREATE2`和提供的`salt`部署給定的合約`initcode`，將儲存在`新地址`中。

#### 如何使用`CREATE2`
其中`Contract`是要創建的合約名，`x`是合約對象（地址），`_salt`是指定的鹽；如果構造函數是`payable`，可以創建時轉入`_value`數量的ETH，`params`是`新合約構造函數的参數。
```Solidity
Contract x = new Contract{salt: _salt, value: _value}(params)
```

#### 極簡Uniswap2
用`CREATE2`實現。  
`Pair`  
```Solidity
contract Pair{
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }
}
```

`PairFactory2`  
```Solidity
contract PairFactory2{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair2(address tokenA, address tokenB) external returns (address pairAddr) {
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //避免tokenA和tokenB相同产生的冲突
        // 用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 用create2部署新合约
        Pair pair = new Pair{salt: salt}(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }
}
```

工廠合約（`PairFactory2`）有兩個狀態變量`getPair`是兩個代幣地址到幣對地址的`map`，方便根據代幣找到幣對地址；`allPairs`是幣對地址的數組，存儲了所有幣對地址。  
`PairFactory2`合約只有一个`createPair2`函數，使用`CREATE2`根據輸入的兩個代幣地址`tokenA`和`tokenB`來創建新的`Pair`合約。其中
```Solidity
Pair pair = new Pair{salt: salt}(); 
```  
就是利用`CREATE2`創建合約的代碼，非常簡單，而`salt`為`token1`和`token2`的`hash`：  
```Solidity
bytes32 salt = keccak256(abi.encodePacked(token0, token1));
```  

#### 事先计算`Pair`地址  
```Solidity
// 提前计算pair合约地址
function calculateAddr(address tokenA, address tokenB) public view returns(address predictedAddress){
    require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //避免tokenA和tokenB相同产生的冲突
    // 计算用tokenA和tokenB地址计算salt
    (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
    bytes32 salt = keccak256(abi.encodePacked(token0, token1));
    // 计算合约地址方法 hash()
    predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        bytes1(0xff),
        address(this),
        salt,
        keccak256(type(Pair).creationCode)
        )))));
}
```

```Solidity
WBNB地址: 0x2c44b726ADF1963cA47Af88B284C06f30380fC78
BSC链上的PEOPLE地址: 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c
```
**如果部署合約構造函數中存在参數**
```
Pair pair = new Pair{salt: salt}(address(this));
```
計算時，需要將參數和`initcode`一起打包：  
```
keccak256(type(Pair).creationCode) => keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
```

```Solidity
predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
            )))));
```
#### 驗證  
1. 首先用WBNB和PEOPLE的地址哈希作为salt来计算出Pair合约的地址
2. 调用PairFactory2.createPair2传入参数为WBNB和PEOPLE的地址，获取出创建的pair合约地址
3. 对比合约地址  
<img src="https://github.com/user-attachments/assets/7d4d71a9-8713-4bfd-90b4-16f10509de14" height="340px" width="600px" />  


### 2024.10.10

#### 刪除合約

`selfdestruct`
* 此命令用來刪除智能合約，並將該合約剩餘`ETH`轉到指定地址。
* 是為了應對合約出錯的極端情況而設計的。  

1. 已经部署的合约无法被SELFDESTRUCT了。
2. 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。

#### 如何使用`selfdestruct`：
```Solidity
selfdestruct(_addr)；
```  
其中_addr是接收合约中剩余ETH的地址。_addr 地址不需要有receive()或fallback()也能接收ETH。

#### Demo-转移ETH功能
當調用`deleteContract()`函數，合約將觸發`selfdestruct`操作。在坎昆升級前，合約會被自毁。但是在升級後，合約依然存在，只是將合約包含的ETH轉移到指定地址，而合約依然能够調用。    
```Solidity
contract DeleteContract {

    uint public value = 10;

    constructor() payable {}

    receive() external payable {}

    // 调用selfdestruct销毁合约，并把剩余的ETH转给msg.sender
    function deleteContract() external {
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}
```


**Demo-同笔交易内实现合约创建-自毁**  
根据提案，原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以我们需要通过另一个合约进行控制。

```Solidity
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

**※注意：**  
1. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
2. 当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

**總結**  
`selfdestruct`是智能合約的緊急按钮，銷毀合約並將剩餘`ETH`轉移到指定帳戶。

> 判断：所有合约创建时都必须包含“selfdestruct”的命令，否则会报错：
>
> A. 正确
> B. 错误
> B. 错误。
>
>并不是所有合约在创建时都必须包含 selfdestruct 命令。selfdestruct 是一种可选的功能，用于销毁合约并将剩余的以太币发送到指定的地址。如果一个合约不需要销毁功能，它可以完全不包含 selfdestruct 命令，合约依然可以正常部署和运行，不会报错。

### 2024.10.11

#### ABI編碼解碼
`ABI` (Application Binary Interface，應用二進制接口)是與以太坊智能合約交互的標準。數據基於他们的類型編碼；並且由於編碼後不包含類型信息，解碼時需要注明它們的類型。

Solidity中，`ABI编码`有4個函數：`abi.encode`, `abi.encodePacked`, `abi.encodeWithSignature`, `abi.encodeWithSelector`。  
`ABI解码`有1个函數：`abi.decode`，用于解码`abi.encode`的數據。  
这一讲，我们将学习如何使用这些函數。

#### ABI編碼
4個變量：  
```Solidity
uint x = 10;
address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
string name = "0xAA";
uint[2] array = [5, 6]; 
```
`abi.encode`  
將给定参數利用[ABI規則](<https://learnblockchain.cn/docs/solidity/abi-spec.html>)编碼。`ABI`被設計出来跟智能合約交互，他將每个參數填充為32字節的數據，並拼接在一起。如果你要和合約交互，要用的就是`abi.encode`。  
```Solidity
function encode() public view returns(bytes memory result) {
    result = abi.encode(x, addr, name, array);
}
```  
編碼的結果為编码的结果为`0x000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，由於`abi.encode`將每個數據都填充為32字節，中間有很多`0`。

`abi.encodePacked`  
將给定参數根據其所需最低空間編碼。它類似`abi.encode`，但是會把其中填充的很多0省略。比如，只用1字節來编碼`uint8`类型。当你想省空间，并且不與合約交互的時候，可以使用`abi.encodePacked`，例如算一些數據的`hash`時。
```Solidity
function encodePacked() public view returns(bytes memory result) {
    result = abi.encodePacked(x, addr, name, array);
}
```

编码的结果为`0x000000000000000000000000000000000000000000000000000000000000000a7a58c0be72be218b41c608b7fe7c5bb630736c713078414100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006`，由于`abi.encodePacked`对编码进行了压缩，长度比`abi.encode`短很多。

`abi.encodeWithSignature`  
与`abi.encode`功能类似，只不过第一个参数为`函数签名`，比如`"foo(uint256,address,string,uint256[2])"`。当调用其他合约的时候可以使用。  
```Solidity
function encodeWithSignature() public view returns(bytes memory result) {
    result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
}
```

编码的结果为`0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，等同于在`abi.encode`编码结果前加上了4字节的`函数选择器`说明。 说明: 函数选择器就是通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用

`abi.encodeWithSelector`  
与`abi.encodeWithSignature`功能类似，只不过第一个参数为`函数选择器`，为`函数签名`Keccak哈希的前4个字节。
```Solidity
function encodeWithSelector() public view returns(bytes memory result) {
    result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
}
```  
编码的结果为`0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，与`abi.encodeWithSignature`结果一样。  


#### ABI解碼
`abi.decode`  
`abi.decode`用于解码`abi.encode`生成的二进制编码，将它还原成原本的参数。  
```Solidity
function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
    (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
}
```  
將`abi.encode`的二進制編碼輸入給`decode`，將解碼出原來的参數：  
<img src="https://github.com/user-attachments/assets/e1b46761-d5a1-466b-a1a1-f7a1f2e602e1" height="200px" width="300px" />

#### ABI的使用場景
1. 在合约开发中，ABI常配合call来实现对合约的底层调用。
```Solidity
bytes4 selector = contract.getValue.selector;

bytes memory data = abi.encodeWithSelector(selector, _x);
(bool success, bytes memory returnedData) = address(contract).staticcall(data);
require(success);

return abi.decode(returnedData, (uint256));
```

2. ethers.js中常用ABI实现合约的导入和函数调用。
```Solidity
const wavePortalContract = new ethers.Contract(contractAddress, contractABI, signer);
    /*
    * Call the getAllWaves method from your Smart Contract
    */
const waves = await wavePortalContract.getAllWaves();
```

3. 对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用。
    * 0x533ba33a() 是一个反编译后显示的函数，只有函数编码后的结果，并且无法查到函数签名  
    <img src="https://github.com/user-attachments/assets/48fc14e8-a0b4-4df8-aa77-9bb108adadda" height="120px" width="360px" />
    <img src="https://github.com/user-attachments/assets/5d9aea9a-eb18-48c2-baca-7905819c76d5" height="120px" width="600px" />

    * 这种情况无法通过构造interface接口或contract来进行调用  
    <img src="https://github.com/user-attachments/assets/e397fa4b-1acc-4e12-9369-c0ba32f577f7" height="120px" width="600px" />

    ```Solidity
    bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a));

    (bool success, bytes memory returnedData) = address(contract).staticcall(data);
    require(success);

    return abi.decode(returnedData, (uint256));
    ```

**總結**  
在以太坊中，数据必须编码成字节码才能和智能合约交互。


> 1.当我们调用智能合约时，传递给合约的数据的前若干个字节被称为“函数选择器 (Selector)”，它告诉合约我们想要调用哪个函数。假设我们想要调用的函数在智能合约中定义声明如下：
> ```
> function foo(uint256 n, address sender, string s) public view returns(bool b)
> ```
> 那么该函数对应的函数选择器为：
>
> A. "foo(uint256,address,string)" 
> B. "foo(uint256 n, address sender, string s)" 
> C. keccak256("foo(uint256,address,string)") 
> D. keccak256("foo(uint256 n, address sender, string s)") 
> E. bytes4(keccak256("foo(uint256,address,string)")) 
> F. bytes4(keccak256("foo(uint256 n, address sender, string s)"))
> 
> Ans: E. bytes4(keccak256("foo(uint256,address,string)"))。  
> 解釋：  
> 當我們想要調用智能合約中的函數時，使用的函數選擇器 (Selector) 是這個函數的簽名的 Keccak256 哈希值的前 4 個字節。  
> 函數的簽名是函數名稱和參數類型（不包括參數名稱）的組合，例如 "foo(uint256,address,string)"。  
> 然後對該簽名進行 keccak256 哈希計算，取哈希結果的前 4 個字節作為函數選擇器。



> 2.下列有关ABI编码的函数中，返回值不可能当作调用智能合约的数据的一项是：  
> A. abi.encode 
> B. abi.encodePacked 
> C. abi.encodeWithSignature 
> D. abi.encodeWithSelector
>
> Ans: B. abi.encodePacked。
>
> 解釋：  
> `abi.encode`、`abi.encodeWithSignature`和`abi.encodeWithSelector`都會返回可以直接作為呼叫合約時的`calldata`使用的編碼結果，它們分別針對不同的情境（如指定函數簽名或函數選擇器）。  
> `abi.encodePacked`雖然也可以進行編碼，但其返回的是緊湊型編碼（packed encoding），這種編碼方式可能導致哈希碰撞或編碼數據不完整，因此不能直接用作智能合約的`calldata`。


> 3.函数abi.decode用于将二进制编码解码，它对应的逆向操作函数（反函数）是：
>
> A. abi.encode  
> B. abi.encodePacked  
> C. abi.encodeWithSignature  
> D. abi.encodeWithSelector
>
> 正確答案是 A. abi.encode  
> 解釋：  
> `abi.decode` 用於將二進制數據解碼回其原始的 Solidity 資料類型。  
> `abi.encode` 是其逆向操作，它將 Solidity 資料類型編碼為二進制形式。

> 4.已知函数foo在智能合约中定义声明如下：
> ```
> function foo(uint256 a) public view
> ```
> 而字符串"foo(uint256)"的keccak256哈希值为：
>
> ```
> 0x2fbebd3821c4e005fbe0a9002cc1bd25dc266d788dba1dbcb39cc66a07e7b38b
> ```  
> 那么，当我们希望调用函数foo()时，以下生成调用数据的写法中，正确且最节省gas的一项是：  
>
> A. abi.encodeWithSignature("foo(uint256)", a)  
> B. abi.encodeWithSelector("foo(uint256)", a)  
> C. abi.encodeWithSelector(bytes(keccak256("foo(uint256)")), a)  
> D. abi.encodeWithSelector(bytes4(0x2fbebd38), a)
> 
> 正確答案是 D. abi.encodeWithSelector(bytes4(0x2fbebd38), a)  
> 解釋：  
> abi.encodeWithSelector 是一個有效的方法來生成函數的調用數據，其中函數的 selector（前四個 bytes 的 Keccak256 哈希值）可以被直接使用。  
> 選項 D 使用了已知的函數 selector 0x2fbebd38，並傳遞參數 a，這樣直接使用 selector，避免了在調用中再去計算哈希值，從而節省了 gas。

### 2024.10.12

哈希函數(hash)是一個密碼學概念，它可以將任意長度的消息轉換為一個固定長度的值，這個值也稱作哈希(hash)。

#### Hash
好的哈希函數具有以下幾個特徵：  
* 單向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
* 靈敏性：输入的消息改变一点对它的哈希改变很大。
* 高效性：从输入的消息到哈希的运算高效。
* 均一性：每个哈希值被取到的概率应该基本相等。
* 抗碰撞性：
    * 弱抗碰撞性：給定一個`x`，找到另個`x'`，使的`hash(x)=hash(x')`是困難的。
    * 強抗碰撞性：找到兩個不同的輸入導致相同的輸出（哈希值）非常困難，但若長度是無限的，必然會有碰撞。

#### Hash的應用
* 生成數據唯一標識
* 加密签名
* 安全加密

**Keccak256**  
Keccak256函数是Solidity中最常用的哈希函数，用法：  
```Solidity
哈希 = keccak256(数据);
```

**Keccak256和sha3**  
1. sha3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。所以SHA3就和keccak计算的结果不一样，这点在实际开发中要注意。
2. 以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。

#### 生成数据唯一标识  

可以利用keccak256来生成一些数据的唯一标识。比如我们有几个不同类型的数据：uint，string，address，我们可以先用abi.encodePacked方法将他们打包编码，然后再用keccak256来生成唯一标识：

```Solidity
function hash(
    uint _num,
    string memory _string,
    address _addr
    ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_num, _string, _addr));
}
```

#### 弱抗碰撞性
我们用`keccak256`演示一下之前讲到的弱抗碰撞性，即给定一个消息`x`，找到另一个消息`x'`，使得`hash(x) = hash(x')`是困难的。

给定一个消息`0xAA`，试图去找另一个消息，使得它们的哈希值相等：  
```Solidity
// 弱抗碰撞性
function weak(
    string memory string1
    )public view returns (bool){
    return keccak256(abi.encodePacked(string1)) == _msg;
}
```

#### 强抗碰撞性
我们用`keccak256`演示一下之前讲到的强抗碰撞性，即找到任意不同的`x`和`x'`，使得`hash(x) = hash(x')`是困难的。

我们构造一个函数`strong`，接收两个不同的`string`参数`string1`和`string2`，然后判断它们的哈希是否相同：  
```Solidity
// 强抗碰撞性
function strong(
        string memory string1,
        string memory string2
    )public pure returns (bool){
    return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
}
```

<img src="https://github.com/user-attachments/assets/0be0c95b-a333-467d-8dd1-387e6ce1c5eb" height="400px" width="640px" />

### 2024.10.13

#### 函數選擇器(Selector)
當調用智能合約時，本質上是向目標合約發送了一段`calldata`。


**msg.data**  
`msg.data`是Solidity中的一个全局變量，值為完整的`calldata`（調用函數時傳入的數據）。  
在下面的代碼中，可以通過`Log`事件來輸出調用`mint`函數的`calldata`：
```Solidity
// event 返回msg.data
event Log(bytes data);

function mint(address to) external{
    emit Log(msg.data);
}
```  
当参数为0x2c44b726ADF1963cA47Af88B284C06f30380fC78时，输出的calldata为  
```
0x6a6278420000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
```  
这段很乱的字节码可以分成两部分：  
```
前4个字节为函数选择器selector：
0x6a627842

后面32个字节为输入的参数：
0x0000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
```  
其实calldata就是告诉智能合约，我要调用哪个函数，以及参数是什么。  

#### method id、selector和函数签名
* `method id`定義為函數簽名的`Keccak`哈希后的前4个字節。
* 當`selector`與`method id`相匹配時，即表示調用該函數。
* 函數簽名，為`"函數名（逗號分隔的参數類型)"`。


**基础类型参数**  
`solidity`中，基础类型的参数有：`uint256`(`uint8`, ... , `uint256`)、`bool`, `address`等。在计算`method id`时，只需要计算`bytes4(keccak256("函数名(参数类型1,参数类型2,...)"))`。例如，如下函数，函数名为`elementaryParamSelector`，参数类型分别为`uint256`和`bool`。所以，只需要计算`bytes4(keccak256("elementaryParamSelector(uint256,bool)"))`便可得到此函数的`method id`。

```Solidity
    // elementary（基础）类型参数selector
    // 输入：param1: 1，param2: 0
    // elementaryParamSelector(uint256,bool) : 0x3ec37834
    function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4 selectorWithElementaryParam){
        emit SelectorEvent(this.elementaryParamSelector.selector);
        return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
    }
```

**固定长度类型参数**  
固定长度的参数类型通常为固定长度的数组，例如：`uint256[5]`等。例如，如下函数`fixedSizeParamSelector`的参数为`uint256[3]`。因此，在计算该函数的`method id`时，只需要通过`bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))`即可。  

```Solidity
    // fixed size（固定长度）类型参数selector
    // 输入： param1: [1,2,3]
    // fixedSizeParamSelector(uint256[3]) : 0xead6b8bd
    function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
        emit SelectorEvent(this.fixedSizeParamSelector.selector);
        return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
    }
```

**可变长度类型参数**  
可变长度参数类型通常为可变长的数组，例如：`address[]`、`uint8[]`、`string`等。例如，如下函数`nonFixedSizeParamSelector`的参数为`uint256[]`和`string`。因此，在计算该函数的method id时，只需要通过`bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"))`即可。
```Solidity
    // non-fixed size（可变长度）类型参数selector
    // 输入： param1: [1,2,3]， param2: "abc"
    // nonFixedSizeParamSelector(uint256[],string) : 0xf0ca01de
    function nonFixedSizeParamSelector(uint256[] memory param1,string memory param2) external returns(bytes4 selectorWithNonFixedSizeParam){
        emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
        return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
    }
```

**映射类型参数**  
映射类型参数通常有：`contract`、`enum`、`struct`等。在计算`method id`时，需要将该类型转化成为`ABI`类型。

例如，如下函数`mappingParamSelector中DemoContract`需要转化为`address`，结构体`User`需要转化为`tuple`类型`(uint256,bytes)`，枚举类型`School`需要转化为`uint8`。因此，计算该函数的`method id`的代码为`bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"))`。

```Solidity
contract DemoContract {
    // empty contract
}

contract Selector{
    // Struct User
    struct User {
        uint256 uid;
        bytes name;
    }
    // Enum School
    enum School { SCHOOL1, SCHOOL2, SCHOOL3 }
    ...
    // mapping（映射）类型参数selector
    // 输入：demo: 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99， user: [1, "0xa0b1"], count: [1,2,3], mySchool: 1
    // mappingParamSelector(address,(uint256,bytes),uint256[],uint8) : 0xe355b0ce
    function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
        emit SelectorEvent(this.mappingParamSelector.selector);
        return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
    }
    ...
}
```

#### 使用selector
我们可以利用`selector`来调用目标函数。例如我想调用`elementaryParamSelector`函数，我只需要利用`abi.encodeWithSelector`将`elementaryParamSelector`函数的`method id`作为`selector`和参数打包编码，传给`call`函数：

```Solidity
    // 使用selector来调用函数
    function callWithSignature() external{
    ...
        // 调用elementaryParamSelector函数
        (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
    ...
    }
```




### 2024.10.14

#### Try Catch

`try-catch`只能被用於`external`函數或創建合約時`constructor`（被視為`external`函數）的調用。  
`externalContract.f()`是某個外部合約的函數調用，`try`在調用成功的情况下運行，而`catch`則在調用失敗時執行。  
可以使用`this.f()`來替代`externalContract.f()`，`this.f()`也被視作為外部調用，但不可在構造函數中使用，因為此時合約還未創建。  
```Solidity
try externalContract.f() {
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```  

如果調用的函數有返回值，那麼必須在`try`之後聲明`returns(returnType val)`，並且在`try`中可以使用返回的變量；如果是創建合約，那麼返回值是新創建的合約變量。  
`catch`支持特殊的異常原因：  
```Solidity
try externalContract.f() returns(returnType){
    // call成功的情况下 运行一些代码
} catch Error(string memory /*reason*/) {
    // 捕获revert("reasonString") 和 require(false, "reasonString")
} catch Panic(uint /*errorCode*/) {
    // 捕获Panic导致的错误 例如assert失败 溢出 除零 数组访问越界
} catch (bytes memory /*lowLevelData*/) {
    // 如果发生了revert且上面2个异常类型匹配都失败了 会进入该分支
    // 例如revert() require(false) revert自定义类型的error
}
```

#### `try-catch`實例
`OnlyEven`
```Solidity
# 创建一个外部合约OnlyEven，并使用try-catch来处理异常
contract OnlyEven{
    # 当a=0时，require会抛出异常；当a=1时，assert会抛出异常；其他情况均正常。
    constructor(uint a){
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    # 当b为奇数时，require会抛出异常。
    function onlyEven(uint256 b) external pure returns(bool success){
        // 输入奇数时revert
        require(b % 2 == 0, "Ups! Reverting");
        success = true;
    }
}
```

**处理外部函数调用异常**  
```Solidity
// 调用成功会释放的事件
event SuccessEvent();

// CatchEvent和CatchByte是抛出异常时会释放的事件，分别对应require/revert和assert异常的情况。
event CatchEvent(string message);
event CatchByte(bytes data);

// 声明even是个OnlyEven合约变量
OnlyEven even;

constructor() {
    even = new OnlyEven(2);
}


// 在execute函数中使用try-catch处理调用外部函数onlyEven中的异常
function execute(uint amount) external returns (bool success) {
    try even.onlyEven(amount) returns(bool _success){
        // call成功的情况下
        emit SuccessEvent();
        return _success;
    } catch Error(string memory reason){
        // call不成功的情况下
        emit CatchEvent(reason);
    }
}
```

<img src="https://github.com/user-attachments/assets/9c1dc954-3162-4426-95ea-0c60a5c756cb" height="330px" width="640px" />

<img src="https://github.com/user-attachments/assets/58366fda-8148-40fe-a38b-711d9167eda9" height="330px" width="640px" />


**处理合约创建异常**  
利用`try-catch`来处理合约创建时的异常。只需要把`try`改写为`OnlyEven`合约的创建就行：  
```Solidity
// 在创建新合约中使用try-catch （合约创建被视为external call）
// executeNew(0)会失败并释放`CatchEvent`
// executeNew(1)会失败并释放`CatchByte`
// executeNew(2)会成功并释放`SuccessEvent`
function executeNew(uint a) external returns (bool success) {
    try new OnlyEven(a) returns(OnlyEven _even){
        // call成功的情况下
        emit SuccessEvent();
        success = _even.onlyEven(a);
    } catch Error(string memory reason) {
        // catch失败的 revert() 和 require()
        emit CatchEvent(reason);
    } catch (bytes memory reason) {
        // catch失败的 assert()
        emit CatchByte(reason);
    }
}
```

<img src="https://github.com/user-attachments/assets/6c95b81b-d35f-4fac-a3ea-8fefc9a0898e" height="330px" width="640px" />

<img src="https://github.com/user-attachments/assets/2f1707a4-edae-44e9-9daf-a651bba32ca1" height="330px" width="640px" />

<img src="https://github.com/user-attachments/assets/bd9c3a2e-a299-4cff-8cb7-9de48ace1307" height="330px" width="640px" />

#### 總結  
使用try-catch来处理智能合约运行中的异常：  
* 只能用于外部合约调用和合约创建。
* 如果try执行成功，返回变量必须声明，并且与返回的变量类型相同。


> 1.try-catch可以捕获什么异常？  
> A. revert()  
> B. require()  
> C. assert()  
> D. 以上都可以
>
> Ans:D


> 2.以下异常返回值类型为bytes的是：  
> A. revert()  
> B. require()  
> C. assert()  
> D. 以上都是  
>
> Ans:C

> 3.try-catch捕获到异常后是否会使try-catch所在的方法调用失败？  
> A. 会  
> B. 不会
>
> Ans:B

> 4.try代码块内的revert是否会被catch本身捕获？  
> A. 会  
> B. 不会
>
> Ans:B

### 2024.10.15

#### ERC20
`ERC20`是太坊上的代幣標準，它實現了代幣轉帳的基本邏輯：  
* 帳戶餘額(balanceOf())
* 轉帳(transfer())
* 授權轉帳(transferFrom())
* 授權(approve())
* 代幣總供給(totalSupply())
* 授權轉帳額度(allowance())
* 代幣信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())

#### IERC20
IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件。  

* 事件：
    `IERC20`定义了`2`个事件：`Transfer`事件和`Approval`事件，分别在转账和授权时被释放  
    ```Solidity
    // @dev 释放条件：当 `value` 单位的货币从账户 (`from`) 转账到另一账户 (`to`)时.
    event Transfer(address indexed from, address indexed to, uint256 value);

    // @dev 释放条件：当 `value` 单位的货币从账户 (`owner`) 授权给另一账户 (`spender`)时.
    event Approval(address indexed owner, address indexed spender, uint256 value);
    ```

* 函數：
    `IERC20`定义了`6`个函数，提供了转移代币的基本功能，并允许代币获得批准，以便其他链上第三方使用。

    * `totalSupply()`返回代币总供给
    ```Solidity
    // @dev 返回代币总供给.
    function totalSupply() external view returns (uint256);
    ```

    * `balanceOf()`返回账户余额
    ```Solidity
    // @dev 返回账户`account`所持有的代币数.
    function balanceOf(address account) external view returns (uint256);
    ```

    * `transfer()`转账
    ```Solidity
    /**
    * @dev 转账 `amount` 单位代币，从调用者账户到另一账户 `to`.
    * 如果成功，返回 `true`.
    * 释放 {Transfer} 事件.
    */
    function transfer(address to, uint256 amount) external returns (bool);
    ```

    * `allowance()`返回授权额度
    ```Solidity
    /**
    * @dev 返回`owner`账户授权给`spender`账户的额度，默认为0。
    * 当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
    */
    function allowance(address owner, address spender) external view returns (uint256);
    ```

    * `approve()`授权
    ```Solidity
    /**
    * @dev 调用者账户给`spender`账户授权 `amount`数量代币。
    * 如果成功，返回 `true`.
    * 释放 {Approval} 事件.
    */
    function approve(address spender, uint256 amount) external returns (bool);
    ```

    * `transferFrom()`授权转账
    ```Solidity
    /**
    * @dev 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
    * 如果成功，返回 `true`.
    * 释放 {Transfer} 事件.
    */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    ```

#### 實現ERC20
寫一個`ERC20`，將`IERC20`規定的函數簡單實現。  
**状态变量**  

```Solidity
mapping(address => uint256) public override balanceOf;

mapping(address => mapping(address => uint256)) public override allowance;

uint256 public override totalSupply;   // 代币总供给

string public name;   // 名称
string public symbol;  // 代号

uint8 public decimals = 18; // 小数位数
```

* 函數  
    * 构造函数：初始化代币名称、代号。
    ```Solidity
    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
    }
    ```

    * `transfer()`函数：实现IERC20中的transfer函数，代币转账逻辑。调用方扣除amount数量代币，接收方增加相应代币。土狗币会魔改这个函数，加入税收、分红、抽奖等逻辑。
    ```Solidity
    function transfer(address recipient, uint amount) public override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    ```

    * `approve()`函数：实现IERC20中的approve函数，代币授权逻辑。被授权方spender可以支配授权方的amount数量的代币。spender可以是EOA账户，也可以是合约账户：当你用uniswap交易代币时，你需要将代币授权给uniswap合约。
    ```Solidity
    function approve(address spender, uint amount) public override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    ```

    * `transferFrom()`函数：实现IERC20中的transferFrom函数，授权转账逻辑。被授权方将授权方sender的amount数量的代币转账给接收方recipient。
    ```Solidity
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

    * `mint()`函数：铸造代币函数，不在IERC20标准中。这里为了教程方便，任何人可以铸造任意数量的代币，实际应用中会加权限管理，只有owner可以铸造代币：
    ```Solidity
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
    ```

    * `burn()`函数：销毁代币函数，不在IERC20标准中。
    ```Solidity
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    ```

### 2024.10.16

#### 代幣水龍頭
代幣水龍頭是讓用戶免費領帶幣的網站/應用。  
最早的代幣水龍頭是彼特幣(BTC)水龍頭。  

#### ERC20水龍頭合約
簡易的`ERC20`合約：將一些`ERC20`代幣轉入合約中，用戶可以通過合約`requestToken()`函數去領取`100`單位的代幣，每個地址只能領一次。  

**狀態變量**  
```Solidity
uint256 public amountAllowed = 100; // 设定每次能领取代币数量（默认为100，不是一百枚，因为代币有小数位数）。
address public tokenContract;   // 记录发放的ERC20代币合约地址。
mapping(address => bool) public requestedAddress;   // 记录领取过代币的地址。
```

**事件**  
```Solidity
// 定義SendToken事件，紀錄每次領取代幣的地址和數量，在requestTokens()被調用時釋放。
event SendToken(address indexed Receiver, uint256 indexed Amount); 
```

**函數**  
合約中只有兩個函數：  
```Solidity
// 构造函数：初始化tokenContract状态变量，确定发放的ERC20代币地址。
constructor(address _tokenContract) {
  tokenContract = _tokenContract; // set token contract
}


// 用户领取代币函数
function requestTokens() external {
    require(!requestedAddress[msg.sender], "Can't Request Multiple Times!"); // 每个地址只能领一次
    IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // 水龙头空了

    token.transfer(msg.sender, amountAllowed); // 发送token
    requestedAddress[msg.sender] = true; // 记录领取地址 
    
    emit SendToken(msg.sender, amountAllowed); // 释放SendToken事件
}
```

<!-- Content_END -->
