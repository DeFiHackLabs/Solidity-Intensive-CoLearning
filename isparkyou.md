---
timezone: America/New_York
---

---

# isparkyou

1. Friedrich Ludwig

2. Yes!
   
## Notes

<!-- Content_START -->

### 2024.09.23
### Solidity
### Remix
[Remix](https://remix.ethereum.org)
### 注释：
// SPDX-License-Identifier: MIT
### 版本：
pragma solidity ^0.8.21;
### 合约：
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
### 编译：
Ctrl + S
### 部署：
Deploy
### 2024.09.24
### value type
1. bool
```
bool public _bool = true;
```
```
// 布尔运算
bool public _bool1 = !_bool; false// 取非
bool public _bool2 = _bool && _bool1; false// 与
bool public _bool3 = _bool || _bool1; true// 或
bool public _bool4 = _bool == _bool1; false// 相等
bool public _bool5 = _bool != _bool1; true// 不相等
```
### “短路规则”
一般出现在逻辑与（&&）和逻辑或（||）中。 当逻辑与（&&）的第一个条件为false时，就不会再去判断第二个条件； 当逻辑或（||）的第一个条件为true时，就不会再去判断第二个条件，这就是短路规则。

2. int
```
   // 整型
int public _int = -1; // 整数，包括负数
uint public _uint = 1; // 正整数
uint256 public _number = 20220330; // 256位正整数
```
```
// 整数运算
uint256 public _number1 = _number + 1; 20220331// +，-，*，/
uint256 public _number2 = 2**2; 4// 指数
uint256 public _number3 = 7 % 2; 1// 取余数
bool public _numberbool = _number2 > _number3; true// 比大小
```
3. address
address:存储一个20字节的值
payable address：多transfer和send两个成员方法
```
// 地址
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address); // payable address，可以转账、查余额
// 地址类型的成员
uint256 public balance = _address1.balance; // balance of address
```
4. byte
定长字节数组：属于值类型，数组长度在声明之后不能改变。
不定长字节数组：属于引用类型，数组长度在声明之后可以改变。
```
// 固定长度的字节数组
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0]; 
```
5. enum
用户定义的数据类型，主要用于uint分配名称，使程序易于阅读和维护。
```
// 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
enum ActionSet { Buy, Hold, Sell }
// 创建enum变量 action
ActionSet action = ActionSet.Buy;
// enum可以和uint显式的转换
function enumToUint() external view returns(uint){
    return uint(action);
}
```

### reference type

### mapping type

### 2024.09.25
### 函数
```
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
合约中定义的函数需要明确指定可见性，它们没有默认值。
public|private|internal 也可用于修饰状态变量。
public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

public：内部和外部均可见。
private：只能从本合约内部访问，继承的合约也不能使用。
external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
internal: 只能从合约内部访问，继承的合约可以用。

#### 在以太坊中，以下语句被视为修改链上状态：
1. 写入状态变量。
2. 释放事件。
3. 创建其他合约。
4. 使用 selfdestruct.
5. 通过调用发送以太币。
6. 调用任何未标记 view 或 pure 的函数。
7. 使用低级调用（low-level calls）。
8. 使用包含某些操作码的内联汇编。

pure，pure 函数既不能读取也不能写入链上的状态变量。
view，view函数能读取但也不能写入状态变量。
非 pure 或 view 的函数既可以读取也可以写入状态变量。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract FunctionTypes{
    uint256 public number = 5;
// 默认function
function add() external{
    number = number + 1;
}
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
// view: 看客
function addView() external view returns(uint256 new_number) {
    new_number = number + 1;
}
// internal: 内部函数
function minus() internal {
    number = number - 1;
}

// 合约内的函数可以调用内部函数
function minusCall() external {
    minus();
}
// payable: 递钱，能给合约支付eth的函数
function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}
}
```

### 返回值：return和returns
returns：跟在函数名后面，用于声明返回的变量类型及变量名。
return：用于函数主体中，返回指定的变量。
```
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
```
这里uint256[3]声明了一个长度为3且类型为uint256的数组作为返回值。因为[1,2,3]会默认为uint8(3)，因此[uint256(1),2,5]中首个元素必须强转uint256来声明该数组内的元素皆为此类型。数组类型返回值默认必须用memory修饰

### 命名式返回
我们可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。
```
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```
也可以在命名式返回中用 return 来返回变量：
```
// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

### 解构式赋值
读取所有返回值：声明变量，然后将要赋值的变量用,隔开，按顺序排列。
```
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
```
读取部分返回值：声明要读取的返回值对应的变量，不读取的留空。在下面的代码中，我们只读取_bool，而不读取返回的_number和_array：
```
(, _bool2, ) = returnNamed();
```

### 引用类型（Reference Type）
包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。
#### 数据位置
Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。大致用法：
storage：合约里的状态变量默认都是storage，存储在链上。
memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。例子：
```
function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    //参数为calldata数组，不能被修改
    // _x[0] = 0 //这样修改会报错
    return(_x);
}
```

#### 数据位置和赋值规则
赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。例子：
```
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```
memory赋值给memory，会创建引用，改变新变量会影响原变量。
其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方

#### 变量的作用域
#### 状态变量
状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明：
```
contract Variables {
    uint public x = 1;
    uint public y;
    string public z;
}
```
我们可以在函数里更改状态变量的值：
```
function foo() external{
    // 可以在函数里更改状态变量的值
    x = 5;
    y = 2;
    z = "0xAA";
}
```
#### 局部变量
局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明：
```
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}
```
#### 全局变量
全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：
```
function global() external view returns(address, uint, bytes memory){
    address sender = msg.sender;
    uint blockNum = block.number;
    bytes memory data = msg.data;
    return(sender, blockNum, data);
}
```
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

#### 以太单位与事件单位
#### 以太单位
Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。
wei: 1
gwei: 1e9 = 1000000000
ether: 1e18 = 1000000000000000000
```
function weiUnit() external pure returns(uint) {
    assert(1 wei == 1e0);
    assert(1 wei == 1);
    return 1 wei;
}

function gweiUnit() external pure returns(uint) {
    assert(1 gwei == 1e9);
    assert(1 gwei == 1000000000);
    return 1 gwei;
}

function etherUnit() external pure returns(uint) {
    assert(1 ether == 1e18);
    assert(1 ether == 1000000000000000000);
    return 1 ether;
}
```
#### 时间单位
可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。
seconds: 1
minutes: 60 seconds = 60
hours: 60 minutes = 3600
days: 24 hours = 86400
weeks: 7 days = 604800
```
function secondsUnit() external pure returns(uint) {
    assert(1 seconds == 1);
    return 1 seconds;
}

function minutesUnit() external pure returns(uint) {
    assert(1 minutes == 60);
    assert(1 minutes == 60 seconds);
    return 1 minutes;
}

function hoursUnit() external pure returns(uint) {
    assert(1 hours == 3600);
    assert(1 hours == 60 minutes);
    return 1 hours;
}

function daysUnit() external pure returns(uint) {
    assert(1 days == 86400);
    assert(1 days == 24 hours);
    return 1 days;
}

function weeksUnit() external pure returns(uint) {
    assert(1 weeks == 604800);
    assert(1 weeks == 7 days);
    return 1 weeks;
}
```

### 引用类型
#### 数组array
固定长度数组：在声明时指定数组的长度。用T[k]的格式声明，其中T是元素的类型，k是长度，例如：
```
// 固定长度 Array
uint[8] array1;
bytes1[5] array2;
address[100] array3;
```
可变长度数组（动态数组）：在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型，例如：
```
// 可变长度 Array
uint[] array4;
bytes1[] array5;
address[] array6;
bytes array7;
```
bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
#### 创建数组的规则
对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：
```
// memory动态数组
uint[] memory array8 = new uint[](5);
bytes memory array9 = new bytes(9);
```
数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化array的一种方式，并且里面每一个元素的type是以第一个元素为准的
如果创建的是动态数组，你需要一个一个元素的赋值。

#### 数组成员
length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。

#### 结构体struct
支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。
```
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体
```
给结构体赋值的四种方法：
```
//  给结构体赋值
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

### 映射类型mapping
在映射中，人们可以通过键（Key）来查询对应的值（Value）
声明映射的格式为mapping(_KeyType => _ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型。例子：
```
mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址
```
### 映射的规则
规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型。
规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数（见例子）。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。
规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。
规则4：给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对。

### 映射的原理
原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。
原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。
原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

### 变量初始值
#### 值类型初始值
boolean: false
string: ""
int: 0
uint: 0
enum: 枚举中的第一个元素
address: 0x0000000000000000000000000000000000000000 (或 address(0))
function
internal: 空白函数
external: 空白函数

#### 引用类型初始值
映射mapping: 所有元素都为其默认值的mapping
结构体struct: 所有成员设为其默认值的结构体
数组array
动态数组: []
静态数组（定长）: 所有成员设为其默认值的静态数组

#### delete操作符
delete a会让变量a的值变为初始值。

### 2024.09.26
### 常数constant和immutable
状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。
只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。
```
// constant变量必须在声明的时候初始化，之后不能改变
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

// immutable变量可以在constructor里初始化，之后不能改变
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;

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

### 控制流
```
// if-else
function ifElseTest(uint256 _number) public pure returns(bool){
    if(_number == 0){
        return(true);
    }else{
        return(false);
    }
}
// for
function forLoopTest() public pure returns(uint256){
    uint sum = 0;
    for(uint i = 0; i < 10; i++){
        sum += i;
    }
    return(sum);
}
// while
function whileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    while(i < 10){
        sum += i;
        i++;
    }
    return(sum);
}
// do-while
function doWhileTest() public pure returns(uint256){
    uint sum = 0;
    uint i = 0;
    do{
        sum += i;
        i++;
    }while(i < 10);
    return(sum);
}
// 三元运算符 ternary/conditional operator
function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
    // return the max of x and y
    return x >= y ? x: y; 
}
```

```
# Python program for implementation of Insertion Sort
def insertionSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1
        while j >=0 and key < arr[j] :
            arr[j+1] = arr[j]
            j -= 1
        arr[j+1] = key
    return arr
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

### 构造函数和修饰器
#### 构造函数
构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数
```
address owner; // 定义owner变量

// 构造函数
constructor(address initialOwner) {
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}
```
#### 修饰器
修饰器（modifier）是Solidity特有的语法，类似于面向对象编程中的装饰器（decorator），声明函数拥有的特性，并减少代码冗余。
modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。
```
// 定义modifier
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是否为owner地址
   _; // 如果是的话，继续运行函数主体；否则报错并revert交易
}
function changeOwner(address _newOwner) external onlyOwner{
   owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
}
```

### 事件event
响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

#### 声名事件
事件的声明由event关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。
```
event Transfer(address indexed from, address indexed to, uint256 value);
```
其中from和to前面带有indexed关键字，他们会保存在以太坊虚拟机日志的topics中，方便之后检索。
#### 释放事件
```
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
```

### EVM日志log
以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。
#### 主题topics
日志的第一部分是主题数组，用于描述事件，长度不能超过4。它的第一个元素是事件的签名（哈希）。
除了事件哈希，主题还可以包含至多3个indexed参数，也就是Transfer事件中的from和to。
indexed标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个 indexed 参数的大小为固定的256比特，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

#### 数据data
事件中不带 indexed的参数会被存储在 data 部分中，可以理解为事件的“值”。data 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 data 部分可以用来存储复杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特，即使存储在事件的 topics 部分中，也是以哈希的方式存储。另外，data 部分的变量在存储上消耗的gas相比于 topics 更少。

### 继承
virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
override：子合约重写了父合约中的函数，需要加上override关键字。
用override修饰public变量，会重写与变量同名的getter函数
```
mapping(address => uint256) public override balanceOf;
```
#### 简单继承
```
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
contract Erzi is Yeye, Baba{
    // 继承两个function: hip()和pop()，输出值为Erzi。
    function hip() public virtual override(Yeye, Baba){
        emit Log("Erzi");
    }

    function pop() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }
}
```
#### 多重继承
1. 继承时要按辈分最高到最低的顺序排。比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，不然就会报错。
2. 如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。
3. 重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。

#### 修饰器的继承
```
contract Base1 {
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}
modifier exactDividedBy2And3(uint _a) override {
    _;
    require(_a % 2 == 0 && _a % 3 == 0);
}
```

#### 构造函数的继承
在继承时声明父构造函数的参数，例如：contract B is A(1)
在子合约的构造函数中声明构造函数的参数，例如：
```
// 构造函数的继承
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```

#### 调用父合约的函数
1. 直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，例如Yeye.pop()
```
function callParent() public{
    Yeye.pop();
}
```
2. super关键字：子合约可以利用super.函数名()来调用最近的父合约函数。Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()：
```
function callParentSuper() public{
    // 将调用最近的父合约函数，Baba.pop()
    super.pop();
}
```
#### 钻石继承
在多重+菱形继承链条上使用super关键字时，需要注意的是使用super会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。
```
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

### 抽象合约和接口
如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为abstract，不然编译会报错；另外，未实现的函数需要加virtual，以便子合约重写。
```
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```
#### 接口
接口类似于抽象合约，但它不实现任何功能。接口的规则：
1. 不能包含状态变量
2. 不能包含构造函数
3. 不能继承除接口外的其他合约
4. 所有函数都必须是external且不能有函数体
5. 继承接口的非抽象合约必须实现接口定义的所有功能
虽然接口不实现任何功能，但它非常重要。接口是智能合约的骨架，定义了合约的功能以及如何触发它们：如果智能合约实现了某种接口（比如ERC20或ERC721），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：
1. 合约里每个函数的bytes4选择器，以及函数签名函数名(每个参数类型）。
2. 接口id
接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用abi-to-sol工具，也可以将ABI json文件转换为接口sol文件。
接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。

```
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

#### IERC721 event
Transfer事件：在转账时被释放，记录代币的发出地址from，接收地址to和tokenId。
Approval事件：在授权时被释放，记录授权地址owner，被授权地址approved和tokenId。
ApprovalForAll事件：在批量授权时被释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。

#### IERC721 function
balanceOf：返回某地址的NFT持有量balance。
ownerOf：返回某tokenId的主人owner。
transferFrom：普通转账，参数为转出地址from，接收地址to和tokenId。
safeTransferFrom：安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。
approve：授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
getApproved：查询tokenId被批准给了哪个地址。
setApprovalForAll：将自己持有的该系列NFT批量授权给某个地址operator。
isApprovedForAll：查询某地址的NFT是否批量授权给了另一个operator地址。
safeTransferFrom：安全转账的重载函数，参数里面包含了data。

如果我们知道一个合约实现了IERC721接口，我们不需要知道它具体代码实现，就可以与它交互。

### 异常
#### error
error是solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。人们可以在contract之外定义异常。
在执行当中，error必须搭配revert（回退）命令使用。
#### require
require命令是solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。
#### asset
assert命令一般用于程序员写程序debug，因为它不能解释抛出异常的原因（比require少个字符串）。它的用法很简单，assert(检查条件），当检查条件不成立的时候，就会抛出异常。
error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas，大家要多用！

### 2024.09.27

### 重载overloading
即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。
```
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```
最终重载函数在经过编译器编译后，由于不同的参数类型，都变成了不同的函数选择器（selector）。
#### 实参匹配Argument Matching
在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。

### 库合约
库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在。
他和普通合约主要有以下几点不同：
1. 不能存在状态变量
2. 不能够继承或被继承
3. 不能接收以太币
4. 不可以被销毁

**库合约中的函数可见性如果被设置为public或者external，则在调用函数时会触发一次delegatecall。
而如果被设置为internal，则不会引起。
对于设置为private可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。**

#### Strings库合约
是将uint256类型转换为相应的string类型的代码库
主要包含两个函数，toString()将uint256转为string，toHexString()将uint256转换为16进制，在转换为string。

#### 如何使用库合约
1. 利用using for指令
   指令using A for B;可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数：
   ```
   // 利用using for指令
   using Strings for uint256;
   function getString1(uint256 _number) public pure returns(string memory){
       // 库合约中的函数会自动添加为uint256型变量的成员
       return _number.toHexString();
   }
   ```
2. 通过库合约名称调用函数
   ```
   // 直接通过库合约名调用
   function getString2(uint256 _number) public pure returns(string memory){
       return Strings.toHexString(_number);
   }
   ```


**常用的有：**
1. Strings：将uint256转换为String
2. Address：判断某个地址是否为合约地址
3. Create2：更安全的使用Create2 EVM opcode
4. Arrays：跟数组相关的库合约

### Import
import语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。
#### import用法
1. 通过源文件相对位置导入，例子：
```
文件结构
├── Import.sol
└── Yeye.sol

// 通过文件相对位置import
import './Yeye.sol';
```
2. 通过源文件网址导入网上的合约的全局符号，例子：
```
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
```
3. 通过npm的目录导入，例子：
```
import '@openzeppelin/contracts/access/Ownable.sol';
```
4. 通过指定全局符号导入合约特定的全局符号，例子：
```
import {Yeye} from './Yeye.sol';
```
5. 引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前。

### 接收ETH receive和fallback
Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：
1. 接收ETH
2. 处理合约中不存在的函数调用（代理合约proxy contract）
#### 接收ETH函数receive
receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。
当合约接收ETH的时候，receive()会被触发。receive()最好不要执行太多的逻辑因为如果别人用send和transfer方法发送ETH的话，gas会限制在2300，receive()太复杂可能会触发Out of Gas报错；如果用call就可以自定义gas执行更复杂的逻辑
可以在receive()里发送一个event，例如：
```
// 定义事件
event Received(address Sender, uint Value);
// 接收ETH时释放Received事件
receive() external payable {
    emit Received(msg.sender, msg.value);
}
```
#### 回退函数fallback
fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。
我们定义一个fallback()函数，被触发时候会释放fallbackCalled事件，并输出msg.sender，msg.value和msg.data:
```
event fallbackCalled(address Sender, uint Value, bytes Data);

// fallback
fallback() external payable{
    emit fallbackCalled(msg.sender, msg.value, msg.data);
}
```
#### receive和fallback的区别
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
合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。
receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错（你仍可以通过带有payable的函数向合约发送ETH）。

### 发送ETH
三种方法向其他合约发送ETH，他们是：transfer()，send()和call()，其中call()是被鼓励的用法。
先部署一个接收ETH合约ReceiveETH。ReceiveETH合约里有一个事件Log，记录收到的ETH数量和gas剩余。还有两个函数，一个是receive()函数，收到ETH被触发，并发送Log事件；另一个是查询合约ETH余额的getBalance()函数。
```
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
先在发送ETH合约SendETH中实现payable的构造函数和receive()，让我们能够在部署时和部署后向合约转账。
```
contract SendETH {
    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable{}
    // receive方法，接收eth时被触发
    receive() external payable{}
}
```
#### transfer
用法是接收方地址.transfer(发送ETH数额)。
transfer()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
transfer()如果转账失败，会自动revert（回滚交易）。
```
// 用transfer()发送ETH
function transferETH(address payable _to, uint256 amount) external payable{
    _to.transfer(amount);
}
```
#### send
用法是接收方地址.send(发送ETH数额)。
send()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
send()如果转账失败，不会revert。
send()的返回值是bool，代表着转账成功或失败，需要额外代码处理一下。
```
error SendFailed(); // 用send发送ETH失败error

// send()发送ETH
function sendETH(address payable _to, uint256 amount) external payable{
    // 处理下send的返回值，如果失败，revert交易并发送error
    bool success = _to.send(amount);
    if(!success){
        revert SendFailed();
    }
}
```
#### call
用法是接收方地址.call{value: 发送ETH数额}("")。
call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑。
call()如果转账失败，不会revert。
call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理一下。
```
error CallFailed(); // 用call发送ETH失败error

// call()发送ETH
function callETH(address payable _to, uint256 amount) external payable{
    // 处理下call的返回值，如果失败，revert交易并发送error
    (bool success,) = _to.call{value: amount}("");
    if(!success){
        revert CallFailed();
    }
}
```
**call没有gas限制，最为灵活，是最提倡的方法；
transfer有2300 gas限制，但是发送失败会自动revert交易，是次优选择；
send有2300 gas限制，而且发送失败不会自动revert交易，几乎没有人用它。**

### 2024.09.28
### 调用其他合约
**目标合约**
```
contract OtherContract {
    uint256 private _x = 0; // 状态变量_x
    // 收到eth的事件，记录amount和gas
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

    // 读取_x
    function getX() external view returns(uint x){
        x = _x;
    }
}
```

#### 调用OtherContract合约
**我们可以利用合约的地址和合约代码（或接口）来创建合约的引用：_Name(_Address)，其中_Name是合约名，应与合约代码（或接口）中标注的合约名保持一致，_Address是合约地址。然后用合约的引用来调用它的函数：_Name(_Address).f()，其中f()是要调用的函数。**

1. 传入合约地址
在函数里传入目标合约地址，生成目标合约的引用，然后调用目标函数。
```
function callSetX(address _Address, uint256 x) external{
    OtherContract(_Address).setX(x);
}
```
2. 传入合约变量
直接在函数里传入合约的引用，只需要把上面参数的address类型改为目标合约名
```
function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}
```
3. 创建合约变量
创建合约变量，然后通过它来调用目标函数。
```
function callGetX2(address _Address) external view returns(uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
```
4. 调用合约并发送ETH
如果目标合约的函数是payable的，那么我们可以通过调用它来给合约转账：_Name(_Address).f{value: _Value}()，其中_Name是合约名，_Address是合约地址，f是目标函数名，_Value是要转的ETH数额（以wei为单位）。
```
function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
}
```

### Call
call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。
1. call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。
2. 不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数
3. 当我们不知道对方合约的源代码或ABI，就没法生成合约变量；这时，我们仍可以通过call调用对方合约的函数。

#### Call的使用规则
```
目标合约地址.call(字节码);
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
```

#### 利用call调用目标合约
1. Response事件
2. 调用setX函数
3. 调用getX函数
4. 调用不存在的函数
```
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
    // call 不存在的函数
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("foo(uint256)")
    );

    emit Response(success, data); //释放事件
}
```

### Delegatecall
delegatecall与call类似，是Solidity中地址类型的低级成员函数。
当用户A通过合约B来call合约C的时候，执行的是合约C的函数，上下文(Context，可以理解为包含变量和状态的环境)也是合约C的：msg.sender是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上。
![image](https://github.com/user-attachments/assets/77654bd6-c0ef-4019-b97b-58892389650b)
而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
![image](https://github.com/user-attachments/assets/eb6bfeab-c0c4-4a4b-8a28-d54532553737)

delegatecall语法和call类似，也是：
```
目标合约地址.delegatecall(二进制编码);
```
其中二进制编码利用结构化编码函数abi.encodeWithSignature获得：
```
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
```
函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)。
**和call不一样，delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额**

目前delegatecall主要有两个应用场景：
1. 代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。
2. EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。

#### 被调用的合约C
有两个public变量：num和sender，分别是uint256和address类型；有一个函数，可以将num设定为传入的_num，并且将sender设为msg.sender。
```
// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}
```
#### 发起调用的合约B
合约B必须和目标合约C的变量存储布局必须相同，两个变量，并且顺序为num和sender
```
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
```

### 在合约中创建新合约
有两种方法可以在合约中创建新合约，create和create2
#### create
```
Contract x = new Contract{value: _value}(params)
```
其中Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数。

#### 极简Uniswap
Uniswap V2核心合约中包含两个合约：
1. UniswapV2Pair: 币对合约，用于管理币对地址、流动性、买卖。
2. UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。

#### Pair合约
```
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
```
构造函数constructor在部署时将factory赋值为工厂合约地址。initialize函数会由工厂合约在部署完成后手动调用以初始化代币地址，将token0和token1更新为币对中两种代币的地址。

#### PairFactory
```
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
工厂合约（PairFactory）有两个状态变量getPair是两个代币地址到币对地址的map，方便根据代币找到币对地址；allPairs是币对地址的数组，存储了所有代币地址。

### create2
CREATE2 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址。Uniswap创建Pair合约用的就是CREATE2而不是CREATE。
#### create如何计算地址
智能合约可以由其他合约和普通账户利用CREATE操作码创建。 在这两种情况下，新合约的地址都以相同的方式计算：创建者的地址(通常为部署的钱包地址或者合约地址)和nonce(该地址发送交易的总数,对于合约账户是创建的合约总数,每创建一个合约nonce+1)的哈希。
```
新地址 = hash(创建者地址, nonce)
```
#### create2如何计算地址
CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。用CREATE2创建的合约地址由4个部分决定：
- 0xFF：一个常数，避免和CREATE冲突
- CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
- salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
- initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
```
新地址 = hash("0xFF",创建者地址, salt, initcode)
```
CREATE2 确保，如果创建者使用 CREATE2 和提供的 salt 部署给定的合约initcode，它将存储在 新地址 中。

#### 如何使用create2
```
Contract x = new Contract{salt: _salt, value: _value}(params)
```

#### 极简Uniswap2
```
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
        // 用tokenA和tokenB地址计算salt
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
}
```
#### 事先计算Pair地址
calculateAddr函数来事先计算tokenA和tokenB将会生成的Pair地址。通过它，我们可以验证我们事先计算的地址和实际地址是否相同。
```
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
}
```
#### 如果部署合约构造函数中存在参数
计算时，需要将参数和initcode一起进行打包：
| keccak256(type(Pair).creationCode) => keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
```
predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
            )))));
```

### 删除合约
#### selfdestruct
可以用来删除智能合约，并将该合约剩余ETH转到指定地址。
selfdestruct是为了应对合约出错的极端情况而设计的。
原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以目前来说：
1. 已经部署的合约无法被SELFDESTRUCT了。
2. 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。
```
selfdestruct(_addr)；
```
#### 转移ETH功能
```
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
#### 同笔交易内实现合约创建-自毁
```
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
#### 注意事项
1. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
2. 当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

### 2024.9.29
### ABI解码
ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。

ABI编码有4个函数：abi.encode, abi.encodePacked, abi.encodeWithSignature, abi.encodeWithSelector。
而ABI解码有1个函数：abi.decode

ABI被设计出来跟智能合约交互，他将每个参数填充为32字节的数据，并拼接在一起。如果你要和合约交互，你要用的就是abi.encode。
```
function encode() public view returns(bytes memory result) {
    result = abi.encode(x, addr, name, array);
}
```

将给定参数根据其所需最低空间编码。它类似 abi.encode，但是会把其中填充的很多0省略。比如，只用1字节来编码uint8类型。当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked
```
function encodePacked() public view returns(bytes memory result) {
    result = abi.encodePacked(x, addr, name, array);
}
```

与abi.encode功能类似，只不过第一个参数为函数签名，比如"foo(uint256,address,string,uint256[2])"。当调用其他合约的时候可以使用。
```
function encodeWithSignature() public view returns(bytes memory result) {
    result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
}
```
等同于在abi.encode编码结果前加上了4字节的函数选择器说明。 说明: 函数选择器就是通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用

与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。
```
function encodeWithSelector() public view returns(bytes memory result) {
    result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
}
```

###
ABI解码
abi.decode用于解码abi.encode生成的二进制编码，将它还原成原本的参数。
```
function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
    (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
}
```

### Hash
是一个密码学概念，它可以将任意长度的消息转换为一个固定长度的值，这个值也称作哈希（hash）
1. 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
2. 灵敏性：输入的消息改变一点对它的哈希改变很大。
3. 高效性：从输入的消息到哈希的运算高效。
4. 均一性：每个哈希值被取到的概率应该基本相等。
5. 抗碰撞性：
   1. 弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
   2. 强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。

**应用**
1. 生成数据唯一标识
2. 加密签名
3. 安全加密

### Keccak256
Keccak256函数是Solidity中最常用的哈希函数，用法非常简单：
```
哈希 = keccak256(数据);
```
#### 生成数据唯一标识
我们可以利用keccak256来生成一些数据的唯一标识。比如我们有几个不同类型的数据：uint，string，address，我们可以先用abi.encodePacked方法将他们打包编码，然后再用keccak256来生成唯一标识：
```
function hash(
    uint _num,
    string memory _string,
    address _addr
    ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_num, _string, _addr));
}
```

### 函数选择器
当我们调用智能合约时，本质上是向目标合约发送了一段calldata，在remix中发送一次交易后，可以在详细信息中看见input即为此次交易的calldata
发送的calldata中前4个字节是selector（函数选择器）。
#### msg.data
msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）。
```
// event 返回msg.data
event Log(bytes data);
function mint(address to) external{
    emit Log(msg.data);
}
```
#### method id、selector和函数签名
由于计算method id时，需要通过函数名和函数的参数类型来计算。在Solidity中，函数的参数类型主要分为：基础类型参数，固定长度类型参数，可变长度类型参数和映射类型参数。

#### 基础类型参数
基础类型的参数有：uint256(uint8, ... , uint256)、bool, address等。在计算method id时，只需要计算bytes4(keccak256("函数名(参数类型1,参数类型2,...)"))。
```
    // elementary（基础）类型参数selector
    // 输入：param1: 1，param2: 0
    // elementaryParamSelector(uint256,bool) : 0x3ec37834
    function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4 selectorWithElementaryParam){
        emit SelectorEvent(this.elementaryParamSelector.selector);
        return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
    }
```
#### 固定长度类型参数
固定长度的参数类型通常为固定长度的数组，，在计算该函数的method id时，只需要通过bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))即可。
```
    // fixed size（固定长度）类型参数selector
    // 输入： param1: [1,2,3]
    // fixedSizeParamSelector(uint256[3]) : 0xead6b8bd
    function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4 selectorWithFixedSizeParam){
        emit SelectorEvent(this.fixedSizeParamSelector.selector);
        return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
    }
```
#### 可变长度参数类型
可变长度参数类型通常为可变长的数组，例如：address[]、uint8[]、string等
```
    // non-fixed size（可变长度）类型参数selector
    // 输入： param1: [1,2,3]， param2: "abc"
    // nonFixedSizeParamSelector(uint256[],string) : 0xf0ca01de
    function nonFixedSizeParamSelector(uint256[] memory param1,string memory param2) external returns(bytes4 selectorWithNonFixedSizeParam){
        emit SelectorEvent(this.nonFixedSizeParamSelector.selector);
        return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
    }
```
#### 映射类型参数
映射类型参数通常有：contract、enum、struct等。在计算method id时，需要将该类型转化成为ABI类型。
DemoContract需要转化为address，结构体User需要转化为tuple类型(uint256,bytes)，枚举类型School需要转化为uint8。因此，计算该函数的method id的代码为bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"))。
```
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

#### 使用selector
```
    // 使用selector来调用函数
    function callWithSignature() external{
    ...
        // 调用elementaryParamSelector函数
        (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
    ...
    }
```

### Try Catch
try-catch只能被用于external函数或创建合约时constructor（被视为external函数）的调用。
```
try externalContract.f() {
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```
同样可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。
如果调用的函数有返回值，那么必须在try之后声明returns(returnType val)，并且在try模块中可以使用返回的变量；如果是创建合约，那么返回值是新创建的合约变量。
```
try externalContract.f() returns(returnType val){
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```
#### catch模块支持捕获特殊的异常原因：
```
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

### 2024.9.30

### ERC20
它实现了代币转账的基本逻辑：
账户余额(balanceOf())
转账(transfer())
授权转账(transferFrom())
授权(approve())
代币总供给(totalSupply())
授权转账额度(allowance())
代币信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())

### IERC20
IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件。 之所以需要定义接口，是因为有了规范后，就存在所有的ERC20代币都通用的函数名称，输入参数，输出参数。 在接口函数中，只需要定义函数名称，输入参数，输出参数，并不关心函数内部如何实现。 由此，函数就分为内部和外部两个内容，一个重点是实现，另一个是对外接口，约定共同数据。 这就是为什么需要ERC20.sol和IERC20.sol两个文件实现一个合约。
#### 事件
```
/**
 * @dev 释放条件：当 `value` 单位的货币从账户 (`from`) 转账到另一账户 (`to`)时.
 */
event Transfer(address indexed from, address indexed to, uint256 value);

/**
 * @dev 释放条件：当 `value` 单位的货币从账户 (`owner`) 授权给另一账户 (`spender`)时.
 */
event Approval(address indexed owner, address indexed spender, uint256 value);
```
#### 函数
```
/**
 * @dev 返回代币总供给.
 */
function totalSupply() external view returns (uint256);
/**
 * @dev 返回账户`account`所持有的代币数.
 */
function balanceOf(address account) external view returns (uint256);
/**
 * @dev 转账 `amount` 单位代币，从调用者账户到另一账户 `to`.
 *
 * 如果成功，返回 `true`.
 *
 * 释放 {Transfer} 事件.
 */
function transfer(address to, uint256 amount) external returns (bool);
/**
 * @dev 返回`owner`账户授权给`spender`账户的额度，默认为0。
 *
 * 当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
 */
function allowance(address owner, address spender) external view returns (uint256);
/**
 * @dev 调用者账户给`spender`账户授权 `amount`数量代币。
 *
 * 如果成功，返回 `true`.
 *
 * 释放 {Approval} 事件.
 */
function approve(address spender, uint256 amount) external returns (bool);
/**
 * @dev 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
 *
 * 如果成功，返回 `true`.
 *
 * 释放 {Transfer} 事件.
 */
function transferFrom(
    address from,
    address to,
    uint256 amount
) external returns (bool);
```

#### 状态变量
我们需要状态变量来记录账户余额，授权额度和代币信息。其中balanceOf, allowance和totalSupply为public类型，会自动生成一个同名getter函数，实现IERC20规定的balanceOf(), allowance()和totalSupply()。而name, symbol, decimals则对应代币的名称，代号和小数位数。
```
mapping(address => uint256) public override balanceOf;

mapping(address => mapping(address => uint256)) public override allowance;

uint256 public override totalSupply;   // 代币总供给

string public name;   // 名称
string public symbol;  // 代号

uint8 public decimals = 18; // 小数位数
// 构造函数：初始化代币名称、代号。
constructor(string memory name_, string memory symbol_){
    name = name_;
    symbol = symbol_;
}
// transfer()函数：实现IERC20中的transfer函数，代币转账逻辑。调用方扣除amount数量代币，接收方增加相应代币。土狗币会魔改这个函数，加入税收、分红、抽奖等逻辑。
function transfer(address recipient, uint amount) public override returns (bool) {
    balanceOf[msg.sender] -= amount;
    balanceOf[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
    return true;
}
// approve()函数：实现IERC20中的approve函数，代币授权逻辑。被授权方spender可以支配授权方的amount数量的代币。spender可以是EOA账户，也可以是合约账户：当你用uniswap交易代币时，你需要将代币授权给uniswap合约。
function approve(address spender, uint amount) public override returns (bool) {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
// transferFrom()函数：实现IERC20中的transferFrom函数，授权转账逻辑。被授权方将授权方sender的amount数量的代币转账给接收方recipient。
function transferFrom(
    address sender,
    address recipient,
    uint amount
) public override returns (bool) {
    allowance[sender][msg.sender] -= amount;
    balanceOf[sender] -= amount;
    balanceOf[recipient] += amount;
    emit Transfer(sender, recipient, amount);
    return true;
}
// mint()函数：铸造代币函数，不在IERC20标准中。这里为了教程方便，任何人可以铸造任意数量的代币，实际应用中会加权限管理，只有owner可以铸造代币：
function mint(uint amount) external {
    balanceOf[msg.sender] += amount;
    totalSupply += amount;
    emit Transfer(address(0), msg.sender, amount);
}
// burn()函数：销毁代币函数，不在IERC20标准中。
function burn(uint amount) external {
    balanceOf[msg.sender] -= amount;
    totalSupply -= amount;
    emit Transfer(msg.sender, address(0), amount);
}
```

### 代币水龙头
```
// 状态变量
uint256 public amountAllowed = 100; // 每次领 100 单位代币
address public tokenContract;   // token合约地址
mapping(address => bool) public requestedAddress;   // 记录领取过代币的地址
// 事件
// SendToken事件    
event SendToken(address indexed Receiver, uint256 indexed Amount);
// 函数
// 部署时设定ERC20代币合约
constructor(address _tokenContract) {
  tokenContract = _tokenContract; // set token contract
}
// 用户领取代币函数
function requestTokens() external {
    require(!requestedAddress[msg.sender], "Can't Request Multiple Times!"); // 每个地址只能领一次
    IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // 水龙头空了

    token.transfer(msg.sender, amountAllowed); // 发送token
    requestedAddress[msg.sender] = true; // 记录领取地址 
    
    emit SendToken(msg.sender, amountAllowed); // 释放SendToken事件
}
```

### 空投合约
Airdrop空投合约逻辑非常简单：利用循环，一笔交易将ERC20代币发送给多个地址。
```
// 数组求和函数
function getSum(uint256[] calldata _arr) public pure returns(uint sum){
    for(uint i = 0; i < _arr.length; i++)
        sum = sum + _arr[i];
}
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
        // 注释代码有Dos攻击风险, 并且transfer 也是不推荐写法
        // Dos攻击 具体参考 https://github.com/AmazingAng/WTF-Solidity/blob/main/S09_DoS/readme.md
        // _addresses[i].transfer(_amounts[i]);
        (bool success, ) = _addresses[i].call{value: _amounts[i]}("");
        if (!success) {
            failTransferList[_addresses[i]] = _amounts[i];
        }
    }
}
```

### ERC721
EIP全称 Ethereum Improvement Proposals(以太坊改进建议), 是以太坊开发者社区提出的改进建议, 是一系列以编号排定的文件, 类似互联网上IETF的RFC。
EIP可以是 Ethereum 生态中任意领域的改进, 比如新特性、ERC、协议改进、编程工具等等。
ERC全称 Ethereum Request For Comment (以太坊意见征求稿), 用以记录以太坊上应用级的各种开发标准和协议。如典型的Token标准(ERC20, ERC721)、名字注册(ERC26, ERC13), URI范式(ERC67), Library/Package格式(EIP82), 钱包格式(EIP75,EIP85)。
**EIP包含ERC**

### ERC165
智能合约可以声明它支持的接口，供其他合约检查。简单的说，ERC165就是检查一个智能合约是不是支持了ERC721，ERC1155的接口。
```
interface IERC165 {
    /**
     * @dev 如果合约实现了查询的`interfaceId`，则返回true
     * 规则详见：https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     *
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
    function supportsInterface(bytes4 interfaceId) external pure override returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }
```

### IERC721
IERC721是ERC721标准的接口合约，规定了ERC721要实现的基本函数。它利用tokenId来表示特定的非同质化代币，授权或转账都要明确tokenId；而ERC20只需要明确转账的数额即可。
```
/**
 * @dev ERC721标准接口.
 */
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

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

#### IERC721事件
IERC721包含3个事件，其中Transfer和Approval事件在ERC20中也有。

Transfer事件：在转账时被释放，记录代币的发出地址from，接收地址to和tokenid。
Approval事件：在授权时释放，记录授权地址owner，被授权地址approved和tokenid。
ApprovalForAll事件：在批量授权时释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。

#### IERC721函数
balanceOf：返回某地址的NFT持有量balance。
ownerOf：返回某tokenId的主人owner。
transferFrom：普通转账，参数为转出地址from，接收地址to和tokenId。
safeTransferFrom：安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。
approve：授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
getApproved：查询tokenId被批准给了哪个地址。
setApprovalForAll：将自己持有的该系列NFT批量授权给某个地址operator。
isApprovedForAll：查询某地址的NFT是否批量授权给了另一个operator地址。
safeTransferFrom：安全转账的重载函数，参数里面包含了data。

#### IERC721 Receiver
如果一个合约没有实现ERC721的相关函数，转入的NFT就进了黑洞，永远转不出来了。为了防止误转账，ERC721实现了safeTransferFrom()安全转账函数，目标合约必须实现了IERC721Receiver接口才能接收ERC721代币，不然会revert。
```
// ERC721接收者接口：合约必须实现这个接口来通过安全转账接收ERC721
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
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

#### IERC721 Metadata
IERC721Metadata是ERC721的拓展接口，实现了3个查询metadata元数据的常用函数：

name()：返回代币名称。
symbol()：返回代币代号。
tokenURI()：通过tokenId查询metadata的链接url，ERC721特有的函数。
```
interface IERC721Metadata is IERC721 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
}
```

### ERC721主合约
```
// SPDX-License-Identifier: MIT
// by 0xAA
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

### 免费铸造的APE
```
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./ERC721.sol";

contract WTFApe is ERC721{
    uint public MAX_APES = 10000; // 总量

    // 构造函数
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
    }

    //BAYC的baseURI为ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/ 
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }
    
    // 铸造函数
    function mint(address to, uint tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_APES, "tokenId out of range");
        _mint(to, tokenId);
    }
}
```

为了防止NFT被转到一个没有能力操作NFT的合约中去,目标必须正确实现ERC721TokenReceiver接口：
```
interface ERC721TokenReceiver {
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4);
}
```
接口是某些行为的集合(在solidity中更甚，接口完全等价于函数选择器的集合)，某个类型只要实现了某个接口，就表明该类型拥有这样的一种功能。因此，只要某个contract类型实现了上述的ERC721TokenReceiver接口(更具体而言就是实现了onERC721Received这个函数),该contract类型就对外表明了自己拥有管理NFT的能力。
ERC165是一种对外表明自己实现了哪些接口的技术标准。就像上面所说的，实现了一个接口就表明合约拥有种特殊能力。有一些合约与其他合约交互时，期望目标合约拥有某些功能，那么合约之间就能够通过ERC165标准对对方进行查询以检查对方是否拥有相应的能力。
```
/// 注意这个**0x80ac58cd**
///  **⚠⚠⚠ Note: the ERC-165 identifier for this interface is 0x80ac58cd. ⚠⚠⚠**
interface ERC721 /* is ERC165 */ {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

    function approve(address _approved, uint256 _tokenId) external payable;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}
```

### 荷兰拍卖 Dutch Auction
亦称“减价拍卖”，它是指拍卖标的的竞价由高到低依次递减直到第一个竞买人应价（达到或超过底价）时击槌成交的一种拍卖。
项目方非常喜欢这种拍卖形式，主要有两个原因
1. 荷兰拍卖的价格由最高慢慢下降，能让项目方获得最大的收入。
2. 拍卖持续较长时间（通常6小时以上），可以避免gas war。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";

contract DutchAuction is Ownable, ERC721 {
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

    constructor() ERC721("WTF Dutch Auctoin", "WTF Dutch Auctoin") {
        auctionStartTime = block.timestamp;
    }

    // auctionStartTime setter函数，onlyOwner
    function setAuctionStartTime(uint32 timestamp) external onlyOwner {
        auctionStartTime = timestamp;
    }
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
    // 拍卖mint函数
    function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // 检查是否设置起拍时间，拍卖是否开始
        require(
        totalSupply() + quantity <= COLLECTOIN_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // 检查是否超过NFT上限

        uint256 totalCost = getAuctionPrice() * quantity; // 计算mint成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 检查用户是否支付足够ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多余ETH退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); //注意一下这里是否有重入的风险
        }
    }
    // 提款函数，onlyOwner
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}(""); // call函数的调用方式详见第22讲
        require(success, "Transfer failed.");
    }
```

### 2024.10.1
### Merkel Tree

![image](https://github.com/user-attachments/assets/e2eaab42-5ed0-4726-8da7-62916f43edf3)
Merkle Tree允许对大型数据结构的内容进行有效和安全的验证（Merkle Proof）。对于有N个叶子结点的Merkle Tree，在已知root根值的情况下，验证某个数据是否有效（属于Merkle Tree叶子结点）只需要ceil(log₂N)个数据（也叫proof），非常高效。

![image](https://github.com/user-attachments/assets/8308df8e-c571-4550-8315-58ea509490d9)

**利用MerkleProof库来验证
```
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
**verify()函数**：利用proof数来验证leaf是否属于根为root的Merkle Tree中，如果是，则返回true。它调用了processProof()函数。
**processProof()函数**：利用proof和leaf依次计算出Merkle Tree的root。它调用了_hashPair()函数。
**_hashPair()函数**：用keccak256()函数计算非根节点对应的两个子节点的哈希（排序后）。

### 利用MerkleTree发放NFT白名单
```
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

### 数字签名
**双椭圆曲线数字签名算法（ECDSA）**，基于双椭圆曲线“私钥-公钥”对的数字签名算法。它主要起到了三个作用：
1. 身份认证：证明签名方是私钥的持有人。
2. 不可否认：发送方不能否认发送过这个消息。
3. 完整性：通过验证针对传输消息生成的数字签名，可以验证消息是否在传输过程中被篡改。

### ECDSA合约
ECDSA标准中包含两个部分：
1. 签名者利用私钥（隐私的）对消息（公开的）创建签名（公开的）。
2. 其他人使用消息（公开的）和签名（公开的）恢复签名者的公钥（公开的）并验证签名。

#### 创建签名
1. 打包消息
被签名的消息是一组数据的keccak256哈希，为bytes32类型。
```
    /*
     * 将mint地址（address类型）和tokenId（uint256类型）拼成消息msgHash
     * _account: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
     * _tokenId: 0
     * 对应的消息msgHash: 0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
     */
    function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_account, _tokenId));
    }
```
2. 计算以太坊签名信息
消息可以是能被执行的交易，也可以是其他任何形式。为了避免用户误签了恶意交易，EIP191提倡在消息前加上"\x19Ethereum Signed Message:\n32"字符，并再做一次keccak256哈希，作为以太坊签名消息。经过toEthSignedMessageHash()函数处理后的消息，不能被用于执行交易:
```
    /**
     * @dev 返回 以太坊签名消息
     * `hash`：消息
     * 遵从以太坊签名标准：https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`]
     * 以及`EIP191`:https://eips.ethereum.org/EIPS/eip-191`
     * 添加"\x19Ethereum Signed Message:\n32"字段，防止签名的是可执行交易。
     */
    function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
        // 哈希的长度为32
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
```
3. 利用钱包签名
metamask的personal_sign方法会自动把消息转换为以太坊签名消息，然后发起签名。所以我们只需要输入消息和签名者钱包account即可。
4. 利用web3.py签名
```
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
#### 验证签名
验证者需要拥有消息，签名，和签名使用的公钥。我们能验证签名的原因是只有私钥的持有者才能够针对交易生成这样的签名，而别人不能。
5. 通过签名和消息回复公钥
签名是由数学算法生成的。这里我们使用的是rsv签名，签名中包含r, s, v三个值的信息。而后，我们可以通过r, s, v及以太坊签名消息来求得公钥。
```
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
            r := mload(add(_signature, 0x20))
            // 读取之后的32 bytes
            s := mload(add(_signature, 0x40))
            // 读取最后一个byte
            v := byte(0, mload(add(_signature, 0x60)))
        }
        // 使用ecrecover(全局函数)：利用 msgHash 和 r,s,v 恢复 signer 地址
        return ecrecover(_msgHash, v, r, s);
    }
```
6. 对比公钥并验证签名
```
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

### 利用签名发放白名单
NFT项目方可以利用ECDSA的这个特性发放白名单。由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济。方法非常简单，项目方利用项目方账户把白名单发放地址签名（可以加上地址可以铸造的tokenId）。然后mint的时候利用ECDSA检验签名是否有效，如果有效，则给他mint。
SignatureNFT合约实现了利用签名发放NFT白名单。
```
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
由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济；
但由于用户要请求中心化接口去获取签名，不可避免的牺牲了一部分去中心化；
额外还有一个好处是白名单可以动态变化，而不是提前写死在合约里面了，因为项目方的中心化后端接口可以接受任何新地址的请求并给予白名单签名。

### NFT交易所
```
// 事件
    event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
    event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId);    
    event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice);
// 订单
    // 定义order结构体
    struct Order{
        address owner;
        uint256 price; 
    }
    // NFT Order映射
    mapping(address => mapping(uint256 => Order)) public nftList;
// 回退函数
fallback() external payable{}
// onERC721Received
contract NFTSwap is IERC721Receiver{

    // 实现{IERC721Receiver}的onERC721Received，能够接收ERC721代币
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }

// 交易
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

### 2024.10.2
### 链上随机数
#### 链上随机数生成
可以将一些链上的全局变量作为种子，利用keccak256()哈希函数来获取伪随机数。这是因为哈希函数具有灵敏性和均一性，可以得到“看似”随机的结果。
```
    /** 
    * 链上伪随机数生成
    * 利用keccak256()打包一些链上的全局变量/自定义变量
    * 返回时转换成uint256类型
    */
    function getRandomOnchain() public view returns(uint256){
        // remix运行blockhash会报错
        bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));
        
        return uint256(randomBytes);
    }
```
**这个方法并不安全：**
首先，block.timestamp，msg.sender和blockhash(block.number-1)这些变量都是公开的，使用者可以预测出用这些种子生成出的随机数，并挑出他们想要的随机数执行合约。
其次，矿工可以操纵blockhash和block.timestamp，使得生成的随机数符合他的利益。

#### 链下随机数生成
可以在链下生成随机数，然后通过预言机把随机数上传到链上。Chainlink提供VRF（可验证随机函数）服务，链上开发者可以支付LINK代币来获取随机数。
![image](https://github.com/user-attachments/assets/a3885099-af43-4bd2-a318-21eea746a7af)
1. 申请Subscription并转入Link代币
2. 用户合约继承VRFConsumerBaseV2
3. 用户合约申请随机数
4. Chainlink节点链下生成随机数和数字签名，并发送给VRF合约
5. VRF合约验证签名有效性
6. 用户合约接收并使用随机数

#### tokenId随机铸造的NFT
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Random is ERC721, VRFConsumerBaseV2{
    // NFT相关
    uint256 public totalSupply = 100; // 总供给
    uint256[100] public ids; // 用于计算可供mint的tokenId
    uint256 public mintCount; // 已mint数量

    // chainlink VRF参数
    
    //VRFCoordinatorV2Interface
    VRFCoordinatorV2Interface COORDINATOR;
    
    /**
     * 使用chainlink VRF，构造函数需要继承 VRFConsumerBaseV2
     * 不同链参数填的不一样
     * 网络: Sepolia测试网
     * Chainlink VRF Coordinator 地址: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625
     * LINK 代币地址: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     * 30 gwei Key Hash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c
     * Minimum Confirmations 最小确认块数 : 3 （数字大安全性高，一般填12）
     * callbackGasLimit gas限制 : 最大 2,500,000
     * Maximum Random Values 一次可以得到的随机数个数 : 最大 500          
     */
    address vrfCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625;
    bytes32 keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 1_000_000;
    uint32 numWords = 1;
    uint64 subId;
    uint256 public requestId;
    
    // 记录VRF申请标识对应的mint地址
    mapping(uint256 => address) public requestToSender;

    constructor(uint64 s_subId) 
        VRFConsumerBaseV2(vrfCoordinator)
        ERC721("WTF Random", "WTF"){
            COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
            subId = s_subId;
    }

    /** 
    * 输入uint256数字，返回一个可以mint的tokenId
    * 算法过程可理解为：totalSupply个空杯子（0初始化的ids）排成一排，每个杯子旁边放一个球，编号为[0, totalSupply - 1]。
    每次从场上随机拿走一个球（球可能在杯子旁边，这是初始状态；也可能是在杯子里，说明杯子旁边的球已经被拿走过，则此时新的球从末尾被放到了杯子里）
    再把末尾的一个球（依然是可能在杯子里也可能在杯子旁边）放进被拿走的球的杯子里，循环totalSupply次。相比传统的随机排列，省去了初始化ids[]的gas。
    */
    function pickRandomUniqueId(uint256 random) private returns (uint256 tokenId) {
        //先计算减法，再计算++, 关注(a++，++a)区别
        uint256 len = totalSupply - mintCount++; // 可mint数量
        require(len > 0, "mint close"); // 所有tokenId被mint完了
        uint256 randomIndex = random % len; // 获取链上随机数

        //随机数取模，得到tokenId，作为数组下标，同时记录value为len-1，如果取模得到的值已存在，则tokenId取该数组下标的value
        tokenId = ids[randomIndex] != 0 ? ids[randomIndex] : randomIndex; // 获取tokenId
        ids[randomIndex] = ids[len - 1] == 0 ? len - 1 : ids[len - 1]; // 更新ids 列表
        ids[len - 1] = 0; // 删除最后一个元素，能返还gas
    }

    /** 
    * 链上伪随机数生成
    * keccak256(abi.encodePacked()中填上一些链上的全局变量/自定义变量
    * 返回时转换成uint256类型
    */
    function getRandomOnchain() public view returns(uint256){
        /*
         * 本例链上随机只依赖区块哈希，调用者地址，和区块时间，
         * 想提高随机性可以再增加一些属性比如nonce等，但是不能根本上解决安全问题
         */
        bytes32 randomBytes = keccak256(abi.encodePacked(blockhash(block.number-1), msg.sender, block.timestamp));
        return uint256(randomBytes);
    }

    // 利用链上伪随机数铸造NFT
    function mintRandomOnchain() public {
        uint256 _tokenId = pickRandomUniqueId(getRandomOnchain()); // 利用链上随机数生成tokenId
        _mint(msg.sender, _tokenId);
    }

    /** 
     * 调用VRF获取随机数，并mintNFT
     * 要调用requestRandomness()函数获取，消耗随机数的逻辑写在VRF的回调函数fulfillRandomness()中
     * 调用前，需要在Subscriptions中转入足够的Link
     */
    function mintRandomVRF() public {
        // 调用requestRandomness获取随机数
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requestToSender[requestId] = msg.sender;
    }

    /**
     * VRF的回调函数，由VRF Coordinator调用
     * 消耗随机数的逻辑写在本函数中
     */
    function fulfillRandomWords(uint256 requestId, uint256[] memory s_randomWords) internal override{
        address sender = requestToSender[requestId]; // 从requestToSender中获取minter用户地址
        uint256 tokenId = pickRandomUniqueId(s_randomWords[0]); // 利用VRF返回的随机数生成tokenId
        _mint(sender, tokenId);
    }
```

### ERC1155
允许一个合约包含多个同质化和非同质化代币。ERC1155在GameFi应用最多
在ERC721中，每个代币都有一个tokenId作为唯一标识，每个tokenId只对应一个代币；而在ERC1155中，每一种代币都有一个id作为唯一标识，每个id对应一种代币。这样，代币种类就可以非同质的在同一个合约里管理了，并且每种代币都有一个网址uri来存储它的元数据，类似ERC721的tokenURI。

如果某个id对应的代币总量为1，那么它就是非同质化代币，类似ERC721；如果某个id对应的代币总量大于1，那么他就是同质化代币，因为这些代币都分享同一个id，类似ERC20。

#### IERC1155接口合约
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

/**
 * @dev ERC1155标准的接口合约，实现了EIP1155的功能
 * 详见：https://eips.ethereum.org/EIPS/eip-1155[EIP].
 */
interface IERC1155 is IERC165 {
    /**
     * @dev 单类代币转账事件
     * 当`value`个`id`种类的代币被`operator`从`from`转账到`to`时释放.
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev 批量代币转账事件
     * ids和values为转账的代币种类和数量数组
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev 批量授权事件
     * 当`account`将所有代币授权给`operator`时释放
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev 当`id`种类的代币的URI发生变化时释放，`value`为新的URI
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev 持仓查询，返回`account`拥有的`id`种类的代币的持仓量
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * @dev 批量持仓查询，`accounts`和`ids`数组的长度要想等。
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev 批量授权，将调用者的代币授权给`operator`地址。
     * 释放{ApprovalForAll}事件.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev 批量授权查询，如果授权地址`operator`被`account`授权，则返回`true`
     * 见 {setApprovalForAll}函数.
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev 安全转账，将`amount`单位`id`种类的代币从`from`转账给`to`.
     * 释放{TransferSingle}事件.
     * 要求:
     * - 如果调用者不是`from`地址而是授权地址，则需要得到`from`的授权
     * - `from`地址必须有足够的持仓
     * - 如果接收方是合约，需要实现`IERC1155Receiver`的`onERC1155Received`方法，并返回相应的值
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev 批量安全转账
     * 释放{TransferBatch}事件
     * 要求：
     * - `ids`和`amounts`长度相等
     * - 如果接收方是合约，需要实现`IERC1155Receiver`的`onERC1155BatchReceived`方法，并返回相应的值
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
```
**IERC1155事件**
TransferSingle事件：单类代币转账事件，在单币种转账时释放。
TransferBatch事件：批量代币转账事件，在多币种转账时释放。
ApprovalForAll事件：批量授权事件，在批量授权时释放。
URI事件：元数据地址变更事件，在uri变化时释放。
**IERC1155函数**
balanceOf()：单币种余额查询，返回account拥有的id种类的代币的持仓量。
balanceOfBatch()：多币种余额查询，查询的地址accounts数组和代币种类ids数组的长度要相等。
setApprovalForAll()：批量授权，将调用者的代币授权给operator地址。。
isApprovedForAll()：查询批量授权信息，如果授权地址operator被account授权，则返回true。
safeTransferFrom()：安全单币转账，将amount单位id种类的代币从from地址转账给to地址。如果to地址是合约，则会验证是否实现了onERC1155Received()接收函数。
safeBatchTransferFrom()：安全多币转账，与单币转账类似，只不过转账数量amounts和代币种类ids变为数组，且长度相等。如果to地址是合约，则会验证是否实现了onERC1155BatchReceived()接收函数。

#### ERC1155接收合约
```
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

#### ERC1155主合约
**ERC1155变量**
ERC1155主合约包含4个状态变量：

name：代币名称
symbol：代币代号
_balances：代币持仓映射，记录代币种类id下某地址account的持仓量balances。
_operatorApprovals：批量授权映射，记录持有地址给另一个地址的授权情况。

**ERC1155函数**
ERC1155主合约包含16个函数：

构造函数：初始化状态变量name和symbol。
supportsInterface()：实现ERC165标准，声明它支持的接口，供其他合约检查。
balanceOf()：实现IERC1155的balanceOf()，查询持仓量。与ERC721标准不同，这里需要输入查询的持仓地址account以及币种id。
balanceOfBatch()：实现IERC1155的balanceOfBatch()，批量查询持仓量。
setApprovalForAll()：实现IERC1155的setApprovalForAll()，批量授权，释放ApprovalForAll事件。
isApprovedForAll()：实现IERC1155的isApprovedForAll()，查询批量授权信息。
safeTransferFrom()：实现IERC1155的safeTransferFrom()，单币种安全转账，释放TransferSingle事件。与ERC721不同，这里不仅需要填发出方from，接收方to，代币种类id，还需要填转账数额amount。
safeBatchTransferFrom()：实现IERC1155的safeBatchTransferFrom()，多币种安全转账，释放TransferBatch事件。
_mint()：单币种铸造函数。
_mintBatch()：多币种铸造函数。
_burn()：单币种销毁函数。
_burnBatch()：多币种销毁函数。
_doSafeTransferAcceptanceCheck：单币种转账的安全检查，被safeTransferFrom()调用，确保接收方为合约的情况下，实现了onERC1155Received()函数。
_doSafeBatchTransferAcceptanceCheck：多币种转账的安全检查，，被safeBatchTransferFrom调用，确保接收方为合约的情况下，实现了onERC1155BatchReceived()函数。
uri()：返回ERC1155的第id种代币存储元数据的网址，类似ERC721的tokenURI。
baseURI()：返回baseURI，uri就是把baseURI和id拼接在一起，需要开发重写。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Receiver.sol";
import "./IERC1155MetadataURI.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/Address.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/String.sol";
import "https://github.com/AmazingAng/WTF-Solidity/blob/main/34_ERC721/IERC165.sol";

/**
 * @dev ERC1155多代币标准
 * 见 https://eips.ethereum.org/EIPS/eip-1155
 */
contract ERC1155 is IERC165, IERC1155, IERC1155MetadataURI {
    using Address for address; // 使用Address库，用isContract来判断地址是否为合约
    using Strings for uint256; // 使用String库
    // Token名称
    string public name;
    // Token代号
    string public symbol;
    // 代币种类id 到 账户account 到 余额balances 的映射
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // address 到 授权地址 的批量授权映射
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * 构造函数，初始化`name` 和`symbol`, uri_
     */
    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return
            interfaceId == type(IERC1155).interfaceId ||
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    /**
     * @dev 持仓查询 实现IERC1155的balanceOf，返回account地址的id种类代币持仓量。
     */
    function balanceOf(address account, uint256 id) public view virtual override returns (uint256) {
        require(account != address(0), "ERC1155: address zero is not a valid owner");
        return _balances[id][account];
    }

    /**
     * @dev 批量持仓查询
     * 要求:
     * - `accounts` 和 `ids` 数组长度相等.
     */
    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public view virtual override
        returns (uint256[] memory)
    {
        require(accounts.length == ids.length, "ERC1155: accounts and ids length mismatch");
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }

    /**
     * @dev 批量授权，调用者授权operator使用其所有代币
     * 释放{ApprovalForAll}事件
     * 条件：msg.sender != operator
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(msg.sender != operator, "ERC1155: setting approval status for self");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev 查询批量授权.
     */
    function isApprovedForAll(address account, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev 安全转账，将`amount`单位的`id`种类代币从`from`转账到`to`
     * 释放 {TransferSingle} 事件.
     * 要求:
     * - to 不能是0地址.
     * - from拥有足够的持仓量，且调用者拥有授权
     * - 如果 to 是智能合约, 他必须支持 IERC1155Receiver-onERC1155Received.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // 调用者是持有者或是被授权
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(to != address(0), "ERC1155: transfer to the zero address");
        // from地址有足够持仓
        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "ERC1155: insufficient balance for transfer");
        // 更新持仓量
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }
        _balances[id][to] += amount;
        // 释放事件
        emit TransferSingle(operator, from, to, id, amount);
        // 安全检查
        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);    
    }

    /**
     * @dev 批量安全转账，将`amounts`数组单位的`ids`数组种类代币从`from`转账到`to`
     * 释放 {TransferSingle} 事件.
     * 要求:
     * - to 不能是0地址.
     * - from拥有足够的持仓量，且调用者拥有授权
     * - 如果 to 是智能合约, 他必须支持 IERC1155Receiver-onERC1155BatchReceived.
     * - ids和amounts数组长度相等
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        address operator = msg.sender;
        // 调用者是持有者或是被授权
        require(
            from == operator || isApprovedForAll(from, operator),
            "ERC1155: caller is not token owner nor approved"
        );
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");
        require(to != address(0), "ERC1155: transfer to the zero address");

        // 通过for循环更新持仓  
        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "ERC1155: insufficient balance for transfer");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
            _balances[id][to] += amount;
        }

        emit TransferBatch(operator, from, to, ids, amounts);
        // 安全检查
        _doSafeBatchTransferAcceptanceCheck(operator, from, to, ids, amounts, data);    
    }

    /**
     * @dev 铸造
     * 释放 {TransferSingle} 事件.
     */
    function _mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");

        address operator = msg.sender;

        _balances[id][to] += amount;
        emit TransferSingle(operator, address(0), to, id, amount);

        _doSafeTransferAcceptanceCheck(operator, address(0), to, id, amount, data);
    }

    /**
     * @dev 批量铸造
     * 释放 {TransferBatch} 事件.
     */
    function _mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            _balances[ids[i]][to] += amounts[i];
        }

        emit TransferBatch(operator, address(0), to, ids, amounts);

        _doSafeBatchTransferAcceptanceCheck(operator, address(0), to, ids, amounts, data);
    }

    /**
     * @dev 销毁
     */
    function _burn(
        address from,
        uint256 id,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");

        address operator = msg.sender;

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }

        emit TransferSingle(operator, from, address(0), id, amount);
    }

    /**
     * @dev 批量销毁
     */
    function _burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");
        require(ids.length == amounts.length, "ERC1155: ids and amounts length mismatch");

        address operator = msg.sender;

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), ids, amounts);
    }

    // @dev ERC1155的安全转账检查
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    // @dev ERC1155的批量安全转账检查
    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try IERC1155Receiver(to).onERC1155BatchReceived(operator, from, ids, amounts, data) returns (
                bytes4 response
            ) {
                if (response != IERC1155Receiver.onERC1155BatchReceived.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    /**
     * @dev 返回ERC1155的id种类代币的uri，存储metadata，类似ERC721的tokenURI.
     */
    function uri(uint256 id) public view virtual override returns (string memory) {
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, id.toString())) : "";
    }

    /**
     * 计算{uri}的BaseURI，uri就是把baseURI和tokenId拼接在一起，需要开发重写.
     */
    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
}
```

#### 魔改BAYC
```
// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.21;

import "./ERC1155.sol";

contract BAYC1155 is ERC1155{
    uint256 constant MAX_ID = 10000; 
    // 构造函数
    constructor() ERC1155("BAYC1155", "BAYC1155"){
    }

    //BAYC的baseURI为ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/ 
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }
    
    // 铸造函数
    function mint(address to, uint256 id, uint256 amount) external {
        // id 不能超过10,000
        require(id < MAX_ID, "id overflow");
        _mint(to, id, amount, "");
    }

    // 批量铸造函数
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts) external {
        // id 不能超过10,000
        for (uint256 i = 0; i < ids.length; i++) {
            require(ids[i] < MAX_ID, "id overflow");
        }
        _mintBatch(to, ids, amounts, "");
    }
}
```

### WETH
以太币本身并不符合ERC20标准。WETH的开发是为了提高区块链之间的互操作性 ，并使ETH可用于去中心化应用程序（dApps）。它就像是给原生代币穿了一件智能合约做的衣服：穿上衣服的时候，就变成了WETH，符合ERC20同质化代币标准，可以跨链，可以用于dApp；脱下衣服，它可1:1兑换ETH。

#### WETH合约
```
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

### 分账
#### 分账合约
分账合约(PaymentSplit)具有以下几个特点：
1. 在创建合约时定好分账受益人payees和每人的份额shares。
2. 份额可以是相等，也可以是其他任意比例。
3. 在该合约收到的所有ETH中，每个受益人将能够提取与其分配的份额成比例的金额。
4.分账合约遵循Pull Payment模式，付款不会自动转入账户，而是保存在此合约中。受益人通过调用release()函数触发实际转账。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * 分账合约 
 * @dev 这个合约会把收到的ETH按事先定好的份额分给几个账户。收到ETH会存在分账合约中，需要每个受益人调用release()函数来领取。
 */
contract PaymentSplit{
    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合约收款事件

uint256 public totalShares; // 总份额
    uint256 public totalReleased; // 总支付

    mapping(address => uint256) public shares; // 每个受益人的份额
    mapping(address => uint256) public released; // 支付给每个受益人的金额
    address[] public payees; // 受益人数组

    /**
     * @dev 初始化受益人数组_payees和分账份额数组_shares
     * 数组长度不能为0，两个数组长度要相等。_shares中元素要大于0，_payees中地址不能为0地址且不能有重复地址
     */
    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // 检查_payees和_shares数组长度相同，且不为0
        require(_payees.length == _shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(_payees.length > 0, "PaymentSplitter: no payees");
        // 调用_addPayee，更新受益人地址payees、受益人份额shares和总份额totalShares
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }

    /**
     * @dev 回调函数，收到ETH释放PaymentReceived事件
     */
    receive() external payable virtual {
        emit PaymentReceived(msg.sender, msg.value);
    }

    /**
     * @dev 为有效受益人地址_account分帐，相应的ETH直接发送到受益人地址。任何人都可以触发这个函数，但钱会打给account地址。
     * 调用了releasable()函数。
     */
    function release(address payable _account) public virtual {
        // account必须是有效受益人
        require(shares[_account] > 0, "PaymentSplitter: account has no shares");
        // 计算account应得的eth
        uint256 payment = releasable(_account);
        // 应得的eth不能为0
        require(payment != 0, "PaymentSplitter: account is not due payment");
        // 更新总支付totalReleased和支付给每个受益人的金额released
        totalReleased += payment;
        released[_account] += payment;
        // 转账
        _account.transfer(payment);
        emit PaymentReleased(_account, payment);
    }

    /**
     * @dev 计算一个账户能够领取的eth。
     * 调用了pendingPayment()函数。
     */
    function releasable(address _account) public view returns (uint256) {
        // 计算分账合约总收入totalReceived
        uint256 totalReceived = address(this).balance + totalReleased;
        // 调用_pendingPayment计算account应得的ETH
        return pendingPayment(_account, totalReceived, released[_account]);
    }

    /**
     * @dev 根据受益人地址`_account`, 分账合约总收入`_totalReceived`和该地址已领取的钱`_alreadyReleased`，计算该受益人现在应分的`ETH`。
     */
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // account应得的ETH = 总应得ETH - 已领到的ETH
        return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased;
    }

    /**
     * @dev 新增受益人_account以及对应的份额_accountShares。只能在构造器中被调用，不能修改。
     */
    function _addPayee(address _account, uint256 _accountShares) private {
        // 检查_account不为0地址
        require(_account != address(0), "PaymentSplitter: account is the zero address");
        // 检查_accountShares不为0
        require(_accountShares > 0, "PaymentSplitter: shares are 0");
        // 检查_account不重复
        require(shares[_account] == 0, "PaymentSplitter: account already has shares");
        // 更新payees，shares和totalShares
        payees.push(_account);
        shares[_account] = _accountShares;
        totalShares += _accountShares;
        // 释放增加受益人事件
        emit PayeeAdded(_account, _accountShares);
    }
```

### 线性释放
### 代币归属条款Token Vesting
线性释放指的是代币在归属期内匀速释放。
```
contract TokenVesting {
    // 事件
    event ERC20Released(address indexed token, uint256 amount); // 提币事件

    // 状态变量
    mapping(address => uint256) public erc20Released; // 代币地址->释放数量的映射，记录已经释放的代币
    address public immutable beneficiary; // 受益人地址
    uint256 public immutable start; // 起始时间戳
    uint256 public immutable duration; // 归属期

    /**
     * @dev 初始化受益人地址，释放周期(秒), 起始时间戳(当前区块链时间戳)
     */
    constructor(
        address beneficiaryAddress,
        uint256 durationSeconds
    ) {
        require(beneficiaryAddress != address(0), "VestingWallet: beneficiary is zero address");
        beneficiary = beneficiaryAddress;
        start = block.timestamp;
        duration = durationSeconds;
    }

    /**
     * @dev 受益人提取已释放的代币。
     * 调用vestedAmount()函数计算可提取的代币数量，然后transfer给受益人。
     * 释放 {ERC20Released} 事件.
     */
    function release(address token) public {
        // 调用vestedAmount()函数计算可提取的代币数量
        uint256 releasable = vestedAmount(token, uint256(block.timestamp)) - erc20Released[token];
        // 更新已释放代币数量   
        erc20Released[token] += releasable; 
        // 转代币给受益人
        emit ERC20Released(token, releasable);
        IERC20(token).transfer(beneficiary, releasable);
    }

    /**
     * @dev 根据线性释放公式，计算已经释放的数量。开发者可以通过修改这个函数，自定义释放方式。
     * @param token: 代币地址
     * @param timestamp: 查询的时间戳
     */
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


### 2024.10.3
### 代币锁Token Locker
是一种简单的时间锁合约，它可以把合约中的代币锁仓一段时间，受益人在锁仓期满后可以取走代币。代币锁一般是用来锁仓流动性提供者LP代币的。
#### LP代币
作为补偿，DEX会给他们铸造相应的流动性提供者LP代币凭证，证明他们质押了相应的份额，供他们收取手续费。

#### 代币锁合约
```
    // 事件
    event TokenLockStart(address indexed beneficiary, address indexed token, uint256 startTime, uint256 lockTime);
    event Release(address indexed beneficiary, address indexed token, uint256 releaseTime, uint256 amount);

    // 被锁仓的ERC20代币合约
    IERC20 public immutable token;
    // 受益人地址
    address public immutable beneficiary;
    // 锁仓时间(秒)
    uint256 public immutable lockTime;
    // 锁仓起始时间戳(秒)
    uint256 public immutable startTime;

    /**
     * @dev 部署时间锁合约，初始化代币合约地址，受益人地址和锁仓时间。
     * @param token_: 被锁仓的ERC20代币合约
     * @param beneficiary_: 受益人地址
     * @param lockTime_: 锁仓时间(秒)
     */
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

    /**
     * @dev 在锁仓时间过后，将代币释放给受益人。
     */
    function release() public {
        require(block.timestamp >= startTime+lockTime, "TokenLock: current time is before release time");

        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");

        token.transfer(beneficiary, amount);

        emit Release(msg.sender, address(token), block.timestamp, amount);
    }
```

### 时间锁Timelock
它是一种计时器，旨在防止保险箱或保险库在预设时间之前被打开，即便开锁的人知道正确密码。
- 在创建Timelock合约时，项目方可以设定锁定期，并把合约的管理员设为自己。
- 时间锁主要有三个功能：
   - 创建交易，并加入到时间锁队列。
   - 在交易的锁定期满后，执行交易。
   - 后悔了，取消时间锁队列中的某些交易。
- 项目方一般会把时间锁合约设为重要合约的管理员，例如金库合约，再通过时间锁操作他们。
- 时间锁合约的管理员一般为项目的多签钱包，保证去中心化。
```
    // 事件
    // 交易取消事件
    event CancelTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    // 交易执行事件
    event ExecuteTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    // 交易创建并进入队列 事件
    event QueueTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature, bytes data, uint executeTime);
    // 修改管理员地址的事件
    event NewAdmin(address indexed newAdmin);

    // 状态变量
    address public admin; // 管理员地址
    uint public constant GRACE_PERIOD = 7 days; // 交易有效期，过期的交易作废
    uint public delay; // 交易锁定时间 （秒）
    mapping (bytes32 => bool) public queuedTransactions; // txHash到bool，记录所有在时间锁队列中的交易

    // onlyOwner modifier
    modifier onlyOwner() {
        require(msg.sender == admin, "Timelock: Caller not admin");
        _;
    }

    // onlyTimelock modifier
    modifier onlyTimelock() {
        require(msg.sender == address(this), "Timelock: Caller not Timelock");
        _;
    }

    /**
     * @dev 构造函数，初始化交易锁定时间 （秒）和管理员地址
     */
    constructor(uint delay_) {
        delay = delay_;
        admin = msg.sender;
    }

    /**
     * @dev 改变管理员地址，调用者必须是Timelock合约。
     */
    function changeAdmin(address newAdmin) public onlyTimelock {
        admin = newAdmin;

        emit NewAdmin(newAdmin);
    }

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

    /**
     * @dev 取消特定交易。
     *
     * 要求：交易在时间锁队列中
     */
    function cancelTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner{
        // 计算交易的唯一识别符：一堆东西的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 检查：交易在时间锁队列中
        require(queuedTransactions[txHash], "Timelock::cancelTransaction: Transaction hasn't been queued.");
        // 将交易移出队列
        queuedTransactions[txHash] = false;

        emit CancelTransaction(txHash, target, value, signature, data, executeTime);
    }

    /**
     * @dev 执行特定交易。
     *
     * 要求：
     * 1. 交易在时间锁队列中
     * 2. 达到交易的执行时间
     * 3. 交易没过期
     */
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
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
        }
        // 利用call执行交易
        (bool success, bytes memory returnData) = target.call{value: value}(callData);
        require(success, "Timelock::executeTransaction: Transaction execution reverted.");

        emit ExecuteTransaction(txHash, target, value, signature, data, executeTime);

        return returnData;
    }

    /**
     * @dev 获取当前区块链时间戳
     */
    function getBlockTimestamp() public view returns (uint) {
        return block.timestamp;
    }

    /**
     * @dev 将一堆东西拼成交易的标识符
     */
    function getTxHash(
        address target,
        uint value,
        string memory signature,
        bytes memory data,
        uint executeTime
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(target, value, signature, data, executeTime));
    }
```

### 2024.10.4
### 代理合约Proxy Contract
Solidity合约部署在链上之后，代码是不可变的（immutable）。这样既有优点，也有缺点：
优点：安全，用户知道会发生什么（大部分时候）。
坏处：就算合约中存在bug，也不能修改或升级，只能部署新合约。但是新合约的地址与旧的不一样，且合约的数据也需要花费大量gas进行迁移。
![image](https://github.com/user-attachments/assets/8d702393-04b7-4a32-8db7-eae6c9b38005)
代理合约（Proxy）通过delegatecall，将函数调用全权委托给逻辑合约（Implementation）执行，再把最终的结果返回给调用者（Caller）。
代理模式主要有两个好处：
1. 可升级：当我们需要升级合约的逻辑时，只需要将代理合约指向新的逻辑合约。
2. 省gas：如果多个合约复用一套逻辑，我们只需部署一个逻辑合约，然后再部署多个只保存数据的代理合约，指向逻辑合约。
   
**它有三个部分：代理合约Proxy，逻辑合约Logic，和一个调用示例Caller。它的逻辑并不复杂：**
1. 首先部署逻辑合约Logic。
2. 创建代理合约Proxy，状态变量implementation记录Logic合约地址。
3. Proxy合约利用回调函数fallback，将所有调用委托给Logic合约
4. 最后部署调用示例Caller合约，调用Proxy合约。
```
contract Proxy {
    address public implementation; // 逻辑合约地址。implementation合约同一个位置的状态变量类型必须和Proxy合约的相同，不然会报错。

    /**
     * @dev 初始化逻辑合约地址
     */
    constructor(address implementation_){
        implementation = implementation_;
    }
/**
* @dev 回调函数，将本合约的调用委托给 `implementation` 合约
* 通过assembly，让回调函数也能有返回值
*/
fallback() external payable {
    address _implementation = implementation;
    assembly {
        // 将msg.data拷贝到内存里
        // calldatacopy操作码的参数: 内存起始位置，calldata起始位置，calldata长度
        calldatacopy(0, 0, calldatasize())

        // 利用delegatecall调用implementation合约
        // delegatecall操作码的参数：gas, 目标合约地址，input mem起始位置，input mem长度，output area mem起始位置，output area mem长度
        // output area起始位置和长度位置，所以设为0
        // delegatecall成功返回1，失败返回0
        let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

        // 将return data拷贝到内存
        // returndata操作码的参数：内存起始位置，returndata起始位置，returndata长度
        returndatacopy(0, 0, returndatasize())

        switch result
        // 如果delegate call失败，revert
        case 0 {
            revert(0, returndatasize())
        }
        // 如果delegate call成功，返回mem起始位置为0，长度为returndatasize()的数据（格式为bytes）
        default {
            return(0, returndatasize())
        }
    }
}

/**
 * @dev 逻辑合约，执行被委托的调用
 */
contract Logic {
    address public implementation; // 与Proxy保持一致，防止插槽冲突
    uint public x = 99; 
    event CallSuccess(); // 调用成功事件

    // 这个函数会释放CallSuccess事件并返回一个uint。
    // 函数selector: 0xd09de08a
    function increment() external returns(uint) {
        emit CallSuccess();
        return x + 1;
    }
}
/**
 * @dev Caller合约，调用代理合约，并获取执行结果
 */
contract Caller{
    address public proxy; // 代理合约地址

    constructor(address proxy_){
        proxy = proxy_;
    }

    // 通过代理合约调用increment()函数
    function increment() external returns(uint) {
        ( , bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
        return abi.decode(data,(uint));
    }
}

```


### 可升级合约
```
// SPDX-License-Identifier: MIT
// wtf.academy
pragma solidity ^0.8.21;

// 简单的可升级合约，管理员可以通过升级函数更改逻辑合约地址，从而改变合约的逻辑。
// 教学演示用，不要用在生产环境
contract SimpleUpgrade {
    address public implementation; // 逻辑合约地址
    address public admin; // admin地址
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
    fallback() external payable {
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}

// 逻辑合约1
contract Logic1 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器： 0xc2985578
    function foo() public{
        words = "old";
    }
}

// 逻辑合约2
contract Logic2 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器：0xc2985578
    function foo() public{
        words = "new";
    }
}
```

### 透明代理Transparent Proxy
#### 选择器冲突
智能合约中，函数选择器（selector）是函数签名的哈希的前4个字节。
由于函数选择器仅有4个字节，范围很小，因此两个不同的函数可能会有相同的选择器
有两个可升级合约标准解决了这一问题：透明代理Transparent Proxy和通用可升级代理UUPS。

**限制管理员的权限，不让他调用任何逻辑合约的函数，就能解决冲突：**
- 管理员变为工具人，仅能调用代理合约的可升级函数对合约升级，不能通过回调函数调用逻辑合约。
- 其它用户不能调用可升级函数，但是可以调用逻辑合约的函数。

```
// 透明可升级合约的教学代码，不要用于生产。
contract TransparentProxy {
    address implementation; // logic合约地址
    address admin; // 管理员
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
    // 不能被admin调用，避免选择器冲突引发意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}

// 旧逻辑合约
contract Logic1 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器： 0xc2985578
    function foo() public{
        words = "old";
    }
}

// 新逻辑合约
contract Logic2 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器：0xc2985578
    function foo() public{
        words = "new";
    }
}
```

### 通用可升级代理（UUPS，universal upgradeable proxy standard）
将升级函数放在逻辑合约中。这样一来，如果有其它函数与升级函数存在“选择器冲突”，编译时就会报错。
![image](https://github.com/user-attachments/assets/91a2d3d3-428f-40ec-90b3-f86927156db3)
```
contract UUPSProxy {
    address public implementation; // 逻辑合约地址
    address public admin; // admin地址
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
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
    // UUPS中，逻辑合约中必须包含升级函数，不然就不能再升级了。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}

// 新的UUPS逻辑合约
contract UUPS2{
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器： 0xc2985578
    function foo() public{
        words = "new";
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用。选择器：0x0900f010
    // UUPS中，逻辑合约中必须包含升级函数，不然就不能再升级了。
    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
```

### 多签钱包
逻辑：
1. 设置多签人和门槛（链上）：部署多签合约时，我们需要初始化多签人列表和执行门槛（至少n个多签人签名授权后，交易才能执行）。
2. 创建交易（链下）
3. 收集多签签名（链下）：将上一步的交易ABI编码并计算哈希，得到交易哈希，然后让多签人签名，并拼接到一起的到打包签名。
4. 调用多签合约的执行函数，验证签名并执行交易（链上）。
```
    event ExecutionSuccess(bytes32 txHash);    // 交易成功事件
    event ExecutionFailure(bytes32 txHash);    // 交易失败事件
    address[] public owners;                   // 多签持有人数组 
    mapping(address => bool) public isOwner;   // 记录一个地址是否为多签持有人
    uint256 public ownerCount;                 // 多签持有人数量
    uint256 public threshold;                  // 多签执行门槛，交易至少有n个多签人签名才能被执行。
    uint256 public nonce;                      // nonce，防止签名重放攻击
// 构造函数，初始化owners, isOwner, ownerCount, threshold 
constructor(        
    address[] memory _owners,
    uint256 _threshold
) {
    _setupOwners(_owners, _threshold);
}

/// @dev 初始化owners, isOwner, ownerCount,threshold 
/// @param _owners: 多签持有人数组
/// @param _threshold: 多签执行门槛，至少有几个多签人签署了交易
function _setupOwners(address[] memory _owners, uint256 _threshold) internal {
    // threshold没被初始化过
    require(threshold == 0, "WTF5000");
    // 多签执行门槛 小于 多签人数
    require(_threshold <= _owners.length, "WTF5001");
    // 多签执行门槛至少为1
    require(_threshold >= 1, "WTF5002");

    for (uint256 i = 0; i < _owners.length; i++) {
        address owner = _owners[i];
        // 多签人不能为0地址，本合约地址，不能重复
        require(owner != address(0) && owner != address(this) && !isOwner[owner], "WTF5003");
        owners.push(owner);
        isOwner[owner] = true;
    }
    ownerCount = _owners.length;
    threshold = _threshold;
}

/// @dev 在收集足够的多签签名后，执行交易
/// @param to 目标合约地址
/// @param value msg.value，支付的以太坊
/// @param data calldata
/// @param signatures 打包的签名，对应的多签地址由小到达，方便检查。 ({bytes32 r}{bytes32 s}{uint8 v}) (第一个多签的签名, 第二个多签的签名 ... )
function execTransaction(
    address to,
    uint256 value,
    bytes memory data,
    bytes memory signatures
) public payable virtual returns (bool success) {
    // 编码交易数据，计算哈希
    bytes32 txHash = encodeTransactionData(to, value, data, nonce, block.chainid);
    nonce++;  // 增加nonce
    checkSignatures(txHash, signatures); // 检查签名
    // 利用call执行交易，并获取交易结果
    (success, ) = to.call{value: value}(data);
    require(success , "WTF5004");
    if (success) emit ExecutionSuccess(txHash);
    else emit ExecutionFailure(txHash);
}

/**
 * @dev 检查签名和交易数据是否对应。如果是无效签名，交易会revert
 * @param dataHash 交易数据哈希
 * @param signatures 几个多签签名打包在一起
 */
function checkSignatures(
    bytes32 dataHash,
    bytes memory signatures
) public view {
    // 读取多签执行门槛
    uint256 _threshold = threshold;
    require(_threshold > 0, "WTF5005");

    // 检查签名长度足够长
    require(signatures.length >= _threshold * 65, "WTF5006");

    // 通过一个循环，检查收集的签名是否有效
    // 大概思路：
    // 1. 用ecdsa先验证签名是否有效
    // 2. 利用 currentOwner > lastOwner 确定签名来自不同多签（多签地址递增）
    // 3. 利用 isOwner[currentOwner] 确定签名者为多签持有人
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

/// 将单个签名从打包的签名分离出来
/// @param signatures 打包签名
/// @param pos 要读取的多签index.
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
/// @dev 编码交易数据
/// @param to 目标合约地址
/// @param value msg.value，支付的以太坊
/// @param data calldata
/// @param _nonce 交易的nonce.
/// @param chainid 链id
/// @return 交易哈希bytes.
function encodeTransactionData(
    address to,
    uint256 value,
    bytes memory data,
    uint256 _nonce,
    uint256 chainid
) public pure returns (bytes32) {
    bytes32 safeTxHash =
        keccak256(
            abi.encode(
                to,
                value,
                keccak256(data),
                _nonce,
                chainid
            )
        );
    return safeTxHash;
}
```

### 2024.10.5
### ERC4626代币化金库标准
#### 金库
金库合约是 DeFi 乐高中的基础，它允许你把基础资产（代币）质押到合约中，换取一定收益，包括以下应用场景:
收益农场: 在 Yearn Finance 中，你可以质押 USDT 获取利息。
借贷: 在 AAVE 中，你可以出借 ETH 获取存款利息和贷款。
质押: 在 Lido 中，你可以质押 ETH 参与 ETH 2.0 质押，得到可以生息的 stETH。

#### 优点
1. 代币化: ERC4626 继承了 ERC20，向金库存款时，将得到同样符合 ERC20 标准的金库份额，比如质押 ETH，自动获得 stETH。
2. 更好的流通性: 由于代币化，你可以在不取回基础资产的情况下，利用金库份额做其他事情。拿 Lido 的 stETH 为例，你可以用它在 Uniswap 上提供流动性或交易，而不需要取出其中的 ETH。
3. 更好的可组合性: 有了标准之后，用一套接口可以和所有 ERC4626 金库交互，让基于金库的应用、插件、工具开发更容易。

#### 合约逻辑
1. ERC20: ERC4626 继承了 ERC20，金库份额就是用 ERC20 代币代表的：用户将特定的 ERC20 基础资产（比如 WETH）存进金库，合约会给他铸造特定数量的金库份额代币；当用户从金库中提取基础资产时，会销毁相应数量的金库份额代币。asset() 函数会返回金库的基础资产的代币地址。
2. 存款逻辑：让用户存入基础资产，并铸造相应数量的金库份额。相关函数为 deposit() 和 mint()。deposit(uint assets, address receiver) 函数让用户存入 assets 单位的资产，并铸造相应数量的金库份额给 receiver 地址。mint(uint shares, address receiver) 与它类似，只不过是以将铸造的金库份额作为参数。
3. 提款逻辑：让用户销毁金库份额，并提取金库中相应数量的基础资产。相关函数为 withdraw() 和 redeem()，前者以取出基础资产数量为参数，后者以销毁的金库份额为参数。
4. 会计和限额逻辑：ERC4626 标准中其他的函数是为了统计金库中的资产，存款/提款限额，和存款/提款的基础资产和金库份额数量。

#### IERC4626接口合约
**IERC4626 接口合约共包含 2 个事件:**
Deposit 事件: 存款时触发。
Withdraw 事件: 取款时触发。
**IERC4626 接口合约还包含 16 个函数，根据功能分为 4 大类：元数据，存款/提款逻辑，会计逻辑，和存款/提款限额逻辑。**
**元数据**
asset(): 返回金库的基础资产代币地址，用于存款，取款。
**存款/提款逻辑**
deposit(): 存款函数，用户向金库存入 assets 单位的基础资产，然后合约铸造 shares 单位的金库额度给 receiver 地址。会释放 Deposit 事件。
mint(): 铸造函数（也是存款函数），用户指定想获得的 shares 单位的金库额度，函数经过计算后得出需要存入的 assets 单位的基础资产数量，然后合约从用户账户转出 assets 单位的基础资产，再给 receiver 地址铸造指定数量的金库额度。会释放 Deposit 事件。
withdraw(): 提款函数，owner 地址销毁 share 单位的金库额度，然后合约将相应数量的基础资产发送给 receiver 地址。
redeem(): 赎回函数（也是提款函数），owner 地址销毁 shares 数量的金库额度，然后合约将相应单位的基础资产发给 receiver 地址
**会计逻辑**
totalAssets(): 返回金库中管理的基础资产代币总额。
convertToShares(): 返回利用一定数额基础资产可以换取的金库额度。
convertToAssets(): 返回利用一定数额金库额度可以换取的基础资产。
previewDeposit(): 用于用户在当前链上环境模拟存款一定数额的基础资产能够获得的金库额度。
previewMint(): 用于用户在当前链上环境模拟铸造一定数额的金库额度需要存款的基础资产数量。
previewWithdraw(): 用于用户在当前链上环境模拟提款一定数额的基础资产需要赎回的金库份额。
previewRedeem(): 用于链上和链下用户在当前链上环境模拟销毁一定数额的金库额度能够赎回的基础资产数量。
**存款/提款限额逻辑**
maxDeposit(): 返回某个用户地址单次存款可存的最大基础资产数额。
maxMint(): 返回某个用户地址单次铸造可以铸造的最大金库额度。
maxWithdraw(): 返回某个用户地址单次取款可以提取的最大基础资产额度。
maxRedeem(): 返回某个用户地址单次赎回可以销毁的最大金库额度。
```
// SPDX-License-Identifier: MIT
// Author: 0xAA from WTF Academy

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @dev ERC4626 "代币化金库标准"的接口合约
 * https://eips.ethereum.org/EIPS/eip-4626[ERC-4626].
 */
interface IERC4626 is IERC20, IERC20Metadata {
    /*//////////////////////////////////////////////////////////////
                                 事件
    //////////////////////////////////////////////////////////////*/
    // 存款时触发
    event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);

    // 取款时触发
    event Withdraw(
        address indexed sender,
        address indexed receiver,
        address indexed owner,
        uint256 assets,
        uint256 shares
    );

    /*//////////////////////////////////////////////////////////////
                            元数据
    //////////////////////////////////////////////////////////////*/
    /**
     * @dev 返回金库的基础资产代币地址 （用于存款，取款）
     * - 必须是 ERC20 代币合约地址.
     * - 不能revert
     */
    function asset() external view returns (address assetTokenAddress);

    /*//////////////////////////////////////////////////////////////
                        存款/提款逻辑
    //////////////////////////////////////////////////////////////*/
    /**
     * @dev 存款函数: 用户向金库存入 assets 单位的基础资产，然后合约铸造 shares 单位的金库额度给 receiver 地址
     *
     * - 必须释放 Deposit 事件.
     * - 如果资产不能存入，必须revert，比如存款数额大大于上限等。
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
```
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IERC4626} from "./IERC4626.sol";
import {ERC20, IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev ERC4626 "代币化金库标准"合约，仅供教学使用，不要用于生产
 */
contract ERC4626 is ERC20, IERC4626 {
    /*//////////////////////////////////////////////////////////////
                    状态变量
    //////////////////////////////////////////////////////////////*/
    ERC20 private immutable _asset; // 
    uint8 private immutable _decimals;

    constructor(
        ERC20 asset_,
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {
        _asset = asset_;
        _decimals = asset_.decimals();

    }

    /** @dev See {IERC4626-asset}. */
    function asset() public view virtual override returns (address) {
        return address(_asset);
    }

    /**
     * See {IERC20Metadata-decimals}.
     */
    function decimals() public view virtual override(IERC20Metadata, ERC20) returns (uint8) {
        return _decimals;
    }

    /*//////////////////////////////////////////////////////////////
                        存款/提款逻辑
    //////////////////////////////////////////////////////////////*/
    /** @dev See {IERC4626-deposit}. */
    function deposit(uint256 assets, address receiver) public virtual returns (uint256 shares) {
        // 利用 previewDeposit() 计算将获得的金库份额
        shares = previewDeposit(assets);

        // 先 transfer 后 mint，防止重入
        _asset.transferFrom(msg.sender, address(this), assets);
        _mint(receiver, shares);

        // 释放 Deposit 事件
        emit Deposit(msg.sender, receiver, assets, shares);
    }

    /** @dev See {IERC4626-mint}. */
    function mint(uint256 shares, address receiver) public virtual returns (uint256 assets) {
        // 利用 previewMint() 计算需要存款的基础资产数额
        assets = previewMint(shares);

        // 先 transfer 后 mint，防止重入
        _asset.transferFrom(msg.sender, address(this), assets);
        _mint(receiver, shares);

        // 释放 Deposit 事件
        emit Deposit(msg.sender, receiver, assets, shares);

    }

    /** @dev See {IERC4626-withdraw}. */
    function withdraw(
        uint256 assets,
        address receiver,
        address owner
    ) public virtual returns (uint256 shares) {
        // 利用 previewWithdraw() 计算将销毁的金库份额
        shares = previewWithdraw(assets);

        // 如果调用者不是 owner，则检查并更新授权
        if (msg.sender != owner) {
            _spendAllowance(owner, msg.sender, shares);
        }

        // 先销毁后 transfer，防止重入
        _burn(owner, shares);
        _asset.transfer(receiver, assets);

        // 释放 Withdraw 事件
        emit Withdraw(msg.sender, receiver, owner, assets, shares);
    }

    /** @dev See {IERC4626-redeem}. */
    function redeem(
        uint256 shares,
        address receiver,
        address owner
    ) public virtual returns (uint256 assets) {
        // 利用 previewRedeem() 计算能赎回的基础资产数额
        assets = previewRedeem(shares);

        // 如果调用者不是 owner，则检查并更新授权
        if (msg.sender != owner) {
            _spendAllowance(owner, msg.sender, shares);
        }

        // 先销毁后 transfer，防止重入
        _burn(owner, shares);
        _asset.transfer(receiver, assets);

        // 释放 Withdraw 事件       
        emit Withdraw(msg.sender, receiver, owner, assets, shares);
    }

    /*//////////////////////////////////////////////////////////////
                            会计逻辑
    //////////////////////////////////////////////////////////////*/
    /** @dev See {IERC4626-totalAssets}. */
    function totalAssets() public view virtual returns (uint256){
        // 返回合约中基础资产持仓
        return _asset.balanceOf(address(this));
    }

    /** @dev See {IERC4626-convertToShares}. */
    function convertToShares(uint256 assets) public view virtual returns (uint256) {
        uint256 supply = totalSupply();
        // 如果 supply 为 0，那么 1:1 铸造金库份额
        // 如果 supply 不为0，那么按比例铸造
        return supply == 0 ? assets : assets * supply / totalAssets();
    }

    /** @dev See {IERC4626-convertToAssets}. */
    function convertToAssets(uint256 shares) public view virtual returns (uint256) {
        uint256 supply = totalSupply();
        // 如果 supply 为 0，那么 1:1 赎回基础资产
        // 如果 supply 不为0，那么按比例赎回
        return supply == 0 ? shares : shares * totalAssets() / supply;
    }

    /** @dev See {IERC4626-previewDeposit}. */
    function previewDeposit(uint256 assets) public view virtual returns (uint256) {
        return convertToShares(assets);
    }

    /** @dev See {IERC4626-previewMint}. */
    function previewMint(uint256 shares) public view virtual returns (uint256) {
        return convertToAssets(shares);
    }

    /** @dev See {IERC4626-previewWithdraw}. */
    function previewWithdraw(uint256 assets) public view virtual returns (uint256) {
        return convertToShares(assets);
    }

    /** @dev See {IERC4626-previewRedeem}. */
    function previewRedeem(uint256 shares) public view virtual returns (uint256) {
        return convertToAssets(shares);
    }

    /*//////////////////////////////////////////////////////////////
                     存款/提款限额逻辑
    //////////////////////////////////////////////////////////////*/
    /** @dev See {IERC4626-maxDeposit}. */
    function maxDeposit(address) public view virtual returns (uint256) {
        return type(uint256).max;
    }

    /** @dev See {IERC4626-maxMint}. */
    function maxMint(address) public view virtual returns (uint256) {
        return type(uint256).max;
    }
    
    /** @dev See {IERC4626-maxWithdraw}. */
    function maxWithdraw(address owner) public view virtual returns (uint256) {
        return convertToAssets(balanceOf(owner));
    }
    
    /** @dev See {IERC4626-maxRedeem}. */
    function maxRedeem(address owner) public view virtual returns (uint256) {
        return balanceOf(owner);
    }
}
```

### 2024.10.6
### EIP712类型化数据签名
#### EIP191签名标准personal sign
它可以给一段消息签名。但是它过于简单，当签名数据比较复杂时，用户只能看到一串十六进制字符串（数据的哈希），无法核实签名内容是否与预期相符。

#### 链下签名
```
EIP712Domain: [
    { name: "name", type: "string" },
    { name: "version", type: "string" },
    { name: "chainId", type: "uint256" },
    { name: "verifyingContract", type: "address" },
]
const domain = {
    name: "EIP712Storage",
    version: "1",
    chainId: "1",
    verifyingContract: "0xf8e81D47203A594245E36C48e151709F0C19fBe8",
};
const types = {
    Storage: [
        { name: "spender", type: "address" },
        { name: "number", type: "uint256" },
    ],
};
const message = {
    spender: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    number: "100",
};
// 获得provider
const provider = new ethers.BrowserProvider(window.ethereum)
// 获得signer后调用signTypedData方法进行eip712签名
const signature = await signer.signTypedData(domain, types, message);
console.log("Signature:", signature);
```

#### 链上验证
```
// SPDX-License-Identifier: MIT
// By 0xAA 
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract EIP712Storage {
    using ECDSA for bytes32;

    bytes32 private constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
    bytes32 private constant STORAGE_TYPEHASH = keccak256("Storage(address spender,uint256 number)");
    bytes32 private DOMAIN_SEPARATOR;
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

    /**
     * @dev Store value in variable
     */
    function permitStore(uint256 _num, bytes memory _signature) public {
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
        
        address signer = digest.recover(v, r, s); // 恢复签名者
        require(signer == owner, "EIP712Storage: Invalid signature"); // 检查签名

        // 修改状态变量
        number = _num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }    
}
```

### ERC20
它流行的一个主要原因是 approve 和 transferFrom 两个函数搭配使用，使得代币不仅可以在外部拥有账户（EOA）之间转移，还可以被其他合约使用。
但是，ERC20的 approve 函数限制了只有代币所有者才能调用，这意味着所有 ERC20 代币的初始操作必须由 EOA 执行。

#### ERC20Permit
EIP-2612 提出了 ERC20Permit，扩展了 ERC20 标准，添加了一个 permit 函数，允许用户通过 EIP-712 签名修改授权，而不是通过 msg.sender。这有两点好处：
1. 授权这步仅需用户在链下签名，减少一笔交易。
2. 签名后，用户可以委托第三方进行后续交易，不需要持有 ETH：用户 A 可以将签名发送给 拥有gas的第三方 B，委托 B 来执行后续交易。

#### IERC20接口合约
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev ERC20 Permit 扩展的接口，允许通过签名进行批准，如 https://eips.ethereum.org/EIPS/eip-2612[EIP-2612]中定义。
 */
interface IERC20Permit {
    /**
     * @dev 根据owner的签名, 将 `owenr` 的ERC20余额授权给 `spender`，数量为 `value`
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev 返回 `owner` 的当前 nonce。每次为 {permit} 生成签名时，都必须包括此值。
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev 返回用于编码 {permit} 的签名的域分隔符（domain separator）
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

#### ERC20Permit合约
```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

/**
 * @dev ERC20 Permit 扩展的接口，允许通过签名进行批准，如 https://eips.ethereum.org/EIPS/eip-2612[EIP-2612]中定义。
 *
 * 添加了 {permit} 方法，可以通过帐户签名的消息更改帐户的 ERC20 余额（参见 {IERC20-allowance}）。通过不依赖 {IERC20-approve}，代币持有者的帐户无需发送交易，因此完全不需要持有 Ether。
 */
contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
    mapping(address => uint) private _nonces;

    bytes32 private constant _PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    /**
     * @dev 初始化 EIP712 的 name 以及 ERC20 的 name 和 symbol
     */
    constructor(string memory name, string memory symbol) EIP712(name, "1") ERC20(name, symbol){}

    /**
     * @dev See {IERC20Permit-permit}.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual override {
        // 检查 deadline
        require(block.timestamp <= deadline, "ERC20Permit: expired deadline");

        // 拼接 Hash
        bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
        bytes32 hash = _hashTypedDataV4(structHash);
        
        // 从签名和消息计算 signer，并验证签名
        address signer = ECDSA.recover(hash, v, r, s);
        require(signer == owner, "ERC20Permit: invalid signature");
        
        // 授权
        _approve(owner, spender, value);
    }

    /**
     * @dev See {IERC20Permit-nonces}.
     */
    function nonces(address owner) public view virtual override returns (uint256) {
        return _nonces[owner];
    }

    /**
     * @dev See {IERC20Permit-DOMAIN_SEPARATOR}.
     */
    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        return _domainSeparatorV4();
    }

    /**
     * @dev "消费nonce": 返回 `owner` 当前的 `nonce`，并增加 1。
     */
    function _useNonce(address owner) internal virtual returns (uint256 current) {
        current = _nonces[owner];
        _nonces[owner] += 1;
    }
}
```

**安全注意**
一些合约在集成permit时，也会带来DoS（拒绝服务）的风险。因为permit在执行时会用掉当前的nonce值，如果合约的函数中包含permit操作，则攻击者可以通过抢跑执行permit从而使得目标交易因为nonce被占用而回滚。

### 跨链桥
跨链桥不是区块链原生支持的，跨链操作需要可信第三方来执行，这也带来了风险

#### 种类
1. Burn/Mint：在源链上销毁（burn）代币，然后在目标链上创建（mint）同等数量的代币。此方法好处是代币的总供应量保持不变，但是需要跨链桥拥有代币的铸造权限，适合项目方搭建自己的跨链桥。
![image](https://github.com/user-attachments/assets/56616b7a-a181-4b1f-ab73-179c5ac62963)
2. Stake/Mint：在源链上锁定（stake）代币，然后在目标链上创建（mint）同等数量的代币（凭证）。源链上的代币被锁定，当代币从目标链移回源链时再解锁。这是一般跨链桥使用的方案，不需要任何权限，但是风险也较大，当源链的资产被黑客攻击时，目标链上的凭证将变为空气。
![image](https://github.com/user-attachments/assets/cd62aa84-6387-4124-b08f-6a6156014558)
3. Stake/Unstake：在源链上锁定（stake）代币，然后在目标链上释放（unstake）同等数量的代币，在目标链上的代币可以随时兑换回源链的代币。这个方法需要跨链桥在两条链都有锁定的代币，门槛较高，一般需要激励用户在跨链桥锁仓。
![image](https://github.com/user-attachments/assets/abe1b911-f6a6-47a2-9169-91654785df55)

#### 跨链代币合约
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CrossChainToken is ERC20, Ownable {
    
    // Bridge event
    event Bridge(address indexed user, uint256 amount);
    // Mint event
    event Mint(address indexed to, uint256 amount);

    /**
     * @param name Token Name
     * @param symbol Token Symbol
     * @param totalSupply Token Supply
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply
    ) payable ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, totalSupply);
    }

    /**
     * Bridge function
     * @param amount: burn amount of token on the current chain and mint on the other chain
     */
    function bridge(uint256 amount) public {
        _burn(msg.sender, amount);
        emit Bridge(msg.sender, amount);
    }

    /**
     * Mint function
     */
    function mint(address to, uint amount) external onlyOwner {
        _mint(to, amount);
        emit  Mint(to, amount);
    }
}
```
constructor(): 构造函数，在部署合约时会被调用一次，用于初始化代币的名字、符号和总供应量。
bridge(): 用户调用此函数进行跨链转移，它会销毁用户指定数量的代币，并释放Bridge事件。
mint(): 只有合约的所有者才能调用此函数，用于处理跨链事件，并释放Mint事件。当用户在另一条链调用bridge()函数销毁代币，脚本会监听Bridge事件，并给用户在目标链铸造代币。

#### 跨链脚本
```
import { ethers } from "ethers";

// 初始化两条链的provider
const providerGoerli = new ethers.JsonRpcProvider("Goerli_Provider_URL");
const providerSepolia = new ethers.JsonRpcProvider("Sepolia_Provider_URL://eth-sepolia.g.alchemy.com/v2/RgxsjQdKTawszh80TpJ-14Y8tY7cx5W2");

// 初始化两条链的signer
// privateKey填管理者钱包的私钥
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

### 多重调用
MultiCall（多重调用）合约的设计能让我们在一次交易中执行多个函数调用。它的优点如下：
1. 方便性：MultiCall能让你在一次交易中对不同合约的不同函数进行调用，同时这些调用还可以使用不同的参数。比如你可以一次性查询多个地址的ERC20代币余额。
2. 节省gas：MultiCall能将多个交易合并成一次交易中的多个调用，从而节省gas。
3. 原子性：MultiCall能让用户在一笔交易中执行所有操作，保证所有操作要么全部成功，要么全部失败，这样就保持了原子性。比如，你可以按照特定的顺序进行一系列的代币交易。

#### MultiCall合约
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Multicall {
    // Call结构体，包含目标合约target，是否允许调用失败allowFailure，和call data
    struct Call {
        address target;
        bool allowFailure;
        bytes callData;
    }

    // Result结构体，包含调用是否成功和return data
    struct Result {
        bool success;
        bytes returnData;
    }

    /// @notice 将多个调用（支持不同合约/不同方法/不同参数）合并到一次调用
    /// @param calls Call结构体组成的数组
    /// @return returnData Result结构体组成的数组
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

### 去中心化交易所
恒定乘积自动做市商（Constant Product Automated Market Maker, CPAMM），它是去中心化交易所的核心机制，被Uniswap，PancakeSwap等一系列DEX采用
#### 自动做市商
自动做市商（Automated Market Maker，简称 AMM）是一种算法，或者说是一种在区块链上运行的智能合约，它允许数字资产之间的去中心化交易。AMM 的引入开创了一种全新的交易方式，无需传统的买家和卖家进行订单匹配，而是通过一种预设的数学公式（比如，常数乘积公式）创建一个流动性池，使得用户可以随时进行交易。
1. 恒定总和自动做市商（Constant Sum Automated Market Maker, CSAMM）是最简单的自动做市商模型它在交易时的约束为:k=x+y
2. 恒定乘积自动做市商（CPAMM）是最流行的自动做市商模型，最早被 Uniswap 采用。它在交易时的约束为:k=x∗y

#### 去中心化交易所合约
```
contract SimpleSwap is ERC20 {
    // 代币合约
    IERC20 public token0;
    IERC20 public token1;

    // 代币储备量
    uint public reserve0;
    uint public reserve1;
    
    // 构造器，初始化代币地址
    constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
        token0 = _token0;
        token1 = _token1;
    }
}
event Mint(address indexed sender, uint amount0, uint amount1);

// 添加流动性，转进代币，铸造LP
// @param amount0Desired 添加的token0数量
// @param amount1Desired 添加的token1数量
function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
    // 将添加的流动性转入Swap合约，需事先给Swap合约授权
    token0.transferFrom(msg.sender, address(this), amount0Desired);
    token1.transferFrom(msg.sender, address(this), amount1Desired);
    // 计算添加的流动性
    uint _totalSupply = totalSupply();
    if (_totalSupply == 0) {
        // 如果是第一次添加流动性，铸造 L = sqrt(x * y) 单位的LP（流动性提供者）代币
        liquidity = sqrt(amount0Desired * amount1Desired);
    } else {
        // 如果不是第一次添加流动性，按添加代币的数量比例铸造LP，取两个代币更小的那个比例
        liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);
    }

    // 检查铸造的LP数量
    require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

    // 更新储备量
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    // 给流动性提供者铸造LP代币，代表他们提供的流动性
    _mint(msg.sender, liquidity);
    
    emit Mint(msg.sender, amount0Desired, amount1Desired);
}
// 移除流动性，销毁LP，转出代币
// 转出数量 = (liquidity / totalSupply_LP) * reserve
// @param liquidity 移除的流动性数量
function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
    // 获取余额
    uint balance0 = token0.balanceOf(address(this));
    uint balance1 = token1.balanceOf(address(this));
    // 按LP的比例计算要转出的代币数量
    uint _totalSupply = totalSupply();
    amount0 = liquidity * balance0 / _totalSupply;
    amount1 = liquidity * balance1 / _totalSupply;
    // 检查代币数量
    require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');
    // 销毁LP
    _burn(msg.sender, liquidity);
    // 转出代币
    token0.transfer(msg.sender, amount0);
    token1.transfer(msg.sender, amount1);
    // 更新储备量
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    emit Burn(msg.sender, amount0, amount1);
}
// 给定一个资产的数量和代币对的储备，计算交换另一个代币的数量
function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
    require(amountIn > 0, 'INSUFFICIENT_AMOUNT');
    require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
    amountOut = amountIn * reserveOut / (reserveIn + amountIn);
}

// swap代币
// @param amountIn 用于交换的代币数量
// @param tokenIn 用于交换的代币合约地址
// @param amountOutMin 交换出另一种代币的最低数量
function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
    require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
    require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');
    
    uint balance0 = token0.balanceOf(address(this));
    uint balance1 = token1.balanceOf(address(this));

    if(tokenIn == token0){
        // 如果是token0交换token1
        tokenOut = token1;
        // 计算能交换出的token1数量
        amountOut = getAmountOut(amountIn, balance0, balance1);
        require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
        // 进行交换
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        tokenOut.transfer(msg.sender, amountOut);
    }else{
        // 如果是token1交换token0
        tokenOut = token0;
        // 计算能交换出的token1数量
        amountOut = getAmountOut(amountIn, balance1, balance0);
        require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
        // 进行交换
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        tokenOut.transfer(msg.sender, amountOut);
    }

    // 更新储备量
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
}
```

### 闪电贷Flashloan
闪电贷利用了以太坊交易的原子性：一个交易（包括其中的所有操作）要么完全执行，要么完全不执行。如果一个用户尝试使用闪电贷并在同一个交易中没有归还资金，那么整个交易都会失败并被回滚，就像它从未发生过一样。因此，DeFi平台不需要担心借款人还不上款，因为还不上的话就意味着钱没借出去；同时，借款人也不用担心套利不成功，因为套利不成功的话就还不上款，也就意味着借钱没成功。

#### 1. Uniswap V2闪电贷
```
function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external lock {
    // 其他逻辑...

    // 乐观的发送代币到to地址
    if (amount0Out > 0) _safeTransfer(_token0, to, amount0Out);
    if (amount1Out > 0) _safeTransfer(_token1, to, amount1Out);

    // 调用to地址的回调函数uniswapV2Call
    if (data.length > 0) IUniswapV2Callee(to).uniswapV2Call(msg.sender, amount0Out, amount1Out, data);

    // 其他逻辑...

    // 通过k=x*y公式，检查闪电贷是否归还成功
    require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'UniswapV2: K');
}
```
#### 闪电贷合约UniswapV2Flashloan.sol
```
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

#### Foundry测试合约UniswapV2Flashloan.t.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/UniswapV2Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV2FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    UniswapV2Flashloan private flashloan;

    function setUp() public {
        flashloan = new UniswapV2Flashloan();
    }

    function testFlashloan() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);
        // 闪电贷借贷金额
        uint amountToBorrow = 100 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    // 手续费不足，会revert
    function testFlashloanFail() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 3e17);
        // 闪电贷借贷金额
        uint amountToBorrow = 100 * 1e18;
        // 手续费不足
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
```

#### 2. Uniswap V3闪电贷
```
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
#### 闪电贷合约UniswapV3Flashloan.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

// UniswapV3闪电贷回调接口
// 需要实现并重写uniswapV3FlashCallback()函数
interface IUniswapV3FlashCallback {
    /// 在实现中，你必须偿还池中由 flash 发送的代币及计算出的费用金额。
    /// 调用此方法的合约必须经由官方 UniswapV3Factory 部署的 UniswapV3Pool 检查。
    /// @param fee0 闪电贷结束时，应支付给池的 token0 的费用金额
    /// @param fee1 闪电贷结束时，应支付给池的 token1 的费用金额
    /// @param data 通过 IUniswapV3PoolActions#flash 调用由调用者传递的任何数据
    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external;
}

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

    function getPool(
        address _token0,
        address _token1,
        uint24 _fee
    ) public pure returns (address) {
        PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(
            _token0,
            _token1,
            _fee
        );
        return PoolAddress.computeAddress(UNISWAP_V3_FACTORY, poolKey);
    }

    // 闪电贷函数
    function flashloan(uint wethAmount) external {
        bytes memory data = abi.encode(WETH, wethAmount);
        IUniswapV3Pool(pool).flash(address(this), 0, wethAmount, data);
    }

    // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
    function uniswapV3FlashCallback(
        uint fee0,
        uint fee1,
        bytes calldata data
    ) external {
        // 确认调用的是 DAI/WETH pair 合约
        require(msg.sender == address(pool), "not authorized");
        
        // 解码calldata
        (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

        // flashloan 逻辑，这里省略
        require(tokenBorrow == WETH, "token borrow != WETH");

        // 归还闪电贷
        weth.transfer(address(pool), wethAmount + fee1);
    }
}
```

#### Foundry测试合约UniswapV3Flashloan.t.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import "../src/UniswapV3Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV2FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    UniswapV3Flashloan private flashloan;

    function setUp() public {
        flashloan = new UniswapV3Flashloan();
    }

    function testFlashloan() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);
                
        uint balBefore = weth.balanceOf(address(flashloan));
        console2.logUint(balBefore);
        // 闪电贷借贷金额
        uint amountToBorrow = 1 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    // 手续费不足，会revert
    function testFlashloanFail() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e17);
        // 闪电贷借贷金额
        uint amountToBorrow = 100 * 1e18;
        // 手续费不足
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
```

#### 3. AAVE V3闪电贷
#### 闪电贷合约AaveV3Flashloan.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

interface IFlashLoanSimpleReceiver {
    /**
    * @notice 在接收闪电借款资产后执行操作
    * @dev 确保合约能够归还债务 + 额外费用，例如，具有
    *      足够的资金来偿还，并已批准 Pool 提取总金额
    * @param asset 闪电借款资产的地址
    * @param amount 闪电借款资产的数量
    * @param premium 闪电借款资产的费用
    * @param initiator 发起闪电贷款的地址
    * @param params 初始化闪电贷款时传递的字节编码参数
    * @return 如果操作的执行成功则返回 True，否则返回 False
    */
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool);
}

// AAVE V3闪电贷合约
contract AaveV3Flashloan {
    address private constant AAVE_V3_POOL =
        0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    ILendingPool public aave;

    constructor() {
        aave = ILendingPool(AAVE_V3_POOL);
    }

    // 闪电贷函数
    function flashloan(uint256 wethAmount) external {
        aave.flashLoanSimple(address(this), WETH, wethAmount, "", 0);
    }

    // 闪电贷回调函数，只能被 pool 合约调用
    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata)
        external
        returns (bool)
    {   
        // 确认调用的是 DAI/WETH pair 合约
        require(msg.sender == AAVE_V3_POOL, "not authorized");
        // 确认闪电贷发起者是本合约
        require(initiator == address(this), "invalid initiator");

        // flashloan 逻辑，这里省略

        // 计算flashloan费用
        // fee = 5/1000 * amount
        uint fee = (amount * 5) / 10000 + 1;
        uint amountToRepay = amount + fee;

        // 归还闪电贷
        IERC20(WETH).approve(AAVE_V3_POOL, amountToRepay);

        return true;
    }
}
```
#### Foundry测试合约AaveV3Flashloan.t.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/AaveV3Flashloan.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

contract UniswapV2FlashloanTest is Test {
    IWETH private weth = IWETH(WETH);

    AaveV3Flashloan private flashloan;

    function setUp() public {
        flashloan = new AaveV3Flashloan();
    }

    function testFlashloan() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 1e18);
        // 闪电贷借贷金额
        uint amountToBorrow = 100 * 1e18;
        flashloan.flashloan(amountToBorrow);
    }

    // 手续费不足，会revert
    function testFlashloanFail() public {
        // 换weth，并转入flashloan合约，用做手续费
        weth.deposit{value: 1e18}();
        weth.transfer(address(flashloan), 4e16);
        // 闪电贷借贷金额
        uint amountToBorrow = 100 * 1e18;
        // 手续费不足
        vm.expectRevert();
        flashloan.flashloan(amountToBorrow);
    }
}
```

### 2024.10.7
### ethers.js
是一个完整而紧凑的开源库，用于与以太坊区块链及其生态系统进行交互。如果你要写Dapp的前端，你就需要用到ethers.js。
与更早出现的web3.js相比，它有以下优点：
1. 代码更加紧凑：ethers.js大小为116.5 kB，而web3.js为590.6 kB。
2. 更加安全：Web3.js认为用户会在本地部署以太坊节点，私钥和网络连接状态由这个节点管理（实际并不是这样）；ethers.js中，Provider提供器类管理网络连接状态，Wallet钱包类管理密钥，安全且灵活。
3. 原生支持ENS。

```
import { ethers } from "ethers";
const provider = ethers.getDefaultProvider();
const main = async () => {
    const balance = await provider.getBalance(`vitalik.eth`);
    console.log(`ETH Balance of vitalik: ${ethers.formatEther(balance)} ETH`);
}
main()
```

### Provider提供器
Provider类是对以太坊网络连接的抽象，为标准以太坊节点功能提供简洁、一致的接口。在ethers中，Provider不接触用户私钥，只能读取链上信息，不能写入，这一点比web3.js要安全。
ethers中最常用的是jsonRpcProvider，可以让用户连接到特定节点服务商的节点。
```
// 利用公共rpc节点连接以太坊网络
// 可以在 https://chainlist.org 上找到
const ALCHEMY_MAINNET_URL = 'https://rpc.ankr.com/eth';
const ALCHEMY_SEPOLIA_URL = 'https://rpc.sepolia.org';
// 连接以太坊主网
const providerETH = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL)
// 连接Sepolia测试网
const providerSepolia = new ethers.JsonRpcProvider(ALCHEMY_SEPOLIA_URL)
    // 1. 查询vitalik在主网和Sepolia测试网的ETH余额
    console.log("1. 查询vitalik在主网和Sepolia测试网的ETH余额");
    const balance = await providerETH.getBalance(`vitalik.eth`);
    const balanceSepolia = await providerSepolia.getBalance(`0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045`);
    // 将余额输出在console（主网）
    console.log(`ETH Balance of vitalik: ${ethers.formatEther(balance)} ETH`);
    // 输出Sepolia测试网ETH余额
    console.log(`Sepolia ETH Balance of vitalik: ${ethers.formatEther(balanceSepolia)} ETH`);

    // 2. 查询provider连接到了哪条链
    console.log("\n2. 查询provider连接到了哪条链")
    const network = await providerETH.getNetwork();
    console.log(network.toJSON());

    // 3. 查询区块高度
    console.log("\n3. 查询区块高度")
    const blockNumber = await providerETH.getBlockNumber();
    console.log(blockNumber);
    // 4. 查询 vitalik 钱包历史交易次数
    console.log("\n4. 查询 vitalik 钱包历史交易次数")
    const txCount = await providerETH.getTransactionCount("vitalik.eth");
    console.log(txCount);

    // 5. 查询当前建议的gas设置
    console.log("\n5. 查询当前建议的gas设置")
    const feeData = await providerETH.getFeeData();
    console.log(feeData);
    // 6. 查询区块信息
    console.log("\n6. 查询区块信息")
    const block = await providerETH.getBlock(0);
    console.log(block);
    // 7. 给定合约地址查询合约bytecode，例子用的WETH地址
    console.log("\n7. 给定合约地址查询合约bytecode，例子用的WETH地址")
    const code = await providerETH.getCode("0xc778417e063141139fce010982780140aa0cd5ab");
    console.log(code);
```

### 2024.10.8
### 读取合约信息
#### Contract类
在ethers中，Contract类是部署在以太坊网络上的合约（EVM字节码）的抽象。通过它，开发者可以非常容易的对合约进行读取call和交易transaction，并可以获得交易的结果和事件。

#### 创建Contract变量
Contract对象分为两类，只读和可读写。只读Contract只能读取链上合约信息，执行call操作，即调用合约中view和pure的函数，而不能执行交易transaction。
```
只读Contract：参数分别是合约地址，合约abi和provider变量（只读）。
const contract = new ethers.Contract(`address`, `abi`, `provider`);
可读写Contract：参数分别是合约地址，合约abi和signer变量。Signer签名者是ethers中的另一个类，用于签名交易，之后我们会讲到。
const contract = new ethers.Contract(`address`, `abi`, `signer`);
```

#### 读取合约信息
```
import { ethers } from "ethers";
// 利用Infura的rpc节点连接以太坊网络
// 准备Infura API Key, 教程：https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL02_Infura/readme.md
const INFURA_ID = ''
// 连接以太坊主网
const provider = new ethers.JsonRpcProvider(`https://mainnet.infura.io/v3/${INFURA_ID}`)
// 第1种输入abi的方式: 复制abi全文
// WETH的abi可以在这里复制：https://etherscan.io/token/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code
const abiWETH = '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view",...太长后面省略...';
const addressWETH = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2' // WETH Contract
const contractWETH = new ethers.Contract(addressWETH, abiWETH, provider)
// 第2种输入abi的方式：输入程序需要用到的函数，逗号分隔，ethers会自动帮你转换成相应的abi
// 人类可读abi，以ERC20合约为例
const abiERC20 = [
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function totalSupply() view returns (uint256)",
    "function balanceOf(address) view returns (uint)",
];
const addressDAI = '0x6B175474E89094C44Da98b954EedeAC495271d0F' // DAI Contract
const contractDAI = new ethers.Contract(addressDAI, abiERC20, provider)

const main = async () => {
    // 1. 读取WETH合约的链上信息（WETH abi）
    const nameWETH = await contractWETH.name()
    const symbolWETH = await contractWETH.symbol()
    const totalSupplyWETH = await contractWETH.totalSupply()
    console.log("\n1. 读取WETH合约信息")
    console.log(`合约地址: ${addressWETH}`)
    console.log(`名称: ${nameWETH}`)
    console.log(`代号: ${symbolWETH}`)
    console.log(`总供给: ${ethers.formatEther(totalSupplyWETH)}`)
    const balanceWETH = await contractWETH.balanceOf('vitalik.eth')
    console.log(`Vitalik持仓: ${ethers.formatEther(balanceWETH)}\n`)

    // 2. 读取DAI合约的链上信息（IERC20接口合约）
    const nameDAI = await contractDAI.name()
    const symbolDAI = await contractDAI.symbol()
    const totalSupplDAI = await contractDAI.totalSupply()
    console.log("\n2. 读取DAI合约信息")
    console.log(`合约地址: ${addressDAI}`)
    console.log(`名称: ${nameDAI}`)
    console.log(`代号: ${symbolDAI}`)
    console.log(`总供给: ${ethers.formatEther(totalSupplDAI)}`)
    const balanceDAI = await contractDAI.balanceOf('vitalik.eth')
    console.log(`Vitalik持仓: ${ethers.formatEther(balanceDAI)}\n`)
}

main()
```

### 发送ETH
#### Signer签名者类
在ethers中，Signer签名者类是以太坊账户的抽象，可用于对消息和交易进行签名，并将签名的交易发送到以太坊网络，并更改区块链状态。Signer类是抽象类，不能直接实例化，我们需要使用它的子类：Wallet钱包类。

#### Wallet钱包类
#### 创建Wallet实例
```
// 创建随机的wallet对象
const wallet1 = ethers.Wallet.createRandom()
// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet2 = new ethers.Wallet(privateKey, provider)
// 从助记词创建wallet对象
const wallet3 = ethers.Wallet.fromPhrase(mnemonic.phrase)
```
还可以通过ethers.Wallet.fromEncryptedJson解密一个JSON钱包文件创建钱包实例，JSON文件即keystore文件

#### 发送ETH
```
    // 创建交易请求，参数：to为接收地址，value为ETH数额
    const tx = {
        to: address1,
        value: ethers.parseEther("0.001")
    }
        //发送交易，获得收据
    const txRes = await wallet2.sendTransaction(tx)
    const receipt = await txRes.wait() // 等待链上确认交易
    console.log(receipt) // 打印交易的收据
    ```

#### 代码示例
```
// 利用Wallet类发送ETH
// 由于playcode不支持ethers.Wallet.createRandom()函数，我们只能用VScode运行这一讲代码
import { ethers } from "ethers";

// 利用Alchemy的rpc节点连接以太坊测试网络
// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);
// 创建随机的wallet对象
const wallet1 = ethers.Wallet.createRandom()
const wallet1WithProvider = wallet1.connect(provider)
const mnemonic = wallet1.mnemonic // 获取助记词

// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet2 = new ethers.Wallet(privateKey, provider)
// 从助记词创建wallet对象
const wallet3 = ethers.Wallet.fromPhrase(mnemonic.phrase)
    const address1 = await wallet1.getAddress()
    const address2 = await wallet2.getAddress() 
    const address3 = await wallet3.getAddress() // 获取地址
    console.log(`1. 获取钱包地址`);
    console.log(`钱包1地址: ${address1}`);
    console.log(`钱包2地址: ${address2}`);
    console.log(`钱包3地址: ${address3}`);
    console.log(`钱包1和钱包3的地址是否相同: ${address1 === address3}`);

console.log(`钱包1助记词: ${wallet1.mnemonic.phrase}`)

    console.log(`钱包2私钥: ${wallet2.privateKey}`)

    const txCount1 = await provider.getTransactionCount(wallet1WithProvider)
    const txCount2 = await provider.getTransactionCount(wallet2)
    console.log(`钱包1发送交易次数: ${txCount1}`)
    console.log(`钱包2发送交易次数: ${txCount2}`)

    // 5. 发送ETH
    // 如果这个钱包没goerli测试网ETH了，去水龙头领一些，钱包地址: 0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2
    // 1. chainlink水龙头: https://faucets.chain.link/goerli
    // 2. paradigm水龙头: https://faucet.paradigm.xyz/
    console.log(`\n5. 发送ETH（测试网）`);
    // i. 打印交易前余额
    console.log(`i. 发送前余额`)
    console.log(`钱包1: ${ethers.formatEther(await provider.getBalance(wallet1WithProvider))} ETH`)
    console.log(`钱包2: ${ethers.formatEther(await provider.getBalance(wallet2))} ETH`)
    // ii. 构造交易请求，参数：to为接收地址，value为ETH数额
    const tx = {
        to: address1,
        value: ethers.parseEther("0.001")
    }
    // iii. 发送交易，获得收据
    console.log(`\nii. 等待交易在区块链确认（需要几分钟）`)
    const receipt = await wallet2.sendTransaction(tx)
    await receipt.wait() // 等待链上确认交易
    console.log(receipt) // 打印交易详情
    // iv. 打印交易后余额
    console.log(`\niii. 发送后余额`)
    console.log(`钱包1: ${ethers.formatEther(await provider.getBalance(wallet1WithProvider))} ETH`)
    console.log(`钱包2: ${ethers.formatEther(await provider.getBalance(wallet2))} ETH`)
```

### 2024.10.9
### 合约交互
```
const contract = new ethers.Contract(address, abi, signer)
const contract2 = contract.connect(signer)
// 发送交易
const tx = await contract.METHOD_NAME(args [, overrides])
// 等待链上确认交易
await tx.wait() 
```

#### 例子：与测试网WETH合约交互
```
import { ethers } from "ethers";

// 利用Alchemy的rpc节点连接以太坊网络
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);

// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)
// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function deposit() public payable",
    "function transfer(address, uint) public returns (bool)",
    "function withdraw(uint) public",
];
// WETH合约地址（Goerli测试网）
const addressWETH = '0xb4fbf271143f4fbf7b91a5ded31805e42b2208d6' // WETH Contract

// 声明可写合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)
// 也可以声明一个只读合约，再用connect(wallet)函数转换成可写合约。
// const contractWETH = new ethers.Contract(addressWETH, abiWETH, provider)
// contractWETH.connect(wallet)
const address = await wallet.getAddress()
// 读取WETH合约的链上信息（WETH abi）
console.log("\n1. 读取WETH余额")
const balanceWETH = await contractWETH.balanceOf(address)
console.log(`存款前WETH持仓: ${ethers.formatEther(balanceWETH)}\n`)
    console.log("\n2. 调用desposit()函数，存入0.001 ETH")
    // 发起交易
    const tx = await contractWETH.deposit({value: ethers.parseEther("0.001")})
    // 等待交易上链
    await tx.wait()
    console.log(`交易详情：`)
    console.log(tx)
    const balanceWETH_deposit = await contractWETH.balanceOf(address)
    console.log(`存款后WETH持仓: ${ethers.formatEther(balanceWETH_deposit)}\n`)
    console.log("\n3. 调用transfer()函数，给vitalik转账0.001 WETH")
    // 发起交易
    const tx2 = await contractWETH.transfer("vitalik.eth", ethers.parseEther("0.001"))
    // 等待交易上链
    await tx2.wait()
    const balanceWETH_transfer = await contractWETH.balanceOf(address)
    console.log(`转账后WETH持仓: ${ethers.formatEther(balanceWETH_transfer)}\n`)
```

### 部署合约
在以太坊上，智能合约的部署是一种特殊的交易：将编译智能合约得到的字节码发送到0地址。如果这个合约的构造函数有参数的话，需要利用abi.encode将参数编码为字节码，然后附在在合约字节码的尾部一起发送。

#### 合约工厂
ethers.js创造了合约工厂ContractFactory类型，方便开发者部署合约。你可以利用合约abi，编译得到的字节码bytecode和签名者变量signer来创建合约工厂实例，为部署合约做准备。
```
const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
const contract = await contractFactory.deploy(args)
await contractERC20.waitForDeployment();
```

#### 例子：部署ERC20代币合约
```
import { ethers } from "ethers";

// 利用Alchemy的rpc节点连接以太坊网络
// 连接goerli测试网
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);

// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)
// ERC20的人类可读abi
const abiERC20 = [
    "constructor(string memory name_, string memory symbol_)",
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function totalSupply() view returns (uint256)",
    "function balanceOf(address) view returns (uint)",
    "function transfer(address to, uint256 amount) external returns (bool)",
    "function mint(uint amount) external",
];
// 填入合约字节码，在remix中，你可以在两个地方找到Bytecode
// 1. 编译面板的Bytecode按钮
// 2. 文件面板artifact文件夹下与合约同名的json文件中
// 里面"bytecode"属性下的"object"字段对应的数据就是Bytecode，挺长的，608060起始
// "object": "608060405260646000553480156100...
const bytecodeERC20 = "60806040526012600560006101000a81548160ff021916908360ff1602179055503480156200002d57600080fd5b5060405162001166380380620011668339818101604052810190620000539190620001bb565b81600390805190602001906200006b9291906200008d565b508060049080519060200190620000849291906200008d565b505050620003c4565b8280546200009b90620002d5565b90600052602060002090601f016020900481019282620000bf57600085556200010b565b82601f10620000da57805160ff19168380011785556200010b565b828001600101855582156200010b579182015b828111156200010a578251825591602001919060010190620000ed565b5b5090506200011a91906200011e565b5090565b5b80821115620001395760008160009055506001016200011f565b5090565b6000620001546200014e8462000269565b62000240565b905082815260208101848484011115620001735762000172620003a4565b5b620001808482856200029f565b509392505050565b600082601f830112620001a0576200019f6200039f565b5b8151620001b28482602086016200013d565b91505092915050565b60008060408385031215620001d557620001d4620003ae565b5b600083015167ffffffffffffffff811115620001f657620001f5620003a9565b5b620002048582860162000188565b925050602083015167ffffffffffffffff811115620002285762000227620003a9565b5b620002368582860162000188565b9150509250929050565b60006200024c6200025f565b90506200025a82826200030b565b919050565b6000604051905090565b600067ffffffffffffffff82111562000287576200028662000370565b5b6200029282620003b3565b9050602081019050919050565b60005b83811015620002bf578082015181840152602081019050620002a2565b83811115620002cf576000848401525b50505050565b60006002820490506001821680620002ee57607f821691505b6020821081141562000305576200030462000341565b5b50919050565b6200031682620003b3565b810181811067ffffffffffffffff8211171562000338576200033762000370565b5b80604052505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b600080fd5b600080fd5b600080fd5b600080fd5b6000601f19601f8301169050919050565b610d9280620003d46000396000f3fe608060405234801561001057600080fd5b50600436106100a95760003560e01c806342966c681161007157806342966c681461016857806370a082311461018457806395d89b41146101b4578063a0712d68146101d2578063a9059cbb146101ee578063dd62ed3e1461021e576100a9565b806306fdde03146100ae578063095ea7b3146100cc57806318160ddd146100fc57806323b872dd1461011a578063313ce5671461014a575b600080fd5b6100b661024e565b6040516100c39190610b02565b60405180910390f35b6100e660048036038101906100e19190610a14565b6102dc565b6040516100f39190610ae7565b60405180910390f35b6101046103ce565b6040516101119190610b24565b60405180910390f35b610134600480360381019061012f91906109c1565b6103d4565b6040516101419190610ae7565b60405180910390f35b610152610583565b60405161015f9190610b3f565b60405180910390f35b610182600480360381019061017d9190610a54565b610596565b005b61019e60048036038101906101999190610954565b61066d565b6040516101ab9190610b24565b60405180910390f35b6101bc610685565b6040516101c99190610b02565b60405180910390f35b6101ec60048036038101906101e79190610a54565b610713565b005b61020860048036038101906102039190610a14565b6107ea565b6040516102159190610ae7565b60405180910390f35b61023860048036038101906102339190610981565b610905565b6040516102459190610b24565b60405180910390f35b6003805461025b90610c88565b80601f016020809104026020016040519081016040528092919081815260200182805461028790610c88565b80156102d45780601f106102a9576101008083540402835291602001916102d4565b820191906000526020600020905b8154815290600101906020018083116102b757829003601f168201915b505050505081565b600081600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055508273ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925846040516103bc9190610b24565b60405180910390a36001905092915050565b60025481565b600081600160008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546104629190610bcc565b92505081905550816000808673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546104b79190610bcc565b92505081905550816000808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825461050c9190610b76565b925050819055508273ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef846040516105709190610b24565b60405180910390a3600190509392505050565b600560009054906101000a900460ff1681565b806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546105e49190610bcc565b9250508190555080600260008282546105fd9190610bcc565b92505081905550600073ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516106629190610b24565b60405180910390a350565b60006020528060005260406000206000915090505481565b6004805461069290610c88565b80601f01602080910402602001604051908101604052809291908181526020018280546106be90610c88565b801561070b5780601f106106e05761010080835404028352916020019161070b565b820191906000526020600020905b8154815290600101906020018083116106ee57829003601f168201915b505050505081565b806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546107619190610b76565b92505081905550806002600082825461077a9190610b76565b925050819055503373ffffffffffffffffffffffffffffffffffffffff16600073ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516107df9190610b24565b60405180910390a350565b6000816000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825461083a9190610bcc565b92505081905550816000808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825461088f9190610b76565b925050819055508273ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef846040516108f39190610b24565b60405180910390a36001905092915050565b6001602052816000526040600020602052806000526040600020600091509150505481565b60008135905061093981610d2e565b92915050565b60008135905061094e81610d45565b92915050565b60006020828403121561096a57610969610d18565b5b60006109788482850161092a565b91505092915050565b6000806040838503121561099857610997610d18565b5b60006109a68582860161092a565b92505060206109b78582860161092a565b9150509250929050565b6000806000606084860312156109da576109d9610d18565b5b60006109e88682870161092a565b93505060206109f98682870161092a565b9250506040610a0a8682870161093f565b9150509250925092565b60008060408385031215610a2b57610a2a610d18565b5b6000610a398582860161092a565b9250506020610a4a8582860161093f565b9150509250929050565b600060208284031215610a6a57610a69610d18565b5b6000610a788482850161093f565b91505092915050565b610a8a81610c12565b82525050565b6000610a9b82610b5a565b610aa58185610b65565b9350610ab5818560208601610c55565b610abe81610d1d565b840191505092915050565b610ad281610c3e565b82525050565b610ae181610c48565b82525050565b6000602082019050610afc6000830184610a81565b92915050565b60006020820190508181036000830152610b1c8184610a90565b905092915050565b6000602082019050610b396000830184610ac9565b92915050565b6000602082019050610b546000830184610ad8565b92915050565b600081519050919050565b600082825260208201905092915050565b6000610b8182610c3e565b9150610b8c83610c3e565b9250827fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff03821115610bc157610bc0610cba565b5b828201905092915050565b6000610bd782610c3e565b9150610be283610c3e565b925082821015610bf557610bf4610cba565b5b828203905092915050565b6000610c0b82610c1e565b9050919050565b60008115159050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000819050919050565b600060ff82169050919050565b60005b83811015610c73578082015181840152602081019050610c58565b83811115610c82576000848401525b50505050565b60006002820490506001821680610ca057607f821691505b60208210811415610cb457610cb3610ce9565b5b50919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b600080fd5b6000601f19601f8301169050919050565b610d3781610c00565b8114610d4257600080fd5b50565b610d4e81610c3e565b8114610d5957600080fd5b5056fea2646970667358221220f87d0662c51e3b4b5e034fe8e1e7a10185cda3c246a5ba78e0bafe683d67789764736f6c63430008070033";
const factoryERC20 = new ethers.ContractFactory(abiERC20, bytecodeERC20, wallet);
// 1. 利用contractFactory部署ERC20代币合约
console.log("\n1. 利用contractFactory部署ERC20代币合约")
// 部署合约，填入constructor的参数
const contractERC20 = await factoryERC20.deploy("WTF Token", "WTF")
console.log(`合约地址: ${contractERC20.target}`);
console.log("部署合约的交易详情")
console.log(contractERC20.deploymentTransaction())
console.log("\n等待合约部署上链")
await contractERC20.waitForDeployment()
// 也可以用 contractERC20.deployTransaction.wait()
console.log("合约已上链")

// 打印合约的name()和symbol()，然后调用mint()函数，给自己地址mint 10,000代币
console.log("\n2. 调用mint()函数，给自己地址mint 10,000代币")
console.log(`合约名称: ${await contractERC20.name()}`)
console.log(`合约代号: ${await contractERC20.symbol()}`)
let tx = await contractERC20.mint("10000")
console.log("等待交易上链")
await tx.wait()
console.log(`mint后地址中代币余额: ${await contractERC20.balanceOf(wallet)}`)
console.log(`代币总供给: ${await contractERC20.totalSupply()}`)

// 3. 调用transfer()函数，给Vitalik转账1000代币
console.log("\n3. 调用transfer()函数，给Vitalik转账1,000代币")
tx = await contractERC20.transfer("vitalik.eth", "1000")
console.log("等待交易上链")
await tx.wait()
console.log(`Vitalik钱包中的代币余额: ${await contractERC20.balanceOf("vitalik.eth")}`)
```

### 检索事件
#### 事件Event
智能合约释放出的事件存储于以太坊虚拟机的日志中。日志分为两个主题topics和数据data部分，其中事件哈希和indexed变量存储在topics中，作为索引方便以后搜索；没有indexed变量存储在data中，不能被直接检索，但可以存储更复杂的数据结构。
```
event Transfer(address indexed from, address indexed to, uint256 amount);
```
可以利用Ethers中合约类型的queryFilter()函数读取合约释放的事件。
```
const transferEvents = await contract.queryFilter('事件名', 起始区块, 结束区块)

#### 例子：检索WETH合约中的Transfer事件
```
import { ethers } from "ethers";
// 利用Alchemy的rpc节点连接以太坊网络
// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);

// WETH ABI，只包含我们关心的Transfer事件
const abiWETH = [
    "event Transfer(address indexed from, address indexed to, uint amount)"
];

// 测试网WETH地址
const addressWETH = '0xb4fbf271143f4fbf7b91a5ded31805e42b2208d6'
// 声明合约实例
const contract = new ethers.Contract(addressWETH, abiWETH, provider)

// 得到当前block
const block = await provider.getBlockNumber()
console.log(`当前区块高度: ${block}`);
console.log(`打印事件详情:`);
const transferEvents = await contract.queryFilter('Transfer', block - 10, block)
// 打印第1个Transfer事件
console.log(transferEvents[0])
// 解析Transfer事件的数据（变量在args中）
console.log("\n2. 解析事件：")
const amount = ethers.formatUnits(ethers.getBigInt(transferEvents[0].args["amount"]), "ether");
console.log(`地址 ${transferEvents[0].args["from"]} 转账${amount} WETH 到地址 ${transferEvents[0].args["to"]}`)
```

### 监听合约事件
```
contract.on("eventName", function)
contract.once("eventName", function)
```

#### 监听USDT合约
```
import { ethers } from "ethers";
// 准备 alchemy API  
// 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_MAINNET_URL = 'https://eth-mainnet.g.alchemy.com/v2/oKmOQKbneVkxgHZfibs-iFhIlIAl6HDN';
// 连接主网 provider
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);

// USDT的合约地址
const contractAddress = '0xdac17f958d2ee523a2206206994597c13d831ec7'
// 构建USDT的Transfer的ABI
const abi = [
  "event Transfer(address indexed from, address indexed to, uint value)"
];
// 生成USDT合约对象
const contractUSDT = new ethers.Contract(contractAddress, abi, provider);
  // 只监听一次
  console.log("\n1. 利用contract.once()，监听一次Transfer事件");
  contractUSDT.once('Transfer', (from, to, value)=>{
    // 打印结果
    console.log(
      `${from} -> ${to} ${ethers.formatUnits(ethers.getBigInt(value),6)}`
    )
  })
  // 持续监听USDT合约
  console.log("\n2. 利用contract.on()，持续监听Transfer事件");
  contractUSDT.on('Transfer', (from, to, value)=>{
    console.log(
     // 打印结果
     `${from} -> ${to} ${ethers.formatUnits(ethers.getBigInt(value),6)}`
    )
  })
```

### 事件过滤
#### 过滤器
当合约创建日志（释放事件）时，它最多可以包含[4]条数据作为索引（indexed）。索引数据经过哈希处理并包含在布隆过滤器中，这是一种允许有效过滤的数据结构。因此，一个事件过滤器最多包含4个主题集，每个主题集是个条件，用于筛选目标事件。规则：
- 如果一个主题集为null，则该位置的日志主题不会被过滤，任何值都匹配。
- 如果主题集是单个值，则该位置的日志主题必须与该值匹配。
- 如果主题集是数组，则该位置的日志主题至少与数组中其中一个匹配。
![image](https://github.com/user-attachments/assets/e02ecda0-3fe8-445a-b45f-785cbc2d3b84)

#### 构建过滤器
```
const filter = contract.filters.EVENT_NAME( ...args ) 
contract.filters.Transfer(myAddress)
contract.filters.Transfer(null, myAddress)
contract.filters.Transfer(myAddress, otherAddress)
contract.filters.Transfer(null, [ myAddress, otherAddress ])
```

#### 监听交易所的USDT转账
```
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);
// 合约地址
const addressUSDT = '0xdac17f958d2ee523a2206206994597c13d831ec7'
// 交易所地址
const accountBinance = '0x28C6c06298d514Db089934071355E5743bf21d60'
// 构建ABI
const abi = [
  "event Transfer(address indexed from, address indexed to, uint value)",
  "function balanceOf(address) public view returns(uint)",
];
// 构建合约对象
const contractUSDT = new ethers.Contract(addressUSDT, abi, provider);
const balanceUSDT = await contractUSDT.balanceOf(accountBinance)
console.log(`USDT余额: ${ethers.formatUnits(balanceUSDT,6)}\n`)
// 2. 创建过滤器，监听转移USDT进交易所
console.log("\n2. 创建过滤器，监听USDT转进交易所")
let filterBinanceIn = contractUSDT.filters.Transfer(null, accountBinance);
console.log("过滤器详情：")
console.log(filterBinanceIn);
contractUSDT.on(filterBinanceIn, (res) => {
  console.log('---------监听USDT进入交易所--------');
  console.log(
    `${res.args[0]} -> ${res.args[1]} ${ethers.formatUnits(res.args[2],6)}`
  )
})

  // 3. 创建过滤器，监听交易所转出USDT
  let filterToBinanceOut = contractUSDT.filters.Transfer(accountBinance);
  console.log("\n3. 创建过滤器，监听USDT转出交易所")
  console.log("过滤器详情：")
  console.log(filterToBinanceOut);
  contractUSDT.on(filterToBinanceOut, (res) => {
    console.log('---------监听USDT转出交易所--------');
    console.log(
      `${res.args[0]} -> ${res.args[1]} ${ethers.formatUnits(res.args[2],6)}`
    )
  }
  );
```

### BigInt和单位转换
以太坊中，许多计算都对超出JavaScript整数的安全值（js中最大安全整数为9007199254740991）。因此，ethers.js使用 JavaScript ES2020 版本原生的 BigInt 类 安全地对任何数量级的数字进行数学运算。在ethers.js中，大多数需要返回值的操作将返回 BigInt，而接受值的参数也会接受它们。

#### 创建BigInt
```
const oneGwei = ethers.getBigInt("1000000000"); // 从十进制字符串生成
console.log(oneGwei)
console.log(ethers.getBigInt("0x3b9aca00")) // 从hex字符串生成
console.log(ethers.getBigInt(1000000000)) // 从数字生成
// 不能从js最大的安全整数之外的数字生成BigNumber，下面代码会报错
// ethers.getBigInt(Number.MAX_SAFE_INTEGER);
console.log("js中最大安全整数：", Number.MAX_SAFE_INTEGER)

// 运算
console.log("加法：", oneGwei + 1n)
console.log("减法：", oneGwei - 1n)
console.log("乘法：", oneGwei * 2n)
console.log("除法：", oneGwei / 2n)
// 比较
console.log("是否相等：", oneGwei == 1000000000n)
![image](https://github.com/user-attachments/assets/a565abca-8fbe-4ff1-8fbf-83bdf50537d8)
//代码参考：https://docs.ethers.org/v6/api/utils/#about-units
console.group('\n2. 格式化：小单位转大单位，formatUnits');
console.log(ethers.formatUnits(oneGwei, 0));
// '1000000000'
console.log(ethers.formatUnits(oneGwei, "gwei"));
// '1.0'
console.log(ethers.formatUnits(oneGwei, 9));
// '1.0'
console.log(ethers.formatUnits(oneGwei, "ether"));
// `0.000000001`
console.log(ethers.formatUnits(1000000000, "gwei"));
// '1.0'
console.log(ethers.formatEther(oneGwei));
// `0.000000001` 等同于formatUnits(value, "ether")
console.groupEnd();

// 3. 解析：大单位转小单位
// 例如将ether转换为wei：parseUnits(变量, 单位),parseUnits默认单位是 ether
// 代码参考：https://docs.ethers.org/v6/api/utils/#about-units
console.group('\n3. 解析：大单位转小单位，parseUnits');
console.log(ethers.parseUnits("1.0").toString());
// { BigNumber: "1000000000000000000" }
console.log(ethers.parseUnits("1.0", "ether").toString());
// { BigNumber: "1000000000000000000" }
console.log(ethers.parseUnits("1.0", 18).toString());
// { BigNumber: "1000000000000000000" }
console.log(ethers.parseUnits("1.0", "gwei").toString());
// { BigNumber: "1000000000" }
console.log(ethers.parseUnits("1.0", 9).toString());
// { BigNumber: "1000000000" }
console.log(ethers.parseEther("1.0").toString());
// { BigNumber: "1000000000000000000" } 等同于parseUnits(value, "ether")
console.groupEnd();
```

### 2024.10.10
### StaticCall
在发送交易之前检查交易是否会失败，节省大量gas。
在 ethers.js 中，你可以使用 contract.函数名.staticCall() 方法来模拟执行一个可能会改变状态的函数，但不实际向区块链提交这个状态改变。这相当于调用以太坊节点的 eth_call。这通常用于模拟状态改变函数的结果。如果函数调用成功，它将返回函数本身的返回值；如果函数调用失败，它将抛出异常。
```
    const tx = await contract.函数名.staticCall( 参数, {override})
    console.log(`交易会成功吗？：`, tx)
    ```
####用StaticCall模拟DAI转账
```
import { ethers } from "ethers";

//准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_MAINNET_URL = 'https://eth-mainnet.g.alchemy.com/v2/oKmOQKbneVkxgHZfibs-iFhIlIAl6HDN';
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);

// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)
// DAI的ABI
const abiDAI = [
    "function balanceOf(address) public view returns(uint)",
    "function transfer(address, uint) public returns (bool)",
];
// DAI合约地址（主网）
const addressDAI = '0x6B175474E89094C44Da98b954EedeAC495271d0F' // DAI Contract
// 创建DAI合约实例
const contractDAI = new ethers.Contract(addressDAI, abiDAI, provider)
const address = await wallet.getAddress()
console.log("\n1. 读取测试钱包的DAI余额")
const balanceDAI = await contractDAI.balanceOf(address)
console.log(`DAI持仓: ${ethers.formatEther(balanceDAI)}\n`)
console.log("\n2.  用staticCall尝试调用transfer转账1 DAI，msg.sender为Vitalik地址")
// 发起交易
const tx = await contractDAI.transfer.staticCall("vitalik.eth", ethers.parseEther("1"), {from:  await provider.resolveName("vitalik.eth")})
console.log(`交易会成功吗？：`, tx)
console.log("\n3.  用staticCall尝试调用transfer转账10000 DAI，msg.sender为测试钱包地址")
const tx2 = await contractDAI.transfer.staticCall("vitalik.eth", ethers.parseEther("10000"), {from: address})
console.log(`交易会成功吗？：`, tx2)
```

### 识别ERC721合约
#### ERC165
通过ERC165标准，智能合约可以声明它支持的接口，供其他合约检查。
```
interface IERC165 {
    /**
     * @dev 如果合约实现了查询的`interfaceId`，则返回true
     * 规则详见：https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     *
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


   function supportsInterface(bytes4 interfaceId)
        external
        pure
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId 
    }
```

#### 识别ERC721
```
//准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_MAINNET_URL = 'https://eth-mainnet.g.alchemy.com/v2/oKmOQKbneVkxgHZfibs-iFhIlIAl6HDN';
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL);
// 合约abi
const abiERC721 = [
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function supportsInterface(bytes4) public view returns(bool)",
];
// ERC721的合约地址，这里用的BAYC
const addressBAYC = "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d"
// 创建ERC721合约实例
const contractERC721 = new ethers.Contract(addressBAYC, abiERC721, provider)

// 1. 读取ERC721合约的链上信息
const nameERC721 = await contractERC721.name()
const symbolERC721 = await contractERC721.symbol()
console.log("\n1. 读取ERC721合约信息")
console.log(`合约地址: ${addressBAYC}`)
console.log(`名称: ${nameERC721}`)
console.log(`代号: ${symbolERC721}`)

// 2. 利用ERC165的supportsInterface，确定合约是否为ERC721标准
// ERC721接口的ERC165 identifier
const selectorERC721 = "0x80ac58cd"
const isERC721 = await contractERC721.supportsInterface(selectorERC721)
console.log("\n2. 利用ERC165的supportsInterface，确定合约是否为ERC721标准")
console.log(`合约是否为ERC721标准: ${isERC721}`)
```

### 编码calldata
#### 接口类Interface
ethers.js的接口类抽象了与以太坊网络上的合约交互所需的ABI编码和解码。ABI（Application Binary Interface）与API类似，是一格式，用于对合约可以处理的各种类型的数据进行编码，以便它们可以交互。
```
// 利用abi生成
const interface = ethers.Interface(abi)
// 直接从contract中获取
const interface2 = contract.interface
interface.getSighash("balanceOf");
// '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef'
interface.encodeDeploy("Wrapped ETH", "WETH");
interface.encodeFunctionData("balanceOf", ["0xc778417e063141139fce010982780140aa0cd5ab"]);
interface.decodeFunctionResult("balanceOf", resultData)
```

#### 例子：与测试网WETH合约交互
```
//准备 alchemy API 可以参考https://github.com/AmazingAng/WTFSolidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-rinkeby.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);

// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)

// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function deposit() public payable",
];
// WETH合约地址（Goerli测试网）
const addressWETH = '0xb4fbf271143f4fbf7b91a5ded31805e42b2208d6'
// 声明WETH合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)

const address = await wallet.getAddress()
// 1. 读取WETH合约的链上信息（WETH abi）
console.log("\n1. 读取WETH余额")
// 编码calldata
const param1 = contractWETH.interface.encodeFunctionData(
    "balanceOf",
    [address]
  );
console.log(`编码结果： ${param1}`)
// 创建交易
const tx1 = {
    to: addressWETH,
    data: param1
}
// 发起交易，可读操作（view/pure）可以用 provider.call(tx)
const balanceWETH = await provider.call(tx1)
console.log(`存款前WETH持仓: ${ethers.formatEther(balanceWETH)}\n`)
// 编码calldata
const param2 = contractWETH.interface.encodeFunctionData(
    "deposit"          
    );
console.log(`编码结果： ${param2}`)
// 创建交易
const tx2 = {
    to: addressWETH,
    data: param2,
    value: ethers.parseEther("0.001")}
// 发起交易，写入操作需要 wallet.sendTransaction(tx)
const receipt1 = await wallet.sendTransaction(tx2)
// 等待交易上链
await receipt1.wait()
console.log(`交易详情：`)
console.log(receipt1)
const balanceWETH_deposit = await contractWETH.balanceOf(address)
console.log(`存款后WETH持仓: ${ethers.formatEther(balanceWETH_deposit)}\n`)
```

### 2024.10.11
### 批量生成钱包
#### HD钱包Hierarchical Deterministic Wallet
HD钱包（Hierarchical Deterministic Wallet，多层确定性钱包）是一种数字钱包 ，通常用于存储比特币和以太坊等加密货币持有者的数字密钥。

#### BIP32
在BIP32推出之前，用户需要记录一堆的私钥才能管理很多钱包。BIP32提出可以用一个随机种子衍生多个私钥，更方便的管理多个钱包。钱包的地址由衍生路径决定，例如“m/0/0/1”。
![image](https://github.com/user-attachments/assets/a0811c12-b668-47a2-a71b-e35dd84aba96)
#### BIP44
BIP44为BIP32的衍生路径提供了一套通用规范，适配比特币、以太坊等多链。这一套规范包含六级，每级之间用"/"分割：
```
m / purpose' / coin_type' / account' / change / address_index
```
其中：
m: 固定为"m"
purpose：固定为"44"
coin_type：代币类型，比特币主网为0，比特币测试网为1，以太坊主网为60
account：账户索引，从0开始。
change：是否为外部链，0为外部链，1为内部链，一般填0.
address_index：地址索引，从0开始，想生成新地址就把这里改为1，2，3。
举个例子，以太坊的默认衍生路径为"m/44'/60'/0'/0/0"。
#### BIP39
BIP39让用户能以一些人类可记忆的助记词的方式保管私钥，而不是一串16进制的数字：
```
//私钥
0x813f8f0a4df26f6455814fdd07dd2ab2d0e2d13f4d2f3c66e7fd9e3856060f89
//助记词
air organ twist rule prison symptom jazz cheap rather dizzy verb glare jeans orbit weapon universe require tired sing casino business anxiety seminar hunt
```

#### 批量生成钱包
```
// 生成随机助记词
const mnemonic = ethers.Mnemonic.entropyToPhrase(ethers.randomBytes(32))
// 创建HD基钱包
// 基路径："m / purpose' / coin_type' / account' / change"
const basePath = "44'/60'/0'/0"
const baseWallet = ethers.HDNodeWallet.fromPhrase(mnemonic, basePath)
console.log(baseWallet);
const numWallet = 20
// 派生路径：基路径 + "/ address_index"
// 我们只需要提供最后一位address_index的字符串格式，就可以从baseWallet派生出新钱包。V6中不需要重复提供基路径！
let wallets = [];
for (let i = 0; i < numWallet; i++) {
    let baseWalletNew = baseWallet.derivePath(i.toString());
    console.log(`第${i+1}个钱包地址： ${baseWalletNew.address}`)
    wallets.push(baseWalletNew);
}
const wallet = ethers.Wallet.fromPhrase(mnemonic)
console.log("通过助记词创建钱包：")
console.log(wallet)
// 加密json用的密码，可以更改成别的
const pwd = "password"
const json = await wallet.encrypt(pwd)
console.log("钱包的加密json：")
console.log(json)

const wallet2 = await ethers.Wallet.fromEncryptedJson(json, pwd);
console.log("\n4. 从加密json读取钱包：")
console.log(wallet2)
```

### 批量转账
```
console.log("\n1. 创建HD钱包")
// 通过助记词生成HD钱包
const mnemonic = `air organ twist rule prison symptom jazz cheap rather dizzy verb glare jeans orbit weapon universe require tired sing casino business anxiety seminar hunt`
const hdNode = ethers.HDNodeWallet.fromPhrase(mnemonic)
console.log(hdNode);
console.log("\n2. 通过HD钱包派生20个钱包")
const numWallet = 20
// 派生路径：m / purpose' / coin_type' / account' / change / address_index
// 我们只需要切换最后一位address_index，就可以从hdNode派生出新钱包
let basePath = "m/44'/60'/0'/0";
let addresses = [];
for (let i = 0; i < numWallet; i++) {
    let hdNodeNew = hdNode.derivePath(basePath + "/" + i);
    let walletNew = new ethers.Wallet(hdNodeNew.privateKey);
    addresses.push(walletNew.address);
}
console.log(addresses)
const amounts = Array(20).fill(ethers.parseEther("0.0001"))
console.log(`发送数额：${amounts}`)

//准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);

// 利用私钥和provider创建wallet对象
// 如果这个钱包没goerli测试网ETH了
// 请使用自己的小号钱包测试，钱包地址: 0x338f8891D6BdC58eEB4754352459cC461EfD2a5E ,请不要给此地址发送任何ETH
// 注意不要把自己的私钥上传到github上
const privateKey = '0x21ac72b6ce19661adf31ef0d2bf8c3fcad003deee3dc1a1a64f5fa3d6b049c06'
const wallet = new ethers.Wallet(privateKey, provider)

// Airdrop的ABI
const abiAirdrop = [
    "function multiTransferToken(address,address[],uint256[]) external",
    "function multiTransferETH(address[],uint256[]) public payable",
];
// Airdrop合约地址（Goerli测试网）
const addressAirdrop = '0x71C2aD976210264ff0468d43b198FD69772A25fa' // Airdrop Contract
// 声明Airdrop合约
const contractAirdrop = new ethers.Contract(addressAirdrop, abiAirdrop, wallet)

// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function transfer(address, uint) public returns (bool)",
    "function approve(address, uint256) public returns (bool)"
];
// WETH合约地址（Goerli测试网）
const addressWETH = '0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6' // WETH Contract
// 声明WETH合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)

console.log("\n3. 读取一个地址的ETH和WETH余额")
//读取WETH余额
const balanceWETH = await contractWETH.balanceOf(addresses[10])
console.log(`WETH持仓: ${ethers.formatEther(balanceWETH)}\n`)
//读取ETH余额
const balanceETH = await provider.getBalance(addresses[10])
console.log(`ETH持仓: ${ethers.formatEther(balanceETH)}\n`)

console.log("\n4. 调用multiTransferETH()函数，给每个钱包转 0.0001 ETH")
// 发起交易
const tx = await contractAirdrop.multiTransferETH(addresses, amounts, {value: ethers.parseEther("0.002")})
// 等待交易上链
await tx.wait()
// console.log(`交易详情：`)
// console.log(tx)
const balanceETH2 = await provider.getBalance(addresses[10])
console.log(`发送后该钱包ETH持仓: ${ethers.formatEther(balanceETH2)}\n`)

console.log("\n5. 调用multiTransferToken()函数，给每个钱包转 0.0001 WETH")
// 先approve WETH给Airdrop合约
const txApprove = await contractWETH.approve(addressAirdrop, ethers.parseEther("1"))
await txApprove.wait()
// 发起交易
const tx2 = await contractAirdrop.multiTransferToken(addressWETH, addresses, amounts)
// 等待交易上链
await tx2.wait()
// console.log(`交易详情：`)
// console.log(tx2)
// 读取WETH余额
const balanceWETH2 = await contractWETH.balanceOf(addresses[10])
console.log(`发送后该钱包WETH持仓: ${ethers.formatEther(balanceWETH2)}\n`)
```

### 批量归集
```
// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);
// 利用私钥和provider创建wallet对象
const privateKey = '0x21ac72b6ce19661adf31ef0d2bf8c3fcad003deee3dc1a1a64f5fa3d6b049c06'
const wallet = new ethers.Wallet(privateKey, provider)

// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function transfer(address, uint) public returns (bool)",
];
// WETH合约地址（Goerli测试网）
const addressWETH = '0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6' // WETH Contract
// 声明WETH合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)

console.log("\n1. 创建HD钱包")
// 通过助记词生成HD钱包
const mnemonic = `air organ twist rule prison symptom jazz cheap rather dizzy verb glare jeans orbit weapon universe require tired sing casino business anxiety seminar hunt`
const hdNode = ethers.HDNodeWallet.fromPhrase(mnemonic)
console.log(hdNode);

const numWallet = 20
// 派生路径：m / purpose' / coin_type' / account' / change / address_index
// 我们只需要切换最后一位address_index，就可以从hdNode派生出新钱包
let basePath = "m/44'/60'/0'/0";
let wallets = [];
for (let i = 0; i < numWallet; i++) {
    let hdNodeNew = hdNode.derivePath(basePath + "/" + i);
    let walletNew = new ethers.Wallet(hdNodeNew.privateKey);
    wallets.push(walletNew);
    console.log(walletNew.address)
}
// 定义发送数额
const amount = ethers.parseEther("0.0001")
console.log(`发送数额：${amount}`)

console.log("\n3. 读取一个地址的ETH和WETH余额")
//读取WETH余额
const balanceWETH = await contractWETH.balanceOf(wallets[19])
console.log(`WETH持仓: ${ethers.formatEther(balanceWETH)}`)
//读取ETH余额
const balanceETH = await provider.getBalance(wallets[19])
console.log(`ETH持仓: ${ethers.formatEther(balanceETH)}\n`)

// 6. 批量归集钱包的ETH
console.log("\n4. 批量归集20个钱包的ETH")
const txSendETH = {
    to: wallet.address,
    value: amount
}
for (let i = 0; i < numWallet; i++) {
    // 将钱包连接到provider
    let walletiWithProvider = wallets[i].connect(provider)
    var tx = await walletiWithProvider.sendTransaction(txSendETH)
    console.log(`第 ${i+1} 个钱包 ${walletiWithProvider.address} ETH 归集开始`)
}
await tx.wait()
console.log(`ETH 归集结束`)
for (let i = 0; i < numWallet; i++) {
    // 将钱包连接到provider
    let walletiWithProvider = wallets[i].connect(provider)
    // 将合约连接到新的钱包
    let contractConnected = contractWETH.connect(walletiWithProvider)
    var tx = await contractConnected.transfer(wallet.address, amount)
    console.log(`第 ${i+1} 个钱包 ${wallets[i].address} WETH 归集开始`)
}
await tx.wait()
console.log(`WETH 归集结束`)
console.log("\n6. 读取一个地址在归集后的ETH和WETH余额")
// 读取WETH余额
const balanceWETHAfter = await contractWETH.balanceOf(wallets[19])
console.log(`归集后WETH持仓: ${ethersfromPhrase.formatEther(balanceWETHAfter)}`)
// 读取ETH余额
const balanceETHAfter = await provider.getBalance(wallets[19])
console.log(`归集后ETH持仓: ${ethersfromPhrase.formatEther(balanceETHAfter)}\n`)
```

### MerkleTree脚本
Merkle Tree，也叫默克尔树或哈希树，是区块链的底层加密技术，被比特币和以太坊区块链广泛采用。Merkle Tree是一种自下而上构建的加密树，每个叶子是对应数据的哈希，而每个非叶子为它的2个子节点的哈希。
![image](https://github.com/user-attachments/assets/1c8824e8-f130-44fd-ae53-af58417968e3)

Merkle Tree允许对大型数据结构的内容进行有效和安全的验证（Merkle Proof）。对于有N个叶子结点的Merkle Tree，在已知root根值的情况下，验证某个数据是否有效（属于Merkle Tree叶子结点）只需要log(N)个数据（也叫proof），非常高效。如果数据有误，或者给的proof错误，则无法还原出root根植。
![image](https://github.com/user-attachments/assets/0059873f-e8e9-4901-a5e2-8ac857a34202)

```
import { MerkleTree } from "merkletreejs";
// 白名单地址
const tokens = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", 
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"
];

const leaf = tokens.map(x => ethers.keccak256(x))
const merkletree = new MerkleTree(leaf, ethers.keccak256, { sortPairs: true });
const root = merkletree.getHexRoot()
const proof = merkletree.getHexProof(leaf[0]);

// 1. 生成merkle tree
console.log("\n1. 生成merkle tree")
// 白名单地址
const tokens = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", 
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"
];
// leaf, merkletree, proof
const leaf       = tokens.map(x => ethers.keccak256(x))
const merkletree = new MerkleTree(leaf, ethers.keccak256, { sortPairs: true });
const proof      = merkletree.getHexProof(leaf[0]);
const root = merkletree.getHexRoot()
console.log("Leaf:")
console.log(leaf)
console.log("\nMerkleTree:")
console.log(merkletree.toString())
console.log("\nProof:")
console.log(proof)
console.log("\nRoot:")
console.log(root)

// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);
// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)

// 3. 创建合约工厂
// NFT的abi
const abiNFT = [
    "constructor(string memory name, string memory symbol, bytes32 merkleroot)",
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function mint(address account, uint256 tokenId, bytes32[] calldata proof) external",
    "function ownerOf(uint256) view returns (address)",
    "function balanceOf(address) view returns (uint256)",
];
// 合约字节码，在remix中，你可以在两个地方找到Bytecode
// i. 部署面板的Bytecode按钮
// ii. 文件面板artifact文件夹下与合约同名的json文件中
// 里面"object"字段对应的数据就是Bytecode，挺长的，608060起始
// "object": "608060405260646000553480156100...
const bytecodeNFT = contractJson.default.object;
const factoryNFT = new ethers.ContractFactory(abiNFT, bytecodeNFT, wallet);

console.log("\n2. 利用contractFactory部署NFT合约")
// 部署合约，填入constructor的参数
const contractNFT = await factoryNFT.deploy("WTF Merkle Tree", "WTF", root)
console.log(`合约地址: ${contractNFT.target}`);
console.log("等待合约部署上链")
await contractNFT.waitForDeployment()
console.log("合约已上链")

console.log("\n3. 调用mint()函数，利用merkle tree验证白名单，给第一个地址铸造NFT")
console.log(`NFT名称: ${await contractNFT.name()}`)
console.log(`NFT代号: ${await contractNFT.symbol()}`)
let tx = await contractNFT.mint(tokens[0], "0", proof)
console.log("铸造中，等待交易上链")
await tx.wait()
console.log(`mint成功，地址${tokens[0]} 的NFT余额: ${await contractNFT.balanceOf(tokens[0])}\n`)
```
在生产环境使用Merkle Tree验证白名单发行NFT主要有以下步骤：
1. 确定白名单列表。
2. 在后端生成白名单列表的Merkle Tree。
3. 部署NFT合约，并将Merkle Tree的root保存在合约中。
4. 用户铸造时，向后端请求地址对应的proof。
5. 用户调用mint()函数进行铸造NFT。

### 2024.10.12
### 数字签名
以太坊使用的数字签名算法叫双椭圆曲线数字签名算法（ECDSA），基于双椭圆曲线“私钥-公钥”对的数字签名算法。它主要起到了三个作用：
1. 身份认证：证明签名方是私钥的持有人。
2. 不可否认：发送方不能否认发送过这个消息。
3. 完整性：消息在传输过程中无法被修改。
### 数字签名合约
```
// 创建消息
const account = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
const tokenId = "0"
// 等效于Solidity中的keccak256(abi.encodePacked(account, tokenId))
const msgHash = ethers.solidityPackedKeccak256(
    ['address', 'uint256'],
    [account, tokenId])
console.log(`msgHash：${msgHash}`)
// msgHash：0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
// 签名
const messageHashBytes = ethers.getBytes(msgHash)
const signature = await wallet.signMessage(messageHashBytes);
console.log(`签名：${signature}`)
// 签名：0x390d704d7ab732ce034203599ee93dd5d3cb0d4d1d7c600ac11726659489773d559b12d220f99f41d17651b0c1c6a669d346a397f8541760d6b32a5725378b241c

// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_GOERLI_URL = 'https://eth-goerli.alchemyapi.io/v2/GlaeWuylnNM3uuOo-SAwJxuwTdqHaY5l';
const provider = new ethers.JsonRpcProvider(ALCHEMY_GOERLI_URL);
// 利用私钥和provider创建wallet对象
const privateKey = '0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b'
const wallet = new ethers.Wallet(privateKey, provider)

// 创建消息
const account = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
const tokenId = "0"
// 等效于Solidity中的keccak256(abi.encodePacked(account, tokenId))
const msgHash = ethers.solidityPackedKeccak256(
    ['address', 'uint256'],
    [account, tokenId])
console.log(`msgHash：${msgHash}`)
// 签名
const messageHashBytes = ethers.getBytes(msgHash)
const signature = await wallet.signMessage(messageHashBytes);
console.log(`签名：${signature}`)

// NFT的人类可读abi
const abiNFT = [
    "constructor(string memory _name, string memory _symbol, address _signer)",
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function mint(address _account, uint256 _tokenId, bytes memory _signature) external",
    "function ownerOf(uint256) view returns (address)",
    "function balanceOf(address) view returns (uint256)",
];
// 合约字节码，在remix中，你可以在两个地方找到Bytecode
// i. 部署面板的Bytecode按钮
// ii. 文件面板artifact文件夹下与合约同名的json文件中
// 里面"object"字段对应的数据就是Bytecode，挺长的，608060起始
// "object": "608060405260646000553480156100...
const bytecodeNFT = contractJson.default.object;
const factoryNFT = new ethers.ContractFactory(abiNFT, bytecodeNFT, wallet);

// 部署合约，填入constructor的参数
const contractNFT = await factoryNFT.deploy("WTF Signature", "WTF", wallet.address)
console.log(`合约地址: ${contractNFT.target}`);
console.log("等待合约部署上链")
await contractNFT.waitForDeployment()
// 也可以用 contractNFT.deployTransaction.wait()
console.log("合约已上链")

console.log(`NFT名称: ${await contractNFT.name()}`)
console.log(`NFT代号: ${await contractNFT.symbol()}`)
let tx = await contractNFT.mint(account, tokenId, signature)
console.log("铸造中，等待交易上链")
await tx.wait()
console.log(`mint成功，地址${account} 的NFT余额: ${await contractNFT.balanceOf(account)}\n`)
```
在生产环境使用数字签名验证白名单发行NFT主要有以下步骤：
1. 确定白名单列表。
2. 在后端维护一个签名钱包，生成每个白名单对应的消息和签名。
3. 部署NFT合约，并将签名钱包的公钥signer保存在合约中。
4. 用户铸造时，向后端请求地址对应的签名。
5. 用户调用mint()函数进行铸造NFT。

### 监听Mempool
### MEV
Maximal Extractable Value，最大可提取价值
在用户的交易被矿工打包进以太坊区块链之前，所有交易会汇集到Mempool（交易内存池）中。矿工也是在这里寻找费用高的交易优先打包，实现利益最大化。通常来说，gas price越高的交易，越容易被打包。

同时，一些MEV机器人也会搜索mempool中有利可图的交易。比如，一笔滑点设置过高的swap交易可能会被三明治攻击：通过调整gas，机器人会在这笔交易之前插一个买单，之后发送一个卖单，等效于把把代币以高价卖给用户（抢跑）。
![image](https://github.com/user-attachments/assets/82553464-aa6c-4f28-a652-7b41f3310e6b)

### 监听Mempool
你可以利用ethers.js的Provider类提供的方法，监听mempool中的pending（未决，待打包）交易：
```
provider.on("pending", listener)
```
```
console.log("\n1. 连接 wss RPC")
// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_MAINNET_WSSURL = 'wss://eth-mainnet.g.alchemy.com/v2/oKmOQKbneVkxgHZfibs-iFhIlIAl6HDN';
const provider = new ethers.WebSocketProvider(ALCHEMY_MAINNET_WSSURL);
function throttle(fn, delay) {
    let timer;
    return function(){
        if(!timer) {
            fn.apply(this, arguments)
            timer = setTimeout(()=>{
                clearTimeout(timer)
                timer = null
            },delay)
        }
    }
}
let i = 0
provider.on("pending", async (txHash) => {
    if (txHash && i < 100) {
        // 打印txHash
        console.log(`[${(new Date).toLocaleTimeString()}] 监听Pending交易 ${i}: ${txHash} \r`);
        i++
        }
});
let j = 0
provider.on("pending", throttle(async (txHash) => {
    if (txHash && j <= 100) {
        // 获取tx详情
        let tx = await provider.getTransaction(txHash);
        console.log(`\n[${(new Date).toLocaleTimeString()}] 监听Pending交易 ${j}: ${txHash} \r`);
        console.log(tx);
        j++
        }
}, 1000));
```

### 未决交易
ethers.js提供了Interface类方便解码交易数据。声明Interface类型和声明abi的方法差不多，例如：
```
const iface = ethers.Interface([
    "function balanceOf(address) public view returns(uint)",
    "function transfer(address, uint) public returns (bool)",
    "function approve(address, uint256) public returns (bool)"
]);
```
#### 解码交易数据
```
// 准备 alchemy API 可以参考https://github.com/AmazingAng/WTF-Solidity/blob/main/Topics/Tools/TOOL04_Alchemy/readme.md 
const ALCHEMY_MAINNET_WSSURL = 'wss://eth-mainnet.g.alchemy.com/v2/oKmOQKbneVkxgHZfibs-iFhIlIAl6HDN';
const provider = new ethers.WebSocketProvider(ALCHEMY_MAINNET_WSSURL);
let network = provider.getNetwork()
network.then(res => console.log(`[${(new Date).toLocaleTimeString()}] 连接到 chain ID ${res.chainId}`));
const iface = new ethers.Interface([
"function transfer(address, uint) public returns (bool)",
])
const selector = iface.getFunction("transfer").selector
console.log(`函数选择器是${selector}`)
// 处理bigInt
function handleBigInt(key, value) {
    if (typeof value === "bigint") {
        return value.toString() + "n"; // or simply return value.toString();
    }
return value;
}

provider.on('pending', async (txHash) => {
if (txHash) {
    const tx = await provider.getTransaction(txHash)
    j++
    if (tx !== null && tx.data.indexOf(selector) !== -1) {
        console.log(`[${(new Date).toLocaleTimeString()}]监听到第${j + 1}个pending交易:${txHash}`)
        console.log(`打印解码交易详情:${JSON.stringify(iface.parseTransaction(tx), handleBigInt, 2)}`)
        console.log(`转账目标地址:${iface.parseTransaction(tx).args[0]}`)
        console.log(`转账金额:${ethers.formatEther(iface.parseTransaction(tx).args[1])}`)
        provider.removeListener('pending', this)
    }
}})
```

### 2024.10.13
### 靓号生成器
```
const wallet = ethers.Wallet.createRandom() // 随机生成钱包，安全
- 开头几位字符匹配，我们用`^`符号，例如`^0x000`就会匹配以`0x000`开头的地址。
- 最后几位字符匹配，我们用`$`符号，例如`000$`就会匹配以`000`结尾的地址。
- 中间几位我们不关心，可以利用`.*`通配符，例如`^0x000.*000$`就会匹配任何以`0x000`开头并以`000`结尾的地址。
const regex = /^0x000.*$/ // 表达式，匹配以0x000开头的地址
isValid = regex.test(wallet.address) // 检验正则表达式

import { ethers } from "ethers";
var wallet // 钱包
const regex = /^0x000.*$/ // 表达式
var isValid = false
while(!isValid){
    wallet = ethers.Wallet.createRandom() // 随机生成钱包，安全
    isValid = regex.test(wallet.address) // 检验正则表达式
}
// 打印靓号地址与私钥
console.log(`靓号地址：${wallet.address}`)
console.log(`靓号私钥：${wallet.privateKey}`)
```

#### 顺序地址生成
```
import { ethers } from "ethers";

var wallet // 钱包
for (let i = 1; i <= 101; i += 1) {
    // 填充3位数字，比如001，002，003，...，999
    const paddedIndex = (i).toString().padStart(3, '0');
    const regex = new RegExp(`^0x${paddedIndex}.*$`);  // 表达式
    var isValid = false
    while(!isValid){
        wallet = ethers.Wallet.createRandom() // 随机生成钱包
        isValid = regex.test(wallet.address) // 检验正则表达式
    }
    // 打印地址与私钥
    console.log(`钱包地址：${wallet.address}`)
    console.log(`钱包私钥：${wallet.privateKey}`)
}

// 生成正则匹配表达式，并返回数组
function CreateRegex(total) {
    const regexList = [];
    for (let index = 0; index < total; index++) {
        // 填充3位数字，比如001，002，003，...，999
        const paddedIndex = (index + 1).toString().padStart(3, '0');
        const regex = new RegExp(`^0x${paddedIndex}.*$`);
        regexList.push(regex);
    }
    return regexList;
}

async function CreateWallet(regexList) {
    let wallet;
    var isValid = false;

    //从21讲的代码扩充
    //https://github.com/WTFAcademy/WTFEthers/blob/main/21_VanityAddress/readme.md
    while (!isValid && regexList.length > 0) {
        wallet = ethers.Wallet.createRandom();
        const index = regexList.findIndex(regex => regex.test(wallet.address));
        // 移除匹配的正则表达式
        if (index !== -1) {
            isValid = true;
            regexList.splice(index, 1);
        }
    }
    const data = `${wallet.address}:${wallet.privateKey}`
    console.log(data);
    return data
}
```
















    
<!-- Content_END -->
