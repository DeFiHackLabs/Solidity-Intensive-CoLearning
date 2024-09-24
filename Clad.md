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
學習內容  
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
  
#### 控制流
- if, else
- for
- while
- do, while
- 三元運算

#### 構造函數, 修式器
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
- 
```solidity
// 事件聲明
// indexed 關鍵字, 表示會保存在 EVM 日誌的 topics 中
event Transfer(address indexed from, address indexed to, uint256 value);

// 在函數裡釋放事件
emit Transfer(from, to, amount);
```
#### 繼承

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
contract Sun is Father{

   function hip() public virtual override{
      emit Log("Sun");
   }

   function pop() public virtual override{
      emit Log("Sun");
   }

   function sun() public virtual{
      emit Log("Sun");
   }
}

// 部屬合約後, 可以看到 Sun 合約有 4 個 function, 且 hip(), pop() 的輸出被改寫成 "Sun", 繼承來的 father() 輸出扔然保持 "Father"
```

<!-- Content_END -->
