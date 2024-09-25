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


<!-- Content_END -->
