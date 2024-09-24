---
timezone: Asia/Shanghai
---

---

# Haoder

1. 自我介绍  
Hi~ 我是 [**Haoder**](<https://github.com/hau823823>)，希望透過這次共學計畫，加深自己對 solidity 的瞭解以及熟悉程度，同時與共學夥伴共同砥礪進步。

2. 你认为你会完成本次残酷学习吗？  
LFG～～～～～ 會完成的

## Notes

<!-- Content_START -->

### 2024.09.23

### 1. HelloWeb3(三行代碼)

#### 重點內容

> [!NOTE]
> 學習開發環境以及 Solidity 基礎語法

#### 題目練習

1. **Q: Solidity是什么？**  
   **A:** 編寫智能合約的語言

2. **Q: Remix 是什麼？**  
   **A:** 智能合約開發 IDE

3. **Q: 什麼事 IDE？**  
   **A:** 集成開發環境（Integrated Development Environment）

4. **Q: 帶有pragma solidity ^0.8.4; 的智能合约能否被 solidity 0.8版本編譯？**  
   **A:** 不可以

5. **Q: Remix没有以下哪个面板？**  
   **A:** 版本

6. **Q: Remix的本地测试账户中有多少个ETH？**  
   **A:** 100

7. **Q: Solidity中每行代码需要以什么符号结尾？**  
   **A:** 分號;

8. **Q: String是什么类型的变量？**  
   **A:** 字符串

### 2024.09.24  

### 2. 值類型

#### 重點內容

> [!NOTE]
> 認識 solidity 中的變量類型以及值類型

#### 隨筆

##### 變量類型

1. **值類型（Value Type）** : 包含布爾型別、整數等，賦值直接傳值

2. **引用類型（Reference Type）** : 包含數組和結構體，佔空間大，賦值直接傳址

3. **映射類型（Mapping Type）** : 存儲件值對的數據結構，可以理解為哈希表

##### 值類型

1. **布爾（bool）**
   > **注意** : && 看 || 運算符遵循短路規則

2. **整型** : int、uint、uint256 等

3. **地址類型**
   * 普通地址 : 存儲 單一個 20 字節的值
   * payable address

4. **字節數組**
   * 定長數組（值類型）：bytes1、bytes8、bytes32 等，最多存 32 bytes 數據（bytes32）
   * 不定長數組（引用類型）

5. **枚舉 enum** : 用於為 uint 分配名稱，使用名稱來代替從 0 開始的 uint

#### 題目練習

1. **Q: 以下屬於 solidity 變量類型的是？**  
   **A:** 以上皆是

2. **Q: solidity中数值类型(Value Type)不包括？**  
   **A:** float

3. **Q: 请解释下面这段代码的意思？**

   ```solidity
      address payable addr;
      addr.transfer(1);
   ```

   **A:** 合約向 addr 轉帳 1 wei
> [!TIP]
> **參考後面章節**: [20. SendETH](https://www.wtf.academy/docs/solidity-102/SendETH/)

5. **Q: bytes4類型具有幾個 16 進制位？**  
   **A:** 8
> [!TIP]
> bytes4 是固定長度的字節數組，表示 4 個字節（4 bytes）。每個字節由 2 個 16 進制位組成，所以總共有 4（字節） x 2（16 進制位/字節） = 8 個 16 進制位。

6. **Q: 以下运算能使a返回true的是？**  
   **A:** bool a = 1 - 1 == 0 && 1 % 2 == 1
> [!TIP]
> ![img1](content/Haoder/img/102/img1.png)

### 3. 函數

<!-- Content_END -->
