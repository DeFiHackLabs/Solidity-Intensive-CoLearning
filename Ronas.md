---
timezone: Asia/Shanghai
---

# Ronas

1. 自我介绍
資安研究員 WEB3新手
2. 你认为你会完成本次残酷学习吗？
會
   
## Notes

<!-- Content_START -->

### 2024.09.23

> 進度: Solidity 101 1~4

#### HelloWeb3

#### 變數類型 (Types)

> https://docs.soliditylang.org/en/v0.8.27/types.html#value-types

- 值 (Value Types)
    - 布林 (Booleans): `true`, `false`
    - 整數 (Integers)
        - 32 種有號整數: `int8`, `int16`,`int24`,`int32`,...`int256` (8bit to 256bit)
        - 32 種無號整數: `uint8`, `uint16`,`uint24`,`uint32`,...`uint256` 
        - 沒有浮點數型別, 除法之後結果會取整數
    - 地址 (Address)
        - `address`: 20 Byte 值
            - 可以將 `uint160`,整數,`bytes20`,合約類型轉型為address
                ```
                // uint160 <-> address
                uint160 number = 123456789;
                address addr = address(number);
                uint160 backToUint = uint160(addr);

                // integer literals
                address addr = address(123456789); 

                // bytes20 -> address
                bytes20 b = bytes20(address(0x1234567890abcdef1234567890abcdef12345678));
                address addr = address(b);
                
                // contract types
                contract MyContract {
                    // 合约内容
                }

                MyContract myContract = MyContract(0x1234567890abcdef1234567890abcdef12345678);
                address addr = address(myContract);
                ```
        - `address payable`: 具有成員函數 `transfer` 及 `send`
    - 合約 (Contract Types)
        - 可以與 `address` 型別互相轉換
    - 位元組陣列 (Fixed-size byte arrays)
        - `bytes1`, `bytes2`, `bytes3`, …, `bytes32`
    - 枚舉 (Enum)
    - 函數 (Function Types)
        > https://docs.soliditylang.org/en/v0.8.27/types.html#function-types
        ```
        function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
        ```
        - 存取控制 `{internal|external|public|private}`
        - 權限 `[pure|view|payable]`
            - 可讀可寫合約狀態: `payable` (修改全域變數)
            - 只可讀不可寫: `view` (可讀取全域變數)
            - 不可讀不可寫: `pure` (不可讀取全域變數)
        - 返回語法
            - 只定義返回型別 (類似大部分程式語言)
            - 命名式返回: 定義返回型別及返回變數名稱，不須在程式碼中多一行指定 return
            - 命名式返回要在程式碼中多一行指定 return 回傳值也可以
        - 解構式取得回傳值
            - 可取得全部 `(_number, _bool, _array) = returnNamed();`
            - 或對位取得部分 `(, _bool2, ) = returnNamed();`
- 引用 (Reference Types)
- 映射 (Mapping Types)

### 2024.09.24

<!-- Content_END -->
