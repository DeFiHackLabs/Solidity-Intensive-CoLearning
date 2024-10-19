---
timezone: America/Los_Angeles
---


# Ye

1. 自我介绍
     - 清华-南加大 Communication Data Science 25'硕士在读，链上数据分析2年经验，Dune [@wyeeeh](https://dune.com/wyeeeh)。因为对链上数据的分析离不开合约解析，希望通过共学计划掌握Solidity的基础开发知识，能更好读懂合约的function和event。

2. 你认为你会完成本次残酷学习吗？
   - 有激励就有野心，之前完成过Sixdegree Lab和BuidlerDAO发起的Dune Analytics共学计划。
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### WTF Academy Solidity 101.1 Hello Web3 (三行代码)
- IDE：[Remix IDE](https://remix.ethereum.org)
##### 合约
- 合约是 Solidity 中的一种结构，用于定义智能合约的代码和数据。
- 许可：如果不写许可，编译时会出现警告（warning），但程序仍可运行。
- 注释：单行注释 `//` ，多行注释 `/* */`
- 状态变量：状态变量是合约中声明的变量，用于存储合约的状态。
- 函数：函数是合约中用于执行特定任务的代码块。
- 函数修饰器：函数修饰器用于修改函数的行为。
- 事件：事件是合约中用于记录某些特定事件的代码块。
- 错误：错误是合约中用于记录某些特定错误信息的代码块。
- 部署：`Ctrl + S` 
  - 默认情况下，Remix 会使用 Remix 虚拟机（以前称为 JavaScript 虚拟机）来模拟以太坊链，运行智能合约，类似在浏览器里运行一条测试链。Remix 还会为你分配一些测试账户，每个账户里有 100 ETH（测试代币）
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 指定编译器版本

// 创建合约（contract），并声明合约名为 HelloWeb3，状态变量为 _string
contract HelloWeb3 {
    string public _string = "Hello Web3!"; 
}
```
- 变量名下划线
  - 私有变量：通常在变量名前加下划线，以表明这些变量是私有的。
  - 函数参数：有时在函数参数名前加下划线，以避免与状态变量名称冲突。
  - 状态变量：有时在状态变量名前加下划线，以便与局部变量区分开来。
  - 在例子中，_string 是一个状态变量，加下划线可能是为了与其他变量区分开来。
##### 测验结果
  - 75/100
  - 100/100

### 2024.09.24
#### WTF Academy Solidity 101.2 值类型

##### 值类型：Value Type，用于存储具体的值。
- 布尔类型：`true` 和 `false`。
- 整数类型：整数类型包括有符号整数（int）和无符号整数（uint）。

- 地址类型：地址类型用于存储以太坊地址。
  - 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
  - payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账。
- 字节数组
  - 定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 bytes1, bytes8, bytes32 等类型。定长字节数组最多存储 32 bytes 数据，即bytes32。
  - 不定长字节数组: 属于引用类型（之后的章节介绍），数组长度在声明之后可以改变，包括 bytes 等。
- 枚举 enum
  - 枚举（enum）是 Solidity 中用户定义的数据类型。它主要用于为 uint 分配名称，使程序易于阅读和维护。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ValueTypes {
    // 布尔值
    bool public _bool = true; 

    // 布尔运算
    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等

    // 整型
    int public _int = -1; // 整数，包括负数
    uint public _uint = 1; // 正整数
    uint256 public _number = 20220330; // 256位正整数

    // 整数运算
    uint256 public _number1 = _number + 1; 
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
    
    // bytes32 是一个固定长度的字节数组，长度为 32 字节。"MiniSolidity" 是一个字符串字面量，它会被自动转换为字节数组并存储在 _byte32 中。由于 bytes32 的长度是 32 字节，而 "MiniSolidity" 的长度小于 32 字节，剩余的字节会被填充为零。

    bytes1 public _byte = _byte32[0]; 
    // _byte 是 _byte32 的第一个字节，因此 _byte 的值为 "M"。

    // 枚举 enum
    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy; // 实际上在内存中存储的是整数0

    // enum可以和uint显式的转换，返回当前action的整数值
    function enumToUint() external view returns(uint){
        return uint(action);
    }

}

//deploy后可以在VALUETYPES找到声明的变量。
```

##### 测验错题
  1. solidity中数值类型(Value Type)不包括float
  2. 下列代码的意思是
   
      ```solidity
      address payable addr;
      addr.transfer(1);
      ```
     - `address payable addr;`：声明了一个可支付的以太坊地址变量 `addr`。`payable` 关键字表示这个地址可以接收以太币（Ether）。
     - `addr.transfer(1);`：将 1 wei（以太坊的最小单位）转账到 `addr` 地址。`transfer` 方法用于从合约中转移以太币到指定的 `payable` 地址。
     - 这段代码定义了一个可以接收以太币的地址，并向该地址转账 1 wei。
  3. bytes4类型具有8个16进制位

### 2024.09.25
#### WTF Academy Solidity 101.3 函数

##### Solidity中函数的形式

  ```Solidity
  function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
  ```
 ##### function：声明函数
  - `<function name>`：函数名。
  - `(<parameter types>)`：参数，输入到函数的变量类型和名称
  - `{internal|external|public|private}`：函数可见性说明符，共有4种。
    - public：内部和外部均可见。
    - private：只能从本合约内部访问，继承的合约也不能使用。
    - external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
    - internal: 只能从合约内部访问，继承的合约可以用。
    - 注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。
    - 注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
  - `[pure|view|payable]`：决定函数权限/功能的关键字。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。pure 和 view 的介绍见下一节。
  - `[returns ()]`：函数返回的变量类型和名称。
##### Pure和View
  - 包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的。
    - pure 函数既不能读取也不能写入链上的状态变量。
    - view函数能读取但也不能写入状态变量。
  - 非 pure 或 view 的函数既可以读取也可以写入状态变量。合约中非 pure/view 函数调用 pure/view 函数时需要付gas。
##### internal v.s. external
  - `internal` 函数只能由合约内部调用
  - 我们必须再定义一个 `external` 的 `minusCall()` 函数，通过它间接调用内部的 `minus()` 函数。
##### payable
  - 运行的时候可以给合约转入 ETH。
##### 测验结果
  - 100/100

### 2024.09.26
#### WTF Academy Solidity 101.4 函数输出

##### 返回值：return 和 returns
- return 和 returns 都可以用于返回值，但它们的使用场景不同。
  - `returns`：跟在函数名后面，用于声明返回的变量类型及变量名。
  - `return`：用于函数主体中，返回指定的变量。

```solidity
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
```
- returns(uint256, bool, uint256[3] memory) 表示该函数将返回3个值：
  - 第一个是 uint256 类型。
  - 第二个是 bool 类型。
  - 第三个是长度为3的 uint256 数组。
- return (1, true, [uint256(1), 2, 5]) 实际返回的值是：
  - 1 作为第一个返回值，类型为 uint256。
  - true 作为第二个返回值，类型为 bool。
  - [1, 2, 5] 作为第三个返回值，类型为 uint256[3]。
- memory 修饰符用来声明数据的存储位置。
  - 在Solidity中，数组作为返回值时，通常需要指定存储位置。可以是 memory（临时存储）或 storage（持久存储在区块链上）。函数返回的数组通常存储在内存中，因此我们使用 memory 修饰符。
- 类型转换
  - 在Solidity中，类型转换通常用于将一个数据类型转换为另一个数据类型。
  - 假设有一个数组，要求所有元素都必须是 uint256 类型，如：
    ```solidity
    uint256[3] memory myArray;
    ```

    但输入了以下内容：

    ```solidity
    myArray = [1, 2, 5];
    ```

    编译器会认为 1, 2, 5 都是最小的适合类型（可能是 uint8）。然而，数组的类型被声明为 uint256，因此编译器会提示类型不匹配。为了避免这种错误，你需要显示地告诉编译器，第一个元素 1 是 uint256 类型：

    ```solidity
    myArray = [uint256(1), 2, 5];
    ```

    这样，编译器就知道，所有元素的类型都是 uint256，符合数组的要求。

##### 命名式返回
- 用 `returns(uint256 _number, bool _bool, uint256[3] memory _array)` 声明了返回变量类型以及变量名。这样，在主体中只需为变量 `_number`、`_bool`和`_array` 赋值，即可自动返回。

```solidity
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}

// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
```

##### 解构式赋值
- 读取所有返回值：声明变量，然后将要赋值的变量用`,`隔开，按顺序排列。
- 读取部分返回值：声明要读取的返回值对应的变量，不读取的留空。我们只读取`_bool`，而不读取返回的`_number`和`_array`

```solidity
uint256 _number;
bool _bool;
uint256[3] memory _array;

// 读取所有返回值
(_number, _bool, _array) = returnNamed();

// 读取部分返回值
(, _bool2, ) = returnNamed();
```

##### 测验结果
- 100/100


### 2024.09.27
#### WTF Academy Solidity 101.5 变量数据存储和作用域 storage/memory/calldata

##### 引用类型(Reference Type)
- 包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要**声明数据存储的位置**。

##### 数据位置
- 不同存储位置的`gas`成本不同。
  - `storage`类型的数据存在链上，类似计算机的硬盘，消耗`gas`多；
  - `memory`和`calldata`类型的临时存在内存里，消耗`gas`少。
1. `storage`：合约里的状态变量默认都是`storage`，存储在链上。

1. `memory`：函数里的参数和临时变量一般用`memory`，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，**必须加memory修饰**，例如：string, bytes, array和自定义结构。

2. `calldata`：和`memory`类似，存储在内存中，不上链。与`memory`的不同点在于`calldata`变量不能修改（`immutable`），一般用于函数的参数。

##### 赋值规则
| 赋值类型 | 是否为引用 | 备注 |
| --- | --- | --- |
| **Storage** ↔ **Storage** | 引用 | 除非赋值给状态变量或存储结构体成员，创建副本 |
| **Memory** ↔ **Memory** | 引用 | Memory 变量共享同一数据，修改会互相影响 |
| **Storage** → **Memory** | 独立副本 | 从 `storage` 到 `memory` 创建副本，修改 memory 变量不会影响 `storage` 数据。 |
| **Memory** → **Storage** | 独立副本 | 从 `memory` 到 `storage` 创建副本 |
| **Calldata** → **Memory** | 独立副本 | `calldata` 到 `memory` 创建副本 |
| **Calldata** → **Storage** | 独立副本 | `calldata` 到 `storage` 创建副本 |

##### 变量的作用域
1. 状态变量（state variable）
     - 状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。
2. 局部变量（local variable）
     - 局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。
3. 全局变量（global variable）
     - 全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用
     - 时间单位

##### 测验结果
- 100/100

### 2024.09.28
#### WTF Academy Solidity 101.6 引用类型, array, struct

##### 数组 Array
- 存储在 `storage` 的数组：
    - **可变长度数组**（即未指定固定长度的 `T[]`）是可以动态扩展和缩减的，例如通过 `push()` 和 `pop()` 操作。
    - **固定长度数组**（如 `uint[8]`）在 `storage` 中长度是固定的，初始化后不能改变其长度。
- 存储在 `memory` 的数组：
    - **可变长度数组**在 `memory` 中一旦初始化，**长度是固定的**，不能在运行时再改变长度。因此，`memory` 数组在初始化时必须指定其长度，之后无法扩展或缩减。

**数组成员**
- `length`: 可以读取数组的长度。`memory`数组的长度在创建后是固定的，`storage` 数组可以通过直接赋值来修改数组长度。
- `push()`: 向 `storage` 中的可变长度数组添加一个`0`元素，并返回该元素的引用。
- `push(x)`: 向 `storage` 中的可变长度数组添加一个`x`元素，并自动增加数组的长度。
- `pop()`: 删除 `storage` 数组的最后一个元素，并减少数组的长度。

- 注意事项
  - `storage` 数组：支持 `.push()`、`.pop()` 和 `.length` 成员，可以动态增加和减少长度。
  - `memory` 数组的操作相对简单，因为它们的长度一旦初始化后无法改变。因此，只有读取和修改数组元素的功能，没有 `push` 和 `pop` 操作。
  - 对于固定长度的数组（无论在 `storage` 还是 `memory`），它们的长度在编译时就确定了，因此无法使用 `.push()` 或 `.pop()` 操作。

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageArrayLength {
    uint[] public array;

    // 获取数组长度
    function getLength() public view returns (uint) {
        return array.length;
    }

    // 修改数组长度
    function setLength(uint newLength) public {
        array.length = newLength;
    }
}

contract StorageArrayPush {
    uint[] public array;

    // 向数组中添加元素
    function addElement(uint _value) public {
        array.push(_value);
    }

    uint[] public numbers;

    function addElement() public {
        uint storageElement = numbers.push(); // 添加一个0元素并返回其引用
        numbers[numbers.length - 1] = 42;     // 可以通过引用直接修改最后一个元素
      }
}
```

##### 结构体 struct
`struct` 是 Solidity 中用于定义自定义类型的关键字。每个结构体可以包含不同类型的变量，称为字段（fields），它们可以是基本类型（如 `uint`、`bool` 等）或引用类型（如数组、映射等）。
1. **定义结构体**
     - 这是为了创建一种新的数据类型，类似于定义一个模版。定义结构体是告诉 Solidity，接下来可以使用这种新的自定义类型，类似于在其他编程语言中定义一个类（class）或数据类型。
    ```solidity
    // 定义一个名为 Student 的结构体
    struct Student {
        uint256 id;     // 学生ID
        uint256 score;  // 学生分数
    }
    ```

2. **声明结构体变量**
    - 这是在定义的结构体类型基础上创建一个实际的变量，并分配内存。声明结构体变量后，可以使用它来存储和操作数据。
      ```solidity
      Student student; // 声明一个 `Student` 结构体变量
      ```

3. **赋值方式**
    - `storage` 引用：在函数中创建一个指向状态变量的 `storage` 引用，可以直接修改该结构体。
      ```solidity
      function initStudent1() external {
          Student storage _student = student; // 指向 `student` 结构体的引用
          _student.id = 11;                   // 修改 `student` 的 id
          _student.score = 100;               // 修改 `student` 的 score
      }
      ```

      在这个例子中，`_student` 是对状态变量 `student` 的引用。通过修改 `_student`，你实际上是在修改原始 `student` 结构体。

    - 直接修改结构体字段：直接引用结构体变量并为其字段赋值。
      ```solidity
      function initStudent2() external {
          student.id = 1;        // 直接修改 `student` 的 id
          student.score = 80;     // 直接修改 `student` 的 score
      }
      ```
      在这种方法中，直接操作状态变量 `student`，而不需要创建中间的引用。
    - 构造函数式：利用构造函数风格的赋值方法为结构体赋值。
      ```solidity
      function initStudent3() external {
          student = Student(3, 90);  // 使用构造函数语法为 `student` 赋值
      }
      ```
      这种方法类似于函数调用，通过提供参数来一次性赋值结构体的所有字段。
    - `key-value` 形式赋值：这种方式允许通过 `key-value` 的形式为结构体赋值，特别适用于具有很多字段的结构体。
      ```solidity
      function initStudent4() external {
          student = Student({id: 4, score: 60});  // 通过键值对形式赋值
      }
      ```
      `key-value` 方式在参数顺序不重要或者字段较多时，能提高代码的可读性。

##### 测验结果
- 100/100


### 2024.09.29
#### WTF Academy Solidity 101.7 映射类型 mapping

##### 映射的声明

映射的基本格式为：

```solidity
mapping(_KeyType => _ValueType)
```

- **例子**：
    
    ```solidity
    mapping(uint => address) public idToAddress; // 将 id 映射到地址
    mapping(address => address) public swapPair; // 将一个地址映射到另一个地址
    ```

##### 映射的规则

- **规则1**：`_KeyType` 只能是 Solidity 内置的值类型（如 `uint`、`address` 等），而 `_ValueType` 可以是自定义类型。
    - **错误示例**：
        
        ```solidity
        struct Student {
            uint256 id;
            uint256 score;
        }
        mapping(Student => uint) public testVar; // 这会报错，因为Student是自定义的struct
        ```
        
- **规则2**：映射的存储位置必须是 `storage`，不能用作 `public` 函数的参数或返回值。
  - **映射不能作为 `memory` 或 `calldata` 类型的变量**：因为映射的结构依赖于区块链的存储模型，它无法直接被赋值为临时变量（`memory`）或传递给函数作为参数（`calldata`）。例如，不能像这样做：

    ```solidity
    function test(mapping(uint => address) memory tempMap) public {} // 错误
    ```
  - **映射不能作为函数参数或返回类型**：映射不能直接作为 `public` 或 `external` 函数的参数或返回类型。这是因为映射的数据不是像普通变量那样存储在内存中或通过函数参数传递。下面这个代码会报错：

    ```solidity
    // 错误示例：试图将映射作为函数参数或返回类型
    function returnMapping(mapping(uint => address) memory someMapping) public pure returns (mapping(uint => address) memory) {
        return someMapping; // 这是不允许的
    }
    ```
  - **为什么映射不能作为 `public` 函数的参数或返回类型？**
    - **映射记录的是一种关系**（键-值对），而不是单纯的值。当你试图传递或返回映射时，Solidity 无法有效处理这些键-值对的传递，因为映射依赖于区块链的存储结构，而不是内存或临时存储区域（如 `memory` 或 `calldata`）。
    - **映射在内部通过哈希函数处理**：每个键会通过 `keccak256` 函数生成一个存储位置，并且映射并不存储完整的键或值的列表。因此，映射无法像数组那样直接作为函数的参数或返回值。
- **规则3**：如果映射被声明为 `public`，Solidity 会自动生成一个 `getter` 函数，可以通过键来查询对应的值。正确用法如下：
    ```solidity
      pragma solidity ^0.8.0;

      contract MappingExample {
          // 映射必须是状态变量，存储在 storage 中
          mapping(uint => address) public idToAddress;

          // 函数可以修改映射，映射存储在 storage
          function setAddress(uint _id, address _addr) public {
              idToAddress[_id] = _addr; // 将 _id 对应的地址设置为 _addr
          }

          // 通过自动生成的 getter 函数来查询映射
          function getAddress(uint _id) public view returns (address) {
              return idToAddress[_id]; // 返回存储在映射中的地址
          }
      }
    ```
- **规则4**：添加键值对的语法为 `_Var[_Key] = _Value`。
    - **例子**：
        
        ```solidity
        function writeMap(uint _Key, address _Value) public {
            idToAddress[_Key] = _Value; // 将地址 _Value 存储在 idToAddress 映射中
        }
        
        ```
##### 原理
- **原理1**: 映射不储存任何键（`Key`）的信息，也没有 `length` 信息
  - **为什么不存储键？** 映射是通过哈希（hashing）的方式来定位和存取键对应的值。也就是说，它不直接存储键，而是通过计算哈希值来找到存储的值。因此，映射的本质是键和值的关系，而不是键的存储。
  - **映射 vs 数组**：映射是无序的，没有“长度”概念，无法直接遍历；而数组是有序的，可以通过索引查找特定位置的元素。
- **原理2**：映射使用 `keccak256(abi.encodePacked(key, slot))` 来计算值的偏移量，其中 `slot` 是映射变量定义时的插槽位置。
  1. **`key`（键）**：这是映射中的某个键，比如 `uint` 类型的 `1`。
  2. **`slot`（插槽）**：这是映射变量在 Solidity 合约中的位置，类似于它在合约中的地址或索引。插槽是 Solidity 合约的状态变量存储结构中的位置，它唯一标识每个映射或变量的存储地址。
  3. 通过 `keccak256(abi.encodePacked(key, slot))` 来计算具体的存储位置。这个哈希值就是键值对中的 `value` 的存储位置。
- **原理3**：所有未赋值的键的初始值都是各自类型的默认值（例如，`uint` 的默认值是 0）。
##### 示例代码
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingExample {
    // 声明一个映射
    mapping(uint => address) public idToAddress;

    // 写入映射
    function writeMap(uint _key, address _value) public {
        idToAddress[_key] = _value; // 将地址存入映射
    }

    // 查询映射
    function readMap(uint _key) public view returns (address) {
        return idToAddress[_key]; // 返回对应的地址
    }
}

```
##### 测验结果
- 100/100

### 2024.09.30
#### WTF Academy Solidity 101.8 变量初始值

##### 变量初始值
- 在Solidity中，声明但没赋值的变量都有它的初始值或默认值。
- 值类型初始值
  - `uint` 初始值为 `0`
  - `int` 初始值为 `0`
  - `bool` 初始值为 `false`
  - `address` 初始值为 `address(0)`
  - `bytes1` 到 `bytes32`（固定大小的 bytes）：0x00（对应长度的字节）
  - `enum` 初始值为 `0`
- 引用类型初始值
  - `bytes` 初始值为 `bytes("")`
  - `string` 初始值为 `""`
  - `struct` 初始值为 `struct` 的默认值
  - `array` 初始值为 `array(length => 0)`，即`[]`
  - `mapping` 初始值为 `mapping(key => value)` 的默认值
  
- `delete a`会让变量a的值变为初始值

##### 测验结果
- 80/100
- 100/100

##### 测验错题
- bytes1的初始值是`0x00`

### 2024.10.01
#### WTF Academy Solidity 101.9 常数 constant和immutable
- 这两个关键字在 Solidity 中都用于定义不可修改的变量，但它们有一些显著区别。
##### Constant
- **定义**: `constant` 变量必须在声明时就初始化，之后不能再改变其值。如果尝试修改，编译将失败。
- **存储**: `constant` 变量的值会在编译时被硬编码进字节码中，因此它们不占用合约的存储空间。这也意味着这些值不会因为部署合约而消耗额外的 `gas`。
- **应用场景**: 适用于那些在合约整个生命周期内都不会改变的常量值。

##### Immutable
- **定义**: `immutable` 变量与 `constant` 变量类似，它们的值也不可修改，但 `immutable` 变量可以在**构造函数中**进行初始化（赋值），而不必在声明时直接赋值。这使得 `immutable` 变量更加灵活。
- **存储**: 与 `constant` 不同，`immutable` 变量的值会被保存在合约的存储空间中。虽然它们在合约运行时不可修改，但因为它们的值是在部署时动态确定的，所以需要消耗 `gas` 来存储。
- **应用场景**: 当变量的值需要在部署时根据某些条件动态决定（如部署合约时的区块号或合约地址），但在合约运行期间又不希望这些值被修改时，适合使用 `immutable`。

  ```Solidity
  contract MyContract {
      uint256 public immutable DEPLOY_BLOCK;
      address public immutable OWNER;

      constructor() {
          DEPLOY_BLOCK = block.number;  // 部署时的区块号
          OWNER = msg.sender;           // 部署合约的地址
      }
  }
  ```
  在这个例子中，`DEPLOY_BLOCK` 和 `OWNER` 是 `immutable` 变量，它们的值在合约部署时由 `constructor` 初始化，并且一旦赋值就不能再改变。

##### **`constant` vs `immutable` 的具体区别**

| 特性 | `constant` | `immutable` |
| --- | --- | --- |
| **赋值时机** | 必须在声明时赋值 | 可以在声明时或构造函数中赋值 |
| **修改** | 无法修改 | 在构造函数中初始化后无法修改 |
| **存储位置** | 编译时直接写入字节码，不占用存储空间 | 值存储在合约存储中，部署时确定，消耗少量 `gas` |
| **使用场景** | 用于固定的、绝对不变的常量值 | 用于部署时动态确定、之后不可更改的值 |

##### 测验结果
- 80/100
- 100/100

##### 测验错题
**`immutable` 变量不能在声明时通过字符串字面量初始化**
- 在声明 `immutable` 变量时，如果试图直接用字符串（如 `"hello world"`）进行初始化，会报错。原因是 `string` 是一种 **引用类型**，它的值在内存或存储中会涉及更多的动态分配。
- `immutable` 变量的初始化需要在**运行时**进行，比如通过构造函数或函数调用来赋值。而**字符串字面量**在 Solidity 中不能直接作为 `immutable` 变量的初始化值，因为这种分配在编译期间还不能确定最终的内存位置。

**错误示例**

```solidity
// 报错：immutable 变量不能通过字符串字面量初始化
string immutable myString = "hello world";
```
**引用类型需要在构造函数或通过计算赋值**
- 由于 `immutable` 变量的初始化要在**运行时**进行，因此在声明引用类型的 `immutable` 变量时，应该通过构造函数初始化，而不是直接在声明时赋值。

**正确示例**

```solidity
contract MyContract {
    string immutable myString;

    // 通过构造函数初始化 immutable 变量
    constructor(string memory _input) {
        myString = _input;
    }
}
```
### 2024.10.02
#### WTF Academy Solidity 101.10 控制流

##### 逻辑控制
  1. `if-else`判断
      - **Solidity** 的 `if-else` 语法和 **Python** 几乎完全一样，只是需要使用 **大括号 `{}`** 来包围代码块，而 **Python** 是通过缩进来表示代码块的。
        ```Solidity
        // Solidity
        if (condition) {
            // 如果条件为真，执行此代码块
        } else {
            // 否则，执行此代码块
        }
        ```
        ```python
        # Python
        if condition:
            # 如果条件为真，执行此代码块
        else:
            # 否则，执行此代码块
        ```
  2. `for`循环
      - **Solidity** 使用 C 风格的 `for` 循环，需要明确地指定初始化、条件和增量/减量表达式。
        - 在 Solidity 中，循环条件 `(i < 10)` 每次迭代都会被检查，而增量 `i++` 在每次循环结束时执行。变量类型如 `uint` 必须在循环前定义。
      - **Python** 的 `for` 循环通常用于遍历列表或迭代器，语法更简洁。
        ```solidity
        // Solidity
        for (uint i = 0; i < 10; i++) {
            // 在每次迭代时，执行此代码块
        }
        ```

        **Python 示例**：

        ```python
        # Python
        for i in range(10):
            # 在每次迭代时，执行此代码块
        ```
  3. `while`循环
      - **Solidity** 和 **Python** 的 `while` 循环也是相似的，但 **Solidity** 需要用 `{}` 来定义代码块。
        ```solidity
        // Solidity
        uint i = 0;
        while (i < 10) {
            // 执行代码块
            i++;
        }
        ```
        ```python
        # Python
        i = 0
        while i < 10:
            # 执行代码块
            i += 1

      ```
  4. `do-while`循环
      - **Solidity** 中有 `do-while` 循环，这是 **Python** 没有的语法结构。`do-while` 循环会先执行一次循环体，然后再检查条件。
        - **`do-while` 的特点**：即使条件最开始不成立，代码块也会执行一次。
        ```solidity
        // Solidity
        uint i = 0;
        do {
            // 先执行一次代码块
            i++;
        } while (i < 10);

        ```
  5. 三元运算符
      - **Solidity** 和 **Python** 都支持三元运算符，但写法不同。三元运算符允许简洁地表达 `if-else` 语句。
      - **Solidity** 采用 C 风格的语法，`? :` 用来表示条件语句，而 **Python** 则是用 `if-else` 的自然语言表达。
        ```solidity
        // Solidity
        uint max = (x >= y) ? x : y;
        ```
        ```python
        # Python
        max = x if x >= y else y
        ```

##### 控制流与插入排序
```solidity
function insertionSort(uint[] memory a) public pure returns (uint[] memory) {
    for (uint i = 1; i < a.length; i++) {  // for循环：从第2个元素开始逐个比较
        uint temp = a[i];  // 当前需要插入的值
        uint j = i;        // j 用来记录当前元素的插入位置

        // while循环：将当前元素与前面的已经排序部分逐个比较
        while ((j >= 1) && (temp < a[j - 1])) {
            a[j] = a[j - 1];  // 如果当前元素小于前一个元素，前一个元素向后移
            j--;  // j 递减，继续向前比较
        }

        // 插入到正确位置
        a[j] = temp;
    }

    return a;
}

```
1. **`for` 循环**：
    - 这段代码使用了 `for` 循环从数组的第二个元素（`i = 1`）开始，逐个将元素与前面的元素进行比较。
    - 每次循环的迭代，都会从 `a[i]` 取出当前要插入的值，并通过 `while` 循环找到合适的位置插入。
2. **`while` 循环**：
    - `while` 循环是插入排序的核心部分，它通过不断递减 `j`，将当前要插入的元素（`temp`）与前面的元素逐一比较。
    - 当 `temp < a[j - 1]` 时，意味着 `temp` 需要插入在 `a[j - 1]` 的前面，因此要将 `a[j - 1]` 向后移动一位。
    - 当 `while` 条件不满足时（即 `temp >= a[j - 1]`），循环结束，此时 `temp` 被插入到正确的位置。
3. **控制循环中的变量**：
    - 在 **Solidity** 中，`uint` 是无符号整数，因此 `j` 不能小于 0，这就是为什么我们要确保 `j >= 1` 的原因，避免下溢错误（underflow）。
    - 每次迭代，`temp` 会被插入到合适的位置，直到所有元素都被正确排序。
4. **注意事项**
    - **Solidity** 需要显式定义变量类型（如 `uint`），而 **Python** 是动态类型的，不需要显式声明。
    - **`uint` 类型的处理**：在 **Solidity** 中，由于 `uint` 是无符号整数，不能为负数，所以在控制流的设计上要格外小心，避免出现下溢错误。而 **Python** 中，整数可以是负数。

##### 测验结果
- 87/100
- 100/100

##### 测验错题
- 正确的排序算法

### 2024.10.03
#### WTF Academy Solidity 101.11 构造函数和修饰器

##### 构造函数`constructor`
构造函数（`constructor`）是一种特殊的函数，它只会在智能合约部署时运行一次，用来初始化合约的一些变量或状态。可以类比为Python中的类初始化函数 `__init__()`，它在类的实例化时自动调用。
构造函数的常见用途是设置合约的 `owner`，即合约的管理员，只有管理员才能做某些重要操作，比如改变合约的设置或执行关键功能。
> **为什么不能写死`owner`？**
>  - 写死 `owner` 会导致合约的可重用性大大降低。当想用相同的合约代码在多个环境或不同的区块链网络中进行部署。如果 `owner` 地址写死在代码中，那么部署在每个不同环境时都必须修改地址，这不但增加了工作量，还容易出错。
>  - 将 `owner` 地址写死在代码中可能存在安全隐患。尤其是在公开的开源项目中，任何人都可以看到代码中预设的 `owner` 地址，这样可能会成为攻击目标。如果这个地址失去了对私钥的控制权或遭遇攻击，攻击者可能会针对这个合约进行操作，甚至获取对合约的控制权。
>  - 合约的 `owner` 并不总是固定不变的。在实际应用中，`owner` 可能需要转让权限（例如公司组织结构变更或团队内的角色调整）。如果 `owner` 是动态设置的，并且还提供了更改 `owner` 的功能（如通过 `changeOwner` 函数），那么 `owner` 可以在合约生命周期内被灵活管理。

###### 构造函数语法
```solidity
address owner; // 定义owner变量

// 构造函数
constructor(address initialOwner) {
    owner = initialOwner; // 在合约部署时，设置owner为传入的initialOwner地址
}
```
- **owner** 是一个存储管理员地址的状态变量。
- **constructor** 是构造函数，它接受一个 `initialOwner` 地址作为参数，然后将这个地址赋值给 `owner` 变量。

##### 修饰器`modifier`
修饰器（`modifier`）是 **Solidity** 中的一种语法工具，它允许在运行函数前先执行某些检查或操作，从而减少代码重复。这类似于Python中的装饰器（`decorator`），可以为函数添加额外的功能或条件。

###### 修饰器语法
在权限控制中，我们常常使用修饰器来检查调用者是否为合约的管理员（`owner`），只有管理员才能执行某些关键操作。
```solidity
// 定义onlyOwner修饰器
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是不是owner
   _; // 如果是，继续运行函数；否则，revert交易并报错
}
```
- **`msg.sender`** 是合约的内置全局变量，表示当前调用合约的地址。
- **`require`** 是一个断言函数，如果条件为 `false`，则会抛出错误并撤销交易。
- **`_;`** 代表函数主体会在通过修饰器的检查后继续执行。如果检查不通过，函数主体不会执行。

###### 使用 `onlyOwner` 修饰器的函数
```solidity
function changeOwner(address _newOwner) external onlyOwner {
   owner = _newOwner; // 只有当前owner地址可以调用这个函数
}
```

- **`external`** 表示这个函数只能被合约外部调用，而不能由合约内部调用。
- 通过修饰器 `onlyOwner`，这个函数只有当前合约的管理员 `owner` 才能调用。这个函数的功能是允许 `owner` 更改合约的所有者地址。

###### 修饰器和`if`函数的区别
- **`modifier`** 是 Solidity 特有的语法结构，用来改变或扩展函数的行为，主要目的是为函数添加**预处理条件**，通常用于权限控制、状态检查等场景。
    - 例如，`onlyOwner` 修饰器用于确保只有合约的所有者 (`owner`) 才能执行某些敏感操作。
    - `modifier` 的特点是通过 `_` 占位符，在检查通过后继续执行函数主体代码，而不是嵌入到函数内部。
    
    ```solidity
    modifier onlyOwner {
        require(msg.sender == owner); // 检查条件
        _; // 如果条件满足，继续执行被修饰的函数
    }
    ```
    
- **`if` 语句** 是控制流结构，用于根据某个条件执行代码块。
    - `if` 语句是函数内部的控制流语句，用于处理逻辑分支。如果条件不满足，可以选择 `else` 分支处理。
    - `if` 通常与函数主体的某个逻辑相关，而不是像 `modifier` 那样专门处理预处理条件。
    
    ```solidity
    function someFunction() public {
        if (msg.sender == owner) {
            // 执行某些操作
        } else {
            revert(); // 条件不满足，抛出错误
        }
    }
    ```

- **`modifier`** 提供了一种**代码复用**的方式，尤其在权限控制等场景下特别有用。多个函数可以使用相同的 `modifier`，避免在每个函数内部都重复写 `if` 条件判断。
    - 例如，`onlyOwner` 修饰器可以应用于多个函数，不需要每次都写相同的 `require(msg.sender == owner)`。
    
    ```solidity
    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner; // 只有owner能执行
    }
    
    function withdrawFunds() external onlyOwner {
        // 只有owner能执行
    }
    ```
    
- 如果用 **`if`** 语句，每个需要权限控制的函数都必须重复写 `if` 判断逻辑，导致代码冗余且难以维护。
    
    ```solidity
    function changeOwner(address _newOwner) public {
        if (msg.sender == owner) {
            owner = _newOwner;
        } else {
            revert();
        }
    }
    
    function withdrawFunds() public {
        if (msg.sender == owner) {
            // 执行逻辑
        } else {
            revert();
        }
    }
    ```

##### 测验结果
- 100/100


### 2024.10.04
#### WTF Academy Solidity 101.12 事件
事件（`event`）是 **以太坊虚拟机（EVM）** 上的日志系统，用于记录合约中的重要信息，并且对外发送信号，可以被外部程序监听。
- **响应**：事件可以让前端应用通过 `RPC` 接口订阅并监听某个合约的状态变化，接收到事件后可以做出对应的响应。例如，用户在DApp上发起了代币转账，DApp会通过监听事件来实时更新用户的余额或显示通知。
- **经济性**：事件是记录合约数据的一种经济方式。相比于直接将数据存储在链上，事件的 `gas` 消耗较少（每次大约消耗2,000 `gas`），而链上存储一个新变量至少需要 20,000 `gas`。

##### 声明事件
使用 `event` 关键字，后面跟随事件名称和事件参数（需要记录的变量）。例如，在`ERC20`代币合约中，通常定义一个 `Transfer` 事件，用于记录每次代币的转账操作：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

- `Transfer` 是事件的名称，代表发生了代币的转账。
- `from` 和 `to` 是转账的发送方和接收方地址。
- `value` 是转账的代币数量。
- `indexed` 关键字表示这些参数会被索引到事件的 `topics` 中，方便检索和查询。

**`indexed` 参数的作用**：在以太坊上，事件的参数可以标记为 `indexed`，这样这些参数的值就会存储在以太坊虚拟机日志的 `topics` 部分，供用户快速检索。一个事件**最多**可以有三个 `indexed` 参数，因为日志的`topics`最多可以存储4个元素（见EVM日志`log`部分）。

  
##### 释放事件
事件定义后，可以通过 `emit` 关键字在函数中释放事件，也就是记录并广播这个事件的发生。

下面的代码展示了如何在代币转账函数 `_transfer` 中释放 `Transfer` 事件：

```solidity
function _transfer(
    address from,
    address to,
    uint256 amount
) external {

    _balances[from] -= amount; // 减少转账方的余额
    _balances[to] += amount;   // 增加接收方的余额

    // 释放 Transfer 事件，记录转账信息
    emit Transfer(from, to, amount);
}

```

在这个例子中，每次执行 `_transfer` 函数时，都会通过 `emit` 释放 `Transfer` 事件，并记录转账的相关数据。前端应用或其他外部程序可以通过监听这个事件来更新用户的界面或执行其他逻辑。

##### EVM 日志 `Log`
事件在EVM中的表现形式是日志 `Log`，每个日志包含两个部分：

- **主题（topics）**：保存的是事件的**索引信息**，即事件签名的哈希值（即事件的名称和参数类型经过`keccak256`哈希后得到的值）。
  - **事件哈希**：事件的第一个 `topic` 是事件的签名哈希。签名哈希是事件声明的 `keccak256` 哈希值。例如，`Transfer` 事件的签名哈希是：
  
    ```solidity
    keccak256("Transfer(address,address,uint256)")
    
    // 计算得到的哈希值为：
    // 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
    ```
    如果两个不同合约都定义了完全相同的`Transfer`事件：

    ```solidity
    contract A {
        event Transfer(address indexed from, address indexed to, uint256 value);
    }

    contract B {
        event Transfer(address indexed from, address indexed to, uint256 value);
    }
    ```

    两者的事件哈希值是一样的，因为它们有相同的名称和参数类型。如果事件的**名称**或**参数类型**发生任何变化，即使是同一个合约或不同合约，事件的哈希值都会不同。例如：

    ```solidity
    event Transfer(address indexed from, address indexed to, uint256 amount);  // 名字不同
    event Transfer(address indexed sender, address indexed receiver, uint256 value);  // 参数名不同
    ```
  
  - **`indexed` 参数**：接下来，`topics` 数组中还可以包含最多三个 `indexed` 参数。在上面的 `Transfer` 事件中，`from` 和 `to` 参数带有 `indexed` 关键字，因此它们会被存储在 `topics` 部分，方便之后快速检索这些转账的相关信息。
    - 可以使用`indexed`修饰的变量类型
      - `address`
      - `bool`
      - 基本数值类型：`uint`, `int`, `uint8`, `uint256`等
      - 固定大小的字节数组：`bytes1`, `bytes32` 等
        
      这些类型的数据会被直接存储在事件日志的`topics`部分，方便之后的检索和过滤。
    - 不能使用`indexed`修饰的变量类型
      一些复杂类型，比如动态数组、字符串（`string`）和动态字节数组（`bytes`），不能被直接`indexed`修饰。如果尝试将这些类型标记为`indexed`，Solidity编译器会报错。
- **数据（data）**：保存的是事件中**不带`index`索引**的参数。在 `Transfer` 事件中，`value` 就存储在 `data` 部分。**`data` 部分不能被直接检索**，但它可以存储任意大小的数据，因此适合用来存储复杂的数据结构，如数组和字符串。


##### 代码总结

**事件**：

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);

function transfer(address to, uint256 value) public {
    // 业务逻辑，比如代币转账
    emit Transfer(msg.sender, to, value); // 触发事件
}
```
这个事件记录了三项信息：

- `from`: 转出代币的地址。
- `to`: 接收代币的地址。
- `value`: 转账的代币数量。

**日志**：

对于该`Transfer`事件，EVM会将`from`和`to`作为`indexed`参数存储在`topics`中，因为它们被标记为`indexed`。`value`则会存储在`data`部分，因为它没有`indexed`。
- `topics[0]`：事件的哈希值（`Transfer(address,address,uint256)`的哈希，计算方式是`keccak256`哈希函数）。这个哈希值可以让区块链系统快速识别这个事件类型。
- `topics[1]`：`from`地址（即`msg.sender`）。因为它被标记为`indexed`，所以存储在`topics`中，便于检索。
- `topics[2]`：`to`地址。同样因为`indexed`，存储在`topics`中。
- `data`：`value`（转账的金额）。因为没有`indexed`，存储在`data`部分。
EVM日志大致结构可以理解为：

```
topics: [
    0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, // keccak256("Transfer(address,address,uint256)")
    0xabc123..., // from address
    0xdef456...  // to address
]
data: [
    1000  // value
]
```

###### 如何理解“事件是日志的抽象”？
- 在EVM中，**日志（log）是一种低级别的数据记录方式。日志数据不会存储在合约的状态变量中，它只能通过事件的形式发出，并且不会在区块链状态中直接可见。它主要用于记录交易的非持久性信息**，帮助外部应用程序（如`ethers.js`或区块浏览器）监听和响应事件。
- 事件是EVM日志的**高级接口**，它简化了日志的使用方式，帮助开发者将某些特定状态的变化（如代币转账、合约调用等）通过`event`表达出来。开发者不需要手动管理日志记录，EVM自动将这些事件转化为对应的低级别日志，简化了开发者与底层日志系统的交互，同时优化了区块链上数据存储的`gas`消耗。
- 事件与EVM日志的映射关系如下：
  - **事件声明**：开发者通过`event`声明事件，如`Transfer`事件。
  - **事件触发**：使用`emit`关键字触发事件。这会在EVM上生成一条日志（`log`）。


##### 测验结果
- 100/100

### 2024.10.05
#### WTF Academy Solidity 101.13 继承

###### `Virtural`
父合约中的函数如果希望被子合约重写，需要加上`virtual`关键字。
`virtual`关键字用于标记一个函数，表示它**可以被子合约重写**。如果父合约中的函数没有`virtual`，那么子合约**不能**对该函数进行重写。
```solidity
contract Parent {
    function greet() public virtual returns (string memory) {
        return "Hello from Parent";
    }
}
```
在这个例子中，`greet`函数加了`virtual`，表示子合约可以对它进行重写。

###### `Override`
子合约重写了父合约中的函数，需要加上`override`关键字。 `override`关键字用于在子合约中**重写**父合约中带有`virtual`的函数。它告诉编译器，当前子合约中的函数是对父合约中某个`virtual`函数的重写。
```solidity
contract Child is Parent {
    function greet() public override returns (string memory) {
        return "Hello from Child";
    }
}
```
`Child`合约中的`greet`函数使用了`override`，表示它是对`Parent`合约中`greet`函数的重写。

##### 简单继承
定义父合约`Yeye`
```solidity
contract Yeye {
    event Log(string msg);

    function hip() public virtual {
        emit Log("Yeye");
    }

    function pop() public virtual {
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}
```
继承合约`Baba`，继承了`Yeye`，并重写了`hip()`和`pop()`函数（加了`override`关键字），同时新增`baba()`函数。
```solidity
contract Baba is Yeye {
    function hip() public virtual override {
        emit Log("Baba");
    }

    function pop() public virtual override {
        emit Log("Baba");
    }

    function baba() public {
        emit Log("Baba");
    }
}
```
##### 多重继承
1. **继承顺序**：必须从辈分高的合约到低的合约，比如`contract Erzi is Yeye, Baba`。如果顺序写错会报错。
2. **函数冲突**：如果父合约中有重名函数，比如这里的`hip()`和`pop()`，在子合约中必须重写，并且`override`中要标明所有父合约名字。

##### 修饰器的继承
```solidity
contract Base1 {
    // 修饰器：检查输入的数字是否同时能被2和3整除
    modifier exactDividedBy2And3(uint _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0, "Not divisible by 2 and 3");
        _; // 继续执行函数
    }
}
```
子合约`Identifier`继承了`Base1`，并且在函数`getExactDividedBy2And3`中使用了这个修饰器：
```solidity
contract Identifier is Base1 {

    // 使用父合约中的修饰器 exactDividedBy2And3
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
}
```
在这里，`Identifier`合约继承了`Base1`合约的修饰器`exactDividedBy2And3`，并在函数`getExactDividedBy2And3`中使用了它。只要传入的数字`_dividend`能同时被2和3整除，函数才会执行。

##### 构造函数的继承
###### 在继承时传递参数
当定义子合约时，直接在继承声明时传递父合约构造函数的参数。
```solidity
// 父合约 A
contract A {
    uint public a;

    // 父合约 A 的构造函数
    constructor(uint _a) {
        a = _a;
    }
}

// 子合约 B 继承 A
contract B is A(10) { // 直接在继承时传递参数
}
```
在这个例子中，合约 `B` 继承了 `A`，并且在继承时通过 `A(10)` 直接将参数传给了父合约 `A` 的构造函数。所以，当部署 `B` 合约时，`A` 的状态变量 `a` 会被初始化为 10。
###### 在子合约的构造函数中调用父合约的构造函数
如果希望在子合约的构造函数中动态传递参数给父合约，可以在子合约的构造函数中显式调用父合约的构造函数。
```solidity
// 父合约 A
contract A {
    uint public a;

    // 父合约 A 的构造函数
    constructor(uint _a) {
        a = _a;
    }
}

// 子合约 C 继承 A
contract C is A {
    // 子合约的构造函数传递参数给 A 的构造函数
    constructor(uint _c) A(_c * 2) {
    }
}
```
在这个例子中，子合约 `C` 的构造函数接收参数 `_c`，并将 `_c * 2` 传递给父合约 `A` 的构造函数。这意味着当你部署 `C` 合约时，`A` 的状态变量 `a` 会被初始化为 `_c * 2`。

**什么时候用哪种方法？**
- 如果参数是固定的，可以直接在继承声明时传递参数（第一种方法）。
- 如果参数需要动态计算或者传递，则可以在子合约的构造函数中调用父合约的构造函数（第二种方法）。

##### 调用父合约的函数
1. **直接调用**：可以通过`父合约名.函数名()`来调用，比如`Yeye.pop()`。
    
    ```solidity
    function callParent() public {
        Yeye.pop();
    }
    ```
2. **`super`关键字**：使用`super`可以调用最近的父合约。例如，`super.pop()`会调用继承链条上最近的父合约的`pop()`函数。
    - 这里的“最近的父合约”指的是根据继承顺序，最接近当前合约的那个父合约。
    
    ```solidity
    function callParentSuper() public {
        super.pop();  // 调用的是Baba.pop()，因为Baba是最近的父合约
    }
    ```

###### 举例
假设我们有三个合约 `Yeye`（爷爷）, `Baba`（爸爸）, 和 `Child`（孩子），并且它们之间有继承关系。`Child` 继承自 `Baba`，而 `Baba` 继承自 `Yeye`。每个合约都有一个 `pop()` 函数。

```solidity
// 爷爷合约
contract Yeye {
    function pop() public virtual returns (string memory) {
        return "Yeye's pop";
    }
}

// 爸爸合约
contract Baba is Yeye {
    function pop() public virtual override returns (string memory) {
        return "Baba's pop";
    }
}

// 孩子合约
contract Child is Baba {
    // 直接调用父合约的函数
    function callParent() public returns (string memory) {
        return Baba.pop();  // 调用 Baba 的 pop() 函数
    }

    // 使用 super 调用最近的父合约的函数
    function callParentSuper() public returns (string memory) {
        return super.pop();  // 调用继承链中最近的父合约的 pop() 函数，这里是 Baba 的 pop()
    }

    // 使用 Yeye 直接调用 Yeye 的 pop() 函数
    function callYeyeDirectly() public returns (string memory) {
        return Yeye.pop();  // 明确调用 Yeye 的 pop() 函数
    }
}
```
1. **继承关系**：
    - `Child` 继承了 `Baba`，而 `Baba` 继承了 `Yeye`。因此，`Child` 是最底层的合约，`Baba` 是中间层，`Yeye` 是顶层。
2. **直接调用父合约的函数**：
    - 在 `callParent()` 函数中，`Baba.pop()` 明确调用了父合约 `Baba` 的 `pop()` 函数。因为 `Baba` 重写了 `Yeye` 的 `pop()` 函数，所以调用 `Baba.pop()` 时，结果会是 `"Baba's pop"`。
3. **`super` 关键字**：
    - 在 `callParentSuper()` 中，`super.pop()` 调用了继承链中最近的父合约的 `pop()` 函数。因为 `Child` 继承了 `Baba`，而 `Baba` 是最近的父合约，所以 `super.pop()` 实际上调用的是 `Baba` 的 `pop()` 函数，结果仍然是 `"Baba's pop"`。
    - 如果 `Baba` 没有重写 `Yeye` 的 `pop()` 函数，那么 `super.pop()` 会调用 `Yeye` 的 `pop()` 函数。
4. **调用更上层的父合约**：
    - 在 `callYeyeDirectly()` 中，`Yeye.pop()` 明确调用了顶层合约 `Yeye` 的 `pop()` 函数，即便 `Baba` 已经重写了 `pop()`。因此，结果是 `"Yeye's pop"`。


**输出**
- 调用 `callParent()`：返回 `"Baba's pop"`。
- 调用 `callParentSuper()`：返回 `"Baba's pop"`，因为 `super.pop()` 调用了最近的父合约 `Baba`。
- 调用 `callYeyeDirectly()`：返回 `"Yeye's pop"`，因为明确调用了顶层合约 `Yeye` 的函数。
##### 钻石继承
代码示例
```solidity
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
###### 合约继承树
```solidity
/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/
```
- `Adam` 和 `Eve` 都继承自 `God`，且都重写了 `God` 中的 `foo()` 和 `bar()` 函数。
- 合约 `people` 同时继承了 `Adam` 和 `Eve`，并重写了 `foo()` 和 `bar()`，调用 `super.foo()` 和 `super.bar()`。
###### 继承顺序
在 Solidity 中，多重继承的顺序由合约声明的顺序决定。合约继承链的调用顺序（也称为**继承线性化顺序**或 C3 线性化）从左到右，是根据继承关系树来确定的。这个顺序定义了哪个父合约的函数会先被调用，而哪些会在之后调用。

Solidity 中的继承顺序是**从左到右**的，这里的“左”和“右”是根据继承声明的顺序来定义的。当你写出一个合约，并从多个父合约继承时，继承链的线性化顺序会基于合约声明时的顺序：

```solidity
contract people is Adam, Eve { }
```

在这个例子中，`people` 继承了 `Adam` 和 `Eve`，**左**边的父合约是 `Adam`，**右**边的父合约是 `Eve`。

**为什么是 `Eve` 先调用？**
虽然 `people` 继承顺序看起来是 `Adam` 在 `Eve` 之前，但继承调用遵循 Solidity 的**C3 线性化规则**。在 C3 线性化中，子合约会先继承所有右侧的父合约，然后再继承左侧的父合约。

**Solidity 的线性化规则**
1. **父合约的合并**：当写 `contract people is Adam, Eve` 时，`people` 需要先遍历 `Eve`，然后遍历 `Adam`。因为在 `Eve` 和 `Adam` 中，都有对 `God` 的继承，所以 `God` 只会在最终调用时执行一次。
2. **从右到左继承**：线性化顺序遵循从右至左继承的原则。`people` 合约先会调用右侧的父合约 `Eve`，再去调用左侧的父合约 `Adam`，最后调用最顶层的 `God`，这是线性化的特点。

**最终继承顺序**
调用 `people.foo()` 时，函数执行顺序是：
1. **调用 `Eve.foo()`**：首先执行右边的父合约，即 `Eve.foo()`，输出 `Eve.foo called`。
2. **调用 `Adam.foo()`**：接着执行左边的父合约 `Adam.foo()`，输出 `Adam.foo called`。
3. **调用 `God.foo()`**：由于 `Eve` 和 `Adam` 都继承自 `God`，最终调用 `God.foo()`，输出 `God.foo called`。

输出结果：
```
Eve.foo called
Adam.foo called
God.foo called
```

调用 `people.bar()` 时，函数执行顺序与 `foo()` 类似：

1. **调用 `Eve.bar()`**：首先执行右边的父合约 `Eve.bar()`，输出 `Eve.bar called`。
2. **调用 `Adam.bar()`**：接着执行左边的父合约 `Adam.bar()`，输出 `Adam.bar called`。
3. **调用 `God.bar()`**：最后调用 `God.bar()`，输出 `God.bar called`。

输出结果：
```
Eve.bar called
Adam.bar called
God.bar called
```

**如果没有C3 线性化规则避免重复输出呢？**
1. **`people.foo()` 的调用顺序**：
    - `people` 先调用 `Eve.foo()`，`Eve.foo()` 调用 `super.foo()`，它指向 `God.foo()`；
    - 接着 `people` 调用 `Adam.foo()`，`Adam.foo()` 也调用 `super.foo()`，它再次指向 `God.foo()`；
    
    因为没有线性化原则，`God.foo()` 会被调用两次，一次在 `Eve` 中，一次在 `Adam` 中。

    ```
    Eve.foo called
    God.foo called
    Adam.foo called
    God.foo called
    ```
    
2. **`people.bar()` 的调用顺序**：
    - 同理，`people` 先调用 `Eve.bar()`，`Eve.bar()` 调用 `super.bar()`，指向 `God.bar()`；
    - 然后调用 `Adam.bar()`，`Adam.bar()` 也调用 `super.bar()`，再次指向 `God.bar()`；
    
    因为没有线性化原则，`God.bar()` 也会被重复调用两次。

    ```
    Eve.bar called
    God.bar called
    Adam.bar called
    God.bar called
    ```
##### 测验结果
- 85/100
- 100/100

##### 测验错题
`function a() public override{}`意思是？

这个函数`重写`（`override`）了一个父合约中的同名函数 `a`。
- `public`：表示该函数的可见性为公共（public），即可以从合约外部以及合约内部调用。
- `override`：意味着该函数是对父合约中同名函数 a 的重写。父合约中必须有一个函数签名与此函数相同，并且该父合约的函数必须被标记为 virtual，允许子合约进行重写。
- `{}`：函数体为空，表示该函数目前没有实现任何逻辑操作。

### 2024.10.06
#### WTF Academy Solidity 101.14 抽象合约和接口

##### 抽象合约
**定义**：抽象合约是指至少包含一个未实现函数的合约。这意味着这个函数没有实际的逻辑实现，只提供一个接口，具体的实现留给继承这个合约的子合约完成。

1. **未实现的函数**：在抽象合约中，未实现的函数必须使用 `virtual` 关键字，表示这个函数可以被重写。
2. **抽象合约的使用场景**：当你定义一些通用的接口或功能，但不打算在这个合约中具体实现这些功能时，可以使用抽象合约。子合约可以继承抽象合约，并实现这些函数。当一个子合约继承了一个抽象合约时，子合约**必须重写**抽象合约中所有未实现的函数，否则子合约本身也必须被标记为 `abstract`。这意味着，抽象合约中的未实现函数在子合约中需要被实现，才能编译和部署成功。
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

abstract contract InsertionSort {
    // 定义一个抽象函数，只提供接口，不提供实现
    function insertionSort(uint[] memory a) public pure virtual returns (uint[] memory);
}
```

在上面的例子中，`InsertionSort` 是一个抽象合约，它定义了一个插入排序函数 `insertionSort()`，但没有具体实现。这个函数被标记为 `virtual`，意思是任何继承该合约的子合约都可以并且必须重写这个函数。

##### 接口
**定义**：接口类似于抽象合约，但更加严格。接口只定义函数的签名和事件，不能包含任何实现细节。它也不能有状态变量或构造函数。

**规则**：
1. 不能包含状态变量。
2. 不能有构造函数。
3. 只能包含函数签名（必须为 `external` 类型）和事件声明。
4. 不能继承除其他接口以外的合约。
5. 继承接口的非抽象合约必须实现接口定义的所有功能。

**接口的作用**：接口定义了合约的功能和交互方式，其他合约只需要知道接口就可以与实现了该接口的合约进行交互，而无需了解合约的具体实现。

接口与合约`ABI`（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的`ABI`，利用[abi-to-sol工具](https://gnidan.github.io/abi-to-sol/)，也可以将`ABI json`文件转换为`接口sol`文件。

###### 代码示例：定义`IERC721`接口
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 定义 IERC721 接口
interface IERC721 {
    // 定义事件
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    // 定义外部函数
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}
```

- **事件**：`Transfer` 事件记录 NFT 的转账操作，`from` 是发送方，`to` 是接收方，`tokenId` 是 NFT 的 ID。
- **函数**：
    - `balanceOf`：返回某个地址持有的 NFT 数量。
    - `ownerOf`：返回某个 `tokenId` 的拥有者地址。
    - `safeTransferFrom`：安全转账 NFT，确保接收方能处理 NFT，否则操作失败。

###### 代码示例：使用`IERC721`接口
```solidity
contract interactBAYC {
    // 利用BAYC合约地址创建接口合约变量
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    // 通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOfBAYC(address owner) external view returns (uint256 balance) {
        return BAYC.balanceOf(owner); // 查询owner拥有的BAYC数量
    }

    // 通过接口调用BAYC的safeTransferFrom()安全转账
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external {
        BAYC.safeTransferFrom(from, to, tokenId); // 将BAYC转账给另一个地址
    }
}
```
- **接口合约变量**：
    - `IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);`
        - `IERC721` 是我们定义的 `ERC721` 接口。
        - `0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D` 是 Bored Ape Yacht Club (BAYC) 的智能合约地址。
        - `BAYC` 是通过这个地址创建的接口变量，我们可以用它调用 `IERC721` 接口中的函数来与 BAYC 合约交互。
- **查询持仓量**：
    - `balanceOfBAYC(address owner)` 函数使用 `BAYC.balanceOf(owner)`，查询某个地址的 BAYC NFT 数量。
- **安全转账**：
    - `safeTransferFromBAYC(address from, address to, uint256 tokenId)` 使用 `BAYC.safeTransferFrom(from, to, tokenId)`，将 BAYC NFT 从 `from` 地址转账到 `to` 地址。
###### 接口应用：标准库继承
开发者在编写和部署合约时，**不需要手动再次定义`IERC721`接口**，因为这个接口已经是**标准化的**，可以直接通过继承的方式使用。这意味着你可以直接写`contract MyNFT is IERC721`，并通过`override`关键字实现接口中的函数。
通常来说，开发者可以直接从**已有的标准库**中继承接口。这些标准库（如`OpenZeppelin`提供的库）已经包含了`IERC721`接口的定义和实现，所以开发者可以直接从中继承，而不需要再定义接口。
例如，使用[OpenZeppelin库](https://github.com/OpenZeppelin/openzeppelin-contracts)，可以直接引入`IERC721`接口，并编写自己的实现：
    
    ```solidity
    // 从OpenZeppelin导入IERC721接口
    import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
    
    contract MyNFT is IERC721 {
        mapping(address => uint256) private _balances;
    
        function balanceOf(address owner) external view override returns (uint256) {
            return _balances[owner];
        }
    
        // 其他函数的实现...
    }
    
    ```
使用这种方法，开发者不需要重复编写接口部分，只需要关注具体实现。这样代码更加简洁、规范，并且减少了错误的可能。
##### 测验结果
- 57/100
- 85/100
- 100/100
##### 测验错题
1. 被标记为`abstract`的合约能否被部署？
    不能。被标记为`abstract`的合约不能被直接部署。抽象合约包含未实现的函数，意味着它不完整，无法在区块链上运行。如果想要部署一个合约，必须确保该合约实现了所有的函数，或者继承它的子合约实现了所有未实现的函数。
2. 已知Azuki合约中存在approve(address to, uint256 tokenId)函数可以让NFT的拥有者将自己某一NFT的许可权授予另一地址，且该函数没有返回值，现在某个Azuki拥有者想利用上文中创建的接口合约变量调用这一函数 ，那么他写出的代码可能是？

    ```solidity
    function approveAzuki(address to, uint256 id) external { Azuki.approve(to, id); }
    ```

    解释：
    - `approve(address to, uint256 tokenId)` 是一个改变链上状态的函数，因此它不能是 `view` 函数（`view` 函数表示不会修改链上数据）。
    - 该函数没有返回值，而不是返回一个布尔值。因为它没有 `view` 限制，也没有错误的返回值定义。
3. 已知Azuki合约中存在ownerOf(uint256 tokenId)函数可用来查询某一NFT的拥有者，现在vitalik想利用上文中创建的接口合约变量调用这一函数，并写出了如下代码：
    ```solidity
    function  ownerOfAzuki(uint256 id) external view returns (address){ 
        _________________________________
    }
    ```
    横线处应该是：
    ```solidity
    return Azuki.ownerOf(id);
    ```

    解释：
    - `return Azuki.ownerOf(id);`正确使用了`Azuki`接口变量调用`ownerOf`函数，并传入了`id`作为参数，返回该`tokenId`对应的地址。

    - `return ownerOf(id);`错误，因为直接调用`ownerOf(id)`会导致编译错误，必须通过合约变量`Azuki`来调用接口中的函数。

    - `return Azuki.ownerOfAzuki(id);`错误，`ownerOfAzuki`并不是`IERC721`接口中的函数名。

    - `return Azuki(ownerOf, id);`错误，`Azuki(ownerOf, id)`是无效的语法，函数调用不应以这种形式进行。

### 2024.10.07
#### WTF Academy Solidity 101.15 异常 `Error`

##### `error` 与 `revert`
`error` 是在 Solidity 0.8.4 中引入的，用来定义自定义异常。通过 `error`，开发者可以高效地抛出错误并返回相关的错误信息。`error` 通常与 `revert` 搭配使用，当程序遇到错误条件时，`revert`会将状态回滚。

- 节省`gas`：由于不会输出过多的字符串信息，`error`在提供错误信息的同时更节省`gas`。
- 参数支持：可以向异常携带相关的参数，提供更精确的调试信息。

在同一个合约中，可以同时定义同名的 `error`，一个是没有参数的，另一个是带参数的。 Solidity 允许这种方式，因为它支持函数和错误的重载（overloading），即同名但参数不同的定义是合法的。下面是一个示例：
###### 代码示例
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Example {
    // 自定义的无参数错误
    error TransferNotOwner();

    // 自定义的带参数错误
    error TransferNotOwner(address sender);

    mapping(uint256 => address) private _owners;

    function transferOwner(uint256 tokenId, address newOwner) public {
        // 检查是否为代币的拥有者
        if (_owners[tokenId] != msg.sender) {
            revert TransferNotOwner(); // 抛出无参数错误
        }
        // 更新拥有者
        _owners[tokenId] = newOwner;
    }

    function transferOwnerWithDetails(uint256 tokenId, address newOwner) public {
        // 检查是否为代币的拥有者
        if (_owners[tokenId] != msg.sender) {
            revert TransferNotOwner(msg.sender); // 抛出带参数错误
        }
        // 更新拥有者
        _owners[tokenId] = newOwner;
    }
}
```
- `TransferNotOwner()` 是一个没有参数的错误，适用于不需要提供额外信息的场景。
- `TransferNotOwner(address sender)` 是一个带参数的错误，可以在抛出错误时提供调用者的地址，方便调试和错误跟踪。
- 然而，尽管可以在同一个合约中同时定义同名的错误，**在实际开发中，为了代码的可读性和可维护性，建议尽量避免使用相同的名字**。这样可以减少混淆，尤其是在较大的合约中。

**类比 Python**：
在 Python 中可以使用自定义异常类来模拟 Solidity 中的 `error`。同时，当条件不满足时通过 `raise` 抛出异常并传递参数。

```python
class TransferNotOwner(Exception):
    def __init__(self, sender):
        self.sender = sender

def transfer_owner(token_id, new_owner, owners, sender):
    if owners[token_id] != sender:
        raise TransferNotOwner(sender)  # 自定义异常带参数
    owners[token_id] = new_owner
```

##### `require`
`require` 是 Solidity 中用于条件检查的常见方法。它通过验证条件是否为真，若不满足则抛出异常并回滚交易，同时可以带有描述错误原因的字符串。`require` 常用于合约函数的入口检查，比如验证用户权限或合约的输入。

- 友好的用户提示：可以附带字符串信息解释错误。
- 常用于权限验证和函数前置条件检查。

###### 代码示例
```solidity
contract MyToken {
    mapping(uint256 => address) private _owners;

    function transferOwner(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner"); // 权限检查
        _owners[tokenId] = newOwner;
    }
}
```

##### `assert`
`assert` 主要用于开发者调试过程中检查程序的内部逻辑。它的功能类似于`require`，但通常用于合约的不可变状态或代码内部的逻辑错误。如果条件不成立，合约会回滚并抛出异常。但相比`require`，`assert`不附带（可自定义的）错误提示信息。

- 用于合约内部逻辑的断言，适用于不可变状态。
- 通常用于表示**不应发生的情况**。

###### 代码示例
```solidity

contract MyToken {
    mapping(uint256 => address) private _owners;

    function transferOwner(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender); // 内部逻辑检查，与require比少字符串
        _owners[tokenId] = newOwner;
    }
}
```

##### `require`和修饰器的区别
- **使用场景**：
    - `require` 一般用于简单的条件检查，适合在单一函数中执行，尤其是在处理逻辑简单、并且条件检查不重复的场景。
    - 修饰器更适合用于多次重复出现的条件检查和代码复用，减少重复代码的写入。
- **代码复用**：
    - `require` 只能在函数内直接使用，无法抽象成可重复利用的逻辑。
    - 修饰器可以被多个函数复用，用于共享检查逻辑，比如权限控制或其他共同的条件。
- **可读性**：
    - `require` 通常更直观，因为条件和操作在同一个地方定义，适合短小的逻辑。
    - 修饰器可以简化函数体，使函数主体更专注于核心逻辑，提升代码的可读性。

可以将 `require` 理解为一种内联的"修饰器"，用于单次条件验证，而修饰器则是一个结构化的工具，用来抽象条件检查并提高代码复用性。它们确实有相似的功能，但应用场景有所不同。
如果你的条件检查逻辑只在某一个函数中使用，`require` 是更简单直接的选择。如果需要重复检查同样的条件，修饰器则是更高效、优雅的选择。

**修饰器代码**
```solidity
modifier onlyOwner(uint256 tokenId) {
    require(_owners[tokenId] == msg.sender, "Not the owner");
    _;
}

function transferOwner(uint256 tokenId, address newOwner) public onlyOwner(tokenId) {
    _owners[tokenId] = newOwner;
}
```

**类比 Python**：
Python 中可以通过 `assert` 或 `if` 语句检查条件，并使用 `raise` 抛出异常。
**代码示例**
```python
class MyTokenRequire:
    def __init__(self):
        self._owners = {}

    def transfer_owner(self, token_id, new_owner, sender):
        # 使用 if 语句进行检查，类似于 Solidity 中的 require
        if self._owners.get(token_id) != sender:
            raise Exception("Transfer Not Owner")  # 抛出异常，类似于 revert 或 require
        self._owners[token_id] = new_owner
    # 报错结果：Exception: Transfer Not Owner

class MyTokenAssert:
    def __init__(self):
        self._owners = {}

    def transfer_owner(self, token_id, new_owner, sender):
        # 使用 assert 进行内部逻辑检查
        assert self._owners.get(token_id) == sender, "Transfer Not Owner"
        self._owners[token_id] = new_owner
    # 报错结果：AssertionError: Transfer Not Owner
```

##### 测验结果
- 85/100
- 100/100

##### 测验错题
`error`必须搭配`revert`使用

### 2024.10.08
#### WTF Academy Solidity 102.16 函数重载

##### 函数重载`overloading`
Solidity允许函数重载（Overloading），即定义多个同名函数，但具有不同参数类型或参数数量。
需要注意的是，Solidity 不允许修饰器进行重载。修饰器与函数的语法不同，它们在逻辑上更像是对函数的封装，而不是不同的实现。因此，当使用修饰器时，函数的名称必须是唯一的。

**不同参数类型**

```solidity
pragma solidity ^0.8.0;

contract OverloadExample {
    function saySomething() public pure returns (string memory) {
        return "Nothing"; // 没有参数的函数
    }

    function saySomething(string memory something) public pure returns (string memory) {
        return something; // 带一个字符串参数的函数
    }
}
```

**不同参数数量**

```solidity
pragma solidity ^0.8.0;

contract OverloadExample {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b; // 两个参数的加法
    }

    function add(uint a, uint b, uint c) public pure returns (uint) {
        return a + b + c; // 三个参数的加法
    }
}
```
###### 函数选择
在 Solidity 中，重载函数的名称相同，但由于参数类型的不同，它们被编译成不同的函数选择器。函数选择器是根据函数的签名生成的前四个字节，签名包括函数名称及其参数类型。例如：

- `saySomething()` 的选择器是根据函数签名 `"saySomething()"` 生成的。
- `saySomething(string memory)` 的选择器是根据签名 `"saySomething(string)"` 生成的。

##### 实参匹配（Argument Matching）
当调用重载函数时，Solidity 会尝试根据提供的实参（实际参数）来匹配最适合的重载函数，。如果传入的参数能够匹配多个重载函数，将会导致编译错误，因此必须确保传入的实参能明确匹配某一个重载函数。
```solidity
pragma solidity ^0.8.0;

contract Example {
    function f(uint8 _in) public pure returns (uint8) {
        return _in; // uint8 的 f 函数
    }

    function f(uint256 _in) public pure returns (uint256) {
        return _in; // uint256 的 f 函数
    }
}

// 当调用 f(50) 时，会报错：
// TypeError: Function call argument type mismatch.
```

在这个例子中，如果调用 `f(50)`，编译器会发现 `50` 同时可以被视为 `uint8` 和 `uint256`，因为它可以在这两种类型之间进行转换。这时，编译器无法确定调用哪个版本的 `f()` 函数，因此会报错。

##### 测验结果
- 100/100

### 2024.10.09
#### WTF Academy Solidity 102.17 库合约

##### 库合约（Library Contract）

在 Solidity 中，库合约是一种特殊的合约，旨在提高代码的复用性并减少交易成本（gas 消耗）。库合约像传统的代码库一样，提供了一系列的函数，但它们与普通合约有一些显著的区别：
- **不能存在状态变量**：库合约不能存储状态，所有的变量都是局部的。
- **不能继承或被继承**：库合约无法继承其他合约，也不允许其他合约继承它。
- **不能接收以太币**：库合约不能接收以太币，所有操作都是纯粹的计算。
- **不可以被销毁**：库合约一旦部署，不可被销毁。
- **可见性设置**：库合约的函数如果设置为 `public` 或 `external`，调用时会触发一次 `delegatecall`。而 `internal` 则不会触发 `delegatecall`，`private` 函数只能在库合约内部调用。

##### 库合约的使用方法
**3.1 使用 `using for` 指令**
通过 `using A for B;` 可以将库合约 A 的函数附加到类型 B。使用这个指令后，库 A 中的函数会自动成为 B 类型变量的成员，可以直接调用。

```solidity
// 利用using for指令
using Strings for uint256;

function getString1(uint256 _number) public pure returns(string memory) {
    return _number.toHexString(); // 调用库合约中的函数
}
```

**3.2 直接通过库合约名调用**
可以直接使用库合约的名称来调用函数，这样更为直观。

```solidity
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory) {
    return Strings.toHexString(_number); // 调用库合约中的函数
}
```

##### 测验结果
- 100/100

### 2024.10.10
#### WTF Academy Solidity 102.18 Import

#####  `import` 导入方法
1. **通过文件相对位置导入**
    - 使用相对路径导入本地的 Solidity 文件。这种方式常见于项目中的文件之间的引用。
    - 例子：
    在项目结构中，如果 `Import.sol` 和 `Yeye.sol` 位于同一目录下，则可以通过相对路径导入 `Yeye.sol` 文件中的所有内容。
        
        ```solidity
        import './Yeye.sol';
        
        ```
        
2. **通过网址导入**
    - 直接从网络上引用合约文件，例如从 GitHub 上的公开 Solidity 文件。这种方式常见于引入远程的库或合约。
    - 例子：
    这种引用方式非常方便，尤其是在开发过程中想要快速测试和使用现有的第三方库。
        
        ```solidity
        import '<https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol>';
        
        ```
        
3. **通过 npm 导入**
    - 这种方式通常用于导入项目依赖中的库，例如通过 npm 安装的 OpenZeppelin 库。
    - 例子：
    使用这种方式时，项目必须配置好 npm 依赖，例如通过 `npm install` 安装相关库。
        
        ```solidity
        import '@openzeppelin/contracts/access/Ownable.sol';
        
        ```
        
4. **通过指定全局符号导入**
    - 通过这种方式可以只导入指定的符号（例如合约、结构体等），避免导入整个文件的所有内容。这种方式适用于文件中包含多个合约或定义，但我们只需要使用其中的某一部分。
    - 例子：
    这样只导入 `Yeye.sol` 文件中的 `Yeye` 合约。
        
        ```solidity
        import {Yeye} from './Yeye.sol';
        ```

##### 测验结果
- 100/100

### 2024.10.11
#### WTF Academy Solidity 102.19 接收ETH receive和fallback

##### `receive`函数
`receive()` 函数专门用于处理合约收到ETH的情况。当合约接收到ETH并且 `msg.data` 为空时（即没有调用任何函数），如果存在 `receive()` 函数，它就会被触发。
- **`receive()` 函数的触发条件**：
    - 当合约接收ETH，且 `msg.data` 为空时会触发 `receive()`。
    - 在上述例子中，当有人向合约发送ETH时（例如通过钱包的发送功能），`receive()` 会被调用，并触发 `Received` 事件。
- **语法规则**：
    - 一个合约最多有一个`receive()`函数
    - 声明方式与一般函数不一样，不需要`function`关键字：`receive() external payable { ... }`。
    - `receive()`函数不能有任何的参数，不能返回任何值，必须包含`external`和`payable`。
- **逻辑简单**：为了避免超过 `gas` 限制，`receive()` 函数最好尽量简单，在这里我们仅仅记录ETH发送者和金额。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ReceiveExample {
    event Received(address sender, uint value);

    // receive 函数，用于接收ETH
    receive() external payable {
        emit Received(msg.sender, msg.value); // 触发事件记录发送者和金额
    }

    // 用于查询合约的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

```

##### `fallback`函数
`fallback()` 函数在两个主要场景下被调用：
1. 当调用一个不存在的函数时。
2. 当向合约发送ETH且 `msg.data` 不为空，或者合约没有定义 `receive()` 函数时。
- **`fallback()` 函数的触发条件**：
    - 当调用合约中不存在的函数时，或者向合约发送ETH但 `msg.data` 不为空时，`fallback()` 会被触发。
    - 在这个例子中，我们定义了一个 `fallback()` 函数，当它被触发时，记录发送者、金额和 `msg.data`。
- **`payable` 修饰符**：为了确保 `fallback()` 能够接收ETH，它通常也会使用 `payable` 修饰符。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FallbackExample {
    event FallbackCalled(address sender, uint value, bytes data);

    // fallback 函数，用于接收ETH或处理不存在的函数调用
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data); // 触发事件记录发送者、金额和data
    }

    // 用于查询合约的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

```
##### `receive`和`fallback`的区别

| 触发条件 | `receive()` | `fallback()` |
| --- | --- | --- |
| 接收ETH，且 `msg.data` 为空 | 触发 | 不触发 |
| 接收ETH，且 `msg.data` 不为空 | 不触发 | 触发（如果存在） |
| 调用不存在的函数 | 不触发 | 触发 |
| 合约没有 `receive()`，接收ETH | 不触发 | 触发 |

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
##### 同时实现`receive`和`fallback`
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ReceiveFallbackExample {
    event Received(address sender, uint value);
    event FallbackCalled(address sender, uint value, bytes data);

    // receive 函数
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    // fallback 函数
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }

    // 查询合约余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

```

在这个合约中：
- 如果向合约发送ETH而不附带数据，则 `receive()` 函数会被触发。
- 如果向合约发送ETH并附带数据，或者调用了一个不存在的函数，`fallback()` 函数会被触发。

##### 测验结果
- 100/100

### 2024.10.12
#### WTF Academy Solidity 102.20 发送ETH

##### 发送-接收ETH合约
**接收ETH合约 `ReceiveETH`**

简单的接收ETH的合约包含`receive()`函数，允许它接收ETH，并记录交易信息。

```solidity
contract ReceiveETH {
    // 事件，用于记录ETH接收情况
    event Log(uint amount, uint gas);

    // receive函数，每次接收ETH时触发
    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    // 查询合约当前余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

```
**发送ETH合约 `SendETH`**

发送ETH的合约`SendETH`，这个合约通过不同的方法向`ReceiveETH`合约发送ETH。

```solidity
contract SendETH {
    // 构造函数，使得部署时可以转入ETH
    constructor() payable {}

    // receive函数，接收ETH时被触发
    receive() external payable {}

    // transfer()发送ETH的示例
    function transferETH(address payable _to, uint256 amount) external payable {
        _to.transfer(amount);
    }

    // send()发送ETH的示例
    error SendFailed();  // 如果发送失败，触发自定义错误
    function sendETH(address payable _to, uint256 amount) external payable {
        bool success = _to.send(amount);
        if (!success) {
            revert SendFailed();  // 发送失败则revert交易
        }
    }

    // call()发送ETH的示例
    error CallFailed();  // 如果发送失败，触发自定义错误
    function callETH(address payable _to, uint256 amount) external payable {
        (bool success, ) = _to.call{value: amount}("");
        if (!success) {
            revert CallFailed();  // 发送失败则revert交易
        }
    }
}

```

##### 三种发送ETH方法
**1. `transfer()`**

**语法**：

```solidity
_to.transfer(amount);

```

- **参数**：
    - `_to`：接收ETH的目标地址，类型是`address payable`。
    - `amount`：发送的ETH数额，以`wei`为单位。
- **返回值**：
    - `transfer()` 没有返回值。
    - 如果转账失败（例如目标合约消耗的`gas`超过了2300 gas），会自动`revert`（回滚交易），并抛出异常，停止执行合约后续的代码。
- **用法特点**：
    - 固定的2300 gas限制，适合简单的转账，不适用于执行复杂逻辑。
    - 如果失败，会自动回滚交易，无需手动处理。

**示例**：

```solidity
function transferETH(address payable _to, uint256 amount) external {
    _to.transfer(amount);
}

```

**2. `send()`**

**语法**：

```solidity
bool success = _to.send(amount);

```

- **参数**：
    - `_to`：接收ETH的目标地址，类型是`address payable`。
    - `amount`：发送的ETH数额，以`wei`为单位。
- **返回值**：
    - 返回一个`bool`值，表示转账是否成功。
        - `true`：转账成功。
        - `false`：转账失败。
    - 由于返回值是`bool`，需要手动检查返回值来决定是否要回滚（例如使用`require`或`revert`来处理）。
- **用法特点**：
    - 和`transfer()`一样有2300 gas限制，但转账失败不会自动`revert`，需要手动处理失败情况。
    - 因为没有自动`revert`机制，使用场景较少。

**示例**：

```solidity
error SendFailed(); // 自定义错误

function sendETH(address payable _to, uint256 amount) external {
    bool success = _to.send(amount);
    if (!success) {
        revert SendFailed(); // 手动回滚
    }
}

```

**3. `call()`**

**语法**：

```solidity
(bool success, bytes memory data) = _to.call{value: amount}("");

```

- **参数**：
    - `_to`：接收ETH的目标地址，类型是`address payable`。
    - `amount`：发送的ETH数额，以`wei`为单位。
    - `{value: amount}`：指定转账的ETH数额。
    - `""`：调用的函数签名（空字符串代表调用目标合约的`fallback()`或`receive()`函数）。
- **返回值**：
    - `call()`返回一个元组：
        - `bool success`：表示调用是否成功。
            - `true`：调用成功。
            - `false`：调用失败。
        - `bytes memory data`：表示调用返回的`data`，在发送ETH时通常不使用（因为没有调用任何具体函数），但在函数调用中可以解析返回数据。
- **用法特点**：
    - 没有固定的gas限制，适合复杂逻辑的执行（可以手动设置`gas`）。
    - 如果失败，不会自动`revert`，需要手动检查`bool success`，决定是否要回滚交易。

**示例**：

```solidity
error CallFailed(); // 自定义错误

function callETH(address payable _to, uint256 amount) external {
    (bool success, ) = _to.call{value: amount}(""); // 发送ETH
    if (!success) {
        revert CallFailed(); // 手动回滚
    }
}

```

##### 主要区别总结：

| 方法 | 语法规则 | 返回值 | gas 限制 | 失败时行为 | 用法场景 |
| --- | --- | --- | --- | --- | --- |
| `transfer()` | `_to.transfer(amount)` | 无返回值 | 固定 2300 gas | 自动`revert` | 简单ETH转账，确保安全 |
| `send()` | `bool success = _to.send(amount)` | `bool success` | 固定 2300 gas | 不自动`revert` | 不推荐，必须手动检查返回值 |
| `call()` | `(bool success, bytes memory data) = _to.call{value: amount}("")` | `bool success`, `bytes data` | 无限制 | 不自动`revert` | 推荐用于复杂逻辑或可控的ETH发送 |
##### 测验结果
- 100/100

### 2024.10.13
#### WTF Academy Solidity 102.21 调用其他合约

##### 传入合约地址
**语法：**

```solidity
OtherContract(_Address).f();

```

- **`OtherContract`**：这是目标合约的类型，即我们调用的目标合约的名称。
- **`_Address`**：这是目标合约的部署地址，类型为`address`。
- **`f()`**：这是目标合约中我们要调用的函数。

**示例：**

```solidity
function callSetX(address _Address, uint256 x) external {
    OtherContract(_Address).setX(x);
}

```

- **`_Address`**：传递目标合约的地址。
- **`setX(x)`**：这是目标合约中的函数，用来设置状态变量`x`。

##### 传入合约变量

**语法：**

```solidity
function callGetX(OtherContract _Address) external view returns (uint x) {
    x = _Address.getX();
}

```

- **`OtherContract _Address`**：函数参数为目标合约的引用类型`OtherContract`，这个引用在外部生成并传递给函数。
    ß- 参数`OtherContract _Address`底层类型仍然是`address`，生成的`ABI`中、调用`callGetX`时传入的参数都是`address`类型
- **`_Address.getX()`**：直接通过传入的合约引用调用其函数。


#####  创建合约变量
在这种方式中，我们在函数内部创建目标合约的引用，然后通过该引用调用目标函数。相比第一种方式，这里我们将引用赋值给一个局部变量`oc`。这种方式适用于当我们在函数中要多次使用合约引用时，可以避免多次创建临时引用。通过将引用保存到一个局部变量中，可以提高代码的可读性。

**语法：**

```solidity
function callGetX2(address _Address) external view returns (uint x) {
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}

```

- **`OtherContract oc = OtherContract(_Address);`**：在函数内部创建一个合约变量`oc`，它是目标合约的引用。
- **`oc.getX()`**：通过这个局部变量调用目标函数。

##### 调用合约并发送`ETH`
如果目标合约的函数是`payable`的，允许发送`ETH`，我们可以在调用函数时通过**Solidity的特殊语法**`_Name(_Address).f{value: _Value}()`来发送`ETH`。此时我们需要通过`{value: _Value}`来指定发送的`ETH`数量。

**语法：**

```solidity
function setXTransferETH(address otherContract, uint256 x) payable external {
    OtherContract(otherContract).setX{value: msg.value}(x);
}

```

- **`payable`**：函数必须使用`payable`关键字，表示该函数可以处理`ETH`转账。
- **`msg.value`**：这是发送到目标合约的`ETH`金额，以`wei`为单位。
- **`setX{value: msg.value}(x)`**：调用目标合约的`payable`函数，并通过`{value: msg.value}`的语法发送`ETH`。

##### 总结表格
| 方法 | 语法 | 使用规则 | 适用场景 |
| --- | --- | --- | --- |
| 通过合约地址创建引用 | `OtherContract(_Address).f()` | 需要目标合约地址，每次调用时传入地址 | 快速调用已知地址的合约 |
| 通过合约变量传递引用 | `callGetX(OtherContract _Address)` | 需要目标合约引用（类型为合约），函数参数为引用 | 减少重复创建引用，适合频繁调用函数 |
| 在函数内部创建合约引用 | `OtherContract oc = OtherContract(_Address)` | 在函数内部创建引用，多次使用同一个合约引用 | 在函数中多次使用同一个合约时 |
| 调用`payable`函数并发送`ETH` | `_Name(_Address).f{value: _Value}()` | 需要目标函数为`payable`，发送`ETH`时需使用`value` | 调用`payable`函数并且发送`ETH` |
##### 测验结果
- 40/100
- 80/100
- 100/100

##### 测验错题
```solidity
//OtherContract 合约如下：
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

interface IOtherContract {
    function getBalance() external returns(uint);
    function setX(uint256 x) external payable;
    function getX() external view returns(uint x);
}

contract OtherContract is IOtherContract{
    uint256 private _x = 0;
    event Log(uint amount, uint gas);
    
    function getBalance() external view override returns(uint) {
        return address(this).balance;
    }

    function setX(uint256 x) external override payable{
        _x = x;
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    function getX() external view override returns(uint x){
        x = _x;
    }
}
```
1. 下列写法正确的是
    ```solidity
    (1) OtherContract other = OtherContract(0xd9145`CCE52D386f254917e481eB44e9943F39138)
    (2) IOtherContract other = IOtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138)`
    ```
    - (1) 正确。如果 `0xd9145CCE52D386f254917e481eB44e9943F39138` 是一个已部署的 `OtherContract` 合约的地址，那么你可以通过这个地址创建一个 `OtherContract` 类型的变量 `other`。这样你就可以调用 `OtherContract` 中的所有公开（public）和外部（external）函数。
    
    - (2) 正确。可以通过这个地址创建一个 `IOtherContract` 接口类型的变量 `other`。这样你只可以调用 `IOtherContract` 中声明的函数。这种方式可以增加代码的灵活性，因为你可以将不同合约实现的接口视为相同类型，从而使合约调用更具通用性。

定义`MyContract`
    ```solidity
    contract MyContract {
        OtherContract other = OtherContract(0xd9145CCE52D386f254917e481eB44e9943F39138);
        function call_getX() external view returns(uint x){
            x = other.getX();
        }
        function call_setX(uint256 x) external{
            other.setX(x);
        }
    }
    ```

2. 下列说法正确的是：
    A. `MyContract` 是 `OtherContract` 的子类
    - **错误**。`MyContract` 不是 `OtherContract` 的子类。它只是通过合约地址引用了 `OtherContract` 的实例，而没有继承 `OtherContract` 的属性和方法。

    B. `MyContract` 是 `IOtherContract` 的一个实现 
    - **错误**。`MyContract` 并没有实现 `IOtherContract` 接口。它使用了 `OtherContract` 的实例，但自身并没有声明为实现该接口。

    C. `MyContract` 需要 `0xd9145CCE52D386f254917e481eB44e9943F39138` 的某种许可，才可以调用其中的函数
    - **错误**。在 Solidity 中，合约之间的调用不需要许可。只要合约地址正确且函数可见，`MyContract` 就可以直接调用 `OtherContract` 的公开函数。

    D. `MyContract` 的函数 `call_setX` 可以实现，这意味着 `OtherContract` 中 `setX` 的权限没有门槛，存在安全隐患 
    - **正确**。`call_setX` 函数直接调用了 `OtherContract` 的 `setX` 函数，并且没有任何权限检查，这可能会导致未授权的调用，存在安全隐患。特别是如果 `setX` 是一个 `payable` 函数，而没有适当的条件或限制，就可能被恶意合约滥用。

3. 调用结果：
    ```solidity
    (1) 在 0xd9145CCE52D386f254917e481eB44e9943F39138 调用函数 setX(10);
    (2) 在 0xd9145CCE52D386f254917e481eB44e9943F39138 调用函数 getX();
    (3) 在 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99 调用函数 call_setX(20);
    (4) 在 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99 调用函数 call_getX();
    ```

    - 初始状态下，`_x` 的值为 `0`。
    - (1) 在 0xd9145CCE52D386f254917e481eB44e9943F39138 调用函数 setX(10);
        - **执行结果**: 成功。
        - **状态变化**: `OtherContract` 的 `_x` 变量被设置为 `10`。
        - **返回值**: 该函数没有返回值，只有事件被触发（如果有 ETH 被发送的话）。
    - (2) 在 0xd9145CCE52D386f254917e481eB44e9943F39138 调用函数 `getX();`
        - **执行结果**: 成功。
        - **返回值**: `10`（因为 `_x` 已被更新）。
    - (3) 在 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99 调用函数 `call_setX(20);`
        - **执行结果**: 成功。
        - **状态变化**: `OtherContract` 的 `_x` 变量被设置为 `20`。
        - **返回值**: 该函数没有返回值。
    - (4) 在 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99 调用函数 `call_getX();`
        - **执行结果**: 成功。
        - **返回值**: `20`（因为 `_x` 已被更新到 `20`）。

    - **(1)** 成功，返回值：无（状态变化：`_x = 10`）。
    - **(2)** 成功，返回值：`10`。
    - **(3)** 成功，返回值：无（状态变化：`_x = 20`）。
    - **(4)** 成功，返回值：`20`。

### 2024.10.14
#### WTF Academy Solidity 102.22 Call
`call` 是 `Solidity` 提供的低级成员函数，用来与其他合约交互，特别是当我们不知道目标合约的 `ABI` 时，它可以通过发送字节码直接调用目标合约的函数。

##### `call` 的语法结构
```solidity
(bool success, bytes memory data) = address.call{value: 发送的ETH, gas: gas数额}(字节码);
```


1. **目标地址**: 
   `address.call` 用于指定目标合约的地址，调用这个地址上的合约或发送 ETH。

2. **可选参数**:
   - `{value: 发送的ETH}`: 发送的 ETH 数额（单位为 wei）。如果不需要发送 ETH，可以省略。
   - `{gas: gas数额}`: 指定调用时允许使用的最大 gas 数量。如果不指定，默认会使用全部可用的 gas。

3. **字节码**: 
   - `abi.encodeWithSignature("函数签名", 参数)` 用于生成调用函数的字节码。函数签名为 `"函数名(参数类型列表)"`，后面接具体的参数值。

4. **返回值**:
   - `bool success`: 表示调用是否成功，`true` 表示成功，`false` 表示失败。
   - `bytes memory data`: 返回的字节数据，可以通过 `abi.decode` 来解码获取具体的返回值。

##### 用法
###### 目标合约
```solidity
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

1. **调用目标合约的 `payable` 函数并发送 ETH**:

```solidity
(bool success, bytes memory data) = targetAddress.call{value: 1 ether}(
    abi.encodeWithSignature("setX(uint256)", 42)
);
```

2. **调用目标合约的 `view` 函数**（无需发送 ETH）:

```solidity
(bool success, bytes memory data) = targetAddress.call(
    abi.encodeWithSignature("getX()")
);
uint256 x = abi.decode(data, (uint256)); // 解码返回值
```

3. **调用不存在的函数**（会触发目标合约的 `fallback` 或 `receive` 函数）:

```solidity
(bool success, bytes memory data) = targetAddress.call(
    abi.encodeWithSignature("nonExistentFunction()")
);
```

4. **仅发送 ETH 而不调用任何函数**:

```solidity
(bool success, ) = targetAddress.call{value: 1 ether}("");
require(success, "ETH transfer failed");
```

##### 测验结果
- 100/100
##### 测验错题


### 2024.10.15
#### WTF Academy Solidity 102.23 Delegatecall

#####
`delegatecall` 是 Solidity 中一种特殊的低级调用方式，允许一个合约在另一个合约的上下文中执行其代码。简单来说，它让调用者（调用方合约）的存储和上下文被目标合约的逻辑操作。

区别于常规的 `call`，`delegatecall` 不会将调用的上下文切换到被调用合约的上下文，而是保持在调用合约的上下文中。这意味着，任何对状态变量的修改都会影响调用合约的变量，而不是被调用合约的变量。

`delegatecall` 主要在代理合约模式中使用，这种模式通过将存储和逻辑分离，允许合约升级功能，而不需要更换合约地址。常见场景有：

1. **代理合约 (Proxy Contract)**：将逻辑合约和存储合约分离，通过代理合约来调用逻辑合约的功能。
2. **EIP-2535 Diamonds 标准**：允许合约在生产中扩展和模块化。

##### 代码示例：合约 B 调用合约 C 的代码

1. **被调用的合约 `C`**

这个合约有两个变量：`num` 和 `sender`。其中 `num` 是存储的一个整数，`sender` 是存储调用者地址的一个变量。合约中的 `setVars` 函数用于更新这两个变量：

```solidity
// 被调用的合约C
contract C {
    uint public num;
    address public sender;

    // 更新 num 和 sender，记录调用者
    function setVars(uint _num) public payable {
        num = _num; // 更新 num
        sender = msg.sender; // 更新调用者地址，注意这里的 msg.sender 是调用该函数的合约地址
    }
}

```
- `num`: 存储一个 `uint` 型的数。
- `sender`: 存储调用者的地址。
- `setVars`: 更新 `num` 和 `sender`。`msg.sender` 是调用该函数的账户地址，通常是合约的地址或外部账户。

**2. 发起调用的合约 `B`**

合约 `B` 中也有两个相同类型和顺序的状态变量：`num` 和 `sender`，以保证 `delegatecall` 时存储布局一致。

```solidity
contract B {
    uint public num;
    address public sender;
}

```

- 合约 `B` 的状态变量必须与合约 `C` 保持一致的存储布局，以确保 `delegatecall` 调用时不会出现存储冲突。

**3. 使用 `call` 调用**

先通过 `call` 来调用合约 `C` 的 `setVars` 函数，观察效果：

```solidity
// 通过 call 调用 C 合约的 setVars() 函数，更新 C 合约中的状态变量
function callSetVars(address _addr, uint _num) external payable {
    (bool success, bytes memory data) = _addr.call(
        abi.encodeWithSignature("setVars(uint256)", _num) // 将函数和参数编码为二进制数据
    );
}

```

- `_addr`: `C` 合约的地址。
- `_num`: 要传递的数值，更新 `num`。
- `call`: 普通调用会在 `C` 合约的上下文中执行函数，修改 `C` 合约的 `num` 和 `sender`。

当使用 `call` 时，合约 `B` 调用 `C` 合约的函数，执行的上下文是 `C` 合约的，所以任何状态变量的变化都体现在 `C` 合约上，`msg.sender` 是合约 `B` 的地址。

**4. 使用 `delegatecall` 调用**

通过 `delegatecall`，合约 `B` 可以调用 `C` 合约的代码，但状态变量的更改会发生在 `B` 的存储中，而不是 `C`：

```solidity
// 通过 delegatecall 调用 C 合约的 setVars() 函数，更新 B 合约中的状态变量
function delegatecallSetVars(address _addr, uint _num) external payable {
    (bool success, bytes memory data) = _addr.delegatecall(
        abi.encodeWithSignature("setVars(uint256)", _num) // 将函数和参数编码为二进制数据
    );
}

```
- `delegatecall`: 执行 `C` 合约的代码，但对状态变量的操作发生在 `B` 合约中。`msg.sender` 是调用者地址（即最初发起交易的用户）。
- 由于 `delegatecall` 保持了调用合约（`B`）的上下文，`num` 和 `sender` 的更新会影响 `B` 合约中的变量，而不是 `C`。

##### `call` 和 `delegatecall`对比

- **`call`**：在被调用合约的上下文中执行代码，修改的是被调用合约的状态变量。
- **`delegatecall`**：在调用合约的上下文中执行目标合约的代码，修改的是调用合约的状态变量。

这两者的核心区别是状态变量的存储位置，以及 `msg.sender` 的值。使用 `delegatecall` 时，注意存储布局一致性以及目标合约的安全性，以避免潜在的安全漏洞。

##### 测验结果
- 100/100

### 2024.10.16
#### WTF Academy Solidity 102.24 Create

##### `Create`基本语法
```solidity
Contract x = new Contract{value: _value}(params);
```
- `Contract` 是要创建的新合约类型。
- `x` 是存储新合约地址的变量。
- `{value: _value}` 是可选的，表示可以在创建时发送一定数量的`ETH`。
- `(params)` 是传递给新合约构造函数的参数。

##### 代码示例
###### 简单的创建合约
```solidity
// 被创建的合约
contract NewContract {
    uint public x;
    address public creator;

    constructor(uint _x) payable {
        x = _x;
        creator = msg.sender;
    }
}

// 用于创建新合约的合约
contract Creator {
    function createNewContract(uint _x) external payable returns (address) {
        NewContract newContract = new NewContract{value: msg.value}(_x);
        return address(newContract);
    }
}
```

1. `NewContract` 是要创建的目标合约，它有一个`uint`类型的变量`x`，并记录创建者的地址。
2. 构造函数中接受`x`的值并设置`msg.sender`为`creator`。
3. `Creator` 合约有一个函数 `createNewContract`，通过 `new` 创建一个 `NewContract` 实例，同时传入构造函数参数 `_x`，并附带`ETH`。
4. 在Remix上验证，通过Creator创建后，返回`decoded output: {
	"0": "address: 0xeae1f6F987196E95E526B1601119D1d5Bb3Ed03F"
}`
###### Uniswap V2
```solidity
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
- `mapping(address => mapping(address => address)) public getPair;`
    - 这是一个嵌套的映射，作用是通过**两个代币的地址**查找它们对应的**交易对合约地址**。例如，如果你有两个代币的地址`tokenA`和`tokenB`，你可以通过`getPair[tokenA][tokenB]`查询它们对应的交易对地址。
    - **外层`address`**：代表第一个代币（`tokenA`）的地址。
    - **内层`address`**：代表第二个代币（`tokenB`）的地址。
    - **最终的`address`**：是这两个代币组成的交易对（Pair）的合约地址。
- `address[] public allPairs;`
    - 这是一个保存所有交易对（Pair）合约地址的数组。
    - **`address[]`**：表示一个存储地址类型的数组，每个地址代表一个交易对合约的地址。
    - **`public`**：这个数组是公开的，因此可以直接读取它的内容。
    - **`allPairs`**：这个数组用于存储所有已经创建的交易对地址，顺序依次加入每次创建的新交易对。
- `createPair`函数
    - 创建新的`Pair`合约实例。
    - 调用`Pair`合约的`initialize`函数，传入两个代币地址以初始化币对。
    - 记录并存储新创建的币对地址。
##### 测验结果
- 100/100

### 2024.10.17
#### WTF Academy Solidity 102.25 `Create2`
##### `CREATE2` 计算合约地址的方式

`CREATE2` 用四个参数来生成合约地址：

1. `0xFF`: 常数，用于区分 `CREATE` 和 `CREATE2`。
2. `CreatorAddress`: 当前创建合约的地址（调用 `CREATE2` 的合约地址）。
3. `salt`：一个创建者指定的 `bytes32` 类型的值，用于增加地址的可控性。
4. `initcode`: 新合约的字节码，包含合约的创建代码和构造函数的参数。

生成合约地址的计算公式如下：

```
新合约地址 = hash("0xFF", 创建者地址, salt, initcode)

```

这意味着合约的地址是确定的，只要指定了相同的 `salt` 和 `initcode`，无论何时何地合约被部署，生成的地址都会保持不变。

##### `CREATE2` 与 `CREATE` 的区别

- **`CREATE`**:
    - 合约地址由调用者地址和 `nonce` 的哈希计算得出，因此地址随着调用者的 `nonce` 变化而变化，不易预测。
    - 地址计算公式：`hash(创建者地址, nonce)`。
- **`CREATE2`**:
    - 合约地址与未来状态无关，部署之前可以预测。
    - 地址计算由 `0xFF`、调用者地址、`salt` 和合约的 `initcode` 计算而得。
    - 地址计算公式：`hash("0xFF", 创建者地址, salt, initcode)`。

##### 使用 `CREATE2` 的语法

`CREATE2` 的使用方式与 `CREATE` 类似，唯一的区别是需要额外提供一个 `salt` 参数：

```solidity
Contract x = new Contract{salt: _salt, value: _value}(params);

```

- `Contract`: 要创建的合约类型。
- `x`: 新合约的地址。
- `_salt`: 32 字节的盐值，用于影响新合约的地址。
- `_value`: 可选的 `ETH` 发送金额（如果合约的构造函数是 `payable`）。
- `params`: 新合约构造函数的参数。

##### 测验结果
- 100/100


### 2024.10.18 `SelfDestruct`自毁
`selfdestruct`是智能合约中的一种操作，用于销毁合约并将合约剩余的`ETH`余额转移到指定地址。这个功能设计的初衷是应对合约发生错误时的极端情况。起初它被命名为`suicide`（自杀），但由于敏感性问题，后来改名为`selfdestruct`。
坎昆升级后，[EIP-6780](https://eips.ethereum.org/EIPS/eip-6780)对`selfdestruct`进行了功能限制。该提案是为了支持Verkle Tree，而限制`SELFDESTRUCT`操作码的功能，改变后它只能转移ETH，删除合约的功能只有在同一笔交易中创建和销毁合约时才会生效。

以下是基本的`selfdestruct`调用方式：

```solidity
selfdestruct(_addr);
```

其中`_addr`为接收合约中剩余ETH的地址，无需该地址包含`receive()`或`fallback()`函数。
##### 坎昆升级后`SelfDestruct`最新特性
1. **已经部署的合约无法被完全销毁**：`selfdestruct`不再具有销毁功能，仅能转移合约余额。合约只会转移ETH，合约本身依然存在，且可以继续交互。
2. **同一交易中合约创建和销毁**：若在同一笔交易中执行合约创建和`selfdestruct`，则删除功能才会生效。

##### 代码示例
在以下示例中，合约通过`selfdestruct`功能实现了内部ETH的转移：

```solidity
contract DeleteContract {

    uint public value = 10;

    constructor() payable {}

    receive() external payable {}

    function deleteContract() external {
        // 通过selfdestruct将合约剩余的ETH转入msg.sender
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}

```

在合约中：

- `value`是一个状态变量，用来表示一个存储值。
- `getBalance()`用于查询合约余额。
- `deleteContract()`用于调用`selfdestruct`，将合约的ETH转移给调用者（发起者）。

通过另一个合约创建并销毁子合约，满足坎昆升级后的限制：

```solidity
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

- 通过`DeployContract`合约创建`DeleteContract`合约并立即调用`deleteContract`。
- 这样可以确保在同一笔交易内完成创建和销毁，合约成功删除且余额转移。

##### 测验结果
- 100/100

#### WTF Academy Solidity 102.26

##### 笔记

##### 测验结果

##### 测验错题

### 2024.10.19
#### WTF Academy Solidity 102.27

##### 笔记

##### 测验结果

##### 测验错题

### 2024.10.20
#### WTF Academy Solidity 102.28

##### 笔记

##### 测验结果

##### 测验错题

### 2024.10.21
#### WTF Academy Solidity 102.29

##### 笔记

##### 测验结果

##### 测验错题

### 2024.10.22
#### WTF Academy Solidity 102.30

##### 笔记

##### 测验结果

##### 测验错题
<!-- Content_END -->
