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

### 2024.09.25

> 進度: Solidity 101 7~8

- 映射 (Mapping Types)
    > https://docs.soliditylang.org/en/latest/types.html#mapping-types
    - `mapping(_KeyType => _ValueType)`
        - `_KeyType` 只能使用內建的值類型, 不能使用結構
        - `_ValueType` 可以使用結構
    - 儲存位置必須為 `storage`
    - 不能用於 `public` 函數的參數或回傳值

- 變數初始值
    - 值類型
        - `boolean`: `false`
        - `string`: `""`
        - `int`: `0`
        - `uint`: `0`
        - `enum`: 第一個元素
        - `address`: `0x0000000000000000000000000000000000000000` (`address(0)`)
        - `function`
    - 引用類型
        - `mapping` key/value的初始值的映射
        - `struct` 成員類型的初始值
        - `array`
            - 動態 `[]`
            - 靜態
    - `delete a` 會使變數 `a` 的值變為初始值

### 2024.09.26

> 進度: Solidity 101 9~11

- 常數
    - `constant` 須在宣告時賦值, 後續不能改 `TypeError: Cannot assign to a constant variable.`
    - `immutable` 可在宣告時或在建構函數中賦值, 後續不能改 `TypeError: Immutable state variable already initialized.`
    - `string` 和 `bytes` 可以宣告為 `constant`, 但不能為 `immutable`

- 流程控制
    - `if-else`
    - `for` loop
    - `while` loop
    - `do-while` loop

- 建構函數
    - 合約布署時會執行的函數
    - 0.4.22 版本後, 以 `constructor` 關鍵字定義建構函數, 避免出現因 typo 造成漏洞
        > example: Ethernaut CTF Fal1out

- 修飾器 (Modifier)
    - 控制合約權限

### 2024.09.27

> 進度: Solidity 101 12

- 事件 `event`: EVM 上日誌的抽象概念
    - Example
        ```
        event Transfer(address indexed from, address indexed to, uint256 value);
        ```
    - 釋放事件
        ```
        // 定义_transfer函数，执行转账逻辑
        function _transfer(
            address from,
            address to,
            uint256 amount
        ) external {

            _balances[from] = 10000000; // 给转账地址一些初始代币

            _balances[from] -=  amount; // from地址减去转账数量
            _balances[to] += amount; // to地址加上转账数量

            // 释放事件
            emit Transfer(from, to, amount);
        }
        ```


- 日誌 (Log)
    - `topics`: 函數簽名 e.g. `keccak256("Transfer(address,address,uint256)")`
    - `data`: 事件中不含 `index` 的資料會儲存在 data

### 2024.09.28

> 進度: Solidity 101 13~15

- 繼承 `inheritance`
    - 合約繼承
        ```
        contract ChildContract is ParentContract {
        }
        ```
        - 父合約中希望子合約重寫的函數, 要加上 `virtual` 關鍵字
            ```
            function hip() public virtual {
                emit Log("Parent");
            }
            ```
        - 子合約內重寫合約函數, 要加上 `override` 關鍵字
            ```
            function hip() public override {
                emit Log("Child");
            }
            ```
        - 多重繼承
            ```
            contract ChildContract is GrandParentContract, ParentContract, {
            }
            ```
            - 輩分高 -> 輩分低
            - 若函數在多個繼承的合約都存在, 子合約裡必須重寫 `override(GrandParent, Parent)`
    - 修飾器繼承
        - 在繼承的合約中, 可以直接用父合約中的修飾器, 也可以重寫
            ```
            modifier exactDividedBy2And3(uint _a) override {
            }
            ```
    - 建構函數
        - 繼承時宣告父建構函數的參數
            ```
            contract DeFiHackLabsToken is ERC20("DeFiHackLabs", "HACK") {
                constructor(uint256 initialSupply) {
                    _mint(msg.sender, initialSupply * 10 ** decimals());
                }

                function decimals() public view virtual override returns (uint8) {
                    return 18;
                }
            }
            ```
        - 在子合約的建構函數中宣告建構函數的參數
            ```
            contract DeFiHackLabsToken is ERC20 {
                constructor(uint256 initialSupply) ERC20("DeFiHackLabs", "HACK") {
                    _mint(msg.sender, initialSupply * 10 ** decimals());
                }

                function decimals() public view virtual override returns (uint8) {
                    return 18;
                }
            }
            ```
    - 於子合約中呼叫父合約函數
        - 直接呼叫
            ```
            ParentContract.func();
            ```
        - 使用 `super` 關鍵字，會呼叫到最近的父合約函數
            ```
            super.func(); // ParentContract.func() 而不是 GrandParent.func()
            ```
    - 鑽石/菱形繼承: 繼承自兩個以上的合約
        - 注意使用 `super` 關鍵字的呼叫順序

- 抽象合約
    - 合約中有未實現的函數, 需標註為抽象 `abstract`, 該為實現函數需標註 `virtual`
        ```
        abstract contract InsertionSort{
            function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
        }
        ```

- 接口/介面 (Interface)
    - 性質
        - 不能包含狀態變數
        - 不能包含建構函數
        - 只能繼承接口合約
        - 所有函數必須為 `external`, 不能有功能
        - 繼承接口的非抽象合約必須實現接口內功能
    - 資訊
        - 每個函數的 `bytes4` 選擇器, 函數簽名
        - 接口 id
    - 不須知道原始碼即可與之互動, 且與 ABI 可互相轉換

- 異常種類
    - `error`: solidity 0.8.4 新增, 可以在合約外定義 `error`, 在合約內搭配 `revert` 使用, 較省 gas
    - `require`: solidity 0.8 之前, gas 隨著描述異常的字數增加而增加
        - e.g. `require(_owners[tokenId] == msg.sender, "Transfer Not Owner");`
    - `assert`: 確認某些已知條件, 常用於除錯 
        - e.g. `assert(檢查條件);`

### 2024.09.29

> 進度: 複習 Solidity 101, 完成 Bootcamp 作業

### 2024.09.30

> 進度: Solidity 102 16

- 函數重載 (overloading)
    - 相同函數名稱，不同參數類型
    - `modifier` 無法 overloading
    - 如果出現多個匹配的函數, 會報錯
        - e.g. 
            ```
            function f(uint8 _in) public pure returns (uint8 out) {
                out = _in;
            }

            function f(uint256 _in) public pure returns (uint256 out) {
                out = _in;
            }

            f(50);
            ```

### 2024.10.01

> 進度: Solidity 102 17~18

- 庫合約 (Library)
    ```
    library Strings {
    }
    ```
    - 性質
        - 不能有狀態變數
        - 不能繼承或被繼承
        - 不能接收發送 ETH
        - 不可被銷毀
    - `public` 或 `external` 的函數, 會觸發 `delegatecall`
    - 語法
        ```
        using Strings for uint256;
        function getString1(uint256 _number) public pure returns(string memory){
            return _number.toHexString();
        }

        function getString2(uint256 _number) public pure returns(string memory){
            return Strings.toHexString(_number);
        }
        ```

- 引入外部合約 (import)
    > https://docs.soliditylang.org/en/latest/path-resolution.html#imports

### 2024.10.02

> 進度: Solidity 102 19~20

- 回調函數 (Callback function) `fallback` 以及 `receive`
    - 版本沿革
        - 0.6 版本前, 只有 `fallback()` 函數
        - 0.6 版本後, 多出 `receive()` 拆分原本 `fallback()` 功能
    - 負責處理以下兩種情況 (不應也不能在合約裡被呼叫)
        - 接收 ETH 時調用
        - 被呼叫的函數簽名不存在時
    - `receive`
        - 語法
            ```
            receive() external payable { ... }
            ```
            - 不用 `function` 關鍵字
            - 必須為 `external payable`
            - 無參數、無回傳值
    - `fallback`
        - 語法
            ```
            fallback() external payable { ... }
            ```
            - 必須為 `external`, 通常也會用 `payable` 修飾
    - 接收 ETH 時觸發方式
        - 條件1: `msg.data` 是否為空, 非空執行 `fallback()`
        - 條件2: `receive()` 是否存在, 不存在執行 `fallback()`
        - `receive()`, `payable fallback()` 都不存在時, 向合約發送 ETH 將會報錯

- 發送 ETH
    - `transfer`
        ```
        _to.transfer(amount);
        ```
        - 有 `gas` 限制 (2300), 遇到目標合約回調函數過於複雜很容易超過
        - 失敗會自動 revert
    - `send`
        ```
        _to.send(amount);
        ```
        - 有 `gas` 限制 (2300)
        - 失敗不會自動 revert, 會回傳 `bool` (`true` or `false`) 代表成功或失敗
    - `call`
        ```
        (bool success,) = _to.call{value: amount}("");
        ```
        - 無 `gas` 限制
        - 失敗不會自動 revert, 會回傳 `(bool, bytes)`
    - 選擇 
        - `call` > `transfer` > `send`


### 2024.10.03

> 進度: Solidity 102 21

- 呼叫已布署的合約的做法
    - 傳入地址, 將地址強轉型為目標合約
        ```
        function callSetX(address _Address, uint256 x) external{
            OtherContract(_Address).setX(x);
        }

        function callGetX(OtherContract _Address) external view returns(uint x){
            x = _Address.getX();
        }
        ```
    - 運用合約變數
        ```
        function callGetX2(address _Address) external view returns(uint x){
            OtherContract oc = OtherContract(_Address);
            x = oc.getX();
        }
        ```
- 呼叫目標合約 `payable` 函數發送 ETH 語法
    ```
    _Name(_Address).f{value: _Value}()
    ```
    - e.g.
        ```
        function setXTransferETH(address otherContract, uint256 x) payable external{
            OtherContract(otherContract).setX{value: msg.value}(x);
        }
        ```

<!-- Content_END -->
