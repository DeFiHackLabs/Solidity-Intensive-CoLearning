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


### 2024.10.04

#### 函数重载

##### 重载定义

`Solidity`中允许函数进行重载（`overloading`），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，`Solidity`不允许修饰器（`modifier`）重载。

##### 函数重载

举个例子，我们可以定义两个都叫`saySomething()`的函数，一个没有任何参数，输出`"Nothing"`；另一个接收一个`string`参数，输出这个`string`。

```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```



最终重载函数在经过编译器编译后，由于不同的参数类型，都变成了不同的函数选择器（selector）。关于函数选择器的具体内容可参考[WTF Solidity极简入门: 29. 函数选择器Selector](https://github.com/AmazingAng/WTF-Solidity/tree/main/29_Selector)。

以 `Overloading.sol` 合约为例，在 Remix 上编译部署后，分别调用重载函数 `saySomething()` 和 `saySomething(string memory something)`，可以看到他们返回了不同的结果，被区分为不同的函数。



![16-1.jpg](https://www.wtf.academy/assets/images/16-1-02e5e7643e93251800ec337e341a58a4.jpg)



##### 实参匹配（Argument Matching）

在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。下面这个例子有两个叫`f()`的函数，一个参数为`uint8`，另一个为`uint256`：

```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```



我们调用`f(50)`，因为`50`既可以被转换为`uint8`，也可以被转换为`uint256`，因此会报错。

##### 总结

这一讲，我们介绍了`Solidity`中函数重载的基本用法：名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。



#### 库合约

`ERC721`的引用的库合约`Strings`为例介绍`Solidity`中的库合约（`Library`），并总结了常用的库合约。

库合约是一种特殊的合约，为了提升`Solidity`代码的复用性和减少`gas`而存在。库合约是一系列的函数合集，由大神或者项目方创作，咱们站在巨人的肩膀上，会用就行了。

他和普通合约主要有以下几点不同：

1. 不能存在状态变量
2. 不能够继承或被继承
3. 不能接收以太币
4. 不可以被销毁

需要注意的是，库合约重的函数可见性如果被设置为`public`或者`external`，则在调用函数时会触发一次`delegatecall`。而如果被设置为`internal`，则不会引起。对于设置为`private`可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

##### Strings库合约

`Strings库合约`是将`uint256`类型转换为相应的`string`类型的代码库，样例代码如下：

```solidity
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



他主要包含两个函数，`toString()`将`uint256`转为`string`，`toHexString()`将`uint256`转换为`16进制`，在转换为`string`。

##### 如何使用库合约

我们用`Strings`库合约的`toHexString()`来演示两种使用库合约中函数的办法。

1. 利用using for指令

   指令`using A for B;`可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库`A`中的函数会自动添加为`B`类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数：

   ```solidity
   // 利用using for指令
   using Strings for uint256;
   function getString1(uint256 _number) public pure returns(string memory){
       // 库合约中的函数会自动添加为uint256型变量的成员
       return _number.toHexString();
   }
   ```

   

2. 通过库合约名称调用函数

   ```solidity
   // 直接通过库合约名调用
   function getString2(uint256 _number) public pure returns(string memory){
       return Strings.toHexString(_number);
   }
   ```

   

我们部署合约并输入`170`测试一下，两种方法均能返回正确的`16进制string` “0xaa”。证明我们调用库合约成功！



![成功调用库合约](https://images.mirror-media.xyz/publication-images/bzB_JDC9f5VWHRjsjQyQa.png?height=750&width=580)



##### 总结

这一讲，我们用`ERC721`的引用的库合约`Strings`为例介绍`Solidity`中的库合约（`Library`）。99%的开发者都不需要自己去写库合约，会用大神写的就可以了。我们只需要知道什么情况该用什么库合约。常用的有：

1. [Strings](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Strings.sol)：将`uint256`转换为`String`
2. [Address](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Address.sol)：判断某个地址是否为合约地址
3. [Create2](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Create2.sol)：更安全的使用`Create2 EVM opcode`
4. [Arrays](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/4a9cc8b4918ef3736229a5cc5a310bdc17bf759f/contracts/utils/Arrays.sol)：跟数组相关的库合约



### 2024.10.05

`import`语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。本教程将向你介绍如何在Solidity中使用`import`语句。

#### `import`用法

- 通过源文件相对位置导入，例子：

  ```text
  文件结构
  ├── Import.sol
  └── Yeye.sol
  
  // 通过文件相对位置import
  import './Yeye.sol';
  ```

  

- 通过源文件网址导入网上的合约的全局符号，例子：

  ```text
  // 通过网址引用
  import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
  ```

  

- 通过`npm`的目录导入，例子：

  ```solidity
  import '@openzeppelin/contracts/access/Ownable.sol';
  ```

  

- 通过指定`全局符号`导入合约特定的全局符号，例子：

  ```solidity
  import {Yeye} from './Yeye.sol';
  ```

  

- 引用(`import`)在代码中的位置为：在声明版本号之后，在其余代码之前。

#### 测试导入结果

我们可以用下面这段代码测试是否成功导入了外部源代码：

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

contract Import {
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



![result](https://www.wtf.academy/assets/images/18-1-be3039b3dda4b85f9a3197fbe6102abb.png)

#### 代码块

```solidity
// 创建Good.sol文件

// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

struct Goods {
    bool good;
}

function sayGood() pure returns(string memory){
    return "say: good!";
}


contract Good {

    event GoogWorld(string);


    function world() external {
        emit GoogWorld("Hello Import!");
    }
}
```

```solidity
// 在文件中引用Goods.sol文件中的内容

// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

// 引入本地文件
// import "./Good.sol";
// import { Good } from "./Good.sol";
// import { Good as myGood } from "./Good.sol";
import * as myGood2 from "./Good.sol";

// 可以直接引入目标文件中的struct，function，和contract
import { Good, Goods, sayGood } from "./Good.sol";

// 也可以直接引入网络文件
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 或者npm文件
import '@openzeppelin/contracts/access/Ownable.sol';

contract Import {
    
    function callGood() external {
        // Good good = new Good();
        // myGood good = new myGood();
        myGood2.Good good = new myGood2.Good();
        good.world(); // 以上三种方式都可以正常输出Good.sol中的 Hello Import!
    }

    // 使用引入的struct
    function callStructGood() external pure returns(bool) {
        Goods memory goods = Goods(true); 
        return goods.good; // 调用Goods中的struct里的good 返回的是true
    }

    // 使用引入的function
    function callFnGoods() external pure returns(string memory) {
        return sayGood(); // 输出Goods文件中的sayGood犯法中的内容 say: good!
    }
}
```

#### 总结

这一讲，我们介绍了利用`import`关键字导入外部源代码的方法。通过`import`关键字，可以引用我们写的其他文件中的合约或者函数，也可以直接导入别人写好的代码，非常方便。

---
---
---

### 2024.10.06

#### 接收ETH

`Solidity`支持两种特殊的回调函数，`receive()`和`fallback()`，他们主要在两种情况下被使用：

1. 接收ETH
2. 处理合约中不存在的函数调用（代理合约proxy contract）

注意⚠️：在Solidity 0.6.x版本之前，语法上只有 `fallback()` 函数，用来接收用户发送的ETH时调用以及在被调用函数签名没有匹配到时，来调用。 0.6版本之后，Solidity才将 `fallback()` 函数拆分成 `receive()` 和 `fallback()` 两个函数。

我们这一讲主要讲接收ETH的情况。

##### 接收ETH函数 receive

`receive()`函数是在合约收到`ETH`转账时被调用的函数。一个合约最多有一个`receive()`函数，声明方式与一般函数不一样，不需要`function`关键字：`receive() external payable { ... }`。`receive()`函数不能有任何的参数，不能返回任何值，必须包含`external`和`payable`。

当合约接收ETH的时候，`receive()`会被触发。`receive()`最好不要执行太多的逻辑因为如果别人用`send`和`transfer`方法发送`ETH`的话，`gas`会限制在`2300`，`receive()`太复杂可能会触发`Out of Gas`报错；如果用`call`就可以自定义`gas`执行更复杂的逻辑（这三种发送ETH的方法我们之后会讲到）。

我们可以在`receive()`里发送一个`event`，例如：

```solidity
// 定义事件
event Received(address Sender, uint Value);
// 接收ETH时释放Received事件
receive() external payable {
    emit Received(msg.sender, msg.value);
}
```



有些恶意合约，会在`receive()` 函数（老版本的话，就是 `fallback()` 函数）嵌入恶意消耗`gas`的内容或者使得执行故意失败的代码，导致一些包含退款和转账逻辑的合约不能正常工作，因此写包含退款等逻辑的合约时候，一定要注意这种情况。

##### 回退函数 fallback

`fallback()`函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约`proxy contract`。`fallback()`声明时不需要`function`关键字，必须由`external`修饰，一般也会用`payable`修饰，用于接收ETH:`fallback() external payable { ... }`。

我们定义一个`fallback()`函数，被触发时候会释放`fallbackCalled`事件，并输出`msg.sender`，`msg.value`和`msg.data`:

```solidity
event fallbackCalled(address Sender, uint Value, bytes Data);

// fallback
fallback() external payable{
    emit fallbackCalled(msg.sender, msg.value, msg.data);
}
```



##### receive和fallback的区别

`receive`和`fallback`都能够用于接收`ETH`，他们触发的规则如下：

```text
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



简单来说，合约接收`ETH`时，`msg.data`为空且存在`receive()`时，会触发`receive()`；`msg.data`不为空或不存在`receive()`时，会触发`fallback()`，此时`fallback()`必须为`payable`。

`receive()`和`payable fallback()`均不存在的时候，向合约**直接**发送`ETH`将会报错（你仍可以通过带有`payable`的函数向合约发送`ETH`）。

##### 演示

1. 首先在 Remix 上部署合约 "Fallback.sol"。

2. "VALUE" 栏中填入要发送给合约的金额（单位是 Wei），然后点击 "Transact"。

   

   ![19-1.jpg](https://www.wtf.academy/assets/images/19-1-4ba34e6d9cbb74a98a3c8affd59bc583.jpg)

   

3. 可以看到交易成功，并且触发了 "receivedCalled" 事件。

   

   ![19-2.jpg](https://www.wtf.academy/assets/images/19-2-b933741438ce18210739446f85b8e3c4.jpg)

   

4. "VALUE" 栏中填入要发送给合约的金额（单位是 Wei），"CALLDATA" 栏中填入随意编写的`msg.data`，然后点击 "Transact"。

   

   ![19-3.jpg](https://www.wtf.academy/assets/images/19-3-83c411c3270d886d6ea0535c4cc9660d.jpg)

   

5. 可以看到交易成功，并且触发了 "fallbackCalled" 事件。

   

   ![19-4.jpg](https://www.wtf.academy/assets/images/19-4-a6bbcb103838f43fe8987b95606b8e27.jpg)

   

##### 总结

这一讲，我介绍了`Solidity`中的两种特殊函数，`receive()`和`fallback()`，他们主要在两种情况下被使用，处理接收`ETH`和代理合约`proxy contract`。



---



#### 发送ETH

`Solidity`有三种方法向其他合约发送`ETH`，他们是：`transfer()`，`send()`和`call()`，其中`call()`是被鼓励的用法。

##### 接收ETH合约

我们先部署一个接收`ETH`合约`ReceiveETH`。`ReceiveETH`合约里有一个事件`Log`，记录收到的`ETH`数量和`gas`剩余。还有两个函数，一个是`receive()`函数，收到`ETH`被触发，并发送`Log`事件；另一个是查询合约`ETH`余额的`getBalance()`函数。

```solidity
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



部署`ReceiveETH`合约后，运行`getBalance()`函数，可以看到当前合约的`ETH`余额为`0`。



![20-1](https://www.wtf.academy/assets/images/20-1-b18baa5867c909e527eca6852945ad46.png)



##### 发送ETH合约

我们将实现三种方法向`ReceiveETH`合约发送`ETH`。首先，先在发送ETH合约`SendETH`中实现`payable`的`构造函数`和`receive()`，让我们能够在部署时和部署后向合约转账。

```solidity
contract SendETH {
    // 构造函数，payable使得部署的时候可以转eth进去
    constructor() payable{}
    // receive方法，接收eth时被触发
    receive() external payable{}
}
```



##### transfer

- 用法是`接收方地址.transfer(发送ETH数额)`。
- `transfer()`的`gas`限制是`2300`，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。
- `transfer()`如果转账失败，会自动`revert`（回滚交易）。

代码样例，注意里面的`_to`填`ReceiveETH`合约的地址，`amount`是`ETH`转账金额：

```solidity
// 用transfer()发送ETH
function transferETH(address payable _to, uint256 amount) external payable{
    _to.transfer(amount);
}
```



部署`SendETH`合约后，对`ReceiveETH`合约发送ETH，此时`amount`为10，`value`为0，`amount`>`value`，转账失败，发生`revert`。



![20-2](https://www.wtf.academy/assets/images/20-2-572c8ac0dfa42d4ea7fc62de0ff1c5af.png)



此时`amount`为10，`value`为10，`amount`<=`value`，转账成功。



![20-3](https://www.wtf.academy/assets/images/20-3-c48a1c9f41ff2a53095bbf4d0b7767b7.png)



在`ReceiveETH`合约中，运行`getBalance()`函数，可以看到当前合约的`ETH`余额为`10`。



![20-4](data:image/png;base64,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)



##### send

- 用法是`接收方地址.send(发送ETH数额)`。
- `send()`的`gas`限制是`2300`，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。
- `send()`如果转账失败，不会`revert`。
- `send()`的返回值是`bool`，代表着转账成功或失败，需要额外代码处理一下。

代码样例：

```solidity
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



对`ReceiveETH`合约发送ETH，此时`amount`为10，`value`为0，`amount`>`value`，转账失败，因为经过处理，所以发生`revert`。



![20-5](https://www.wtf.academy/assets/images/20-5-cb457285c7185c438995bfcc95b6a01d.png)



此时`amount`为10，`value`为11，`amount`<=`value`，转账成功。



![20-6](https://www.wtf.academy/assets/images/20-6-1ae2f81d902c618059d813e5b16cbe4c.png)

##### call

- 用法是`接收方地址.call{value: 发送ETH数额}("")`。
- `call()`没有`gas`限制，可以支持对方合约`fallback()`或`receive()`函数实现复杂逻辑。
- `call()`如果转账失败，不会`revert`。
- `call()`的返回值是`(bool, bytes)`，其中`bool`代表着转账成功或失败，需要额外代码处理一下。

代码样例：

```solidity
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



对`ReceiveETH`合约发送ETH，此时`amount`为10，`value`为0，`amount`>`value`，转账失败，因为经过处理，所以发生`revert`。



![20-7](https://www.wtf.academy/assets/images/20-7-bbfe1e7134676767c0a6c9612165ea9e.png)



此时`amount`为10，`value`为11，`amount`<=`value`，转账成功。



![20-8](https://www.wtf.academy/assets/images/20-8-5c25a6d4556ce624ff27752f24e85d4a.png)



运行三种方法，可以看到，他们都可以成功地向`ReceiveETH`合约发送`ETH`。

##### 总结

这一讲，我们介绍`Solidity`三种发送`ETH`的方法：`transfer`，`send`和`call`。

- `call`没有`gas`限制，最为灵活，是最提倡的方法；
- `transfer`有`2300 gas`限制，但是发送失败会自动`revert`交易，是次优选择；
- `send`有`2300 gas`限制，而且发送失败不会自动`revert`交易，几乎没有人用它。

##### 代码示例

```solidity
// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;

contract getEth {
    // 接受ETH
    event Receive(uint amount);
    event Fallback(uint amount);

    receive() external payable { 
        emit Receive(msg.value);
    }

    fallback() external payable {
        emit Fallback(msg.value);
    }

///------------------------------------------------------------
///------------------------------------------------------------

    // 发送ETH
    constructor() payable  {
        
    }
    // transfer方式
    function transferETH() external {
        payable(msg.sender).transfer(1 ether);
    }

    // send方式
    function sendETH() external {
        // send会返回一个bool值，需要接收后，进行判断
        bool success = payable(msg.sender).send(1 ether);
        require(success);
    }

    // call方式（推荐）
    function callETH() external {
        // 固定写法
        (bool success,) = msg.sender.call{value: 1 ether}("");
        require(success);
    }   
}
```





### 2024.10.07

#### 调用已部署合约

在`Solidity`中，一个合约可以调用另一个合约的函数，这在构建复杂的DApps时非常有用。本教程将会介绍如何在已知合约代码（或接口）和地址的情况下，调用已部署的合约。

#### 目标合约（外部合约）

我们先写一个简单的合约`OtherContract`，用于被其他合约调用。

```solidity
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



这个合约包含一个状态变量`_x`，一个事件`Log`在收到`ETH`时触发，三个函数：

- `getBalance()`: 返回合约`ETH`余额。
- `setX()`: `external payable`函数，可以设置`_x`的值，并向合约发送`ETH`。
- `getX()`: 读取`_x`的值。

#### 调用`OtherContract`合约

我们可以利用合约的地址和合约代码（或接口）来创建合约的引用：`_Name(_Address)`，其中`_Name`是合约名，应与合约代码（或接口）中标注的合约名保持一致，`_Address`是合约地址。然后用合约的引用来调用它的函数：`_Name(_Address).f()`，其中`f()`是要调用的函数。

下面我们介绍4个调用合约的例子，在remix中编译合约后，分别部署`OtherContract`和`CallContract`：



![deploy contract0 in remix](https://www.wtf.academy/assets/images/21-1-9c522c370dfc53d1a0c273716f949c9e.png)





![deploy contract1 in remix](https://www.wtf.academy/assets/images/21-2-a3c672e6dca937bf09dc3dfe5a421534.png)





![deploy contract2 in remix](https://www.wtf.academy/assets/images/21-3-dd0cfc401d8462761c9b740ec21aa994.png)



##### 1. 传入合约地址

我们可以在函数里传入目标合约地址，生成目标合约的引用，然后调用目标函数。以调用`OtherContract`合约的`setX`函数为例，我们在新合约中写一个`callSetX`函数，传入已部署好的`OtherContract`合约地址`_Address`和`setX`的参数`x`：

```solidity
function callSetX(address _Address, uint256 x) external{
    OtherContract(_Address).setX(x);
}
```



复制`OtherContract`合约的地址，填入`callSetX`函数的参数中，成功调用后，调用`OtherContract`合约中的`getX`验证`x`变为123



![call contract1 in remix](https://www.wtf.academy/assets/images/21-4-89e705ffc18c8f90063c922e7504b31e.png)





![call contract2 in remix](https://www.wtf.academy/assets/images/21-5-52866e87f467b4ebad52d6d00d4d2744.png)



##### 2. 传入合约变量

我们可以直接在函数里传入合约的引用，只需要把上面参数的`address`类型改为目标合约名，比如`OtherContract`。下面例子实现了调用目标合约的`getX()`函数。

**注意**：该函数参数`OtherContract _Address`底层类型仍然是`address`，生成的`ABI`中、调用`callGetX`时传入的参数都是`address`类型

```solidity
function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}
```



复制`OtherContract`合约的地址，填入`callGetX`函数的参数中，调用后成功获取`x`的值



![call contract3 in remix](https://www.wtf.academy/assets/images/21-6-615b6ab5f73c18a1c4a7a7d0be5f7228.png)



##### 3. 创建合约变量

我们可以创建合约变量，然后通过它来调用目标函数。下面例子，我们给变量`oc`存储了`OtherContract`合约的引用：

```solidity
function callGetX2(address _Address) external view returns(uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
```



复制`OtherContract`合约的地址，填入`callGetX2`函数的参数中，调用后成功获取`x`的值



![call contract4 in remix](https://www.wtf.academy/assets/images/21-7-ab9a5e3d84b27006392eb368b1e93d2d.png)



##### 4. 调用合约并发送`ETH`

如果目标合约的函数是`payable`的，那么我们可以通过调用它来给合约转账：`_Name(_Address).f{value: _Value}()`，其中`_Name`是合约名，`_Address`是合约地址，`f`是目标函数名，`_Value`是要转的`ETH`数额（以`wei`为单位）。

`OtherContract`合约的`setX`函数是`payable`的，在下面这个例子中我们通过调用`setX`来往目标合约转账。

```solidity
function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
}
```



复制`OtherContract`合约的地址，填入`setXTransferETH`函数的参数中，并转入10ETH



![call contract5 in remix](https://www.wtf.academy/assets/images/21-8-3566ee52a32b536dded77112c6599bdb.png)



转账后，我们可以通过`Log`事件和`getBalance()`函数观察目标合约`ETH`余额的变化。



![call contract6 in remix](https://www.wtf.academy/assets/images/21-9-d90c3bad37dd4d77acbd2ea8b695242e.png)

#### 代码示例

```solidity
// SPDX License-Identifier: MIT
pragma solidity ^0.8.19;


// 创建一个其他合约
contract OtherContract {
    uint256 private  _x = 0; // 状态变量

    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);

    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以太壮状态比变量_x的函数，并且可以往合约转ETh（payable）
    function setX(uint256 x) external payable {
        _x = x;
        // 如果转入ETH，则释放LOG事件
        if(msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取_x
    function getX() external view returns(uint x) {
        x = _x;
    }
}

// 在当前合约中，调用OtherContract合约中的方法，一共有4种方式
contract CallOtherContract {
    
    function setOneX(address _address, uint256 x) external payable {
        OtherContract(_address).setX(x);
    }

    function setTwoX(OtherContract _address, uint256 x) external payable {
        _address.setX(x);
    }

    function setThreeX(address _address, uint256 x) external payable {
        OtherContract call = OtherContract(_address);
        call.setX(x);
    }

    function setFourX(address _address, uint256 x) external payable {
        OtherContract(_address).setX{value: msg.value}(x);
    }

}
```



#### 总结

这一讲，我们介绍了如何通过目标合约代码（或接口）和地址来创建合约的引用，从而调用目标合约的函数。

---
---
---



---

<!-- Content_END -->
