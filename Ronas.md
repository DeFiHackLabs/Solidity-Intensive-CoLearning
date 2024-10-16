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

### 2024.10.04

> 進度: Solidity 102 22~23

- call
    ```
    目標合約地址.call(abi.encodeWithSignature("函數簽名", 逗號分隔的具體參數));
    目標合約地址.call{value:發送數量, gas:gas數量}(abi.encodeWithSignature("函數簽名", 逗號分隔的具體參數));
    ```
    - 為 `address` 的 low-level 成員函數, 回傳值 `(bool, bytes memory)`
    - 為推薦發送 ETH 的方式
    - 在目標合約名稱未知情況下, 可使用 call 呼叫另一個合約的函數, 但應盡量避免 (安全問題)

- delegatecall
    ```
    目標合約地址.delegatecall(abi.encodeWithSignature("函數簽名", 逗號分隔的具體參數));
    目標合約地址.call{gas:gas數量}(abi.encodeWithSignature("函數簽名", 逗號分隔的具體參數));
    ```
    - 使用場景為代理合約 (Proxy Contract), 代理合約儲存狀態, 邏輯合約實作邏輯, 使用者透過代理合約呼叫邏輯合約中的功能
    - 為 `address` 的 low-level 成員函數, 回傳值 `(bool, bytes memory)`
    - 不能指定 ETH 數量
    - 狀態變數: 名稱可以不同, 類型及順序必須相同

### 2024.10.05

> 進度: Solidity 102 24~25

- 在合約中建立新合約
    - create
        ```
        Contract x = new Contract{value: _value}(params)
        ```
        - 合約地址生成演算法
            ```
            新地址 = hash(創建者地址, nonce)
            ```
        - Example
            ```
            contract PairFactory{
                mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
                address[] public allPairs; // 保存所有Pair地址

                function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
                    // 创建新合约
                    Pair pair = new Pair(); 
                    // 调用新合约的initialize方法
                    pair.initialize(tokenA, tokenB);
                    // 更新地址map
                    pairAddr = address(pair);
                    allPairs.push(pairAddr);
                    getPair[tokenA][tokenB] = pairAddr;
                    getPair[tokenB][tokenA] = pairAddr;
                }
            }
            ```
    - create2
        ```
        Contract x = new Contract{salt: _salt, value: _value}(params)
        ```
        - 合約地址生成演算法
            ```
            新地址 = hash("0xFF",創建者地址, salt, initcode)
            ```
        - Example
            ```
            contract PairFactory2{
                mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
                address[] public allPairs; // 保存所有Pair地址

                function createPair2(address tokenA, address tokenB) external returns (address pairAddr) {
                    require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //避免tokenA和tokenB相同产生的冲突
                    // 用tokenA和tokenB地址计算salt
                    (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
                    bytes32 salt = keccak256(abi.encodePacked(token0, token1));
                    // 用create2部署新合约
                    Pair pair = new Pair{salt: salt}(); 
                    // 调用新合约的initialize方法
                    pair.initialize(tokenA, tokenB);
                    // 更新地址map
                    pairAddr = address(pair);
                    allPairs.push(pairAddr);
                    getPair[tokenA][tokenB] = pairAddr;
                    getPair[tokenB][tokenA] = pairAddr;
                }
            }
            ```

### 2024.10.06

> 進度: Solidity 102 26

- selfdestruct
    - 觸發 `selfdestruct` 後, 會將合約內的 ETH 發送到指定地址
    - deprecated since 0.8.18 - [solidity-0.8.18](https://blog.soliditylang.org/2023/02/01/solidity-0.8.18-release-announcement/) [EIP-6049](https://eips.ethereum.org/EIPS/eip-6049)
    - 坎昆升級後, 加入了 [EIP-6780](https://eips.ethereum.org/EIPS/eip-6780), 更改了 `selfdestruct` 功能, 升級後的 `selfdestruct` 只會轉移 ETH, 刪除功能必須在同時發生創建-自毀才會發生
        - 已部署的合約已無法被刪除

### 2024.10.07

> 進度: Solidity 102 27~30

- ABI (Application Binary Interface)
    - 編碼
        - abi.encode
            ```
            abi.encode(x, addr, name, array);

            # 預期結果
            0x000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000
            ```
            - 與合約交互時使用
            - 每個參數都會填充 0 補滿 32 bytes
        - abi.encodePacked 
            ```
            abi.encodePacked(x, addr, name, array);
            ```
            - 會將多餘的 0 壓縮以節省空間, 在不須與合約交互時使用
        - abi.encodeWithSignature
            ```
            abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
            ```
            - 第一個參數為函數簽名 (e.g. `foo(uint256,address,string,uint256[2])`)
        - abi.encodeWithSelector
            ```
            abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
            ```
            - 第一個參數為函數選擇器 (e.g. `bytes4(keccak256("foo(uint256,address,string,uint256[2])"))`), 結果與 encodeWithSignature 相同
    - 解碼 
        - abi.decode
- Hash
    - Keccak256
        - 不等於標準 SHA3

- Calldata & Function Selector
    - 呼叫智能合約時, 本質上是向目標合約發送一段 `calldata`
    - `calldata` 前四個 byte 為 selector

- Try Cache
    - since v6.0

### 2024.10.08

> 進度: Solidity 103 31~32

- ERC20
    - `IERC20` 為對外接口 `ERC20` 為邏輯實現
    - 事件
        - `Transfer`
        - `Approval`
    - 函數
        - `totalSupply()` 代幣總供應量
        - `balanceOf()` 取得餘額
        - `transfer()` 移轉代幣
        - `allowance()` 查詢授權額度
        - `approve()` 授權
        - `transferFrom()` 授權移轉代幣

- ERC20 Token Faucet
    - 狀態變數
        - `amountAllowed`: 每次能領取數量
        - `tokenContract`: 代幣地址
        - `requestedAddress`: 領取過的地址
    - 事件 
        - `SendToken`: 於 `requestToken()` 中 emit
    - 函數
        - 建構函數設定代幣地址
            ```
            constructor(address _tokenContract) {
                tokenContract = _tokenContract; // set token contract
            }
            ```
        - `requestToken()`
            ```
            function requestTokens() external {
                require(!requestedAddress[msg.sender], "Can't Request Multiple Times!"); // 每个地址只能领一次
                IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
                require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // 水龙头空了

                token.transfer(msg.sender, amountAllowed); // 发送token
                requestedAddress[msg.sender] = true; // 记录领取地址 
                
                emit SendToken(msg.sender, amountAllowed); // 释放SendToken事件
            }
            ```

### 2024.10.09

> 進度: Solidity 103 33~35

- 空投合約 (Airdrop)
    - 分送代幣給多個合約
    - 函數
        - `getSum()`
            ```
            function getSum(uint256[] calldata _arr) public pure returns(uint sum){
                for(uint i = 0; i < _arr.length; i++)
                    sum = sum + _arr[i];
            }
            ```
        - `multiTransferToken()`
            ```
            // @notice 向多个地址转账ERC20代币，使用前需要先授权
            ///
            /// @param _token 转账的ERC20代币地址
            /// @param _addresses 空投地址数组
            /// @param _amounts 代币数量数组（每个地址的空投数量）
            function multiTransferToken(
                address _token,
                address[] calldata _addresses,
                uint256[] calldata _amounts
                ) external {
                // 检查：_addresses和_amounts数组的长度相等
                require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
                IERC20 token = IERC20(_token); // 声明IERC合约变量
                uint _amountSum = getSum(_amounts); // 计算空投代币总量
                // 检查：授权代币数量 >= 空投代币总量
                require(token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");

                // for循环，利用transferFrom函数发送空投
                for (uint8 i; i < _addresses.length; i++) {
                    token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
                }
            }
            ```

- ERC165
    ```
    interface IERC165 {
        /**
        * @dev 如果合约实现了查询的`interfaceId`，则返回true
        * 规则详见：https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
        *
        */
        function supportsInterface(bytes4 interfaceId) external view returns (bool);
    }
    ```
    - 檢查是否支援 ERC721, ERC1155

- ERC721 非同質化代幣標準
    > source (op): https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol
    - `IERC721` 為對外接口 `ERC721` 為邏輯實現
    - 事件
        - `Transfer`
        - `Approval`
        - `ApprovalForAll`
    - 函數
        - `balanceOf()` 取得餘額
        - `ownerOf()` 取得所有人
        - `transferFrom()` 授權移轉代幣
        - `safeTransferFrom(from, to, tokenId)` 安全授權移轉代幣
        - `safeTransferFrom(data)` 
        - `approve()` 授權
        - `getApproved()` 查詢 tokenId 被批准給哪個地址
        - `setApprovalForAll()` 批次授權給某個 operator
        - `isApprovedForAll()` 查詢是否批次授權

- 荷蘭拍賣 (Dutch Auction)


### 2024.10.10

> 進度: Solidity 103 36~37

- Merkle Tree
    - 基於密碼學中 Hash 演算法, 又稱 Hash Tree, 可實現大型有效性與安全性驗證 (Merkle Proof)
    - 在 N 層 Merkle Tree 中, 知道 root 後要驗證 leaf 節點, 只需要中間層的 ceil(log₂N) 個數據 (proof), leaf 透過 proof 層層運算能推導出 root 則驗證成功, 反之驗證失敗
    - 常應用於 NFT 白名單, 空投合約
        - example: https://github.com/carv-protocol/contracts/tree/staking/contracts/airdrop
    - references
        - https://github.com/merkletreejs/merkletreejs

- 用錢包執行簽章
    - 基於公鑰密碼系統數位簽章
        - 身分驗證: 只有私鑰持有人才能進行簽章
        - 不可否認: 簽章發送方無法否認簽章
        - 完整性: 不可竄改
    - 執行簽章
        ```
        function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
            return keccak256(abi.encodePacked(_account, _tokenId));
        }

        // EIP191 以太坊簽名消息
        function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
            // 哈希的长度为32
            return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        }
        ```
    - 驗證簽章
        - signature 中包含三段, 分別為 r, s, v 值, 可根據這三個值及 msgHash 求得不可否認的 signer
        - `recoverSigner`
            ```
            function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address){
                // 检查签名长度，65是标准r,s,v签名的长度
                require(_signature.length == 65, "invalid signature length");
                bytes32 r;
                bytes32 s;
                uint8 v;
                // 目前只能用assembly (内联汇编)来从签名中获得r,s,v的值
                assembly {
                    /*
                    前32 bytes存储签名的长度 (动态数组存储规则)
                    add(sig, 32) = sig的指针 + 32
                    等效为略过signature的前32 bytes
                    mload(p) 载入从内存地址p起始的接下来32 bytes数据
                    */
                    // 读取长度数据后的32 bytes
                    r := mload(add(_signature, 0x20))
                    // 读取之后的32 bytes
                    s := mload(add(_signature, 0x40))
                    // 读取最后一个byte
                    v := byte(0, mload(add(_signature, 0x60)))
                }
                // 使用ecrecover(全局函数)：利用 msgHash 和 r,s,v 恢复 signer 地址
                return ecrecover(_msgHash, v, r, s);
            }
            ```
        - `verify`
            ```
            function verify(bytes32 _msgHash, bytes memory _signature, address _signer) internal pure returns (bool) {
                return recoverSigner(_msgHash, _signature) == _signer;
            }
            ```

- 運用簽章方法分配空投
    - 簽章線下完成, 不需耗費 gas
    - 需中心化的接口驗證簽章, 較不去中心化
    
### 2024.10.11

> 進度: Solidity 103 40

- ERC1155
    > source (by OP): https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC1155
    - 背景
        - 問題: ERC20 (同質化代幣) 及 ERC721 (非同質化代幣), 每個代幣背後都需要有一個獨立的合約, 在許多場景將會造成管理上的困難與資源的消耗, 例如 GameFi, 想將裝備武器代幣化, 又不想管理大量的合約
        - 解決辦法: [EIP1155](https://eips.ethereum.org/EIPS/eip-1155) 中提出 ERC1155, 允許一個合約中包含多個及多種代幣
        - 各種功能皆會有針對單代幣及多代幣場景
    - IERC1155
        - 事件
            - `TransferSingle`
            - `TransferBatch`
            - `ApprovalForAll`
            - `URI`
        - 函數
            - `balanceOf()`
            - `balanceOfBatch()`
            - `setApprovalForAll()`
            - `isApprovedForAll()`
            - `safeTransferFrom()`
            - `safeBatchTransferFrom()`

    - IERC1155Receiver
        - 函數
            - `onERC1155Received()`
            - `onERC1155BatchReceived()`
    
    - ERC1155
        - 狀態變數
            - `name`
            - `symbol`
            - `_balances`
            - `_operatorApprovals`
        - 函數 (16 個)
            - `supportsInterface(bytes4 interfaceId)` ERC165
            - `balanceOf(address account, uint256 id)`
            - `balanceOfBatch(address[] memory accounts, uint256[] memory ids)`
            - `setApprovalForAll(address operator, bool approved)`
            - `isApprovedForAll(address account, address operator)`
            - `safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data)`
            - `safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)`
            - `_mint(address to, uint256 id, uint256 amount, bytes memory data)`
            - `_mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)`
            - `_burn(address from, uint256 id, uint256 amount)`
            - `_burnBatch(address from, uint256[] memory ids, uint256[] memory amounts)`
            - `_doSafeTransferAcceptanceCheck`
            - `_doSafeBatchTransferAcceptanceCheck`
            - `uri(uint256 id)`
            - `_baseURI()`

### 2024.10.12

> 進度: Solidity 103 38~39

- NFT 交易所
    - 角色
        - 買家
        - 賣家
        - 訂單
    - 功能
        - 創建訂單 (list)
        - 撤單 (revoke)
        - 購買 (purchase)
        - 修改價格 (update)
    - 實作 - [NFTSwap](./content/Ronas/NFTSwap.sol)
- 鏈上隨機數
    - 鏈上直接使用 hash 函數生成 (不安全, 可預測)
        ```
        bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));
        ```
    - [Chainlink VRF](https://vrf.chain.link/)

### 2024.10.13

> 進度: Solidity 103 41~44

- WETH
    - 乙太坊原生代幣 ETH 不符合 ERC20 標準, 因此創造符合 ERC20 標準的 ETH - WETH, 以便與 DApp 互動
    - 實作 - [WETH](./content/Ronas/WETH.sol)
- 分帳合約 - [PaymentSplit](./content/Ronas/PaymentSplit.sol)
- 代幣線性解鎖 - [TokenVesting](./content/Ronas/TokenVesting.sol)
- 代幣鎖倉 - [TokenLocker](./content/Ronas/TokenLocker.sol)

### 2024.10.14

> 進度: Solidity 103 45~46

- 時間鎖 - [Timelock](./content/Ronas/Timelock.sol)
- 代理合約 - [Proxy](./content/ROnas/Proxy.sol)
    - 角色
        - 代理合約  
        - 邏輯合約
        - 呼叫者

### 2024.10.15

> 進度: Solidity 103 47~50

- Upgradeable Contract
    - 運用代理合約, 抽換邏輯合約
    - Example - [SimpleUpgrade](./content/Ronas/SimpleUpgrade.sol)

- Selector Clash
    - selector algorithm `bytes4(keccak256("func(types)"))`
    - 4 bytes 容易出現碰撞, 造成安全性問題
        ```
        bytes4(keccak256("burn(uint256)")) # 0x42966c68
        bytes4(keccak256("collate_propagate_storage(bytes16)")) # 0x42966c68
        ```
- Transparent Upgradeable Proxy
    - 改變權限結構, 防止管理者受到選擇器碰撞攻擊
        - 管理者: 不可使用回調函數呼叫邏輯合約, 只能呼叫代理合約的升級函數
        - 任意使用者: 可使用回調函數呼叫邏輯合約(原本應有的功能), 不可呼叫代理合約的升級函數
    - OP Implementation - https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/transparent/TransparentUpgradeableProxy.sol

- 通用可升級代理 (UUPS)
    - 升級函數放在邏輯合約部分
    - 也能避免選擇器衝突

- 多簽錢包
    - 交易需要多個簽名簽署
    - Gnosis Safe
    - reference: https://peopledao.mirror.xyz/nFCBXda8B5ZxQVqSbbDOn2frFDpTxNVtdqVBXGIjj0s

### 2024.10.16

> 進度: Solidity 103 51

- ERC4626 (Tokenized Vault Standard)
    - Standard
        - https://eips.ethereum.org/EIPS/eip-4626
    - 功能
        - 資產數據
            - asset
        - 存提款邏輯
            - deposit
            - mint
            - withdraw
            - redeem
        - 會計邏輯
            - totalAssets
            - convertToShares
            - convertToAssets
            - previewDeposit
            - previewMint
            - previewWithdraw
            - previewRedeem
        - 存提款限額
            - maxDeposit
            - maxMint

    - OP Implemetation 
        - [IERC4626](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/IERC4626.sol)
        - [ERC4626](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC4626.sol)

<!-- Content_END -->
