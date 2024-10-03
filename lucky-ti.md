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
2.call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑，不会revert，call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理一下。
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
### 2024.10.03

在外面完成，笔记后续补充
章节23-28












<!-- Content_END -->
