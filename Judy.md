---
timezone: Asia/Shanghai
---


---

# Judy

1. 自我介绍 

   3年軟體工程師 區塊鏈開發學習中

2. 你认为你会完成本次残酷学习吗？

   會
   
## Notes

<!-- Content_START -->

### 2024.09.23
#### Remix(online IDE)
- 創建新文件後 → 開啟自動編譯 → 完成程式碼後部署
    
    ![image](https://github.com/user-attachments/assets/dad74a13-f31d-4144-b400-dfa331d2d6e3)

    
- 這是一個簡單的 Solidity 智能合約，名稱為 `HelloWorld`。Solidity 是用來開發在以太坊等區塊鏈平台上運行的智能合約的編程語言。
    
    ![image](https://github.com/user-attachments/assets/e8be65db-54d2-445a-b6cb-5e9acf88b799)

    
    - 以下是這段程式碼的解釋：
        1. **SPDX-License-Identifier: MIT**：這是一個許可識別符，表示此合約是開源的，並使用 MIT 許可證。
        2. **pragma solidity ^0.8.26;**：這一行指定了該合約應使用的 Solidity 編譯器版本。`^` 符號表示該合約與從 `0.8.26` 到不包括重大版本變更的所有版本兼容。**通常會選擇最新版本的前一版。**
        3. **contract HelloWorld { ... }**：這段程式碼定義了一個名為 `HelloWorld` 的合約。在 Solidity 中，`contract` 類似於 object-oriented programming 中的 `class`，包含資料和函式。
        4. **string public hi = "Hello World";**：這一行聲明了一個名為 `hi` 的公開變數，類型是 `string`（字串），並且初始化為 `"Hello World"`。由於變數標記為 `public`，Solidity 自動生成了一個 getter 函式，允許任何人從區塊鏈上讀取 `hi` 的值。
    - 總結來說，這個合約是將字串 `"Hello World"` 儲存在一個公開變數中，並且可以通過調用部署後的合約中的 `hi()` 函式來訪問該值。
- 結果
    
    ![image](https://github.com/user-attachments/assets/468e71e7-aba6-45b1-b226-04141c4ccce0)

    
    ![image](https://github.com/user-attachments/assets/d93ddc9a-90ff-4127-bf00-0a10da6de80b)

#### Solidity 主要變量類型總覽：

1. 值類型(Value Type)：
    - 值類型的變量在複製時，會將實際值複製到新變量中
    - `uint`、`int`、`bool`、`address`、`bytes`、`string`、`enum`
2. 引用類型(Reference Type)：
    - 引用類型的變量會存儲其引用位置（如存儲在存儲、記憶體或 calldata 中），複製時會複製引用，而不是直接複製值。
    - 動態或固定大小的 `arrays`、`struct`、`mapping`

3. 特定數據類型（Special Data Types）

- 函數型變量（Function Types）
    - 函數也可以作為變量來使用，特別是在智能合約中，允許將函數傳遞或作為參數傳遞。

#### **常用的Value Type:**

- 布林值：值為 `True` 或 `False`
    
    ```jsx
    bool public open = false;
    bool public open1 = !open; // true
    bool public open2 = open && open1; // false
    bool public open3 = open || open1; // true
    bool public open4 = open == open1; // false
    bool public open4 = open != open1; // true
    ```
    
- 整數：有 `int`, `uint`, `uint256`
    - 區塊鏈開發中多用 `uint` (非負整數)
    - `uint` = `uint256`
    - 為何在區塊鏈開發中，**`uint`（無符號整數）** 通常比 **`int`（有符號整數）** 更常使用？
        1. 節省 Gas 費用
            - `int` 需要額外的位元來存儲符號位（正或負），並在運算時檢查符號位，增加了計算複雜度和存儲空間。
            - `uint` 僅處理非負數值，運算邏輯更簡單，因此在許多情況下可以降低合約執行的 Gas 成本。
        2. 避免負數邏輯錯誤
            - 許多區塊鏈應用（如代幣交易、資金管理、投票系統等）只需要處理非負數的數值。例如：
                - 代幣餘額不可能是負數。
                - 交易金額也不應該是負的。
                - 用戶的投票數量、持有代幣的數量、交易手續費等，都只能是正數。
            - 在這些情境下，使用 **`uint`** 可以自動避免不正當的負數出現，從而減少潛在的邏輯錯誤和安全風險。
        3. uint 比 int 範圍更大
            - **總數值範圍（總數量）** 是相同的，因為：
                - `uint256` 允許表示的值從 **0 到 2^256 - 1** ，總共 2＾256 個可能的值。
                - `int256` 的範圍是從 **負數到正數**，即從 −2＾255 到 2＾255−1，同樣有 2＾256 個可能的值。
            - 但 **表示的數值範圍不同**：
                - `uint256` 只包含正數（和 0），範圍是從 **0 到約 10^77**。
                - `int256` 包含正數和負數，範圍是 **約 -10^77 到 10^77**。
            - **`uint256` 能表示的正數範圍更大**，因為它不需要分配一半的範圍給負數。換句話說，`uint256` 可以表示的**最大正數**比 `int256` 大得多。
        4. 合約中更符合應用需求
            - 大多數智能合約應用中，例如去中心化金融（DeFi）、代幣管理、資產交易，通常只需要處理非負數字。
    
    ```jsx
    // 運算
    uint public num = 666;
    uint public num1 = num + 4; //670
    uint public num2 = num - 6; //550
    uint public num3 = num * 2; //1332
    uint public num4 = num / 111; //6
    uint public num5 = 2 ** 2; //4
    uint public num6 = 7 % 2; //1 
    
    // 比大小
    bool public isNumLarger = num > num1; //false
    ```
    
- 地址：
    - 用來儲存 `byte20` (以太坊地址大小)
    - 1 byte  =  8 bits, 而 **1 byte 是兩個 16 進制數字**， 所以可以用來存 40 個 16進制數字
    - 解釋
        
        **1. 什麼是 1 byte？**
        
        - 1 byte 是一個包含 8 個位元（bits）的資訊單位。每個位元可以是 0 或 1，因此 1 byte 可以有 2^8 = 256 種不同的數值範圍，對應的範圍是從 0 到 255（十進制）。
        
        **2. 16 進制表示法**
        
        - 16 進制（hexadecimal）是一種使用基數 16 的數字系統，數字範圍從 0 到 15。為了方便表示，16 進制的數字使用 0 到 9 來表示 0 到 9，並使用 A 到 F 來表示 10 到 15。
            
            
            | 十進制 | 二進制 | 16 進制 |
            | --- | --- | --- |
            | 0 | 0000 | 0 |
            | 1 | 0001 | 1 |
            | 2 | 0010 | 2 |
            | ... | ... | ... |
            | 10 | 1010 | A |
            | 15 | 1111 | F |
        
        **3. 為什麼 1 byte 對應 兩個 16 進制數字？**
        
        - **示例:**  假設我們有一個 1 byte 的值，十進制為 255，對應的二進制為 `11111111`。
            - 將二進制數 `11111111` 分成兩組：`1111` 和 `1111`。
            - 每組 `1111` 對應的 16 進制數為 `F`，因此這個 byte 在 16 進制表示中為 `FF`。
        - 再看一個例子，十進制數字 `165` 對應的二進制是 `10100101`。
            - 分成兩組：`1010` 和 `0101`。
            - `1010` 對應 16 進制的 `A`，`0101` 對應 16 進制的 `5`，因此 165 在 16 進制中表示為 `A5`。
        
        **4. 總結**
        
        - 1 byte 有 8 個 bits，這些 bits 可以分成兩組，每組 4 個 bits，而 4 個 bits 可以對應 1 個 16 進制數字。因此，1 byte 可以表示為兩個 16 進制數字。
        1. 重要性：區塊鏈技術大量使用 16 進制來處理資料、計算哈希值、管理地址和進行合約開發
            - **a. 地址表示**
                - 以太坊中的錢包地址是 **160 bits**，即 **20 bytes**。每個地址用 16 進制表示為 40 個字符（兩個 16 進制數字表示 1 byte）。
                    
                    例如：
                    
                    - 以太坊地址：`0x742d35cc6634c0532925a3b844bc454e4438f44e`
                    - 該地址由 40 個 16 進制數字組成（去掉前面的 `0x`），這相當於 20 bytes，能夠唯一標識以太坊上的一個帳戶。
                - 使用 16 進制來表示大資料（如地址）不僅精簡，而且與低層次的二進制數據結構相容，非常適合區塊鏈需要高效存儲和計算的環境。
            - **b. 哈希值與加密**
                - 區塊鏈依賴哈希函數來保證資料的完整性和安全性。常用的哈希算法（如 **SHA-256**）的輸出是 **256 bits**，也就是 **32 bytes**。這個哈希值通常以 16 進制來表示，因為 16 進制可以更加直觀地壓縮和閱讀這樣長的二進制數據。
                    
                    例如：
                    
                    - SHA-256 的輸出可以是：`0x3e23e8160039594a33894f6564e1b1348bb328186614d5e97d4f3f5a9c02efc1`
                    - 這個哈希值包含 64 個 16 進制數字，對應的是 32 bytes 的數據。
                - 16 進制表達在哈希值中非常重要，因為它使得以二進制進行的低層次運算更加高效和直觀。
            - c. **智能合約中資料結構的高效表示**
                - 智能合約（如 Solidity）中常常處理不同型別的資料，例如數字、字串、地址等。這些資料在存儲或傳輸時以 byte 格式處理，而在顯示或與外界交互時通常使用 16 進制。
                - 例如，Solidity 中的 `bytes` 型別（例如 `bytes32`）是固定長度的 byte 序列，適合儲存和操作二進制資料。在執行合約或在區塊鏈上進行儲存時，這些 byte 通常會以 16 進制的方式顯示或輸出。
                    
                    ```solidity
                    bytes32 public data = 0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890;
                    ```
                    
                    這是 32 bytes 的數據，用 16 進制表示有 64 個字符，方便處理和驗證。
                    
            - d. **節省存儲與計算成本**
                - 區塊鏈上的每一個操作都需要計算成本（例如在以太坊上需要支付 `Gas`）。
                - 將資料以 16 進制的形式存儲和操作能有效減少存儲空間並提升運算效率，因為 16 進制與低層次的二進制計算非常相容。
                - 例如，在區塊鏈中使用 16 進制數據可以縮減交易和合約的數據量，減少存儲需求，從而降低交易費用。
            - e. **調試與分析交易數據**
                - 開發者和使用者經常需要檢查區塊鏈上的交易數據、合約執行結果或原始區塊數據。這些數據通常會以 16 進制形式展示，因為它們是二進制數據的簡化表達方式。
                - 例如，交易的資料字段、合約的 ABI（應用程式二進制介面）和交易哈希等都會以 16 進制顯示。開發者經常需要解碼 16 進制數據來調試和分析交易的正確性。
        
    - 有分普通地址及 payable address(可轉帳地址)
    ```solidity
        contract HelloWorld{
            address public _address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
            address payable public _address1 = payable(_address); // payable address，可以轉帳、查餘額
            uint256 public balance = _address1.balance;
        }
        
        // balance output: 99999999999996783714
    ```
        
    - 為何 eth 是 18 個 0?
      ### 1. 1 ETH = 10¹⁸ Wei：
      - 在以太坊中，**1 ETH** 等於 **10¹⁸ Wei**，也就是說，1 ETH 等於後面帶有 18 個 0 的 Wei。這類似於在傳統貨幣中，一美元可以分成 100 分（cents），但以太坊將 ETH 的最小單位設得更小。
      ### 2. Wei 是以太坊的最小單位：
       - Wei 是以太坊貨幣系統中最小的單位。這樣設計的原因是區塊鏈系統中需要處理非常小的數值，特別是微交易（微量的支付或轉帳）。
       - 將 ETH 分成更小的單位有助於精確處理非常小的交易量，避免因浮點運算產生誤差。
      ### 3. **為何使用 18 個 0？**
       - 18 是一個相對較大的數字，但它提供了足夠的精度來處理微交易。這意味著即使是非常小的以太坊支付，仍然可以通過 Wei 來表示和處理。
       - 在金融系統中，使用更小的分割單位來避免精度問題非常重要。例如，比特幣的最小單位是 **Satoshi**，而 1 比特幣等於 10⁸ Satoshi。
            
      ### 以太坊單位對照：
            
      - **1 ETH** = 10¹⁸ Wei
      - **1 Gwei** = 10⁹ Wei （Gwei 通常用來表示交易手續費，`gas price`）
            
        這種設計使以太坊能夠靈活處理從非常大額到非常小額的交易和操作。
            
    
- 定長 byte:
    - `bytes1`, `bytes8`, `bytes32` 等
    - 長度在宣告之後不能改變，消耗 gas 相對少
    - 不定長 byte 是 reference type
    - 使用場景
        - **密鑰或哈希值存儲**：在智能合約中，定長字節數列常用於存儲哈希值（如 `bytes32` 用於存儲 Keccak256 哈希值）或某些固定長度的數據（如加密密鑰或標識符）。
        - **效能**：相比變長字節數列（`bytes`），定長字節數列在存儲和操作上更有效率，因為它們的長度在編譯時就已經確定，操作時不需動態計算長度。
        
        ```solidity
        contract HelloWorld{
           bytes32 public newWord = "Solidity";
           bytes1 public first_newWord = newWord[0];
        }
        
        // newWord output: 0x536f6c6964697479000000000000000000000000000000000000000000000000
        // first_newWord output: 0x53
        ```
        

- 列舉(enum): 少用，為了增加可讀性
    - `enum` 可以和 `uint` 轉換
    - 為何！！！
        
        ```solidity
        contract HelloWorld{
            enum ActionSet { Buy, Hold, Sell }
            ActionSet action = ActionSet.Buy;
           
             // enum can be converted to uint
            function enumToUint() external view returns(uint) {
                return uint(action);
            }
        }
        
        // enumToUint() output: 0
        ```
        
        ```solidity
        contract HelloWorld{
            enum ActionSet { Buy, Hold, Sell }
            ActionSet public action;
        
            constructor() {
                action = ActionSet.Hold;  // Explicitly initialize to Hold (1)
            }
             // enum can be converted to uint
            function enumToUint() external view returns(uint) {
                return uint(action);
            }
        }
        
        // enumToUint() output: 1
        ```
### 2024.09.24
#### 變量類型：函數
![image](https://github.com/user-attachments/assets/0ee88f54-f82d-4ae4-b6c8-b527fd761d42)

## Solidity 中函數的形式

```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

- function 函數名稱(參數們) 可見性修飾詞 狀態修飾詞 回傳值 {
    // 函數的內容
}

- **可見性修飾詞(Visibility Specifiers)**
    - `public`: 函數可以從外部或合約內部調用。自動生成 getter 方法。
    - `private`: 函數只能從合約內部調用，外部無法訪問。
    - `internal`: 函數只能從合約內部或繼承的合約調用，外部無法訪問。
    - `external`: 函數只能從合約外部調用，不能從內部直接調用（但可以用 `this.functionName()` 調用）。
    
    |  | Within Contract | Outside Contracts | Child Contract | External Account |
    | --- | --- | --- | --- | --- |
    | public | O | O | O | O |
    | private | O | X | X | X |
    | internal | O | X | O | X |
    | external | X | O | X | O |

    ```solidity
    contract ExampleContract {
    	uint public count;  // 合約中的狀態變量
    	
    	// 宣告一個 public 函數，可以修改狀態變量
    	function increment() public {
    	    count += 1;
    	}
    	
    	// 宣告一個 pure 函數，不修改也不讀取合約內部的狀態
    	function add(uint a, uint b) public pure returns (uint) {
    	    return a + b;
    	}
    	
    	// 宣告一個 view 函數，可以讀取合約內部的狀態但不能修改
    	function getCount() public view returns (uint) {
    	    return count;
    	}
    	
    	// 宣告一個 payable 函數，允許接收以太幣
    	function receiveEther() public payable {
    	    // 這個函數可以接收以太幣
    	}
    }
    ```
    
    - 注意！鏈上數據是公開的。所以即使是`private`，也能透過 Ether.js / web3.js 等方法，去讀取slot中的數據。
        - 使用 `private` 宣告變量後，該變量不會自動生成對外的 getter 函數
        - 即便限制在合約內部的訪問，該變量依然會存儲在區塊鏈的儲存槽（storage slot）中，而這些儲存槽對任何有區塊鏈訪問權限的人來說是可讀的。
        - 如何讀取鏈上的 `private` 變量？
            
            要讀取變量的值，主要的挑戰是如何計算該變量所在的儲存位置（slot）。
            
            ### 步驟概述：
            
            1. **儲存槽的概念**：
            每個合約的狀態變量都會按照它們宣告的順序被存儲在特定的儲存槽中。每個儲存槽的大小是 32 字節（256 位元）。例如，第一個變量存儲在 slot 0，第二個在 slot 1 依此類推。
            2. **計算變量的 slot**：
            通過查找變量在智能合約中的位置，可以計算出該變量存儲在哪個儲存槽。如果變量是結構體或陣列，則會使用更複雜的哈希算法來確定它的儲存槽。
            3. **讀取儲存槽的值**：
            使用像 Ether.js 這樣的庫，可以直接訪問區塊鏈的狀態並讀取特定 slot 的值。
            
            例如，使用 Ether.js 的 `provider.getStorageAt` 方法可以讀取一個特定儲存槽中的數據：
            
            ```solidity
            // 使用 Ether.js 讀取特定合約地址中的儲存槽數據
            let slotIndex = 0;  // 變量的儲存槽索引
            let contractAddress = "0x合約地址";
            let data = await provider.getStorageAt(contractAddress, slotIndex);
            console.log(data);  // 這會輸出儲存槽中的值
            ```
            
            ### 儲存槽範例
            
            假設一個合約中有以下變量：
            
            ```solidity
            contract MyContract {
            	uint private secretValue = 123;
            }
            ```
            
            - 這個 `secretValue` 儲存於儲存槽 0 中（因為它是第一個宣告的變量），即使變量標記為 `private`，依然可以透過鏈上的工具來讀取。
    - 如何在智能合約中存儲私密數據？
        - 不能僅依賴 `private` 關鍵字來保護該數據。要想真正確保隱私，可能需要將敏感數據進行加密，並在智能合約內部只存儲加密後的數據。
        - 然而，即使如此，也應該注意到智能合約在鏈上執行的邏輯也是公開的，因此，如果加密和解密的過程包含在合約中，可能仍然存在被分析的風險。   

- **狀態修飾詞 (State Modifiers)**:
    - `pure`: 函數不讀取或修改區塊鏈上的狀態，也不讀取合約內部的變量，純粹執行運算。
    - `view`: 函數可以讀取區塊鏈上的狀態，但不能修改。
    - `payable`: 函數可以接收以太幣。沒有此關鍵字的函數無法接收以太幣。
    
    ![image](https://github.com/user-attachments/assets/f4a71c37-3ab3-4607-ace7-94d31c54983f)
    
    - `payable` 的意義
        - **明確性**：`payable` 關鍵字強制開發者明確標示哪些函數可以接收以太幣，這有助於防止錯誤的資金傳輸，並保護合約的安全性。這是因為不想接收以太幣的函數不應該無意間被允許接收資金。
        - **資金處理**：`payable` 函數允許在執行時附帶以太幣，這在某些場景下非常重要，例如：
            - 當用戶需要支付合約某項服務時。
            - 合約接收捐款或募集資金時。
            - 資金傳遞和處理的相關功能。
    - 注意！智能合約中的函數若要接收以太幣（ETH），必須使用關鍵字 **`payable`** 來聲明。沒有這個關鍵字的函數，即便在執行過程中試圖發送以太幣給合約，也會導致交易失敗
        
        ```solidity
        contract Example {
        	// 沒有 payable 的函數
        	function notPayableFunction() public {
        	// 該函數無法接收以太幣，若嘗試傳送 ETH，交易會失敗
        	}
        	
        	// 有 payable 的函數
        	function payableFunction() public payable {
        	    // 該函數可以接收以太幣，傳送的以太幣會被記錄到合約的餘額中
        	}
        	
        	// 返回合約內的以太幣餘額
        	function getBalance() public view returns (uint) {
        	    return address(this).balance;
        	}
        }
        ```
        
        - **`notPayableFunction()`**：這是一個普通的函數，沒有 `payable` 關鍵字。它不能接收任何以太幣。如果有人在呼叫該函數時傳送以太幣，交易會失敗並回退（revert）。
        - **`payableFunction()`**：這個函數使用了 `payable` 關鍵字，因此它可以接收以太幣。傳送的以太幣將被記錄到合約的餘額中，即 `address(this).balance`。
    - Gas Fee
        - 在以太坊等基於區塊鏈的智能合約平台上，**每個操作**幾乎都需要支付一定的 **gas fee**
        - 這是因為區塊鏈上的每個操作都需要計算資源，這些資源由網絡上的礦工或驗證者提供，並通過 gas 來補償他們的計算成本
        - **哪些操作不消耗 gas**？
            1. **純計算操作 (Pure Functions)**：
            如果函數標記為 `pure`，且只進行純計算操作（如數學運算，不涉及區塊鏈上的狀態），這樣的函數不會消耗 gas，前提是它是在本地執行（即使用 `call` 呼叫，沒有觸發交易）。
            2. **只讀操作 (View Functions)**：
            標記為 `view` 的函數僅僅讀取區塊鏈上的狀態，並且不修改任何狀態變量。在本地呼叫這些函數時（如通過 `call` 方法），不會消耗 gas。這些函數不會改變區塊鏈上的狀態，因此無需支付 gas。
        - 以下是一些會消耗 **gas** 的常見操作：
            - 1. **交易（Transaction）**
                
                任何涉及到在區塊鏈上進行狀態變更的交易都會消耗 gas，包括：
                
                - **發送以太幣**：當用戶從一個帳戶發送以太幣到另一個帳戶，這個交易會消耗 gas。
                - **發送帶有數據的交易**：如果交易包括調用智能合約函數或傳送數據，這會需要更多的 gas。
            - 2. **部署智能合約**
                
                部署一個新的智能合約到區塊鏈上會消耗大量的 gas。這是因為合約的代碼和狀態需要寫入區塊鏈的永久存儲，這是一個相對昂貴的操作。
                
            - 3. **調用智能合約函數**
                
                當用戶或合約調用某個智能合約函數時，根據函數的操作不同，消耗的 gas 也會有所不同：
                
                - **修改區塊鏈狀態**：函數如果會改變區塊鏈上的狀態（例如寫入存儲變量），就會消耗較多的 gas。例如，修改合約中的變量、轉移代幣等操作。
                - **創建新合約**：在合約中創建其他合約（例如工廠模式）會消耗大量的 gas，因為它涉及部署新合約的成本。
            - 4. **寫入儲存 (Storage)**
                
                寫入區塊鏈的 **持久性存儲** 是智能合約中最昂貴的操作之一。當智能合約更新狀態變量或向區塊鏈寫入數據時，這些數據會被永久存儲在區塊鏈中，而這種操作非常昂貴。例如：
                
                - 更新一個 `mapping` 或數組的值。
                - 寫入新的變量或結構到合約的狀態存儲中。
            - 5. **合約中的內部計算與邏輯操作**
                
                即使不改變合約的狀態，合約中的邏輯操作和計算也會消耗 gas，儘管相比存儲操作來說，這些計算的 gas 消耗較低。常見的邏輯操作包括：
                
                - 數學運算 (加法、減法、乘法等)。
                - 邏輯判斷 (`if` 條件、`for` 迴圈)。
                - 哈希運算，例如 `keccak256`。
                - 呼叫其他合約或自身的函數。
            - 6. **讀取存儲 (Storage Reads)**
                
                讀取合約的永久存儲也會消耗 gas，但成本比寫入低得多。儘管讀取是比較便宜的操作，讀取越多數據仍然會增加 gas 的消耗。例如：
                
                - 讀取 `mapping` 或數組的值。
                - 獲取合約的狀態變量。
            - 7. **轉移以太幣或代幣**
                
                當合約內部或外部轉移以太幣或 ERC20 代幣時，這些操作通常會消耗 gas。包括：
                
                - 使用 `transfer()` 或 `send()` 函數轉移以太幣。
                - 調用 ERC20 的 `transfer()` 函數來轉移代幣。
            - 8. **事件 (Events)**
                
                智能合約中的 **事件 (events)** 用於記錄交易日誌，這些日誌不儲存在區塊鏈的永久存儲中，但仍然需要消耗少量的 gas。當合約發出一個事件（例如 `emit` 關鍵字），雖然不會直接影響狀態，但會在交易日誌中保留記錄，這同樣需要 gas。
                
            - 9. **呼叫其他合約**
                
                當一個合約呼叫另一個合約時，這個操作需要額外的 gas。尤其是涉及跨合約的呼叫（例如合約 A 呼叫合約 B 的函數），每次呼叫的過程都會消耗 gas。
                
            - 10. **Self-destruct（自毀合約）**
                
                當合約被自毀（使用 `selfdestruct` 函數）時，合約從區塊鏈中刪除，並將其餘額發送到指定地址。這個操作也會消耗 gas，不過它有時會退還部分 gas，因為自毀後會釋放合約的存儲空間。
                

### 函數小結

- **函數宣告關鍵字**：`function`
- **可見性修飾詞**：`public`, `private`, `internal`, `external`
- **狀態修飾詞**：`pure`, `view`, `payable`
- **其他常用關鍵字**：`returns`, `modifier`, `override`

### 2024.09.25
#### 函數輸出
- 在 Solidity 中，函式可以通過 **`returns`** 關鍵字來指定輸出的值
    
    ```solidity
    function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    	return(1, true, [uint256(1),2,5]);
    }
    ```
    
    - 注意：`returns`跟在函数名後面，`return`在函數裡

- Solidity 如何返回函式輸出
    - 1. 返回單個值
        
        當一個函式返回單個值時，`returns` 關鍵字用來指定輸出類型。函數結束時，會使用 `return` 關鍵字來返回結果。
        
        ```solidity
        contract Example {
        	// 返回一個整數
        	function getNumber() public pure returns (uint) {
        			return 42;
        	}
        	
        	// 返回一個字串
        	function getMessage() public pure returns (string memory) {
        	    return "Hello, Solidity!";
        	}
        }
        ```
        
    - 2. 命名式返回：返回多個值
        
        命名式返回 ＝ `returns` 時有命名。
        
        在 Solidity 中，函式也可以返回多個值。當函式返回多個值時，需要使用小括號 `()` 包裹多個返回型別。相應的，`return` 語句需要返回對應數量的數據。
        
        ```solidity
        contract Example {
        	// 返回多個值：一個整數和兩個字串
        	function returnName() pure external returns (uint _totalSupply, string memory, string memory symbol){
                return (500, "sooo", "easy");
            }
        }
        ```
        
        ![image](https://github.com/user-attachments/assets/2f7857f2-a010-4d01-829f-a0ef732dff3e)

        
    - 3. 命名式返回：返回命名的輸出變量
        
             在 Solidity 中，我們可以為返回值指定名稱，這樣就不需要在 `return` 語句中明確地返回它們。
             這樣做的好處是代碼更加簡潔，而且可以在函式內部隱式地使用這些變量。
        
        ```solidity
        contract ExampleContract {
        	function returnName() pure external returns (uint _totalSupply, string memory message, string memory symbol){
                _totalSupply = 500;
                message = "sooo";
                symbol = "easy";
            }
        }
        
        // 結果同上2.
        ```
        
        ![image](https://github.com/user-attachments/assets/4fa81a7f-4d17-47a4-b266-6e82f7e1f4ee)

        
    - 4. 解構式返回
        
        當函數返回多個值時，可以在函數調用時使用解構式賦值，將返回的值分配給多個變數。
        
        ```solidity
        contract ExampleContract {
            uint public myTotalSupply;
            string public myMessage;
            string public mySymbol;
        
        	function returnName() pure internal returns (uint _totalSupply, string memory message, string memory symbol){
                _totalSupply = 500;
                message = "sooo";
                symbol = "easy";
            }
        
            // 注意：這裡不能用 pure
            function getReturnName() external {
                (uint _totalSupply, string memory message, string memory symbol) = returnName();
                myTotalSupply = _totalSupply;
                myMessage = message;
                mySymbol = symbol;
            }
        }
        ```
        
        - 剛deploy完的起始值
            
            ![image](https://github.com/user-attachments/assets/0d8d65e6-093f-47fa-ac55-206f7c43665f)

            
        - `getReturnName()`被呼叫後，鏈上數據被異動
            
            ![image](https://github.com/user-attachments/assets/93716615-1fe3-4c24-aae2-bcab7e52fa99)

            
        - 何時使用解構式返回？
            
            解構式返回在以下情況中特別有用：
            
            1. **返回多個相關聯的值**：當函數返回多個值，這些值通常是相關聯的（例如一個實體的屬性或運算結果），解構式返回能夠讓你同時處理多個返回值，而不必每次都單獨調用函數。
            2. **提高可讀性**：當處理多個返回值時，解構式賦值能夠提高代碼的可讀性，因為變數名稱可以直接反映它們的含義。這比將返回值放入一個元組然後再逐個提取變數更直觀。
            3. **避免過多的臨時變數**：解構式返回可以在一行代碼中完成多個變數的賦值，減少了臨時變數的使用和賦值操作。
        - 如果只想要部分的返回值
            
            ```solidity
            contract ExampleContract {
                uint public myTotalSupply;
                string public myMessage;
                string public mySymbol;
            
            	function returnName() pure internal returns (uint _totalSupply, string memory message, string memory symbol){
                    _totalSupply = 500;
                    message = "sooo";
                    symbol = "easy";
                }
            
                function getReturnName() external {
                    (, string memory message,) = returnName();
                    myMessage = message;
                }
            }
            ```
            
            - `getReturnName()`被呼叫後，只取其中的 `mySymbol`
                
                ![image](https://github.com/user-attachments/assets/44a164f4-d427-443e-9da5-92165f8beb80)

### 2024.09.26
#### 變量數據儲存與作用域
## **Solidity 中的 Reference Type:**

- 在 Solidity 中，**Reference Type** 是指那些資料型別的數據存放在儲存位置上（如 memory、storage 或 calldata），而不是直接儲存在堆棧上（stack）。
- 這些類型的變數只存儲數據的**引用（reference）**，因此被稱為「參考型別」。
    - **Array**（陣列）
    - **Bytes**（動態字節數組 `bytes`，而不是定長 `bytesN`）
    - **String**（字串）
    - **Struct**（結構體）
    - **Mapping**（映射，但 Mapping 通常只能存在於 storage 中，無法存在於 memory）

## **Reference Type 的儲存位置**：

- 在 Solidity 中，由於參考型別佔的空間大，使用時需要宣告數據儲存的位置。
- 存在不同地方，`gas fee` 不同
- 常見的存儲位置包括：
    - **`storage`**：數據持久化儲存在區塊**鏈上**，是合約的狀態變量。（電腦硬碟，gas fee高）
    - **`memory`**：數據僅在函數執行期間存在，並且不會持久化到區塊鏈。（記憶體）
    - **`calldata`**：僅用於函數參數，**數據是不可修改**的，適用於外部函數參數。（記憶體）
    
    ```solidity
    contract StorageMemoryCalldataExample {
    	// 狀態變量，存儲在 storage 中
    	string public storedData;
    	
    	// 使用 calldata 接收數據，並將數據存儲到 storage 中
    	function setData(string calldata _inputData) public {
    	    storedData = _inputData;  // calldata 中的數據複製到 storage 中
    	}
    	
    	// 使用 memory 中的數據處理
    	function processData() public view returns (string memory) {
    	    string memory temporaryData = storedData;  // 將 storage 中的數據複製到 memory 中
    	    return temporaryData;  // 返回處理過的 memory 中的數據
    	}
    }
    ```
    

## Reference Type 的賦值：

- **賦值本質上是創建引用指向本體**。
- 當你將一個參考型別賦值給另一個變數時，兩個變數會共享同一個底層數據。
- 這樣一來，**修改本體或者引用中的數據，變化都會被同步**，因為它們指向的是同一個數據位置。
- `Storage` 的引用
    
    ```solidity
    contract ReferenceExample {
    	struct Data {
    	uint value;
    	}
    	
    	Data public data1;
    	Data public data2;
    	
    	function assignReference() public {
    	    data1.value = 100;
    	
    	    // 創建 data1 的引用並賦值給 data2，這裡的賦值是創建引用，兩者共享相同的數據
    	    data2 = data1;
    	
    	    // 修改 data2.value，會影響到 data1.value，因為兩者指向同一個存儲位置
    	    data2.value = 200;
    	}
    	
    	function getData1Value() public view returns (uint) {
    	    return data1.value;  // 這裡會返回 200，因為 data1 和 data2 是同一個數據
    	}
    }
    ```
    
- `Memory` 的引用
    
    ```solidity
    contract MemoryReferenceExample {
    	struct Data {
    	uint value;
    	}
    	
    	function modifyMemory() public pure returns (uint) {
        // 創建兩個 memory 中的變數
        Data memory data1 = Data(100);
        Data memory data2 = data1;  // 創建引用，兩者指向同一個 memory 儲存
    
        data2.value = 200;  // 修改 data2.value 會影響 data1.value
    
        return data1.value;  // 返回 200，因為 data1 和 data2 共享同一個 memory 引用
    	}
    }
    ```
    
- 什麼情況下不會同步？
    
    當進行深度複製時，會創建一個新的實例，而不是引用同一個存儲位置。這種情況下，修改其中一個變數不會影響到另一個變數。
    
    例如：
    
    - 如果你明確地在不同的存儲區域（如 `storage` 和 `memory`）之間進行數據傳遞，會發生數據拷貝。
    - 當涉及值型別（如 `uint`、`bool` 等），賦值操作會直接進行數據拷貝，而不會是引用。
    
    ```solidity
    contract CopyExample {
    	uint public x = 10;
    	uint public y;
    	
    	function copyValue() public {
        y = x;  // 這裡是值的拷貝，而不是引用
        y = 20; // 修改 y 不會影響 x，因為它們是獨立的變數
    	}
    	
    	function getX() public view returns (uint) {
    	    return x;  // 返回 10，因為 x 沒有被修改
    	}
    }
    ```
    

## 小結 - 何時使用：

- **`storage`**：當需要永久存儲在區塊鏈上的數據時使用，通常是狀態變量。
- **`memory`**：當你需要處理臨時數據且不需要永久保存時使用，特別是在函數執行期間。
- **`calldata`**：當你需要外部函數的參數且這些參數不需要修改時使用。它是一個節省 gas 的選擇，因為參數直接從交易數據讀取，不進行複製。

### 作用域的分類

**作用域（scope）** 是指變數或函數的可見性範圍，即變數或函數在程式中哪個區域可以被訪問或使用。

在 Solidity 中，作用域主要分為三個層次：

1. **區域作用域（Local Scope）**
2. **狀態作用域（State Scope）**
3. **全域作用域（Global Scope）**

### 1. **區域作用域（Local Scope）**

區域作用域是指在**函數內部**宣告的變數，它們只能在該函數內部使用。一旦函數執行完畢，這些變數就會被銷毀，無法在函數外部或其他函數中訪問。

```solidity
contract Example {
	function localVariableExample() public pure returns (uint) {
		uint localVar = 100;  // 區域變數，作用域僅限於此函數
		return localVar;      // 可以在函數內部訪問
	}
	
	// 在其他函數中無法訪問 localVar，因為它是區域變數
	function anotherFunction() public pure returns (uint) {
	    // uint x = localVar;  // 這行會產生錯誤，localVar 不可見
	    return 200;
	}
}
```

**區域作用域的要點**：

- 區域變數只能在它們所在的函數內使用。
- 區域變數在函數執行結束後會被銷毀。
- 優點：可以避免函數之間的變數命名衝突。

### 2. **狀態作用域（State Scope）**

狀態作用域是指**合約的狀態變數**，這些變數儲存在區塊鏈上，可以在合約中的所有函數中訪問。狀態變數通常是永久存在的，它們會保留在合約的存儲空間（`storage`）中，直到合約被銷毀。

```solidity
contract Example {
	uint public stateVar = 50;  // 狀態變數，可以在合約中所有函數中訪問
	
	function modifyStateVar() public {
	   stateVar = 100;  // 修改狀態變數
	}
	
	function getStateVar() public view returns (uint) {
	    return stateVar;  // 在任何函數中都可以訪問 stateVar
	}
}
```

**狀態作用域的要點**：

- 狀態變數在合約的所有函數中都是可見的。
- 狀態變數存儲在區塊鏈的 `storage` 中，具有持久性。
- 優點：可以保存合約的持久狀態，隨時被合約中的其他函數讀取或修改。

### 3. **全域作用域（Global Scope）**

全域作用域是 Solidity 預定義的變數或函數，這些變數或函數可以在任何地方使用，無需顯式宣告。這些通常是一些全域變數、區塊信息或函數，如 `msg.sender`、`block.timestamp` 等。

```solidity
contract Example {
	function globalScopeExample() public view returns (address, uint) {
		address sender = msg.sender;    // 全域變數，表示呼叫者的地址
		uint timestamp = block.timestamp; // 全域變數，表示區塊時間戳
		return (sender, timestamp);
	}
}
```

**全域作用域的要點**：

- 全域變數或函數是由 Solidity 提供的，不需要顯式宣告。
- 可以在合約的任何地方使用。
- 這些全域變數為合約提供了區塊鏈的上下文信息，例如交易發起者（`msg.sender`）、當前區塊號（`block.number`）等。

### 作用域的重要性

1. **變數衝突與覆蓋**：
使用區域作用域可以避免變數名稱衝突。如果多個函數內部使用相同名稱的變數，由於它們的作用域不同，變數不會相互影響。同時，區域變數可以暫時覆蓋狀態變數的值。
    
    ```solidity
    contract Example {
        uint public stateVar = 50;  // 狀態變數
    
        function localScopeExample() public view returns (uint) {
            uint stateVar = 100;  // 區域變數，暫時覆蓋狀態變數
            return stateVar;      // 返回的是區域變數的值 100，而不是狀態變數的 50
        }
    }
    ```
    
2. **節省資源**：
區域變數存儲在記憶體（`memory`）或堆疊（`stack`）中，並且只在函數執行期間存在，這相比於存儲在區塊鏈上的狀態變數要更高效且節省 gas。這對於臨時運算或處理數據非常重要。
3. **數據安全與邏輯正確性**：
函數的區域變數和狀態變數的作用域清晰界定，有助於確保合約邏輯的正確性，並防止無意中修改合約的狀態變數。
4. **防止無意修改數據**：
理解作用域可以幫助你控制數據的可訪問性，防止不必要的修改。例如，狀態變數的變更是持久性的，如果只需要在短期內使用數據，應該使用區域變數來避免無意的狀態改變。

### 2024.09.27
#### 變量類型：引用

這裡介紹兩種常用的 Reference Type: Array 和 Struct 用法

## Array

通用寫法 T[] 

```solidity
// 固定陣列
uint[3] array4;

// 可變（動態）陣列
bytes1[] array5;
address[] array6;
bytes array7;
```

**注意**：`bytes`比较特殊，不用`[]`

1. 固定長度
    
    ```solidity
    contract ExampleContract {
        // 1.固定
        uint[3] arr1;
    
        // 賦值
        function changFixedArraye() external {
            arr1[0] = 1;
            arr1[1] = 2;
            arr1[2] = 3;
        }
    
        // 直接針對指定索引進行賦值
        function setFixedArray(uint index, uint value) public {
            require(index < 3, "Index out of bounds");
            arr1[index] = value;  
        }
    
        function getFixedArray() external view returns(uint[3] memory) {
            return arr1;
        }
    }
    ```
    
    - 回憶：宣告 `arr1` 時有沒有 `public` 差在哪
        - **有 `public`**：
            - Solidity 會自動生成一個 getter 函數。
            - 外部合約和帳戶可以通過自動生成的 getter 函數直接存取陣列中的個別元素。
        - **沒有 `public`**：
            - 不會生成 getter 函數。
            - 如果需要允許外部存取陣列的值，必須顯式編寫一個函數。
2. 變動長度
    
    ```solidity
    contract ExampleContract {
        // 1.固定
        uint[3] arr1;
    
        // 2. 變動 ---可以使用push.pop
        uint[] arr2;
    
        // 3.動態＋可變
        uint[] arr3 = new uint[](2);
    
        // 賦值
        function changNonFixedArraye() external {
            arr2.push(5);
            arr2.push(6);
            arr2.pop();
        }
    
         function getNonFixedArray() external view returns(uint[] memory) {
            return arr2;
        }
    }
    ```
    
    - deploy後起始值
        
        ![image](https://github.com/user-attachments/assets/41d55237-bfb8-430e-9c2d-e0c85b04b5fc)

        
    - changeNonFixedArray() 之後
        
        ![image](https://github.com/user-attachments/assets/0ffe0da9-ce48-438e-a50c-2a969dd31bb1)

        
3. 動態陣列
    
    ```solidity
    contract ExampleContract {
        // 1.固定
        uint[3] arr1;
    
        // 2. 變動 ---可以使用push.pop
        uint[] arr2;
    
        // 3.動態＋可變
        uint[] arr3 = new uint[](2);
    
        // 賦值
        function changeDynamicArray() external {
            arr3[0] = 9;
            arr3[1] = 10;
            arr3.push(11);
            arr3.push(12);
        }
    
        function getDynamicArray() external view returns(uint[] memory) {
            return arr3;
        }
    
        function getDynamicArrayLength() external view returns(uint) {
            return arr3.length;
        }
    }
    ```
    
    - deploy後起始值
        
        ![image](https://github.com/user-attachments/assets/da227efa-d08c-4dd1-b89f-83f09da052a1)

        
    - changeDynamicArray() 之後
        
        ![image](https://github.com/user-attachments/assets/eb609211-f339-4890-b6af-29975184b075)

### Array 總結：

1. **固定長度陣列 `arr1`**：長度固定，無法動態增減元素，只能通過索引賦值。
2. **變動長度陣列 `arr2`**：可以動態增減元素，使用 `push` 和 `pop` 操作來調整陣列長度。
3. **動態長度陣列 `arr3`（初始有固定長度）**：初始時長度固定，但仍然是一個動態陣列，允許使用 `push` 和 `pop` 進行動態增減。

## Struct

在 Solidity 中，**`struct`** 是用來定義自訂型別的數據結構。

- 定義與宣告
    
    ```solidity
    contract ExampleContract {
        // 定義一個 struct
        struct Person {
            string name;
            uint age;
            address wallet;
        }
    
        // 宣告一個狀態變數，使用這個 struct 類型
        Person public person;
    }
    ```
    
    - 結果
        
        ![image](https://github.com/user-attachments/assets/433068c9-4109-45dd-9dbe-f06eb6c950ac)
        
- 4種賦值寫法
    
    ```solidity
    contract ExampleContract {
        // 定義一個 struct
        struct Person {
            string name;
            uint age;
            address wallet;
        }
    
        // 宣告一個狀態變數，使用這個 struct 類型
        Person public person;
    
        function setPerson1() external {
            Person storage _person = person;
            _person.name = "Tim";
            _person.age = 18;
        }
    
        function setPerson2() external {
            // 使用點語法（dot notation）
            person.name = "John";
            person.age = 30;
        }
    
        function setPerson3() external {
            person = Person("Ken", 60, 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        }
    
        function setPerson4() external {
            person = Person({name: "Gary", age: 90, wallet: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4});
        }
    }
    ```
    
    - 注意：`setPerson1()` 中的 `Person storage _person = person;`
        - 創建了一個指向合約中實際儲存在 `storage` 的 `person` 的引用。
        - 對 `_person` 所做的任何修改，將直接影響原來存儲的 `person`。
- `struct` 的常見應用
    1. **儲存複雜數據結構**：
    當合約需要處理包含多個欄位的數據時，`struct` 是非常理想的解決方案。例如，儲存一個人的詳細資訊、車輛數據、物品資訊等。
    2. **管理多個對象的集合**：
    通常我們會使用 `struct` 來管理一組相關的數據，例如一組玩家、交易或產品。結構體可以用來定義每個對象的屬性，然後將它們存儲在陣列或 `mapping` 中。
    3. **建構複雜的智能合約**：
    當需要處理更複雜的業務邏輯時，`struct` 提供了一種清晰的數據建模方式。例如，在拍賣合約中，`Auction` 可以是一個 `struct`，裡面包含拍賣商品、出價、拍賣時間等多個欄位。
    4. **與 `mapping` 結合**：
    `struct` 經常與 `mapping` 一起使用來快速存取和管理複雜的數據。例如，可以通過 `mapping(address => Person)` 來將每個地址與一個 `Person` 結構體相關聯。
        
        ```solidity
        contract Example {
        		struct Person {
        		string name;
        		uint age;
        		address wallet;
        		}
        		
        		// 使用 mapping 將 address 與 Person 結構體關聯
        	mapping(address => Person) public personMapping;
        	
        	// 添加或更新 Person 資訊
        	function setPerson(string memory _name, uint _age) public {
        	    personMapping[msg.sender] = Person(_name, _age, msg.sender);
        	}
        	
        	// 獲取某個地址的 Person 資訊
        	function getPerson(address _person) public view returns (string memory, uint, address) {
        	    Person memory person = personMapping[_person];
        	    return (person.name, person.age, person.wallet);
        	}
        }
        ```
        

### Struct 總結 :

- **`struct`** 是用來定義自訂數據型別的工具，能將多種不同類型的資料組合在一起。
- 常見應用包括儲存和管理複雜的數據，如人的資訊、產品資訊、交易詳情等。
- 可以與陣列或 `mapping` 結合來管理多個實體。
- 透過 `struct`，可以有效提高代碼的結構性和可讀性，讓智能合約的邏輯更清晰、易於維護。

### 2024.09.28
#### 映射

映射（mapping）就是`key - value` 概念

在 Solidity 中，參考型別（Reference Types）包括 `struct`、`array` 和 `mapping`

### 映射的語法

映射的基本語法如下：

```solidity
mapping(keyType => valueType) public myMapping;
```

- `keyType`: 映射的鍵的類型
    - 是一種偏移量，必須是 Solidity 中的基礎型別（自定義的話Solidity不知道）
    - 合法的 `keyType` 包括以下基礎型別：
        - `uint` / `uint256`
        - `int`
        - `address`
        - `bool`
        - `bytes1` 到 `bytes32` （定長字節數組）
    - **不能**使用複雜型別如 `struct` 或動態陣列作為鍵類型。
    - 如果需要使用陣列或結構體作為鍵，可以先將其哈希處理，然後使用哈希值作為鍵來存取對應的值。
- `valueType`: 映射的值的類型
    - 可以是任何類型，包含基礎型別、結構體、甚至另一個映射。
- mapping 只能存在`storage`，所以通常是狀態變量，不能作為函數參數或返回值。
- 如果是`public`，會自動創建 `getter`，可根據 key 查詢 value

### 映射的特性

1. **默認值**：
映射中的每個鍵在初始化之前都有一個默認值。當你查詢一個從未設定過的鍵時，映射會返回該值類型的默認值。例如，`uint` 的默認值是 `0`，`bool` 的默認值是 `false`，`address` 的默認值是 `0x0000000000000000000000000000000000000000`。
    
    範例：
    
    ```solidity
    function getBalance(address _addr) public view returns (uint) {
        return balances[_addr]; // 如果這個地址未被設定過，返回 0
    }
    ```
    
2. **無法遍歷**：
Solidity 中的映射無法被遍歷，這是因為映射不會儲存鍵的清單，也無法得知有哪些鍵存在。因此，你無法列舉映射中所有的鍵值對。如果需要遍歷資料，通常會與陣列一起使用來記錄所有鍵。
3. **只支持基礎型別作為鍵**：
映射的鍵只能是 Solidity 支援的基礎型別，如 `address`、`uint`、`bytes32` 等，不能是動態陣列或 `struct`。
4. **動態大小**：
映射的大小是動態的，可以根據需要添加新的鍵值對。無需在初始化時指定映射的大小。
5. **值可以是任何類型**：
映射的值類型可以是任何類型，包括基礎型別、陣列、結構體，甚至是其他映射。

### 映射的應用場景

1. **管理用戶餘額**：
映射常用於管理帳戶餘額。例如，可以用映射來儲存每個地址對應的代幣或資金餘額。
    
    ```solidity
    contract ExampleContract {
        // 錢包地址對應多少錢
        mapping(address => uint) public balanceOf;
    
        // 給他錢
        function mint() external{
            balanceOf[msg.sender] = 50 ether;
        }
    
        // 燒毀
        function burn() external{
            balanceOf[msg.sender] = 10 ether;
        }
    }
    ```
    
    - deploy 起始值
        
        ![image](https://github.com/user-attachments/assets/d3beddc7-70fc-4b67-904d-b1f9e87a997d)

        
    - mint() 之後
        
        ![image](https://github.com/user-attachments/assets/12dd3ffb-10c9-48e2-8744-f184d7785905)

        
    - burn() 之後
        
        ![image](https://github.com/user-attachments/assets/bfe53d46-2777-4b0d-9472-d12d4d7bfae8)

        
2. **白名單（Whitelist）或黑名單（Blacklist）**：
映射可以用來跟蹤某個地址是否在白名單或黑名單中。可以用布林值（`bool`）來標記某個地址是否被允許或禁止。
    
    ```solidity
    mapping(address => bool) public whitelist;
    
    function addToWhitelist(address _addr) public {
        whitelist[_addr] = true;
    }
    
    function isWhitelisted(address _addr) public view returns (bool) {
        return whitelist[_addr];
    }
    ```
    
3. **管理多重資料結構**：
映射可以與結構體（`struct`）結合使用，來管理更複雜的資料。例如，可以建立一個 `struct`，然後將每個地址與該結構體關聯。
    
    範例：
    
    ```solidity
    struct User {
        string name;
        uint age;
    }
    
    mapping(address => User) public users;
    
    function setUser(address _addr, string memory _name, uint _age) public {
        users[_addr] = User(_name, _age);
    }
    
    function getUser(address _addr) public view returns (string memory, uint) {
        User memory user = users[_addr];
        return (user.name, user.age);
    }
    ```
    
4. **允許或拒絕操作權限**：
映射可以用來跟蹤某些地址是否有權限執行某些操作，例如在某個合約中授權特定地址進行操作。
    
    ```solidity
    mapping(address => bool) public authorized;
    
    function authorize(address _addr) public {
        authorized[_addr] = true;
    }
    
    function revoke(address _addr) public {
        authorized[_addr] = false;
    }
    
    function isAuthorized(address _addr) public view returns (bool) {
        return authorized[_addr];
    }
    ```
    

### 映射的限制

1. **無法遍歷**：
如前所述，映射中的鍵不能被遍歷。因此，如果需要檢查所有的鍵值對，需要自己維護一個鍵的陣列來實現遍歷。
    
    ```solidity
    address[] public keys;
    
    function addKey(address _key) public {
        keys.push(_key);
    }
    
    function getAllKeys() public view returns (address[] memory) {
        return keys;
    }
    ```
    
2. **無法確定鍵是否存在**：
    
    ```solidity
    mapping(address => bool) public whitelist;
    
    function isWhitelisted(address _addr) public view returns (bool) {
        return whitelist[_addr]; // 如果地址未被設定，默認為 false
    }
    
    ```
    
    - Solidity 無法直接判斷某個鍵是否存在於映射中。
    - 當查詢一個不存在的鍵時，映射會返回默認值，而不是告知該鍵不存在。
    - 因此，當值類型有明確的默認值時（如 `uint` 的默認值為 `0`），可能需要額外的邏輯來判斷一個鍵是否實際存在。

### 2024.09.30
#### 變量初始值
### 前言

- 在 Solidity 中，所有變量在宣告後，若未經過初始化，都會自動設置為對應型別的**默認初始值**。
- 默認初始值是基於變量的資料型別來決定的。
- 了解這些默認值以及 `delete` 關鍵字的作用非常重要，可以幫助在管理智能合約中的狀態變量時避免意外行為。

### 變量的初始值

每種類型的默認初始值如下：

- **`uint` 和 `int`**（無符號與有符號整數）：默認值為 `0`。
- **`bool`**（布林型）：默認值為 `false`。
- **`address`**（地址型）：默認值為 `0x0000000000000000000000000000000000000000` （0x + 40個0）。
- **`bytes`（定長字節）**：默認為 `0x0000...`，填滿零。
- **`mapping`**：映射中的每個鍵在初始時對應的值是其值類型的默認值（例如，`mapping(address => uint)` 中每個地址對應的值初始為 `0`）。
- **`array`（陣列）**：動態陣列的長度默認為 `0`。定長陣列的每個元素為其類型的默認值。
- **`struct`（結構體）**：結構體中的每個成員變數會被初始化為其型別的默認值。

```solidity
contract ExampleContract {
    // Value Type
    bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum; // 第1個Buy的索引0

    function fi() internal{} // internal空白函数
    function fe() external{} // external空白函数
}
```

![image](https://github.com/user-attachments/assets/0f6fe1cb-3ee7-4b4c-9d94-7be40631fbd1)


```solidity
   	// Reference Types
    uint[8] public _staticArray; // [0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`
    mapping(uint => address) public _mapping; // 所有元素都為其默認值的mapping
    
    // 所有成員設為其默認值的結構體 0, 0
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student;
```

![image](https://github.com/user-attachments/assets/98a38a9f-7498-47b0-8fde-319f7bf54983)


### `delete` 關鍵字

- 將變量重置為其默認初始值的操作。
- 它可以用來重置任何變量，無論是基礎型別（例如 `uint`、`bool` 等），還是複合型別（例如陣列、結構體或映射中的特定鍵值）。
- 範例：
    
    ```solidity
    contract ExampleContract {
        struct Person {
            string name;
            uint age;
        }
    
        Person public person = Person("Alice", 30);
    
        function resetPerson() public {
            delete person;  // 重置 person 的 name 為空字串，age 為 0
        }
    }
    ```
    
    - deploy 起始值
        
        ![image](https://github.com/user-attachments/assets/7377d599-430a-439f-af0c-cb6d891b7303)

        
    - delete 後
        
        ![image](https://github.com/user-attachments/assets/95e42f8d-e735-4b43-aef1-2b7d70c05eeb)

        

### `delete` 的作用

- **對基礎型別**：將變量設置為其型別的默認初始值。例如，對 `uint` 使用 `delete`，會將其重置為 `0`；對 `bool` 使用 `delete`，會將其設置為 `false`。
- **對引用型別（陣列、映射等）**：`delete` 將引用型別的內容重置為初始狀態，例如清空陣列、刪除映射中的特定鍵值等。

### 2024.10.01
#### 常數的兩個關鍵字：const, immutable
### 前言

- 在 Solidity 中，**常數（constants）** 是不可變的值，
- 常數一旦設置後，在合約的生命週期中就不能再更改。
- Solidity 提供了兩個關鍵字來定義常數：**`constant`** 和 **`immutable`**。
- 這兩個關鍵字都能提高合約的效率，並確保特定變數的值不會被篡改，但它們有不同的使用場景和特性。

### 1. **`constant` 關鍵字**

- 定義的變量必須在宣告時立即初始化，並且初始化的值必須是**編譯時已知的常量**。

```solidity
contract Example {
	// 使用 constant 定義常數
	uint256 public constant MY_CONSTANT = 100;
	string public constant NAME = "Alice";
	address public constant OWNER = 0x1234567890abcdef1234567890abcdef12345678;
}
```

- **宣告**：在變量的類型後加上 `constant` 關鍵字。
- **初始化**：`constant` 變量必須在宣告時進行初始化，且其值不可在合約的任何地方更改。
- **效率**：`constant` 變量的值在編譯時期就會被確定，並直接嵌入到合約的字節碼中。這樣可以減少存儲需求，降低部署和運行時的 gas 消耗。

### 2. **`immutable` 關鍵字**

- `immutable` 允許定義在部署合約時設置一次且之後不可變更的變量。
- 與 `constant` 不同，`immutable` 變量的值可以在合約的`建構函數（constructor）`中進行初始化，而不必在宣告時立即賦值。
- `immutable` 只支持固定大小的型別
- `string` 和 `bytes` 是動態大小的資料型別（長度不固定），不能用`immutable`

```solidity
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;

// 利用constructor初始化immutable變量
// 可以使用全局變量例如 address(this)、block.number 或者自定義的函數給 immutable 變量初始化
// 在下面這個例子中，利用了 test() 函數給 IMMUTABLE_TEST 初始化為 9。
constructor(){
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}

function test() public pure returns(uint256){
    uint256 what = 9;
    return(what);
}
```

- 結果

![image](https://github.com/user-attachments/assets/8df02d17-9669-46a0-b025-4eaaf8cdfb59)


### `constant` 與 `immutable` 的比較

| 特性 | `constant` | `immutable` |
| --- | --- | --- |
| **初始化時間** | 必須在宣告時賦值 | 可以在建構函數中初始化 |
| **修改** | 無法修改，一旦設置後永遠不可改變 | 只能在建構函數中設置，之後不可更改 |
| **編譯時/部署時** | 在編譯時設置 | 在合約部署時設置 |
| **用途** | 用於編譯時已知的值 | 用於部署時期才確定的值 |
| **Gas 效率** | 更高效（直接編譯進字節碼） | 高效，但稍差於 `constant` |
| **存儲位置** | 嵌入到**合約的字節碼**中（contract bytecode） | 存儲在**合約的字節碼**中 |
| **訪問效率** | **最高**效率，因為值直接嵌入字節碼中 | **高效率**，從合約字節碼中讀取，不涉及 `storage` |

- 注意：**訪問效率** 和 **Gas 費用** 並不是完全相等的概念
    - 定義：
        - **訪問效率**：指的是訪問或操作變量所需的計算資源和時間。高效率的操作通常需要較少的計算步驟，例如直接從合約字節碼中讀取常數，而不涉及對區塊鏈上 `storage` 的存取，這樣的操作會被認為是高效的。
        - **Gas 費用**：是以太坊網絡對計算和存儲操作的計費方式。每次在智能合約中執行的操作都會消耗一定的 Gas，操作越複雜或需要讀寫區塊鏈存儲的資源越多，消耗的 Gas 也就越多。因此，訪問效率高的操作通常需要更少的 Gas。
    - 關係：
        - 如果一個操作非常高效（例如直接從字節碼中讀取常數），它需要的 Gas 很少。
        - 如果操作涉及存取區塊鏈的 `storage`（例如讀取或寫入存儲變量），則效率較低，並且需要更多的 Gas。

### 為什麼這些關鍵字很重要？

1. **安全性**：`constant` 和 `immutable` 能夠保證變量在合約的整個生命周期中保持不變，從而防止惡意或意外的變更，增強了合約的安全性。
2. **節省 Gas**：這些變量不會儲存在永久性 `storage` 中，因此不需要消耗額外的存儲資源。這可以顯著降低合約的部署和執行成本。特別是 `constant`，其值直接嵌入到合約的字節碼中，這進一步提升了效率。
3. **代碼的可讀性和明確性**：通過明確標記某些變量為不可變，可以幫助開發者更好地理解合約的邏輯和設計意圖，並使代碼更加易於維護。

### 2024.10.02
#### 控制流 ＆ 插入排序
1. if - else

```solidity
contract ExampleContract {
    function isPositive(int number) external pure returns (bool) {
        if (number > 0) {
            return true;
        } else {
            return false;
        }
    }
}
```

2. for 迴圈

```solidity
contract ExampleContract {
	function addSum() external pure returns (uint) {
		uint sum = 0;
		for (uint i = 0; i < 10; i++) {
			sum = sum + i;
		}
		return sum;
	}
}
```

![image](https://github.com/user-attachments/assets/6bef0c89-81c3-454b-abe0-2b443b3798b0)


3. while

```solidity
contract ExampleContract {
    function addSum() external pure returns (uint) {
        uint sum = 0;
        uint n = 0;
        while(n < 10){
            sum = sum + n;
            n ++;
        }
        return sum;
    }
}
```

![image](https://github.com/user-attachments/assets/7eed044d-2b05-4527-a6e4-67526721759c)


4. do while(至少執行一次do)

```solidity
contract ExampleContract {
    function addSum() external pure returns (uint) {
        uint sum = 0;
        uint n = 0;
        do {
            sum += n;
            n++;
        }while(n < 10);
        return sum;
    }
}
```

![image](https://github.com/user-attachments/assets/652c58f5-da50-414c-ab58-f623aca62d92)


1. 跳出當前循環用 `break`，跳到下一個循環用 `continue`

- 練習：以 solidity 寫 insertion sort

```solidity
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // note that uint can not take negative value
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i;
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}
```
### 2024.10.03
#### 建構函數與修飾器
### 1. 建構函數（Constructor）

建構函數是智能合約的特殊函數，它在合約**部署**時被自動執行。

主要用來設置合約的初始狀態，例如設定初始變數值、初始化合約的擁有者等。

### 特點：

- **自動執行**：當合約被部署（即在區塊鏈上創建合約實例）時，建構函數會自動執行一次。
- **命名方式**：在 Solidity 0.4.22 版本及更早版本，建構函數的名字必須和合約的名字相同；在 Solidity 0.4.22 之後，使用 `constructor` 關鍵字定義建構函數。
- **無法重複調用**：建構函數只能執行一次，合約部署後無法再次被調用。

```solidity
contract MyContract {
	address public owner;
	
	// 建構函數
	constructor() {
	    owner = msg.sender; // 將合約的擁有者設置為部署者
	}
}
```

### 2. 修飾器（Modifier）

修飾器是一個可以用來**修改或限制**函數行為的程式塊。

它們主要用來進行條件檢查或邏輯控制，並且通常在需要對函數執行前進行一些前置條件檢查的場景下使用。

### 特點：

- **函數前置條件**：修飾器可以在函數執行之前檢查條件，若條件不符合，可以阻止函數執行。
- **代碼復用**：透過修飾器，可以避免在多個函數中重複寫相同的檢查代碼。
- **`_` 符號**：修飾器中的 `_` 表示函數本身的邏輯會在修飾器檢查通過後的這個位置執行。

```solidity
contract MyContract {
	address public owner;
	
	// 修飾器：檢查調用者是否為擁有者
	modifier onlyOwner() {
	    require(msg.sender == owner, "You are not the owner");
	    _; // 在此處執行原本的函數邏輯
	}
	
	// 建構函數
	constructor() {
	    owner = msg.sender; // 設置合約的擁有者為部署者
	}
	
	// 含有modifier方法
	// 只有當前調用者為擁有者時，才能執行此函數
	function changeOwner(address newOwner) external onlyOwner{
      owner = newOwner;
  }
}
```

在這個例子中，`onlyOwner` 修飾器檢查當前調用者是否是合約的擁有者。

如果條件不滿足，會拋出錯誤並阻止函數執行。

這樣可以保證特定`Function` 只有合約的擁有者才能調用。

- 起始合約 owner
    
    ![image](https://github.com/user-attachments/assets/f51d8d7e-bf63-4802-816f-2ccd71616f4d)

    
- 非該合約 owner 呼叫 `changeOwner` 時
    
    ![image](https://github.com/user-attachments/assets/c40af1fe-fcba-4d4a-a77f-62108379663a)

    
- 該合約 owner 呼叫 `changeOwner` 時
    
    ![image](https://github.com/user-attachments/assets/b859a581-ec39-44c0-b2ea-ee0d025eea44)

    

### 3. 修飾器的應用場景

- **權限控制**：如 `onlyOwner` 檢查，確保只有特定人員能執行某些操作。
- **狀態檢查**：檢查合約當前的狀態是否允許執行特定函數，如某種狀態值。
- **防止重入攻擊**：修飾器可以用來防範 Solidity 中常見的重入攻擊（reentrancy attack），即在函數調用過程中，惡意合約再次調用相同函數，導致合約邏輯被惡意多次執行。

### 總結

- **建構函數**：在合約部署時執行，用於初始化合約的狀態。
- **修飾器**：用來修改函數執行行為，主要用於檢查條件並控制函數執行。

### 2024.10.04
#### 事件
## 前言

- 事件(event) 就是EVM 上的 log
- 這些日誌記錄在區塊鏈中，但不會影響智能合約的狀態，並且比存儲在區塊鏈的數據便宜。
- 外部應用(前端透過web3.js或ether.js)可以「監聽」這些事件。
- 一旦事件被觸發，就可以接收到相關的數據。

### 事件的語法

在 Solidity 中，事件使用 `event` 關鍵字來定義。通常，事件包含一組參數，這些參數可以是原始類型或結構。觸發事件使用 `emit` 關鍵字。

以下是一個簡單的事件定義和使用範例：

```solidity
contract Example {
    // 定義事件
    event Deposit(address indexed _from, uint _value);

    // 觸發事件
    function deposit() public payable {
        emit Deposit(msg.sender, msg.value);
    }
}
```

在這個範例中：

- 定義了一個 `Deposit` 事件，它有兩個參數：`_from`（代表存款者的地址）和 `_value`（代表存入的金額）。
- 當 `deposit` 函數被調用時，`emit` 關鍵字會觸發這個事件，將存款者的地址和金額記錄到區塊鏈的日誌中。

### **使用事件的時機**

事件在智能合約的開發中具有多種用途。常見的使用時機包括：

1. **追蹤狀態變更**：
當智能合約的狀態發生變化時，可以使用事件來記錄這些變化。外部應用或用戶可以通過監聽事件來追蹤合約的執行情況。這尤其適用於 DeFi 應用、NFT 合約等，需要跟蹤交易或狀態更新的場景。
    
    例如：在一個拍賣智能合約中，當有新的出價或拍賣結束時，可以發出相應的事件來通知前端。
    
2. **記錄交易相關信息**：
事件可以記錄特定交易的細節，特別是在智能合約內部沒有其他存儲機制或需要減少 gas 費用的情況下。這些交易細節對於區塊鏈上的審計和數據分析非常有幫助。
3. **與外部應用程序溝通**：
當合約執行某些重要操作時（如資金轉移或權限變更），可以通過事件來通知外部應用。應用可以監聽這些事件並做出相應的反應，比如更新前端的顯示、觸發後續的智能合約操作等。
4. **減少 gas 消耗**：
在某些情況下，將數據寫入日誌比寫入區塊鏈狀態（如變量或映射）更為經濟。由於事件的數據儲存在日誌中，它們不會消耗太多的 gas。這對於需要大量數據寫入但不需要永久保存的情況非常有用。
5. **調試和日誌記錄**：
在合約的開發過程中，事件也可以用作調試工具。開發者可以使用事件來捕捉合約內部的執行流程和變量的變化，從而更容易定位和解決問題。

### **事件的限制**

- **不可讀取**：事件中的數據儲存在區塊鏈的日誌中，因此無法直接從智能合約內部讀取到這些數據。它們僅供外部應用程序讀取。
- **不保證執行**：事件只是寫入日誌，不會對合約的狀態產生影響，也不會影響交易的成敗。因此，`不應依賴事件來實現合約內部的核心邏輯`。

## 補充：課程範例-查看 logs

```solidity
contract ExampleContract {
    event Transfer(address _from, address _to, uint value);
    uint a;

    function transfer(address _from, address _to, uint value) external {
      a = 10;
      emit Transfer(_from, _to, value);
    }
}
```

![image](https://github.com/user-attachments/assets/c153f3b6-c938-4230-a3b0-c9cdc74bd6a5)


![image](https://github.com/user-attachments/assets/5b472020-090a-4082-8e45-f1b9120a636b)


- 有加 `indexed` 的會被記錄到 `topics`

```solidity
contract ExampleContract {
    event Transfer(address indexed _from, address indexed _to, uint value);
    uint a;

    function transfer(address _from, address _to, uint value) external {
      a = 10;
      emit Transfer(_from, _to, value);
    }
}
```

![image](https://github.com/user-attachments/assets/297d8e5f-b48d-4924-9431-d26480c94856)


### **EVM 日誌（Logs）的結構**

![image](https://github.com/user-attachments/assets/f9325e2e-c7ed-4449-ab02-f6b9f7e08c06)


當事件在 Solidity 中被觸發時，EVM 會生成一個**日誌條目**，並將其寫入區塊的日誌區域。這些日誌條目包括：

1. **地址（Address）**：觸發事件的合約地址。
2. **主題（Topics）**：每個日誌條目最多可以包含四個主題，用來索引事件參數，從而幫助過濾特定類型的事件。
3. **數據（Data）**：存儲與事件相關的具體數據，通常是事件的非索引參數。

這些日誌不會影響合約的內部狀態，它們只是一種「外部輸出」，方便外部應用程式（如 DApp）或區塊鏈瀏覽器進行檢索和分析。

### **事件如何存儲在日誌中**

在 Solidity 中，每當 `emit` 關鍵字觸發一個事件時，EVM 會將該事件存儲為日誌條目。這些日誌條目存儲在每個區塊中，並與區塊的其他交易數據一同保存。

### 具體的存儲結構包括：

1. **合約地址**：用來標識是由哪個智能合約觸發的事件。這是日誌的**發件人地址**，即觸發事件的智能合約的地址。
2. **事件的 Keccak-256 哈希值**：事件簽名（包括事件名稱和參數類型）會被哈希化為 256 位的雜湊值，這個值存儲在 `topics[0]` 中。這是每個事件獨有的識別符，幫助過濾器在大量日誌中識別具體的事件類型。
    - https://emn178.github.io/online-tools/keccak_256.html
        
        例如，對於以下事件：
        
        ```solidity
        event Transfer(address indexed _from, address indexed _to, uint256 _value);
        ```
        
        EVM 會計算這個簽名的哈希：
        
        ```solidity
        keccak256("Transfer(address,address,uint256)")
        
        // ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
        ```
        
3. **索引參數（Indexed Parameters）**：事件定義中的 `indexed` 參數會被儲存到 `topics` 陣列的後續位置。最多可以有三個索引參數，每個索引參數會以 Keccak-256 的格式哈希存儲。這樣可以通過索引進行高效查詢。
    - 在上述事件中，`_from` 和 `_to` 都是 `indexed` 參數，因此它們的哈希值會被存儲在 `topics[1]` 和 `topics[2]`。
4. **非索引參數（Non-indexed Parameters）**：不帶 `indexed` 關鍵字的參數會以原始格式存儲在日誌的數據段（`data`）中。這些參數不會被索引，因此無法直接通過過濾器查詢，但可以從日誌中讀取。
    - 在 `Transfer` 事件中，`_value` 是一個非索引參數，因此它會被存儲在日誌的數據段內，而不是 `topics` 中。

### **如何檢索日誌**

事件被儲存在區塊鏈日誌中，而外部應用可以使用 `eth_getLogs` 這樣的 RPC 調用來檢索這些日誌。因為索引參數被存儲在 `topics` 中，外部應用可以使用參數過濾器來高效查詢特定的事件。

### **日誌和事件的特點**

1. **高效性**：日誌（logs）是 EVM 的「輕量級」記錄，寫入和檢索相對低成本，不會像區塊鏈狀態存儲那樣消耗太多 gas。
2. **過濾能力**：事件的索引參數被存儲在 `topics` 中，允許對事件進行高效的查詢和過濾。
3. **只寫性**：事件的數據被存儲在日誌中，這些日誌只能被寫入，無法在智能合約內部讀取，這確保了它們僅用於外部交互，而不會改變區塊鏈狀態。
4. **不可變性**：一旦事件被寫入區塊，日誌就是不可變的。這意味著日誌提供了一種可靠的方式來追蹤歷史事件，這對於審計和數據分析非常有用。
<!-- Content_END -->
