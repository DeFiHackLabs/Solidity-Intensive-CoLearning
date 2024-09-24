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

<!-- Content_END -->
