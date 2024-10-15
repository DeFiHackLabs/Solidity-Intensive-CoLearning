### 54.MultiCall

MultiCall 多重調用合約，它的設計目的在於一次交易中執行多個函數調用，這樣可以顯著降低交易費用並提高效率

在Solidity中，MultiCall（多重呼叫）合約的設計能讓我們在一次交易中執行多個函數呼叫。它的優點如下：

- `方便性`：MultiCall能讓你在一次交易中對不同合約的不同函數進行調用，同時這些調用還可以使用不同的參數。例如你可以一次查詢多個地址的ERC20代幣餘額。

- `節省gas`：MultiCall能將多個交易合併成一次交易中的多個調用，從而節省gas。

- `原子性`：MultiCall能讓使用者在一筆交易中執行所有操作，並保證所有操作要麼全部成功，要麼全部失敗，這樣就保持了原子性。例如，你可以按照特定的順序進行一系列的代幣交易。

就是打包呼叫～


#### MultiCall合約

`MultiCall` 合約定義了兩個結構體:

    - `Call`: 這是一個呼叫結構體，包含要呼叫的目標合約target，指示是否允許呼叫失敗的標記allowFailure，和要呼叫的字節碼call data。

    - `Result`: 這是一個結果結構體，包含了指示呼叫是否成功的標記success和呼叫傳回的字節碼return data。

該合約只包含了一個函數，用於執行多重呼叫：

    - `multicall()`: 這個函數的參數是由Call結構體組成的數組，這樣做可以確保傳入的target和data的長度一致。函數透過一個循環來執行多個調用，並在調用失​​敗時回滾交易。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Multicall {
    // Call结构体，包含目标合约target，是否允许调用失败allowFailure，和call data
    struct Call {
        address target;
        bool allowFailure;
        bytes callData;
    }

    // Result结构体，包含调用是否成功和return data
    struct Result {
        bool success;
        bytes returnData;
    }

    /// @notice 将多个调用（支持不同合约/不同方法/不同参数）合并到一次调用
    /// @param calls Call结构体组成的数组
    /// @return returnData Result结构体组成的数组
    function multicall(Call[] calldata calls) public returns (Result[] memory returnData) {
        uint256 length = calls.length;
        returnData = new Result[](length);
        Call calldata calli;
        
        // 在循环中依次调用
        for (uint256 i = 0; i < length; i++) {
            Result memory result = returnData[i];
            calli = calls[i];
            (result.success, result.returnData) = calli.target.call(calli.callData);
            // 如果 calli.allowFailure 和 result.success 均为 false，则 revert
            if (!(calli.allowFailure || result.success)){
                revert("Multicall: call failed");
            }
        }
    }
}
```

#### 實作


1. 我們先部署一個非常簡單的ERC20代幣合約MCERC20，並記錄下合約地址。


2. 部署MultiCall合約，並記錄下合約地址。

3. 先搞清楚設定參數

      - `target`：目標合約的地址。
      - `allowFailure`：是否允許呼叫失敗。
      - `callData`：要呼叫的字節碼。

`call data` 怎麼產生?

EX:

選擇器（selector）是一個函數的哈希值的前四個字節。在 Solidity 中，你可以使用 `bytes4(keccak256(mint(address,uint)"))` 來獲取函數的選擇器。

selector: `0x40c10f19`

參數的話都要 32 個字節可以利用之前的 hashEx了轉換

address: `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`
uint: 50

`0x40c10f19 + 32 bytes + 32 bytes`

`0x40c10f190000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000032`

以上設定了解了，我們就是多個呼叫。

`calls[]`

```
[["0x7C4e30a43ecC4d3231b5B07ed082329020D141F3", true,"0x40c10f190000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000032"],[....]]

4. 利用`MultiCall`的`multicall()`函數呼叫ERC20代幣合約的mint()函數，給2個地址分別鑄造50 和100 單位的代幣
```


總結：
  不太確定為什麼用 remix 呼叫 multiCall 非常的慢，但大致了解可以一次呼叫很多個合約的函數，這樣可以節省很多 gas。