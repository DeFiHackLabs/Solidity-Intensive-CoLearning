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

### 

<!-- Content_END -->
