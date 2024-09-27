---
timezone: Asia/Shanghai
---

# rorozn

1. 自我介绍:  
   web2 转全职 web3 萌新, 希望找个 remote 工作

2. 你认为你会完成本次残酷学习吗？  
   会！学完试着参加黑客松

## Notes

<!-- Content_START -->

### 2024.09.15

#### **1.三行代码**

- 软件许可最好写上
- 注意结尾;号
- 注意 pragma 拼写，a 不是 o！

```solidity
// SPDX-License-Identifier:MIT

pragma solidity>=0.8.21; //solidity版本 ^相当于>=

contract HelloWeb3{ //合约内容
    string public _string = "Hello Web3!!";
}
```

- 部署 deploy 向链上写入代码，要消耗 gas 的

#### **2.值类型**

- payable 关键字：账户相关，可以转账、查余额
- bytes1 有 2 个 16 进制，0xff，bytes32 就有 64 个 16 进制，1 个 16 进制位=2\*\*4，bytes32=32\*2\*4=256 个 0
- [运算符优先级](https://docs.soliditylang.org/zh/v0.8.19/cheatsheet.html)

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract ValueType{
    bool public _bool= true;
    int public  _int = -1;
    uint public _uint =1;
    uint256 public _number= 20240915;
    //address
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1= payable (_address);
    uint256 public balance = _address1.balance;

    bytes32 public _byte32 = "solidity";
    string public text = "text";
    bytes1 public _byte = 0x01;
    bytes1 public _byte2 = 'b';

    //几乎很少用
    enum ActionSet{ Buy, Hold, Sell}
    ActionSet action = ActionSet.Hold;
    //enum转unit
    function enumToUint() external view returns(uint){
        return uint(action);
    }

}
```

- uint 要注意减法时的溢出，比如插入排序时，0-1 溢出了

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract InsertSort {
    uint[] private m_uintArr;

    function insertSort () public  { //插入排序
        for(uint i=1; i<m_uintArr.length; i++){
            uint j = i; //为什么用j= i-1的方式不行： 因为uint类型 0-1就溢出啦！！！
            uint value = m_uintArr[i];
            while(j>=1 && m_uintArr[j-1]>value){
                m_uintArr[j] = m_uintArr[j-1];
                j--;
            }
            m_uintArr[j] = value;
        }
    }

    // function insertSort2 () public  {
    //     for(uint i=1; i<m_uintArr.length; i++){
    //         uint j = i-1; //j= i-1 无符号整形，溢出
    //         uint value = m_uintArr[i];
    //         while(j>=0 && m_uintArr[j]>value){
    //             m_uintArr[j+1] = m_uintArr[j];
    //             j--;
    //         }
    //         m_uintArr[j+1] = value;
    //     }
    // }

    function input(uint[] memory _arr) public {
        m_uintArr = _arr;
    }

    function showArr() view public returns(uint[] memory){
        return m_uintArr;
    }
}
```

### 2024.09.16

#### **tintinland 的作业**

[TTlandTask](https://github.com/chesley666/TTlandTask/)

- task2-1： 插入排序，注意 unit 类型，0-1 时会溢出
- task2-2： 简易 nftswap 实现暂时还不会，先用 ai 生成代码并读懂，全部学完之后再实现一遍

#### **btc/eth 基础**

朋友问了我一些问题，觉得还是应该复习一下基础

- **btc 的 fees 和矿工挖矿的收益是 1 个东西吗？**  
  比特币的转账手续费（也称为矿工费）和挖矿奖励（block reward）是两个相关但独立的概念。挖矿奖励是矿工成功挖出一个区块时获得的固定数量的新生成的比特币。而交易手续费则是用户在进行比特币交易时支付给矿工的费用，以激励矿工将他们的交易包含在区块中。随着比特币挖矿奖励的减半，交易手续费在矿工收入中所占的比例将逐渐增加，并可能最终成为矿工的主要收入来源。
- **btc 和 bch 分叉改了哪里？**
  BCH 的分叉涉及到对原始比特币代码的修改，比如增加区块大小、改变共识算法等。BCH 在 2017 年的分叉为了解决 BTC 的可扩展性问题，通过增加区块大小来允许更多的交易，从而减少费用和交易时间。分叉前链上数据一致，分叉后因为代码本质上就已经不一致了所以数据肯定不一致
- **btc 的 fees 和 eth 的 gas 的区别？**
  BTC 的交易费用主要由交易的大小（以字节为单位）决定，费用是交易大小乘以每字节的费用率。  
  ETH 的 Gas 费用包括基本费用（base fee）和优先费用（priority fee）。基本费用依据 EVM 里指令消耗算力的情况，而优先费用则是用户为了使交易更快被处理而支付给矿工的小费。EIP-1559 引入了基本费用和最大费用（max fee）：用户愿意为每单位 Gas 支付的最高费用，EIP-4844（2024）改变里费用计算结构，尤其是 calldata 部分，在高交易量时减少了费用，对 layer2 层有影响？。  
  [CKB/EVM 简介](https://accu.cc/content/ckb/evm/)
- **btc 的 fees 计算依据？交易失败时 fees 怎么处理？**

  - 交易大小：比特币交 fees 用通常按 sat/vByte 计算。交易数据量越大费用越高。例如，UTXO 模型下，多个输入和输出的交易体积大，费用也就高。
  - 网络拥堵情况：在网络活动高峰期间，未确认交易的池（mempool）可能会变得拥挤。为了快速确认交易，会提高 fees，从而推高 avg fees。
  - 用户偏好：可以手动设置交易 fees。
  - 交易复杂性：某些交易使用特殊功能，如多重签名（multisig），这会增加交易的数据大小。

    **当交易失败时，处理费用的方式可能会有所不同。如果交易未能进入区块链，即未被任何矿工确认，那么交易发起者可能有机会通过以下方式处理费用：**

  - 执行代码出错通常不会发生，交易被网络节点接受之前会经过验证（签名、默克尔树等技术），但可能出现 网络问题、交易费过低导致长时间未被确认、交易格式不符合网络规则等原因。
  - 交易未被确认：因为任何原因未能被矿工确认并包含在区块链中，那么这笔交易的手续费不会被退还给用户，也不会支付给矿工。它会留在比特币的内存池（mempool）中，直到交易被确认或从内存池中移除。
  - 交易被拒绝：如果交易因为格式错误或其他严重问题被网络节点拒绝，那么这笔交易的手续费同样不会被退还，也不会支付给矿工。
  - 交易被取消：在某些情况下，如果交易尚未被确认，用户可以通过提高交易费用来“替换”原来的交易（Replace-by-Fee, RBF），允许用户通过支付更高费用来鼓励矿工优先处理其交易。在这种情况下，原始交易的手续费将由矿工保留，而新交易将包含新的更高的费用。
  - 交易被确认：一旦交易被确认并包含在区块链中，交易费用就会被支付给将该交易包含在区块中的矿工。

- **eth 的 gas 计算依据？交易失败时 gas 怎么处理？**  
  笼统的说，根据 evm 里指令消耗算力多少，区块的大小(50%为界)，用户的 tip 设置；当执行 revert/require/assert 函数时,0.8.0 之前，gas 会被消耗掉不返还；0.8.0 之后的版本，revert 和 require 错误现在使用 EVM 的 REVERT 操作码，它允许错误信息被包含在交易回执中，并且剩余的 gas 可以被返还。
- **UTXO 模型**  
  **A 有 7btc(5，2 两个未花费)，现在要转给 B 3btc，从 A 发起交易到 B 钱包查看到钱，发生了什么？换成 eth 的话过程又是怎样的？**

  - **BTC 交易过程：**
    [体验区块链](https://andersbrownworth.com/blockchain/coinbase)

    1. 创建交易：A 的钱包软件会创建一笔交易，这笔交易指定了 B 的比特币地址作为收款方，并且指定了转账金额为 3 BTC。
    2. 选择 UTXO：为了完成这笔交易，A 的钱包会从 A 控制的未花费交易输出（UTXO）中选择足够的 BTC 来支付 3 BTC 给 B，以及支付给矿工的交易费。A 有 7 BTC，其中 5 BTC 是未花费的，因此可能选择这 5 BTC 的 UTXO。
    3. 生成新 UTXO：在比特币系统中，交易是通过消耗旧的 UTXO 并创建新的 UTXO 来完成的。这意味着 A 的 5 BTC UTXO 将被消耗，并生成两个新的 UTXO：一个 3 BTC 的 UTXO 给 B，一个小于 2 BTC 的 UTXO 作为找零返回给 A（因为 A 只需要支付 3 BTC，所以剩余的 BTC 会作为找零）。
    4. 交易签名(**椭圆曲线算法**)：A 使用与要花费的 UTXO 关联的私钥对交易进行签名，以证明 A 有权使用这些 UTXO 中的 BTC。
    5. 广播交易：签名后的交易被广播到比特币网络中，矿工节点会接收到这笔交易。
    6. 交易验证：网络中的矿工节点会验证交易的有效性，包括检查签名是否与 UTXO 匹配，以及确保 A 的比特币余额足够。
    7. 交易进入内存池 mempool： 一旦交易通过验证，它就会被加入到节点的内存池中。内存池中的交易会根据交易费用进行排序，因为矿工在打包区块时倾向于选择手续费较高的交易。
    8. 打包交易（**数字摘要**）：矿工从他们的内存池中选择交易，并将其打包成一个区块。矿工通常会优先选择那些手续费较高的交易。
    9. 工作量证明（**默克尔树**）：矿工通过解决工作量证明（PoW）难题来挖掘新区块，这个过程需要大量的计算力。  
       **区块的数据结构：** header(prehash,curhash,交易摘要)+交易内容，**具体待补充**

    10. 区块确认：当新区块被添加到区块链上，这笔交易就得到了初步确认。随着更多的区块在该区块之后被添加，交易的确认度会增加。通常，6 个确认被认为是安全的，这意味着交易几乎不可能被逆转。
    11. 更新钱包余额：一旦交易被确认，B 的钱包会更新显示新的 3 BTC 余额，而 A 的钱包会扣除 3 BTC 并增加找零的 BTC。

  - **ETH 交易过程（send）：**  
    **以后更新**

- **第 1 比 btc 交易怎么从发起到写入区块的？在创世区块时，当全网只有 1 个节点机器的时候，代码如何运行的？**  
  创世区块的哈希值为 000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f，这是一个 coinbase 交易，它将 50 个比特币作为区块奖励分配给中本聪。然而，这笔奖励由于创世区块在代码中的特殊处理，实际上无法被使用。  
   在比特币的早期版本中，创世区块的代码被直接写入比特币**客户端**软件中，当软件启动时，它会创建这个区块并将其作为区块链的起点。这个过程**不需要网络**中的其他节点参与，因为创世区块是**硬编码**的，它不依赖于网络中的其他区块或交易。在比特币的 C++源代码中，创世区块被定义为一个特殊的案例，它的各个参数（如时间戳、难度目标、Nonce 值等）都是**预先设定好**的。

### 2024.09.17

3. **函数**

- 函数可见性  
  private/internal/external/public 必须有  
  payable 只有在包含了账户相关的功能时才需要
  view 只读没写，pure 没读没写

4. **函数输出**

- returns: 函数返回声明， 如果声明时定义了变量名就自动返回，函数里不用再写 return

```solidity
  function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];

  // 直接命名式返回，returns时声明变量名，return直接返回值
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
}
```

- return：函数里返回指定变量
- 多个变量返回： return(a,b)
- 解构式赋值

```solidity
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}

(_number, _bool, _array) = returnNamed();
(, _bool2, ) = returnNamed(); //只要其中的_bool2
```

### 2024.09.19

5. **变量存储和作用域**

- storage：链上， 合约里的状态变量
- memory： 内存， 函数参数，临时变量
- calldata：内存，不能修改

```solidity
function Calldata(uint[] calldata _x) public pure returns(uint[] calldata){
  return(_x);
}
```

- 引用：相当于指针,s 引用 s / m 引用 m：影响本体；s 引用 m：不影响
- 作用域：  
  状态变量：合约内，函数外，链上存储  
  局部变量：函数里，内存里  
  全局变量：solidity 预留关键字，注意 solidity 里没有小数点，所以要用预留单位表示数据，[全局变量](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)

```solidity
1 wei =1;
1 gwei = 1e9;
1 ether = 1e18;
1 seconds =1;
1 minutes = 60;
1 hours = 3600;
1 days = 86400;
1 weeks = 604800;
```

### 2024.09.20

6. **引用类型**

- 数组

  - bytes 特殊：是数组，不用加[]，单字节 bytes/bytes1[]
  - memory 修饰的动态数组，可以用 new 操作符来创建，但是必须声明长度，并且声明后**长度不能改变**（内存数组 new 需要声明长度且不可改）
  - 数组成员：length,push,pop
  - 结构体

  - 4 种赋值方法：创建引用，直接引用状态变量，函数方式，v-k 形式

  ```solidity
   // 结构体
     struct Student{
     uint256 id;
     uint256 score;
     }
     Student student; // 初始一个 student 结构体

   // 方法1:在函数中创建一个storage的struct引用
     function initStudent1() external{
         Student storage _student = student; // assign a copy of student
         _student.id = 11;
         _student.score = 100;
     }

   // 方法2:直接引用状态变量的struct
     function initStudent2() external{
         student.id = 1;
         student.score = 80;
     }

   // 方法3:构造函数式
     function initStudent3() external {
         student = Student(3, 90);
     }

   // 方法4:key value
     function initStudent4() external {
         student = Student({id: 4, score: 60});
     }
  ```

### 2024.09.21

7.  映射

- key 只能是内置类型，不能自定义
- 映射的**存储位置必须是 storage**，因此可以用于合约的状态变量。原因：_mapping 是动态的，在编译的时候并不知道大小；mapping 元素的存储位置是根据 key 和位置哈希计算出来的，是动态的；EVM 的操作码支持存储的读写，不支持内存复杂数据的操作_
- 不能用于 public 函数的参数/返回，因为记录的是 k-v 结构
- mapping(k=>v) public 会自动创建 getter 函数，通过 k 查询 v
- 新增语法： name[key]=value，删除：delete Map[key];
- 没有 length 信息。如果要查询长度，在更新的时候增加一个计数器变量

```solidity
  contract MappingWithCounter {// 定义一个mapping，用于存储键值对
    mapping(address => uint256) private myMap;// 定义一个计数器，用于跟踪mapping中的元素数量
    uint256 private count;

    // 添加或更新mapping中的元素
    function set(address _addr, uint256 _value) public {
        myMap[_addr] = _value;// 如果之前不存在这个键，则增加计数器
        if (myMap[_addr] == _value && myMap[_addr] != 0) {
            count++;
        }
    }
```

- 映射使用 keccak256(abi.encodePacked(key, slot))当成 offset 存取 value，其中 slot 是映射变量定义所在的插槽位置。
- 以太坊所有未使用的空间默认为 0。未赋值（Value）的键（Key）初始值都是各个 type 的默认值，如 uint 的默认值是 0

8.  变量初始值

- 数值类型

```text
 boolean: false
 string: ""
 int: 0
 uint: 0
 enum: 枚举中的第一个元素
  enum ActionSet { Buy, Hold, Sell}
  ActionSet public _enum; // 第1个内容Buy的索引0
 address: 0x0000000000000000000000000000000000000000 (或 address(0))
 function
     internal: 空白函数
     external: 空白函数
```

- 引用类型:各自类型的初始默认值

```solidity
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000

enum ActionSet { Buy, Hold, Sell}
ActionSet public _enum; // 第1个内容Buy的索引0

function fi() internal{} // internal空白函数
function fe() external{} // external空白函数
```

- delete 操作会让变量值变为初始值

```solidity
// delete操作符
bool public _bool2 = true;
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}
```

9. 常量

- constant,immutable 初始化后不可改变
- 数值变量（uint, int, address）可以 constant 和 immutable
- string/bytes 为 constant，**不能 immutable**，因为：_字符串在 Solidity 中是动态，并且它们的存储方式与值类型不同，字符串实际上是存储在合约存储中的一系列字节，而不是像值类型那样可以直接内联到代码中通过存储加载。_
- constant 必须在声明的时候初始化
- immutable 可以在声明时/构造函数中 初始化，如果声明时初始化&constructor 里又初始化：按 constructor，v8.0.21 之后，不需要显式初始化

```solidity
// 利用constructor初始化immutable变量，因此可以利用
constructor(){
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}

function test() public pure returns(uint256){
    uint256 what = 9;
    return(what);
}
```

### 2024.09.22

10. 控制流  
    插入算法：注意 uint 防止下越界

11. 构造函数&修饰器

- 修饰器：场景：运行函数前的检查； \_;代表被修饰函数的内容

```solidity
modifier onlyOwner{
 require(msg.sender == owner);// 检查调用是否为owner地址
 _; // 如果是的话，运行函数内容
}
function changeOwner(address _newOwner) external onlyOwner{
 owner = _newOwner;
}
```

12. 事件

- 事件是 evm 上日志的抽象；  
  响应：应用程序 ether.js 可以通过 RPC 接口订阅和监听；  
  相比链上存储更省 gas；  
  释放事件：触发事件 emit EventName(k1,k2,...)
- EVM 日志  
  topic 部分：数组结构，最长 4，第一个元素是事件的签名 EventName(type1,type2,...),剩下的是 indexed 参数或者参数哈希（比如 string）  
  data 部分：不带 indexed 的参数

13. 继承

- contract A3 is A1,A2// A3 继承 A1,A2,并且辈分 A1 更高  
  function FuncA3( ) public virtual override(A1, A2)
- virtual 虚函数关键字
- override 子合约重写了父合约的函数 关键字
- 用 override 修饰 public 变量，会重写与变量同名的 getter 函数
- 父合约的修饰器可以被继承（子合约里用父合约的 modifier，子合约的修饰器重写父合约的修饰器）
- 构造函数的继承

```solidity
// 构造函数的继承
abstract contract A {
    uint public a;
    constructor(uint _a) {
        a = _a;
    }
}
//子合约的构造函数
contract C is A {
    constructor(uint _c) A(_c * _c) {}//注意A在函数名的部分
}
```

- 调用父合约的函数
  - 直接调用：父合约名.函数名()
  - super.函数名()  
    调用**最近**的父合约函数
- 菱形继承  
  在多重+菱形继承链条上使用 super 关键字时，需要注意的是使用 super 会调用继承链条上的**每一个**合约的相关函数，而不是只调用最近的父合约。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {
    event Log(string message);

    function foo() public virtual {
        emit Log("God.foo called");
    }

    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {
    function foo() public virtual override {
        emit Log("Adam.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
```

### 2024.09.23

14. 抽象合约&接口

- 抽象合约：至少有一个 virtual 函数的，用于代码设计阶段。**抽象合约不能被直接部署**

```solidity
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```

- 接口：不实现任何功能，合约框架，编译接口可以得到合约 abi，比如 IERC721。只需要知道接口就可以交互而不需要知道具体代码实现

```solidity
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
}
```

使用接口：

```solidity
contract interactBAYC {
    // 利用BAYC地址创建接口合约变量（ETH主网）
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    // 通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOfBAYC(address owner) external view returns (uint256 balance){
        return BAYC.balanceOf(owner);
    }

    // 通过接口调用BAYC的safeTransferFrom()安全转账
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
        BAYC.safeTransferFrom(from, to, tokenId);
    }
}
```

15. 异常

- error 必须搭配 revert（回退）命令使用。推荐使用

```solidity
function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
        // revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```

- Require 是 solidity 0.8 版本之前抛出异常的常用方法，缺点就是 gas 随着描述异常的字符串长度增加，比 error 命令要高。使用方法：require(检查条件，"异常的描述")，
- assert 断言。一般用于 debug。用法：assrt(检查条件)，不能解释异常原因。Solidity **0.8.0 之前的版本**，assert 抛出的是一个 panic exception，会把剩余的 gas 全部消耗，**不会返还**。

### 2024.09.24

16. 函数重载：名字相同但入参不同，调用时根据不同参数选择执行哪个函数

- 装饰器 modifier 不能重载
- 如果出现多个匹配的重载函数，则会报错。

17. 库合约

- 一系列函数集合，方便实用，减少 gas，关键字 library。
  - 不能存在状态变量
  - 不能够继承或被继承
  - 不能接收以太币
  - 不可以被销毁
  - **尚未理解的：** 库合约重的函数可见性如果被设置为 public 或者 external，则在调用函数时会触发一次 delegatecall。而如果被设置为 internal，则不会引起。对于设置为 private 可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。
- 使用 常用的有：  
   Strings：将 uint256 转换为 String  
   Address：判断某个地址是否为合约地址  
   Create2：更安全的使用 Create2 EVM opcode  
   Arrays：跟数组相关的库合约

```solidity
// 方法一： 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}

// 方法二： 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```

18. 跨文件引用 import

- 在声明版本号之后，在其余代码之前。  
  可以引用的内容：  
  文件相对位置（import './Yeye.sol';）  
  网址源文件（import 'https://xxx/xxx.sol'）  
  npm(import @openzeppelin/xxx.sol)  
  全局符号（import {xxx as yyy} from './xxx.sol'

### 2024.09.25

19. 接收 eth

- 0.6 之前是 fallback(),之后拆分成 receive()和 fallback()
- receive():  
  合约收到 eth 时被调用  
  不要写太多逻辑，因为 transfer 发送 eth 的话限制 gas 2300

```solidity
event Received(address Sender, uint Value);// 定义事件

receive() external payable {// 接收ETH时释放Received事件
   emit Received(msg.sender, msg.value);
}
```

**有些恶意合约，会在 receive()/fallback() 函数，嵌入恶意消耗 gas 的内容或者使得执行故意失败的代码，导致一些包含退款和转账逻辑的合约不能正常工作**

- fallback()  
  在调用合约不存在的函数时被触发

  ```solidity
  event fallbackCalled(address Sender, uint Value, bytes Data);

  fallback() external payable{//释放事件
  emit fallbackCalled(msg.sender, msg.value, msg.data);
  }
  ```

- receive 和 fallback 区别

```graph
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
```

### 2024.09.26

20. 发送 eth

- transfer()，  
  gas 限制是 2300  
  失败自动 revert
- send()几乎没人用  
  gas 限制是 2300  
  不会 revert  
  返回 bool，代表成功/失败，需要额外代码处理下
- call()【推荐】
  没有 gas 限制  
  如果转账失败，不会 revert  
  返回值是(bool, bytes)，其中 bool 代表着转账成功或失败，需要额外代码处理一下

  ### 2024.09.27

<!-- Content_END -->

```

```
