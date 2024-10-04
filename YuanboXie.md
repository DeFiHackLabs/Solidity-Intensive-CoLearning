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
    - transfer 【不推荐，可能会被DoS】
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

- [102-22] Call
    - call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。
    - 不推荐用call来调用另一个合约，可能会导致安全问题。推荐的方法仍是声明合约变量后调用函数。
    ```solidity
    目标合约地址.call(字节码);
    目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
    // 字节码计算：abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
    ```
- [102-23] Delegatecall 【重要‼️】
    - delegate中是委托/代表的意思，那么delegatecall委托了什么？
        - 当用户A通过合约B来call合约C的时候，执行的是合约C的函数，上下文(Context，可以理解为包含变量和状态的环境)也是合约C的：msg.sender是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上;
        - 当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上;
        - 一个很好的比喻：
        > 一个投资者（用户A）把他的资产（B合约的状态变量）都交给一个风险投资代理（C合约）来打理。执行的是风险投资代理的函数，但是改变的是资产的状态。
    ```solidity
    目标合约地址.delegatecall(二进制编码);
    ```
    - delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额
    - 注意：delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。
    - 使用场景：
        - 代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。
        - EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。 [link](https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard)
- [102-24] 在合约中创建新合约：Create
    - `Contract x = new Contract{value: _value}(params)`
    - 使用场景：去中心化交易所 uniswap 利用工厂合约（PairFactory）创建了无数个币对合约（Pair）： [code](https://github.com/Uniswap/v2-core/tree/master/contracts)
        - UniswapV2Pair: 币对合约，用于管理币对地址、流动性、买卖。
        - UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。

### 2024.10.01

- [102-25] 在合约中创建新合约：Create2
    - CREATE2 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址。CREATE2 的目的是为了让合约地址独立于未来的事件。
    - 用CREATE2创建的合约地址由4个部分决定：`Contract x = new Contract{salt: _salt, value: _value}(params)`
        - 0xFF：一个常数，避免和CREATE冲突
        - CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
        - salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
        - initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
    - 提前计算地址：
        - 无参数：
        ```solidity
        // 计算合约地址方法 hash()
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(type(Pair).creationCode)
        )))));
        ```
        - 有参数：
        ```solidity
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
            )))));
        ```
    - 使用场景：
        - 交易所为新用户预留创建钱包合约地址。
    - Create VS Create2
        - create: `新地址 = hash(创建者地址, nonce)`。由于nonce不确定（你不知道你是第几个，因为别人也可能在调用）所以无法预测地址。
        - create2: `新地址 = hash("0xFF",创建者地址, salt, initcode)`。新合约的地址由创建者地址、salt值(一个256位的值)、合约字节码计算得出。可以预测出创造出的合约地址。
- [102-26] 删除合约：selfdestruct `selfdestruct(_addr)；`
    - selfdestruct 命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。selfdestruct 是为了应对合约出错的极端情况而设计的。它最早被命名为 suicide，但是这个词太敏感，改名为 selfdestruct。在 [v0.8.18](https://soliditylang.org/blog/2023/02/01/solidity-0.8.18-release-announcement/) 版本中，selfdestruct 关键字被标记为「不再建议使用」，在一些情况下它会导致预期之外的合约语义，但由于目前还没有代替方案，目前只是对开发者做了编译阶段的警告，相关内容可以查看 [EIP-6049](https://eips.ethereum.org/EIPS/eip-6049)。
    - 在以太坊坎昆（Cancun）升级中，EIP-6780 被纳入升级以实现对 Verkle Tree 更好的支持。EIP-6780 减少了 SELFDESTRUCT 操作码的功能。根据提案描述，当前 SELFDESTRUCT 仅会被用来将合约中的 ETH 转移到指定地址，而原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以目前来说：
        - 已经部署的合约无法被SELFDESTRUCT了。
        - 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。
- [102-27] ABI编码解码
    - ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。 [docs-abi_spec](https://learnblockchain.cn/docs/solidity/abi-spec.html)
    - 编码：
        - abi.encode: 非紧凑编码，每个类型的数据都填充到32bytes，与合约交互要用这个
        - abi.encodePacked：紧凑编码，用于算hash，长度比abi.encode短很多
        - abi.encodeWithSignature：与abi.encode功能类似，只不过第一个参数为函数签名。等同于在abi.encode编码结果前加上了4字节的函数选择器。`result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);`
        - abi.encodeWithSelector：与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器,`result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);`
    - 解码：abi.decode
        - `(dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));`

### 2024.10.02

- [102-28] Hash
    - 一个好的哈希函数应该具有以下几个特性：
        - 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
        - 灵敏性：输入的消息改变一点对它的哈希改变很大。
        - 高效性：从输入的消息到哈希的运算高效。
        - 均一性：每个哈希值被取到的概率应该基本相等。
        - 抗碰撞性：
            - 弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
            - 强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。
    - `哈希 = keccak256(数据);`
    - SHA3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。所以SHA3就和keccak计算的结果不一样。以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。
    - 使用场景：
        - 生成数据唯一标识：`keccak256(abi.encodePacked(_num, _string, _addr))`
- [102-29] 选择器
    - 调用智能合约时，本质上是向目标合约发送了一段 calldata。sg.data 是 Solidity 中的一个全局变量，值为完整的 calldata。
    - 在函数签名中，uint 和 int 要写为 uint256 和 int256。
    - 计算 method id 时，需要通过函数名和函数的参数类型来计算。在Solidity中，函数的参数类型主要分为：基础类型参数，固定长度类型参数，可变长度类型参数和映射类型参数。
        - `bytes4(keccak256("elementaryParamSelector(uint256,bool)"))`
        - `bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))`
        - `bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"))`
        - 映射类型参数通常有：contract、enum、struct等。在计算method id时，需要将该类型转化成为ABI类型。
        ```solidity
        contract DemoContract {
            // empty contract
        }

        contract Selector{
            // Struct User
            struct User {
                uint256 uid;
                bytes name;
            }
            // Enum School
            enum School { SCHOOL1, SCHOOL2, SCHOOL3 }
            ...
            // mapping（映射）类型参数selector
            // 输入：demo: 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99， user: [1, "0xa0b1"], count: [1,2,3], mySchool: 1
            // mappingParamSelector(address,(uint256,bytes),uint256[],uint8) : 0xe355b0ce
            function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
                emit SelectorEvent(this.mappingParamSelector.selector);
                return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
            }
            ...
        }
        ```
- [102-30] Try Catch
    - Solidity 0.6 版本添加了 try-catch。try-catch 只能被用于 external 函数或创建合约时 constructor（被视为 external 函数）的调用。
    ```solidity
    try externalContract.f() {
        // call成功的情况下 运行一些代码
    } catch {
        // call失败的情况下 运行一些代码
    }

    try externalContract.f() returns(returnType val) {
        // call成功的情况下 try模块中可以使用返回的变量,如果是创建合约，那么返回值是新创建的合约变量。
    } catch {
        // call失败的情况下 运行一些代码
    }

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
    ```
    - 可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。
    - try 代码块内的 revert 不会被 catch 本身捕获。

### 2024.10.03

- [103-31] ERC20
    - 来自15年V神参与的 [EIP-20](https://eips.ethereum.org/EIPS/eip-20)，实现了代币转账的基本逻辑。IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件。
        - 账户余额 balanceOf()
        - 转账 transfer()
        - 授权转账 transferFrom()
        - 授权 approve()
        - 代币总供给 totalSupply()
        - 授权转账额度 allowance()
        - 代币信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())
    - IERC20定义了2个事件：Transfer事件和Approval事件，分别在转账和授权时被释放
        - event Transfer(address indexed from, address indexed to, uint256 value);
        - event Approval(address indexed owner, address indexed spender, uint256 value);
    - IERC20定义了6个函数，提供了转移代币的基本功能
        - function totalSupply() external view returns (uint256);
        - function balanceOf(address account) external view returns (uint256);
        - function transfer(address to, uint256 amount) external returns (bool);
        - function allowance(address owner, address spender) external view returns (uint256); 返回`owner`账户授权给`spender`账户的额度
        - function approve(address spender, uint256 amount) external returns (bool); 授权
        - function transferFrom(address from,address to,uint256 amount) external returns (bool); 授权转账
    - 一般不自己手撸，而是基于 OpenZeppelin 模版改：[docs](https://docs.openzeppelin.com/contracts/5.x/erc20) [ERC20-template](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)
    - 本节示例代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/31_ERC20/ERC20.sol)，注意，这个示例代码是有安全问题的，这里仅供示范。
- [103-32] 代币水龙头:代币水龙头就是让用户免费领代币的网站/应用。
    - 示例代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/32_Faucet/Faucet.sol)，注意，这个示例代码是有安全问题的，这里仅供示范。
- [103-33] 空投合约
    - 因为每次接收空投的用户很多，项目方不可能一笔一笔的转账。利用智能合约批量发放ERC20代币，可以显著提高空投效率。
    ```solidity
    /// @notice 向多个地址转账ERC20代币，使用前需要先授权
    ///
    /// @param _token 转账的ERC20代币地址
    /// @param _addresses 空投地址数组
    /// @param _amounts 代币数量数组（每个地址的空投数量）
    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
        ) external {
        // 检查：_addresses和_amounts数组的长度相等
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        IERC20 token = IERC20(_token); // 声明IERC合约变量
        uint _amountSum = getSum(_amounts); // 计算空投代币总量
        // 检查：授权代币数量 >= 空投代币总量
        require(token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");

        // for循环，利用transferFrom函数发送空投
        for (uint8 i; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    /// 向多个地址转账ETH
    function multiTransferETH(
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) public payable {
        // 检查：_addresses和_amounts数组的长度相等
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        uint _amountSum = getSum(_amounts); // 计算空投ETH总量
        // 检查转入ETH等于空投总量
        require(msg.value == _amountSum, "Transfer amount error");
        // for循环，利用transfer函数发送ETH
        for (uint256 i = 0; i < _addresses.length; i++) {
            // 下面一行的注释代码有Dos攻击风险, 并且transfer也是不推荐写法
            // _addresses[i].transfer(_amounts[i]);
            (bool success, ) = _addresses[i].call{value: _amounts[i]}("");
            if (!success) {
                failTransferList[_addresses[i]] = _amounts[i];
            }
        }
    }
    ```



### 2024.10.04

- [103-34] ERC165, ERC721  
    - Ref: [EIP-165](https://eips.ethereum.org/EIPS/eip-165) [EIP721](https://eips.ethereum.org/EIPS/eip-721)
    - 通过ERC165标准，智能合约可以声明它支持的接口，供其他合约检查。 IERC165接口合约只声明了一个supportsInterface函数，输入要查询的interfaceId接口id，若合约实现了该接口id，则返回true：
    ```solidity
    interface IERC165 {
        function supportsInterface(bytes4 interfaceId) external view returns (bool);
    }
    // 0x80ac58cd= bytes4(keccak256(ERC721.Transfer.selector) ^ keccak256(ERC721.Approval.selector) ^ ··· ^keccak256(ERC721.isApprovedForAll.selector))，这是ERC165规定的计算方式。
    // ERC721 中实现 supportsInterface()函数
    function supportsInterface(bytes4 interfaceId) external pure override returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }
    ```
    - IERC721是ERC721标准的接口合约，规定了ERC721要实现的基本函数。它利用tokenId来表示特定的非同质化代币，授权或转账都要明确tokenId；而ERC20只需要明确转账的数额即可。
    ```solidity
    interface IERC721 is IERC165 {
        event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
        event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
        event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

        function balanceOf(address owner) external view returns (uint256 balance);

        function ownerOf(uint256 tokenId) external view returns (address owner);
        // 安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。
        function safeTransferFrom(
            address from,
            address to,
            uint256 tokenId,
            bytes calldata data // 重载函数，多了个参数
        ) external;
        // 安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。
        function safeTransferFrom(
            address from,
            address to,
            uint256 tokenId
        ) external;

        function transferFrom(
            address from,
            address to,
            uint256 tokenId
        ) external;

        function approve(address to, uint256 tokenId) external;

        function setApprovalForAll(address operator, bool _approved) external;

        function getApproved(uint256 tokenId) external view returns (address operator);

        function isApprovedForAll(address owner, address operator) external view returns (bool);
    }
    ```
    - 如果一个合约没有实现ERC721的相关函数，转入的NFT就进了黑洞，永远转不出来了。为了防止误转账，ERC721实现了safeTransferFrom()安全转账函数，目标合约必须实现了IERC721Receiver接口才能接收ERC721代币，不然会revert。IERC721Receiver接口只包含一个onERC721Received()函数。【这里的意思是表明接收ERC721的合约里自己声明了一个类似flag的东西，实际上处理逻辑并没有规范，没有要求转移NFT的逻辑要怎么写】
    ```solidity
    // ERC721接收者接口：合约必须实现这个接口来通过安全转账接收ERC721
    interface IERC721Receiver {
        function onERC721Received(
            address operator,
            address from,
            uint tokenId,
            bytes calldata data
        ) external returns (bytes4);
    }
    ```
    ERC721利用_checkOnERC721Received来确保目标合约实现了onERC721Received()函数（返回onERC721Received的selector）
    ```solidity
    function _checkOnERC721Received(
        address operator,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal {
        if (to.code.length > 0) {
            try IERC721Receiver(to).onERC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
                if (retval != IERC721Receiver.onERC721Received.selector) {
                    // Token rejected
                    revert IERC721Errors.ERC721InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    // non-IERC721Receiver implementer
                    revert IERC721Errors.ERC721InvalidReceiver(to);
                } else {
                    /// @solidity memory-safe-assembly
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        }
    }
    ```
    - IERC721Metadata是ERC721的拓展接口，实现了3个查询metadata元数据的常用函数：
    ```solidity
    interface IERC721Metadata is IERC721 {
        function name() external view returns (string memory);
        function symbol() external view returns (string memory);
        function tokenURI(uint256 tokenId) external view returns (string memory);
    }
    ```
    - ERC721主合约实现了IERC721，IERC165和IERC721Metadata定义的所有功能，包含4个状态变量和17个函数。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;

    import "./IERC165.sol";
    import "./IERC721.sol";
    import "./IERC721Receiver.sol";
    import "./IERC721Metadata.sol";
    import "./String.sol";

    contract ERC721 is IERC721, IERC721Metadata{
        using Strings for uint256; // 使用String库，

        // Token名称
        string public override name;
        // Token代号
        string public override symbol;
        // tokenId 到 owner address 的持有人映射
        mapping(uint => address) private _owners;
        // address 到 持仓数量 的持仓量映射
        mapping(address => uint) private _balances;
        // tokenID 到 授权地址 的授权映射
        mapping(uint => address) private _tokenApprovals;
        //  owner地址。到operator地址 的批量授权映射
        mapping(address => mapping(address => bool)) private _operatorApprovals;

        // 错误 无效的接收者
        error ERC721InvalidReceiver(address receiver);

        /**
        * 构造函数，初始化`name` 和`symbol` .
        */
        constructor(string memory name_, string memory symbol_) {
            name = name_;
            symbol = symbol_;
        }

        // 实现IERC165接口supportsInterface
        function supportsInterface(bytes4 interfaceId)
            external
            pure
            override
            returns (bool)
        {
            return
                interfaceId == type(IERC721).interfaceId ||
                interfaceId == type(IERC165).interfaceId ||
                interfaceId == type(IERC721Metadata).interfaceId;
        }

        // 实现IERC721的balanceOf，利用_balances变量查询owner地址的balance。
        function balanceOf(address owner) external view override returns (uint) {
            require(owner != address(0), "owner = zero address");
            return _balances[owner];
        }

        // 实现IERC721的ownerOf，利用_owners变量查询tokenId的owner。
        function ownerOf(uint tokenId) public view override returns (address owner) {
            owner = _owners[tokenId];
            require(owner != address(0), "token doesn't exist");
        }

        // 实现IERC721的isApprovedForAll，利用_operatorApprovals变量查询owner地址是否将所持NFT批量授权给了operator地址。
        function isApprovedForAll(address owner, address operator)
            external
            view
            override
            returns (bool)
        {
            return _operatorApprovals[owner][operator];
        }

        // 实现IERC721的setApprovalForAll，将持有代币全部授权给operator地址。调用_setApprovalForAll函数。
        function setApprovalForAll(address operator, bool approved) external override {
            _operatorApprovals[msg.sender][operator] = approved;
            emit ApprovalForAll(msg.sender, operator, approved);
        }

        // 实现IERC721的getApproved，利用_tokenApprovals变量查询tokenId的授权地址。
        function getApproved(uint tokenId) external view override returns (address) {
            require(_owners[tokenId] != address(0), "token doesn't exist");
            return _tokenApprovals[tokenId];
        }
        
        // 授权函数。通过调整_tokenApprovals来，授权 to 地址操作 tokenId，同时释放Approval事件。
        function _approve(
            address owner,
            address to,
            uint tokenId
        ) private {
            _tokenApprovals[tokenId] = to;
            emit Approval(owner, to, tokenId);
        }

        // 实现IERC721的approve，将tokenId授权给 to 地址。条件：to不是owner，且msg.sender是owner或授权地址。调用_approve函数。
        function approve(address to, uint tokenId) external override {
            address owner = _owners[tokenId];
            require(
                msg.sender == owner || _operatorApprovals[owner][msg.sender],
                "not owner nor approved for all"
            );
            _approve(owner, to, tokenId);
        }

        // 查询 spender地址是否可以使用tokenId（需要是owner或被授权地址）
        function _isApprovedOrOwner(
            address owner,
            address spender,
            uint tokenId
        ) private view returns (bool) {
            return (spender == owner ||
                _tokenApprovals[tokenId] == spender ||
                _operatorApprovals[owner][spender]);
        }

        /*
        * 转账函数。通过调整_balances和_owner变量将 tokenId 从 from 转账给 to，同时释放Transfer事件。
        * 条件:
        * 1. tokenId 被 from 拥有
        * 2. to 不是0地址
        */
        function _transfer(
            address owner,
            address from,
            address to,
            uint tokenId
        ) private {
            require(from == owner, "not owner");
            require(to != address(0), "transfer to the zero address");

            _approve(owner, address(0), tokenId);

            _balances[from] -= 1;
            _balances[to] += 1;
            _owners[tokenId] = to;

            emit Transfer(from, to, tokenId);
        }
        
        // 实现IERC721的transferFrom，非安全转账，不建议使用。调用_transfer函数
        function transferFrom(
            address from,
            address to,
            uint tokenId
        ) external override {
            address owner = ownerOf(tokenId);
            require(
                _isApprovedOrOwner(owner, msg.sender, tokenId),
                "not owner nor approved"
            );
            _transfer(owner, from, to, tokenId);
        }

        /**
        * 安全转账，安全地将 tokenId 代币从 from 转移到 to，会检查合约接收者是否了解 ERC721 协议，以防止代币被永久锁定。调用了_transfer函数和_checkOnERC721Received函数。条件：
        * from 不能是0地址.
        * to 不能是0地址.
        * tokenId 代币必须存在，并且被 from拥有.
        * 如果 to 是智能合约, 他必须支持 IERC721Receiver-onERC721Received.
        */
        function _safeTransfer(
            address owner,
            address from,
            address to,
            uint tokenId,
            bytes memory _data
        ) private {
            _transfer(owner, from, to, tokenId);
            _checkOnERC721Received(from, to, tokenId, _data);
        }

        /**
        * 实现IERC721的safeTransferFrom，安全转账，调用了_safeTransfer函数。
        */
        function safeTransferFrom(
            address from,
            address to,
            uint tokenId,
            bytes memory _data
        ) public override {
            address owner = ownerOf(tokenId);
            require(
                _isApprovedOrOwner(owner, msg.sender, tokenId),
                "not owner nor approved"
            );
            _safeTransfer(owner, from, to, tokenId, _data);
        }

        // safeTransferFrom重载函数
        function safeTransferFrom(
            address from,
            address to,
            uint tokenId
        ) external override {
            safeTransferFrom(from, to, tokenId, "");
        }

        /** 
        * 铸造函数。通过调整_balances和_owners变量来铸造tokenId并转账给 to，同时释放Transfer事件。铸造函数。通过调整_balances和_owners变量来铸造tokenId并转账给 to，同时释放Transfer事件。
        * 这个mint函数所有人都能调用，实际使用需要开发人员重写，加上一些条件。
        * 条件:
        * 1. tokenId尚不存在。
        * 2. to不是0地址.
        */
        function _mint(address to, uint tokenId) internal virtual {
            require(to != address(0), "mint to zero address");
            require(_owners[tokenId] == address(0), "token already minted");

            _balances[to] += 1;
            _owners[tokenId] = to;

            emit Transfer(address(0), to, tokenId);
        }

        // 销毁函数，通过调整_balances和_owners变量来销毁tokenId，同时释放Transfer事件。条件：tokenId存在。
        function _burn(uint tokenId) internal virtual {
            address owner = ownerOf(tokenId);
            require(msg.sender == owner, "not owner of token");

            _approve(owner, address(0), tokenId);

            _balances[owner] -= 1;
            delete _owners[tokenId];

            emit Transfer(owner, address(0), tokenId);
        }

        // _checkOnERC721Received：函数，用于在 to 为合约的时候调用IERC721Receiver-onERC721Received, 以防 tokenId 被不小心转入黑洞。
        function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory data) private {
            if (to.code.length > 0) {
                try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
                    if (retval != IERC721Receiver.onERC721Received.selector) {
                        revert ERC721InvalidReceiver(to);
                    }
                } catch (bytes memory reason) {
                    if (reason.length == 0) {
                        revert ERC721InvalidReceiver(to);
                    } else {
                        /// @solidity memory-safe-assembly
                        assembly {
                            revert(add(32, reason), mload(reason))
                        }
                    }
                }
            }
        }

        /**
        * 实现IERC721Metadata的tokenURI函数，查询metadata。
        */
        function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
            require(_owners[tokenId] != address(0), "Token Not Exist");

            string memory baseURI = _baseURI();
            return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
        }

        /**
        * 计算{tokenURI}的BaseURI，tokenURI就是把baseURI和tokenId拼接在一起，需要开发重写。
        * BAYC的baseURI为ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/ 
        */
        function _baseURI() internal view virtual returns (string memory) {
            return "";
        }
    }
    ```
    - ERC721标准仍在不断发展中，目前比较流行的版本为ERC721Enumerable（提高NFT可访问性）和ERC721A（节约铸造gas）。
- [103-35] 荷兰拍卖
    - 荷兰拍卖（Dutch Auction）是一种特殊的拍卖形式。 亦称“减价拍卖”，它是指拍卖标的的竞价由高到低依次递减直到第一个竞买人应价（达到或超过底价）时击槌成交的一种拍卖【标高价逐步减价，直到有人买】。很多 NFT 通过荷兰拍卖发售。
        - 荷兰拍卖的价格由最高慢慢下降，能让项目方获得最大的收入。
        - 拍卖持续较长时间（通常6小时以上），可以避免gas war。
    - 完整代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/35_DutchAuction/DutchAuction.sol)
    ```solidity
    uint256 public constant COLLECTOIN_SIZE = 10000; // NFT总数
    uint256 public constant AUCTION_START_PRICE = 1 ether; // 起拍价(最高价)
    uint256 public constant AUCTION_END_PRICE = 0.1 ether; // 结束价(最低价/地板价)
    uint256 public constant AUCTION_TIME = 10 minutes; // 拍卖时间，为了测试方便设为10分钟
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes; // 每过多久时间，价格衰减一次
    uint256 public constant AUCTION_DROP_PER_STEP =
        (AUCTION_START_PRICE - AUCTION_END_PRICE) /
        (AUCTION_TIME / AUCTION_DROP_INTERVAL); // 每次价格衰减步长
    
    uint256 public auctionStartTime; // 拍卖开始时间戳
    string private _baseTokenURI;   // metadata URI
    uint256[] private _allTokens; // 记录所有存在的tokenId 
    ````
    - 拍卖逻辑
    ```solidity
    // 获取拍卖实时价格
    function getAuctionPrice()
        public
        view
        returns (uint256)
    {
        if (block.timestamp < auctionStartTime) {
        return AUCTION_START_PRICE;
        }else if (block.timestamp - auctionStartTime >= AUCTION_TIME) {
        return AUCTION_END_PRICE;
        } else {
        uint256 steps = (block.timestamp - auctionStartTime) /
            AUCTION_DROP_INTERVAL;
        return AUCTION_START_PRICE - (steps * AUCTION_DROP_PER_STEP);
        }
    }
    ```
- [103-36] 默克尔树
    - 对于有 N 个叶子结点的 Merkle Tree，在已知 root 根值的情况下，验证某个数据是否有效（属于 Merkle Tree 叶子结点）只需要 ceil(log₂N) 个数据（也叫 merkle proof）。
    - ![](./content/YuanboXie/merkletree.png)
        - [website for merkle](https://lab.miguelmota.com/merkletreejs/example/)
        - [merkletreejs](https://github.com/merkletreejs/merkletreejs)
    - Solidity verify merkle proof
    ```solidity
    library MerkleProof {
        /**
        * @dev 当通过`proof`和`leaf`重建出的`root`与给定的`root`相等时，返回`true`，数据有效。
        * 在重建时，叶子节点对和元素对都是排序过的。
        */
        function verify(
            bytes32[] memory proof,
            bytes32 root,
            bytes32 leaf
        ) internal pure returns (bool) {
            return processProof(proof, leaf) == root;
        }

        /**
        * @dev Returns 通过Merkle树用`leaf`和`proof`计算出`root`. 当重建出的`root`和给定的`root`相同时，`proof`才是有效的。
        * 在重建时，叶子节点对和元素对都是排序过的。
        */
        function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
            bytes32 computedHash = leaf;
            for (uint256 i = 0; i < proof.length; i++) {
                computedHash = _hashPair(computedHash, proof[i]);
            }
            return computedHash;
        }

        // Sorted Pair Hash
        function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
            return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
        }
    }
    ```
    - 注意：_hashPair 里对 hash 进行了排序。因为 keccak256(abi.encodePacked(a, b)) 和 keccak256(abi.encodePacked(b, a)) 计算结果不一样，这里排序后，无论这个 _hashPair 先传 proof path 还是先传当前的 computedHash 都可以保证结果的一致性。当然我理解这里不排序也可以，就是proof计算需要和这个一致。排序的话容错性大一点点。
    - 应用场景：白名单，全量存白名单地址太费 gas。
    ```solidity
    contract MerkleTree is ERC721 {
        bytes32 immutable public root; // Merkle树的根
        mapping(address => bool) public mintedAddress;   // 记录已经mint的地址

        // 构造函数，初始化NFT合集的名称、代号、Merkle树的根
        constructor(string memory name, string memory symbol, bytes32 merkleroot)
        ERC721(name, symbol)
        {
            root = merkleroot;
        }

        // 利用Merkle树验证地址并完成mint
        function mint(address account, uint256 tokenId, bytes32[] calldata proof)
        external
        {
            require(_verify(_leaf(account), proof), "Invalid merkle proof"); // Merkle检验通过
            require(!mintedAddress[account], "Already minted!"); // 地址没有mint过
            _mint(account, tokenId); // mint
            mintedAddress[account] = true; // 记录mint过的地址
        }

        // 计算Merkle树叶子的哈希值
        function _leaf(address account)
        internal pure returns (bytes32)
        {
            return keccak256(abi.encodePacked(account));
        }

        // Merkle树验证，调用MerkleProof库的verify()函数
        function _verify(bytes32 leaf, bytes32[] memory proof)
        internal view returns (bool)
        {
            return MerkleProof.verify(proof, root, leaf);
        }
    }
    ```

<!-- Content_END -->
### 2024.10.05

- [103-37] 数字签名
    - 以太坊使用的数字签名算法叫双椭圆曲线数字签名算法（ECDSA），基于双椭圆曲线“私钥-公钥”对的数字签名算法。它主要起到了三个作用：
        - 身份认证：证明签名方是私钥的持有人。
        - 不可否认：发送方不能否认发送过这个消息。
        - 完整性：通过验证针对传输消息生成的数字签名，可以验证消息是否在传输过程中被篡改。
    - ECDSA标准中包含两个部分：
        - 签名者利用私钥（隐私的）对消息（公开的）创建签名（公开的）。
        - 其他人使用消息（公开的）和签名（公开的）恢复签名者的公钥（公开的）并验证签名。 
    - 以太坊消息签名；
        - 1.打包消息: 在以太坊的ECDSA标准中，被签名的消息是一组数据的keccak256哈希，为bytes32类型。我们可以把任何想要签名的内容利用abi.encodePacked()函数打包，然后用keccak256()计算哈希，作为消息。
        `keccak256(abi.encodePacked(_account, _tokenId))`
        - 2.计算以太坊签名消息: 消息可以是能被执行的交易，也可以是其他任何形式。为了避免用户误签了恶意交易，EIP191提倡在消息前加上"\x19Ethereum Signed Message:\n32"字符，并再做一次keccak256哈希，作为以太坊签名消息。
        `keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash))`
    - MetaMask 消息签名
    ```js
    ethereum.enable()
    account = "0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2"
    hash = "0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c"
    ethereum.request({method: "personal_sign", params: [account, hash]})
    ```
    - Web3.py 签名
    ```py
    from web3 import Web3, HTTPProvider
    from eth_account.messages import encode_defunct

    private_key = "0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b"
    address = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
    rpc = 'https://rpc.ankr.com/eth'
    w3 = Web3(HTTPProvider(rpc))

    #打包信息
    msg = Web3.solidity_keccak(['address','uint256'], [address,0])
    print(f"消息：{msg.hex()}")
    #构造可签名信息
    message = encode_defunct(hexstr=msg.hex())
    #签名
    signed_message = w3.eth.account.sign_message(message, private_key=private_key)
    print(f"签名：{signed_message['signature'].hex()}")
    ```
    - 验证签名
        - 通过签名和消息恢复公钥:签名是由数学算法生成的。这里我们使用的是rsv签名，签名中包含r, s, v三个值的信息。而后，我们可以通过r, s, v及以太坊签名消息来求得公钥。
        ```solidity
        // @dev 从_msgHash和签名_signature中恢复signer地址
        function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address){
            // 检查签名长度，65是标准r,s,v签名的长度
            require(_signature.length == 65, "invalid signature length");
            bytes32 r;
            bytes32 s;
            uint8 v;
            // 目前只能用assembly (内联汇编)来从签名中获得r,s,v的值
            assembly {
                /*
                前32 bytes存储签名的长度 (动态数组存储规则)
                add(sig, 32) = sig的指针 + 32
                等效为略过signature的前32 bytes
                mload(p) 载入从内存地址p起始的接下来32 bytes数据
                */
                // 读取长度数据后的32 bytes
                r := mload(add(_signature, 0x20)) // mload 从传入的地址向前读取32bytes，即[0,32)
                // 读取之后的32 bytes
                s := mload(add(_signature, 0x40))
                // 读取最后一个byte
                v := byte(0, mload(add(_signature, 0x60)))
            }
            // 使用ecrecover(全局函数)：利用 msgHash 和 r,s,v 恢复 signer 地址
            return ecrecover(_msgHash, v, r, s);
        }
        ```
        - 对比公钥并验证签名
        ```solidity
        /**
        * @dev 通过ECDSA，验证签名地址是否正确，如果正确则返回true
        * _msgHash为消息的hash
        * _signature为签名
        * _signer为签名地址
        */
        function verify(bytes32 _msgHash, bytes memory _signature, address _signer) internal pure returns (bool) {
            return recoverSigner(_msgHash, _signature) == _signer;
        }
        ```
    - 应用：基于 ECDSA 发放白名单。由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济。利用项目方账户把白名单发放地址签名（可以加上地址可以铸造的tokenId）。然后mint的时候利用ECDSA检验签名是否有效，如果有效，则给他mint。
    ```solidity
    contract SignatureNFT is ERC721 {
        address immutable public signer; // 签名地址
        mapping(address => bool) public mintedAddress;   // 记录已经mint的地址

        // 构造函数，初始化NFT合集的名称、代号、签名地址
        constructor(string memory _name, string memory _symbol, address _signer)
        ERC721(_name, _symbol)
        {
            signer = _signer;
        }

        // 利用ECDSA验证签名并mint
        function mint(address _account, uint256 _tokenId, bytes memory _signature)
        external
        {
            bytes32 _msgHash = getMessageHash(_account, _tokenId); // 将_account和_tokenId打包消息
            bytes32 _ethSignedMessageHash = ECDSA.toEthSignedMessageHash(_msgHash); // 计算以太坊签名消息
            require(verify(_ethSignedMessageHash, _signature), "Invalid signature"); // ECDSA检验通过
            require(!mintedAddress[_account], "Already minted!"); // 地址没有mint过
            _mint(_account, _tokenId); // mint
            mintedAddress[_account] = true; // 记录mint过的地址
        }

        /*
        * 将mint地址（address类型）和tokenId（uint256类型）拼成消息msgHash
        * _account: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        * _tokenId: 0
        * 对应的消息: 0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
        */
        function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
            return keccak256(abi.encodePacked(_account, _tokenId));
        }

        // ECDSA验证，调用ECDSA库的verify()函数
        function verify(bytes32 _msgHash, bytes memory _signature)
        public view returns (bool)
        {
            return ECDSA.verify(_msgHash, _signature, signer);
        }
    }
    ```
- [103-38] NFT交易所 [code](https://github.com/AmazingAng/WTF-Solidity/blob/main/38_NFTSwap/NFTSwap.sol)
    - 设计逻辑
    ```
    卖家：出售NFT的一方，可以挂单list、撤单revoke、修改价格update。
    买家：购买NFT的一方，可以购买purchase。
    订单：卖家发布的NFT链上订单，一个系列的同一tokenId最多存在一个订单，其中包含挂单价格price和持有人owner信息。当一个订单交易完成或被撤单后，其中信息清零。
    ```
    - Event
    ```solidity
    event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId);    
    event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice);
    ```
    - Order
    ```solidity
    // 定义order结构体
    struct Order{
        address owner;
        uint256 price; 
    }
    // NFT Order映射
    mapping(address => mapping(uint256 => Order)) public nftList; // nft_addr->token_id->order
    ```
    - Trade
    ```solidity
    // 挂单: 卖家上架NFT，合约地址为_nftAddr，tokenId为_tokenId，价格_price为以太坊（单位是wei）
    function list(address _nftAddr, uint256 _tokenId, uint256 _price) public{
        IERC721 _nft = IERC721(_nftAddr); // 声明IERC721接口合约变量
        require(_nft.getApproved(_tokenId) == address(this), "Need Approval"); // 合约得到授权
        require(_price > 0); // 价格大于0

        Order storage _order = nftList[_nftAddr][_tokenId]; //设置NF持有人和价格
        _order.owner = msg.sender;
        _order.price = _price;
        // 将NFT转账到合约
        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);

        // 释放List事件
        emit List(msg.sender, _nftAddr, _tokenId, _price);
    }
    // 撤单： 卖家取消挂单
    function revoke(address _nftAddr, uint256 _tokenId) public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中
        
        // 将NFT转给卖家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        delete nftList[_nftAddr][_tokenId]; // 删除order
      
        // 释放Revoke事件
        emit Revoke(msg.sender, _nftAddr, _tokenId);
    }
    // 调整价格: 卖家调整挂单价格
    function update(address _nftAddr, uint256 _tokenId, uint256 _newPrice) public {
        require(_newPrice > 0, "Invalid Price"); // NFT价格大于0
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.owner == msg.sender, "Not Owner"); // 必须由持有人发起
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中
        
        // 调整NFT价格
        _order.price = _newPrice;
      
        // 释放Update事件
        emit Update(msg.sender, _nftAddr, _tokenId, _newPrice);
    }
    // 购买: 买家购买NFT，合约为_nftAddr，tokenId为_tokenId，调用函数时要附带ETH
    function purchase(address _nftAddr, uint256 _tokenId) payable public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.price > 0, "Invalid Price"); // NFT价格大于0
        require(msg.value >= _order.price, "Increase price"); // 购买价格大于标价
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中

        // 将NFT转给买家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 将ETH转给卖家，多余ETH给买家退款
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // 删除order

        // 释放Purchase事件
        emit Purchase(msg.sender, _nftAddr, _tokenId, _order.price);
    }
    ```
- [103-39] 链上随机数
    - 由于以太坊上所有数据都是公开透明（public）且确定性（deterministic）的，它没法像其他编程语言一样给开发者提供生成随机数的方法。
    - 链上（哈希函数）：将一些链上的全局变量作为种子，利用keccak256()哈希函数来获取伪随机数。这是因为哈希函数具有灵敏性和均一性，可以得到“看似”随机的结果。
    ```solidity
    function getRandomOnchain() public view returns(uint256){
        // remix运行blockhash会报错
        bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));
        return uint256(randomBytes);
    }
    ```
    注意:，这个方法并不安全：首先，block.timestamp，msg.sender和blockhash(block.number-1)这些变量都是公开的，使用者可以预测出用这些种子生成出的随机数，并挑出他们想要的随机数执行合约。其次，矿工可以操纵blockhash和block.timestamp，使得生成的随机数符合他的利益。攻击[例子](https://forum.openzeppelin.com/t/understanding-the-meebits-exploit/8281)。
    - 链下（chainlink预言机）随机数生成：在链下生成随机数，然后通过预言机把随机数上传到链上。Chainlink 提供 VRF（可验证随机函数）服务，链上开发者可以支付 LINK 代币来获取随机数。
        - 用户合约继承VRFConsumerBaseV2；
        - 订阅chainlink，合约部署后，需要把合约加入到Subscription的Consumers中，才能发送申请；
        - 用户合约申请随机数；
        - Chainlink节点链下生成随机数和数字签名，并发送给 VRF 合约；
        - VRF合约验证签名有效性；
        - 用户合约接收并使用随机数；
    - 注意: 用户申请随机数时调用的requestRandomness()和VRF合约返回随机数时调用的回退函数fulfillRandomness()是两笔交易，调用者分别是用户合约和VRF合约，后者比前者晚几分钟（不同链延迟不一样）。
    - 完整代码参考: [code1](https://github.com/AmazingAng/WTF-Solidity/blob/main/39_Random/Random.sol) [code2](https://github.com/AmazingAng/WTF-Solidity/blob/main/39_Random/RandomNumberConsumer.sol)

### 2024.10.06

- [103-40] ERC1155 [eip-1155](https://eips.ethereum.org/EIPS/eip-1155)
    - 多代币标准ERC1155，允许一个合约包含多个同质化和非同质化代币。IERC1155接口合约抽象了EIP1155需要实现的功能，其中包含4个事件和6个函数。与ERC721不同，因为ERC1155包含多类代币，它实现了批量转账和批量余额查询，一次操作多种代币。
    - 区分ERC1155中的某类代币是同质化还是非同质化代币呢？其实很简单：如果某个id对应的代币总量为1，那么它就是非同质化代币，类似ERC721；如果某个id对应的代币总量大于1，那么他就是同质化代币，因为这些代币都分享同一个id，类似ERC20。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

    interface IERC1155 is IERC165 {
        event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);
        event TransferBatch(address indexed operator,address indexed from,address indexed to,uint256[] ids,uint256[] values);
        event ApprovalForAll(address indexed account, address indexed operator, bool approved);

        /**
        * @dev 当`id`种类的代币的URI发生变化时释放，`value`为新的URI
        */
        event URI(string value, uint256 indexed id);

        function balanceOf(address account, uint256 id) external view returns (uint256);

        /**
        * @dev 批量持仓查询，`accounts`和`ids`数组的长度要想等。
        */
        function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
            external
            view
            returns (uint256[] memory);

        function setApprovalForAll(address operator, bool approved) external;
        function isApprovedForAll(address account, address operator) external view returns (bool);

        /**
        * @dev 安全转账，将`amount`单位`id`种类的代币从`from`转账给`to`.
        * 释放{TransferSingle}事件.
        * 要求:
        * - 如果调用者不是`from`地址而是授权地址，则需要得到`from`的授权
        * - `from`地址必须有足够的持仓
        * - 如果接收方是合约，需要实现`IERC1155Receiver`的`onERC1155Received`方法，并返回相应的值
        */
        function safeTransferFrom(address from,address to,uint256 id,uint256 amount,bytes calldata data) external;

        /**
        * @dev 批量安全转账
        * 释放{TransferBatch}事件
        * 要求：
        * - `ids`和`amounts`长度相等
        * - 如果接收方是合约，需要实现`IERC1155Receiver`的`onERC1155BatchReceived`方法，并返回相应的值
        */
        function safeBatchTransferFrom(address from,address to,uint256[] calldata ids,uint256[] calldata amounts,bytes calldata data) external;
    }
    ```
    - IERC1155Receiver
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

    /**
    * @dev ERC1155接收合约，要接受ERC1155的安全转账，需要实现这个合约
    */
    interface IERC1155Receiver is IERC165 {
        /**
        * @dev 接受ERC1155安全转账`safeTransferFrom` 
        * 需要返回 0xf23a6e61 或 `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
        */
        function onERC1155Received(
            address operator,
            address from,
            uint256 id,
            uint256 value,
            bytes calldata data
        ) external returns (bytes4);

        /**
        * @dev 接受ERC1155批量安全转账`safeBatchTransferFrom` 
        * 需要返回 0xbc197c81 或 `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
        */
        function onERC1155BatchReceived(
            address operator,
            address from,
            uint256[] calldata ids,
            uint256[] calldata values,
            bytes calldata data
        ) external returns (bytes4);
    }
    ```
    - ERC-1155 主合约 [code](https://github.com/AmazingAng/WTF-Solidity/blob/main/40_ERC1155/ERC1155.sol)
- [103-41] WETH
    - WETH (Wrapped ETH)是ETH的带包装版本。我们常见的WETH，WBTC，WBNB，都是带包装的原生代币。为什么要包装它们？以太币本身并不符合ERC20标准。WETH的开发是为了提高区块链之间的互操作性 ，并使ETH可用于去中心化应用程序（dApps）。它就像是给原生代币穿了一件智能合约做的衣服：穿上衣服的时候，就变成了WETH，符合ERC20同质化代币标准，可以跨链，可以用于dApp；脱下衣服，它可1:1兑换ETH。
    - WETH 符合 ERC20标准，它比普通的 ERC20 多了两个功能：
        - 存款：包装，用户将ETH存入WETH合约，并获得等量的WETH。
        - 取款：拆包装，用户销毁WETH，并获得等量的ETH。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    contract WETH is ERC20{
        // 事件：存款和取款
        event  Deposit(address indexed dst, uint wad);
        event  Withdrawal(address indexed src, uint wad);

        // 构造函数，初始化ERC20的名字和代号
        constructor() ERC20("WETH", "WETH"){
        }

        // 回调函数，当用户往WETH合约转ETH时，会触发deposit()函数
        fallback() external payable {
            deposit();
        }
        // 回调函数，当用户往WETH合约转ETH时，会触发deposit()函数
        receive() external payable {
            deposit();
        }

        // 存款函数，当用户存入ETH时，给他铸造等量的WETH
        function deposit() public payable {
            _mint(msg.sender, msg.value);
            emit Deposit(msg.sender, msg.value);
        }

        // 提款函数，用户销毁WETH，取回等量的ETH
        function withdraw(uint amount) public {
            require(balanceOf(msg.sender) >= amount);
            _burn(msg.sender, amount);
            payable(msg.sender).transfer(amount);
            emit Withdrawal(msg.sender, amount);
        }
    }
    ```
- [103-42] 分账
    - 分账就是按照一定比例分钱财。分账合约(PaymentSplit)允许将ETH按权重转给一组账户中，进行分账。
    - 分账合约具有以下几个特点：
        1. 创建合约时定好分账受益人 payees 和每人的份额 shares;
        2. 份额可以是相等，也可以是其他任意比例。
        3. 该合约收到的所有 ETH 中，每个受益人将能够提取与其分配的份额成比例的金额;
        4. 分账合约遵循 Pull Payment 模式，付款不会自动转入账户，而是保存在此合约中。受益人通过调用 release() 函数触发实际转账;
    - 完整代码: [code](https://github.com/AmazingAng/WTF-Solidity/blob/main/42_PaymentSplit/PaymentSplit.sol)
    ```solidity
    function releasable(address _account) public view returns (uint256) {
        // 计算分账合约总收入totalReceived
        uint256 totalReceived = address(this).balance + totalReleased;
        // 调用_pendingPayment计算account应得的ETH
        return pendingPayment(_account, totalReceived, released[_account]);
    }
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // account应得的ETH = 总应得ETH - 已领到的ETH
        return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased;
    }
    ```

### 2024.10.07

- [103-43] 线性释放
    - 代币归属条款，并写一个线性释放ERC20代币的合约。代码由OpenZeppelin的VestingWallet合约简化而来。在传统金融领域，一些公司会向员工和管理层提供股权。但大量股权同时释放会在短期产生抛售压力，拖累股价。因此，公司通常会引入一个归属期来延迟承诺资产的所有权。同样的，在区块链领域，Web3初创公司会给团队分配代币，同时也会将代币低价出售给风投和私募。如果他们把这些低成本的代币同时提到交易所变现，币价将被砸穿，散户直接成为接盘侠。所以，项目方一般会约定代币归属条款（token vesting），在归属期内逐步释放代币，减缓抛压。
    - 线性释放：代币在归属期内匀速释放。
    - 锁仓并线性释放ERC20代币的合约TokenVesting：
        - 项目方规定线性释放的起始时间、归属期和受益人。
        - 项目方将锁仓的ERC20代币转账给TokenVesting合约。
        - 受益人可以调用release函数，从合约中取出释放的代币。
    - 代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/43_TokenVesting/TokenVesting.sol)
    ```solidity
    function release(address token) public {
        // 调用vestedAmount()函数计算可提取的代币数量
        uint256      = vestedAmount(token, uint256(block.timestamp)) - erc20Released[token];
        // 更新已释放代币数量   
        erc20Released[token] += releasable; 
        // 转代币给受益人
        emit ERC20Released(token, releasable);
        IERC20(token).transfer(beneficiary, releasable);
    }

    function vestedAmount(address token, uint256 timestamp) public view returns (uint256) {
        // 合约里总共收到了多少代币（当前余额 + 已经提取）
        uint256 totalAllocation = IERC20(token).balanceOf(address(this)) + erc20Released[token];
        // 根据线性释放公式，计算已经释放的数量
        if (timestamp < start) {
            return 0;
        } else if (timestamp > start + duration) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start)) / duration;
        }
    }
    ```
    - 分析一下：`IERC20(token).balanceOf(address(this)) + erc20Released[token];`这样写和直接写死总数的区别是lock之后可以新加入的token也会按照这个规则vest，如果写死的话，新的token打进这个地址会被锁死导致无法vest。
- [103-44] 代币锁
    - 流动性提供者LP代币、锁定流动性、ERC20代币锁合约
    - 代币锁(Token Locker)是一种简单的时间锁合约，它可以把合约中的代币锁仓一段时间，受益人在锁仓期满后可以取走代币。代币锁一般是用来锁仓流动性提供者LP代币的。
        - 用户在去中心化交易所DEX上交易代币，例如Uniswap交易所。DEX和中心化交易所(CEX)不同，去中心化交易所使用自动做市商(AMM)机制，需要用户或项目方提供资金池，以使得其他用户能够即时买卖。简单来说，用户/项目方需要质押相应的币对（比如 ETH/DAI）到资金池中，作为补偿，DEX 会给他们铸造相应的流动性提供者 LP 代币凭证，证明他们质押了相应的份额，供他们收取手续费。
        - 如果项目方毫无征兆的撤出流动性池中的 LP 代币，那么投资者手中的代币就无法变现，直接归零了。这种行为也叫 rug-pull。如果 LP 代币是锁仓在代币锁合约中，在锁仓期结束以前，项目方无法撤出流动性池，也没办法 rug pull。因此代币锁可以防止项目方过早跑路（要小心锁仓期满跑路的情况）。
    - TokenLocker
        - 开发者在部署合约时规定锁仓的时间，受益人地址，以及代币合约。
        - 开发者将代币转入TokenLocker合约。
        - 在锁仓期满，受益人可以取走合约里的代币。
    ```solidity
    constructor(
        IERC20 token_,
        address beneficiary_,
        uint256 lockTime_
    ) {
        require(lockTime_ > 0, "TokenLock: lock time should greater than 0");
        token = token_;
        beneficiary = beneficiary_;
        lockTime = lockTime_;
        startTime = block.timestamp;

        emit TokenLockStart(beneficiary_, address(token_), block.timestamp, lockTime_);
    }

    function release() public {
        require(block.timestamp >= startTime+lockTime, "TokenLock: current time is before release time");

        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");

        token.transfer(beneficiary, amount);

        emit Release(msg.sender, address(token), block.timestamp, amount);
    }
    ```
- [103-45] 时间锁
    - 简化自 Compound 的 [Timelock 合约](https://github.com/compound-finance/compound-protocol/blob/master/contracts/Timelock.sol)
    - 时间锁（Timelock）是银行金库和其他高安全性容器中常见的锁定机制。它是一种计时器，旨在防止保险箱或保险库在预设时间之前被打开，即便开锁的人知道正确密码。时间锁被DeFi和DAO大量采用。它是一段代码，他可以将智能合约的某些功能锁定一段时间。它可以大大改善智能合约的安全性，举个例子，假如一个黑客黑了Uniswap的多签，准备提走金库的钱，但金库合约加了2天锁定期的时间锁，那么黑客从创建提钱的交易，到实际把钱提走，需要2天的等待期。在这一段时间，项目方可以找应对办法，投资者可以提前抛售代币减少损失。
    - Timelock：
        - 创建交易，并加入到时间锁队列。
        - 在交易的锁定期满后，执行交易。
        - 后悔了，取消时间锁队列中的某些交易。
    - 项目方一般会把时间锁合约设为重要合约的管理员，例如金库合约，再通过时间锁操作他们。时间锁合约的管理员一般为项目的多签钱包，保证去中心化。
    ```solidity
    /**
     * @dev 创建交易并添加到时间锁队列中。
     * @param target: 目标合约地址
     * @param value: 发送eth数额
     * @param signature: 要调用的函数签名（function signature）
     * @param data: call data，里面是一些参数
     * @param executeTime: 交易执行的区块链时间戳
     *
     * 要求：executeTime 大于 当前区块链时间戳+delay
     */
    function queueTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner returns (bytes32) {
        // 检查：交易执行时间满足锁定时间
        require(executeTime >= getBlockTimestamp() + delay, "Timelock::queueTransaction: Estimated execution block must satisfy delay.");
        // 计算交易的唯一识别符：一堆东西的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 将交易添加到队列
        queuedTransactions[txHash] = true;

        emit QueueTransaction(txHash, target, value, signature, data, executeTime);
        return txHash;
    }
    function cancelTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner{
        // 计算交易的唯一识别符：一堆东西的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 检查：交易在时间锁队列中
        require(queuedTransactions[txHash], "Timelock::cancelTransaction: Transaction hasn't been queued.");
        // 将交易移出队列
        queuedTransactions[txHash] = false;
        emit CancelTransaction(txHash, target, value, signature, data, executeTime);
    }
    function executeTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public payable onlyOwner returns (bytes memory) {
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 检查：交易是否在时间锁队列中
        require(queuedTransactions[txHash], "Timelock::executeTransaction: Transaction hasn't been queued.");
        // 检查：达到交易的执行时间
        require(getBlockTimestamp() >= executeTime, "Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
        // 检查：交易没过期
       require(getBlockTimestamp() <= executeTime + GRACE_PERIOD, "Timelock::executeTransaction: Transaction is stale.");
        // 将交易移出队列
        queuedTransactions[txHash] = false;

        // 获取call data
        bytes memory callData;
        if (bytes(signature).length == 0) {
            callData = data;
        } else {
        // 这里如果采用encodeWithSignature的编码方式来实现调用管理员的函数，请将参数data的类型改为address。不然会导致管理员的值变为类似"0x0000000000000000000000000000000000000020"的值。其中的0x20是代表字节数组长度的意思.
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
        }
        // 利用call执行交易
        (bool success, bytes memory returnData) = target.call{value: value}(callData);
        require(success, "Timelock::executeTransaction: Transaction execution reverted.");

        emit ExecuteTransaction(txHash, target, value, signature, data, executeTime);

        return returnData;
    }
    ```
### 2024.10.08

- [103-46] 代理合约
- [103-47] 可升级合约
- [103-48] 透明代理

### 2024.10.09

- [103-49] 通用可升级代理
- [103-50] 多签钱包
- [103-51] ERC4626代币化金库标准

### 2024.10.10

- [103-52] EIP712 类型化数据签名
- [103-53] ERC-2612 ERC20Permit
- [103-54] 跨链桥

### 2024.10.11

- [103-55] 多重调用
- [103-56] 去中心化交易所
- [103-57] 闪电贷

### 2024.10.12

- [104-S01] 重入攻击
- [104-S02] 选择器碰撞
- [104-S03] 中心化风险

### 2024.10.13

- [104-S04] 权限管理漏洞
- [104-S05] 整型溢出
- [104-S06] 签名重放

### 2024.10.14

- [104-S07] 坏随机数
- [104-S08] 绕过合约检查
- [104-S09] 拒绝服务

### 2024.10.15

- [104-S10] 貔貅
- [104-S11] 抢先交易
- [104-S12] tx.origin 钓鱼攻击

### 2024.10.16

- [104-S13] 未检查的低级调用
- [104-S14] 操纵区块时间
- [104-S15] 操纵预言机
- [104-S16] NFT重入攻击
- [104-S17] “跨服”重入攻击