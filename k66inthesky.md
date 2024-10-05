---
timezone: Asia/Shanghai (UTC+8)
---

# k66inthesky

1. Hi我是k66，這是我第一次參加殘酷共學，一起衝鴨🦆

2. 你认为你会完成本次残酷学习吗？我會努力完成！
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: `Hello Web3`: 本堂課第一支程式
> + `Solidity`: 用於EVM的程式語言
> + `Remix`: Solidity的IDE
> + Solidity程式架構: `1.註解Licence`、`2.Solidity版本號`、`3.contract相當於main`

以下是實際寫碼+編譯過程:

1.遇到錯誤->請AI提示->原本要照AI(左下角有RemixAI)提供的程式碼做(螢光綠處)->但發現錯誤其實來自少一字母r於是選擇不照AI的建議而是修正typo
<img src="https://github.com/user-attachments/assets/7df89f23-f290-4827-b716-ac45c8605c1e" >
2.編譯成功後，出現這些檔案(紅括號處)
<img src="https://github.com/user-attachments/assets/1d8a949f-f49e-456a-9d9b-18f9da1ac6c1" >
3.部屬合約前發現設定檔預設和教程有些不同(比如教程VM分支是merge但目前預設是坎昆)
<img src="https://github.com/user-attachments/assets/62670336-ef07-4c87-b933-aa8916ff9ef4" >
4.順便查了除了坎昆，也支援L2的Optimism和Arbitrum
<img src="https://github.com/user-attachments/assets/c505fef6-2316-41ee-848c-44a24531b38c" >


### 2024.09.24

學習內容: `2.ValueTypes`
> + 三種類型:Value Type, Reference Type, Mapping Type
> + 與C語言寫法不同的是int寫在public前，如`int public _int = -1;`
> + 常見Value type: bool, int, uint, uint256, address, address payable, bytes(可變), bytes1, bytes8, bytes32, enum


### 2024.09.25
學習內容: `3.function`
> 這集對我來說單看有點難理解(碧琪公主那我看不懂)，
> 看[這篇](https://medium.com/taipei-ethereum-meetup/solidity-weekly-11-70c5208a3bf1)才懂`pure`、`view`是為取代`constant`(到v0.4.17才取代)。
> 此外`internal`、`external`蠻好懂。

### 2024.09.26
學習內容: `4.Return`
> 分`returns`和`returns`，後者和其他程式語言類似，前者跟在函數名後面。
> 特別的寫法，解構式賦值: `(, _bool2, ) = returnNamed();`


### 2024.09.27
學習內容: `5.Data Storage`
> 引用類型: `array`, `struct`
> 數據位置(與一般程式不同): `storage`, `memory`, `calldata`，`storage`消耗gas較多，且合約裡默認是`storage`，`memory`和`calldata`只存內存但不上鏈，
`calldate`較`memory`不同的是其`immutable`特性。
> 作用域: `state variable`, `local variable`, `global variable`。
> 乙太單位: `wei(1)`, `gwei(1e9)`, `ether(1e18)`
> 時間: 可以規定一個操作須在指定時間內完成。

+ 心得: 這章和gas和省空間(是否上鏈)息息相關，若未來寫合約時產生不必要的gas浪費，可回頭看這章找靈感。

### 2024.09.28
學習內容: `6.Array and Struct`
> `array`: `T[k]`, `T[]`, `bytes`, `bytes1`, `bytes`比`bytes1`省gas。
> `push()`, ,`push(x)`, `pop()`

```
struct先創建後賦值: 
struct Student{
   uint256 id;
   uint256 score;
}
function initStu() external {
   _stu = Student(3,90);
}
```

### 2024.09.29
學習內容: `7.Mapping`
+ key-value寫法
```
mapping(uint => address) public i2addr;
```
+ 心得: 這章有講到mapping規則和原理但我對其沒感覺，之後再回頭看。

### 2024.09.30
學習內容: `8.Initial Value`
+ 宣告過但還沒被賦值的變數都有預設值。可用`getter()`驗證初始值。
+ 怎麼變回初始值? `delete a`會讓a的值變回初始值。

### 2024.10.01
學習內容: `9.Constant和immutable`
+ 和其他程式語言相同，constant不可變，immutable可變。
+ constant宣告時須先初始化(賦值)，immutable則不用。

### 2024.10.02
學習內容: `10.Insertion Sort`
+ 作者特別強調90%的人在Solidity寫插入算法都會出錯。
+ A: 情境: 若宣告`uinit j=i-1`，則當`j=0`時會出錯`underflow`，原因是`uinit是正整數不得為0`
+ 介紹`if-else`,`for`,`while`,`do-while`
+ 介紹三元運算符:`條件?真表達式:假表達式`

+ 心得: 不一定要是插入排序，只要是uint的值切記不得為0。

### 2024.10.03
學習內容: `11.constructor和modifier`
+ 每個合約可以有一個constructor，和其他程式語言類似。
+ modifier是Solidity獨有，類似decorator，modifier用做函數運行前的檢查(地址、變數、餘額等)
+ 另外多學到revert: _和ownable

### 2024.10.04
學習內容: `12.Event`
+ event用作`響應`、`經濟`
+ 事件的宣告用event開頭
+ emit 釋放事件
+ EVM Log(每條Log都包含`topics`和`data`)
   - topics
      * 包含至多3个indexed参数，Transfer事件中的hash、from和to。
   - data
      * 事件中不带 indexed的參數會被存在data。
      * data不能被直接檢索，但可以存任意大小的數據，一般用來存複雜的數據結構，例如array和string。
   - data消耗的gas比topics少。

### 2024.10.05
學習內容: `13.Inheritance`
+ 繼承有幾種: `簡單`、`多重`、`Modifier`、`Constructor`、`鑽石(菱形)`
+ 繼承的好處: 減少重複的代碼
+ 規則: `virtual`、`override`
+ 簡單繼承用法: `contract Baba is Yeye`
+ 多重繼承用法: `contract Erziis Yeye, Baba`
+ Modifier繼承用法:
  ```
  modifier exactDividedBy2And3(uint _a) virtual {...}
  contract Identifier is Base1 {...}
  也可以:
  modifier exactDividedBy2And3(uint _a) override {...}
  ```
+ Constructor繼承用法: 
  ```
  contract B is A(1)
  contract C is A {...}
  function callParent() public{ Yeye.pop(); }
  function callParentSuper() public{ super.pop(); }
  ```
+ 鑽石(菱形)繼承用法:
  ```
     God
    /  \
   Adam Eve
    \  /
   people
   ```

<!-- Content_END -->
