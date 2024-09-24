---
timezone: Asia/Shanghai
---

# jasonch1u

1. 自我介绍：無開發經驗，參加XREX區塊鍊課程後，不想再當web2的佃農。最近很幸運的錄取了資安BOOTCAMP，希望這段時間學習後，有機會投身web3的行列。
2. 你认为你会完成本次残酷学习吗？ 一開始覺得不好說，不過這段時間提前自學，期許自己還是可以完成。

## Notes

<!-- Content_START -->
### 2024.09.19
因為從未接觸過Solidity，這週提前開始課程，大概了解自學難度、個人目標、及殘酷共學的願景。

### 2024.09.23

01_HelloWeb3

* Solidity 是智能合約語言，主要用於以太坊，能幫助讀懂區塊鏈項目代碼。
* Remix 是官方推薦的開發工具(https://remix.ethereum.org)，可在瀏覽器中開發和部署 Solidity 合約。建議可以開啟自動編譯，省步驟。
* Solidity 程序結構包含：

License 註釋
```solidity
// SPDX-License-Identifier: MIT
```
版本聲明：跟編譯器要一致，在remix輸入"pragma..." 會跳出"License註識"一起寫完，最後記得填入version
```solidity
pragma solidity 0.8.26;
```
合約內容
```solidity
contract HelloWorld { }
```
* 第一個合約示例：HelloWeb3 合約，定義一個字符串變量，值為 "Hello Web3!"。每行代碼用分號 ；結尾

</br>
02_ValueTypes

值的寫法：value類型 (不寫? | internal | public | private，還不知道為什麼不能寫external?) <_value name> = 數值、字串或判斷式

如果寫public，會自動產生getter函數(這邊應該可以理解成直接產生一個查找對應數值的函數功能)，寫其他或不寫，就不會有字自動生成getter函數，就沒辦法直接看對應數值。

ex.
```solidity
uint8 public _apple = 255; //會自動產getter函數，部屬後直接點_apple會知道uint8: 255
uint256 _banana = 20; //不會自動產getter函數，部屬後沒有_banana可以點，要另外自己寫function找_banana
```

數值類型概述
* 布爾型 (bool)：只有兩個值，true 和 false。
* 整數型 (uint)：
    * uint（無符號整數）常用於區塊鏈，因為不需要負數，默認為 uint256。也沒有小數點。位數表達是二進制的位數，即256bits。
    * 支援基本數學運算（加、減、乘、除、平方、取商、取餘數），以及比較運算（如>, >=, <, <= 等...）。
    * 操作符：==、!=、&&、|| 用於邏輯比較。
    * 短路規則（Short-circuiting）：
        * &&：如果前者為 false，後者不再執行。
        * ||：如果前者為 true，後者不再執行。
* 地址型 (address)：
    * 特殊的 20 byte 類型，用於儲存 Ethereum 地址。
    * address：佔用 20 bytes，即 40 個 16 進位字符。
    * payable address 可用於接收轉帳。
    * 支援轉帳操作方法：transfer、send 和 call。以後會學
* 字節型 (bytes)：
    * 分為定長（如 bytes32）和不定長版本。
    * 定長字節型聲明長度後不可變；不定長字節數組有機會儲存更多數據。
    * 1 byte = 8 bits，可以由 2 個 16 進位字符表示。
        * 每個 16 進位字符代表 4 bits。例如：1111 1111（二進位） = FF（16 進位）。
        * bytes32：能存 32 bytes，即 64 個 16 進位字符。
        * 0x只是用來表示16進制，不佔字符數。
* 枚举 enum：冷門，方便辨識程式碼的寫法。類似自定義X, Y, X = 0, 1, 2的概念

</br>

03_Function

函數的基本結構
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
* 可見性：函數的可見性決定誰可以調用該函數：
   * public：內外部都可訪問，會自動生成 getter 函數。
   * private：僅限合約內部調用。
   * internal：內部和子合約可調用。
   * external：僅外部調用，內部需透過 this.f() 調用。
* 修飾詞
   * pure：不讀取或修改狀態，完全依賴傳入的參數。
   * view：僅讀取狀態，不修改。
   * payable：允許函數接收以太幣，常用於資金接收。
   * 不寫：可以讀取和修改狀態，改變鍊上數據會消耗 Gas。
<!-- Content_END -->
