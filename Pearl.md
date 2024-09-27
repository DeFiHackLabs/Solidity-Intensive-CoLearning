---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍 Pearl, female.

2. 你认为你会完成本次残酷学习吗？ Probably
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 

**值類型**
```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
    // 布尔值
    bool public _bool = true;
    // 布尔运算
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等
    // && 和 || 运算符遵循短路规则


    // 整型
    int public _int = -1; // 整数，包括负数
    uint public _uint = 1; // 正整数
    uint256 public _number = 20220330; // 256位正整数
    // 整数运算
    uint256 public _number1 = _number + 1; // +，-，*，/
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小


    // 地址
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address


    // 固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity"; 
    bytes1 public _byte = _byte32[0]; 


    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;
    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }
}
```
**函數**
```Solidity
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
    // view: 看客
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }

    // 返回多个变量
    function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
        return(1, true, [uint256(1),2,5]);
    }
    // 命名式返回，也可以用 return 来返回变量
    function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        _number = 2;
        _bool = false;
        _array = [uint256(3),2,1];
    }

    function read() public pure {
        uint256 _number;
        bool _bool;
        bool _bool2;
        uint256[3] memory _array;

        // 读取所有返回值
        (_number, _bool, _array) = returnNamed();

        // 只读取_bool，而不读取返回的_number和_array
        (, _bool2, ) = returnNamed();
    }
}
```
 
### 2024.09.24

**引用類型(Reference Type)**
 * 数据位置和赋值规则
```Solidity
contract referenceType{
    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        // 参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return(_x);
    }

    uint[] x = [1,2,3]; // 状态变量：数组 x

    function fStorage() public{
        // 声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }
}
```
* 变量的作用域
```Solidity
contract Variables {
    // state variables
    uint public x = 1;
    uint public y;
    string public z;
    function foo() external{
        // 可以在函数里更改状态变量的值
        x = 5;
        y = 2;
        z = "0xAA";
    }

    function bar() external pure returns(uint){
        // local variables
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }

    function global() external view returns(address, uint, bytes memory){
        // global variables
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }

    // 以太单位
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

    // 时间单位
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
}
```

**数组 array**
   * 固定长度数组：在声明时指定数组的长度。用`T[k]`的格式声明，其中T是元素的类型，k是长度
   * 可变长度数组（动态数组）：在声明时不指定数组的长度。用`T[]`的格式声明，其中T是元素的类型
```Solidity
contract arrayType{
    // 固定长度 Array
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;
    // 可变长度 Array
    uint[] array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;
}
```
   * memory修饰的动态数组：可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变
   * 如果创建的是动态数组，你需要一个一个元素的赋值。
```Solidity
contract memoryArray{
    // memory动态数组
    uint[] memory array8 = new uint[](5);
    bytes memory array9 = new bytes(9);
}
```
* 数组成员
   * length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
   * push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
   * push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
   * pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。
**结构体 struct**
* 结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。
```Solidity
contract structType{
   // 结构体
   struct Student{
       uint256 id;
       uint256 score; 
   }

   Student student; // 初始一个student结构体
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
}
```
###  2024.09.25
**映射Mapping**
   * 可以通过键（`Key`）来查询对应的值（`Value`），比如：通过一个人的id来查询他的钱包地址。
   * 声明映射的格式为`mapping(_KeyType => _ValueType)`，其中`_KeyType`和`_ValueType`分别是`Key`和`Value`的变量类型。
   * 映射的规则：
     1. 映射的`_KeyType`只能选择Solidity内置的值类型，比如`uint`，`address`等，不能用自定义的结构体。而`_ValueType`可以使用自定义的类型。
      ```Solidity
      // 我们定义一个结构体 Struct
      struct Student{
          uint256 id;
          uint256 score; 
      }
      mapping(Student => uint) public testVar;
      ```
     2. 映射的存储位置必须是`storage`，因此可以用于合约的状态变量，函数中的`storage`变量和library函数的参数。不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。
     3. 如果映射声明为public，那么Solidity会自动给你创建一个`getter`函数，可以通过`Key`来查询对应的`Value`。
     4. 给映射新增的键值对的语法为`_Var[_Key] = _Value`，其中`_Var`是映射变量名，`_Key`和`_Value`对应新增的键值对。
     ```Solidity
      function writeMap (uint _Key, address _Value) public{
          idToAddress[_Key] = _Value;
      }
      ```
**变量初始值**
* 值类型初始值：
   * boolean: false
   * string: ""
   * int: 0
   * uint: 0
   * enum: 枚举中的第一个元素
   * address: 0x0000000000000000000000000000000000000000 (或 address(0))
   * function
   * internal: 空白函数
   * external: 空白函数
   ```Solidity
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
* 引用类型初始值：
   * 映射mapping: 所有元素都为其默认值的mapping
   * 结构体struct: 所有成员设为其默认值的结构体
   * 数组array
   * 动态数组: []
   * 静态数组（定长）: 所有成员设为其默认值的静态数组
   ```Solidity
   // Reference Types
   uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
   uint[] public _dynamicArray; // `[]`
   mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
   // 所有成员设为其默认值的结构体 0, 0
   struct Student{
       uint256 id;
       uint256 score; 
   }
   Student public student;
   ```
**delete操作符**
   * `delete a`会让变量`a`的值变为初始值。
   ```Solidity
   // delete操作符
   bool public _bool2 = true; 
   function d() external {
       delete _bool2; // delete 会让_bool2变为默认值，false
   }
   ```
**constant和immutable**
   * constant
      * `constant`变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。
      ```Solidity
      // constant变量必须在声明的时候初始化，之后不能改变
      uint256 constant CONSTANT_NUM = 10;
      string constant CONSTANT_STRING = "0xAA";
      bytes constant CONSTANT_BYTES = "WTF";
      address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
      ```
   * immutable
      * `immutable`变量可以在声明时或构造函数中初始化。在`Solidity v8.0.21`以后，不需要显式初始化。反之，则需要显式初始化。
      * 若immutable变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。
      ```Solidity
      // immutable变量可以在constructor里初始化，之后不能改变
      uint256 public immutable IMMUTABLE_NUM = 9999999999;
      address public immutable IMMUTABLE_ADDRESS;
      uint256 public immutable IMMUTABLE_BLOCK;
      uint256 public immutable IMMUTABLE_TEST;
      ```
      * 可以使用全局变量例如`address(this)`，`block.number `或者自定义的函数给`immutable`变量初始化。
      ```Solidity
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
###  2024.09.26
**控制流**
   * `if-else`、`for`、`while`、`do while`、三元运算符
   * 插入排序: `uint`是正整数，取到负值的话，会报underflow错误，要注意。
   ```Solidity
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
**构造函数**
   * `constructor`: 是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，例如初始化合约的owner地址
   ```Solidity
   address owner; // 定义owner变量
   
   // 构造函数
   constructor(address initialOwner) {
       owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
   }
   ```
**修饰器**
   * 修饰器（`modifier`）: 类似于面向对象编程中的装饰器（decorator），声明函数拥有的特性，并减少代码冗余。modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。
   ```Solidity
   // 定义modifier
   modifier onlyOwner {
      require(msg.sender == owner); // 检查调用者是否为owner地址
      _; // 如果是的话，继续运行函数主体；否则报错并revert交易
   }
   function changeOwner(address _newOwner) external onlyOwner{
      owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
   }
   ```
**事件**
   * 事件（`event`）: 是`EVM`上日志的抽象，它具有两个特点：
      1. 响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
      2. 经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。
   * 声明事件: 事件的声明由`event`关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。
   * 释放事件:
   ```Solidity
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
   ```
**EVM日志 `Log`**

   以太坊虚拟机（EVM）用日志`Log`来存储Solidity事件，每条日志记录都包含主题`topics`和数据`data`两部分。
   
**主题 `topics`**
   * 日志的第一部分是主题数组，用于描述事件，长度不能超过4。它的第一个元素是事件的签名（哈希）。
   ```Solidity
   keccak256("Transfer(address,address,uint256)")
   
   //0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
   ```
   * 除了事件哈希，主题还可以包含至多3个`indexed`参数，也就是Transfer事件中的`from`和`to`。
   * `indexed`标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个`indexed`参数的大小为固定的256bits，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

**数据 data**
   * 事件中不带`indexed`的参数会被存储在`data`部分中，可以理解为事件的“值”。
   * `data`部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般`data`部分可以用来存储复杂的数据结构，例如数组和字符串等等。
   * `data`部分的变量在存储上消耗的gas相比于`topics`更少。

###  2024.09.27
**继承**
   * 规则:
      1. `virtual`: 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字。
      2. `override`：子合约重写了父合约中的函数，需要加上`override`关键字。
         * 注意：用`override`修饰`public`变量，会重写与变量同名的`getter`函数
   * 简单继承:
   ```Solidity
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
   ```
   * 多重继承:
      * 规则:
         1. 继承时要按辈分最高到最低的顺序排。
         2. 如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。
         3. 重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如`override(Yeye, Baba)`。
      ```Solidity
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
   * 修饰器的继承:
   ```Solidity
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
   * 也可以利用`override`关键字重写修饰器
   ```Solidity
   modifier exactDividedBy2And3(uint _a) override {
       _;
       require(_a % 2 == 0 && _a % 3 == 0);
   }
   ```
   * 构造函数的继承:
     1. 在继承时声明父构造函数的参数
     2. 在子合约的构造函数中声明构造函数的参数
      ```Solidity
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
   * 调用父合约的函数:
     1. 直接调用：子合约可以直接用`父合约名.函数名()`的方式来调用父合约函数
     ```Solidity
     function callParentSuper() public{
        // 将调用最近的父合约函数，Baba.pop()
        super.pop();
     }
     ```
     2. `super`关键字：子合约可以利用`super.函数名()`来调用最近的父合约函数。
        * Solidity继承关系按声明时从右到左的顺序是：`contract Erzi is Yeye, Baba`，`super.pop()`将调用`Baba.pop()`而不是`Yeye.pop()`
      ```Solidity
      function callParentSuper() public{
          // 将调用最近的父合约函数，Baba.pop()
          super.pop();
      }
      ```
   * 钻石继承: 在面向对象编程中，钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类。
      * 在多重+菱形继承链条上使用`super`关键字时，需要注意的是使用`super`会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。
   ```Solidity
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
<!-- Content_END -->
