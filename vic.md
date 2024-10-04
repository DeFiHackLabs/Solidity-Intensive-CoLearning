---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍
我是Vic，一名从业7年的前端开发

3. 你认为你会完成本次残酷学习吗？
   是的，必须完成！
## Notes

<!-- Content_START -->

### 2024.09.23
使用编译器 remix https://remix.ethereum.org/
```
// 声明许可证
// SPDX License-Identifier: MIT

// solidity版本号，大于0.8.19
pragma solidity ^0.8.19;

// 声明HelloWorld
contract HelloWorld {
    // 生命公开字符hi，输出Hello World
    string public hi = "Hello World";

}
```

### 2024.09.24
#### 数据类型，bool，uint，address，byte，enum
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Types {
    // bool类型
    bool public open = false;
    bool public open1 = !open; // true
    bool public open2 = open && open1; // fasle
    bool public open3 = open || open1; // true
    bool public open4 = open == open1; // false
    bool public open5 = open != open1; // true

    // 整数
    // 整数分成: 整数(正整数、负整数) 正整数，平时只用uint，uint256其实就是uint
    int public stair = -18;
    uint public stair1 = 18;
    uint256 public stair2 = 0;

    // 数字运算 + - * / ** %
    uint public num = 100;
    uint public num1 = num + 1; // 101
    uint public num2 = num - 2; // 98
    uint public num3 = num * 2; // 200
    uint public num4 = num / 4; // 25
    uint public num5 = num ** 2; // 10000
    uint public num6 = num % 3; //1

    // 比价运算 <= < == != > >=
    bool public compare = 3 <= 3; // true
    bool public compare1 = 3 < 3; // fasle
    bool public compare2 = 3 == 3; // true
    bool public compare3 = 3 != 3; // false
    bool public compare4 = 3 > 3; //fasle
    bool public compare5 = 3 >= 3; //true

    // 地址
    /*
        普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
        payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账。

        1byte = 8bit = 1111 1111 = 0xFF
        所以1byte可以是2个16进制数据
    */
    address public wade = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address payable public  wade1 = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    uint256 public balance = wade.balance;

    // 定长字节数组
    /*
        字节数组分为定长和不定长两种：

        定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 bytes1, bytes8, bytes32 等类型。定长字节数组最多存储 32 bytes 数据，即bytes32。
        不定长字节数组: 属于引用类型（之后的章节介绍），数组长度在声明之后可以改变，包括 bytes 等。
    */
    bytes32 public _byte32 = "MiniSolidity"; // 0x4d696e69536f6c69646974790000000000000000000000000000000000000000
    bytes12 public _byte12 = "MiniSolidity"; // 0x4d696e69536f6c6964697479
    bytes1 public _byte1 = _byte12[0]; // 0x4d

    // 枚举enum（很少人用）
    enum ActionSet { Buy, Hold, Sell }
    ActionSet public action = ActionSet.Hold;

    // enum与uint可以相互转换
    // 枚举可以显式地和 uint 相互转换，并会检查转换的正整数是否在枚举的长度内，否则会报错
    function enumToUint() external view returns (uint) {
        return uint(action); // 1
    }
}
```
### 2024.09.25

#### 函数

函数
Solidity语言的函数非常灵活，可以进行各种复杂操作。在本教程中，我们将会概述函数的基础概念，并通过一些示例演示如何使用函数。

我们先看一下 Solidity 中函数的形式:

function <function name> (<parameter types>) {internal|external|public|private} [pure|view|payable] [returns ()]

Copy
看着有一些复杂，让我们从前往后逐个解释(方括号中的是可写可不 写的关键字)：

function：声明函数时的固定用法。要编写函数，就需要以 function 关键字开头。

 <function name> ：函数名。

(<parameter types>)：圆括号内写入函数的参数，即输入到函数的变量类型和名称。

{internal|external|public|private}：函数可见性说明符，共有4种。

   public：内部和外部均可见。
   private：只能从本合约内部访问，继承的合约也不能使用。
   external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
   internal: 只能从合约内部访问，继承的合约可以用。
注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。
注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。

[pure|view|payable]：决定函数权限/功能的关键字。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。pure 和 view 的介绍见下一节。

[returns ()]：函数返回的变量类型和名称。

到底什么是 Pure 和View？
刚开始学习 solidity 时，pure 和 view 关键字可能令人费解，因为其他编程语言中没有类似的关键字。solidity 引入这两个关键字主要是因为 以太坊交易需要支付气费（gas fee）。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

在以太坊中，以下语句被视为修改链上状态：

写入状态变量。
释放事件。
创建其他合约。
使用 selfdestruct.
通过调用发送以太币。
调用任何未标记 view 或 pure 的函数。
使用低级调用（low-level calls）。
使用包含某些操作码的内联汇编。
为了帮助大家理解，我画了一个马里奥插图。在这幅插图中，我将合约中的状态变量（存储在链上）比作碧琪公主，三种不同的角色代表不同的关键字。

WTF is pure and view in solidity?

pure，中文意思是“纯”，这里可以理解为”纯打酱油的”。pure 函数既不能读取也不能写入链上的状态变量。就像小怪一样，看不到也摸不到碧琪公主。

view，“看”，这里可以理解为“看客”。view函数能读取但也不能写入状态变量。类似马里奥，能看到碧琪公主，但终究是看客，不能入洞房。

非 pure 或 view 的函数既可以读取也可以写入状态变量。类似马里奥里的 boss，可以对碧琪公主为所欲为🐶。

##### pure|view|payable

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloFunction {
    // 函数
    // function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

    uint public number = 100;

    // 默认不使用view和pure，可以读写（修改）变量
    function add() external  {
        number += 1;
    }

    // view 能读取但也不能写入状态变量
    function addView() external view returns  (uint new_number) {
        new_number = number + 5;
    }

    // pure 既不能读取也不能写入链上的状态变量
    function addPure(uint _count) external  pure  returns (uint new_number) {
        new_number = _count + 5;
    }
}
```

##### internal,external,public,private

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloFunction {
    // 函数
    // function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

    // internal,external,public,private

    // public 内部和外部均可见
    function addPublic() public  {
        number += 5;
    }
    //  private 只能从本合约内部访问，外部不可见，继承的合约也不可使用
    function addPrivate() private  {
        number += 10;
    }

    // internal 只能从合约内部访问，外部不可见，继承的合约可以使用
    function addInternal() internal {
        number += 15;
    }

    // external 只能从合约外部访问，但是内部可以通过 this.f()来调用，f是函数名字
    function addExternal() external {
        number += 20;
    }
}
```

### 2024.09.26
#### 函数的返回
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 函数输出
contract functionReturn {
    // 创建公开可读写的数据
    uint public myNum;
    string public myStr1;
    bool public myBool;

    function returnName() internal pure returns (uint num, string memory str1, bool bool1) {
        // 可以直接使用return()进行返回
        // return(100, "Hello", false);

        // 也可以使用命名返回方式
        num = 200;
        str1 = "World";
        bool1 = true;
    }
    
    // 使用返回值修改创建的可读写的数据
    function getReturnName() external {
        // 对获取到的返回进行解构，数据类型，顺序需要相同
        (uint num, string memory str1, bool bool1) = returnName();
        myBool = bool1;
        myNum  = num;
        myStr1 = str1;

        // 也可以只解构需要的部分，区域部分可以为空
        (, string memory str1,) = returnName();
        myStr1 = str1;
    }
}
```

### 2024.09.27

#### 变量数据存储和作用域

---

引用类型(Reference Type)：
包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。
*****
#### 数据位置

Solidity 数据存储位置有三类：**storage**，**memory**和**calldata**。不同存储位置的 gas 成本不同。storage 类型的数据存在链上，类似计算机的硬盘，消耗 gas 多；memory 和 calldata 类型的临时存在内存里，消耗 gas 少。大致用法：

**storage**：合约里的状态变量默认都是 storage，存储在链上。

**memory**：函数里的参数和临时变量一般用 memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加 memory 修饰，例如：string, bytes, array 和自定义结构。

**calldata**：和 memory 类似，存储在内存中，不上链。与 memory 的不同点在于 calldata 变量不能修改（immutable），一般用于函数的参数。
*****
#### 数据位置和赋值规则

在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。规则如下：
赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
storage（合约的状态变量）赋值给本地 storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
memory 赋值给 memory，会创建引用，改变新变量会影响原变量。
其他情况下，赋值创建的是本体的副本，即对二者之一的修改，并不会同步到另一方。
*****
#### 变量的作用域

Solidity 中变量按作用域划分有三种，分别是状态变量（state variable），局部变量（local variable）和全局变量(global variable)

1. 状态变量
   状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas 消耗高。状态变量在合约内、函数外声明。
2. 局部变量
   局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas 低。局部变量在函数内声明。
3. 全局变量
   全局变量是全局范围工作的变量，都是 solidity 预留关键字。他们可以在函数内不声明直接使用。
*****
#### 常用的全局变量

  [更完整的列表请看这个](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions) 
  blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于 256 最近区块, 不包含当前区块。
  block.coinbase: (address payable) 当前区块矿工的地址
  block.gaslimit: (uint) 当前区块的 gaslimit
  block.number: (uint) 当前区块的 number
  block.timestamp: (uint) 当前区块的时间戳，为 unix 纪元以来的秒
  gasleft(): (uint256) 剩余 gas
  msg.data: (bytes calldata) 完整 call data
  msg.sender: (address payable) 消息发送者 (当前 caller)
  msg.sig: (bytes4) calldata 的前四个字节 (function identifier)
  msg.value: (uint) 当前交易发送的 wei 值
  block.blobbasefee: (uint) 当前区块的 blob 基础费用。这是 Cancun 升级新增的全局变量。
  blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个 blob 的版本化哈希（第一个字节为版本号，当前为 0x01，后面接 KZG 承诺的 SHA256 哈希的最后 31 个字节）。若当前交易不包含 blob，则返回空字节。这是 Cancun 升级新增的全局变量。

---

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 变量数据存储和作用域
contract varEnv {
    uint[] public a = [5,6,7];

    // 合约里的状态变量默认都是storage，存储在链上。
    function myStorage() external {
        uint[] storage xStorage = a;
        xStorage[1] = 199;
    }

    // 函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰
    function myMemory() external view {
        uint[] memory xMemory = a;
        xMemory[0] = 99;
    }

    // 和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数
    function myCalldata(uint[] calldata _x) external {
        a = _x;
    }

    /*
    变量按作用域划分有三种，分别是状态变量，局部变量 和 全局变量

    状态变量
    状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明

    局部变量
    局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明

    全局变量
    全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用
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
    blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量
    */

    uint public num = 12;
    string public str = "Hello";

    function change() external {
        num = 66;
        str = "World";
    }

    function change1() external pure returns(uint result) {
        uint num1 = 5;
        uint num2 = 10;
        result = num1 + num2;
    }

    function change2() external payable returns(uint amount, address sender, uint time) {
        // 常用的三种变量
        amount = msg.value;
        sender = msg.sender;
        time = block.timestamp;
        /*
            执行后输出：
            {
                "0": "uint256: amount 1000000000000000000",
                "1": "address: sender 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
                "2": "uint256: time 1727379969"
            }
        */
    }

    function change3() external  pure returns(uint amount, uint time) {
        amount = 1 ether;
        time = 1 hours;
    }
}

```

### 2024.09.28

#### 引用类型 array，struct

##### array

数组（`Array`）是`Solidity`常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种：

- 固定长度数组：在声明时指定数组的长度。用`T[k]`的格式声明，其中`T`是元素的类型，`k`是长度，例如：

  ```solidity
  // 固定长度 Array
  uint[8] array1;
  bytes1[5] array2;
  address[100] array3;
  ```

- 可变长度数组（动态数组）：在声明时不指定数组的长度。用`T[]`的格式声明，其中`T`是元素的类型，例如：

  ```solidity
  // 可变长度 Array
  uint[] array4;
  bytes1[] array5;
  address[] array6;
  bytes array7;
  ```

  **注意**：`bytes`比较特殊，是数组，但是不用加`[]`。另外，不能用`byte[]`声明单字节数组，可以使用`bytes`或`bytes1[]`。`bytes` 比 `bytes1[]` 省gas。

在Solidity里，创建数组有一些规则：

- 对于`memory`修饰的`动态数组`，可以用`new`操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：

  ```solidity
  // memory动态数组
  uint[] memory array8 = new uint[](5);
  bytes memory array9 = new bytes(9);
  ```

- 数组字面常数(Array Literals)是写作表达式形式的数组，用方括号包着来初始化array的一种方式，并且里面每一个元素的type是以第一个元素为准的，例如`[1,2,3]`里面所有的元素都是`uint8`类型，因为在Solidity中，如果一个值没有指定type的话，会根据上下文推断出元素的类型，默认就是最小单位的type，这里默认最小单位类型是`uint8`。而`[uint(1),2,3]`里面的元素都是`uint`类型，因为第一个元素指定了是`uint`类型了，里面每一个元素的type都以第一个元素为准。

  下面的例子中，如果没有对传入 `g()` 函数的数组进行 `uint` 转换，是会报错的。

  ```solidity
  // SPDX-License-Identifier: GPL-3.0
  pragma solidity >=0.4.16 <0.9.0;
  
  contract C {
      function f() public pure {
          g([uint(1), 2, 3]);
      }
      function g(uint[3] memory _data) public pure {
          // ...
      }
  }
  ```

  

- 如果创建的是动态数组，你需要一个一个元素的赋值。

  ```solidity
  uint[] memory x = new uint[](3);
  x[0] = 1;
  x[1] = 3;
  x[2] = 4;
  ```

  

数组成员[](https://www.wtf.academy/docs/solidity-101/ArrayAndStruct/#数组成员)

- `length`: 数组有一个包含元素数量的`length`成员，`memory`数组的长度在创建后是固定的。
- `push()`: `动态数组`拥有`push()`成员，可以在数组最后添加一个`0`元素，并返回该元素的引用。
- `push(x)`: `动态数组`拥有`push(x)`成员，可以在数组最后添加一个`x`元素。
- `pop()`: `动态数组`拥有`pop()`成员，可以移除数组最后一个元素。

---

##### 结构体 struct[](https://www.wtf.academy/docs/solidity-101/ArrayAndStruct/#结构体-struct)

`Solidity`支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法：

```solidity
// 结构体
struct Student{
    uint256 id;
    uint256 score; 
}

Student student; // 初始一个student结构体
```

给结构体赋值的四种方法：

```solidity
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



##### 代码块

```solidity
// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

// 引用类型 array， struct
contract referencetypes {

    // 声明定长array
    uint[3] numberArray;

    // 声明可变array
    uint[] numberArray2;

    // 声明动态+可变array
    uint[] numberArray3 = new uint[](2); // 初始化数组为两个长度


    // 修改定长array内容
    function change() external {
        numberArray[0] = 1;
        numberArray[1] = 2;
        numberArray[2] = 3;
    }

    // 修改可变array内容
    function change2() external {
        numberArray2.push(11);
        numberArray2.push(22);
        numberArray2.push(33);
        numberArray2.push(44);

        // 移除array最后一个元素
        numberArray2.pop();
        // 获取array长度
        numberArray2.length;
    }

    // 修改动态+可变array内容
    function change3() external {
        // 由于初始化长度为2，所以只可以是使用下标修改长度之内的数据
        numberArray3[0] = 111;
        numberArray3[1] = 222;
        // 超出创建array长度的数据，需要使用push()进行添加
        numberArray3.push(333);
        // 创建新的长度后，可以再次进行修改
        numberArray3[2] = 33333;
    }
    

    function getArray1() external view returns(uint[3] memory) {
        return numberArray;
    }

    function getArray2() external view returns(uint[] memory) {
        return numberArray2;
    }

    function getArray3() external view returns(uint[] memory) {
        return numberArray3;
    }

// ----------------------------------------------------------------- //

    // 声明一个struct
    struct Person {
        uint height;
        uint weight;
        string name;
    }

    Person public p;

    function changePerson() external {
        Person storage _p = p;
        _p.height = 180;
        _p.weight = 120;
        _p.name = "Vic";
    }

    function changePerson2() external {
        p.height = 172;
        p.weight = 103;
        p.name = "Anna";
    }

    function changePerson3() external {
        p = Person(168,96,"Vivian");
    }

    function changePerson4() external {
        p = Person({
            height: 163,
            weight: 92,
            name: "Lucy"
        });
    }
}
```

#### 映射类型

##### mapping

可以通过键（`Key`）来查询对应的值（`Value`），比如：通过一个人的`id`来查询他的钱包地址。

声明映射的格式为`mapping(_KeyType => _ValueType)`，其中`_KeyType`和`_ValueType`分别是`Key`和`Value`的变量类型。

```solidity
mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址
```

##### 映射的规则[](https://www.wtf.academy/docs/solidity-101/Mapping/#映射的规则)

- **规则1**：映射的`_KeyType`只能选择Solidity内置的值类型，比如`uint`，`address`等，不能用自定义的结构体。而`_ValueType`可以使用自定义的类型。下面这个例子会报错，因为`_KeyType`使用了我们自定义的结构体：

  ```solidity
  // 我们定义一个结构体 Struct
  struct Student{
      uint256 id;
      uint256 score; 
  }
  mapping(Student => uint) public testVar;
  ```

- **规则2**：映射的存储位置必须是`storage`，因此可以用于合约的状态变量，函数中的`storage`变量和library函数的参数（见[例子](https://github.com/ethereum/solidity/issues/4635)）。不能用于`public`函数的参数或返回结果中，因为`mapping`记录的是一种关系 (key - value pair)。

- **规则3**：如果映射声明为`public`，那么Solidity会自动给你创建一个`getter`函数，可以通过`Key`来查询对应的`Value`。

- **规则4**：给映射新增的键值对的语法为`_Var[_Key] = _Value`，其中`_Var`是映射变量名，`_Key`和`_Value`对应新增的键值对。例子：

  ```solidity
  function writeMap (uint _Key, address _Value) public{
      idToAddress[_Key] = _Value;
  }
  ```

##### 映射的原理[](https://www.wtf.academy/docs/solidity-101/Mapping/#映射的原理)

- **原理1**: 映射不储存任何键（`Key`）的资讯，也没有length的资讯。
- **原理2**: 映射使用`keccak256(abi.encodePacked(key, slot))`当成offset存取value，其中`slot`是映射变量定义所在的插槽位置。
- **原理3**: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（`Value`）的键（`Key`）初始值都是各个type的默认值，如uint的默认值是0。

```solidity
// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

contract mapTypes {
		// 创建一个地址映射，类型是uint
    mapping(address => uint) public balanceOf;

    function mint() external {
        balanceOf[msg.sender] = 50 ether;
    }

    function burn() external {
        balanceOf[msg.sender] = 10 ether;
    }
}
```

### 2024.09.29

#### 变量初始值

声明但没赋值的变量都有它的初始值或默认值

##### 值类型初始值[](https://www.wtf.academy/docs/solidity-101/InitialValue/#值类型初始值)

- `boolean`: `false`

- `string`: `""`

- `int`: `0`

- `uint`: `0`

- `enum`: 枚举中的第一个元素

- `address`: `0x0000000000000000000000000000000000000000` (或 `address(0)`)

- ```
  function
  ```

  - `internal`: 空白函数
  - `external`: 空白函数

可以用`public`变量的`getter`函数验证上面写的初始值是否正确：

```solidity
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



##### 引用类型初始值[](https://www.wtf.academy/docs/solidity-101/InitialValue/#引用类型初始值)

- 映射`mapping`: 所有元素都为其默认值的`mapping`

- 结构体`struct`: 所有成员设为其默认值的结构体

- 数组

  ```
  array
  ```

  - 动态数组: `[]`
  - 静态数组（定长）: 所有成员设为其默认值的静态数组

可以用`public`变量的`getter`函数验证上面写的初始值是否正确：

```solidity
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



##### `delete`操作符[](https://www.wtf.academy/docs/solidity-101/InitialValue/#delete操作符)

`delete a`会让变量`a`的值变为初始值。

```solidity
// delete操作符
bool public _bool2 = true; 
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}
```

#### 常数

Constant, inmutable

状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省`gas`。

只有数值变量可以声明`constant`和`immutable`；`string`和`bytes`可以声明为`constant`，但不能为`immutable`。

##### constant

变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。

```solidity
// constant变量必须在声明的时候初始化，之后不能改变
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```



##### immutable

变量可以在声明时或构造函数中初始化，因此更加灵活。在`Solidity v8.0.21`以后，`immutable`变量不需要显式初始化。反之，则需要显式初始化。 若`immutable`变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。

```solidity
// immutable变量可以在constructor里初始化，之后不能改变
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;
```



你可以使用全局变量例如`address(this)`，`block.number` 或者自定义的函数给`immutable`变量初始化。

```solidity
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

##### 代码块

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 常数
contract constType {
    
    // 创建常量，不可以修改
    uint public constant money = 10; // 10

    // function changeMoney() external {
        // 下面一行代码会报错
        // money = 20;
    // }

    uint public immutable point; // 99
    uint public immutable pointNum = 5; // 9

    // 创建immutable需要使用
    constructor() {
        point = 99;
    }

}
```

#### 控制流

##### 控制流[](https://www.wtf.academy/docs/solidity-101/InsertionSort/#控制流)

`Solidity`的控制流与其他语言类似，主要包含以下几种：

1. `if-else`

   ```solidity
   function ifElseTest(uint256 _number) public pure returns(bool){
       if(_number == 0){
           return(true);
       }else{
           return(false);
       }
   }
   ```

   

2. `for循环`

   ```solidity
   function forLoopTest() public pure returns(uint256){
       uint sum = 0;
       for(uint i = 0; i < 10; i++){
           sum += i;
       }
       return(sum);
   }
   ```

   

3. `while循环`

   ```solidity
   function whileTest() public pure returns(uint256){
       uint sum = 0;
       uint i = 0;
       while(i < 10){
           sum += i;
           i++;
       }
       return(sum);
   }
   ```

   

4. `do-while循环`

   ```solidity
   function doWhileTest() public pure returns(uint256){
       uint sum = 0;
       uint i = 0;
       do{
           sum += i;
           i++;
       }while(i < 10);
       return(sum);
   }
   ```

   

5. `三元运算符`

   三元运算符是`Solidity`中唯一一个接受三个操作数的运算符，规则`条件? 条件为真的表达式:条件为假的表达式`。此运算符经常用作`if`语句的快捷方式。

   ```solidity
   // 三元运算符 ternary/conditional operator
   function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
       // return the max of x and y
       return x >= y ? x: y; 
   }
   ```

   

另外还有`continue`（立即进入下一个循环）和`break`（跳出当前循环）关键字可以使用。

用`Solidity`实现插入排序[](https://www.wtf.academy/docs/solidity-101/InsertionSort/#用solidity实现插入排序)

**写在前面：90%以上的人用`Solidity`写插入算法都会出错。**

###### 插入排序[](https://www.wtf.academy/docs/solidity-101/InsertionSort/#插入排序)

```solidity
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

### 2024.09.30

#### 构造函数和修改器

##### 构造函数

构造函数（`constructor`）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数，例如初始化合约的`owner`地址：

```solidity
address owner; // 定义owner变量

// 构造函数
constructor(address initialOwner) {
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}
```



##### 修饰器

修饰器（`modifier`）是`Solidity`特有的语法，类似于面向对象编程中的装饰器（`decorator`），声明函数拥有的特性，并减少代码冗余。它就像钢铁侠的智能盔甲，穿上它的函数会带有某些特定的行为。`modifier`的主要使用场景是运行函数前的检查，例如地址，变量，余额等。

我们来定义一个叫做onlyOwner的modifier：

```solidity
// 定义modifier
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是否为owner地址
   _; // 如果是的话，继续运行函数主体；否则报错并revert交易
}
```



带有`onlyOwner`修饰符的函数只能被`owner`地址调用，比如下面这个例子：

```solidity
function changeOwner(address _newOwner) external onlyOwner{
   owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
}
```



我们定义了一个`changeOwner`函数，运行它可以改变合约的`owner`，但是由于`onlyOwner`修饰符的存在，只有原先的`owner`可以调用，别人调用就会报错。这也是最常用的控制智能合约权限的方法。

OpenZeppelin的Ownable标准实现

`OpenZeppelin`是一个维护`Solidity`标准化代码库的组织，他的`Ownable`标准实现如下： https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


### 2024.10.01

#### 事件

##### 事件

`Solidity`中的事件（`event`）是`EVM`上日志的抽象，它具有两个特点：

- 响应：应用程序（[`ethers.js`](https://learnblockchain.cn/docs/ethers.js/api-contract.html#id18)）可以通过`RPC`接口订阅和监听这些事件，并在前端做响应。
- 经济：事件是`EVM`上比较经济的存储数据的方式，每个大概消耗2,000 `gas`；相比之下，链上存储一个新变量至少需要20,000 `gas`。

##### 声明事件

事件的声明由`event`关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名。以`ERC20`代币合约的`Transfer`事件为例：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```



我们可以看到，`Transfer`事件共记录了3个变量`from`，`to`和`value`，分别对应代币的转账地址，接收地址和转账数量，其中`from`和`to`前面带有`indexed`关键字，他们会保存在以太坊虚拟机日志的`topics`中，方便之后检索。

##### 释放事件

我们可以在函数里释放事件。在下面的例子中，每次用`_transfer()`函数进行转账操作的时候，都会释放`Transfer`事件，并记录相应的变量。

```solidity
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



##### EVM日志 `Log`

以太坊虚拟机（EVM）用日志`Log`来存储`Solidity`事件，每条日志记录都包含主题`topics`和数据`data`两部分。

![12-3](https://www.wtf.academy/assets/images/12-3-06b5d454b3752b96000f8a9477fa31de.png)



##### 主题 `topics`

日志的第一部分是主题数组，用于描述事件，长度不能超过`4`。它的第一个元素是事件的签名（哈希）。对于上面的`Transfer`事件，它的事件哈希就是：

```solidity
keccak256("Transfer(address,address,uint256)")

//0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
```

除了事件哈希，主题还可以包含至多`3`个`indexed`参数，也就是`Transfer`事件中的`from`和`to`。

`indexed`标记的参数可以理解为检索事件的索引“键”，方便之后搜索。每个 `indexed` 参数的大小为固定的256比特，如果参数太大了（比如字符串），就会自动计算哈希存储在主题中。

##### 数据 `data`

事件中不带 `indexed`的参数会被存储在 `data` 部分中，可以理解为事件的“值”。`data` 部分的变量不能被直接检索，但可以存储任意大小的数据。因此一般 `data` 部分可以用来存储复杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特，即使存储在事件的 `topics` 部分中，也是以哈希的方式存储。另外，`data` 部分的变量在存储上消耗的gas相比于 `topics` 更少。

##### `Remix`演示

以 `Event.sol` 合约为例，编译部署。

然后调用 `_transfer` 函数。

![12-1](https://www.wtf.academy/assets/images/12-1-21d3090d03ff4dbb241e5810f2177fe8.jpg)

点击右侧的交易查看详情，可以看到日志的具体内容。

![12-2](https://www.wtf.academy/assets/images/12-2-4faa09c9994dc41555b86c1f023b4c38.jpg)

##### 在Etherscan上查询事件

我们尝试用`_transfer()`函数在`Sepolia`测试网络上转账100代币，可以在`Etherscan`上查询到相应的`tx`：[网址](https://sepolia.etherscan.io/tx/0xb07dcd9943662e2e8b17c7add370f046401962ce24d0690a61bb249a385dc8c9#eventlog)。

点击`Logs`按钮，就能看到事件明细：

![Event明细](https://www.wtf.academy/assets/images/12-4-3397b1066a143a21feb58ed7c697164d.png)



`Topics`里面有三个元素，`[0]`是这个事件的哈希，`[1]`和`[2]`是我们定义的两个`indexed`变量的信息，即转账的转出地址和接收地址。`Data`里面是剩下的不带`indexed`的变量，也就是转账数量。

##### 代码块

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EventFn {
    // 事件
    event Payfor(address indexed from, address indexed to, uint value);

    uint public a = 0;

    function payfor(address from, address to, uint value) external {
        a = value;
        
        emit Payfor(from, to, value);
    }
}
```

### 2024.10.02

#### 继承

- `virtual`: 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字。

- `override`：子合约重写了父合约中的函数，需要加上`override`关键字。

  **多重继承**

  `Solidity`的合约可以继承多个合约。规则：

  1. 继承时要按辈分最高到最低的顺序排。比如我们写一个`Erzi`合约，继承`Yeye`合约和`Baba`合约，那么就要写成`contract Erzi is Yeye, Baba`，而不能写成`contract Erzi is Baba, Yeye`，不然就会报错。
  2. 如果某一个函数在多个继承的合约里都存在，比如例子中的`hip()`和`pop()`，在子合约里必须重写，不然会报错。
  3. 重写在多个父合约中都重名的函数时，`override`关键字后面要加上所有父合约名字，
  4. 子合约有两种方式调用父合约的函数，直接调用和利用`super`关键字。

```solidity
// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

// 继承

// 创建爷爷合约
contract Yeye {
    event Log(string msg);

    function hip() external virtual {
        emit Log("yeye");
    }

    function yeye() external virtual {
        emit Log("yeye");
    }
}// 部署Yeye合约，会出现hip(),yeye()两个方法

// 创建爸爸合约，继承爷爷合约
contract Baba is Yeye {
    // 使用 override 关键字，重写父类方法
    function hip() external virtual override  {
        emit Log("baba");
    }

    function baba() external virtual {
        emit Log("baba");
    }
}// 部署Baba合约，会出现hip(),yeye(),baba()三个方法

contract Son is Yeye, Baba {
    // 会使用 override 覆盖所有父级的同名方法
    function hip() external virtual override(Yeye, Baba)  {
        emit Log("son");
        // 使用super先调用最近父类的方法
        super.hip(); // 输出son，baba
        
        // 也可以直接调用父类级别的方法
        Yeye.hip(); // 输出son、yeye
    }

    function son() external  {
        emit Log("son");
    }
}// 部署Son合约，会出现hip(),yeye(),baba()，son()四个方法
```



```solidity
// 修饰器继承

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

Copy
Identifier合约可以直接在代码中使用父合约中的exactDividedBy2And3修饰器，也可以利用override关键字重写修饰器：

modifier exactDividedBy2And3(uint _a) override {
    _;
    require(_a % 2 == 0 && _a % 3 == 0);
}
```



```solidity
// 构造函数的继承
contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}

// // 继承方式1
// constant B is A(5){

// }

// 继承方式2
contract C is A {
    // 此时，传入下面函数3，合约A中的构造函数输出3*3=9
    constructor(uint _a) A(_a * _a) {

    }
}
```



在面向对象编程中，钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类。

在多重+菱形继承链条上使用`super`关键字时，需要注意的是使用`super`会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。

```solidity
// 钻石继承
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
		// 顺序是：people > Eve > Admn > God
		
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}

/*
在这个例子中，调用合约people中的super.bar()会依次调用Eve、Adam，最后是God合约。

虽然Eve、Adam都是God的子合约，但整个过程中God合约只会被调用一次。原因是Solidity借鉴了Python的方式，强制一个由基类构成的DAG（有向无环图）使其保证一个特定的顺序。
*/
```

### 2024.10.03

#### 抽象合约和接口

抽象合约（`abstract`）和接口（`interface`）

##### 抽象合约

如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体`{}`中的内容，则必须将该合约标为`abstract`，不然编译会报错；另外，未实现的函数需要加`virtual`，以便子合约重写。拿我们之前的[插入排序合约](https://github.com/AmazingAng/WTF-Solidity/tree/main/10_InsertionSort)为例，如果我们还没想好具体怎么实现插入排序函数，那么可以把合约标为`abstract`，之后让别人补写上。

```solidity
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```



##### 接口

接口类似于抽象合约，但它不实现任何功能。接口的规则：

1. 不能包含状态变量
2. 不能包含构造函数
3. 不能继承除接口外的其他合约
4. 所有函数都必须是external且不能有函数体
5. 继承接口的非抽象合约必须实现接口定义的所有功能

虽然接口不实现任何功能，但它非常重要。接口是智能合约的骨架，定义了合约的功能以及如何触发它们：如果智能合约实现了某种接口（比如`ERC20`或`ERC721`），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：

1. 合约里每个函数的`bytes4`选择器，以及函数签名`函数名(每个参数类型）`。
2. 接口id（更多信息见[EIP165](https://eips.ethereum.org/EIPS/eip-165)）

另外，接口与合约`ABI`（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的`ABI`，利用[abi-to-sol工具](https://gnidan.github.io/abi-to-sol/)，也可以将`ABI json`文件转换为`接口sol`文件。

我们以`ERC721`接口合约`IERC721`为例，它定义了3个`event`和9个`function`，所有`ERC721`标准的NFT都实现了这些函数。我们可以看到，接口和常规合约的区别在于每个函数都以`;`代替函数体`{ }`结尾。

```solidity
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



###### IERC721事件

`IERC721`包含3个事件，其中`Transfer`和`Approval`事件在`ERC20`中也有。

- `Transfer`事件：在转账时被释放，记录代币的发出地址`from`，接收地址`to`和`tokenId`。
- `Approval`事件：在授权时被释放，记录授权地址`owner`，被授权地址`approved`和`tokenId`。
- `ApprovalForAll`事件：在批量授权时被释放，记录批量授权的发出地址`owner`，被授权地址`operator`和授权与否的`approved`。

###### IERC721函数

- `balanceOf`：返回某地址的NFT持有量`balance`。
- `ownerOf`：返回某`tokenId`的主人`owner`。
- `transferFrom`：普通转账，参数为转出地址`from`，接收地址`to`和`tokenId`。
- `safeTransferFrom`：安全转账（如果接收方是合约地址，会要求实现`ERC721Receiver`接口）。参数为转出地址`from`，接收地址`to`和`tokenId`。
- `approve`：授权另一个地址使用你的NFT。参数为被授权地址`approve`和`tokenId`。
- `getApproved`：查询`tokenId`被批准给了哪个地址。
- `setApprovalForAll`：将自己持有的该系列NFT批量授权给某个地址`operator`。
- `isApprovedForAll`：查询某地址的NFT是否批量授权给了另一个`operator`地址。
- `safeTransferFrom`：安全转账的重载函数，参数里面包含了`data`。

##### 什么时候使用接口？

如果我们知道一个合约实现了`IERC721`接口，我们不需要知道它具体代码实现，就可以与它交互。

无聊猿`BAYC`属于`ERC721`代币，实现了`IERC721`接口的功能。我们不需要知道它的源代码，只需知道它的合约地址，用`IERC721`接口就可以与它交互，比如用`balanceOf()`来查询某个地址的`BAYC`余额，用`safeTransferFrom()`来转账`BAYC`。

```solidity
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



#### 异常

三种抛出异常的方法：`error`，`require`和`assert`

##### Error

`error`是`solidity 0.8.4版本`新加的内容，方便且高效（省`gas`）地向用户解释操作失败的原因，同时还可以在抛出异常的同时携带参数，帮助开发者更好地调试。人们可以在`contract`之外定义异常。下面，我们定义一个`TransferNotOwner`异常，当用户不是代币`owner`的时候尝试转账，会抛出错误：

```solidity
error TransferNotOwner(); // 自定义error
```



我们也可以定义一个携带参数的异常，来提示尝试转账的账户地址

```solidity
error TransferNotOwner(address sender); // 自定义的带参数的error
```



在执行当中，`error`必须搭配`revert`（回退）命令使用。

```solidity
function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
        // revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```



我们定义了一个`transferOwner1()`函数，它会检查代币的`owner`是不是发起人，如果不是，就会抛出`TransferNotOwner`异常；如果是的话，就会转账。

##### Require

`require`命令是`solidity 0.8版本`之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。它很好用，唯一的缺点就是`gas`随着描述异常的字符串长度增加，比`error`命令要高。使用方法：`require(检查条件，"异常的描述")`，当检查条件不成立的时候，就会抛出异常。

我们用`require`命令重写一下上面的`transferOwner1`函数：

```solidity
function transferOwner2(uint256 tokenId, address newOwner) public {
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    _owners[tokenId] = newOwner;
}
```



##### Assert

`assert`命令一般用于程序员写程序`debug`，因为它不能解释抛出异常的原因（比`require`少个字符串）。它的用法很简单，`assert(检查条件）`，当检查条件不成立的时候，就会抛出异常。

我们用`assert`命令重写一下上面的`transferOwner1`函数：

```solidity
function transferOwner3(uint256 tokenId, address newOwner) public {
    assert(_owners[tokenId] == msg.sender);
    _owners[tokenId] = newOwner;
}
```

##### 三种方法的gas比较

我们比较一下三种抛出异常的`gas`消耗，通过remix控制台的Debug按钮，能查到每次函数调用的`gas`消耗分别如下： （使用0.8.17版本编译）

1. **`error`方法`gas`消耗**：24457 (**加入参数后`gas`消耗**：24660)
2. **`require`方法`gas`消耗**：24755
3. **`assert`方法`gas`消耗**：24473
4. **Require > assert > error**

我们可以看到，`error`方法`gas`最少，其次是`assert`，`require`方法消耗`gas`最多！因此，`error`既可以告知用户抛出异常的原因，又能省`gas`，大家要多用！（注意，由于部署测试时间的不同，每个函数的`gas`消耗会有所不同，但是比较结果会是一致的。）

<!-- Content_END -->
