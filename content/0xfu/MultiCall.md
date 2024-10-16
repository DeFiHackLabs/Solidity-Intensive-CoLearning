
### MultiCall 多重调用

MultiCall（多重调用）合约的设计能在一次交易中执行多个函数调用m，优点如下：

- 方便性：MultiCall能在一次交易中对不同合约的不同函数进行调用，同时这些调用还可以使用不同的参数。比如你可以一次性查询多个地址的ERC20代币余额。
- 节省gas：MultiCall能将多个交易合并成一次交易中的多个调用，从而节省gas。
- 原子性：MultiCall能让用户在一笔交易中执行所有操作，保证所有操作要么全部成功，要么全部失败，这样就保持了原子性。比如可以按照特定的顺序进行一系列的代币交易。


### MultiCall 合约

```Solidity 
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
