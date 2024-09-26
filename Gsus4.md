---
timezone: Asia/Shanghai
---


# Gsus4

1. 自我介紹： Gsus4 is a nice chord.

2. 你認為你會完成這次殘酷學習嗎 Yes.
   
## Notes

<!-- Content_START -->

### 2024.09.23
#### 學習內容：Solidity 入門 01 - 05
+ Solidity 簡介與 Remix 開發工具
+ 值類型
+ 函數 (external/internal/public/private, pure/view, payable)
+ 函數返回 （returns/return）
+ 變數作用域和數據儲存  (storage/memory/calldata)

#### 筆記
##### Hello Web3
* Solidity 是一種用於編寫乙太坊 (EVM) 智能合約的物件導向高級編程語言。
* Remix：適合新手入門的線上 IDE。[網址](https://remix.ethereum.org)
* 第一個智能合約
``` solidity
// SPDX-License-Identifier: MIT     // License: 不寫會 warning
pragma solidity ^0.8.21;            // Solidity 版本 >=0.8.21 <0.9.0
contract HelloWeb3{                 // 合約部分
    string public _string = "Hello Web3!";
}
```
##### 值類型 (Value Type)

三種變數類型
* 值類型 (Value Type)：boolean、integer、address...，賦值時直接傳值
* 引用類型 (Reference Type)：數組、結構體，賦值時傳遞地址(類似 pointer)
* 映射類型 (Mapping Type)：儲存鍵值對的數據結構，類似 hash table

值類型
1. bool：布林值 true/false
   運算符：
   * ```!```  (not)
   * ```&&``` (and)
   * ```||``` (or)
   * ```==``` (等於)
   * ```!=``` (不等於)
   * note: ```&&``` (and) 和 ```||``` (or) 遵守短路規則
1. Integer: 整數
   * ```int``` 整數
2. (待補)

---

### 2024.09.24
#### 學習內容：Solidity 入門 06 - 10
* 引用類型：array & struct
* 映射類型：mapping
* 變量初始值
* 常數：constant & immutable
* 控制流：if-else、for loop、while loop、do-while、三元運算子
#### 筆記
(先簽到，有空再補)

---

### 2024.09.25
#### 學習內容：Solidity 入門 11 - 15
* 構造函數 (constructor) & 修飾器 (Modifier)
* 事件 (event)
* 繼承
* 抽象合約 (abstract) & 接口 (Interface)
* 異常 (error/require/assert)

---

### 2024.09.26
#### 學習內容：Solidity 進階 16 - 20
* 函數重載
* library
* import
* 接收 ETH：receive & fallback
* 發送 ETH：transfer & send & call

### 

<!-- Content_END -->
