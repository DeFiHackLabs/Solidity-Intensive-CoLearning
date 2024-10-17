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

### 2024.10.02

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

### 2024.10.04

學習內容: WTF 19~20

![image](https://github.com/user-attachments/assets/dbb32a08-fe16-43ee-be33-57dd1ec1eff0)


# 19: 接收ETH
Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：1)接收ETH，2)处理合约中不存在的函数调用（代理合约proxy contract)
fallback(or receive)函数不能在合约内部调用

1. receive():
      1. 不要执行太多的逻辑,太复杂可能会触发Out of Gas报错。除非用call自訂gas
      2. 一个合约最多有一个,不需要function
      3. 不能有任何的参数，不能返回任何值，必须包含external和payable
      4. 恶意合约，会在receive() 函数（老版本的话，就是 fallback() 函数）嵌入恶意消耗gas的内容或者使得执行故意失败的代码，导致一些包含退款和转账逻辑的合约不能正常工作

     ```
         // 定义事件
         event Received(address Sender, uint Value);
         // 接收ETH时释放Received事件
         receive() external payable {
             emit Received(msg.sender, msg.value);
         }
     ```


2. fallback():
      1. 会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract
      2. 不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }
      3. 想部署一个能接收ETH和msg.data的合约必須用它
      4. 沒有定義會ETH value和msg.data發送失敗(不可只用receive)

         ```
         event fallbackCalled(address Sender, uint Value, bytes Data);
         // fallback
         fallback() external payable{
             emit fallbackCalled(msg.sender, msg.value, msg.data);
         }
         ```
   
3. 触发fallback() 还是 receive()? (receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错)
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()

# 20:發送ETH

Solidity有三种方法向其他合约发送ETH，他们是：transfer()，send()和call()，其中call()是被鼓励的用法
call没有gas限制，最为灵活，是最提倡的方法；
transfer有2300 gas限制，但是发送失败会自动revert交易，是次优选择；
send有2300 gas限制，而且发送失败不会自动revert交易，几乎没有人用它。

1. 先寫一個接收:
   先部署一个接收ETH合约ReceiveETH。ReceiveETH合约里有一个事件Log，记录收到的ETH数量和gas剩余。还有两个函数，一个是receive()函数，收到ETH被触发，并发送Log事件；另一个是查询合约ETH余额的getBalance()函数
   contract ReceiveETH {
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    // receive方法，接收eth时被触发
    receive() external payable{
        emit Log(msg.value, gasleft());
    }
    
    // 返回合约ETH余额 (getBalance()函数，可以看到当前合约的ETH余额)
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}

2. 發送:
   contract SendETH {
    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable{}
    // receive方法，接收eth时被触发
    receive() external payable{}
}

3. 3 WAYS
      1. TRANSFER:接收方地址.transfer(发送ETH数额)，失敗會revert
            function transferETH(address payable _to, uint256 amount) external payable{
                   _to.transfer(amount);
               }

      2. SEND:接收方地址.send(发送ETH数额)
            转账失败，不会revert。返回值是bool，代表着转账成功或失败，需要额外代码处理
            
            error SendFailed(); // 用send发送ETH失败error
   
            // send()发送ETH
            function sendETH(address payable _to, uint256 amount) external payable{
                // 处理下send的返回值，如果失败，revert交易并发送error
                bool success = _to.send(amount);
                if(!success){
                    revert SendFailed();
                }
            }
      3. CALL:接收方地址.call{value: 发送ETH数额}("")
         转账失败，不会revert。call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理。無gas限制
         
         error CallFailed(); // 用call发送ETH失败error

         // call()发送ETH
         function callETH(address payable _to, uint256 amount) external payable{
             // 处理下call的返回值，如果失败，revert交易并发送error
             (bool success,) = _to.call{value: amount}("");
             if(!success){
                 revert CallFailed();
             }
         }

### 2024.10.05

學習內容: WTF 21~22
![image](https://github.com/user-attachments/assets/176d1942-2f85-4dfb-b0e0-7863fb78ea8c)


# 21:調用其他合約
1. 传入合约地址
         function callSetX(address _Address, uint256 x) external{
          OtherContract(_Address).setX(x);
         }
2. 传入合约变量:调用目标合约的getX()
          function callGetX(OtherContract _Address) external view returns(uint x){
             x = _Address.getX();
         }
3. 创建合约变量
         function callGetX2(address _Address) external view returns(uint x){
             OtherContract oc = OtherContract(_Address);
             x = oc.getX();
         }
   //变量oc存储了OtherContract合约的引用
   //复制OtherContract合约的地址，填入callGetX2函数的参数中，调用后成功获取x的值

4. 调用合约并发送ETH
         function setXTransferETH(address otherContract, uint256 x) payable external{
          OtherContract(otherContract).setX{value: msg.value}(x);
         }
   //目标合约的函数是payable的，那么我们可以通过调用它来给合约转账：_Name(_Address).f{value: _Value}()，其中_Name是合约名，_Address是合约地址，f是目标函数名，_Value是要转的ETH数额（以wei为单位)

   兩種都可:
(1) OtherContract other = OtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138)
(2) IOtherContract other = IOtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138)

# 22:Call

1. call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。

2. call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数，见第21讲：调用其他合约。当我们不知道对方合约的源代码或ABI，就没法生成合约变量；这时，我们仍可以通过call调用对方合约的函数。

3. 目标合约地址.call(字节码);
   字节码利用结构化编码函数abi.encodeWithSignature获得：abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
      函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)。

4. 另外call在调用合约时可以指定交易发送的ETH数额和gas数额：目标合约地址.call{value:发送数额, gas:gas数额}(字节码);

5. ```
       contract OtherContract {
       uint256 private _x = 0; // 状态变量x
       // 收到eth的事件，记录amount和gas
       event Log(uint amount, uint gas);
       
       fallback() external payable{}
   
       // 返回合约ETH余额
       function getBalance() view public returns(uint) {
           return address(this).balance;
       }
   
       // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
       function setX(uint256 x) external payable{
           _x = x;
           // 如果转入ETH，则释放Log事件
           if(msg.value > 0){
               emit Log(msg.value, gasleft());
           }
       }
   
       // 读取x
       function getX() external view returns(uint x){
           x = _x;
       }    }

5. 利用call调用目标合约
   1. Response事件
      
      // 定义Response事件，输出call返回的结果success和data
         event Response(bool success, bytes data);

      
 2. 调用setX函数
    
    function callSetX(address payable _addr, uint256 x) public payable {
       // call setX()，同时可以发送ETH
       (bool success, bytes memory data) = _addr.call{value: msg.value}(
           abi.encodeWithSignature("setX(uint256)", x)
       );
   
       emit Response(success, data); //释放事件
      }

    3. 调用getX函数
       
      function callGetX(address _addr) external returns(uint256){
    // call getX()
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("getX()")
    );

    emit Response(success, data); //释放事件
    return abi.decode(data, (uint256));
   }

   4. 调用不存在的函数:觸發fallback
      
      function callNonExist(address _addr) external{
    // call 不存在的函数
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("foo(uint256)")
    );

    emit Response(success, data); //释放事件
}



### 2024.10.06

學習內容: WTF 23

# 23:delegatecall与call类似，是Solidity中地址类型的低级成员函数

1. 当用户A通过合约B来call合约C的时候，执行的是合约C的函数，上下文(Context，可以理解为包含变量和状态的环境)也是合约C的：msg.sender是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上。
2. 而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
   （用户A）把他的资产（B合约的状态变量）都交给一个风险投资代理（C合约）来打理。执行的是风险投资代理的函数，但是改变的是资产的状态。

3. 目标合约地址.delegatecall(二进制编码);
   二进制编码利用结构化编码函数abi.encodeWithSignature -->abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)

4. delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额

5. delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。

6. delegatecall主要有两个应用场景：
      1. 代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。
      2. EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。 更多信息请查看：钻石标准简介。

7. 你（A）通过合约B调用目标合约C

         // 被调用的合约C
         contract C {
             uint public num;
             address public sender;
         
             function setVars(uint _num) public payable {
                 num = _num;
                 sender = msg.sender;
             }
         }
         
         contract B {
             uint public num;
             address public sender;
         }
         
         // 通过call来调用C的setVars()函数，将改变合约C里的状态变量
         function callSetVars(address _addr, uint _num) external payable{
             // call setVars()
             (bool success, bytes memory data) = _addr.call(
                 abi.encodeWithSignature("setVars(uint256)", _num)
             );
         }
         
         // 通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量
         function delegatecallSetVars(address _addr, uint _num) external payable{
             // delegatecall setVars()
             (bool success, bytes memory data) = _addr.delegatecall(
                 abi.encodeWithSignature("setVars(uint256)", _num)
             );
         }

### 2024.10.07

學習內容: WTF 24

# 24:

1. 以太坊链上，用户（外部账户，EOA）可以创建智能合约，智能合约同样也可以创建新的智能合约。去中心化交易所uniswap就是利用工厂合约（PairFactory）创建了无数个币对合约（Pair）。
两种方法可以在合约中创建新合约，create和create2(#25)

2. create的用法:
   Contract x = new Contract{value: _value}(params)
//Contract:合约名，x:合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params:新合约构造函数的参数。

3. Uniswap V2核心合约中包含两个合约：
- UniswapV2Pair: 币对合约，用于管理币对地址、流动性、买卖。
- UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。
//Pair币对合约负责管理币对地址，PairFactory工厂合约用于创建新的币对，并管理币对地址。

4. Pair合约
     
         contract Pair{
          address public factory; // 工厂合约地址
          address public token0; // 代币1
          address public token1; // 代币2
   
       constructor() payable {
           factory = msg.sender;
       }
   
       // called once by the factory at time of deployment
       function initialize(address _token0, address _token1) external {
           require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
           token0 = _token0;
           token1 = _token1;
       }
         }

//3个状态变量：factory，token0和token1。
//构造函数constructor在部署时将factory赋值为工厂合约地址。initialize函数会初始化代币地址，将token0和token1更新为币对中两种代币的地址。
   uniswap使用的是create2创建合约，生成的合约地址可以实现预测

5. PairFactory

         contract PairFactory{
          mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
          address[] public allPairs; // 保存所有Pair地址
      
          function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
              // 创建新合约
              Pair pair = new Pair(); 
              // 调用新合约的initialize方法
              pair.initialize(tokenA, tokenB);
              // 更新地址map
              pairAddr = address(pair);
              allPairs.push(pairAddr);
              getPair[tokenA][tokenB] = pairAddr;
              getPair[tokenB][tokenA] = pairAddr;
          }
      }

getPair是两个代币地址到币对地址的map，方便根据代币找到币对地址
allPairs是币对地址的数组，存储了所有代币地址。

PairFactory合约只有一个createPair函数，根据输入的两个代币地址tokenA和tokenB来创建新的Pair合约。其中
Pair pair = new Pair(); 

### 2024.10.08

學習內容: WTF 25~26
![螢幕擷取畫面 2024-10-08 145448](https://github.com/user-attachments/assets/ef23cb9b-38f2-4c32-b5be-67abfe6b6a7c)

# 25:create2
1. CREATE2 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址。Uniswap创建Pair合约用的就是CREATE2而不是CREATE

2. create:新地址 = hash(创建者地址, nonce)
//nonce:该地址发送交易的总数,对于合约账户是创建的合约总数,每创建一个合约nonce+1
//创建者地址不会变，但nonce可能会随时间而改变，因此用CREATE创建的合约地址不好预测

3. CREATE2的目的是为了让合约地址独立于未来的事件
新地址 = hash("0xFF",创建者地址, salt, initcode)
//0xFF：一个常数，避免和CREATE冲突
//CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
////salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。

4. CREATE2 确保，如果创建者使用 CREATE2 和提供的 salt 部署给定的合约initcode，它将存储在 新地址 中。

   Contract x = new Contract{salt: _salt, value: _value}(params)
   
5. calculateAddr函数来事先计算tokenA和tokenB将会生成的Pair地址。通过它，我们可以验证我们事先计算的地址和实际地址是否相同。

6. 如果部署合约构造函数中存在参数，计算时，需要将参数和initcode一起进行打包：keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))

7.实际应用场景:交易所为新用户预留创建钱包合约地址。
由 CREATE2 驱动的 factory 合约，在Uniswap V2中交易对的创建是在 Factory中调用CREATE2完成。这样做的好处是: 它可以得到一个确定的pair地址, 使得 Router中就可以通过 (tokenA, tokenB) 计算出pair地址, 不再需要执行一次 Factory.getPair(tokenA, tokenB) 的跨合约调用。

# 26:刪除合約

1. selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。selfdestruct是为了应对合约出错的极端情况而设计的。在 v0.8.18 版本中，selfdestruct 关键字被标记为「不再建议使用」，在一些情况下它会导致预期之外的合约语义

2. EIP-6780被纳入升级以实现对Verkle Tree更好的支持。EIP-6780减少了SELFDESTRUCT操作码的功能。根据提案描述，当前SELFDESTRUCT仅会被用来将合约中的ETH转移到指定地址，而原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以目前来说：
   1. 已经部署的合约无法被SELFDESTRUCT了。
   2. 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT

3. selfdestruct(_addr)；
//_addr是接收合约中剩余ETH的地址。_addr 地址不需要有receive()或fallback()也能接收ETH。

function deleteContract() external {
        // 调用selfdestruct销毁合约，并把剩余的ETH转给msg.sender
        selfdestruct(payable(msg.sender));
    }

4. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
5. 当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。


### 2024.10.11

學習內容: WTF 27~30

# 27:ABI
ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。
数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。

ABI编码有4个函数：abi.encode, abi.encodePacked, abi.encodeWithSignature, abi.encodeWithSelector。
而ABI解码有1个函数：abi.decode，用于解码abi.encode的数据。这一讲，我们将学习如何使用这些函数。

ABI编码
我们将编码4个变量，他们的类型分别是uint256（别名 uint）, address, string, uint256[2]：

         uint x = 10;
         address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
         string name = "0xAA";
         uint[2] array = [5, 6]; 

abi.encode:将给定参数利用ABI规则编码。ABI被设计出来跟智能合约交互，他将每个参数填充为32字节的数据，并拼接在一起。如果你要和合约交互，你要用的就是abi.encode。将给定参数根据其所需最低空间编码。当调用其他合约的时候可以使用。

abi.encodePacked类似 abi.encode，但是会把其中填充的很多0省略。比如，只用1字节来编码uint8类型。当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked，例如算一些数据的hash时。

abi.encodeWithSignature
与abi.encode功能类似，只不过第一个参数为函数签名，比如"foo(uint256,address,string,uint256[2])"。当调用其他合约的时候可以使用。


abi.encodeWithSelector
与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。当调用其他合约的时候可以使用。

abi.decode
abi.decode用于解码abi.encode生成的二进制编码，将它还原成原本的参数。

ABI的使用场景
在合约开发中，ABI常配合call来实现对合约的底层调用。

      bytes4 selector = contract.getValue.selector;
      
      bytes memory data = abi.encodeWithSelector(selector, _x);
      (bool success, bytes memory returnedData) = address(contract).staticcall(data);
      require(success);
      
      return abi.decode(returnedData, (uint256));


ethers.js中常用ABI实现合约的导入和函数调用。

      const wavePortalContract = new ethers.Contract(contractAddress, contractABI, signer);
      /*
          * Call the getAllWaves method from your Smart Contract
          */
      const waves = await wavePortalContract.getAllWaves();


对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用。

# 28 HASH
哈希函数应该具有以下几个特性：

单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
灵敏性：输入的消息改变一点对它的哈希改变很大。
高效性：从输入的消息到哈希的运算高效。
均一性：每个哈希值被取到的概率应该基本相等。
抗碰撞性：
      弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
      强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。

Hash的应用
   生成数据唯一标识
   加密签名
   安全加密
Keccak256是Solidity中最常用的哈希函数﹔哈希 = keccak256(数据);

Keccak256和sha3
这是一个很有趣的事情：

sha3由k
eccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。所以SHA3就和keccak计算的结果不一样，这点在实际开发中要注意。
以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的
我们可以利用keccak256来生成一些数据的唯一标识。比如我们有几个不同类型的数据：uint，string，address，我们可以先用abi.encodePacked方法将他们打包编码，然后再用keccak256来生成唯一标识

# 29；函数选择器
当我们调用智能合约时，本质上是向目标合约发送了一段calldata(input)，前4个字节是selector（函数选择器）

在下面的代码中，我们可以通过Log事件来输出调用mint函数的calldata：

      // event 返回msg.data
      event Log(bytes data);
      
      function mint(address to) external{
          emit Log(msg.data);
      }

0x6a6278420000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
可以分成两部分：

//前4个字节为函数选择器selector：0x6a627842
//后面32个字节为输入的参数：0x0000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
其实calldata就是告诉智能合约，我要调用哪个函数，以及参数是什么。

method id、selector和函数签名
   method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数，那么函数签名是什么？
   其实在第21讲中，我们简单介绍了函数签名，为"函数名（逗号分隔的参数类型)"。举个例子，上面代码中mint的函数签名为"mint(address)"。在同一个智能合约中，不同的函数有不同的函数签名，因此我们可以通过函数签名来确定要调用哪个函数。

注意，在函数签名中，uint和int要写为uint256和int256。

我们写一个函数，来验证mint函数的method id是否为0x6a627842。大家可以运行下面的函数，看看结果。

      function mintSelector() external pure returns(bytes4 mSelector){
          return bytes4(keccak256("mint(address)"));
      }

结果正是0x6a627842


基础类型的参数有：uint256(uint8, ... , uint256)、bool, address等。在计算method id时，只需要计算bytes4(keccak256("函数名(参数类型1,参数类型2,...)"))。例如，如下函数，函数名为elementaryParamSelector，参数类型分别为uint256和bool。所以，只需要计算bytes4(keccak256("elementaryParamSelector(uint256,bool)"))便可得到此函数的method id。
固定长度类型参数
固定长度的参数类型通常为固定长度的数组，例如：uint256[5]等。例如，如下函数fixedSizeParamSelector的参数为uint256[3]。因此，在计算该函数的method id时，只需要通过bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))即可。
可变长度类型参数
可变长度参数类型通常为可变长的数组，例如：address[]、uint8[]、string等。例如，如下函数nonFixedSizeParamSelector的参数为uint256[]和string。因此，在计算该函数的method id时，只需要通过bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"))即可。
映射类型参数
映射类型参数通常有：contract、enum、struct等。在计算method id时，需要将该类型转化成为ABI类型。

例如，如下函数mappingParamSelector中DemoContract需要转化为address，结构体User需要转化为tuple类型(uint256,bytes)，枚举类型School需要转化为uint8。因此，计算该函数的method id的代码为bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"))。

我们可以利用selector来调用目标函数。例如我想调用elementaryParamSelector函数，我只需要利用abi.encodeWithSelector将elementaryParamSelector函数的method id作为selector和参数打包编码，传给call函数：

    // 使用selector来调用函数
    function callWithSignature() external{
    ...
        // 调用elementaryParamSelector函数
        (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
    ...
    }

# 30: Try Catch

try-catch是现代编程语言几乎都有的处理异常的一种标准方式，Solidity0.6版本也添加了它。这一讲，我们将介绍如何利用try-catch处理智能合约中的异常。

try-catch
在Solidity中，try-catch只能被用于external函数或创建合约时constructor（被视为external函数）的调用。基本语法如下：

      try externalContract.f() {
          // call成功的情况下 运行一些代码
      } catch {
          // call失败的情况下 运行一些代码
      }

其中externalContract.f()是某个外部合约的函数调用，try模块在调用成功的情况下运行，而catch模块则在调用失败时运行。

同样可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。

如果调用的函数有返回值，那么必须在try之后声明returns(returnType val)，并且在try模块中可以使用返回的变量；如果是创建合约，那么返回值是新创建的合约变量。

      try externalContract.f() returns(returnType val){
          // call成功的情况下 运行一些代码
      } catch {
          // call失败的情况下 运行一些代码
      }

另外，catch模块支持捕获特殊的异常原因：

      try externalContract.f() returns(returnType){
          // call成功的情况下 运行一些代码
      } catch Error(string memory /*reason*/) {
          // 捕获revert("reasonString") 和 require(false, "reasonString")
      } catch Panic(uint /*errorCode*/) {
          // 捕获Panic导致的错误 例如assert失败 溢出 除零 数组访问越界
      } catch (bytes memory /*lowLevelData*/) {
          // 如果发生了revert且上面2个异常类型匹配都失败了 会进入该分支
          // 例如revert() require(false) revert自定义类型的error
      }

### 2024.10.12

學習內容: WTF 31 1/2 +複習1-5

複習第1-5章和看完31（需要再看一次）

### 2024.10.16

學習內容: WTF 31+32
ERC20&代幣水龍頭
<!-- Content_END -->
