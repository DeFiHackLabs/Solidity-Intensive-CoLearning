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



<!-- Content_END -->
