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

不補筆記了，因為我在學習程式語言時沒有做筆記的習慣，覺得將內容再抄寫一遍沒什麼意義，也不想直接叫AI幫我做筆記，所以之後單純紀錄學習進度。

---

### 2024.09.24
#### 學習內容：Solidity 入門 06 - 10
* 引用類型：array & struct
* 映射類型：mapping
* 變量初始值
* 常數：constant & immutable
* 控制流：if-else、for loop、while loop、do-while、三元運算子

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

---

### 2024.09.27
#### 學習內容：Solidity 進階 21 - 25
* 調用其他合約
* Call
* Delegatecall
* 在合約中創建新合約
* CREATE2

---

### 2024.09.28
#### 學習內容：Solidity 進階 26 - 30
* 刪除合約 selfdestruct
* ABI 編碼 & 解碼
* Hash
* 選擇器 Selector
* try-catch

---

### 2024.09.30
#### 學習內容：Solidity 應用 31 - 35
* ERC20
* 代幣水龍頭
* 空投合約
* ERC721
* 荷蘭拍賣

---

### 2024.10.01
#### 學習內容：Solidity 應用 36 - 40
* 默克爾樹
* 數字簽名
* NFT交易所
* 鏈上隨機數
* ERC1155

---

### 2024.10.02
#### 學習內容：Solidity 應用 41 - 45
* WETH
* 分帳
* 線性釋放
* 代幣鎖
* 時間鎖

---

### 2024.10.03
#### 學習內容：Solidity 應用 46 - 50
* 代理合約
* 可升級合約
* 透明代理
* 通用可升級代理
* 多簽錢包

---

### 2024.10.04
#### 學習內容：Solidity 應用 51 - 54
* ERC4626 代幣化金庫標準
* EIP721 類型化數據簽名
* ERC-2612 ERC20Permit
* 跨鏈橋

---

### 2024.10.05
#### 學習內容：Solidity 應用 51 - 54
* 多重調用
* 去中心化交易所
* 閃電貸

---

### 2024.10.07
#### 學習內容：Solidity 合約安全 S01 - S03
* 重入攻擊
* 選擇器碰撞
* 中心化風險

---

### 2024.10.08
#### 學習內容：Solidity 合約安全 S04 - S07
* 權限管理漏洞
* 整型溢出
* 簽名重放
* 壞隨機數

---

### 2024.10.09
#### 學習內容：Solidity 合約安全 S08 - S11
* 繞過合約長度檢查
* DoS 拒絕服務
* 貔貅
* 搶先交易

---

### 2024.10.11
#### 學習內容：Solidity 合約安全 S12 - S14
* tx.origin 釣魚攻擊
* 未檢查的低級調用
* 操縱區塊時間

---

### 2024.10.12
#### 學習內容：Solidity 合約安全 S15 - S17
* 操縱預言機
* NFT 重入攻擊
* "跨服"重入攻擊

---

### 2024.10.15
#### 學習內容：NFT 專題
* ERC721 庫：Address, String, Context
* ERC721 相關接口
* ERC721 主合約
* BAYC 主合約和嚴重漏洞
* Loot


### 

<!-- Content_END -->
