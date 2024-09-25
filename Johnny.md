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

<!-- Content_END -->