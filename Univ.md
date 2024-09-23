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

```solidity
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


<!-- Content_END -->
