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
功用
- 可以透過 key 查詢對應的 value, ex: 通過一個人的 id 查詢他的錢包地址
- mapping 的 _keyType 只能選擇 solidity 內建的直類型, _valueType 則可以自定義類型

寫法
給映射新增鍵值
```solidity
   // 此範例有兩組 mapping, 透過 writeMap() 對 idToAddress 新增鍵值 
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
### 2024.10.4    
學習內容  
筆記:  

#### 刪除合約
- 目前 selfdestruct 僅會被用來將合約中的 eth 轉移到指定地址 
- 原先刪除的功能只有在合約 創建, 自毀 這兩個操作處在同一筆交易時才會生效

寫法
- selfdestruct(_addr);
- _addr 是接收合約剩餘 eth 的地址

```Solidity
function deleteContract() external{
   selfdestruct(payable(msg.sender));
}
```

安全注意
- 對外提供合約銷毀時, 最好設置為只有合約所有者可以調用, 使用函數修飾符 onlyOwner 進行函數聲明
- selfdestruct 常會帶來安全問題和信任問題, 建議避免使用
- selfdestruct 是智能合約的緊急按鈕, 銷毀合約並將剩餘 eth 轉移到指定帳戶, 在最壞的情況下停止黑客攻擊

### 2024.10.5      
學習內容  
筆記:  

#### ABI 編碼解碼
- 數據必須編寫成字節碼才能和智能合約互動
- 
編碼
1. abi.encode
- 將每個參數填充為 32 字節的數據, 並拼接在一起, 如果要和合約互動, 可以用 abi.encode
```Solidity
function encode() public view returns(bytes memory result){
   result = abi.encode(x, addr, name, array);
}
```
2. abi.encodePacked
- 類似 abi.encode, 但是會把其中填充很多的 0 省略
- 當想省空間, 並且不與合約互動時, 可以使用 abi.encodePacked, ex: 算一些數據的 hash
```Solidity
function encodePacked() public view returns(bytes memory result){
   result = abi.encodePacked(x, addr, name, array);
}
```
3. abi.encodeSignature
- 調用其他合約時可以使用
```Solidity
function encodeWithSignature() public view returns(bytes memory result){
   result = abi.encodeWithSignature("foo(uint256, address, string, uint256[2])", x, addr, name, array);
}
```
4. abi.encodeWithSelector
- 與 abi.encodeWithSignature 類似, 不過第一個參數為函數選擇器, 為函數簽名 Keccak 哈希的前 4 個字節
- 編碼後的結果與 abi.encodeSignature 一樣
```Solidity
function encodeWithSelector() public view returns(bytes memory result){
   result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256, address, string, uint256[2])", x, addr, name, array)));
}
```

解碼
1. abi.decode
```Solidity
function decode() public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray){
   (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
}
```
#### Hash
- 將任意長度的消息轉換為一個固定長度的值

Keccak256
- Solidity 中最常用的哈希函數
```Solidity
哈希 = keccak256(數據);
```
生成數據唯一標示
```Solidity
function hash(uint _num, string memory _string, address _addr) public pure returns{
   return keccak256(abi.encodePacked(_num, _string, _addr));
}
```

弱抗碰撞性
- 給定一個特定的輸入, 難以找到另一個具有相同散列值的輸入
  
強抗碰撞性
- 難以找到任何兩個不同的輸入, 它們散列值相同

### 2024.10.6      
學習內容  
筆記:  

#### 函數選擇器
- 當調用智能合約時, 本質上是向目標合約發送一段 calldata, 可以在 remix 的詳細信息中看見 input 就是該次交易的 calldata
- calldata 的錢 4 個字節是 selector 函數選擇器

msg.data

method id, selector, 函數簽名

計算 method id
- 要計算 method id 時, 需要通過函數名和函數的參數類型來計算
- 函數的參數類型分以下 4 種
1. 基礎類型參數 (uint8,...,uint256, bool, address 等)
   寫法, bytes4(keccak256("函數名(參數類型)"))
   ```Solidity
   function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4 selectorWithElementaryParam){
      // emit 這段的用意是甚麼, 待釐清
      emit SelectorEvent(this.elementaryParamSelector.selector);
      return bytes4(keccak256("elementaryParamSelector(uint256, bool)"));
   ]
   ```
   
2. 固定長度類型參數
   - ex: uint256[5]
   寫法, bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
   ```Solidity
   function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
      emit SelectorEvent(this.fixedSizeParamSelector.selector);
      return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
   }
   ```
   
3. 可變長度類型參數
   - ex: address[], uint8[], string
   寫法, bytes4(keccak256("nonFixedSizeParamSelector(uint256[], string)"))
   ```Solidity
   function nonFixedSizeParamSelector(uint256[] memory param1, string memory param2) external returns(bytes4 selectorWithFixedSizeParam){
      emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
      return bytes4(keccak256("fixedSizeParamSelector(uint256[], string)"));
   }
   ``` 
5. 映射類型參數
   - ex: contract, eunm, struct, 在計算 method.id 時, 要將該類型轉成 ABI 類型
   寫法, bytes4(keccak256("mappingParamSelector(address, (uint256, bytes), uint256[], uint8)"))  


使用 selector
- 可以利用 selector 調用目標函數
  ex:利用 abi.encodeWithSelector 將 elementaryParamSelector 函數的 method id 作為 selector 和參數打包編碼, 傳給 call 函數
```Solidity
function callWithSignature() external{
   (bool success, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
}
```
### 2024.10.7      
學習內容  
筆記:  

#### try catch
- 利用 try-catch 處理智能合約的異常
- 只能被用於 external 函數或創建合約時 constructor 的調用

寫法
- externalContract.f() 是某個外部合約的函數調用
```Solidity
try externalContract.f(){
   // 成功的情況下, 運行代碼
}catch{
   // 失敗的情況下, 運行代碼
}
```

- 如果調用的函數有返回值, 必須在 try 之後聲明 returns(returnType val), 並且在 try 的地方可以使用返回的變數
```Solidity
try externalContract.f() returns(returnType val){
   // 成功的情況下, 運行代碼
}catch{
   // 失敗的情況下, 運行代碼
}
```

catch 也支援特殊異常
```Solidity
try externalContract.f() returns(returnType){
}catch Error(){
}catch Panic(){
}catch (bytes memory){
}

```

<hr>  

### 2024.10.8        
學習內容  
筆記:  

#### ERC20
- 以太坊上的代幣標準, 用來實現代幣轉帳的基本邏輯
- 帳戶餘額, balanceOf()
- 轉帳, transfer()
- 授權轉帳, transferFrom()
- 授權, approve()
- 代幣總供給量, totalSupply()
- 授權轉帳額度, allowance()
- 代幣信息, 可選, name(), symbol(), 小數位數 decimals()

IERC20  
- IERC20 是 ERC20 代幣標準的合約接口, 用來規定 ERC20 代幣需要實現的函數和事件, 內含 ERC20 要使用的函數名稱, 輸入輸出參數
- IERC20 定義 2 個事件, 6 個函數

### 2024.10.9        
學習內容  
筆記:  

#### 代幣水龍頭
實做一個簡易版的 ERC20 水龍頭合約
結構
- 狀態變數*3, 紀錄每次能提領的數量, token 合約地址, 紀錄領取過代幣的地址 
- 事件*1, 紀錄每次提取代幣的地址和數量
- 函數*2, 構造函數(初始化 tokenContract 狀態變數, 確定發放的 ERC20 代幣地址), requestTokens() (用戶調用, 可以領取代幣)
  
### 2024.10.10        
學習內容  
筆記:  

#### 空投代幣合約
- 邏輯: 利用循環, 讓一筆交易將 ERC20 代幣發送給多個地址

結構
- 由兩個函數組成
- getSim() 返回 uint 數組的和
- multiTransferToken() 發送 ERC20 代幣空
  需要做
  1. require 空投地址的數量組和每個地址的空投數量組長度相等
  2. require 授權代幣數量 >= 空投代幣總量
  3. for 循環, 利用 transferFrom() 發送空投

### 2024.10.11        
學習內容  
筆記:  

#### ERC721
- 用於非同質化物品, ex: NFT
- ERC165, 檢查一個智能合約是否支援 ERC721, ERC1155 的接口
- IERC721, 規定 ERC721 要實現的基本函數, 利用 tokenId 來表示特定的非同質化代幣, 授權和轉帳都要明確 tokenId, 包含 3 個事件, 9 個函數
- IERC721Metadata, 實現 3 個查詢 metadata 元數據的常用函數
- IERC721Receiver, 目標合約必須實現 IERC721Receiver 接口才能接收 ERC721 代幣, 不然會 revert
- ERC721 主合約實現 IERC165, IERC721, IERC721Metadata 定義的所有功能, 包含 17 個函數

實作一個免費鑄造的 APE  
結構  
- 需要設定總供給量
- 構造函數, 調用父合約 ERC721 的構造函數, 需要傳入 NFT 的名稱 _Nname 和符號 _symbol
- function _baseURI, 讓每個 NFT 的 tokenURI 基於 IPFS 上的資源進行生成
- functnio mint(), 要檢查 tokenId 的範圍沒有超過總供給量, 並 mint

### 2024.10.12        
學習內容  
筆記:  

#### 荷蘭拍賣 DutchAuction
- 也稱減價拍賣, 拍賣是由高到低依次遞減直到第一個人應價或是超過底價
- 優點: 1.拍賣價格由最高慢慢下降, 項目方能獲得最大收入 2.拍賣時間通常 6h 以上, 可避免 gas war

DutchAuction 合約
- DutchAuction 合約繼承 ERC721, Ownable 合約
- 有 9 個狀態變數, 其中 6 個和拍賣有關, 有 9 個函數

結構
1. setAuctionStartTime(), 設定拍賣起始時間
2. getAuctionPrice(), 設定拍賣時的價格
   要處理  
   - block.timestamp 小於起始時間, 價格設定為最高價 action_start_price
   - block.timestamp 大於結束時間, 價格設定為最低價 action_end_price
   - block.timestamp 在兩著之間, 計算當前衰減價格
4. auctionMint(), 用戶參與拍賣並鑄造 NFT
   要處理
   require 檢查是否設置起始時間, 拍賣是否開始
   require 檢查是否超過 NFT 上限
   mint 成本計算
   require 用戶是否支付足夠 ETH
   mint NFT
   多餘 ETH 退款
6. withdrawMoney(),項目方提取拍賣籌集的 ETH

### 2024.10.13        
學習內容  
筆記:  

#### 默克爾樹 Merkle Tree
生成 Merkle Tree
- 利用 https://lab.miguelmota.com/merkletreejs/example/ 來生成 Merkle Tree
  步驟
  1. 輸入地址作為葉子節點
  2. 選擇 Keccak-256, hashLeaves, sortPairs 選項, 點擊 compute 生成 Merkle Tree
     
驗證 Merkle Tree
結構
- 4 個函數
- verify(), 利用 proof 來驗證 leaf 是否屬於根 root, 調用 processProod()
- processProof(), 用 proof, leaf 依序計算出 root, 調用了 _hashPair()
- _hashPair(), 用 keccak256() 計算非根結點對應的兩個子節點的哈希

利用 Merkle Tree 發放 NFT 白名單
結構
- MerkleTree 合約繼承 ERC721, 利用 MerkleProof 庫
- 構造函數 + 3 個函數
- mint(), 利用 Merkle 樹驗證地址並 mint
- _leaf(), 計算 Merkle 樹葉的哈希值
- _verify(), Merkle 驗證, 調用 MerkleProof 庫的 verify()

### 2024.10.14        
學習內容  
筆記:  

#### 數字簽名 
- 雙橢圓曲線數字簽名演算法(ECDSA), 主要作用
1. 身分認證
2. 不可否認性
3. 完整性

ECDSA 中包含兩個部分  
1. 簽名者利用 私鑰(隱私) 對 消息(公開) 創建 簽名(公開)
2. 其他人使用 消息(公開) 對 簽名(公開) 恢復簽名者的 公鑰(公開) 並驗證簽名

創建簽名  
1. 打包消息
2. 計算以太坊簽名消息
3-1. 利用錢包簽名
3-2. 利用 web3.py 簽名

驗證簽名  
1. 通過簽名和消息恢復公鑰
2. 比對公鑰並驗證簽名

利用簽名發放白名單  
- 項目方利用項目方帳戶把白名單發放地址簽名, 然後 mint 的時候利用 ECDSA 檢驗簽名是否有效, 如果有效則給 mint

### 2024.10.15        
學習內容  
筆記:  

#### NFT 交易所
設計邏輯
- 賣家, 功能:掛單 list, 徹單 revoke, 修改價格 update
- 買家, 功能:購買 purchase
- 訂單, 賣家發布 NFT 訂單, 一個系列的同一 tokenId 最多存在一個訂單, 其中包含掛單價格 price 和持有人 owner
- 訊息, 當訂單交易完成或徹單, 清除訊息

合約結構
- 4 個 event, List, Revoke,Update, Purchase

訂單
- 把 NFT 訂單抽象為 Order 結構體, 包含 掛單價格 price, 持有人 owner 資訊
- nftList 映射記錄了訂單是對應的 NFT(合約地址) 和 tokenId 資訊
```Solidity
struct Order{
   address owner;
   uint256 price;
}

mapping(address => mapping(uint256 => Order)) public nftList;
```

退回函數
- 用戶使用 ETH 購買 NFT, 因此合約需要實現 fallback() 接收 ETH
```Solidity
fallback() external payable{}
```

onERC721Received

交易
- 實現 4 個交易相關的函數
- 掛單 list(), 賣家創建訂單, 並釋放 List 事件; 成功後, NFT 會從賣家轉到 NFTSWap 合約中
- 撤單 revoke(), 賣家撤回掛單, 並釋放 Revoke 事件; 成功後, NFT 會從 NFTSWap 合約轉回賣家
- 修改價格 update(), 賣家修改 NFT 訂單價格, 並釋放 Update 事件
- 購買 purchase(), 買家支付 ETH 購買掛單的 NFT, 並釋放 Purchase 事件; 成功後, ETH 轉給賣家, NFT 從 NFTSwap 合約轉給買家

### 2024.10.16        
學習內容  
筆記:  

#### 鏈上隨機數
- 鏈上, 透過 哈希函數隨機生成, 不過因鏈上資訊公開透明, 容易有風險(攻擊者可以鑄造任何他們想要的稀有 NFT, 而非隨機抽取)
```Solidity
function getRandomOnchain() public view returns(uint256){
   bytes randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockchain(block.number-1)));
   return ruint256(randomBytes);
}
```

- 鏈下, 再鏈下生成隨機樹, 然後透過預言機(ex: Chainlink VRF)把隨機數傳到鏈上
- 範例, 用一個簡單的合約向 VRF 請求隨機數, 摒除存在狀態變數中







<!-- Content_END -->
