～～---
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

###  2024.09.29
09.28內容不見了，重打一遍。

**抽象合约**
   * 如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容，则必须将该合约标为`abstract`。
   * 未实现的函数需要加`virtual`，以便子合约重写。
   ```Solidity
   abstract contract InsertionSort{
       function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
   }
   ```

**接口**
   * 类似于抽象合约，但它不实现任何功能。
   * 接口的规则：
     1. 不能包含状态变量。
     2. 不能包含构造函数。
     3. 不能继承除接口外的其他合约。
     4. 所有函数都必须是external且不能有函数体。
     5. 继承接口的非抽象合约必须实现接口定义的所有功能。
   * 接口是智能合约的骨架，定义了合约的功能以及如何触发它们。
   * 如果智能合约实现了某种接口（比如`ERC20`或`ERC721`），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：
     1. 合约里每个函数的`bytes4`选择器，以及函数签名`函数名(每个参数类型）`。
     2. 接口id。
   * 接口与合约`ABI`（Application Binary Interface）等价，可以相互转换。
   * 编译接口可以得到合约的`ABI`，利用abi-to-sol工具，也可以将`ABI json`文件转换为接口`sol`文件。
   ```Solidity
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
   * 我们可以看到，接口和常规合约的区别在于每个函数都以`;`代替函数体`{ }`结尾。
   
**IERC721事件**
   
   `IERC721`包含3个事件，其中`Transfer`和`Approval`事件在`ERC20`中也有。
   1. `Transfer`事件：在转账时被释放，记录代币的发出地址`from`，接收地址`to`和`tokenId`。
   2. `Approval`事件：在授权时被释放，记录授权地址`owner`，被授权地址`approved`和`tokenId`。
   3. `ApprovalForAll`事件：在批量授权时被释放，记录批量授权的发出地址`owner`，被授权地址`operator`和授权与否的`approved`。
        
**IERC721函数**
   1. `balanceOf`：返回某地址的NFT持有量`balance`。
   2. `ownerOf`：返回某`tokenId`的主人`owner`。
   3. `transferFrom`：普通转账，参数为转出地址`from`，接收地址`to`和`tokenId`。
   4. `safeTransferFrom`：安全转账（如果接收方是合约地址，会要求实现`ERC721Receiver`接口）。参数为转出地址`from`，接收地址`to`和`tokenId`。
   5. `approve`：授权另一个地址使用你的NFT。参数为被授权地址`approve`和`tokenId`。
   6. `getApproved`：查询`tokenId`被批准给了哪个地址。
   7. `setApprovalForAll`：将自己持有的该系列NFT批量授权给某个地址`operator`。
   8. `isApprovedForAll`：查询某地址的NFT是否批量授权给了另一个`operator`地址。
   9. `safeTransferFrom`：安全转账的重载函数，参数里面包含了`data`。
      
**什么时候使用接口？**
   * 一个合约实现了`IERC721`接口，我们不需要知道它具体代码实现，就可以与它交互。
   ```Solidity
    contract interactBAYC {
       // 利用BAYC地址创建接口合约变量（ETH主网）
       IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
   
       // 通过接口调用BAYC的balanceOf()查询持仓量
       function balanceOfBAYC(address owner) external view returns (uint256 balance){
           return BAYC.balanceOf(owner);
       }
   
       // 通过接口调用BAYC的safeTransferFrom()安全转账
       function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
           BAYC.safeTransferFrom(from, to, tokenId);
       }
   }
   ```

**异常**
   * 检查条件不成立的时候，就会抛出异常。
   * Error
      *  方便且高效（省`gas`）地向用户解释操作失败的原因
      *  抛出异常的同时可携带参数
      *  可以在`contract`之外定义异常
      ```Solidity
        error TransferNotOwner(); // 自定义error
        error TransferNotOwner(address sender); // 自定义的带参数的error
     
        function transferOwner1(uint256 tokenId, address newOwner) public {
          if(_owners[tokenId] != msg.sender){
              revert TransferNotOwner();
              // revert TransferNotOwner(msg.sender);
          }
          _owners[tokenId] = newOwner;
        }
      ```
      * `error`必须搭配`revert`（回退）命令使用。
   * Require
      * 唯一的缺点就是`gas`随着描述异常的字符串长度增加，比`error`命令要高。
      * 使用方法：`require(检查条件，"异常的描述")`
      ```Solidity
      function transferOwner2(uint256 tokenId, address newOwner) public {
          require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
          _owners[tokenId] = newOwner;
      }
      ```
   * Assert
      * 一般用于程序员写程序`debug`
      * 不能解释抛出异常的原因（比`require`少个字符串）
      * 使用方法：`assert(检查条件）`
      ```Solidity
      function transferOwner3(uint256 tokenId, address newOwner) public {
          assert(_owners[tokenId] == msg.sender);
          _owners[tokenId] = newOwner;
      }
      ```

### 2024.09.30

**重载**
   * 名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。
   * Solidity不允许修饰器（`modifier`）重载。
   * 函数重载:
   ```Solidity
   function saySomething() public pure returns(string memory){
       return("Nothing");
   }
   
   function saySomething(string memory something) public pure returns(string memory){
       return(something);
   }
   ```
![image](https://github.com/user-attachments/assets/562464eb-f093-46d6-8b24-23aeb101352d)

   * 实参匹配（Argument Matching）:
      * 在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。
      * 如果出现多个匹配的重载函数，则会报错。
     ```Solidity
     function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
     }
      
     function f(uint256 _in) public pure returns (uint256 out) {
        out = _in;
     }
     ```
      * 调用`f(50)`，因为50既可以被转换为`uint8`，也可以被转换为`uint256`，因此会报错。
        
**库合约**
   * 是一系列的函数合集
   * 和普通合约的不同：
     1. 不能存在状态变量
     2. 不能够继承或被继承
     3. 不能接收以太币
     4. 不可以被销毁
   * 函数可见性如果被设置为`public`或者`external`，则在调用函数时会触发一次`delegatecall`。如果被设置为`internal`，则不会引起。
   * 对于设置为`private`可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

**Strings库合约**
   * 将`uint256`类型转换为相应的`string`类型的代码库
```Solidity
   library Strings {
       bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";
   
       /**
        * @dev Converts a `uint256` to its ASCII `string` decimal representation.
        */
       function toString(uint256 value) public pure returns (string memory) {
           // Inspired by OraclizeAPI's implementation - MIT licence
           // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
   
           if (value == 0) {
               return "0";
           }
           uint256 temp = value;
           uint256 digits;
           while (temp != 0) {
               digits++;
               temp /= 10;
           }
           bytes memory buffer = new bytes(digits);
           while (value != 0) {
               digits -= 1;
               buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
               value /= 10;
           }
           return string(buffer);
       }
   
       /**
        * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
        */
       function toHexString(uint256 value) public pure returns (string memory) {
           if (value == 0) {
               return "0x00";
           }
           uint256 temp = value;
           uint256 length = 0;
           while (temp != 0) {
               length++;
               temp >>= 8;
           }
           return toHexString(value, length);
       }
   
       /**
        * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
        */
       function toHexString(uint256 value, uint256 length) public pure returns (string memory) {
           bytes memory buffer = new bytes(2 * length + 2);
           buffer[0] = "0";
           buffer[1] = "x";
           for (uint256 i = 2 * length + 1; i > 1; --i) {
               buffer[i] = _HEX_SYMBOLS[value & 0xf];
               value >>= 4;
           }
           require(value == 0, "Strings: hex length insufficient");
           return string(buffer);
       }
   }
   ```
   * 如何使用库合约:
      1. 利用using for指令: 指令`using A for B`; 可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。
         * 在调用的时候，这个变量会被当作第一个参数传递给函数
         ```Solidity
         // 利用using for指令
         using Strings for uint256;
         function getString1(uint256 _number) public pure returns(string memory){
             // 库合约中的函数会自动添加为uint256型变量的成员
             return _number.toHexString();
         }
         ```
      2. 通过库合约名称调用函数
         ```Solidity
         // 直接通过库合约名调用
         function getString2(uint256 _number) public pure returns(string memory){
             return Strings.toHexString(_number);
         }
         ```
     ![image](https://github.com/user-attachments/assets/eddca6ba-278c-466f-a51a-7eed768b1323)
两种方法均能返回正确的16进制string “0xaa”。证明我们调用库合约成功！

###  2024.10.01

複習
**變量類型**
   * 值類型: 布林、整數、地址、字節數組。直接傳遞數據。
   * 引用類型: 字串、數組、結構體。只存指向數據的引用。
      * 數組:
        1. 固定長度array: 以`memory`修飾的動態數組，可用new創建，但必須宣告長度，且宣告後長度不能改變。
        2. 可變長度array
      * 結構體: 定義新的類型，裡面可以是值類型也可以是引用類型。本身也可作為數組或映射類型使用。
   * 映射類型: mapping。只存在`stroage`。
      * 透過key來查詢對應的value
        
**變量作用域**
   * 狀態變量: 存在鏈上，合約內、函數外宣告，合約內函數皆可訪問，gas高。
   * 局部變量: 存在記憶體上，函數內宣告，生命週期為函數執行期間，gas低。
   * 全域變量: 在全域範圍工作，是Solidity預留的關鍵字，可不宣告就使用。
      * eg. 乙太單位、時間單位
     
**函數**
   * 需定義可見性: internal、external、public、private
      * internal: 只能從本合約內部訪問，繼承的合約可使用。
      * external: 只能從合約外部訪問(內部可通過`this.f()`調用)。
      * public: 內外部均可見。
      * private: 只能從本合約內部訪問，繼承的合約不可使用。
   * 決定函數權限或功能: pure、view、payable
      * pure: 不能讀也不能寫入鏈上
      * view: 能讀不能寫入鏈上
      * payable: 可支付的
   * 返回: 命令式返回、解構式返回
      * 命令式返回: `returns`中標明返回變量的名稱，會自動返回，不需使用return。
      * 解構式返回: 聲明變量，將要賦值的變量用 , 隔開，依序排列。若是只讀取部分返回值，則留空。
    
###  2024.10.02
**變量初始值**
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
* 引用类型初始值：
   * 映射mapping: 所有元素都为其默认值的mapping
   * 结构体struct: 所有成员设为其默认值的结构体
   * 数组array
   * 动态数组: []
   * 静态数组（定长）: 所有成员设为其默认值的静态数组

**常數**
    * `constant`跟`immutable`
       * constant: 聲明時初始化，不可改變
       * immutable: 聲明或在構造函數初始化，若同時，會採用構造函數的值。
       
**控制流**
   * `if-else`、`for`、`while`、`do while`、三元運算子
     
**構造函數**
   * constructor: 每個合約可定義一個，部屬合約時自動執行一次

**修飾器**
   * modifier: 聲明函數擁有的特性，主要用來在執行函數前的檢查。

**事件**
   * event: 是`EVM`上日記的抽象，有兩個特色:
     1. 響應: 應用程式(ethers.js)可以透過RPC街口訂閱和監聽這些事件，並在前端做響應。
     2. 經濟: 比較經濟的存數據方式，每個大概消耗2000gas，但鏈上存一個變量要消耗20000gas
   * 聲明事件: event event_name( 變量類型 變量名, ... )
   * 釋放事件: emit event event_name( 變量名, ... )

**EVM日記 Log**
   * 以太坊虛擬機(EVM)用日記`Log`來儲存Solidity事件，每條日記都包含主題`topics`和數據`data`兩部分
     1. `topics`: 描述事件，長度不超過4，第一個元素是事件的簽名(哈希)，除了哈希還可以包含最多三個`indexed`參數，固定為256bits
     2. `data`: event中不帶`indexed`的參數，即為事件的值。不能被直接搜尋，但可以存任意大小的數據，消耗的gas相對於topics`更少。

###  2024.10.03

**繼承**
   * 規則:
     1. `virtual`: 希望子合約重寫的函數，需要在父合約中加上`virtual`
     2. `override`: 子合約重寫的函數要加上`override`。且用`override`修飾`public`變量，會重寫與變量同名的`getter`函數
   * 簡單繼承: contract A is B，A是子合約，B是父合約
   * 多重繼承:
      * 規則:
        1. 繼承時按照輩份最高到最低順序排
        2. 某一個函數在多個繼承的合約裡都有，子合約就必須重寫
        3. 重寫在多個父合約中都一樣名稱的函數時，`override`後面要加上所有父合約的名字。e.g. `override(A, B)`
   * 修飾器的繼承: 跟函數繼承一樣，在對應的地方加`virtual`和`override`就好。
   * 構造函數的繼承:
     1. 在繼承時聲明父合約構造函數的參數
     2. 在子合約的構造函數聲明構造函數的參數
   * 調用父合約的函數:
     1. 直接調用: `父合約名稱.函數名()`
     2. `super`: `super.函數名()`
   * 鑽石繼承: 一個派生類同時有兩個或兩個以上的基類。
      * 使用`super`的話會調用繼承鏈條勝的每一個合約的相關函數，而非最近的父合約。
   ```Solidity
     /* 继承树：
     God
    /  \
   Adam Eve
    \  /
   people
   */
   ```

**抽象合约**
   * 一個合約裡面至少有一個未實現的函數，必須將該合約標為`abstract`。
   * 未實現的函數需加`virtual`，以便子合約重寫。

**介面(接口)**
   * 類似抽象合約，但不實現任何功能。
   * 介面的規則：
     1. 不能包含狀態變數。
     2. 不能包含建構子。
     3. 不能繼承除介面外的其他合約。
     4. 所有函數都必須是external且不能有函數體。
     5. 繼承介面的非抽象合約必須實作介面定義的所有功能。
   * 介面是智慧合約的骨架，定義了合約的功能以及如何觸發它們。
   * 如果智慧合約實現了某種介面（例如`ERC20`或`ERC721`），其他Dapps和智能合約就知道如何與它互動。因為介面提供了兩個重要的資訊：
     1. 合約裡每個函數的`bytes4`選擇器，以及函數簽名`函數名(每個參數類型）`。
     2. 接口id。
   * 介面與合約`ABI`（Application Binary Interface）等價，可以互相轉換。
   * 編譯介面可以得到合約的`ABI`，利用abi-to-sol工具，也可以將`ABI json`檔轉換為介面`sol`檔。

**IERC721事件**

   `IERC721`包含3個事件，其中`Transfer`和`Approval`事件在`ERC20`中也有。
   1. `Transfer`事件：在轉帳時被釋放，記錄代幣的發出地址`from`，接收地址`to`和`tokenId`。
   2. `Approval`事件：在授權時被釋放，記錄授權位址`owner`，被授權位址`approved`和`tokenId`。
   3. `ApprovalForAll`事件：在批量授權時被釋放，記錄批量授權的發出地址`owner`，被授權地址`operator`和授權與否的`approved`。

**IERC721函數**
   1. `balanceOf`：傳回某地址的NFT持有量`balance`。
   2. `ownerOf`：回傳某`tokenId`的主人`owner`。
   3. `transferFrom`：普通轉賬，參數為轉出地址`from`，接收地址`to`和`tokenId`。
   4. `safeTransferFrom`：安全轉帳（如果接收方是合約位址，會要求實作`ERC721Receiver`介面）。參數為轉出位址`from`，接收位址`to`和`tokenId`。
   5. `approve`：授權另一個位址使用你的NFT。參數為被授權位址`approve`和`tokenId`。
   6. `getApproved`：查詢`tokenId`被核准給了哪個位址。
   7. `setApprovalForAll`：將自己持有的該系列NFT批次授權給某個位址`operator`。
   8. `isApprovedForAll`：查詢某個位址的NFT是否批次授權給了另一個`operator`位址。
   9. `safeTransferFrom`：安全轉帳的重載函數，參數裡麵包含了`data`。

**什麼時候使用介面**
   * 一個合約實現了`IERC721`接口，我們不需要知道它具體代碼實現，就可以與它交互。

**異常**
   * 檢查條件不成立的時候，就會拋出異常。
   * Error
      * 方便且有效率（省`gas`）地向使用者解釋操作失敗的原因
      * 拋出例外的同時可攜帶參數
      * 可以在`​​contract`之外定義異常
      * `error`必須搭配`revert`（回退）指令使用。
   * Require
      * 唯一的缺點就是`gas`隨著描述異常的字串長度增加，比`error`指令要高。
      * 使用方法：`require(檢查條件，"異常的描述")`
   * Assert
      * 一般用於程式設計師寫入程式`debug`
      * 不能解釋拋出異常的原因（比`require`少個字串）
      * 使用方法：`assert(檢查條件）`
    
###  2024.10.04

**`import`**
   * 用法:
      * 通过源文件相对位置导入
      ```Solidity
         文件结构
         ├── Import.sol
         └── Yeye.sol
         
         // 通过文件相对位置import
         import './Yeye.sol';
      ```
      * 通过源文件网址导入网上的合约的全局符号
      ```Solidity
      // 通过网址引用
      import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
        ```
      * 通过npm的目录导入
      ```Solidity
         import '@openzeppelin/contracts/access/Ownable.sol';
      ```
      * 通过指定全局符号导入合约特定的全局符号
      ```Solidity
         import {Yeye} from './Yeye.sol';
      ```  

###  2024.10.05

**接收ETH函数 receive**
   * `receive()`函数是在合约收到ETH转账时被调用的函数
   * 一个合约最多有一个receive()函数
   * 声明不需要function关键字: `receive() external payable { ... }`
   * receive()函数不能有任何的参数，不返回任何值，必须包含`external`和`payable`。
   * 合约接收ETH的时候，`receive()`会被触发
   * `receive()`最好不要执行太多的逻辑，因为如果别人用`send`和`transfer`方法发送ETH的话，`gas`会限制在2300，`receive()`太复杂可能会触发`Out of Gas`报错
   * 如果用`call`就可以自定义gas执行更复杂的逻辑
   ```Solidity
   // 定义事件
   event Received(address Sender, uint Value);
   // 接收ETH时释放Received事件
   receive() external payable {
       emit Received(msg.sender, msg.value);
   }
   ```

**回退函数 fallback**
   * `fallback()`函数会在调用合约不存在的函数时被触发
   * 可用于接收ETH，也可以用于代理合约`proxy contract`
   * 声明须由`external`修饰，一般也会用payable修饰，用于接收ETH: `fallback() external payable { ... }`
   ```Solidity
   event fallbackCalled(address Sender, uint Value, bytes Data);
   
   // fallback
   fallback() external payable{
       emit fallbackCalled(msg.sender, msg.value, msg.data);
   }
   ```

**receive和fallback的区别**
   ```Solidity
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
   * 合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。
   * `receive()`和`payable fallback()`均不存在的时候，向合约直接发送ETH将会报错

###  2024.10.07

**接收ETH合约**
   * 先部署一个接收ETH合约ReceiveETH。
       ```Solidity
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
**发送ETH合约**
   * 先在发送ETH合约SendETH中实现payable的构造函数和`receive()`，让我们能够在部署时和部署后向合约转账。
      ```Solidity
      contract SendETH {
          // 构造函数，payable使得部署的时候可以转eth进去
          constructor() payable{}
          // receive方法，接收eth时被触发
          receive() external payable{}
      }
      ```
   * transfer
      * 用法是`接收方地址.transfer(发送ETH数额)`。
      * `transfer()`的gas限制是2300，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。
      * `transfer()`如果转账失败，会自动revert（回滚交易）。
      * 注意里面的_to填ReceiveETH合约的地址，amount是ETH转账金额
      ```Solidity
      // 用transfer()发送ETH
      function transferETH(address payable _to, uint256 amount) external payable{
          _to.transfer(amount);
      }
      ```
   * send
      * 用法是`接收方地址.send(发送ETH数额)`。
      * `send()`的gas限制是2300，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。
      * `send()`如果转账失败，不会revert。
      * `send()`的返回值是bool，代表着转账成功或失败，需要额外代码处理一下。
      ```Solidity
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
   * call
      * 用法是`接收方地址.call{value: 发送ETH数额}("")`。
      * `call()`没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑。
      * `call()`如果转账失败，不会revert。
      * `call()`的返回值是`(bool, bytes)`，其中bool代表着转账成功或失败，需要额外代码处理一下。
      ```Solidity
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
###  2024.10.08
**调用已部署合约**
   * 先写一个简单的合约OtherContract，用于被其他合约调用。
   ```Solidity
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
   * 调用OtherContract合约
      * 可以利用合约的地址和合约代码（或接口）来创建合约的引用: `_Name(_Address)`
      * 用合约的引用来调用它的函数: `_Name(_Address).f()`
   * 4个调用合约的例子
      1. 传入合约地址: 可以在函数里传入目标合约地址，生成目标合约的引用，然后调用目标函数。
         ```Solidity
         function callSetX(address _Address, uint256 x) external{
             OtherContract(_Address).setX(x);
         }
         ```
      2. 传入合约变量: 可以直接在函数里传入合约的引用
         ```Solidity
         function callGetX(OtherContract _Address) external view returns(uint x){
             x = _Address.getX();
         }
         ```
      3. 创建合约变量: 可以创建合约变量，通过它来调用目标函数。
         ```Solidity
         function callGetX2(address _Address) external view returns(uint x){
             OtherContract oc = OtherContract(_Address);
             x = oc.getX();
         }
         ```
      4.  调用合约并发送ETH: 如果目标合约的函数是payable的，那么我们可以通过调用它来给合约转账。
          * e.g. `_Name(_Address).f{value: _Value}()`
          ```Solidity
          function setXTransferETH(address otherContract, uint256 x) payable external{
             OtherContract(otherContract).setX{value: msg.value}(x);
          }
          ```

###  2024.10.09
**Call**
   * `address`类型的低级成员函数
   * 用来与其他合约交互
   * 返回值为`(bool, bytes memory)`
   * 是Solidity官方推荐的通过触发`fallback`或`receive`函数发送ETH的方法
   * 不推荐用`call`来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。
   * 当我们不知道对方合约的源代码或`ABI`，就没法生成合约变量；这时，我们仍可以通过`call`调用对方合约的函数。
   * 使用规则:
     1. `目标合约地址.call(字节码);`
     2. 字节码利用结构化编码函数获得: `abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)`
     3. `函数签名`为`"函数名（逗号分隔的参数类型）"` e.g. `abi.encodeWithSignature("f(uint256,address)", _x, _addr)`
     4. call在调用合约时可以指定交易发送的ETH数额和gas数额: `目标合约地址.call{value:发送数额, gas:gas数额}(字节码);`
    
**目标合约**
   * 先写一个简单的目标合约`OtherContract`并部署
   ```Solidity
   contract OtherContract {
       uint256 private _x = 0; // 状态变量x
       // 收到eth的事件，记录amount和gas
       event Log(uint amount, uint gas);
       
       fallback() external payable{}
   
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
   ```
   * 利用call调用目标合约
      1.  Response事件
         ```Solidity
         // 定义Response事件，输出call返回的结果success和data
         event Response(bool success, bytes data);
         ```
         * 写一个`Call`合约来调用目标合约函数。
         
      2. 调用setX函数
         ```Solidity
         function callSetX(address payable _addr, uint256 x) public payable {
             // call setX()，同时可以发送ETH
             (bool success, bytes memory data) = _addr.call{value: msg.value}(
                 abi.encodeWithSignature("setX(uint256)", x)
             );
         
             emit Response(success, data); //释放事件
         }
         ```
         * 定义`callSetX`函数来调用目标合约的`setX()`，转入`msg.value`数额的ETH，并释放`Response`事件输出`success`和`data`
      ![image](https://github.com/user-attachments/assets/ceb3d81a-0073-4458-8021-9cd52dbc0025)
      
      3. 调用getX函数
         ```Solidity
         function callGetX(address _addr) external returns(uint256){
             // call getX()
             (bool success, bytes memory data) = _addr.call(
                 abi.encodeWithSignature("getX()")
             );
         
             emit Response(success, data); //释放事件
             return abi.decode(data, (uint256));
         }
         ```
         * 调用`getX()`函数返回目标合约_x的值，可以利用`abi.decode`来解码`call`的返回值`data`，并读出数值。
         
      4. 调用不存在的函数
         ```Solidity
         function callNonExist(address _addr) external{
             // call 不存在的函数
             (bool success, bytes memory data) = _addr.call(
                 abi.encodeWithSignature("foo(uint256)")
             );
         
             emit Response(success, data); //释放事件
         }
         ```
         * 如果我们给call输入的函数不存在于目标合约，那么目标合约的fallback函数会被触发。

###  2024.10.10
**Delegatecall**
   * 与`call`类似，是Solidity中地址类型的低级成员函数。
   * `delegate`是委托/代表的意思
   
   **delegatecall委托了什么？**
      * 用户A通过合约B来`call`合约C的时候，执行的是合约C的函数，上下文(`Context`，可以理解为包含变量和状态的环境)也是合约C的
      * `msg.sender`是B的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约C的变量上。
     ![image](https://github.com/user-attachments/assets/f036b28b-1765-4d19-9c60-e7d68d5ccc2a)
      * 用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的
      * `msg.sender`是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
     ![image](https://github.com/user-attachments/assets/f1a07277-a996-4aad-b720-22ee03007a2b)
   * `delegatecall`语法: `目标合约地址.delegatecall(二进制编码);`
   * 二进制编码利用结构化编码函数`abi.encodeWithSignature`获得: `abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)`
   * 和`call`不一样，`delegatecall`在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额
   * **使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。**

**什么情况下会用到delegatecall?**
   * 主要有两个应用场景:
      1. 代理合约（`Proxy Contract`）: 
         * 将智能合约的存储合约和逻辑合约分开
         * 代理合约存储所有相关的变量，并且保存逻辑合约的地址
         * 所有函数存在逻辑合约（`Logic Contract`）里，通过`delegatecall`执行。当升级时，只需要将代理合约指向新的逻辑合约即可。
      2. EIP-2535 Diamonds（钻石）:
         * 支持构建可在生产中扩展的模块化智能合约系统的标准
         * 具有多个实施合约的代理合约

**delegatecall例子**
* 调用结构：你（A）通过合约B调用目标合约C。
   * 被调用的合约C:
      ```Solidity
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
   * 发起调用的合约B: 合约B必须和目标合约C的变量存储布局必须相同，两个变量，并且顺序为num和sender
      ```Solidity
      contract B {
          uint public num;
          address public sender;
      }
      ```
   * 分别用`call`和`delegatecall`来调用合约C的`setVars`函数
      ```Solidity
      // 通过call来调用C的setVars()函数，将改变合约C里的状态变量
      function callSetVars(address _addr, uint _num) external payable{
          // call setVars()
          (bool success, bytes memory data) = _addr.call(
              abi.encodeWithSignature("setVars(uint256)", _num)
          );
      }
      ```
   * `delegatecallSetVars`函数通过`delegatecall`来调用`setVars`
      ```Solidity
      // 通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量
      function delegatecallSetVars(address _addr, uint _num) external payable{
          // delegatecall setVars()
          (bool success, bytes memory data) = _addr.delegatecall(
              abi.encodeWithSignature("setVars(uint256)", _num)
          );
      }
      ```
      
###  2024.10.11

**去中心化交易所uniswap**
   * `create`: `Contract x = new Contract{value: _value}(params)`
   * 如果构造函数是`payable`，可以创建时转入`_value`数量的`ETH`，`params`是新合约构造函数的参数。

**极简Uniswap**
   * `Uniswap V2`核心合约中包含两个合约
     1. UniswapV2Pair: 币对合约，用于管理币对地址、流动性、买卖。
     2. UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。
   * `Pair`合约
   ```Solidity
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
   * 构造函数`constructor`在部署时将`factory`赋值为工厂合约地址。`initialize`函数会由工厂合约在部署完成后手动调用以初始化代币地址，将`token0`和`token1`更新为币对中两种代币的地址。
      * 为什么`uniswap`不在`constructor`中将`token0`和`token1`地址更新好？
      * 因为`uniswap`使用的是`create2`创建合约，生成的合约地址可以实现预测
        
   * `PairFactory`
   ```Solidity
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
   * `getPair`是两个代币地址到币对地址的`map`，方便根据代币找到币对地址；`allPairs`是币对地址的数组，存储了所有代币地址。
   * `PairFactory`合约只有一个`createPair`函数，根据输入的两个代币地址`tokenA`和`tokenB`来创建新的`Pair`合约。

###  2024.10.12
**CREATE2**
   * 智能合约部署在以太坊网络之前就能预测合约的地址。
   * `Uniswap`创建`Pair`合约用的就是`CREATE2`
   * CREATE如何计算地址
      * 智能合约可以由其他合约和普通账户利用CREATE操作码创建。
      * 新合约的地址计算：创建者的地址(通常为部署的钱包地址或者合约地址)和`nonce`(该地址发送交易的总数,对于合约账户是创建的合约总数,每创建一个合约`nonce`+1)的哈希。
      ```Solidity
      新地址 = hash(创建者地址, nonce)
      ```
      * 创建者地址不会变，但nonce可能会随时间而改变，因此用CREATE创建的合约地址不好预测。
   * CREATE2如何计算地址
      * 为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。
      * 用CREATE2创建的合约地址由4个部分决定：
        1. `0xFF`：一个常数，避免和`CREATE`冲突
        2. `CreatorAddress`: 调用`CREATE2`的当前合约（创建合约）地址。
        3. `salt`（盐）：一个创建者指定的`bytes32`类型的值，它的主要目的是用来影响新创建的合约的地址。
        4. `initcode`: 新合约的初始字节码（合约的Creation Code和构造函数的参数）
        ```Solidity
        新地址 = hash("0xFF",创建者地址, salt, initcode)
        ```
     * 如果创建者使用`CREATE2`和提供的`salt`部署给定的合约`initcode`，它将存储在`新地址`中。
       
**如何使用CREATE2**
   * `Contract x = new Contract{salt: _salt, value: _value}(params)`
   * `Contract`是要创建的合约名，`x`是合约对象（地址），`_salt`是指定的盐；如果构造函数是`payable`，可以创建时转入`_value`数量的`ETH`，`params`是新合约构造函数的参数。

**用CREATE2来实现极简Uniswap**
   ```Solidity
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

   * 事先计算`Pair`地址
   ```Solidity
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

   * 如果部署合约构造函数中存在参数 e.g. `Pair pair = new Pair{salt: salt}(address(this));`
   * 计算时，需要将参数和initcode一起进行打包 e.g. `keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))`
     
   ```Solidity
   predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                   bytes1(0xff),
                   address(this),
                   salt,
                   keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))
               )))));
   ```

###  2024.10.13
**selfdestruct**
   * 用来删除智能合约，并将该合约剩余`ETH`转到指定地址。
   * 当前`SELFDESTRUCT`仅会被用来将合约中的`ETH`转移到指定地址，而原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。
   * 所以:
      1. 已经部署的合约无法被`SELFDESTRUCT`了。
      2. 如果要使用原先的`SELFDESTRUCT`功能，必须在同一笔交易中创建并`SELFDESTRUCT`。
         
**如何使用selfdestruct**
   * `selfdestruct(_addr)；`
   * `_addr`是接收合约中剩余`ETH`的地址。`_addr`地址不需要有`receive()`或`fallback()`也能接收`ETH`。
     
**转移ETH功能**
   * 在坎昆升级前可以完成合约的自毁，在坎昆升级后仅能实现内部ETH余额的转移。
   ```Solidity
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
   * 部署好合约后，我们向`DeleteContract`合约转入1`ETH`。这时，`getBalance()`会返回1`ETH`，`value`变量是10。
   * 调用`deleteContract()`函数，合约将触发`selfdestruct`操作。在坎昆升级前，合约会被自毁。但是在升级后，合约依然存在，只是将合约包含的`ETH`转移到指定地址，而合约依然能够调用。

**同笔交易内实现合约创建-自毁**
   * 原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以我们需要通过另一个合约进行控制。
   ```Solidity
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

**注意事项**
   1. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
   2. 当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的`selfdestruct`功能会为攻击者打开攻击向量(例如使用`selfdestruct`向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

###  2024.10.14
**ABI编码**
   * 4个函数
     1. `abi.encode`: 将给定参数利用ABI规则编码。`ABI`被设计出来跟智能合约交互，他将每个参数填充为32字节的数据，并拼接在一起。
      ```Solidity
      uint x = 10;
      address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
      string name = "0xAA";
      uint[2] array = [5, 6];
      
      function encode() public view returns(bytes memory result) {
          result = abi.encode(x, addr, name, array);
      }
      ```
      
         * 编码的结果为`0x000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，由于abi.encode将每个数据都填充为32字节，中间有很多0。
           
     2. `abi.encodePacked`: 将给定参数根据其所需最低空间编码。当你想省空间，并且不与合约交互的时候，可以使用。
      ```Solidity
      function encodePacked() public view returns(bytes memory result) {
      result = abi.encodePacked(x, addr, name, array);
      }
      ```

         * 编码的结果为`0x000000000000000000000000000000000000000000000000000000000000000a7a58c0be72be218b41c608b7fe7c5bb630736c713078414100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006`，由于abi.encodePacked对编码进行了压缩，长度比abi.encode短很多。
        
     3. `abi.encodeWithSignature`: 与`abi.encode`功能类似，只不过第一个参数为函数签名，比如`foo(uint256,address,string,uint256[2])`。当调用其他合约的时候可以使用。
      ```Solidity
      function encodeWithSignature() public view returns(bytes memory result) {
         result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
      }
      ```
      
        * 编码的结果为`0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，等同于在`abi.encode`编码结果前加上了4字节的函数选择器(通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用)。
       
     4. `abi.encodeWithSelector`: 与`abi.encodeWithSignature`功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。
      ```Solidity
      function encodeWithSelector() public view returns(bytes memory result) {
         result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
      }
      ```
      
      * 编码的结果为  `0xe87082f1000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c7100000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000043078414100000000000000000000000000000000000000000000000000000000`，与`abi.encodeWithSignature`结果一样。
       
**ABI解码**
   * `abi.decode`: `abi.decode`用于解码`abi.encode`生成的二进制编码，将它还原成原本的参数。
     ```Solidity
     function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
        (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
     }
     ```
     ![image](https://github.com/user-attachments/assets/be259e82-59ee-401a-9076-e0a8e0ae817c)

**Hash的性质**
   * 可以将任意长度的消息转换为一个固定长度的值，这个值也称作哈希（hash）。
   * 一个好的哈希函数应该具有以下几个特性：
      * 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
      * 灵敏性：输入的消息改变一点对它的哈希改变很大。
      * 高效性：从输入的消息到哈希的运算高效。
      * 均一性：每个哈希值被取到的概率应该基本相等。
      * 抗碰撞性：
         *  弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
         *  强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。
  * 应用
      * 生成数据唯一标识
      * 加密签名
      * 安全加密
        
**Keccak256**
   * `Keccak256`函数是Solidity中最常用的哈希函数，用法非常简单: `哈希 = keccak256(数据);`
   * Keccak256和sha3:
     1. sha3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。*所以SHA3就和keccak计算的结果不一样*，这点在实际开发中要注意。
     2. 以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。
   * 生成数据唯一标识: 我们有几个不同类型的数据：`uint`，`string`，`address`，我们可以先用`abi.encodePacked`方法将他们打包编码，然后再用`keccak256`来生成唯一标识：
     ```Solidity
     function hash(
         uint _num,
         string memory _string,
         address _addr
         ) public pure returns (bytes32) {
         return keccak256(abi.encodePacked(_num, _string, _addr));
     }
     ```
   * 弱抗碰撞性: 给定一个消息`0xAA`，试图去找另一个消息，使得它们的哈希值相等：
     ```Solidity
     function weak(
         string memory string1
         )public view returns (bool){
         return keccak256(abi.encodePacked(string1)) == _msg;
     }
     ```
   * 强抗碰撞性: 构造一个函数`strong`，接收两个不同的`string`参数`string1`和`string2`，然后判断它们的哈希是否相同
     ```Solidity
     function strong(
        string memory string1,
        string memory string2
        )public pure returns (bool){
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
     }
     ```

###  2024.10.15
**函数选择器**
   * 当我们调用智能合约时，本质上是向目标合约发送了一段`calldata`，发送的`calldata`中前4个字节是`selector`（函数选择器）
   * `msg.data`: 是Solidity中的一个全局变量，值为完整的`calldata`（调用函数时传入的数据）。
      ```Solidity
      // event 返回msg.data
      event Log(bytes data);
      
      function mint(address to) external{
          emit Log(msg.data);
      }
      ```
      * 当参数为`0x2c44b726ADF1963cA47Af88B284C06f30380fC78`时，输出的`calldata`为`0x6a6278420000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78`
      * 前4个字节为函数选择器`selector`；后面32个字节为输入的参数。
      * calldata就是告诉智能合约，我要调用哪个函数，以及参数是什么。
     
**method id、selector和函数签名**
   * `method id`定义为函数签名的`Keccak`哈希后的前4个字节，当`selector`与`method id`相匹配时，即表示调用该函数>。
   * 计算method id时，需要通过函数名和函数的参数类型来计算，Solidity中，函数的参数类型主要分为：基础类型参数，固定长度类型参数，可变长度类型参数和映射类型参数。
      1. 基础类型参数: e.g. `bytes4(keccak256("函数名(参数类型1,参数类型2,...)"))`
      2. 固定长度类型参数: e.g. `bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))`
      3. 可变长度类型参数: e.g. `bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"))`
      4. 映射类型参数: e.g. `bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"))`
     
**使用selector**
   * 我们可以利用selector来调用目标函数。
   * 例如我想调用elementaryParamSelector函数，我只需要利用abi.encodeWithSelector将elementaryParamSelector函数的method id作为selector和参数打包编码，传给call函数
     ```Solidity
     // 使用selector来调用函数
     function callWithSignature() external{
     ...
         // 调用elementaryParamSelector函数
         (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
     ...
     }
     ```

###  2024.10.16
**try-catch**
   * 只能被用于`external`函数或创建合约时`constructor`（被视为`external`函数）的调用。
   ```Solidity
   try externalContract.f() { // 某个外部合约的函数调用
       // call成功的情况下 运行一些代码
   } catch {
       // call失败的情况下 运行一些代码
   }
   ```

      * 可以使用`this.f()`来替代`externalContract.f()`
      * `this.f()`也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。
      * 如果调用的函数有返回值，那么必须在`try`之后声明`returns(returnType val)`，并且在`try`模块中可以使用返回的变量
      * 如果是创建合约，那么返回值是新创建的合约变量。
      
   ```Solidity
   try externalContract.f() returns(returnType val){
       // call成功的情况下 运行一些代码
   } catch {
       // call失败的情况下 运行一些代码
   }
   ```
   * `catch`模块支持捕获特殊的异常原因
   ```Solidity
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

**try-catch实战**
   * 创建一个外部合约`OnlyEven`，并使用`try-catch`来处理异常
   ```Solidity
   contract OnlyEven{
       constructor(uint a){
           require(a != 0, "invalid number");
           assert(a != 1);
       }
   
       function onlyEven(uint256 b) external pure returns(bool success){
           // 输入奇数时revert
           require(b % 2 == 0, "Ups! Reverting");
           success = true;
       }
   }
   ```

   * 处理外部函数调用异常
   ```Solidity
   // 成功event
   event SuccessEvent();
   
   // 失败event
   event CatchEvent(string message);
   event CatchByte(bytes data);
   
   // 声明OnlyEven合约变量
   OnlyEven even;
   
   constructor() {
       even = new OnlyEven(2);
   }
   
   // 在external call中使用try-catch
   function execute(uint amount) external returns (bool success) {
       try even.onlyEven(amount) returns(bool _success){
           // call成功的情况下
           emit SuccessEvent();
           return _success;
       } catch Error(string memory reason){
           // call不成功的情况下
           emit CatchEvent(reason);
       }
   }
   ```

   * 处理合约创建异常: 只需要把`try`模块改写为`OnlyEven`合约的创建就行
   ```Solidity
   // 在创建新合约中使用try-catch （合约创建被视为external call）
   // executeNew(0)会失败并释放`CatchEvent`
   // executeNew(1)会失败并释放`CatchByte`
   // executeNew(2)会成功并释放`SuccessEvent`
   function executeNew(uint a) external returns (bool success) {
       try new OnlyEven(a) returns(OnlyEven _even){
           // call成功的情况下
           emit SuccessEvent();
           success = _even.onlyEven(a);
       } catch Error(string memory reason) {
           // catch失败的 revert() 和 require()
           emit CatchEvent(reason);
       } catch (bytes memory reason) {
           // catch失败的 assert()
           emit CatchByte(reason);
       }
   }
   ```
<!-- Content_END -->
