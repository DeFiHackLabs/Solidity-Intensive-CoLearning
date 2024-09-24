---
timezone: Asia/Shanghai

---

# Jason

1. 自我介绍 - Web3 lawyer

2. 你认为你会完成本次残酷学习吗？ 會
   
## Notes

<!-- Content_START -->
### 2024.09.23
1. 複習Solidity 101
2. 資源筆記：（a） Solidity中文文档（[官方文档的中文翻译](https://docs.soliditylang.org/zh/v0.8.19/index.html)）(b) [崔棉大师solidity教程](https://space.bilibili.com/286084162) (c) [Solidity 入門走到飛](https://www.youtube.com/watch?v=X135KO-8OTg)
3. structure
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
4. Variables
   (a) 值类型(Value Type)： These variables directly pass values when assigned

   ■ Boolean: A binary variable with values of true or false.

   ■ Integers: Signed (int) and unsigned (uint) integers, storing up to 256-bit integers.
   
         ■ Addresses: Holds a 20-byte Ethereum address, with address payable allowing ETH transfers.
         ■ Fixed-size byte arrays: byte, bytes8, bytes32, etc., with a fixed length declared at initialization.
         ■ Enumeration (enum): User-defined data types that assign names to uint values for readability
   
   (b) 引用类型(Reference Type)： These variables store the address of data and can be modified with different variable names:

         ■ Arrays: Used to store a set of data. Can be fixed-size (T[k]) or dynamically-sized (T[]).
         ■ Structs: User-defined data types that group together variables of different types.
         ■ Variable-length byte arrays: bytes, with a length that can be modified after declaration
   
   (c) 映射类型(Mapping Type): Solidity中存储键值对的数据结构，可以理解为哈希表

### 

### 2024.09.24
在以太坊區塊鏈中,合約和帳號是兩種不同類型的實體,它們有以下主要區別:
一、函數
1. 函數類型與形式
   - 形式：
   ```
   function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
   ```
   - 類型
      - (1) 可見性類型:
         public: 內部和外部都可以調用
         private: 只能在當前合約內部調用
         internal: 只能在當前合約及其子合約內部調用
         external: 只能從合約外部調用
      - (2) 狀態可變性: view: 不修改狀態,只讀取狀態; pure: 不讀取也不修改狀態; payable: 可以接收以太幣
      - (3) 特殊函數: constructor: 構造函數,部署合約時執行; fallback: 回退函數,在調用不存在的函數時執行; receive: 接收以太幣的函數
      - (4) 修飾器函數: 使用 modifier 關鍵字定義,用於修改其他函數的行為
      - (5) 虛擬函數和重寫函數: virtual: 可以被子合約重寫的函數; override: 重寫父合約的函數
   
3. 函數輸出
在 Solidity 中,函數的輸出主要通過返回值(return value)來實現。以下是關於函數輸出的一些重要概念:

#### 返回值聲明

1. 使用 `returns` 關鍵字在函數聲明中指定返回值類型:

```solidity
function myFunction() public returns (uint) {
  return 123;
}
```

2. 可以返回多個值:

```solidity
function multipleReturns() public returns (uint, bool, uint) {
  return (1, true, 2);
}
```

#### 返回方式

1. 使用 `return` 語句直接返回值:

```solidity
function returnValue() public returns (uint) {
  return 100;
}
```

2. 命名式返回:在 `returns` 中聲明變量名,函數體中給這些變量賦值,最後自動返回[1]:

```solidity
function namedReturn() public returns (uint _number, bool _bool) {
  _number = 2;
  _bool = true;
}
```

## 接收返回值

1. 可以使用解構賦值接收全部或部分返回值[1]:

```solidity
(uint x, bool b, ) = multipleReturns();
```

2. 單個返回值可直接賦值:

```solidity
uint result = returnValue();
```

## 注意事項

1. `view` 和 `pure` 函數可以有返回值,但不修改狀態[5]。

2. 返回值類型可以是基本類型,也可以是複雜類型如數組、結構體等[4]。

3. 如果函數聲明了返回值但沒有顯式返回,將返回該類型的默認值[3]。

4. 返回值可以用於函數內部計算,也可以供外部調用者使用[6]。

總之,合理使用函數返回值可以使合約邏輯更清晰,提高代碼的可讀性和可維護性。在設計函數時,應根據實際需求選擇合適的返回方式。
References:
[1] https://blog.csdn.net/wo541075754/article/details/104354721
[2] https://www.cnblogs.com/zhanchenjin/p/18218201
[3] https://hackmd.io/%40rogerwutw/BJ3CoxkTK
[4] https://mirror.xyz/wtfacademy.eth/FIGf9tF7wiBlLnQGXfEjVkJ0efzKBNltJS1fRxPKYTk
[5] https://u.naturaldao.io/solidity/1.6-solidity-yu-yan-jiao-cheng/structure
[6] https://metana.io/blog/solidity-functions-types-and-use-cases/
   
二、自問自答：
## 帳號(Account)
1. 外部擁有帳戶(EOA):
   - 由私鑰控制
   - 可以發起交易
   - 沒有相關程式碼
   - 有以太幣餘額
2. 合約帳戶:
   - 由智能合約程式碼控制
   - 不能主動發起交易,只能被觸發執行
   - 包含智能合約程式碼
   - 有以太幣餘額

## 智能合約(Smart Contract)
- 是一種特殊的合約帳戶
- 包含可執行的程式碼
- 在區塊鏈上自動執行預定義的操作
- 可以持有資產和狀態
- 由交易或其他合約調用來執行

## 主要差異
1. 控制方式:帳號由私鑰控制,合約由程式碼控制
2. 功能:帳號用於持有資產,合約用於執行邏輯
3. 交易發起:帳號可主動發起交易,合約只能被動執行
4. 程式碼:帳號沒有程式碼,合約包含可執行程式碼
5. 創建方式:帳號可直接創建,合約需要通過交易部署
6. 靈活性:帳號操作簡單,合約可實現複雜邏輯
總之,帳號主要用於管理資產,而智能合約則用於在區塊鏈上執行自動化的業務邏輯。兩者在以太坊生態系統中扮演不同但互補的角色。

### 
### 2024.09.25


### 
<!-- Content_END -->
