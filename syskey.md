---
timezone: Asia/Shanghai
---

# syskey

1. 自我介绍

    大家好，我是syskey，很早之前跟着A大写的[ether](https://github.com/WTFAcademy/WTF-Ethers)教程学习，后续完成了[solidity 101](https://github.com/AmazingAng/WTF-Solidity)的学习。趁此机会把后面的课程也学习下。

2. 你认为你会完成本次残酷学习吗？

    一定会的。
   
## Notes

<!-- Content_START -->

### 2024.09.23

学习内容: 
1. 第一讲
    - 了解`Solidity`合约文件的基本结构(软件许可、版本号、合约主体)，学习使用`Remix`部署简单的合约文件。
2. 第二讲
    - 学习**值类型(Value type)**、**引用类型(Reference Type)**、**映射类型(Mapping Type)**。要记得在逻辑运算用`&&`和`||`遵循的是短路规则(`&&`：如果左边为 `false`，右边不再评估; `||`：如果左边为 `true`，右边不再评估)。
    - 普通地址（address）不能接收以太币的转账。
    - 可支付地址（payable address）是可以接收以太币的地址，可以使用 .transfer() 或 .send() 来接收转账。
        ```solidity
        // SPDX-License-Identifier: MIT

        address public eoa_address = 0x220866B1A2219f40e72f5c628B65D54268cA3A9D;
        address payable public payable_address = payable(eoa_address); // 将普通地址转成payable address，可以转账、查余额
        // 地址类型的成员
        uint256 public balance = payable_address.balance; // payable地址查询余额
        ```
3. 第三讲
    - 学习`Solidity`的函数表达式`function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]`
    - `public`：内部和外部均可见。
    - `private`：只能从本合约内部访问，继承的合约也不能使用。
    - `external`：只能从合约外部访问（但内部可以通过 `this.f()` 来调用，`f`是函数名）。
    - `internal`: 只能从合约内部访问，继承的合约可以用。
    - **注意 1**：合约中定义的函数需要明确指定可见性，它们没有默认值。

    - **注意 2**：`public|private|internal` 也可用于修饰状态变量。`public`变量会自动生成同名的`getter`函数，用于查询数值。未标明可见性类型的状态变量，默认为`internal`。
    - view 函数：
        - 作用：view 修饰符表示函数可以读取区块链上的状态（如存储变量），但不能修改状态。
        - 特性：调用 view 函数不会改变区块链的状态，因此不会产生 gas 费用（除非在交易中调用）。
        ```Solidity
        // SPDX-License-Identifier: MIT

        pragma solidity ^0.8.0;

        contract Example {
            uint256 public storedData = 42;

            // view函数：读取状态变量 storedData
            function getStoredData() public view returns (uint256) {
                return storedData;
            }
        }
        ```
    - pure 函数：
        - 作用：pure 修饰符表示函数既不能读取区块链上的状态变量，也不能修改状态变量。它只能基于函数的输入参数进行计算，完全独立于合约的状态。
	    - 特点：
	        - 不能读取任何存储的状态（例如，不能读取合约中的状态变量）。
	        - 不能访问像 msg.sender、block.timestamp 等全局变量，因为它们依赖于区块链的状态。
	        - 函数仅依赖输入参数或函数内部定义的变量进行操作。
        ```Solidity
        // SPDX-License-Identifier: MIT

        pragma solidity ^0.8.0;

        contract Example {

            // pure函数：不访问或修改状态变量，只进行计算
            function add(uint256 a, uint256 b) public pure returns (uint256) {
                return a + b;
            }
        }
        ```
4. 第四讲
    - 学习函数的返回值，其中包括(返回多种变量、命名式返回、以及解构赋值读取一个或多个返回值)。
    - `returns`：跟在函数名后面，用于声明返回的变量类型及变量名。
    - `return`：用于函数主体中，返回指定的变量。
    - 命名式返回是在`returns`中填写指定的要返回的变量名称和类型，而无需在函数体中使用`return`。
    - 解构赋值是指在读取函数返回值时可以使用`空内容`代替不需要的返回值
        ```solidity
        // SPDX-License-Identifier: MIT
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;

        // 命名式返回
        function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
            _number = 2;
            _bool = false;
            _array = [uint256(3),2,1];
        }
        (_number, _bool, _array) = returnNamed(); // 读取所有返回值
        (, _bool2, ) = returnNamed(); // 只读取_bool2返回值
        ```
5. 第五讲
    - 在Solidity数据存储位置有三类：`storage`，`memory`和`calldata`。不同存储位置的`gas`成本不同。`storage`类型的数据存在链上，类似计算机的硬盘，消耗`gas`多；`memory`和`calldata`类型的临时存在内存里，消耗`gas`少。其中`calldata`多用于函数的参数中，因为`calldata`是不可以修改的。
    - `storage`引用类型赋值后，修改新变量的值也会影响原变量的值。
        ```Solidity
        // SPDX-License-Identifier: MIT

        uint[] x = [1,2,3]; // 状态变量：数组 x

        function fStorage() public{
            //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
            uint[] storage xStorage = x;
            xStorage[0] = 100;
        }
        ```
    - 变量的作用域分别是**状态变量（state variable）**，**局部变量（local variable）**和**全局变量(global variable)**。其中**状态变量（state variable）**是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明。**全局变量(global variable)**是`Solidity`预留的关键词，无需声明可以直接在函数内使用。更完整的全局变量列表看这个[链接](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)。

    - 在 Solidity 中，所有数字都是以整数形式处理的，不支持浮点数或小数点。这意味着以太币的值在智能合约中存储时，也是以最小单位 wei（1 ether = 10^18 wei）表示的，这种做法有助于确保交易的精确度并防止精度损失。
        ```Solidity
        // SPDX-License-Identifier: MIT
        pragma solidity ^0.8.0;

        contract EtherUnitsExample {
            
            // 返回以ether为单位传入的金额，以wei为单位返回结果
            function convertEtherToWei(uint amountInEther) public pure returns (uint) {
                return amountInEther * 1 ether;  // 1 ether = 10^18 wei
            }

            // 返回以gwei为单位传入的金额，以wei为单位返回结果
            function convertGweiToWei(uint amountInGwei) public pure returns (uint) {
                return amountInGwei * 1 gwei;  // 1 gwei = 10^9 wei
            }

            // 接收函数，允许合约接收ether
            receive() external payable {}

            // 返回合约当前余额 (以 wei 为单位)
            function getContractBalance() public view returns (uint256) {
                return address(this).balance;
            }

            // 转账指定金额（单位：wei）到某个地址
            function sendEther(address payable recipient, uint256 amountInWei) public {
                require(address(this).balance >= amountInWei, "Insufficient balance in contract");
                recipient.transfer(amountInWei);
            }
        }
        ```
### 

### 2024.09.24

学习内容: 
1. 第六讲
    - 固定长度数组 - 在声明时指定数组的长度。用T[k]的格式声明，其中T是元素的类型，k是长度
        ```Solidity
        // 固定长度 Array
        uint[8] array1;
        bytes1[5] array2;
        address[100] array3;
        ```
    - 动态数组 - 在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型
        ```Solidity
        // 可变长度 Array
        uint[] array4;
        bytes1[] array5;
        address[] array6;
        bytes array7;
        ```
    **需要注意**：bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

    - 对于`memory`修饰的动态数组，可以用`new`操作符来创建，但是必须声明长度，并且声明后长度不能改变。
        ```Solidity
        // memory动态数组
        uint[] memory array8 = new uint[](5);
        bytes memory array9 = new bytes(9);
        ```
    - 数组方法
        - `length`: 数组有一个包含元素数量的`length`成员，`memory`数组的长度在创建后是固定的。
        - `push()`: `动态数组`拥有`push()`成员，可以在数组最后添加一个`0`元素，并返回该元素的引用。
        - `push(x)`: `动态数组`拥有`push(x)`成员，可以在数组最后添加一个`x`元素。
        - `pop()`: `动态数组`拥有`pop()`成员，可以移除数组最后一个元素。

    - 在 Solidity 中，struct（结构体）是一种自定义的数据类型，它允许开发者组合不同类型的变量（如 uint、string、address 等）到一个单一的实体中。struct 类似于其他编程语言中的结构体或对象，用于组织复杂的数据结构。
        ```Solidity
        pragma solidity ^0.8.0;

        contract Example {
            // 定义一个 struct 类型
            struct Person {
                string name;
                uint age;
                address wallet;
            }

            // 使用 struct 定义变量
            Person public person1;
            Person[] public people; // 数组可以存储多个 struct 实例

            // 添加 struct 实例的函数
            function addPerson(string memory _name, uint _age, address _wallet) public {
                // 初始化并存储到数组
                people.push(Person(_name, _age, _wallet));
            }

            // 获取 struct 数据
            function getPerson(uint index) public view returns (string memory, uint, address) {
                // 从数组中取出 struct 实例
                Person memory person = people[index];
                return (person.name, person.age, person.wallet);
            }
        }
        ```
    **需要注意，struct 中的字段顺序会影响其在存储中的布局，存储时会以最有效的方式进行压缩。为了优化 gas，可以将相同大小的数据类型放在一起。**

	**struct 不能包含自身实例，也不能包含动态长度的数组或映射。**

2. 第七讲
    - `mapping`（映射）是一种特殊的数据结构，用于将唯一的键（key）映射到对应的值（value）。`mapping`本质上类似于其他编程语言中的哈希表或字典，但在 Solidity 中具有一些独特的特性。
    - `mapping`的语法形式`mapping(keyType => valueType) visibility variableName;`
        - keyType：键的类型，可以是任何基础类型（如 address、uint 等），但不能是复杂类型（如 struct、mapping 等）。
        - valueType：值的类型，可以是任意类型，包括 struct、array 甚至 mapping。
        - visibility：映射的可见性，可以是 public、internal 或 private。
        - variableName：映射的名称。
    - `Solidity`的状态变量是存储在 区块链的存储槽（storage slot） 中。每个合约都有自己的存储空间，存储的每一个状态变量都有一个特定的存储槽位置（256 位）。对于简单类型，如 uint256、address，它们存储在连续的存储槽中。而 mapping 的存储更加特殊，主要依赖于哈希计算。
    - `mapping`的存储：
        - 每个 mapping 都占据一个固定的存储槽，假设这个槽的索引是 p。
	    - 当访问某个键（key）对应的值时，Solidity 会通过以下公式计算存储槽的位置：
        ```Solidity
        keccak256(abi.encode(key, p))
        ```
    - `mapping`的特性和限制
        - **键不可遍历**：mapping 的存储设计使得键值对是分散存储的，不是按顺序存储的。这意味着 mapping 无法遍历或枚举所有的键。为了遍历或记录 mapping 中的所有键，你需要手动存储这些键，例如通过一个辅助数组来记录插入的键。
        - **哈希函数的唯一性**：由于 keccak256 是加密安全的哈希函数，它几乎保证不同的键会映射到不同的存储槽。这使得 mapping 非常高效，并且不会产生冲突。
        - **默认值**：对于 mapping 中未初始化的键，读取键的值时，会返回其类型的默认值（比如 uint 默认返回 0，address 默认返回 0x0）。这是因为在存储槽中没有找到相关的值时，Solidity 直接返回默认值。
        - **存储和 gas 成本**：虽然 mapping 的设计非常节省空间，但每次对 mapping 的访问都涉及到哈希运算。因此，尽管存储高效，但计算存储槽位置的成本（即 gas 消耗）取决于键和槽的复杂度。
        - **嵌套 mapping**：mapping 可以嵌套使用，例如 mapping(address => mapping(uint => bool))。在这种情况下，外层 mapping 和内层 mapping 的存储槽都会通过哈希函数计算。每一层都会产生一个独立的哈希槽。
    - 拓展：为什么 `mapping` 不能遍历？
        - 这是因为 mapping 的键值对并没有存储在连续的内存槽中，而是通过哈希散列的方式分布在不同的存储槽。因此，Solidity 没有简单的方式来依次读取所有键，除非在代码中手动存储键。

        - 如果需要遍历 mapping，通常的做法是使用一个数组来记录所有曾经存入过 mapping 的键：
        ```Solidity
        pragma solidity ^0.8.0;

        contract Example {
            mapping(address => uint) public balances;
            address[] public keys; // 记录所有 key

            function setBalance(address _account, uint _amount) public {
                if (balances[_account] == 0) {
                    keys.push(_account); // 只在首次设置时记录 key
                }
                balances[_account] = _amount;
            }

            function getAllKeys() public view returns (address[] memory) {
                return keys;
            }
        }
        ```

3. 第八讲
    - 变量的初始值(也就是只声明变量，未赋值)，其中又分为**值类型初始值**和**引用类型初始值**
    - **值类型初始值**
        - `boolean`: `false`
        - `string`: `""`
        - `int`: `0`
        - `uint`: `0`
        - `enum`: 枚举中的第一个元素
        - `address`: `0x0000000000000000000000000000000000000000` (或 `address(0)`)
        - `function`
        - `internal`: 空白函数
        - `external`: 空白函数
    - **引用类型初始值**
        - 映射`mapping`: 所有元素都为其默认值的`mapping`
        - 结构体`struct`: 所有成员设为其默认值的结构体
        - 数组`array`
        - 动态数组: `[]`
        - 静态数组（定长）: 所有成员设为其默认值的静态数组
    - **`delete`操作符只会让变量的值变为初始值，并不会删除此变量**。

4. 第九讲
    - constant（常量）和 immutable（不变量）都是用于定义不会在合约生命周期中改变的变量。它们的共同点是能够帮助优化 gas 消耗，因为 Solidity 编译器可以对这些变量进行优化，但它们的使用场景和行为有所不同。
        - **constant（常量）**：constant 修饰符用于定义编译时就确定值的变量。它们的值在编译期间就确定下来，不能在运行时被修改。常量通常用于定义那些在合约生命周期中绝不会改变的值，例如数学常数、代币符号、初始配置参数等。
            - 语法：`type constant variableName = value;`
                - type：常量的类型（例如 uint256、address、string 等）。
                - constant：关键字，表示变量是常量。
                - variableName：常量的名称。
                - value：变量的值，必须在声明时指定。
                ```Solidity
                pragma solidity ^0.8.0;

                contract MyContract {
                    uint256 public constant MAX_SUPPLY = 1000000;  // 常量值在编译时确定
                    string public constant SYMBOL = "TEST";     // 代币符号
                }
                ```
            - 特点
                - **不占用存储**：常量不占用存储空间，编译器会直接将它们的值内嵌到字节码中。这样做可以显著降低合约的存储成本，并且减少读取时的 gas 消耗。
                - **只能定义基础类型**：常量只能用于基础类型的数据，例如 uint、address、bool、string 等，不能用于 struct 或 array 这样的复杂类型。 
        - **immutable（不变量）**：修饰符用于定义在部署时确定值的变量。这意味着它的值是在部署合约时根据构造函数或其他逻辑来设置的，而一旦部署完成，它的值就不能被更改。
            - 语法：`type immutable variableName;`
                - type：不变量的类型。
                - immutable：关键字，表示变量是不可变的。
                - variableName：不变量的名称。
                ```Solidity
                pragma solidity ^0.8.0;

                contract MyContract {
                    address public immutable owner;
                    
                    constructor(address _owner) {
                        owner = _owner; // 在部署时通过构造函数赋值
                    }
                }
                ```
            - 特点
                - **更灵活**：与 constant 相比，immutable 变量允许在运行时动态设置值，但设置值的操作只能在合约的部署阶段完成。
	            - **优化存储**：与 constant 类似，immutable 变量不需要存储在存储槽中。它们被存储在合约的代码中，从而减少了存储成本。
    - constant 和 immutable 的区别
        | 特性               | `constant`                  | `immutable`                |
        |--------------------|-----------------------------|----------------------------|
        | **赋值时间**       | 编译时确定                   | 部署时确定                 |
        | **修改性**         | 无法修改，编译时即固定       | 部署时设定后不可修改       |
        | **存储方式**       | 不占用存储槽，值嵌入字节码   | 类似，值存储在合约代码中   |
        | **数据类型**       | 仅支持基础类型               | 支持任何类型，包括 `struct`、`array` |
        | **适用场景**       | 用于绝对不会改变的常量       | 用于在部署时确定的变量     |
        | **存储成本**       | 较低（嵌入字节码）           | 较低（存在代码中）         |
        | **使用方式**       | 适合常量，如代币符号、数学常数等 | 适合部署时动态确定的值，如管理员地址 |

5. 第十讲
    - `Solidity`的控制流与其他语言类似，主要包含以下几种：
        - `if-else`
        - `for循环`
        - `while循环`
        - `do-while循环`
        - `三元运算符`: 三元运算符是`Solidity`中唯一一个接受三个操作数的运算符，规则`条件? 条件为真的表达式:条件为假的表达式`。此运算符经常用作`if`语句的快捷方式。
        - `continue`（立即进入下一个循环）和`break`（跳出当前循环）关键字可以使用。
    - 循环注意事项
        - **避免无限循环**：由于 Solidity 中的 gas 限制，如果循环条件没有正确处理，可能会导致函数耗尽所有 gas，从而导致交易失败。
    - 拓展：`Solidity`中最常用的变量类型是`uint`，也就是正整数。在循环中如果遇到变量可能取到**负值**的情况下，会造成`下溢(underflow)`错误。正确的做法可以通过主动限制变量的值为正数或者在有风险的地方进行防护处理。
###

### 2024.09.25

学习内容: 
1. 第十一讲
    - 构造函数(`constructor`)是一种特殊的函数，每个合约只可以定义一个，用来在部署合约时初始化一些参数，并且只会运行一次。
        ```Solidity
        address owner;

        constructor (address initialOwner) {
            owner = initialOwner; // 部署合约时，将owner设置为传入的initialOwner地址
        }
        ```
    - 修饰器(`modifier`)是`Solidity`特有的语法，类似于面向对象编程中的装饰器(`decorator`)。`modifier`的主要使用场景是运行函数前的检查，例如地址，变量，余额等。
        ```Solidity
        // 定义modifier
        modifier onlyOwner {
            require(msg.sender == owner); // 检查调用者是否为owner地址
            _; // 如果是的话，继续运行函数主体；否则报错并revert交易
        }

        // 带有onlyOwner修饰符的函数只能被owner地址调用
        function changeOwner(address _newOwner) external onlyOwner{
            owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
        }
        ```

2. 第十二讲
    - 事件(`event`)是EVM上日志的抽象。
    - 声明事件`event Transfer(address indexed from, address indexed to, uint256 value);`
    - 释放事件
        ```Solidity
        // 声明事件
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
    - 事件特点
        - **响应**：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
        - **经济**：事件是`EVM`上比较经济的存储数据的方式，每个大概消耗2,000 `gas`；相比之下，链上存储一个新变量至少需要20,000 `gas`。

3. 第十三讲
    - 继承(`inheritance`)是面向对象编程很重要的组成部分，可以显著减少重复代码。如果把合约看作是对象的话，`Solidity`也是面向对象的编程，也支持继承。
    - 规则
        - `virtual`: 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字。
        - `override`: 子合约重写了父合约中的函数，需要加上`override`关键字。

        **注意**：用`override`修饰`public`变量，会重写与变量同名的`getter`函数。
    - 简单继承
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
        // Baba合约继承了Yeye合约, 并重写了hip()和pop()函数
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
    - 多重继承 - `Solidity`的合约可以继承多个合约
        - 继承时要按辈分最高到最低的顺序排。比如我们写一个`Erzi`合约，继承`Yeye`合约和`Baba`合约，那么就要写成`contract Erzi is Yeye, Baba`，而不能写成`contract Erzi is Baba, Yeye`。
        - 如果某一个函数在多个继承的合约里都存在，比如例子中的`hip()`和`pop()`，那在子合约里必须重写。
        - 重写在多个父合约中都重名的函数时，`override`关键字后面要加上所有父合约名字，例如`override(Yeye, Baba)`。
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
    - 修饰器继承 - 用法与函数继承类似，在相应的地方加virtual和override关键字即可。
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

        // Identifier合约可以直接在代码中使用父合约中的exactDividedBy2And3修饰器，也可以利用override关键字重写修饰器
        modifier exactDividedBy2And3(uint _a) override {
            _;
            require(_a % 2 == 0 && _a % 3 == 0);
        }
        ```





    - 构造函数的继承 - 子合约有两种方法继承父合约的构造函数
        - 在继承时声明父构造函数的参数 `contract B is A(1)`
        - 在子合约的构造函数中声明构造函数的参数
        ```Solidity
        contract C is A {
            constructor(uint _c) A(_c * _c) {}
        }
        ```
    - 调用父合约的函数 - 子合约有两种方式调用父合约的函数，直接调用和利用super关键字。
        - 直接调用：子合约可以直接用`父合约名.函数名()`的方式来调用父合约函数，例如`Yeye.pop()`。
        - `super`关键字：子合约可以利用`super.函数名()`来调用最近的父合约函数。`Solidity`继承关系按声明时从右到左的顺序是：`contract Erzi is Yeye, Baba`，那么`Baba`是最近的父合约，`super.pop()`将调用`Baba.pop()`而不是`Yeye.pop()`。
    - 钻石继承(菱形继承) - 指一个派生类同时有两个或两个以上的基类。
        - 在多重+菱形继承链条上使用`super`关键字时，需要注意的是`super`会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。

4. 第十四讲
    - 抽象合约（Abstract Contract） - 是指一个合约中至少有一个函数没有被实现（即函数体为空），它不能被直接部署，但可以被其他合约继承并实现其中未定义的函数。
        - 抽象合约的特性：
            - 不能直接实例化（部署）。
            - 包含至少一个没有实现的函数，即声明函数但不给出具体实现。
            - 可以包含已实现的函数和状态变量。
            - 通常用来作为其他合约的基础合约（基合约），为子合约提供基础结构和逻辑。
            - **关键字：`abstract` 用来标识一个合约为抽象合约。**
                ```Solidity
                // 抽象合约
                abstract contract Animal {
                    // 抽象函数（没有实现的函数）
                    function makeSound() public virtual returns (string memory);

                    // 已实现的函数
                    function description() public pure returns (string memory) {
                        return "This is an animal.";
                    }
                }

                // 继承抽象合约并实现抽象函数
                contract Dog is Animal {
                    function makeSound() public override returns (string memory) {
                        return "Woof!";
                    }
                }
                ```
    - 接口（Interface）- 是一个更严格的合约类型，它只允许定义函数的声明，不允许任何状态变量、构造函数或实现。它定义了一组必须实现的函数。
        - 接口的特性：
            - 只能包含函数声明，不能包含函数实现。
            - 不能有状态变量。
            - 不能有构造函数。
            - 接口中的所有函数都是 external，所以必须在实现合约中重写。
            - 主要用于标准化不同合约之间的交互方式，定义一个公共的 API。
            - **关键字：`interface` 用来标识一个接口。**
                ```Solidity
                // 定义接口
                interface IAnimal {
                    function makeSound() external returns (string memory);
                }

                // 实现接口
                contract Cat is IAnimal {
                    function makeSound() external override returns (string memory) {
                        return "Meow!";
                    }
                }
                ```
        - 拓展 - 接口与合约`ABI`（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的`ABI`，利用[abi-to-sol](https://gnidan.github.io/abi-to-sol/)工具，也可以将`ABI json`文件转换为`接口sol`文件。
    - 接口的主要使用场景
        - 标准化合约的设计：
            - ERC 标准（如 ERC-20、ERC-721、ERC-1155）：接口是 Solidity 中标准协议的基础。例如，ERC-20 代币标准就定义了代币合约需要实现的函数。开发者通过使用接口实现标准化，使得钱包、交易所等工具能够和不同的代币合约进行无缝交互。
            - 多方合作的系统：当多个开发者、团队或组织共同开发一个项目时，使用接口来定义标准是非常有效的方式。这样，各方可以独立实现接口，而不需要了解彼此的内部细节。
        - 合约之间的解耦：
            - 模块化设计：接口可以帮助不同的合约模块解耦合。例如，多个合约可能依赖某个外部合约，但为了降低依赖风险和耦合性，合约可以仅依赖该外部合约的接口，而不是它的具体实现。
            - 动态选择实现：可以通过接口来引用不同的合约实现。比如，通过接口可以与不同版本或不同功能的合约进行交互，而不需要事先了解其具体实现。
        - 合约升级与灵活性：
            - 代理合约模式：在代理合约（Proxy Contracts）和升级合约系统中，接口用于定义公共的 API，而具体的实现可能会随时间而改变。这样，合约的调用方不需要关心实际实现的变化，只要实现保持与接口一致，功能就能正常运行。
            - 抽象和实现分离：通过接口可以将抽象和实现分离。在这种设计模式下，接口定义了合约应该支持的功能，而实际合约实现可以随时间变化，从而支持不同的功能扩展或逻辑修改。
        - **与外部合约进行交互**：
	        - 调用其他合约：当一个合约需要与另一个已经部署的合约进行交互时，通常只需要了解该合约的接口而不需要其具体实现。通过接口定义对外合约的调用方式，可以简化合约间的交互。
        - 权限管理与访问控制：
	        - 在复杂的合约系统中，接口可以用于设计多角色、多合约的权限管理系统。通过接口，各种权限控制模块可以与权限验证模块进行标准化的交互，而不需要硬编码特定合约的实现。
        - 降低依赖和复用代码：
	        - 插件化系统：接口允许开发者实现合约系统的插件化设计，不同合约可以根据接口提供的 API 进行交互。这样，开发者可以创建可复用的逻辑，避免重复实现类似功能的合约。

5. 第十五讲
    - 在 Solidity 中，revert、Error、require 和 assert 是处理异常和错误条件的四种主要方法，它们的用途有所不同，并且在发生错误时的处理方式也不一样。
    - `Error（自定义错误）`- 自 Solidity 0.8.4 开始，支持使用自定义错误，这是一个更高效的方式来处理错误，并且可以为错误提供更好的上下文信息。
        - 用法: 自定义错误是一种定义在合约中的类型，可以通过 revert 关键字触发。与 require 和 assert 不同，自定义错误可以减少存储和传输错误信息的开销。
        - 示例
            ```Solidity
            error InsufficientBalance(uint256 available, uint256 required);

            contract Example {
                uint256 public balance;

                function withdraw(uint256 amount) public {
                    if (balance < amount) {
                        revert InsufficientBalance(balance, amount);
                    }
                    balance -= amount;
                }
            }
            ```
        - 特点: 在于节省 gas，特别是在提供复杂的错误信息时。
    - `require` - 是用于验证函数输入、参数和执行前的前置条件。它用于检查某些条件，并且如果条件不满足，则回退交易。
        - 用法：当条件不满足时，触发 require 会返回一个错误消息，并回滚状态。剩余的 gas 会被退还。
        - 示例
            ```Solidity
            contract Example {
                function transfer(address recipient, uint256 amount) public {
                    require(recipient != address(0), "Invalid recipient address");
                    require(amount > 0, "Transfer amount must be greater than zero");
                    // 继续执行...
                }
            }
            ```
        - 特点：主要用于验证输入的条件。
    - `assert` - 用于检查代码的内部错误，通常用于不应该发生的情况。如果 assert 失败，说明代码有严重的错误（例如，计算溢出或违反不变量）。不同于 require，assert 会消耗掉所有的剩余 gas。
        - 用法：一般用于检查合约状态的内在一致性或一些不应该被破坏的条件。
        - 示例
            ```Solidity
            contract Example {
                uint256 public totalSupply;

                function burn(uint256 amount) public {
                    totalSupply -= amount;
                    assert(totalSupply >= 0);  // 验证 totalSupply 不应该为负数
                }
            }
            ```
        - 特点：用于检测不变量和非常规的错误。如果 assert 失败，意味着合约的某些核心逻辑被破坏了。
    - `revert` - 也是一种用于回退交易的方式，常与自定义错误结合使用。当你需要手动控制交易失败时可以使用 revert。
        - 用法：可以通过 revert 主动回滚交易，同时传递一个自定义错误或字符串消息。
        - 示例
            ```Solidity
            contract Example {
                function safeWithdraw(uint256 amount) public {
                    if (balance < amount) {
                        revert("Insufficient balance");
                    }
                    balance -= amount;
                }
            }
            ```
        - 特点：revert 会退还剩余 gas，但如果传递错误消息字符串，gas 消耗会增加。
###

### 2024.09.26

学习内容:
1. 第十六讲
    - 函数重载 - 即在`Solidity`中允许函数进行重载（`overloading`），即**名字相同**但**输入参数类型不同**的函数可以同时存在，他们被**视为不同的函数**。**注意，Solidity不允许修饰器（modifier）重载。**
    - 下面这两个函数的定义就用到了重载，虽然函数名相同，但它们的参数不同，对应的函数选择器也是不同的。
        ```Solidity
        function saySomething() public pure returns(string memory){
            return("Nothing");
        }

        function saySomething(string memory something) public pure returns(string memory){
            return(something);
        }
        ```
    - 对于调用重载的函数，需要确定好传入的参数。

2. 第十七讲
    - 库合约的作用
        - 库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在，库合约是一系列的函数合集。
    - 库合约与普通合约的不同
        - 不能存在状态变量
        - 不能够继承或被继承
        - 不能接收以太币
        - 不可以被销毁
    - 库合约的使用方式
        - 利用using for指令
            ```Solidity

            // 利用using for指令
            using Strings for uint256;

            function getString1(uint256 _number) public pure returns(string memory){
                // 库合约中的函数会自动添加为uint256型变量的成员
                return _number.toHexString();
            }
            ```
        - 通过库合约名称调用函数
            ```Solidity

            // 直接通过库合约名调用
            function getString2(uint256 _number) public pure returns(string memory){
                return Strings.toHexString(_number);
            }
            ```
    
    **注意**: 库合约重的函数可见性如果被设置为`public`或者`external`，则在调用函数时会触发一次`delegatecall`。而如果被设置为`internal`，则不会引起。对于设置为`private`可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

3. 第十八讲
    - `import`用法
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

4. 第十九讲
    - Solidity中两种特殊的回调函数，`receive()`和`fallback()`。
    - 接收ETH函数 `receive`
        - `receive()`函数是在合约收到ETH转账时被调用的函数且一个合约最多有一个`receive()`函数
        - 声明： `receive() external payable { ... }`
        - 注意：`receive()`函数不能有任何的参数，不能返回任何值，必须包含`external`和`payable`。还有`receive()`最好不要执行太多的逻辑因为如果别人用`send`和`transfer`方法发送ETH的话，`gas`会限制在`2300`，`receive()`太复杂可能会触发`Out of Gas`报错。
            ```Solidity
            // 定义事件
            event Received(address Sender, uint Value);
            // 接收ETH时释放Received事件
            receive() external payable {
                emit Received(msg.sender, msg.value);
            }
            ```
    - 回退函数 `fallback`
        - `fallback()`函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约`proxy contract`。

        - 声明： `fallback() external payable { ... }`

        - 注意：`fallback()`声明时不需要`function`关键字，必须由`external`修饰，一般也会用`payable`修饰，用于接收`ETH`。

            ```Solidity
            event fallbackCalled(address Sender, uint Value, bytes Data);

            // fallback
            fallback() external payable{
                emit fallbackCalled(msg.sender, msg.value, msg.data);
            }
            ```

    - `receive`和`fallback`的区别
        - `receive`和`fallback`都能够用于接收`ETH`，他们触发的规则如下

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
        - 简单来说，合约接收`ETH`时，`msg.data`为空且存在`receive()`时，会触发`receive()`；`msg.data`不为空或不存在`receive()`时，会触发`fallback()`，此时`fallback()`必须为`payable`。
        - `receive()`和`payable fallback()`均不存在的时候，向合约直接发送`ETH`将会报错（你仍可以通过带有`payable`的函数向合约发送ETH）。
    
    **注意⚠️**：在`Solidity 0.6.x`版本之前，语法上只有 `fallback()` 函数，用来接收用户发送的ETH时调用以及在被调用函数签名没有匹配到时，来调用。 `0.6`版本之后，`Solidity`才将 `fallback()` 函数拆分成 `receive()` 和 `fallback()` 两个函数。

5. 第二十讲
    - 在`Solidity`中，有三种方法可以向其他合约发送 `ETH`，它们分别是 `transfer()`、`send()` 和 `call()`。每种方法的使用方式、返回值以及安全性都不同。
        - `transfer()`
            - transfer() 是 Solidity 中最早用于发送 ETH 的方法之一。
            - 该方法每次最多发送 2300 gas，这个限制是为了避免受目标合约复杂逻辑的影响，如重入攻击。
            - 如果发送失败，transfer() 会自动回滚交易，不需要手动检查。
                ```Solidity
                // 用transfer()发送ETH
                function transferETH(address payable _to, uint256 amount) external payable{
                    _to.transfer(amount);
                }
                ```
        - `send()`
            - 	send() 与 transfer() 类似，但它不会在失败时抛出异常。
            - 同样只提供 2300 gas 给目标合约，确保安全性。
            - 如果 send() 失败，只会返回 false，不会自动回滚。
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
        - `call()`
            - call() 是一种低级调用，用于执行外部合约或发送 ETH。它没有固定的 gas 限制，并且更灵活。
            - call 返回的是一个布尔值，表示是否成功，还可以获取返回的数据。
            - 不受 2300 gas 限制，可以发送任意数量的 gas。
            灵活性高：可以发送任意数量的 gas，适用于复杂的合约交互。
            - 安全性需要注意：如果不小心，目标合约可能会消耗大量 gas 或引发重入攻击。为了防止重入攻击，通常建议使用**检查-效果-交互**模式。
            - 返回值：需要手动检查返回值来处理失败情况。
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
    - 关键区别和对比
    
        | 特性              | `transfer()`               | `send()`                   | `call()`                             |
        |-------------------|----------------------------|----------------------------|--------------------------------------|
        | gas 限制          | 固定 2300 gas               | 固定 2300 gas               | 无固定限制，可以灵活设置 gas          |
        | 失败处理          | 抛出异常，自动回滚         | 返回 `false`，需手动处理    | 返回 `bool`，需手动处理              |
        | 安全性            | 较高（防重入攻击）          | 较高（防重入攻击）          | 需注意重入攻击等问题                |
        | 灵活性            | 较低                        | 较低                        | 较高，可传递 gas、调用合约函数       |
        | 推荐场景          | 简单的 ETH 发送             | 简单的 ETH 发送             | 复杂合约调用，推荐当前使用方式      |
###

#### 2024.09.27

学习内容:
1. 第二十一
    - 调用其他合约 - 在已知合约代码（或接口）和地址的情况下，调用已部署的合约。
        - 创建合约引用调用`_ContractName(_ContractAddress).f()`
            - `_ContractName`: 要调用合约的名称
            - `_ContractAddress`: 要调用合约的地址
            - `f()`: 要调用合约的具体函数

                ```Solidity

                // 被调用合约示例
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

                // 调用OtherContract合约的getX()函数
                contract CallContract{
                    function callSetX(address _Address) external{
                        OtherContract(_Address).getX();
                    }
                }
                ```
        - 传入合约变量调用 - 直接在函数中传入合约的引用

            ```Solidity

                // 被调用合约示例
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

                // 调用OtherContract合约的getX()函数
                contract CallContract{
                    function callGetX(OtherContract _Address) external view returns(uint x){
                        x = _Address.getX();
                    }
                }
                ```
        - 创建合约变量调用 - 只传入合约地址

            ```Solidity

                // 被调用合约示例
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

                // 调用OtherContract合约的getX()函数
                contract CallContract{
                    function callGetX2(address _Address) external view returns(uint x){
                        OtherContract oc = OtherContract(_Address); // 函数内部创建合约引用并赋值给oc
                        x = oc.getX();
                    }
                }
                ```
        - 调用合约并发送ETH

            ```Solidity

            function setXTransferETH1(address _Address, uint256 x) payable external{
                OtherContract(_Address).setX{value: msg.value}(x);
            }

            function setXTransferETH2(OtherContract _Address, uint256 x) payable external{
                _Address.setX{value: msg.value}(x)
            }

            function setXTransferETH3(address _Address, uint256 x) payable external{
                OtherContract oc = OtherContract(_Address); 
                oc.setX{value: msg.value}(x)
            }

            ```

2. 第二十二
    - `call`调用合约
        - `call`是官方推荐的通过触发`fallback`或`receive`函数发送ETH的方法。
        - 不推荐用`call`来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数。
        - `call`调用目标合约只有在不知道`合约源代码`或`ABI`时才使用，但要注意风险。
    
    - `call`的调用方式
        - `目标合约地址.call(字节码);`
            - `字节码`利用结构化编码函数`abi.encodeWithSignature`获得
                - `abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)`
                - `函数签名为"函数名(逗号分隔的参数类型)"`。例如`abi.encodeWithSignature("f(uint256,address)", _x, _addr)`。
            - call在调用合约时可以指定交易发送的ETH数额和gas数额
                - `目标合约地址.call{value:发送数额, gas:gas数额}(字节码);`
    
    - `call`调用示例
        
        ```Solidity

        // 被调用的合约，假设不知道OtherContract的源代码
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

        // 调用OtherContract的合约
        contract Call {
            // 定义事件，方便后期查看返回的data数据
            event Response(bool success, bytes data);

            function callSetX(address payable _addr, uint256 x) public payable {
                // 调用setX函数发送ETH
                (bool success, bytes memory data) = _addr.call{value: msg.value}(abi.encodeWithSignature("setX(uint256)", x));

                emit Response(success, data); // 释放日志事件
            }

            function callGetX(address _addr) external returns (uint256) {
                // 调用 getX()
                (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("getX()"));

                emit Response(success, data); // 释放日志事件
                return abi.decode(data, (uint256));
            }

            function callNonExist(address _addr) external {
                // 调用不存在函数
                (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("foo(uint256)"));

                emit Response(success, data); // 释放日志事件
            }
        }
        ```

###
<!-- Content_END -->
