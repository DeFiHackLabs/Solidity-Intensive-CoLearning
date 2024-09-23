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
<!-- Content_END -->
