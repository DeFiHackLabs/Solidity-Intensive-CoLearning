---
timezone: Asia/Shanghai
---

# ruoshui

come on
   
## Notes

<!-- Content_START -->

### 2024.09.23
1、在 Remix 中使用整型运算时，运算符红色，结果编译正常，还以为是错误了呢

2、用 ai 查询了下 uint 和 unit256 的区别，说是没啥区别，使用起来是一样的

3、用 payable 修饰的 address 类型多了 `transfer` 和 `send` 方法 

4、bytes32 最多存储 32 bytes 数据，通常用 16 进制存储

5、四种函数可见性说明符，需明确指定，无默认

   - `public`：内部和外部均可见。
   - `private`：只能从本合约内部访问，继承的合约也不能使用。
   - `external`：只能从合约外部访问（但内部可以通过 `this.f()` 来调用，`f`是函数名）。
   - `internal`: 只能从合约内部访问，继承的合约可以用。
     
6、决定函数权限/功能的关键字，默认能读能写不可支付

   - `payable`：可支付的，运行的时候可以往合约里面转钱
   - `pure`：不能读不能写
   - `view`：只能看不能写

pure 使用示例

```solidity
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
```
### 2024.09.24
1、返回值 return 和 returns

   - `returns`：跟在函数名后面，用于声明返回的变量类型及变量名，如果标明了返回变量名，可无需 `return`
   - `return`：用于函数主体中，返回指定的变量
     
2、三种存储位置

   - `storage`：合约里的状态变量默认都是`storage`，存储在链上，消耗 gas 高。赋值给 `storage` 修饰的新变量，修改新变量值会影响原变量，用 `memory` 修饰的则不会
   - `memory`：函数里的参数和临时变量一般用`memory`，存储在内存中，不上链，消耗 gas 低。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构
   - `calldata`：和`memory`类似，存储在内存中，不上链。与`memory`的不同点在于`calldata`变量不能修改（`immutable`），一般用于函数的参数

3、常见全局变量，完整[链接](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)

   - `blockhash(uint blockNumber)`: (`bytes32`) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
   - `block.coinbase`: (`address payable`) 当前区块矿工的地址
   - `block.gaslimit`: (`uint`) 当前区块的gaslimit
   - `block.number`: (`uint`) 当前区块的number
   - `block.timestamp`: (`uint`) 当前区块的时间戳，为unix纪元以来的秒
   - `gasleft()`: (`uint256`) 剩余 gas
   - `msg.data`: (`bytes calldata`) 完整call data
   - `msg.sender`: (`address payable`) 消息发送者 (当前 caller)
   - `msg.sig`: (`bytes4`) calldata的前四个字节 (function identifier)
   - `msg.value`: (`uint`) 当前交易发送的 `wei` 值
   - `block.blobbasefee`: (`uint`) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
   - `blobhash(uint index)`: (`bytes32`) 返回跟当前交易关联的第 `index` 个blob的版本化哈希（第一个字节为版本号，当前为`0x01`，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。

4、以太单位

- `wei`: 1
- `gwei`: 1e9 = 1000000000
- `ether`: 1e18 = 1000000000000000000

### 2024.09.25
1、`bytes`是一个不需要加 `[]` 的数组，不能用 `byte[]` 声明单字节数组，可以使用`bytes`或`bytes1[]`，`bytes` 比 `bytes1[]` 省gas

2、`uint[]`数组元素 type 通常以第一个为准，如果不指定，会根据上下文推断元素 type, 默认为最小单位类型 `uint8`

3、对于 `memory` 修饰的动态数组，可以用 `new` 操作符来创建，但是必须声明长度，并且声明后长度不能改变

   ```solidity
       uint[] memory array8 = new uint[](5);
       bytes memory array9 = new bytes(9);
   ```
4、数组成员

- `length`: `memory`数组的长度在创建后是固定的
- `push()`: `动态数组`拥有`push()`成员，可以在数组最后添加一个`0`元素，并返回该元素的引用
- `push(x)`: `动态数组`拥有`push(x)`成员，可以在数组最后添加一个`x`元素
- `pop()`: `动态数组`拥有`pop()`成员，可以移除数组最后一个元素

5、两种结构体构造函数赋值方法

```solidity
   // 结构体 Struct
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student student; // 初始一个student结构体

    function initStudent3() external {
        student = Student(3, 90);
    }

    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }
```

6、映射的 `_KeyType` 只能选择 Solidity 内置的值类型，比如 `uint`，`address`等; 映射的存储位置必须是 `storage`

```solidity
   mapping(uint => address) public idToAddress; // id映射到地址
   mapping(address => address) public swapPair; // 币对的映射，地址到地址

   function writeMap (uint _Key, address _Value) public{
      idToAddress[_Key] = _Value;
   }
```

### 2024.09.26
1、`delete` 操作符可以删除一个变量的值并代替为初始值

2、只有数值变量可以声明 `constant` 和 `immutable`；`string` 和 `bytes` 可以声明为 `constant`，但不能为 `immutable`

3、`constant` 和 `immutable`初始化之后都不能改变数值，`immutable` 可以在声明时或者构造函数中初始化，如果两个地方都初始化了，以构造函数中为主

4、Solidity 写插入排序

```solidity
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

### 2024.09.27
1、修饰器 `modifier`是Solidity特有的语法，声明函数拥有的特性，用在函数上

```solidity
contract Owner {
   address public owner; // 定义owner变量

   // 构造函数
   // constructor(address initialOwner) {
   //    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
   // }

      // 构造函数
   constructor() {
      owner = msg.sender;
   }

   // 定义modifier
   modifier onlyOwner {
      require(msg.sender == owner); // 检查调用者是否为owner地址
      _; // 如果是的话，继续运行函数主体；否则报错并revert交易
   }

   // 定义一个带onlyOwner修饰符的函数
   function changeOwner(address _newOwner) external onlyOwner{
      owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
   }
}
```

2、事件 `event`

```solidity
contract EventTest {
    // 定义_balances映射变量，记录每个地址的持币数量
    mapping(address => uint256) public _balances;

    // 定义Transfer event，记录transfer交易的转账地址，接收地址和转账数量
    event Transfer(address indexed from, address indexed to, uint256 value);


    // 定义_transfer函数，执行转账逻辑
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {

        _balances[from] = 10000000; // 给转账地址一些初始代币

        _balances[from] -=  amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量

        // 释放事件
        emit Transfer(from, to, amount);
    }
}
```
以太坊虚拟机（EVM）用日志 Log 来存储 Solidity 事件，每条日志记录都包含主题 topics 和数据 data 两部分，topics 数组第一个元素是事件的签名（哈希）
```solidity
keccak256("Transfer(address,address,uint256)")

//0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
```
`indexed` 关键字标记的参数可以理解为检索事件的索引“键”，方便之后搜索。主题中可以包含至多 3 个 `indexed` 参数

3、继承，用 `is` 关键词

- `virtual`: 父合约中的函数，如果希望子合约重写，需要加上 `virtual` 关键字
- `override`: 子合约重写了父合约中的函数，需要加上 `override`关键字

```solidity
// 合约继承
contract Yeye {
    event Log(string msg);

    // 定义3个function: hip(), pop(), man()，Log值为Yeye。
    function hip() public virtual{
        emit Log("Yeye");
    }

    function pop() public virtual{
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye{
    // 继承两个function: hip()和pop()，输出改为Baba。
    function hip() public virtual override{
        emit Log("Baba");
    }

    function pop() public virtual override{
        emit Log("Baba");
    }

    function baba() public virtual{
        emit Log("Baba");
    }
}

contract Son is Yeye, Baba{
    // 继承两个function: hip()和pop()，输出改为Son。
    function hip() public virtual override(Yeye, Baba){
        emit Log("Son");
    }

    function pop() public virtual override(Yeye, Baba) {
        emit Log("Son");
    }

    function callParent() public{
        Yeye.pop();
    }

    function callParentSuper() public{
        super.pop();
    }
}
```
4、构造函数继承的两种方式

```solidity
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
// 第一种：在继承时声明父构造函数的参数
contract B is A(1) {
}

// 第二种：在子合约的构造函数中声明构造函数的参数
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```

5、`Modifier` 修饰器也能被继承

```solidity
contract A {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}
contract B is A {
   modifier exactDividedBy2And3(uint _a) override {
      require(_a % 2 == 0 && _a % 3 == 0);
      _;
   }
}
```

### 2024.09.28
1、如果一个智能合约里至少有一个未实现的函数，则必须用 `abstract` 标明为抽象合约，没有函数体的函数也需要加 `virtual` 标明

2、接口类似于抽象合约，但它不实现任何功能，参考 NFT 常用的 [IERC721](https://eips.ethereum.org/EIPS/eip-721)

- 不能包含状态变量
- 不能包含构造函数
- 不能继承除接口外的其他合约
- 所有函数都必须是 `external` 且不能有函数体
- 继承接口的非抽象合约必须实现接口定义的所有功能

3、三种抛出异常方法

```solidity
// 自定义error
error TransferNotOwner();

// error TransferNotOwner(address sender);

contract Errors {
    // 一组映射，记录每个TokenId的Owner
    mapping(uint256 => address) private _owners;

    // Error方法: gas cost 24457
    // Error with parameter: gas cost 24660
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if (_owners[tokenId] != msg.sender) {
            revert TransferNotOwner();
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    // require方法: gas cost 24755
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;
    }

    // assert方法: gas cost 24473
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }
}
```
4、`Solidity` 中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，`Solidity` 不允许修饰器（`modifier`）重载。

```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```
### 2024.09.29
29号的笔记找不到了，学了库合约和 `import`的使用，贴两段昨天的练习代码

```solidity

import "@openzeppelin/contracts/utils/Strings.sol";

// 用函数调用另一个库合约
contract UseLibrary{    
    // 利用using for操作使用库
    using Strings for uint256;
    function getString1(uint256 _number) public pure returns(string memory){
        // 库函数会自动添加为uint256型变量的成员
        return _number.toHexString();
    }

    // 直接通过库合约名调用
    function getString2(uint256 _number) public pure returns(string memory){
        return Strings.toHexString(_number);
    }
}
```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 通过文件相对位置import
import './Yeye.sol';
// 通过`全局符号`导入特定的合约
import {Yeye} from './Yeye.sol';
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 引用OpenZeppelin合约
import '@openzeppelin/contracts/access/Ownable.sol';

contract UseImport {
    // 成功导入Address库
    using Address for address;
    // 声明yeye变量
    Yeye yeye = new Yeye();

    // 测试是否能调用yeye的函数
    function test() external{
        yeye.hip();
    }
}
```
### 2024.09.30
1、`solidity` 中有两个特殊的函数 `receive` 和 `fallback` 用于接收 `ETH` 和简单逻辑处理，均不需要 `function` 关键字

区别：合约接收 `ETH` 时，`msg.data` 为空且存在 `receive()` 时，会触发 `receive()`；`msg.data` 不为空或不存在 `receive()` 时，会触发 `fallback()`，此时 `fallback()` 必须为 `payable`。

`receive()` 和 `payable fallback()` 均不存在的时候，向合约直接发送 `ETH` 将会报错（你仍可以通过带有 `payable` 的函数向合约发送ETH）。

2、三种发送 ETH 方法

- `call`没有`gas`限制，最为灵活，是最提倡的方法；
- `transfer`有`2300 gas`限制，但是发送失败会自动`revert`交易，是次优选择；
- `send`有`2300 gas`限制，而且发送失败不会自动`revert`交易，几乎没有人用它。
  
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 3种方法发送ETH
// transfer: 2300 gas, revert
// send: 2300 gas, return bool
// call: all gas, return (bool, data)

error SendFailed(); // 用send发送ETH失败error
error CallFailed(); // 用call发送ETH失败error

contract SendETH {
    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable{}
    // receive方法，接收eth时被触发
    receive() external payable{}

    // 用transfer()发送ETH
    function transferETH(address payable _to, uint256 amount) external payable{
        _to.transfer(amount);
    }

    // send()发送ETH
    function sendETH(address payable _to, uint256 amount) external payable{
        // 处理下send的返回值，如果失败，revert交易并发送error
        bool success = _to.send(amount);
        if(!success){
            revert SendFailed();
        }
    }

    // call()发送ETH
    function callETH(address payable _to, uint256 amount) external payable{
        // 处理下call的返回值，如果失败，revert交易并发送error
        (bool success,) = _to.call{value: amount}("");
        if(!success){
            revert CallFailed();
        }
    }
}

contract ReceiveETH {
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);

    // receive方法，接收eth时被触发
    receive() external payable{
        emit Log(msg.value, gasleft());
    }
    
    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}
```
### 2024.10.01
1、通过目标合约代码或接口，调用目标合约的函数
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);
    
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
    }
}

contract CallContract{
    function callSetX(address _Address, uint256 x) external{
        OtherContract(_Address).setX(x);
    }

    function callGetX(OtherContract _Address) external view returns(uint x){
        x = _Address.getX();
    }

    function callGetX2(address _Address) external view returns(uint x){
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }

    function setXTransferETH(address otherContract, uint256 x) payable external{
        OtherContract(otherContract).setX{value: msg.value}(x);
    }
}
```
2、利用 `call` 调用其他合约
```solidity

contract Call{
    // 定义Response事件，输出call返回的结果success和data
    event Response(bool success, bytes data);

    function callSetX(address payable _addr, uint256 x) public payable {
        // call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint256)", x)
        );

        emit Response(success, data); //释放事件
    }

    function callGetX(address _addr) external returns(uint256){
        // call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Response(success, data); //释放事件
        return abi.decode(data, (uint256));
    }

    function callNonExist(address _addr) external{
        // call 不存在的函数，call仍能执行成功，并返回success，但其实调用的目标合约fallback函数。
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo(uint256)")
        );

        emit Response(success, data); //释放事件
    }
}
```
### 2024.10.02
1、`delegatecall` 示例，和 `call` 不一样，`delegatecall` 在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额

```solidity
// delegatecall和call类似，都是低级函数
// call: B call C, 上下文为 C (msg.sender = B, C中的状态变量受影响)
// delegatecall: B delegatecall C, 上下文为B (msg.sender = A, B中的状态变量受影响)
// 注意B和C的数据存储布局必须相同！变量类型、声明的前后顺序要相同，不然会搞砸合约。

// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

// 发起delegatecall的合约B
contract B {
    uint public num;
    address public sender;

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
}
```

2、用 `create` 方法在合约中创建新合约，实际上就是 `new` 一个新合约

```solidity
// Contract 是要创建的合约名，x 是合约对象（地址），如果构造函数是 payable，可以创建时转入 _value 数量的 ETH，params 是新合约构造函数的参数。
Contract x = new Contract{value: _value}(params)
```
极简 Uniswap 示例

```solidity
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
```

3、用 `CREATE2` 方法在合约中创建新合约，同 `CREATE` 类似，只不过要多传一个 `salt` 参数
```solidity
// 其中 Contract 是要创建的合约名，x 是合约对象（地址），_salt 是指定的盐；如果构造函数是 payable，可以创建时转入 _value 数量的 ETH ，params 是新合约构造函数的参数。
Contract x = new Contract{salt: _salt, value: _value}(params)
```
用 `CREATE2` 方法极简 Uniswap 示例
```solidity
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

contract PairFactory2{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair2(address tokenA, address tokenB) external returns (address pairAddr) {
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //避免tokenA和tokenB相同产生的冲突
        // 计算用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 用create2部署新合约
        Pair pair = new Pair{salt: salt}(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }

    // 提前计算pair合约地址
    function calculateAddr(address tokenA, address tokenB) public view returns(address predictedAddress){
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //避免tokenA和tokenB相同产生的冲突
        // 计算用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA); //将tokenA和tokenB按大小排序
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        // 计算合约地址方法 hash()
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(type(Pair).creationCode)
        )))));

        // 例如当create2合约时：
        // Pair pair = new Pair{salt: salt}(address(this));
        // 计算时，需要将参数和initcode一起进行打包：
        // predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
        //         bytes1(0xff),
        //         address(this),
        //         salt,
        //         keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
        // )))));
    }
}
```
### 2024.10.03
1、删除合约 `selfdestruct`，坎昆（Cancun）升级之后

- 已经部署的合约无法被删除了，使用 `selfdestruct` 仅会被用来将合约中的ETH转移到指定地址
- 如果要实现原先的 `SELFDESTRUCT` 功能，必须在同一笔交易中创建并 `selfdestruct`

```solidity
// selfdestruct: 删除合约，并强制将合约剩余的ETH转入指定账户
contract DeleteContract {

    uint public value = 10;

    constructor() payable {}

    receive() external payable {}

    function deleteContract() external {
        // 调用selfdestruct销毁合约，并把剩余的ETH转给msg.sender
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}
```
想要坎昆升级之前的使用效果

```solidity
import "./DeleteContract.sol";

contract DeployContract {

    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }

    constructor() payable {}

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }

    function demo() public payable returns (DemoResult memory){
        DeleteContract del = new DeleteContract{value:msg.value}();
        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });
        del.deleteContract();
        return res;
    }
}
```

2、ABI 编解码

```solidity

contract ABIEncode{
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xWater";
    uint[2] array = [5, 6]; 

    // 0x000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000073078576174657200000000000000000000000000000000000000000000000000
    // 将每个数据都填充为32字节，所以中间有很多0
    function encode() public view returns(bytes memory result) {
        result = abi.encode(x, addr, name, array);
    }

    // 0x000000000000000000000000000000000000000000000000000000000000000a7a58c0be72be218b41c608b7fe7c5bb630736c713078576174657200000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006
    // 类似 abi.encode，但是会把其中填充的很多0省略，长度比 abi.encode 短很多。比如，只用1字节来编码uint8类型。当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked，例如算一些数据的hash时。
    function encodePacked() public view returns(bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
    }

    // 0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000073078576174657200000000000000000000000000000000000000000000000000
    // 第一个参数为函数签名
    function encodeWithSignature() public view returns(bytes memory result) {
        result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
    }

    // 0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000073078576174657200000000000000000000000000000000000000000000000000
    // 与 abi.encodeWithSignature 功能类似，只不过第一个参数为函数选择器，为函数签名 Keccak 哈希的前4个字节，结果与 abi.encodeWithSignature 相同
    function encodeWithSelector() public view returns(bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
    }

    // 用于解码 abi.encode 生成的二进制编码，将它还原成原本的参数。
    function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
        (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
    }
}
```

<!-- Content_END -->
