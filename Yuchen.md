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

<!-- Content_END -->
