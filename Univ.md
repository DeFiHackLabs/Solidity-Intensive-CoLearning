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
- (a) boolean：布林型別（! && || == !=）
- (b) int、uint、uint256：整數型別
- (c) address：地址型別
- (d) byte1、byte32：字節型別
- (e) enum：列舉型別

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
Solidity 提供了四種函數可見性修飾符，來控制函數的訪問範圍：
- **public**：內外部均可見
- **private**：僅限於本合約內部，繼承合約也無法使用
- **external**：僅限於合約外部訪問（但內部可以通過 `this.f()` 來調用）
- **internal**：僅限於合約內部，繼承的合約可以使用

#### 3. pure 和 view
Solidity 引入 `pure` 和 `view` 關鍵字來控制函數是否改變區塊鏈上的狀態，這是因為以太坊的交易需要支付 gas 費用：
- pure：不能讀取也不能修改合約中的狀態變量。它僅僅執行不依賴合約狀態的邏輯運算，因為不需要讀取或改變鏈上的數據，所以不需要支付 gas
- view：僅能讀取合約的狀態變量，但不能修改狀態。這種函數的運行也不會花費 gas，除非是合約內部調用時

#### 4. internal 和 external 函數
- internal：只能在合約內部或者繼承的合約中被調用，這在需要隱藏某些內部邏輯時非常有用
- external：只能從合約外部訪問，但可以在合約內部通過 `this.functionName()` 調用

#### 5. payable 函數
- payable：允許合約接收 ETH，帶有這個關鍵字的函數在執行時可以接收以太幣並更新合約的餘額

#### 6. 實例代碼
教程中提供了數個簡單的實例來展示如何使用 `pure`、`view`、`internal`、`external` 以及 `payable` 等關鍵字修飾函數：
- `add()` 函數展示了如何操作狀態變量並引入 `pure` 和 `view` 的用法
- `minus()` 函數展示了 `internal` 函數的使用
- `minusPayable()` 函數展示了 `payable` 函數如何接收 ETH 並更新合約餘額

### 2024.09.25
## 04_Return
- returns 這個關鍵字用在函數名稱後面，用來告訴大家這個函數會返回什麼樣的數據，比如返回什麼類型的數字、陣列或布林值（true 或 false），就像你在函數開始之前，先跟大家說：「這個函數會給你什麼東西」
- return 這個關鍵字用在函數的主體裡面，用來實際把數據返回出去。就像是函數結束時，你用 return 把事先說好的東西交給大家

#### 命名式返回
- 在 Solidity 中，你可以在 returns 這裡直接給返回的值取名字，這樣你在函數裡面只要把這些變數賦值，系統會自動把這些值返回，不用再手動用 return
#### 在這裡，我們給每個返回的值取了名字 _number、_bool 和 _array，然後直接賦值，它們就會自動返回
```solidity
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```
#### 當然還是可以用 return 來返回這些命名式的變數
```solidity
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
    return (1, true, [uint256(1),2,5]);
}
```
#### 解構式賦值是一種方便的方式，可以讓你一次把函數返回的多個值分配給不同的變數。如果你不需要所有的返回值，也可以只取部分，其他的就留空
```solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
### 2024.09.26
## 05_DataStorage

#### 引用類型
引用類型包括：array（數組）和 struct（結構體）。
這些類型的變數較為複雜，佔用較多存儲空間，因此需要明確聲明數據存儲的位置。

#### 數據存儲位置
Solidity 中的數據存儲位置有三類：storage、memory 和 calldata，每種位置的 gas 消耗不同：

- storage：合約中的狀態變數默認存儲在 storage，數據存在鏈上，消耗較多 gas，類似電腦的硬碟。
- memory：函數中的參數和臨時變數通常用 memory，數據存在內存中，不上鏈，消耗較少 gas，適用於返回變長數據類型。
- calldata：類似於 memory，但數據不可修改，用於函數參數。

#### 數據位置與賦值規則
- 引用：當 storage 賦值給另一個 storage 或 memory 賦值給另一個 memory 時，會創建引用，修改一方會影響另一方
- 副本：其他情況下賦值會創建副本，修改其中一方不會影響另一方

#### 變數的作用域
- 狀態變數：存儲在鏈上，合約內所有函數可訪問，gas 消耗高，合約內、函數外聲明
- 局部變數：僅在函數執行過程中有效，存儲在內存中，不上鏈，gas 消耗低，函數內聲明
- 全局變數：Solidity 預留的關鍵字，在函數內可直接使用，如 msg.sender、block.number 等

#### 以太單位與時間單位
##### 以太單位：Solidity 中無法使用小數點，使用 wei、gwei、ether 等單位來表示不同的以太值，確保交易的精確性。
- wei: 1
- gwei: 1e9
- ether: 1e18

#### 時間單位：可使用 seconds、minutes、hours 等來設置合約中的時間，確保操作的準確性。
- seconds: 1
- minutes: 60
- hours: 3600
- days: 86400
- weeks: 604800

### 2024.09.27

#### 數組（Array）

##### 數組是用來存儲一組數據的變量類型，可分為固定長度數組和可變長度數組兩種：
- 固定長度數組：
在聲明時指定長度，格式為 T[k]，其中 T 是元素類型，k 是長度，例如：uint[8] array1;
- 可變長度數組：
在聲明時不指定長度，格式為 T[]，例如：uint[] array4;

#### 創建數組的規則：
- 使用 memory 修飾的動態數組可以用 new 操作符創建，必須指定長度，且創建後長度不能改變，例如：uint;
數組字面常數用來初始化數組，例如 [uint(1), 2, 3]，元素類型以第一個元素為準

#### 數組成員：
- length: 表示數組的長度
- push(): 在動態數組末尾添加一個元素
- pop(): 移除數組末尾的元素

#### 結構體（Struct）
結構體允許自定義類型，其元素可以是原始類型或引用類型。結構體可以作為數組或映射的元素

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

- 構造函數式
```solidity
student = Student(3, 90);
```

- 鍵值對方式
```solidity
student = Student({id: 4, score: 60});
```

### 2024.09.28

### 2024.09.29

### 2024.09.30

### 2024.10.01

### 2024.10.02


<!-- Content_END -->
