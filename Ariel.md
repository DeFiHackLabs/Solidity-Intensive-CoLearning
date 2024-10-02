---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍
我是Ariel,在參與本次共學前從未接觸過Solidity 與智能合約相關知識，發現自己太多不了解的知識，想要扎實從頭學起～

2. 你认为你会完成本次残酷学习吗？
我覺得我可以完成本次殘酷共學。為了完成此次學習，我有空出每天一段時間，希望可以幫助我成功完成學習。
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
WTF Academy #1-5
![1000005316](https://github.com/user-attachments/assets/8a67b9f8-ff71-43a5-bf23-3eefc2545d19)

# 2: enum枚举:uint 分配名稱與維護

# 3: 函數類型：prue/view

# 4: 函數輸出：命名式返回/結構式賦值（读取函数的全部或部分返回值）

# 5: 儲存位置
1.
store:狀態變量、上鏈
memory：參數與臨時變量，內存中不上鏈
calldata：類memory,不可修改

2. 會影響變量：
storage->storage
memory ->memory

3. 作用域：

狀態：鏈上，gas消耗高
局部：函數執行過程中，內存，完成消失，函數內聲明
全局：可不聲明，為預留關鍵字

3个常用的全局变量：msg.sender，block.number和msg.data，他们分别代表请求发起地址，当前区块高度，和请求数据。下面是一些常用的全局变量，更完整的列表请看这个链接：
blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
block.coinbase: (address payable) 当前区块矿工的地址
block.gaslimit: (uint) 当前区块的gaslimit
block.number: (uint) 当前区块的number
block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
gasleft(): (uint256) 剩余 gas
msg.data: (bytes calldata) 完整call data
msg.sender: (address payable) 消息发送者 (当前 caller)
msg.sig: (bytes4) calldata的前四个字节 (function identifier)
msg.value: (uint) 当前交易发送的 wei 值
block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。


4. 乙太單位
精度表示，以0代替小數點
wei: 1
gwei: 1e9 = 1000000000
ether: 1e18 = 1000000000000000000

5. 時間單位

### 2024.09.24
學習內容：WTF #6~8
![image](https://github.com/user-attachments/assets/00a41a16-a6e3-4284-a1e8-7a2c5d1aed52)

# 6:引用類型
   1. array:
      1. 固定(內存）：uint[8] array1;
      3. 可變(動態) ：uint[] array1;
      4. 例外：
         1. bytes array7; 不用加［］，叫省gas
         2. bytes1[] array5; 要加
      5. 數組創建：
         1. memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变
            uint[] memory array8 = new uint[](5);
         2. 一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type
             g([uint(1), 2, 3]); -->都是uint
         3. 數組成員
               1. memory內存數組:length
               3. 動態數組:push()最後添加0/push(x)最後添加x/pop()移除最後元素
   2. struct:定義新類型,可為原始/引用；本身可作為數組or mapping元素 ，struct中不可包含其本身。可含數組/mapping/struct類型
      1. 四種賦予值方法
         1.Student storage _student = student; // assign a copy of student
            _student.id=1;
         2. 直接引用状态变量的struct
           student.id=1;
         3. 構造函數式：student = Student(3, 90);
         4. key value:student = Student({id: 4, score: 60});

# 7: 映射類型：存key value pair table, hash table
   1. 格式：mapping(_KeyType => _ValueType)
         例：mapping(uint => address) public idToAddress; // id映射到地址
            mapping(address => uint) public balance0f; //记录不同地址的持仓数量
   3. 注意：
      1. _KeyType只能選預設類型，無法用自定義結構體，_ValueType則可
      2. 存储位置必须是storage，可用於合約狀態變量
      3. 如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value
      4. 新增鍵值對：
         function writeMap (uint _Key, address _Value) public
         {
             idToAddress[_Key] = _Value;
         }
   4. 原理：
      1. 不存key資訊，無length資訊
      2. 使用keccak256(abi.encodePacked(key, slot))作為offset存取value，slot是映射變量定義所在插槽
      3. 定义所有未使用的空间为0，初始值為默認值

# 8：變量初始值
      1. 值/引用 類型
         1. 值：
            boolean: false
            string: ""
            int: 0
            uint: 0
            enum: 枚举中的第一个元素
            address: 0x0000000000000000000000000000000000000000 (或 address(0))
            function
            internal: 空白函数
            external: 空白函数

         2. 引用
            映射mapping: 所有元素都为其默认值的mapping(即a=>b中b的默認值)
            结构体struct: 所有成员设为其默认值的结构体
            数组array
               动态数组: []
               静态数组（定长）: 所有成员设为其默认值的静态数组
               eg:byte1初始值為0x00

      2. delete操作符
         dalete a; //變量a還原初始值

### 2024.09.25

學習內容：WTF #9-11

![image](https://github.com/user-attachments/assets/57aecb5b-19c1-43d9-b848-4ebfd3c5e4f8)


# 9:常數
   1. constant
      1. 数值变量可以声明constant和immutable
      2. string和bytes可以声明为constant，但不能为immutable
      3.初始化之后，尝试改变它的值，会编译不通过
      4. 必須聲明時初始化，後不可變
         ~ uint256 constant CONSTANT_NUM = 10;
   2. immutable
      1. 靈活，可在聲明或構造函數時初始化
      2. Solidity v8.0.21以后，immutable变量不需要显式初始化。反之，则需要显式初始化。
      3.初始化之后，尝试改变它的值，会编译不通过
      4. immutable變量同時在聲明和constructor中初始化-->使用constructor初始化值
         ```
         constructor()
         {
            IMMUTABLE_ADDRESS = address(this);
            IMMUTABLE_NUM = 1118;
            IMMUTABLE_TEST = test();
         }
         ```

# 10:控制流
   https://www.wtf.academy/docs/solidity-101/InsertionSort
   1. if-else
   2. for
   3. while
   4. do-while
   5. 三元運算符：条件? 条件为真的表达式:条件为假的表达式
   6. continue/break
   7. 插入排序
```
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
```
notice: 
   - line178: uint j=i;
   - line179-180: uint j >= 1   &   a[j] = a[j-1];


# 11:構造函數和修飾器
   1. constructor
         1. 每个合约可以定义一个，在部署合约的时候自动运行一次
         2. 可以用来初始化合约的一些参数，如owner地址
            ```
            constructor(address initialOwner)
            {
                owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
            //舊寫法 Parents
            }
            ```
   2. modifier：运行函数前的检查，例如地址，变量，余额
      ```
         modifier onlyOwner
          {
               require(msg.sender == owner); // 检查调用者是否为owner地址
               _; // 如果是的话，继续运行函数主体；否则报错并revert交易
               //onlyOwner修饰符的函数只能被owner地址调用
          }

         function changeOwner(address _newOwner) external onlyOwner
               {
                  owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
               }
      ```
OpenZeppelin是一个维护Solidity标准化代码库的组织，他的Ownable标准实现如下： https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


### 2024.09.26

學習內容：WTF #12 (今天比較忙ＱＱ)
![image](https://github.com/user-attachments/assets/8cc42e19-bbc5-49eb-bc9f-86ad44b65ee4)


# 12:事件

   1. 应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应
   2. 每個只消耗200gas, 較鏈上新變量少（20000gas）
   3. 聲明：ERC20 Transfer
        event Transfer(address indexed from, address indexed to, uint256 value);
        3个变量from，to和value
        from和to前面带有indexed关键字，他们会保存在以太坊虚拟机日志的topics
   4. 釋放:emit Transfer(from, to, amount);
   5. 儲存：
      1. EVM log 以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。
      2. 事件中不带 indexed的参数会被存储在 data 部分中，可以理解为事件的“值”。data 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 data 部分可以用来存储复杂的数据结构，例如数组和字符串
   6. event hash:keccak256("Transfer(address,address,uint256)")
   7. 在Etherscan上查询事件:Etherscan


### 2024.09.27

學習內容：WTF #13

# 13:繼承  （contract Erzi is Yeye）

![image](https://github.com/user-attachments/assets/a0cb4b70-bcb9-4caa-8a88-15545372adb4)


   1. virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。

   2. override：子合约重写了父合约中的函数（与变量同名的getter函数），需要加上override关键字。

      mapping(address => uint256) public override balanceOf;   

   3. 多重继承：高～低排(contract Erzi is Yeye, Baba)、多重需重寫、父在需冠父親名
   4. Modifier 同样可以继承
         构造函数继承:in 聲明or 子構造函數中
   5. 调用父合约的函数:1)直接调用(Yeye.pop())和2)利用super关键字調用最近父合約函數(super.pop();)
   6. 钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类

   7. https://www.wtf.academy/docs/solidity-101/Inheritance/
        
### 2024.09.28

學習內容：WTF #14~15
![image](https://github.com/user-attachments/assets/e9b7b53f-4878-4748-9793-f8229a0101c9)


# 14:抽象合约和接口

1. 抽象合約：至少有一个未实现的函数，即某个函数缺少主体{}中的内容，必须将该合约标为abstract。未实现的函数需要加virtual，以便子合约重写。不能被部署

abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}

2. 接口类似于抽象合约，但它不实现任何功能。接口的规则：

   1. 不能包含状态变量
   2. 不能包含构造函数
   3. 不能继承除接口外的其他合约
   4. 所有函数都必须是external且不能有函数体
   5. 继承接口的非抽象合约必须实现接口定义的所有功能

接口是智能合约的骨架，定义了合约的功能以及如何触发它们：如果智能合约实现了某种接口（比如ERC20或ERC721），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：

   1. 合约里每个函数的bytes4选择器，以及函数签名函数名(每个参数类型）。
   2. 接口id（更多信息见EIP165）

另外，接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用abi-to-sol工具，也可以将ABI json文件转换为接口sol文件。

- 接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。

- 如果我们知道一个合约实现了IERC721接口，我们不需要知道它具体代码实现，就可以与它交互

IERC721:https://www.wtf.academy/docs/solidity-101/Interface/

// 利用BAYC地址创建接口合约变量（ETH主网）
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
// 通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }


# 15:異常：debug

Solidity三种抛出异常的方法：error，require和assert

   1. error:solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。人们可以在contract之外定义异常，必须搭配revert（回退）命令使用。

      error TransferNotOwner(address sender); // 自定义的带参数的error
      revert TransferNotOwner(); //in function
   2. require:缺点就是gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述"),条件不成立的时候，就会抛出异常。
   3. assert(检查条件），当检查条件不成立的时候，就会抛出异常。
   4. error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas

### 2024.09.29

學習內容：WTF #16
![image](https://github.com/user-attachments/assets/599163cf-49f6-4353-97d4-d1ab7528d376)



# 16:overloading
名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数(返回了不同的结果)。注意，Solidity不允许修饰器（modifier）重载，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数（即一輸入可以進入不同overloding function 時），则会报错

### 2024.09.30

學習內容：WTF #17

# 17:庫合約

1. 和普通合约主要有以下几点不同：

不能存在状态变量
不能够继承或被继承
不能接收以太币
不可以被销毁

2. 函数可见性如果被设置为public或者external，则在调用函数时会触发一次delegatecall。而如果被设置为internal，则不会引起。对于设置为private可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

3. 調用
   a. using A for B
   b. 直接調用庫合約
4. 常用庫合約
   Strings：将uint256转换为String
   Address：判断某个地址是否为合约地址
   Create2：更安全的使用Create2 EVM opcode
   Arrays：跟数组相关的库合约

### 2024.10.2

學習內容：WTF #18 

# 18:import
4種:
 // 通过文件相对位置import
import './Yeye.sol';
// 通过`全局符号`导入特定的合约
import {Yeye} from './Yeye.sol';
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 引用OpenZeppelin合约
import '@openzeppelin/contracts/access/Ownable.sol';

contract Import {
    // 成功导入Address库
    }


<!-- Content_END -->
