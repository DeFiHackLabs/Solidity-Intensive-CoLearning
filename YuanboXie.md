---
timezone: Asia/Shanghai
---

---

# YuanboXie

1. 自我介绍: Web3 & AI researcher

2. 你认为你会完成本次残酷学习吗？大概率可以
   
## Notes

- WTF Academy Solidity 101 1-15
- WTF Academy Solidity 102 16-30
- WTF Academy Solidity 103 31-50
- 完成取得 Solidity 101、102 链上证书

<!-- Content_START -->

### 2024.09.23

之前看过这个，但好久没写又忘了。今天重新捡起来复习一下。

- [101-1] 测试题有个地方第一遍打错了：`带有 pragma solidity ^0.8.4; 的智能合约能否被 solidity 0.8版本编译？`，答案是不行，这个0.8.4是只能被>=0.8.4的编译
- [101-2] 类型：value type、reference type、mapping type;
    - solidity 特殊类型：address，以及 payable address: `payable(address)`,后者比普通地址多了 transfer 和 send 方法, 以及可以通过 `address.balance` 查询余额;
    - 定长字节数组、不定长字节数组
    - enum

```solidity
address payable addr;
addr.transfer(1); // 注意这个是从合约给 addr 转账的意思，单位是 wei
```

- [101-3] function: 
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- {internal|external|public|private}：可见性，合约中定义的函数需要明确指定可见性，它们没有默认值。public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
    - public：内部和外部均可见。
    - private：只能从本合约内部访问，继承的合约也不能使用。
    - external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
    - internal: 只能从合约内部访问，继承的合约可以用。
- [pure|view|payable]：决定函数权限/功能的关键字。
    - pure: 既不能读取也不能写入链上的状态变量;【这个一定要记住，这个容易记错！】
    - view: 能读取但也不能写入状态变量;
    - payable: 带 payable 的 function 可以存 ether;

以太坊交易需要支付 gas fee。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

### 2024.09.24

- [101-4] 函数输出
- Solidity 中与函数输出相关的有两个关键字：return和returns。它们的区别在于：
    - returns：跟在函数名后面，用于声明返回的变量类型及变量名。
        - 命名式返回
    - return：用于函数主体中，返回指定的变量。
```solidity
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){ // 数组类型返回值默认必须用 memory 修饰
    return(1, true, [uint256(1),2,5]);
}
```
- 解构赋值:
```solidity
(_number, _bool, _array) = returnNamed();
(, _bool2, ) = returnNamed();
```
- [101-5] 变量数据存储和作用域 storage/memory/calldata
- 引用类型(Reference Type)：包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。
- Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。
    - storage：合约里的状态变量默认都是storage，存储在链上。
    - memory：函数里的参数和临时变量一般用 memory，存储在内存中，不上链。如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
    - calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改，一般用于函数的参数。
- 在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。
```solidity
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    uint[] memory xMemory = x; // memory 不会修改 storage 所以不是引用，此外 memory 赋值给 memory，会创建引用，改变新变量会影响原变量。
    xStorage[0] = 100;
}
```
- 全局变量、局部变量、状态变量
    - 全局变量：都是solidity预留关键字。他们可以在函数内不声明直接使用。 详细查看: [docs](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
        - msg.sender
        - block.number
        - msg.data
        - blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
        - block.coinbase: (address payable) 当前区块矿工的地址
        - block.gaslimit: (uint) 当前区块的gaslimit
        - block.number: (uint) 当前区块的number
        - block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
        - gasleft(): (uint256) 剩余 gas
        - msg.data: (bytes calldata) 完整call data
        - msg.sender: (address payable) 消息发送者 (当前 caller)
        - msg.sig: (bytes4) calldata的前四个字节 (function identifier)
        - msg.value: (uint) 当前交易发送的 wei 值
        - block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
        - blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。
- 货币单位
    - wei: 1
    - gwei: 1e9 = 1000000000
    - ether: 1e18 = 1000000000000000000
- 时间单位
    - 1 seconds: 1
    - 1 minutes: 60 seconds = 60
    - 1 hours: 60 minutes = 3600
    - 1 days: 24 hours = 86400
    - 1 weeks: 7 days = 604800

- [101-6] array、struct
    - 固定长数组、变长数组
        - bytes 比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
        - 对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。
        ```solidity
        // memory动态数组
        uint[] memory array8 = new uint[](5);
        bytes memory array9 = new bytes(9);
        ```
        - array.length
        - 动态数组
            - array.push()
            - array.pop()

### 2024.09.25

- [101-7] mapping(_KeyType => _ValueType)
    - key 只能是 solidity 内置的值类型，value 可以是自定义 struct；mapping 不能用于 public 函数的参数或返回结果中；mapping 的存储位置必须是 storage; mapping 没有 .length;
    - Ethereum 会定义所有未使用的空间为 0，所以未赋值（Value）的键（Key）初始值都是各个 type 的默认值，如 uint 的默认值是 0;
- [101-8] delete 会让变量变为初始值;
- [101-9] Const & immutable
    - 数值变量可以声明 constant 和 immutable; string 和 bytes 可以声明为 constant，但不能为 immutable;
    - constant 变量必须在声明的时候初始化，之后再也不能改变;
    - immutable 变量可以在声明时或构造函数中初始化，因此更加灵活。在 Solidity v8.0.21 以后，immutable 变量不需要显式初始化。反之，则需要显式初始化。 若 immutable 变量既在声明时初始化，又在 constructor 中初始化，会使用 constructor 初始化的值;

### 2024.09.26

- [101-10] 控制流: if-else, for, while, do-while
- [101-11] 构造函数、修饰器
    - 在Solidity 0.4.22之前，构造函数不使用 constructor 而是使用与合约名同名的函数作为构造函数而使用，由于这种旧写法容易使开发者在书写时发生疏漏（例如合约名叫 Parents，构造函数名写成 parents），使得构造函数变成普通函数，引发漏洞，所以0.4.22版本及之后，采用了全新的 constructor 写法;
    - 新版构造函数: `constructor(){}` 构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次;
    - Modifier 修饰器:明函数拥有的特性，并减少代码冗余,使用场景是运行函数前的检查，例如地址，变量，余额等;
    ```solidity
    // 定义modifier
    modifier onlyOwner {
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }
    function changeOwner(address _newOwner) external onlyOwner{
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
    }
    ```
    - OpenZeppelin的Ownable标准实现: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
- [101-12] Event
    - Solidity中的事件（event）是EVM上日志的抽象,事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。
    ```solidity
    event Transfer(address indexed from, address indexed to, uint256 value);
    // indexed: 会保存在以太坊虚拟机日志的topics中，方便之后检索
    ```
    - 以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。![](./content/YuanboXie/evm-log.png)
        - 日志的第一部分是主题数组，用于描述事件，长度不能超过4。它的第一个元素是事件的签名（哈希）。对于上面的Transfer事件，它的事件哈希就是：keccak256("Transfer(address,address,uint256)")
        - 除了事件哈希，主题还可以包含至多3个indexed参数，也就是Transfer事件中的from和to。indexed标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个 indexed 参数的大小为固定的256比特，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

### 2024.09.27

- [101-13] 继承：Solidity中的修饰器（Modifier）同样可以继承，用法与函数继承类似，在相应的地方加virtual和override关键字即可。
    - virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
    - override：子合约重写了父合约中的函数，需要加上override关键字。用override修饰public变量，会重写与变量同名的getter函数。
    - 多重继承
        - Solidity的合约可以继承多个合约。继承时要按辈分最高到最低的顺序排。
        - 如果某一个函数在多个继承的合约里都存在，在子合约里必须重写，不然会报错。
        - 重写在多个父合约中都重名的函数时，override 关键字后面要加上所有父合约名字。
    - 构造函数的继承
        - 方法一：在继承时声明父构造函数的参数，例如：contract B is A(1)
        - 在子合约的构造函数中声明构造函数的参数，例如：
        ```solidity
        contract C is A {
            constructor(uint _c) A(_c * _c) {}
        }
        ```
    - 调用父合约的函数
        - 直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数;
        - super.函数名():
        - 钻石继承/菱形继承：一个派生类同时有两个或两个以上的基类。
        ```solidity
        /* 继承树：
        God
        /  \
        Adam Eve
        \  /
        people
        */
        contract people is Adam, Eve{}
        // 调用合约people中的super.func()会依次调用Eve、Adam，最后是God合约。
        ```
- [101-14] 抽象合约和接口
    - 如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为abstract，不然编译会报错；另外，未实现的函数需要加virtual，以便子合约重写。
    - 接口类似于抽象合约，但它不实现任何功能。接口的规则：
        - 不能包含状态变量、不能包含构造函数、不能继承除接口外的其他合约、所有函数都必须是external且不能有函数体、继承接口的非抽象合约必须实现接口定义的所有功能。
    - 接口提供了两个重要的信息：
        - 合约里每个函数的bytes4选择器，以及函数签名函数名（每个参数类型）;
        - 接口id [eip-165](https://eips.ethereum.org/EIPS/eip-165);
        - 接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用[abi-to-sol](https://gnidan.github.io/abi-to-sol/)工具，也可以将ABI json文件转换为接口sol文件。接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。
        ```solidity
        interface IERC721 is IERC165 {
            event Transfer(address indexed from, address indexed to, uint256 indexed tokenId); // 在转账时被释放，记录代币的发出地址from，接收地址to和tokenId。
            event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId); // 在授权时被释放，记录授权地址owner，被授权地址approved和tokenId。
            event ApprovalForAll(address indexed owner, address indexed operator, bool approved); // 在批量授权时被释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。
            function balanceOf(address owner) external view returns (uint256 balance); // 返回某地址的NFT持有量balance。
            function ownerOf(uint256 tokenId) external view returns (address owner); // 返回某tokenId的主人owner。
            function safeTransferFrom(address from, address to, uint256 tokenId) external; // 安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。
            function transferFrom(address from, address to, uint256 tokenId) external; // 普通转账，参数为转出地址from，接收地址to和tokenId。
            function approve(address to, uint256 tokenId) external; // 授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
            function getApproved(uint256 tokenId) external view returns (address operator); // 查询tokenId被批准给了哪个地址。
            function setApprovalForAll(address operator, bool _approved) external; // 将自己持有的该系列NFT批量授权给某个地址operator。
            function isApprovedForAll(address owner, address operator) external view returns (bool); // 查询某地址的NFT是否批量授权给了另一个operator地址。
            function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external; // 安全转账的重载函数，参数里面包含了data。
        }
        ```
        - 如果我们知道一个合约实现了IERC721接口，我们不需要知道它具体代码实现，就可以与它交互。
- [101-15] 异常：error，require和assert
    - Error: solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。人们可以在contract之外定义异常。
    ```solidity
    error TransferNotOwner(address sender); // 自定义的带参数的error
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if(_owners[tokenId] != msg.sender){
            revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }
    ```
    - Require: solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加，比error命令要高
    - assert命令一般用于程序员写程序debug，因为它不能解释抛出异常的原因（比require少个字符串）。它的用法很简单，assert(检查条件），当检查条件不成立的时候，就会抛出异常。
    - 三种方法的gas比较:error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas。

### 2024.09.28

- [102-16] 函数重载: Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。
    - 重载函数在经过编译器编译后，由于不同的参数类型，都变成了不同的函数选择器（selector）
    - 实参匹配（Argument Matching）：在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。
    ```solidity
    // f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。
    function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
    }

    function f(uint256 _in) public pure returns (uint256 out) {
        out = _in;
    }
    ```
- [102-17] 库合约
    - 和普通合约主要有以下几点不同：
        - 不能存在状态变量、不能够继承或被继承、不能接收以太币、不可以被销毁
    - 库合约中的函数可见性如果被设置为 public 或者 external，则在调用函数时会触发一次 delegatecall。而如果被设置为 internal，则不会引起。对于设置为 private 可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。
    - 如何使用库合约：
        - using for：用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数;
        ```solidity
        // 利用using for指令
        using Strings for uint256;
        function getString1(uint256 _number) public pure returns(string memory){
            // 库合约中的函数会自动添加为uint256型变量的成员
            return _number.toHexString();
        }
        ```
        - 通过库合约名称调用函数
        ```solidity
        // 直接通过库合约名调用
        function getString2(uint256 _number) public pure returns(string memory){
            return Strings.toHexString(_number);
        }
        ```
    - 常用库：
        - [Strings](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Strings.sol)
        - [Address](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Address.sol)
        - [Create2](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Create2.sol)
        - [Arrays](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Arrays.sol)
- [102-18] Import
```solidity
文件结构
├── Import.sol
└── Yeye.sol

// 通过文件相对位置import
import './Yeye.sol';
import {Yeye} from './Yeye.sol';

// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

// 通过npm的目录导入
import '@openzeppelin/contracts/access/Ownable.sol';
```

### 2024.09.29
- [102-19] 接收 ETH
    - Solidity支持两种特殊的回调函数，receive()和fallback(),主要用于两种场景：1）接收 ETH；2）处理合约中不存在的函数调用（代理合约 proxy contract）;
    - 注意：在Solidity 0.6.x版本之前，语法上只有 fallback() 函数，用来接收用户发送的ETH时调用以及在被调用函数签名没有匹配到时，来调用。 0.6版本之后，Solidity才将 fallback() 函数拆分成 receive() 和 fallback() 两个函数。
    - receive()
        - 一个合约最多有一个receive()函数,receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。
        - receive()最好不要执行太多的逻辑因为如果别人用send和transfer方法发送ETH的话，gas会限制在2300，receive()太复杂可能会触发Out of Gas报错；如果用call就可以自定义gas执行更复杂的逻辑。
    - fallback()
        - fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。一般也会用payable修饰。
    - 【提醒】有些恶意合约，会在receive()/fallback() 函数嵌入恶意消耗gas的内容或者使得执行故意失败的代码，导致一些包含退款和转账逻辑的合约不能正常工作，因此写包含退款等逻辑的合约时候，一定要注意这种情况。
    - receive() vs fallback()
        - receive和fallback都能够用于接收ETH，他们触发的规则如下：
        ```
        触发fallback() 还是 receive()?
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
        - receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错（但可以通过合约里带有payable的其他函数发送ETH）。
- [102-20] 发送ETH:transfer()，send()和call()
    - transfer
        - 接收方地址.tranfer(eth_amount)
        - gas limit 2300
        - 转账失败会 revert
    - send 【不推荐】
        - 接收方地址.send(eth_amount)
        - gas limit 2300
        - 转账失败不会 revert
        - 返回值：bool
    - call
        - 接收方地址.call{value: eth_amount}("")
        - 无 gas 限制
        - 转账失败不会 revert
        - call()的返回值是(bool, bytes)
    - 一个习题：EOA调用合约A的sendeth函数给合约b发eth，合约a、b均无eth。这里的执行逻辑是先把交易带的eth加到合约a上，所以sendeth不会revert。
- [102-21] 调用其他合约
    - 传入合约地址：OtherContract(_Address).setX(x);
    - 合约变量：OtherContract _Address （本质上还是address）
### 2024.09.30

- [102-22] 
- [102-23]
- [102-24] 

<!-- Content_END -->