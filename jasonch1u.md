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

狀態變數：預設可見性是 internal。函數：預設可見性是 internal。
值的寫法：
```solidity
<value types> {internal|public|private|不寫?|還不知道為什麼不能寫external?} <_value name> = 數值、字串或判斷式
```
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

命名式返回也可以在returns先聲明變數類型及變數名稱，並在下方用return返回值

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

這邊要再確認一下calldata的作用，不知道為什麼calldata重新賦值後，點aa就變成新數據了，不過做myMemoery確實沒改變[0]，做myStorage有改變[0]，不能理解為什麼做calldata後會改變aa？ aa不是鍊上數據嗎?
```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract DataStorage {

uint[] public aa = [1,2,3]; 

function myCallData(uint[] calldata _x) external {
aa = _x;
}

function myMemory() external view {
uint[] memory xMemory = aa;
xMemory[0] = 100;
}

function myStorage() external {
uint[] storage xMemory = aa;
xMemory[0] = 100;    
}

}
```

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
```solidity
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体，後面小寫的student可以看做是命名Student這個結構體
```
有四種賦值方法
方法1:在函数中创建一个storage的struct引用
```solidity
//  给结构体赋值
function initStudent1() external{
    Student storage _student = student; // assign a copy of student
    _student.id = 11;
    _student.score = 100;
}
```
方法2:直接引用状态变量的struct
```solidity
function initStudent2() external{
    student.id = 1;
    student.score = 80;
}
```

方法3:构造函数式
```solidity
function initStudent3() external {
    student = Student(3, 90);
}
```

方法4:key value
```solidity
function initStudent4() external {
    student = Student({id: 4, score: 60});
}
```
getter函數寫法
* 數組：數組在返回時，Solidity 編譯器會自動處理存儲位置，允許你直接返回 storage 中的數組，並自動將其轉換為 memory。
* 結構體：當返回結構體時，你需要創建一個 memory 的副本，因為編譯器要求這樣來確保數據的安全性和完整性。
```solidity

//array：gettter函數 可以不用寫出memory副本，由系統自動編譯
function getmyArray3() external view returns(uint[] memory){
    return myArray3;
}

//array：getter函數 也可以這樣寫，手動寫出memory副本
function getmyArray3() external view returns(uint[] memory){
    uint[] memory xmyArray3 = myArray3;
    return xmyArray3;
}

//struct，生成一個People getter函數，一定要手動寫出memory副本
function getPeople() external view returns(People memory){ 
    People memory xPeople = people;
    return xPeople;
}
```

### 2024.09.25

#### 07_Mapping
* 规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型。
* 规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数（见例子）。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。
* 规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。
* 规则4：给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对。
  
```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract _7mapping{

    mapping (address => int) public balanceOF;

    function mint() external {
        balanceOF[msg.sender]=100 ether;
    }

    function burn() external {
        balanceOF[msg.sender]=50 ether;

    }
}
```
* 原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。
* 原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。
* 原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

#### 08_InitialValue

值类型初始值

delete操作符
delete a会让变量a的值变为初始值。不是刪除該數值！

#### 09_Constant
只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。
constant, immutable 变量声明后再也不能改变。尝试改变的话，编译不通过。
constant：初始化即聲明
immutable：初始化即聲明 或 在建構子裡面聲明

```solidity
uint public constant money = 1; //初始化即聲明數值
uint public immutable point = 2; //初始化即聲明數值
uint public immutable point2; //先不聲明數值，在建構子裡面聲明

constructor(){
    point2 = 3;
}
```

#### 10_InsertionSort
* if else：條件如果符合，就這樣，不然就那樣
```solidity
function a(uint256 _number) public pure returns(bool){
   if(_number == 0){
      return(true);
   }else{
      return(false);
   }
}
```
* for
* 另外还有continue（立即进入下一个循环）和break（跳出当前循环）关键字可以使用。
```solidity
function forLoopTest() public pure returns(uint256){
   uint sum = 0; /// 一開始 sum = 0
      for(uint i = 0; i < 10; i++){ // 一開始 i = 0，如果 i < 10 的話，i = i + 1
         sum += i; //sum = sum + i
      }
   return(sum);
}

//拆解步驟：i = 0 時，sum =  0 + 0 得到  0，i = 0 + 1 得到 1
//         i = 1 時，sum =  0 + 1 得到  1，i = 1 + 1 得到 2
//         i = 2 時，sum =  1 + 2 得到  3，i = 2 + 1 得到 3
//         i = 3 時，sum =  3 + 3 得到  6，i = 0 + 1 得到 4
//         i = 4 時，sum =  6 + 4 得到 10，i = 1 + 1 得到 5
//         i = 5 時，sum = 10 + 5 得到 15，i = 2 + 1 得到 6
//         i = 6 時，sum = 15 + 6 得到 21，i = 2 + 1 得到 7
//         i = 7 時，sum = 21 + 7 得到 28，i = 0 + 1 得到 8
//         i = 8 時，sum = 28 + 8 得到 36，i = 1 + 1 得到 9
//         i = 9 時，sum = 36 + 9 得到 45，i = 2 + 1 得到 10
//         i = 10 時，跳出 for 迴圈
//
//簡單來說就是，0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45
```
* while
```solidity
    function whileTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        while(i < 10){
            sum += i;
            i++;
        }
        return(sum);
    }
```
* do while
```solidity
// do-while
function doWhileTest() public pure returns(uint256){
   uint sum = 0;
   uint i = 0;
   do{
      sum += i;
      i++;
   }while(i < 10);
   return(sum);
}
```
* 三元運算符
```solidity
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
   // return the max of x and y
   return x >= y ? x: y; 
}
```

* 插入排序：前後兩位比大小，後面小於前面就對調位置
```solidity
// 插入排序 正确版
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    // note that uint can not take negative value
    for (uint i = 1;i < a.length;i++){ 
        uint temp = a[i];
        uint j=i;
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}

//拆解步驟：舉例 [5,4,1,3,2]，a.length = 5
//            第 0 1 2 3 4 位
//         i = 1 < a.length = 5，做第1次for迴圈
//         i = 1，a[1] 即第1位是 4，所以 temp = a[1] = 4，temp表達做該次for迴圈時的對應數值
//         j = i = 1，接著進入while迴圈條件判斷，j = 1 >= 1 而且 temp = 4 < a[j-1] = 第0位的 5，while迴圈條件判斷通過
//         所以 a[j] = a[j-1]，即 a[1] = a[0]，所以第1位數變成 5，數組變成 [5,5,1,3,2]
//         j = j - 1 = 0，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 0 不是>= 1，不符合while迴圈條件，退出while迴圈
//         回到第1次for迴圈的剩餘步驟，a[j] = temp，即 a[0] = temp = 4，數組變成 [4,5,1,3,2]
//         i = i + 1 = 2，結束第1次for迴圈
//
//         可以看出while這段是確定第一位可以跟第0位比較，而且第0位小於第1位的情況下，用很難直接看懂的方式做前後數值對調
//
//         現在數組是 [4,5,1,3,2]
//                 第 0 1 2 3 4 位
//         i = 2 < a.length = 5，做第2次for迴圈
//         i = 2，a[2] 即第2位是 1，所以 temp = a[2] = 1
//         j = i = 2，接著進入while迴圈條件判斷，j = 2 >= 1 而且 temp = 1 < a[j-1] = 第1位的 5，while迴圈條件判斷通過
//         所以 a[j] = a[j-1]，即 a[2] = a[1]，所以第2位數變成 5，數組變成 [4,5,5,3,2]
//         j = j - 1 = 1，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 1 >= 1, temp = 1 < a[0] = 4，符合while迴圈條件，繼續while迴圈 
//         a[1] = a[0] = 4，數組變成 [4,4,5,3,2]
//         j = j - 1 = 0，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 0 不是>= 1，不符合while迴圈條件，退出while迴圈
//         a[0] = temp = 1，數組變成 [1,4,5,3,2]
//         i = i + 1 = 3，結束第2次for迴圈
//
//         可以看出第2次for迴圈，while做2次，用一個很麻煩的方式，讓數組變成 [1,4,5,3,2]，不過目前順序還是對的
//
//         現在數組是 [1,4,5,3,2]
//                 第 0 1 2 3 4 位
//         i = 3 < a.length = 5，做第3次for迴圈
//         i = 3，a[3] 即第3位是 3，所以 temp = a[3] = 3
//         j = i = 3，接著進入while迴圈條件判斷，j = 3 >= 1 而且 temp = 3 < a[j-1] = 第2位的 5，while迴圈條件判斷通過
//         所以 a[j] = a[j-1]，即 a[3] = a[2]，所以第3位數變成 5，數組變成 [1,4,5,5,2]
//         j = j - 1 = 2，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 2 >= 1, temp = 3 < a[1] = 4，符合while迴圈條件，繼續while迴圈 
//         a[2] = a[1] = 4，數組變成 [1,4,4,5,2]
//         j = j - 1 = 1，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 1 >= 1, temp = 3 不是< a[0] = 1，不符合while迴圈條件，退出while迴圈
//         a[1] = temp = 3，數組變成 [1,3,4,5,2]         
//         i = i + 1 = 4，結束第3次for迴圈
//
//         第3次for迴圈，while做2次，讓數組變成 [1,3,4,5,2]
//
//         現在數組是 [1,3,4,5,2]
//                 第 0 1 2 3 4 位
//         i = 4 < a.length = 5，做第4次for迴圈
//         i = 4，a[4] 即第4位是 2，所以 temp = a[4] = 2
//         j = i = 4，接著進入while迴圈條件判斷，j = 4 >= 1 而且 temp = 2 < a[j-1] = 第3位的 5，while迴圈條件判斷通過
//         所以 a[j] = a[j-1]，即 a[4] = a[3]，所以第3位數變成 5，數組變成 [1,3,4,5,5]
//         j = j - 1 = 3，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 3 >= 1, temp = 2 < a[2] = 4，符合while迴圈條件，繼續while迴圈 
//         a[3] = a[2] = 4，數組變成 [1,3,4,4,5]
//         j = j - 1 = 2，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 2 >= 1, temp = 2 < a[1] = 3，符合while迴圈條件，繼續while迴圈 
//         a[2] = a[1] = 3，數組變成 [1,3,3,4,5]       
//         j = j - 1 = 1，再次進入while迴圈條件判斷 (j >= 1 && (temp < a[j-1])，j = 1 >= 1, temp = 2 不是< a[0] = 1，不符合while迴圈條件，退出while迴圈
//         a[1] = temp = 2，數組變成 [1,2,3,4,5]         
//         i = i + 1 = 5，結束第4次for迴圈
//
//         第4次for迴圈，while做3次，讓數組變成 [1,2,3,4,5] 
//
//         1 = 5 < a.lenght = 5，不符合for迴圈條件，結束for迴圈
//
//         return(a);
```

### 2024.09.26

#### 11_Modifier

* Constructor：每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，例如初始化合约的owner地址，部屬時會要求出入initialOwner

```solidity
address owner; // 定义owner变量

// 构造函数
constructor(address initialOwner) { //()聲明輸入值
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}

// getter
function getOwner() external view returns(address _address){
    _address = owner;
}
```

* modifier

```solidity
// 定义modifier
modifier onlyOwner {
require(msg.sender == owner); // 检查调用者是否为owner地址
_; // 如果是的话，继续运行函数主体；否则报错并revert交易
}
```
上面是一個modifier，下面是一個叫onlyOwner modifier修飾的function，當這個function看到modifier之後，才會跑去執行modifier的內容，去判斷检查调用者是否为owner地址，如果是的话，继续运行changeOwner這個function
```solidity
function changeOwner(address _newOwner) external onlyOwner{
owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
}
```
#### 12_Event
* 監聽事件
* 省gas fee

聲明事件
```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

釋放事件
```solidity
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
EVM日志 Log (etherscan)

topic
```solidity
keccak256("Transfer(address,address,uint256)") //事件簽名要這樣寫
//0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef

keccak256("Transfer(address,address,uint)") //uint不寫256，事件簽名hashed會跟上面不一樣
```
除了事件哈希，主题还可以包含至多3个indexed参数，也就是Transfer事件中的from和to。總共四個東西

data
* 事件中不带 indexed的参数会被存储在 data 部分中。
* data 部分的变量在存储上消耗的gas相比于 topics 更少。

#### 13_Inheritance

#### 14_Interface

#### 15_Errors


<!-- Content_END -->
