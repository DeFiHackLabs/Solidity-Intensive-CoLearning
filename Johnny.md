---
timezone: Asia/Shanghai
---

# Johnny

1. 自我介绍
   
   我是一位後端及區塊鏈工程師，曾參加過幾次關於鏈圈的黑客松比賽，這次參加殘酷共學希望能更增進自己撰寫 
solidity 的功力

2. 你认为你会完成本次残酷学习吗？
   
   會的，全力以赴！
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### 1.Hello Web3

小看第一篇了，自以爲最簡單的地方，結果在答題時還是錯了兩題：

```solidity
pragma solidity ^0.8.21
```

這行所聲明的 solidity 版本並不能被小於該版本號或下一個大版本的所編譯，例如：`0.8.21`,就不能被 `> 0.8.21` 或 `>= 0.9.0` 的版本所編譯。

Remix 也沒有版本的面板，版本是由程式碼所選擇的。

#### 2. Value Type

```solidity
address payable addr;
addr.transfer(1);
```
要注意區塊鏈中沒有浮點數，因此最小的單位肯定不是該鏈的原生代幣，如上述最小的單位為 `wei`。

在 Solidity 中，`bytes1` 類型代表 1 個字節（8 位元），每個字節包含 2 個十六進位數字，如同電腦科學的底層原理 `1 byte = 8 bits`。

因此，`bytes1` 類型的數值總共會有 2 個十六進位數字，如:`0xAB`，等等以此類推。

`函數類型(Function Type)`，也是 solidity 中的一種變量類型。

### 2024.09.24

#### 3. Function

`pure` 簡單來說就是不能讀取也不能修改存在鏈上的資料，只能讀取傳入的參數。

例如：

```solidity
function getResult(uint a, uint b) public pure returns (uint) {
    return a + b;
}
```

`view` 簡單來說就是不能修改存在鏈上的資料，只能讀取存在鏈上的資料。

例如：

```solidity
function getResult() public view returns (uint newResult) {
    newResult = a + 1;
}
```

#### 4. Return

何謂命名式返回？

例如：

```solidity
function getResult() public view returns (uint newResult) {
    newResult = a + 1;
}
```

其中 `newResult` 就是命名式返回，用來表示返回的變量名稱，這樣的好處是可以在函數中直接使用 `return newResult` 來返回結果，而不需要再寫一次 `return`，當然也還是可以使用 `return` 來返回結果。


#### 5. DataStorage

`memory`: 儲存在記憶體中，不會被儲存在鏈上，只會在函數執行期間存在，可以被修改。

`calldata`: 儲存在記憶體中，不會被儲存在鏈上，只會在函數執行期間存在，和 `memory` 不同的是，它不可以被修改。

例如：
```solidity
function fCallData(uint[] calldata data) public pure returns (uint[] calldata) {
   // data[0] = 1; // 這樣會報錯，因為 calldata 不能被修改
   return (data);
}
```

賦值規則:

不同類型的變量賦值給不同類型的變量時，有時會產生獨立的副本，例如：

```solidity
uint[] a = [1, 2, 3];

function f() public{
   uint[] storage b = a;
   b[0] = 2;
   // a[0] 也會變成 2
}
```

`memory` 賦值給 `memory` 跟 `storage` 賦值給 `storage` 一樣，會創建引用，改變新變量會原變量會跟著一起改變。

其他情況下，賦值創建的是本體的副本，改變新變量不會影響原變量。

變量的作用域：

`solidity` 中，變量按照作用域可以分為，狀態變量(State Variable)、局部變量(Local Variable)、全局變量(Global Variable)。

其中，狀態變量(State Variable)的 `gas` 消耗是最高的

### 2024.09.25

#### 6.ArrayAndStruct

固定長度數組，表示有聲明數組的長度，例如：

```solidity
uint[3] a = [1, 2, 3];
```

可變長度數組，表示沒有聲明數組的長度，例如：

```solidity
uint[] a = [1, 2, 3];
```
在 Solidity 中，創建數組有一些規則：

對於 `memory` 修飾的動態數組，可以使用 `new` 關鍵字來創建，但是必須指定數組的長度，並且聲明後長度不能改變。例如：

```solidity
uint[] memory a = new uint[](3);
```

Array 和 Struct 都是引用類型，因此賦值給新的變量時，會創建引用，改變新變量會原變量會跟著一起改變(第五章的概念)。

結構體內不能包含其本身，但是可以包含數組和映射等複雜類型及原始類型。

### 2024.09.26

#### 7.Mapping

Mapping 的規則：

聲明 `Mapping` 的格式為 `mapping(_KeyType => _ValueType)`，其中的 `_KeyType` 僅能使用 `solidity` 內建的值類型，不能用自定義的結構體。

而 `_ValueType` 可以使用自己定義的類型，例如下面的例子就會報錯

```solidity
struct car {
   string color
   string brand
}
mapping ( car => address ) testCarOwner;
```

因為 Ethereum 會定義所有未使用的空間為 0 ，所以未賦值(value)的鍵(key)的初始值都是各個 `type` 的默認值，如 `uint` 的為 0

#### 8. InitialValue

`delete`會將變數設為預設值

例如：

```solidity
uint public a = 2;

function reset() external {
   delete a;
}
```

#### 9. Constant

只有數值變量可以聲明 `constant` 及 `immutable` ; `string`、`bytes` 可以聲明為 `constant`, 但不能為 `immutable`

`constant` 變量必須在聲明的時候就初始化，之後就不能再變動，再變動的話會編譯錯誤。

`immutable` 可以在聲明時，或是 `constructor` 中初始化，若 `immutable` 已在聲明中初始化，又再 `constructor` 中初始化，則會使用 `constructor` 初始化的值

### 2024.09.27

#### 13. Inheritance

多重繼承：

`solidity` 的合約可以繼承多個合約，規則如下：

1. 繼承要按照輩分，從最高的到最低的照順序排。比如我寫一個 `A` 合約，它繼承 `B` 和 `C` 合約，那麼就要寫成

```solidity
contract A is B, C
```

### 2024.09.28

#### 14. Interface

`interface` 的規則如下：
1. 不能包含狀態變量
2. 不能包含構造函數
3. 不能繼承除了接口之外的其他合約
4. 所有函數必須是 `external` 且不能有函數體
5. 繼承 `interface` 的非抽象（`abstract`）合約必須實現 `interface` 定義的所有功能

`interface` 提供了兩個重要的訊息：

合約中每個函數的 `bytes4` 選擇器，以及函數簽名 `函數名稱（參數類型）`

例如：`function transfer(address recipient, uint256 amount) external returns (bool);`
   
其 `bytes4` 選擇器為 `bytes4 selector = bytes4(keccak256("transfer(address,uint256)"));`

其函數簽名為 `transfer(address,uint256)`

標記為 abstract 的合約可以被編譯，但是不能被部署，這是因為在部署時，必須實踐所有函數。

<!-- Content_END -->
