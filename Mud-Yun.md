---
timezone: Asia/Taipei
---

# Mud-Yun

1. 我是Mud-Yun，對程式設計有興趣，尤其是在區塊鏈技術領域。基於這份熱忱，我決定將Solidity作為我將要精通的首選程式語言。Solidity不僅是智能合約開發的核心語言，也是進入以太坊等區塊鏈平台不可或缺的技能。我期待通過深入學習Solidity，能夠在這個快速發展的領域中，創造出具有影響力的應用。

2. 參與殘酷共學是一個挑戰，但也是一次成長和學習的機會。這個過程可能會很艱難，但只要堅持下去，就能從中獲得寶貴的經驗。在這個過程中，不僅能學到新知識，還能提升解決問題的能力。所以，即使是第一次參與，我也保持積極的態度，相信自己能夠完成這個挑戰。
   
## Notes

<!-- Content_START -->
### 2024.09.23
![1](https://github.com/user-attachments/assets/1019707a-2710-4d1d-a1e2-0b07c68db484)

要註解版權聲明，不然會有警告。

"pragma solidity ^0.8.21;"代表只可以使用0.8.21以上，0.9.0之下的編譯器做編譯。

我在HelloWeb3合約中定義了一個字串變量"_String"，data為"Hello Web3"，並將其定義為public。

由於將其定義為public，在編譯該合約後會自動生成一個與該變量同名的getter()，可以看到我在部屬合約後，左下角有一個藍色框框(唯讀)，點下去就可以看見該變量中的data：Hello Web3。


### 2024.09.24

在 Solidity 裡，變數有三大類型：值類型、引用類型、和映射類型。這裡我們先來聊聊最常見的值類型。


1. 布林值（Boolean）
布林值就是那種只有兩個狀態的變數，像是「對」或「錯」，也就是 true 和 false。


範例：

bool public isTrue = true;

常見的運算符號：


! (邏輯非，反轉值)

&& (邏輯與，雙方都要為真)

|| (邏輯或，一方為真即可)

== (等於)

!= (不等於)


例子：

bool public notTrue = !isTrue;  // 反轉值

bool public andCondition = isTrue && notTrue;  // 與

bool public orCondition = isTrue || notTrue;  // 或

重點：當執行 && 或 || 的時候，只要前面條件能決定結果，後面的條件就不會執行，這叫做短路運算。


2. 整數（Integer）
   
Solidity 中有分有號整數和無號整數：

有號整數 (int) 可以是正數或負數。

無號整數 (uint) 只能是正數。


範例：

int public num = -5;

uint public positiveNum = 10;

uint256 public largeNum = 123456789;


常見運算：

算術運算：+, -, *, /, %（取餘數）, **（指數）

比較運算：<, <=, ==, !=, >=, >


例子：

uint256 public result = largeNum + 1;

uint256 public exp = 2 ** 3;  // 2 的三次方

uint256 public remainder = 7 % 2;  // 餘數


3. 地址類型（Address）
   
地址是一種存儲以太坊錢包地址的變數，有兩種主要類型：

普通地址 (address)：只用來存地址。

可支付地址 (address payable)：不只存地址，還可以用來處理轉帳。


範例：
address public wallet = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;

address payable public payableWallet = payable(wallet);


你可以查詢某個地址的餘額：

uint256 public balance = payableWallet.balance;


4. 定長字節數組（Fixed-size Byte Array）

這是一種儲存固定長度的字節數組，長度無法更改，例如 bytes32。最多可以存 32 個字節的數據。

範例：

bytes32 public data = "Solidity";

bytes1 public firstByte = data[0];  // 取出第一個字節


5. 枚舉（Enum）

枚舉類型用來定義一組固定的狀態，像是下單操作裡的「買入」、「持有」和「賣出」。每個狀態對應一個整數，從 0 開始。


範例：

enum Order { Buy, Hold, Sell }

Order public currentOrder = Order.Buy;


枚舉也可以轉換成整數：

function getOrderValue() public view returns(uint) {
    return uint(currentOrder);
}


### 2024.09.25

Solidity的函數相當靈活，可以進行許多複雜操作。

1. 基本結構

function <function name>(<參數類型>) {internal|external|public|private} [pure|view|payable] [returns (<回傳類型>)]


function：宣告函數的關鍵字。


<function name>：函數名稱。


(<參數類型>)：函數參數，包括其類型和名稱。


{internal|external|public|private}：函數的可見性：


public：內部外部都可見。


private：僅限合約內部使用，繼承的合約也不能訪問。


external：只能從外部訪問，但可以使用 this.f() 在內部呼叫。


internal：只能在合約內部使用，繼承合約可以訪問。


[pure|view|payable]：函數行為的修飾符：


pure：不能讀取或修改合約狀態。


view：僅能讀取狀態，不可修改。


payable：允許函數接收 ETH。



2. Pure 和 View 的區別
   
這兩個關鍵字的引入是為了節省 Gas 費用，因為如果函數不改變鏈上狀態，就不需要支付 Gas 費。


pure：既不能讀取也不能修改鏈上的狀態變數。


view：可以讀取但不能修改狀態變數。


示例：


uint256 public number = 5;


// pure 函數，不讀取或修改鏈上狀態


function addPure(uint256 _number) external pure returns (uint256 new_number) {
    new_number = _number + 1;
}


// view 函數，讀取但不修改鏈上狀態


function addView() external view returns (uint256 new_number) {
    new_number = number + 1;
}



3. 函數可見性：Internal 和 External

   
internal 函數只能由合約內部呼叫，繼承的合約也可以呼叫。


external 函數可以從外部調用，內部需要用 this.functionName() 來調用。


示例：


// internal 函數


function minus() internal {
    number = number - 1;
}


// external 函數，間接呼叫 internal 函數
function minusCall() external {
    minus();
}



4. Payable 函數

   
payable 函數允許接收 ETH，通常用於涉及支付的情境。


示例：


// payable 函數，允許接收 ETH 並返回合約餘額


function minusPayable() external payable returns (uint256 balance) {
    minus();    
    balance = address(this).balance;
}



5. 函數的回傳值

   
函數可以使用 returns() 指定回傳的變數類型和名稱。


示例：


function add(uint256 _number) external pure returns (uint256 result) {
    result = _number + 1;
}



Solidity 中函數的靈活度很高，尤其是 pure 和 view 關鍵字在 Gas 優化方面有特殊應用。

payable 則是用於處理 ETH 交易的重要工具。
<!-- Content_END -->
