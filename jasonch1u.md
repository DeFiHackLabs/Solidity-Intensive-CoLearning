---
timezone: Asia/Shanghai
---

# jasonch1u

1. 自我介绍：無開發經驗，參加XREX區塊鍊課程後，不想再當web2的佃農。最近很幸運的錄取了資安BOOTCAMP，希望這段時間學習後，有機會投身web3的行列。
2. 你认为你会完成本次残酷学习吗？ 一開始覺得不好說，不過這段時間提前自學，期許自己還是可以完成。

## Notes

<!-- Content_START -->
### 2024.09.19
因為從未接觸過Solidity，這週提前開始課程，大概了解自學難度、個人目標、及殘酷共學的願景。

### 2024.09.23

#### 01_HelloWeb3

* Solidity 是智能合約語言，主要用於以太坊，能幫助讀懂區塊鏈項目代碼。
* Remix 是官方推薦的開發工具(https://remix.ethereum.org)，可在瀏覽器中開發和部署 Solidity 合約。建議可以開啟自動編譯，省步驟。
* Solidity 程序結構包含：

License 註釋
```solidity
// SPDX-License-Identifier: MIT
```
版本聲明：跟編譯器要一致，在remix輸入"pragma..." 會跳出"License註識"一起寫完，最後記得填入version
```solidity
pragma solidity 0.8.26;
```
合約內容
```solidity
contract HelloWorld { }
```
* 第一個合約示例：HelloWeb3 合約，定義一個字符串變量，值為 "Hello Web3!"。每行代碼用分號 ；結尾

#### 02_ValueTypes

值的寫法：value類型 (不寫? | internal | public | private，還不知道為什麼不能寫external?) <_value name> = 數值、字串或判斷式

如果寫public，會自動產生getter函數(這邊應該可以理解成直接產生一個查找對應數值的函數功能)，寫其他或不寫，就不會有字自動生成getter函數，就沒辦法直接看對應數值。

ex.
```solidity
uint8 public _apple = 255; //會自動產getter函數，部屬後直接點_apple會知道uint8: 255
uint256 _banana = 20; //不會自動產getter函數，部屬後沒有_banana可以點，要另外自己寫function找_banana
```

數值類型概述
* 布爾型 (bool)：只有兩個值，true 和 false。
* 整數型 (uint)：
    * uint（無符號整數）常用於區塊鏈，因為不需要負數，默認為 uint256。也沒有小數點。位數表達是二進制的位數，即256bits。
    * 支援基本數學運算（加、減、乘、除、平方、取商、取餘數），以及比較運算（如>, >=, <, <= 等...）。
    * 操作符：==、!=、&&、|| 用於邏輯比較。
    * 短路規則（Short-circuiting）：
        * &&：如果前者為 false，後者不再執行。
        * ||：如果前者為 true，後者不再執行。
* 地址型 (address)：
    * 特殊的 20 byte 類型，用於儲存 Ethereum 地址。
    * address：佔用 20 bytes，即 40 個 16 進位字符。
    * payable address 可用於接收轉帳。
    * 支援轉帳操作方法：transfer、send 和 call。以後會學
* 字節型 (bytes)：
    * 分為定長（如 bytes32）和不定長版本。
    * 定長字節型聲明長度後不可變；不定長字節數組有機會儲存更多數據。
    * 1 byte = 8 bits，可以由 2 個 16 進位字符表示。
        * 每個 16 進位字符代表 4 bits。例如：1111 1111（二進位） = FF（16 進位）。
        * bytes32：能存 32 bytes，即 64 個 16 進位字符。
        * 0x只是用來表示16進制，不佔字符數。
* 枚举 enum：冷門，方便辨識程式碼的寫法。類似自定義X, Y, X = 0, 1, 2的概念

#### 03_Function

函數的基本結構
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
* 可見性：函數的可見性決定誰可以調用該函數：
   * public：內外部都可訪問，會自動生成 getter 函數。
   * private：僅限合約內部調用。
   * internal：內部和子合約可調用。
   * external：僅外部調用，內部需透過 this.f() 調用。
* 修飾詞
   * pure：不讀取或修改狀態，完全依賴傳入的參數。
   * view：僅讀取狀態，不修改。
   * payable：允許函數接收以太幣，常用於資金接收。
   * 不寫：可以讀取和修改狀態，改變鍊上數據會消耗 Gas。

### 2024.09.24

#### 04_Return

returns：跟在函数名后面，用于声明返回的变量类型及变量名。

```solidity
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
```

return：用于函数主体中，返回指定的变量

```solidity
return(1, true, [uint256(1),2,5]);
}
```

命名式返回：returns裡面聲明變數類型及變數名稱，並在函數內部為各個變數賦值

```solidity
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
_number = 2;
_bool = false;
_array = [uint256(3),2,1];
}
```

命令式返回也可以在returns先聲明變數類型及變數名稱，並在下方用return返回值

```solidity
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

解構式賦值：Solidity 中的解構式賦值(Destructuring Assignment)是一種允許你從數組或結構體中提取多個值並同時賦給多個變數的語法特性。這個概念源自於其他現代編程語言，如 JavaScript。 

原講義看不懂，參考小礦工Wade介紹才理解一點，大概是：要先取得變數A跟對應值，然後設定新變數，可以透過解構式賦值的寫法，決定要不要把所有變數A賦值給新變數

```solidity
// 读取返回值，解构式赋值
function readReturn() public pure{

// 读取全部返回值
uint256 _number;
bool _bool;
bool _bool2;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```

如果不想要全部變數都賦值，可以直接把那個變數幹掉；不過被幹掉的新變數，原本聲明的地方應該也要幹掉?

```solidity
// 读取部分返回值，解构式赋值
(, _bool2, ) = returnNamed();
}
```

#### 05_DataStorage

storage: 存在鍊上數據，gas貴
memory: 存在内存，不上鍊。string, bytes, array和自定义结构需加memory。
calldata: 存在内存，不上鍊。但是calldata初始化賦值後不得改變變量。

狀態變量
局部變量
全局變量
全局變量: 乙太單位、時間單位

#### 06_ArrayAndStruct

array
固定长度数组

```solidity
// 固定长度 Array
uint[8] array1;
bytes1[5] array2;
address[100] array3;
````

可变长度数组

```solidity
// 可变长度 Array
uint[] array4;
bytes1[] array5;
address[] array6;
bytes array7;
````

在Solidity中，如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是uint8

对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。

主要是讓memory的變量，聲明一個新變量名稱，讓系統知道這個memory對應的不是鍊上數據，而是另外一個暫存的新值?

這邊提到memory修飾動態數組，可用new創建，這件事應該不只侷限於動態數組，而是有用memory修飾的變量，都有一樣可以用new的概念對吧? 
new 操作符的使用： 您是對的，new 操作符的使用不僅限於動態數組。在 Solidity 中，new 可以用於創建多種類型的 memory 變量，包括： 

* 動態數組
* 靜態數組
* 結構體
* 合約
* uint, string這些如果用到memory修飾，直接定義新變量即可，不需要用到new

如果创建的是动态数组，需要一个一个元素的赋值。

```solidity
function getArray() public pure returns (uint[] memory) {
uint[] memory result = new uint[](3);
result[0] = 1;
result[1] = 2;
result[2] = 3;
return result;
}
```

数组成员

* length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
* push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
* push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
* pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。

struct


<!-- Content_END -->
