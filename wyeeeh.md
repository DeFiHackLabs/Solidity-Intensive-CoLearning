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

##### 笔记


##### 测验结果


##### 测验错题

<!-- Content_END -->
