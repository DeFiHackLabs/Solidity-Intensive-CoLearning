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

**1.Hello Web3**

小看第一篇了，自以爲最簡單的地方，結果在答題時還是錯了兩題：

```solidity
pragma solidity ^0.8.21
```

這行所聲明的 solidity 版本並不能被小於該版本號或下一個大版本的所編譯，例如：`0.8.21`,就不能被 `> 0.8.21` 或 `>= 0.9.0` 的版本所編譯。

Remix 也沒有版本的面板，版本是由程式碼所選擇的。

**2. Value Type**

```solidity
address payable addr;
addr.transfer(1);
```
要注意區塊鏈中沒有浮點數，因此最小的單位肯定不是該鏈的原生代幣，如上述最小的單位為 `wei`。

在 Solidity 中，bytes1 類型代表 1 個字節（8 位元），每個字節包含 2 個十六進位數字，如同電腦科學的底層原理 `1 byte = 8 bits`。

因此，bytes1 類型的數值總共會有 2 個十六進位數字，如:`0xAB`，等等以此類推。

`函數類型(Function Type)`，也是 `solidity` 中的一種變量類型。

### 

<!-- Content_END -->
