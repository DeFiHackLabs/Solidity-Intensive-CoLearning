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

### 2024.09.28
學習內容  
筆記:  

#### 接收 ETH, receive, fallback
- 目的, 1.接收 ETH 2.處理合約中不存在的函數調用
- 觸發規則   
![image](https://github.com/user-attachments/assets/3dbf8f0a-2f3b-413f-b5e2-b9d0c437964d)


receive
- 當合約收到 ETH 轉帳時, receive() 會被觸發
- 一個合約最多只有一個 receive()
- receive() external payable{}, receive() 不能有參數, 不能返回值, 要包含 external 和 payable

```Solidity
// 定義事件
event Received(address sender, uint Value);
// 接收 ETH 時釋放 Received 事件
receive() external payable{
   emit Received(msg.semder, msg.value);
}
```
fallback
- 調用不存在的函數時會被觸發, 可用於接收 ETH, 也可用於代理合約 proxy contract
- fallback() external payable{}

### 2024.09.29
學習內容  
筆記:  

#### 發送 ETH, transfer(), send(), call()
- call 推薦, 沒有 gas 限制
- transfer, 有 2300 gas 限制, 發送失敗會自動 revert 交易
- send 最不推薦, 有 2300 gas 限制, 發送失敗時不會自動 revert 交易

假設一個接收 ETH 合約
```Solidity
contract ReceiveETH{
   // 收到 eth 事件, 紀錄 amount, gas
   event Log(uint amount, uint gas);

   // 接收到 eth 時觸發
   receive() external payable{
      emit Log(msg.value, gasleft());
   }

   // return 合約的 eth 餘額
   function getBalance() view public returns(uint){
      return address(this).balance;
   }
}
```

發送 eth 合約
```Solidity
contract snedETH{
   // 構造函數, 部屬時候可以轉 eth 進去
   construct() payable{}
   // receice, 接收 eth 時被觸發
   receive() external payable{}
}
```

transfer  
- 接收方的地址.transfer(發送數量)
```Solidity
// 用 transfer 發送 eth
function transferETH(address payable _to, uint256 amount) external payable{
   _to.transfer(amount);
}
```

call  
- 接收方地址.call{value: 發送數量}("")
- call() 會返回 (bool, bytes), 其中 bool 代表轉帳成功或失敗, 需要額外程式碼處理
```Solidity
// 用 call 發送 eth 失敗 error
error CallFailed();

function callETH(address payable _to, uint256 amount) external payable{
   (bool success, ) = _to.call{value: amount}("");
   if(!success){
      revert CallFailed();
   }
}
```
### 2024.09.30
學習內容  
筆記:  

#### 調用其他合約
- 目標, 如何在已知合約代碼和地址的情況下, 調用已部屬的合約
  
ex: 目標合約
```Solidity
contract OtherContract{
   uint256 private _x = 0;

   event Log(uint amount, uint gas);

   // return 合約 eth 餘額
   function getBalance() view public returns(uint){
      return address(this).balance;
   }

   function setX(uint256 x) external payable{
      _x = x;
      if(msg.value > 0){
         emit Log(msg.value, gasleft());
      }
   }

   function getX() external view returns(uint x){
      x = _x;
   }
}
```

1. 傳入合約的地址
- 在函數裡傳入要調用的合約地址, 來生成目標合約的引用, 然後調用目標函數
```Solidity
function callSetX(address _Address, uint256 x) external{
   otherContract(_Address).setX(x);
}
```
2. 傳入合約的變數
- 可以直接在函數裡傳入合約的引用, ex: 把參數類型 address 改為要調用的合約 OtherContract
```Solidity
function callGetX(OtherContract _Address) external view returns(uint x){
   x = Address.getX(); 
}
```
3. 創建合約的變數
- 創建合約變數, 通過這個變數來調用目標合約
```Solidity
function callGetX2(address _Address) external view returns(uint x){
   OtherContract oc = OtherContract(_Address);
   x = oc.getX();
}
```
4. 調用合約並發送 eth
- 如果要調用的合約函數是 payable, 那麼可以通過調用它來給合約轉帳
- 規則, contractName(_Address).f{value: _Value}()
```Solidity
function setXTransferETH(address otherContract, uint256 x) payable external{
   OtherContract(otherContract).setX{value: msg.value}(x);
}
```
### 2024.10.1
學習內容  
筆記:  

#### Call
功用
- call 是 address 類型的低級成員函數, 用來與其它合約交互, return (bool bytes memory), 對應 call 是否成功和目標函數的返回值
- call 通過觸發 fallback 或 receive 函數發送 eth

寫法
- 目標合約地址.call(字節碼)
- 自節碼 利用結構化編碼函數取得, abi.encodeWithSignature("函數名(參數類型)", 參數)  
  ex: abi.encodeWithSignature("f(uint256, address)", _x, _addr)
- call 在調用合約時可以指定交易發送的 eth 數量和 gas 數量
  目標合約地址.call{value: 發送數量, gas: gas 數量}(字節碼)

安全注意
- 不要用 call 調用另一個合約, 當調用不安全的合約函數時, 就會把主動權給對方, 建議方法是聲明合約變數後調用函數

### 2024.10.2
學習內容  
筆記:  

#### Delegatecall
功用
- 與 call 類似, 地址類型的低級成員函數
- delegatecall 在調用合約時可以指定交易發送的 gas, 但不能指定發送的 eth
- 智能合約將儲存合約和邏輯合約分開
  代理合約儲存所有相關變數, 並且保存邏輯合約的地址; 邏輯合約儲存所有函數, 通過 delegate 執行
- EIP-2535 Diamonds 鑽石, 鑽石是具有多個實施合約的代理合約
  
寫法
- 目標合約地址.delegatecall(二進制編碼)
- 二進制編碼 利用結構化編碼函數獲得, abi.encodeWithSignature("簽名函數", 具體參數)

安全注意
- 使用時要確保當前合約和目標合約的狀態變數儲存結構相同, 並且目標合約安全, 不然會造成資產損失

#### 在合約中創建新合約
寫法
Contract 要創建的合約名, x 合約對象(地址), 如果構造函數是 payable 可以創建時轉入 _value 數量的 eth, params 新合約構造函數的參數 
```Solidity
Contract x = new Contract{value: _value}(params)
```
### 2024.10.3  
學習內容  
筆記:  

#### Creat2
功用
- 不管未來區塊鏈上發生甚麼, 你都可以把合約部屬在事先計算好的地址上
- 交易所為新用戶預留創建錢包合約的地址
- 

計算 Creat2 地址
- 新地址 = hash("0xFF", 創建者地址, salt, initcode)
- OxFF, 常數  
  創建者地址, 調用 creat2 的當前合約地址
  salt, 創建者指定的 bytes32 類型的值, 主要是用來影響新創見合約的地址
  initcode, 新合約的初始字節碼

寫法
```Solidity
Contract x = new Contract{salt: _salt, value: _value}(parms)
```

```Solidity
// salt 為 token1 和 token2 的 hash
bytes32 salt = keccak256(abi.endcodePacked(token1, token2));
```

  
  





<!-- Content_END -->
