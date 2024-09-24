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

### 2024.9.24

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
<!-- Content_END -->
