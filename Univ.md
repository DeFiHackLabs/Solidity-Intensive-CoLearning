---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍
我是Univ，想藉由這次共學機會深入學習Solidity與智能合約相關知識，跟大家一起的感覺比較有學習的動力。

2. 你认为你会完成本次残酷学习吗？
我可以完成這次共學，每天排出時間更新學習進度。
   
## Notes

### 2024.09.23

#### 01_HelloWeb3

solidity
// SPDX-License-Identifier: MIT 
// 這一行是註釋，表示了MIT license，不寫的話會有warning，但程式還是可以跑
pragma solidity ^0.8.21; // 這一行表示版本

contract HelloWeb3 { // 這裡是合約的定義
   string public _string = "Hello Web3!"; // 宣告一個public的string型態變數，並賦值
}

#### 02_ValueTypes
有分三種
1. Value Type
(a) boolean：布林型別（! && || == !=）
(b) int、uint、uint256：整數型別
(c) address：地址型別
(d) byte1、byte32：字節型別
(e) enum：列舉型別

2. Reference Type
包括 array、struct、mapping 等複雜資料型別

3. Mapping Type
一種特殊的資料型別，用來建立鍵值對映的數據結構

### 2024.09.24

## 1. 函數的基本結構
Solidity 中的函數結構有點複雜，但按照固定的格式來寫函數就可以：
- `function <函數名>(<參數類型>) {internal|external|public|private} [pure|view|payable] [returns (<返回類型>)]`

## 2. 可見性修飾符
Solidity 提供了四種函數可見性修飾符，來控制函數的訪問範圍：
- **public**：內外部均可見。
- **private**：僅限於本合約內部，繼承合約也無法使用。
- external：僅限於合約外部訪問（但內部可以通過 `this.f()` 來調用）。
- internal：僅限於合約內部，繼承的合約可以使用。

## 3. pure 和 view
Solidity 引入 `pure` 和 `view` 關鍵字來控制函數是否改變區塊鏈上的狀態，這是因為以太坊的交易需要支付 gas 費用：
- pure：不能讀取也不能修改合約中的狀態變量。它僅僅執行不依賴合約狀態的邏輯運算，因為不需要讀取或改變鏈上的數據，所以不需要支付 gas。
- view：僅能讀取合約的狀態變量，但不能修改狀態。這種函數的運行也不會花費 gas，除非是合約內部調用時。

## 4. internal 和 external 函數
- internal：只能在合約內部或者繼承的合約中被調用。這在需要隱藏某些內部邏輯時非常有用。
- external：只能從合約外部訪問，但可以在合約內部通過 `this.functionName()` 調用。

## 5. payable 函數
- payable：允許合約接收 ETH。帶有這個關鍵字的函數在執行時可以接收以太幣並更新合約的餘額。

## 6. 實例代碼
教程中提供了數個簡單的實例來展示如何使用 `pure`、`view`、`internal`、`external` 以及 `payable` 等關鍵字修飾函數：
- `add()` 函數展示了如何操作狀態變量並引入 `pure` 和 `view` 的用法。
- `minus()` 函數展示了 `internal` 函數的使用。
- `minusPayable()` 函數展示了 `payable` 函數如何接收 ETH 並更新合約餘額。

<!-- Content_END -->
