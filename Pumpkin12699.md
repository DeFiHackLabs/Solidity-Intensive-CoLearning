---
timezone: Asia/Shanghai
---
# YourName

1. 自我介绍
我是一位大四的學生，目前擔任社團的幹部，主要負責區塊鏈的教學工作。之前透過社團資源，和社團成員一起完成了一個小型的 Solidity 專案，並且也參加了由學生組織辦理的黑客松活動。我希望藉由這次的殘酷共學，與大家一起討論我目前不太熟悉的區塊鏈開發技術，尤其是 Solidity 的進階部分，進一步加強自己的區塊鏈開發能力。

2. 你认为你会完成本次残酷学习吗？
我認為我會完成這次的殘酷學習，我願意全心投入進這個活動，與大家一起學習並共同進步。
## Notes

<!-- Content_START -->
### 2024.09.23

1. **函數宣告**：
   - 基本形式：`function <函數名稱>(<參數類型>) {internal|external|public|private} [pure|view|payable] [returns (<返回類型>)]`
   - **function**：表示這是一個函數。
   - **函數名稱**：函數的名稱，可以自訂。
   - **參數類型**：函數接收的參數，格式為`<類型> <名稱>`，例如：`uint8 test`。
   - **可見性修飾詞**：`internal`、`external`、`public`、`private`決定了函數的訪問範圍。
     - `internal`：只能在合約內部或繼承的合約中使用。
     - `external`：只能從合約外部調用，內部不能調用。
     - `public`：任何人（內部、外部）都可以調用。
     - `private`：只能在合約內部使用，無法在繼承的合約中使用。

2. **函數狀態修飾詞**：
   - **pure**：函數不能讀取或修改鏈上數據，只能進行純計算。
   - **view**：函數可以讀取鏈上數據，但不能修改。
   - **payable**：允許函數接收以太幣（ETH），並可進行轉賬。

   **Tips**：
   - `pure` 和 `view` 修飾的函數不消耗 Gas（除非被內部調用）。
   - 使用 `payable` 的函數是接收 ETH 和處理支付的關鍵。

3. **返回值**：
   - 函數的返回值類型透過 `returns` 指定。例如：`returns (uint8)`表示該函數將返回一個 `uint8` 類型的值。
   - **命名式返回值**：函數內部可以不使用 `return` 直接返回已命名的變數。範例：
     ```solidity
     function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array) {
         _number = 2;
         _bool = false;
         _array = [uint256(3),2,1];
     }
     ```
     - 這樣函數在結束時會自動返回 `_number`、`_bool` 和 `_array`。

   - **結構式賦值**：允許以元組的形式賦值給多個變數。例如：
     ```solidity
     uint256 _number;
     bool _bool;
     uint256[3] memory _array;
     (_number, _bool, _array) = returnNamed();
     ```
     - 此外，如果不需要某些返回值，可以省略。例如：
     ```solidity
     (, _bool2, ) = returnNamed();
     ```
     - 這樣只會取第二個返回值 `_bool2`，其他返回值會被忽略。

4. **重要概念**：
   - Solidity 中的 `public` 和 `private` 也可以應用於狀態變量，`public` 狀態變量會自動生成同名的 getter 函數來查詢變量值。
   - 沒有明確標註可見性的狀態變量，默認為 `internal`。
<!-- Content_END -->
