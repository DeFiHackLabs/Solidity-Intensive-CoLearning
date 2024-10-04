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
<!-- Content_END -->
