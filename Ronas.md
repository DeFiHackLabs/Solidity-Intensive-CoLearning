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

### 2024.09.24

> 進度: Solidity 101 5~6

- 資料位置 (Data Location)
    > https://docs.soliditylang.org/en/v0.8.27/types.html#data-location
    - 分三種
        - `storage` 儲存在鏈上
        - `memory` 儲存在記憶體中 不上鏈
        - `calldata` 儲存在記憶體中 不上鏈 不能修改 (一般用於函數的參數)
    - 不同資料類型相互賦值時，會產生獨立的副本，修改新變數不會改到原數值
    - 相同資料類型相互賦值時，會建立引用，修改新變數會改到原變數值
- 變數作用範圍
    - 狀態變數: 儲存在鏈上的變數
    - 全域變數: 作用範圍在整個合約中
    - 區域變數: 作用範圍僅在函數中
- 乙太單位
    - `wei`: 1
    - `gwei`: 1e9
    - `ether`: 1e18
- 時間單位
    - `seconds`
    - `minutes`
    - `hours`
    - `days`
    - `weeks`
- 引用 (Reference Types)
    - `array`
        - 宣告
            - 固定長度 `uint[5] arr1;`
            - 可變長度 `uint[] arr2;`
        - 初始化
            - 可用 new
                ```
                uint[] memory arr1 = new uint[](5);
                bytes memory arr2 = new bytes(9);
                ```
        - 成員函數 
            - `length`
            - `push()` 在 array 最後添加 0
            - `push(3)` 在 array 最後添加 3 
            - `pop()` 移除最後一個元素
    - `struct`
        ```
        struct Student{
            uint256 id;
            uint256 score; 
        }

        Student student;
        
        function initStudent1() external{
            Student storage _student = student; // _student = reference of student
            _student.id = 11;
            _student.score = 100;
        }
        ```
    
- 映射 (Mapping Types)

### 2024.09.25

<!-- Content_END -->
