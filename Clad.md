---
timezone: Asia/Taipei
---

---

# YourName

1. 自我介绍 Hello World

2. 你认为你会完成本次残酷学习吗？我用盡全力
   
## Notes

<!-- Content_START -->

### 2024.09.23
學習內容 Solidity 101  
筆記:  
#### Mapping
###### 使用 mapping 的時機？
- mapping 映射, 可以透過 key 查詢對應的 value, ex: 通過一個人的 id 查詢他的錢包地址
- mapping 的 _keyType 只能選擇 solidity 內建的直類型, _valueType 則可以自定義類型
  
```solidity
   mapping(uint => address) public idToAddress;
   mapping(address => address) public swapPair;

   function writeMap(uint _key, address _value) public{
      idToAddress[_key] = _value;
   }
 ```

#### 變數初始值
- boolean: false
- string: ""
- int: 0
- uint: 0
- enum: 列舉中的第一個元素
- address: 0x0000000000000000000000000000000000000000 (或 address(0))
- function fi() internal{}
- function fe() external{}
- delete 變數, 會讓變數的值變為初始值

#### 常數 constant, immutable
- 變數聲明這兩個關鍵字後, 初始化後不能再變更數值
- 數字變數可以使用 constant, immutable; string, bytes 則只能用 constant

### 2024.09.24
學習內容  
筆記:    
#### 控制流
- if, else
- for
- while
- do, while
- 三元運算

#### 構造函數, 修飾器
- constructor, 每個合約可以定義一個, 部屬合約時會自動執行一次, 通常用於初始化合約的參數  
- modifier, 聲明函數擁有的特性, 通常用於函數前的檢查 ex:地址, 變數, 餘額

```solidity
modifier onlyOwner{
   require(msg.sender == owner);
   _;
}

function changeOwner(address _newOwner) external onlyOwner{
   owner = _newOwner;
}
```

#### 事件
- 響應: 應用程式 ethers.js 可以通過 RPC 接口訂閱和監聽這些事件, 並在前端做響應
- 經濟: event 是 EVM 上比較有經濟效益的儲存數據方式, 每個大概消耗 2,000 gas; 鏈上儲存一個新變數需要 20,000 gas

```solidity
// 事件聲明
// indexed 關鍵字, 表示會保存在 EVM 日誌的 topics 中
event Transfer(address indexed from, address indexed to, uint256 value);

// 在函數裡釋放事件
emit Transfer(from, to, amount);
```

#### 繼承
規則
- virtual 父合約中的函數, 如果希望子合約重寫, 加上 virtual 
- override 子合約重寫父合約的函數, 加上 override
```solidity
contract Father{
   event Log(string msg);

   function hip() public virtual{
      emit Log("Father");
   }

   function pop() public virtual{
      emit Log("Father");
   }

   function father() public virtual{
      emit Log("Father");
   }
}
```

```solidity
// 簡單繼承
contract Son is Father{

   function hip() public virtual override{
      emit Log("Son");
   }

   function pop() public virtual override{
      emit Log("Son");
   }

   function sun() public virtual{
      emit Log("Son");
   }
}

// 部屬合約後, 可以看到 Son 合約有 4 個 function, 且 hip(), pop() 的輸出被改寫成 "Son", 繼承來的 father() 輸出扔然保持 "Father"
```
### 2024.09.25
學習內容  
筆記:  

多重繼承
- 繼承時要按照輩分高低排序
- 如果某一個函數在多個繼承合約裡都存在, 在子合約裡必須重寫
- 重寫在多個父合約中都重名的函數時, override 後面要加上父合約的名字

```solidity
// 多重繼承
contract Erzi is Father, Son{

   function hip() public virtual override(Father, Son){
      emit Log("Erzi");
   }

   function pop() public virtual override(Father, Son){
      emit Log("Erzi");
   }

}

// Eriz 合約重寫 hip(),pop() 並將輸出改為 Erzi, 並且從 Father, Son 合約繼承 father(), son()
```

修飾器的繼承
- modifier 同樣可以繼承, 用法與函數繼承類似, 在對應的地方加上 virtual, override 
```solidity
contract Base1{
   modifier modifier1(uint _a) virtual{
      require(_a % 2 ==0 && _a % 3 == 0);
      _;
   }
}

contract Base2 is Base1{
   function fun1(uint _b) public modifier1(_b) pure returns(uint, uint){
      return fun2(_b);
   }

   function fun2(uint _c) public pure returns(uint, uint){
      uint div2 = _c / 2;
      uint div3 = _c / 3;
      return (div2, div3);
   }
}
```
構造函數的繼承
1. 繼承時聲明父構造函數的參數, ex: contract B is A(1)
2. 在子合約的構造函數中聲明構造函數的參數
```solidity
abstract contract A{
   uint public a;
   constructor(uint _a){
      a = _a;
   }
}
```
```solidity
contract B is A{
   constructor(uint _b) A(_b * _b){}
}
```

調用父合約的函數
1. 直接調用
2. 利用 super 關鍵字
```solidity
function callParent() public{
   Father.pop();
}

function callParent() public{
   // 假設子合約是 contract Eriz is Father, Son, 那麼 super 將調用最近的複合約函數, Son.pop()
   super.pop()
}
```

### 2024.09.26
學習內容  
筆記:  

#### 抽象合約(abstract)
- 如果合約裡有一個未實現的函數, 則必須將該合約標示為 abstract, 且未實現的函數需要加上 virtual, 以便子合約重寫
```solidity
abstract contract InsertionSort{
   function fun1(uint[] memory a) public pure virtual returns(uint[] memory);
}
```
#### 接口(interface)
- 接口類似抽象合約, 但不實現任何功能
- 定義了合約的功能及如何觸發接口
- 接口提供 1.合約裡每個函數的 bytes4 選擇器及函數簽名 2.接口 id

規則
1. 不能包含狀態變數
2. 不能包含構造函數
3. 不能繼承除了接口外的其他合約
4. 所有的函數必須是 external 且不能有函數體
5. 繼承接口的抽象合約必須實現接口定義的所有功能

- 如果知道合約實現了 ex: IERC721 接口, 不用知道它具體程式碼實現, 就可以與它互動
```solidity
contract interactBAYC {

    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);


    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }


    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
        BAYC.safeTransferFrom(from, to, tokenId);
    }
}
```
#### 異常
- 三種方法 error, require, assert
- gas 消耗程度 require > error > assert

error
- error 必須搭配 revert(退回) 命令使用
```solidity
error TransferNotOwner(); // 自訂義 error
error TransferNotOwner(address sender); // 自訂義帶參數的 error

function transferOwner1(uint256 tokedId, address newOwner) public{
   if(_owners[tokenId] != msg.sender){
      revert TransferNotOwner();
   }
   _owners = newOwner;
}
```

require
- 使用方法 require(檢查條件, "異常的描述")
- 如果檢查條件不成立, 就會拋出錯誤
```solidity
function transferOwner2(uint256 tokedId, address newOwner) public{
   require(_owner[tokenId] == msg.sender, "Transfer Not Owner");
   _owners = newOwner;
}
```
assert
- 不會解釋拋出異常的原因
- 如果檢查條件不成立, 就會拋出錯誤
```solidity
function transferOwner3(uint256 tokedId, address newOwner) public{
   assert(_owner[tokenId] == msg.sender);
   _owners = newOwner;
}
```
<hr>

### 2024.09.27
學習內容 Solidity 102    
筆記:  

#### 函數重載
重載(overloading), 名字相同但輸入參數類型不同的函數可以同時存在, 被視為不同函數; 注意, 不允許 modifier 重載
疑問: 什時間點會使用到重載函數, 基本上我用函數的習慣不會重複命名

實參匹配
調用重載函數時, 會把輸入的實際參數和函數參數的變數類型做匹配, 如果出現多個匹配的重載函數, 會報錯
ex: 調用f(50), 50 可以被轉換成 uint8, 也可以轉換成 uint256
```Solidity
function f(uint8 _in) public pure returns(uint8 out){
   out = _in;
}

function f(uint256 _in) public pure returns(uint256 out){
   out = _in;
}
```
#### 庫合約
- 目的, 減少程式碼的重複性和減少 gas
- 常用的庫合約有, Strings, Address, Create2, Arrays
兩種方式  
1. 利用 using for 指令
```Solidity
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
   return _number.toHexString();
}
```
2. 通過庫合約名稱調用函數
```Solidity
function getString2(uint256 _number) public pure returns(string memory){
   returns Strings.toHexString(_number);
}
```
#### Import
- 目的, 利用 import 引入外部程式碼, ex: 引用我們或別人寫好的合約, 函數, 程式碼

用法
1. 通過文件相對位置引用
2. 通過全局符號, 引用指定的合約
3. 通過網址引用
4. 引用 OpenZeppelin 合約
   
<!-- Content_END -->