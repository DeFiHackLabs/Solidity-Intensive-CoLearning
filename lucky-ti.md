---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加夏令时间 (UTC-8)

timezone: America/Los_Angeles # 太平洋夏令时间 (UTC-7)

timezone: America/Denver # 山地夏令时间 (UTC-6)

timezone: America/Chicago # 中部夏令时间 (UTC-5)

timezone: America/New_York # 东部夏令时间 (UTC-4)

timezone: America/Halifax # 大西洋夏令时间 (UTC-3)

timezone: America/St_Johns # 纽芬兰夏令时间 (UTC-2:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# YourName

1. 自我介绍 【关于我】lucky-ti【坐标】上海【关于⼯作】 运营【本期目标】学习Web3，寻找新机会

2. 你认为你会完成本次残酷学习吗？Y
   
## Notes

<!-- Content_START -->

### 2024.09.23

章节01

笔记：
```
// 许可证申明，不写会报警告
// SPDX-License-Identifier: MIT
// 版本申明，想运行当前版本要>0.8.18且小于0.9。当前remix版本最高0.8.27，默认的是0.8.18，需要注意。
pragma solidity ^0.8.18;
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
```
答案：

PART 01
1. Solidity是什么？编写智能合约的语言
2. Remix是什么？智能合约开发IDE
3. 什么是IDE？集成开发环境(Integrated Development Environment)
4. 带有 pragma solidity ^0.8.4; 的智能合约能否被 solidity 0.8版本编译？不可以
5. Remix没有以下哪个面板？版本
6. Remix的本地测试账户中有多少个ETH？100
7. Solidity中每行代码需要以什么符号结尾？分号;
8. String是什么类型的变量？字符串

### 2024.09.24

章节02——08

笔记：

solidity中变量类型：

值类型(Value Type)：布尔型bool(默认值false,逻辑运算遵循短路规则),整型(uint等效uint256 0——2^256,int等效int256 -2^255——2^255,默认值0),address(20位字节,默认值0地址),定长字节数组（如bytes32，默认空字符串）,枚举值enum(和数组一样，返回时返回uint，从0开始，默认第一个元素)。

引用类型(Reference Type)：数组（array）,结构体（struct）,映射（mapping）(mapping(_KeyType => _ValueType)) 
映射的_KeyType只能选择Solidity内置的值类型,_ValueType可以使用自定义的类型。映射的存储位置必须是storage，不能用于public函数的参数或返回结果中。给映射新增的键值对的语法为：_Var[_Key] = _Value。

函数类型(Function Type):function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
public全可访问,external合约外访问(内部可用this.函数名()访问,但是这样gas消耗会很高,一般不推荐),internal和private都是内部访问,但internal可用于继承函数。
pure和view的区别：view比pure能多访问状态变量,消耗gas更多，需要修改状态变量可不添加这俩。 用于转账时必须包含payable。注意函数名后用returns，内部主体返回时用return
public|private|internal 可用于修饰状态变量,未标明可见范围的，默认internal。

数据位置：gas消耗：storage > memory(一般返回类型为变长数组用memory,因为calldata在函数返回结束后无法访问) > calldata(calldata变量不能修改（immutable）)
同位置变量赋值会创建引用，修改新变量会修改原变量。（如合约状态变量赋值给函数内状态变量）不同位置的会创建副本。
1 ether = 1e9 gwei = 1e18 wei
bytes比较特殊，是数组，但是不用加[]。声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度。如：uint[] memory _array = new uint[](5);
如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type。
push():数组最后添加一个元素,pop():数组最后添加一个元素。
delete a会让变量a的值变为初始值。

```
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}
Student student; // 初始一个student结构体
```
答案：

PART 02
1.	以下属于solidity变量类型的是？数值类型（Value Type)、引用类型(Reference Type)、映射类型(Mapping Type)、函数类型(Function Type)
2.	solidity中数值类型(Value Type)不包括：float
3.	请解释下面这段代码的意思：合约向addr转账1wei
4.	bytes4类型具有几个16进制位？8
5.	以下运算能使a返回true的是？bool a=1-1==0&&1%2==1

PART 03
1.	下面哪一项不是 Solidity 中的函数可见性说明符？protected
2.	下面关于view关键字的描述，哪一项是准确的？包含view关键字的函数，可以读取但不能写入存储在链上的状态变量
3.	下面关于pure和view两个关键字的描述，哪一项是错误的？每个函数在声明时必须包含这两个关键字中的一个
4.	以下代码截取自 SafeMath Library，其定义了一个函数以替代“加法”，如果加法的结果溢出则会返回异常：pure
5.	以下代码截取自 USDT 的 Token 合约，其声明了一个函数，任何用户都可以调用这个函数以查询某个地址的 USDT 余额：public

PART 04
1.	returns关键字的作用：加在函数名后面，用于声明返回的变量类型及变量名
2.	return关键字的作用：用于函数主体中，返回指定的变量
3.	采用命名式返回的函数主体中能否使用return？能
4.	解构式赋值能否只读取函数部分返回值？能
5.	假设存在如下函数：return (64,true,"abcd",[1,2,3])
6.	下列属于命名式返回的是：function returnNamed() public pure returns(uint256 _number,bool _bool,uint256[3] memory _array)
7.	假设存在如下函数：0:uint256: _number 2
8.	假设存在如下函数：bool _bool;  (, _bool, ) = returnMultiple()

PART 05
1.	引用类型(Reference Type)包含以下：数组(array)、结构体(struct)、映射(mapping)
2.	Solidity数据存储位置的类型不包含以下：stack
3.	合约中状态变量默认的存储位置类型为以下的：storage
4.	不同类型的引用变量相互赋值时，修改其中一个的值，不会导致另一个的值随之改变的是以下哪种情况：合约中的storage赋值给本地的memory
5.	Solidity中变量按作用域划分，可分为：状态变量(state variable)、局部变量(local variable)、全局变量(global variable)
6.	消耗gas最多的变量类型为：状态变量
7.	下列表示“请求发起地址”的为：msg.sender
8.	下列表示“当前区块的矿工地址”的为：block.coinbase

PART 06
1.	以下选项中不属于固定长度数组的是：address[] array1;
2.	以下选项中不属于可变长度数组的是：address[6] array2;
3.	以下关于数组的说法中，正确的是：内存数组的长度在创建后是固定的
4.	数组和结构体分别属于什么类型：引用类型和引用类型
5.	以下关于结构体的说法中，错误的是：结构体内可以包含其本身
6.	有如下一段合约代码，执行initStudent方法后，student.id和student.score的值分别为：300 400

PART 07
1.	如果我们要声明一个mapping变量，记录不同地址的持仓数量，应该怎么做？mapping(address => uint) public balanceof
2.	不可以作为mapping中键（key）的变量类型的是：struct
3.	可以作为mapping中值（value）的变量类型是：struct、string、address
4.	Mapping的存储位置可以是：storage
5.	给映射变量map新增键值对的方法：map[_Key] = _Value;
6.	mapping变量是否存长度信息？否

PART 08
1.	address类型的初始值是：0x0000000000000000000000000000000000000000
2.	bool类型的初始值是：false
3.	bytes1的初始值是：0x00
4.	调用函数d，将返回：""
5.	下面是ERC20合约中的一行代码，其中未记录的用户的_balances值是：0

### 2024.09.25

章节09——12

笔记：

只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。
constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过（TypeError: Cannot assign to a constant variable）。
immutable变量可以在声明时或构造函数中初始化,在Solidity v8.0.21以后，immutable变量不需要显式初始化。如果既在声明时初始化，又在constructor中初始化，会返回constructor初始化的值。尝试修改初始化的值，会编译不通过（TypeError: Immutable state variable already）。
```
// 插入排序 正确版
//这里和python代码的区别，是由于solidity最常用的变量类型是uint，无法取到-1。当一组循环中如果要变动第一位也就是a[0]时，可能会使变量取到-1值，solidity中需要避免这种情况。不然遇到这种情况会报错underflow。
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
```
// 构造函数代码示例：
address owner; // 定义owner变量
// 构造函数
constructor(address initialOwner) {
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}
```
```
// 修饰器代码示例：
// 定义modifier
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是否为owner地址
   _; // 如果是的话，继续运行函数主体；否则报错并revert交易
}
// 使用修饰器，在函数位置之后加上修饰器名称。使用修饰器的目的，是为了减少代码重复，降低gas。一般多用于要多次使用的用户检测或者错误检测中。
function changeOwner(address _newOwner) external onlyOwner{
   owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
}
```
应用程序（ethers.js）可以通过RPC接口订阅和监听事件，并在前端做响应。使用事件比存储链上花费更少的gas。
事件的声明由event关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。通过emit来释放事件。
以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics（长度不超过4，0标记事件hash，后续标记分别记录index参数标记的返回，至多3个；每个index参数固定256比特，当超过长度时，也会计算成hash存储起来，确保长度大小）和数据data（不含index的部分，这部分消耗的gas比index部分少）两部分。
indexed关键字不能修饰string类型,因为string类型的不能呗索引。

答案：

PART 09
1.	下面定义变量的语句中，会报错的一项是：uint256 public constant x1;
2.	下面定义变量的语句中，会报错的一项是：string immutable x7 = "hello world";
3.	下面哪一项不符合对 constant 和 immutable 的描述？constant和immutable的使用并不会节省gas
4.	在如下的合约中，我们定义了四个 immutable 的变量 y1, y2, y3, y4。其中，确实有必要在构造函数 constructor 中才赋值的一项是：y4
5.	下列哪一个变量不适合用 constant 或 immutable 来修饰？合约中的ETH数量

PART 10
1.	下面哪个选项是if-else语句？if(a > b){return(a);}else{return(b);}
2.	下面哪个选项是for循环语句？for(uint i = 5;i > 0;i--){x=2**i;}
3.	下面哪个选项是while循环语句？uint256 i = 5; while(i >= 0){x=2**i;i--;}
4.	下面哪个选项是do-while循环语句？uint256 i = 5; do{x = 2**1;i--;}while(i >= 0);
5.	下面哪个选项出现了 三元运算符 ？return x > y ? (x > Z ? x : z):(y > z ? y : z);
6.	使用哪个关键字可以直接跳到下一个循环？continue
7.	使用哪个关键字可以跳出当前循环？break
8.	下面四张图中哪个是正确的插入排序代码？(图在下方）
```
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

PART 11
1.	一个合约可以定义多个构造函数（constructor）：错误
2.	构造函数的运行，只能通过手动调用：错误
3.	构造函数是否可以用来初始化合约参数？是
4.	关于solidity中的修饰器（modifier），以下描述中正确的个数为：4
5.	阅读图中代码，非owner地址是否可以调用函数F？否

PART 12
1.	下列关于事件的说法中，错误的是：链上存储数据比存储事件的成本低。
2.	可以使用emit关键字来释放一个事件：正确
3.	每个事件可以有无限个带indexed的变量：错误
4.	indexed关键字可以修饰任意类型的变量：错误
5.	下列可以查询事件的是：Etherscan

### 2024.09.26

章节13——15

笔记：

继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承。继承用is来表示，如：contract B is A。
virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
override：子合约重写了父合约中的函数，需要加上override关键字。
多重继承中，is后接的顺序按最原始父辈的开始扩展，如：contract erzi is yeye,baba。如果某一个函数在多个继承的合约里都存在，在子合约里必须重写，否则会报错。重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，但不强制要求顺序。
```
// 多重继承中，is后接的顺序按最原始父辈的开始扩展
contract Erzi is Yeye, Baba{
    // 继承两个function: hip()和pop()，输出值为Erzi。
    // 重写了在Yeye,Baba的两个函数，override后标注出来，但不做顺序要求
    function hip() public virtual override(Yeye, Baba){
        emit Log("Erzi");
    }

    function pop() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }
}
```
```
// 修饰器的继承
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
```
```
// 构造函数的继承
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
// 在继承时声明父构造函数的参数
contract B is A(1)
// 在子合约的构造函数中声明构造函数的参数
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}
```
子合约调用父合约函数：直接调用和利用super关键字调用（super只会调用最近的父辈合约，在钻石继承（也就是菱形结构的继承中，super会调用继承链条上的每一个合约的相关函数,并且按照最近的父辈到最原始的父辈的顺序））。
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
如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为abstract，不然编译会报错；另外，未实现的函数需要加virtual，以便子合约重写。

接口类似于抽象合约，但它不实现任何功能。接口的规则：

1.不能包含状态变量
2.不能包含构造函数
3.不能继承除接口外的其他合约
4.所有函数都必须是external且不能有函数体
5.继承接口的非抽象合约必须实现接口定义的所有功能

接口提供了两个重要的信息：合约里每个函数的bytes4选择器，以及函数签名函数名(每个参数类型);接口id。
接口与合约ABI（Application Binary Interface）等价，可以相互转换。

error是solidity 0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，且可以在constract之外定义。在执行当中，error必须搭配revert（回退）命令使用。
require命令是solidity 0.8版本之前抛出异常的常用方法，gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述")。
assert使用方法：assert(检查条件）。

gas消耗；require > error（带参数）> assert > error(不带参数)。
```
error TransferNotOwner(address sender); // 自定义的带参数的error
function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
        // revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```
答案：

PART 13
1.	对virtual关键字描述正确的是：父合约中的函数，如果希望子合约重写，需要加上该关键字。
2.	对override关键字描述正确的是：子合约中重写了父合约中的函数，需要加上该关键字。
3.	下面哪个选项表示A合约继承了B合约：contract A is B
4.	function a() public override{} 意思是：函数a0重写了父合约中的同名函数
5.	如果合约B继承了合约A，合约C要继承A和B，要怎么写？contract C is A,B
6.	合约B继承了合约A，下面选项中，正确调用父合约构造函数的是：constructor(uint _num) A (_num){}
7.	合约B继承了合约A，两个合约都有pop()函数，下面选项中，正确调用父合约函数的是：都正确

PART 14
1.	已知foo是一个未实现的函数，那么下面代码中书写正确的是？
abstract contract A{function foo(uint a)internal pure virtual returns(uint);}
2.	被标记为abstract的合约能否被部署？不能
3.	下列关于接口的规则中，错误的是：继承接口的合约可以不实现接口定义的全部功能
4.	下列关于接口的描述，错误的是：如果已知一个合约实现了ERC20接口，那么还需要知道它具体代码实现，才可以与之交互
5.	已经知Azuki的合约地址为0xED5AF388653567Af2F388E6224dC7C4b3241C544，那么利用该地址创建接口合约变量的语句是：
IERC721 Azuki = IERC721(0xED5AF388653567Af2F388E6224dC7C4b3241C544)
6.	已知Azuki合约中存在ownerOf(uint256 tokenId)函数可用来查询某一NFT的拥有者，现在vitalik想利用上文中创建的接口合约变量调用这一函数，并写出了如下代码：return Azuki.ownerof(id);
7.	已知Azuki合约中存在approve(address to, uint256 tokenId)函数可以让NFT的拥有者将自己某一NFT的许可权授予另一地址，且该函数没有返回值，现在某个Azuki拥有者想利用上文中创建的接口合约变量调用这一函数 ，那么他写出的代码可能是？
function approveAzuki(address to,uint256 id) external{Azuki.approve(to,id);}

PART 15
1.	Solidity抛出异常的方法有：error、require、assert
2.	判断：对于error, 在合约执行过程中，可以搭配revert，也可以单独使用。错误
3.	判断：error可以带有参数。正确
4.	require的使用方法为：require(检查条件，"异常的描述")判断：require消耗gas的数量会随着检查条件的增多以及"异常的描述"变长而增加。正确
5.	判断：assert和require一样，可以解释抛出异常的原因。错误
6.	error，require和assert三种方法的gas消耗，从大到小依次为：
require > assert > error
7.	在有以下定义的前提下，以下实现中能够正确抛出异常的写法为：require方法

### 2024.09.27

章节16——18

笔记：

Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。
```
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}
function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
// 调用f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。
```
库合约和普通合约主要有以下几点不同：

1.不能存在状态变量
2.不能够继承或被继承
3.不能接收以太币
4.不可以被销毁

库合约可见性被设置为public或者external,在调用函数时会触发一次delegatecall。设置为internal，则不会引起。

使用库合约的方法：

1.利用using for指令：指令using A for B;可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数：
```
// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```
2.通过库合约名称调用函数:
```
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```
常用的有：

1.Strings：将uint256转换为String
2.Address：判断某个地址是否为合约地址
3.Create2：更安全的使用Create2 EVM opcode
4.Arrays：跟数组相关的库合约

import用法:
```
// 通过源文件相对位置导入
import './Yeye.sol';
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 通过npm的目录导入
import '@openzeppelin/contracts/access/Ownable.sol';
// 通过指定全局符号导入合约特定的全局符号
import {Yeye} from './Yeye.sol';
```
引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前。

答案：

PART 16
1.	什么是函数重载（Overloading）? 名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。
2.	Solidity中是否允许修饰器（modifier）重载？不允许
3.	下面两个函数的函数选择器是否相同？不相同
4.	使用上一题代码，如果我们调用 saySomething("WTF")，返回值为：”WTF”
5.	下面两个函数的函数选择器是否相同？不相同

PART 17
1.	以下，通过库合约名称调用toHexString()，返回值return出正确的写法为：
Strings.toHexString(_number);
2.	关于库函数的描述，下列描述错误的是：库函数一般需要你自己实现
3.	库合约和普通合约的区别，下列描述错误的是：库合约可以被继承
4.	以下属于常用库函数的有：String、Address、Create2、Arrays
5.	String库合约是将uint256类型转换为相应的string类型的代码库，toHexString()为其中将uint256转换为16进制，再转换为string。
_number.toHexString();

PART 18
1.	Solidity中import的作用是：导入其他合约中的全局符号
2.	import导入文件的来源可以是：源文件网址、npm的目录、本地文件
3.	以下import写法错误的是：import from "./Yeye.sol";
4.	import导入文件中的全局符号可以单独指定其中的：合约、函数、结构体类型
5.	被导入文件中的全局符号想要被其他合约单独导入，应该怎么编写？与合约并列在文件结构中

### 2024.09.29

章节19——20

笔记：

receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。
当合约接收ETH的时候，receive()会被触发。receive()最好不要执行太多的逻辑因为如果别人用send和transfer方法发送ETH的话，gas会限制在2300，receive()太复杂可能会触发Out of Gas报错；如果用call就可以自定义gas执行更复杂的逻辑。
警惕恶意合约，会在receive() 函数（老版本0.6.x的话，就是 fallback() 函数）嵌入恶意消耗gas的内容或者使得执行故意失败的代码。
```
// 定义事件
event Received(address Sender, uint Value);
// 接收ETH时释放Received事件
receive() external payable {
    emit Received(msg.sender, msg.value);
}
```
fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。

receive和fallback的区别：
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
// 合约接收ETH时，msg.data为空且存在receive()时，会触发receive()
```
transfer（接收方地址.transfer(发送ETH数额)）、send（接收方地址.send(发送ETH数额)）、call（接收方地址.call{value: 发送ETH数额}("")）都可用于发送ETH，三者的区别：

1.transfer、send的gas限制都在2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。区别在于，交易失败transfer会自动revert，send不会（send只会返回成功与否的bool值，需要额外代码处理一下）。
2.call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑，不会revert，call()的返回值是(bool, bytes memory)，其中bool代表着转账成功或失败，需要额外代码处理一下。
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

答案：

PART 19
1.	下面哪个选项语法是正确的？receive() external payable {}
2.	fallback(or receive)函数能否在合约内部调用？不能
3.	vitalik想部署一个能接收ETH和msg.data的合约，那么他部署的合约中：
必须含有fallback函数
4.	假设存在如下合约，现在vitalik向该合约发起一笔低级交互，value=100Wei，msg.data=0xaa，那么会发生下面选项中的哪种情况？
error:Fallback function is not defined,value和msg.data均发送失败
5.	假设存在如下合约，现在vitalik想调用该合约中不存在的函数，他在calldata中输入函数选择器，并将value设置为1ETH，那么会发生下面选项中的哪种情况？
error:'Fallback'function is not defined,value和msg.data均发送失败

PART 20
1.	下面三种发送ETH的方法中，哪一种没有gas限制？call
2.	下面三种发送ETH的方法中，哪一种发送失败会自动revert交易?transfer
3.	transfer的gas限制为？2300
4.	vitalik写了一个合约，并且该合约在被部署时可以转ETH进去，那么该合约的构造函数可能为？constructor() payable {}
5.	vitalik写了一个用send()发送ETH的函数：
bool success =_to.send(amount); if(!success) { revert SendFailed(); }
6.	vitalik又写了一个用call()发送ETH的函数：
(bool success,) =_to.call {value:amount} (""); if(!success) {revert CallFailed();}
7.	假设存在如下两个合约(sendETH和ReceiveETH)，两个合约目前ETH余额皆为0，现在vitalik想通过SendETH合约的callETH函数往ReceiveETH合约转入1ETH，他将交易的value设置为2ETH，同时交易成功执行，那么此时sendETH合约和ReceiveETH的ETH余额分别为？1ETH;1ETH

### 2024.09.30

章节21-22

笔记：
```
contract CallContract{
   // 合约名（地址）.函数名（）的方式调用其他合约函数
    function callSetX(address _Address, uint256 x) external{
        OtherContract(_Address).setX(x);
    }
   // 相当于参数已经提前指定合约地址引用，直接调用
    function callGetX(OtherContract _Address) external view returns(uint x){
        x = _Address.getX();
    }
   // 将指定好的赋值给一个变量，通过变量来调用具体函数
    function callGetX2(address _Address) external view returns(uint x){
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }
   // 这边对比第一条callSetX实际多了个转账
    function setXTransferETH(address otherContract, uint256 x) payable external{
        OtherContract(otherContract).setX{value: msg.value}(x);
    }
}
```
call 是address类型的低级成员函数。
call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。
不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数。
当不知道对方合约的源代码或ABI，就没法生成合约变量；这时，我们仍可以通过call调用对方合约的函数。

call的使用规则如下：
```
目标合约地址.call(字节码);
```
其中字节码利用结构化编码函数abi.encodeWithSignature获得：
```
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
```
(函数签名为"函数名（逗号分隔的参数类型）",如：abi.encodeWithSignature("f(uint256,address)", _x, _addr))
在调用合约时可以指定交易发送的ETH数额和gas数额：
```
目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
```
输出call来完成sucesscall的具体的完成情况。
call不存在的函数。call仍能执行成功，并返回success，但其实调用的目标合约fallback函数。

答案：

PART 21
1.	下列关于智能合约调用其他智能合约的说法，正确的一项是：智能合约调用其他智能合约这一功能，主要起到了方便代码复用的作用
2.	假设我们部署了合约 OtherContract （合约内容见下）下列说法正确的是：
(1)(2)均是调用其他合约的正确写法
3.	假设我们新写了一个合约。下列说法正确的是：MyContract的函数call_setx可以实现，这意味着OtherContract中setX的权限没有门槛，存在安全隐患
4.	在第2题的合约中，我们尝试依次进行如下操作：(2)(4)的返回结果分别是10,20
5.	在第2题的合约中，OtherContract 中 setX 函数是 payable 的。如果我们想在已部署的合约 0xd9145CCE52D386f254917e481eB44e9943F39138 中调用 setX 的时候向合约转账 50 wei，那么正确的写法是：
OtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138).setX{value:50}(x)

PART 22
1.	call是什么类型的成员函数？address
2.	call被推荐用来干什么？发送ETH
3.	call的返回类型为:bool和bytes memory
4.	下面哪种使用方式不正确? address.call{gas:1000000,value:1 ether}
5.	如果我们给call输入的函数不存在于目标合约，那么目标合约的什么函数会被触发？fallback
6.	call在什么情况下会调用失败？当调用不存在的函数时，被调用合约没有实现fallback

### 2024.10.03

章节23-28

笔记：

delegatecall与call类似，是Solidity中地址类型的低级成员函数。delegate中是委托/代表的意思。
当用户A通过合约B来call合约C的时候，执行的是合约C的函数，上下文(Context，可以理解为包含变量和状态的环境)也是合约C的：msg.sender是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上。
而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
```
总结：二级用call还是用delegatecall主要的区别：call的msg.sender是中间者，且改变状态变量会作用到二级的合约的变量上。delegatecal的msg.sender会指向本合约，并且改变状态变量会作用的中间者上。
```
delegatecall语法和call类似：
```
目标合约地址.delegatecall(二进制编码);
```
其中二进制编码利用结构化编码函数abi.encodeWithSignature获得：
```
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
```
和call不一样，delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额。delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。

目前delegatecall主要有两个应用场景：

1.代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开：代理合约（Proxy Contract）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（Logic Contract）里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。

2.EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。 更多信息请查看：钻石标准简介（https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard）。

有两种方法可以在合约中创建新合约，create和create2。

create的用法：
```
Contract x = new Contract{value: _value}(params)
```

其中Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数。
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
智能合约可以由其他合约和普通账户利用CREATE操作码创建。 在这两种情况下，新合约的地址都以相同的方式计算：创建者的地址(通常为部署的钱包地址或者合约地址)和nonce(该地址发送交易的总数,对于合约账户是创建的合约总数,每创建一个合约nonce+1)的哈希。创建者地址不会变，但nonce可能会随时间而改变，因此用CREATE创建的合约地址不好预测。
```
新地址 = hash(创建者地址, nonce)
```
CREATE2的目的是为了让合约地址独立于未来的事件。
用CREATE2创建的合约地址由4个部分决定：

0xFF：一个常数，避免和CREATE冲突
CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
```
新地址 = hash("0xFF",创建者地址, salt, initcode)
```

create2的用法：
```
Contract x = new Contract{salt: _salt, value: _value}(params)
```

```
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

事先预测create2地址：
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

如果部署合约构造函数中存在参数
例如当create2合约时：

Pair pair = new Pair{salt: salt}(address(this));

计算时，需要将参数和initcode一起进行打包：

keccak256(type(Pair).creationCode) => keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))

```
predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
            )))));
```

`selfdestruct`命令可以用来删除智能合约，并将该合约剩余`ETH`转到指定地址。在 [v0.8.18](https://blog.soliditylang.org/2023/02/01/solidity-0.8.18-release-announcement/) 版本中，`selfdestruct` 关键字被标记为「不再建议使用」，在一些情况下它会导致预期之外的合约语义，但由于目前还没有代替方案，目前只是对开发者做了编译阶段的警告，相关内容可以查看 [EIP-6049](https://eips.ethereum.org/EIPS/eip-6049)。

然而，在以太坊坎昆（Cancun）升级中，[EIP-6780](https://eips.ethereum.org/EIPS/eip-6780)被纳入升级以实现对`Verkle Tree`更好的支持。EIP-6780减少了`SELFDESTRUCT`操作码的功能。根据提案描述，当前`SELFDESTRUCT`仅会被用来将合约中的ETH转移到指定地址，而原先的删除功能只有在`合约创建-自毁`这两个操作处在同一笔交易时才能生效。所以目前来说：

1. 已经部署的合约无法被`SELFDESTRUCT`了。
2. 如果要使用原先的`SELFDESTRUCT`功能，必须在同一笔交易中创建并`SELFDESTRUCT`。

`selfdestruct`使用起来非常简单：
```
selfdestruct(_addr)；
```
其中_addr是接收合约中剩余ETH的地址。_addr 地址不需要有receive()或fallback()也能接收ETH

以下合约在坎昆升级前可以完成合约的自毁，在坎昆升级后仅能实现内部ETH余额的转移。

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
#### 注意事项

1. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符`onlyOwner`进行函数声明。
2. 当合约中有`selfdestruct`功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用`selfdestruct`向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

Solidity中，ABI编码有4个函数：abi.encode, abi.encodePacked, abi.encodeWithSignature, abi.encodeWithSelector。而ABI解码有1个函数：abi.decode，用于解码abi.encode的数据。

ABI解码四者对比：

abi.encode:被设计用于与智能合约交互，他每个参数填充为32字节的数据，并拼接在一起，用0补足。
```
function encode() public view returns(bytes memory result) {
    result = abi.encode(x, addr, name, array);
}
```

abi.encodePacked:不与合约交互，可相对abi.encode省略填充的0来节省空间。
```
function encodePacked() public view returns(bytes memory result) {
    result = abi.encodePacked(x, addr, name, array);
}
```

abi.encodeWithSignature:第一个参数为函数签名，比如"foo(uint256,address,string,uint256[2])"。当调用其他合约的时候可以使用。等同于在`abi.encode`编码结果前加上了4字节的`函数选择器`[^说明]。
[^说明]: 函数选择器就是通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用。
```
function encodeWithSignature() public view returns(bytes memory result) {
    result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
}
```

abi.encodeWithSelector:与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。[区别]:abi.encodeWithSelector需要自行计算函数选择器，而abi.encodeWithSignature可以直接通过函数签名获取。当已知函数hash,用abi.encodeWithSelector比较省gas。
```
function encodeWithSelector() public view returns(bytes memory result) {
    result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
}
```

一个好的哈希函数应该具有以下几个特性：

- 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
- 灵敏性：输入的消息改变一点对它的哈希改变很大。
- 高效性：从输入的消息到哈希的运算高效。
- 均一性：每个哈希值被取到的概率应该基本相等。
- 抗碰撞性：
  - 弱抗碰撞性：给定一个消息`x`，找到另一个消息`x'`，使得`hash(x) = hash(x')`是困难的。
  - 强抗碰撞性：找到任意`x`和`x'`，使得`hash(x) = hash(x')`是困难的。
 
1. sha3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。**所以SHA3就和keccak计算的结果不一样**，这点在实际开发中要注意。
2. 以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。

答案：

PART 23
1.	delegatecall是哪个类型的成员函数？address
2.	当用户A通过合约B来delegatecall合约C时，执行了__的函数，语境是__，msg.sender和msg.value来自__， 并且如果函数改变一些状态变量，产生的效果会作用于__的变量上。C;B;A;B
3.	delegatecall在调用合约时: 可以指定交易发送的gās,但不可以指定发送的ETH数额
4.	使用delegatecall对当前合约和目标合约的状态变量有什么要求？变量名可以不同，变量类型、声明顺序必须相同 
5.	假设存在如下函数，那么下面选项中可以填在横线上的是？
(bool success,bytes memory data) = _addr.delegatecall(abi.encodeWithSignature("mint(uint256)",_num));
6.	在代理合约中，存储所有相关的变量的是___，存储所有函数的是___，同时____________
代理合约；逻辑合约；代理合约delegatecalli逻辑合约

PART 24
1.	Solidity中创建新合约的关键字是：new
2.	Contract x = new Contract{value: _value}(params)，表达式中value代表什么？当前合约发送给新创建合约的ETH
3.	Contract x = new Contract{value: _value}(params)，表达式中params代表什么？
新合约的构造函数的参数
4.	1个工厂合约PairFactory创建Pair合约的最大数量一般由什么决定？PairFactoryi合约逻辑
5.	示例中Pair合约创建时的msg.sender是？工厂合约PairFactory

PART 25
1.	判断：Create2与Create的不同之处在于，Create2可以让合约地址独立于未来的事件。正确
2.	Create2创建的合约地址不取决于：nonce
3.	Create2的用法相比于Create，在new一个合约并传入构造函数所需参数时，需要多传入的为：一个创建者给定的数值：salt
4.	下面利用Create2创建合约的代码中，参数salt等于：一对代币地址的哈希

PART 26
1.	关于删除合约的命令，现在常选用：selfdestruct
2.	判断：所有合约创建时都必须包含“selfdestruct”的命令，否则会报错：错误
3.	在以太坊坎昆（Cancun）升级后，在调用 deleteContract 删除合约后，读取value的结果为：10
4.	判断：删除合约时，可以将合约中剩余的ETH发送出去：正确
5.	判断：删除合约时，只可以将合约中的ETH发送到合约创建者的地址：错误

PART 27
1.	当我们调用智能合约时，传递给合约的数据的前若干个字节被称为“函数选择器 (Selector)”，它告诉合约我们想要调用哪个函数。假设我们想要调用的函数在智能合约中定义声明如下：
bytes4(keccak256("foo(uint256,address,string)"))
2.	下列有关ABI编码的函数中，返回值不可能当作调用智能合约的数据的一项是：abi.encodePacked
3.	函数abi.decode用于将二进制编码解码，它对应的逆向操作函数（反函数）是：abi.encode
4.	已知函数foo在智能合约中定义声明如下：那么，当我们希望调用函数foo()时，以下生成调用数据的写法中，正确且最节省gas的一项是：
abi.encodewithSelector(bytes4(0x2fbebd38),a)

PART 28
1.	哈希函数（hash function）是一个密码学概念，它可以将任意长度的消息转换为一个固定长度的值，这个值也称作哈希（hash）。在Solidity语言中，最常用的哈希函数为____，它也是函数选择器所应用的函数。Keccak-256
2.	一个好的哈希函数应当包含以下几种特性：单向性、灵敏性、高效性、均一性、抗碰撞性。下列关于这些特性中，描述不正确的一项是：强抗碰撞性意味着哈希函数的任意两个输入对应的输出都不同
3.	如果对于某个哈希函数，我们统计大量不同字符串对应的哈希值（二进制串），发现其前 n 位全部为 0 的频率恰好约为 1/2^n，则我们认为该哈希函数具有良好的：均一性
4.	我们对两个非常相近的字符串 "Hello world!" 和 "Hello world." 求取 sha3-256 哈希值，其结果如下：灵敏性
5.	当我们下载大型文件时，有时候下载源会提供大型文件的哈希值；我们下载完成后，将本地下载好的大文件也计算其哈希值，并将两个哈希值对比。以下说法不准确的是： 如果哈希值相同，说明文件的内容一定完全相同，下载过程没有出现问题

### 2024.10.04

完成章节29-32

笔记：

msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）。

method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数。注意，在函数签名中，uint和int要写为uint256和int256。

在Solidity中，try-catch只能被用于external函数或创建合约时constructor（被视为external函数）的调用。基本语法如下：
```
try externalContract.f() {
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```
可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。

`ERC20`是以太坊上的代币标准，来自2015年11月V神参与的[`EIP20`](https://eips.ethereum.org/EIPS/eip-20)。它实现了代币转账的基本逻辑：

- 账户余额(balanceOf())
- 转账(transfer())
- 授权转账(transferFrom())
- 授权(approve())
- 代币总供给(totalSupply())
- 授权转账额度(allowance())
- 代币信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())

```
interface IERC20 {
    /**
     * @dev 释放条件：当 `value` 单位的货币从账户 (`from`) 转账到另一账户 (`to`)时.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev 释放条件：当 `value` 单位的货币从账户 (`owner`) 授权给另一账户 (`spender`)时.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

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
}
```

答案：

PART 29
1.	函数选择器有几个字节？4
2.	如果一笔调用智能合约的交易的calldata如下，被调用函数的选择器是？0x6a627842
3.	transfer函数的函数签名是？"transfer(address,uint256)"
4.	上一题中transfer函数的选择器为？0xa9059cbb
5.	.我想调用transfer函数将合约中的100枚 $PEOPLE 代币转给 0 地址，下面哪一个选项可以做到这一点。
pp.call(abi.encodewithSelector(0xa9059cbb,address(0),uint256(100)));

PART 30
1.	try-catch可以捕获什么异常？revert()、require()、assert()
2.	以下异常返回值类型为bytes的是：assert()
3.	try-catch捕获到异常后是否会使try-catch所在的方法调用失败？不会
4.	try代码块内的revert是否会被catch本身捕获？不会

### 2024.10.05

完成章节32-35

### 2024.10.06

完成章节35-37

### 2024.10.07

完成章节37-38

### 2024.10.08

完成章节39-40

### 2024.10.09

完成章节41-42

### 2024.10.10

完成章节43-44

### 2024.10.11

完成章节45-46

### 2024.10.12

完成章节47-48

### 2024.10.15

完成章节49-50









<!-- Content_END -->
