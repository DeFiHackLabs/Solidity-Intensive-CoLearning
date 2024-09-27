---
timezone: Asia/Shanghai
---
---

# Passi0n1

1. hi,我是Passi0n1。我对于传统安全比较了解，对于web3安全仅有一些基础，希望可以精进自己的技术。
2. 你认为你会完成本次残酷学习吗？会的。

## Notes

<!-- Content_START -->
### 2024.09.23
#### 学习笔记
函数可见性说明符：
从可见范围，依次变窄的角度去描述：

`public`   合约内外均可访问

`external` 只能从合约外部进行调用，但是如果合约内部真的有调用的需要的花可以通过 `this.f()` 进行调用.

`internal` 只可以由合约内部以及继承的合约调用

`private`  只能从本合约内部访问，即使是继承的合约也不能使用


在此处可以注意一些合约在部署的时候可见性规范不到位，导致的合约漏洞

参考一个由于可见性造成的漏洞
https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7
```
function initWallet(address[] _owners, uint _required, uint _daylimit) {    
  initDaylimit(_daylimit);    
  initMultiowned(_owners, _required);  
}
```
当然，本身 `initWallet` 函数在初始化的时候没有进行调用者身份检查就存在问题。

### 2024.09.24
#### 学习笔记

## 决定函数权限/功能的关键字:

`payable` 此关键字可以说明某个函数可以接收 ETH

```
contract PaymentContract {
    function receivePayment() public payable {
        // 这里可以记录支付信息或执行其他操作
    }
}
```

`pure`  既不能读，也不能写，只适合用来标记哪些不会改变内容的函数。比如下面的 a+b，这里只是返回了 a+b，同样也没有把 a+b 的结果写入某个其他的变量

这里需要辨析的是当 `pure` 函数接收参数并在其内部使用这些参数进行计算时，这不被视为“读取”数据，因为这些参数是函数调用时由外部提供的，而不是从合约状态中获取的。

换句话来说，`view` 和 `pure` 的指的则是合约 storage 内容的读写，所以从外部来的数据的读写必然不算做是读写。




`view`  不可以写，但是可以读


`view` 和 `pure` 都不会消耗 gas。

```
pragma solidity ^0.8.0;

contract Example {
    uint256 public value;

    function pureFunction(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b; // 不会读取或修改value
    }

    function viewFunction() public view returns (uint256) {
        return value; // 可以读取value，但不能修改它
    }

    function modifyFunction() public {
        value = 10; // 可以修改value
    }
}
```


## pure 和 view 的由来

那么既然到了这里。不如进一步的探讨下 `pure` 出现的背景和解决的那些问题：
Solidity 版本: pure 关键字是在 Solidity 0.4.17 版本中引入的，在 `pure` 和 `view` 出现之前，合约还需要通过 `contact` 去标记说明那些不会修改合约状态的函数，

`在 Solidity 0.4.24 及之前的版本中，constant 关键字用于表示函数不会修改合约的状态。即使函数需要读取状态变量，也可以使用 constant 关键字。然而，这种用法可能会引起一些混淆，因为它并不完全准确地反映函数的行为。在后续的版本中，view 关键字被引入来更明确地表示函数不会修改状态，而 pure 关键字用于表示函数既不读取也不修改状态。`


```
pragma solidity ^0.4.24;

contract Example {
    uint256 public value;

    // 这个函数不会修改状态变量value，但可以读取它
    function getValue() public constant returns (uint256) {
        return value;
    }

    // 这个函数既不会读取也不会修改状态变量value
    function calculate(uint256 a, uint256 b) public constant returns (uint256) {
        return a + b;
    }
}
```

那么，pure 和 view 解决的第一个问题就出现了：**去除混淆**。

**去除不必要的理解**：除此之外，solidity 的开发需要多人协作，通过泾渭分明的关键字去表示功能开发人员可以减少很多不必要的工作量。
**明确函数的预期行为**：任何的不明确都可能造成安全的隐患
**降低编译成本**


https://passi0n1.github.io/post/payable%E3%80%81view-he-%20pure.html

### 2024.09.26
#### 学习笔记

昨天的笔记忘记提交了，可惜了
学习到了第八节，整理了一下Storage、memory这些储存的类型。

## Storage
storage 存储的是声明定义的数据。

slot 是存储在 storage 中的，一个 slot 可以存储 256 位（32 字节）的大小。
storage 没有上限，但是 gas 会很高。
[Solidity 中 Storage](https://blog.csdn.net/rfrder/article/details/115706983)

## Memory
memory 存储的是内存中的数据。也就是过程中的数据。

看一个例子：
在这个例子中间的信息，过程性的信息、局部变量就是存储在 Memory
```solidity
pragma solidity ^0.5.17;

contract SimpleContract {
    uint256 public storedData; // Storage

    function set(uint256 x) public {
        uint256 tempData = x + 10; // Memory
        storedData = tempData; // Storage
    }
}

```


<font color="#ff0000">在函数中定义的局部变量是存储在哪里的呢？</font>
函数中也是可以定义变量的，但是这个变量是存储在 memory 中的，而不是 storage。

## Stack
stack 是伴随着 memory 而产生和结束的，但是两者并非是一方包括一方。而是 memory 属于临时数据的存储，而 stack 而伴生在其左右，用来跟进函数的执行。

也就是，memory 之于 stack，就像 storage 之于 memory。 

stack 这种后进先出的结构就是会从 memory 中拿数据，进而跟进函数的执行过程。

```solidity
pragma solidity ^0.5.17;

contract StackExample {
    function functionA(uint256 x) public pure returns (uint256) {
        uint256 y = x + 5;
        uint256 result = functionB(y);
        return result;
    }

    function functionB(uint256 a) internal pure returns (uint256) {
        uint256 b = a * 2;
        return b;
    }
}

```
在这个例子中，当 `functionA` 被调用时，参数 `x` 和局部变量 `y` 都会被置于 Stack 中。然后，当 `functionA` 调用 `functionB` 时，`functionB` 的参数 `a` 以及返回地址（指向 `functionA` 继续执行的位置）也会被压入 Stack。

当 `functionB` 执行完成，它的返回结果 `b` 以及返回地址会从 Stack 中弹出，Stack 的状态就回到了我们首次调用 `functionA` 时的状态，这就使得 `functionA` 可以接着执行。

现在，我们回到 `functionA`，执行完余下的部分（从 `functionB` 返回并将结果赋值给 `result`）。一旦 `functionA` 完成，它的参数和局部变量也会从 Stack 上移除。
  
这是 Stack 在函数调用中发挥作用的例子。Stack 提供了一种灵活、高效的方式来跟踪函数的状态，包括局部变量、参数以及函数调用的嵌套情况。


## calldata

Calldata 相比于 storage 和 Memory 这种固定或者临时存储数据的位置而言，calldata 更像是一种临时工具，只用来在不同的参数当中传递参数。


## 四者之间的比较


Storage（存储）
	1	定义：Storage 是 Solidity 中用于永久存储数据的地方。它对应于以太坊区块链上的状态变量。
	2	特点：
	•	存储在区块链上，每次合约调用都会持久化保存。
	•	访问速度较慢，成本较高。
	•	主要用于存储合约的状态和重要数据。
	
Memory（内存）
	1	定义：Memory 是 Solidity 中用于临时存储数据的地方。它在函数调用期间存在，并在函数执行完毕后销毁。
	2	特点：
	•	存储在内存中，访问速度快，成本较低。
	•	主要用于处理函数参数和局部变量。
	•	数据在函数执行完毕后会被清除。
	
Calldata（调用数据）
	1	定义：Calldata 是 Solidity 中用于传递函数参数的特殊区域。它是一个不可变的字节数组，包含了函数调用的输入数据。
	2	特点：
	•	只读，不可修改。
	•	主要用于外部函数的输入参数。
	•	访问速度快，成本较低。
	•	适用于处理大量数据，因为它不会占用额外的内存空间。
Stack（栈）
	1	定义：Stack 是 Solidity 虚拟机（EVM）中用于执行操作的内部数据结构。它用于临时存储运算过程中的中间结果。
	2	特点：
	•	存储在 EVM 的栈中，访问速度快。
	•	主要用于执行算术运算、逻辑运算和函数调用等操作。
	•	栈的大小有限，通常为 1024 个元素。
	
示例代码
总结
	•	Storage：用于永久存储合约状态。
	•	Memory：用于临时存储函数参数和局部变量。
	•	Calldata：用于传递外部函数的输入参数，只读且高效。
	•	Stack：EVM 内部用于执行操作的数据结构。



这里通过一个例子展示这些存储类型的具体应用
```solidity
pragma solidity ^0.8.0;

contract StorageExample {
    uint256 public storedData; // 存储在storage中

    function setStorageData(uint256 _data) public {
        storedData = _data; // 修改storage中的数据
    }
}

contract MemoryExample {
    function useMemory(uint256[] memory _array) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < _array.length; i++) {
            sum += _array[i]; // 使用memory中的数组
        }
        return sum;
    }
}

contract CalldataExample {
    function processCalldata(uint256[] calldata _array) external pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < _array.length; i++) {
            sum += _array[i]; // 使用calldata中的数组
        }
        return sum;
    }
}
```


总结一下：
- **默认参数类型**：未声明类型的参数默认是 `memory`。
- **Storage 变量**：需要显式声明。
- **External 函数参数**：推荐使用`calldata`，尤其是对于复杂类型，但标量类型可以使用`memory`或`calldata`。
补充：
复杂类型（Complex Types）
复杂类型通常指的是包含多个值或者具有内部结构的数据类型。在Solidity（一种智能合约编程语言）中，复杂类型包括但不限于：

结构体（Structs）
数组（Arrays）
映射（Mappings）
枚举（Enums）
这些类型通常占用更多的内存空间，并且在函数调用时可能需要更多的处理来传递它们的状态。

标量类型（Scalar Types）
标量类型指的是单一的值，它们是最基本的数据类型。在Solidity中，标量类型包括：

整数（如 int, uint）
布尔值（bool）
地址（address）
固定大小字节数组（如 bytes1, bytes32）
<!-- Content_END -->
