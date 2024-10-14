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



### 2024.09.27
#### 学习笔记

**事件**
enevt 是个被定义的事件，主要的功能的对外展示和记录作用，并不是真正的代码的执行。


一个完整的案例：[https://blog.csdn.net/watson2017/article/details/123423834](https://blog.csdn.net/watson2017/article/details/123423834)

```solidity
pragma solidity >=0.6.0 <0.9.0;

contract Demo {
  uint256 demoIndex = 0;
  event DemoIndexInc(uint256 indexed index);
  #这里定义一下时候触发事件时对外展示的信息。
  #顺便补充一下这里的indexed和tx中的log是息息相关的。后续会详细说明的

  function getDemoIndex() public view returns (uint256) {
    return demoIndex;
  }

  function incDemoIndex() public {
    demoIndex = demoIndex+1;
    emit DemoIndexInc(demoIndex);
  }
}
```

而emit就是一个类似于断点一样的东西，或者说是触发点。每当运行到emit的时候就会按照event当中定义的一样把数据整理记录好。
从这角度来看，emit就像是一个类似于接口一样的东西，在emit有了定义之后，tx中的log就按照这个event中的数据来展现，而监听的时候也是从这里获取数据的。



## topic、indexed、与log
学习的原文：[https://www.wtf.academy/solidity-start/Event/](https://www.wtf.academy/solidity-start/Event/)

注意，要跟有event的交互才会有log。。。。。。。

topic中最多三个indexed。

另外emit也可以这样用
```solidity
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
```

## enevt  emit  监听
用来处理的监听逻辑如下：
```html
<script src="./dist/web3.min.js"></script>
<script type="text/javascript">
  const addEventWatchTx = async () => {
    var web3 = new Web3(ethereum)
    var metaTxContract = new web3.eth.Contract(MetaTxABI, contractAddr)
    metaTxContract.events.DemoIndexInc({
      filter:{},
      fromBlock: 'latest'
    }, function(error, event){})
      .on('data', function(event){
        console.log(event); // same results as the optional callback above
      })
      .on('changed', function(event){
        console.log('emove event from local database');
      })        
      .on('error', console.error);
  }
```


其他的监听案例：[https://blog.csdn.net/qq_37928038/article/details/130200781](https://blog.csdn.net/qq_37928038/article/details/130200781)


## 为什么solidity中要存在 event 和 emit？
event 和 emit 是区块链链接外部世界的渠道。


## 在 solidity 中 event 当中的indexed 如何方便检索的
event 机制更像是一种主动的推送，自我分类机制。在合约执行的时候由于一些原因，触发了这个机制然后主动的在众多交易当中脱颖而出，这个时候就方便前端进行监控发布相关信息，或者方便开发者通过脚本遍历众多庞大的交易筛选出来自己想要的事件。

而 indexed 的存在，让相关的参数更为明显，可以作为筛选的条件被使用。


比如下面的这个例子：
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DepositContract {
    event Deposit(address indexed user, uint256 amount);

    function deposit(uint256 amount) public payable {
        // 存款逻辑...
        emit Deposit(msg.sender, amount);
    }
}
```
这里定义了一个存款的事件


然后前端就可以通过 `Deposit` 进行监控，把相应的信息利用起来。
```js
const { ethers } = require("ethers");

// 连接到以太坊节点
const provider = new ethers.providers.JsonRpcProvider("YOUR_RPC_URL");

// 合约地址和ABI
const contractAddress = "YOUR_CONTRACT_ADDRESS";
const contractABI = [/* ... */]; // 你的合约ABI

// 创建合约实例
const contract = new ethers.Contract(contractAddress, contractABI, provider);

// 监听Deposit事件
contract.on("Deposit", (user, amount) => {
    console.log(`User ${user} deposited ${amount} wei.`);
});


```



https://passi0n1.github.io/post/he-yue-zhong-de-event.html

测试链怎么去进行监听之类的呢？


### 2024.09.28
#### 学习笔记

## 被弃用的 constant

之前在查询函数修饰符的时候看到了 `view` 和 `pure` ，后续扩展的时候了解到了主要由 `view` 和 `pure` 替代了 `constant` 的功能，而 `constant` 算是被启用的。
后来再次看到 `constant` 和 `immutable` 时开始疑惑 `constant` 到底被弃用了没有。

听过一番探查，发现在 `0.5` 更新的时候只是规定 `constant` 不再去修饰函数而已，还是可以继续修饰变量的，不过一般情况更推荐使用 `immutable`。

停用 `constant ` 修饰函数

<img width="608" alt="image" src="https://github.com/user-attachments/assets/8485279f-5418-498a-92a6-f36157e743e4">


但是可以用来修饰变量。

https://learnblockchain.cn/docs/solidity/cheatsheet.html?highlight=immutable
<img width="614" alt="image" src="https://github.com/user-attachments/assets/5edd8a6f-654c-48f7-9142-b5c51f758a37">




那么继续回归到 `constant` 和 ` immutable ` 上；


在 Solidity 中，`immutable` 和 `constant` 都是用来修饰变量的关键字，但它们之间有一些重要的区别。

### Constant

`constant` 关键字用于声明一个变量，其值在合约创建后就不能被修改。这意味着一旦合约部署，`constant` 变量的值就固定不变了。`constant` 变量必须在声明时进行初始化。

```solidity
pragma solidity ^0.8.0;

contract Example {
    uint256 constant public MY_CONSTANT = 10;

    function getConstant() public view returns (uint256) {
        return MY_CONSTANT;
    }
}
```

### Immutable

`immutable` 关键字是在 Solidity 0.6.0 版本中引入的，用于声明一个变量，其值在合约创建后也不能被修改。与 `constant` 不同的是，`immutable` 变量可以在声明时不进行初始化，但必须在构造函数中进行初始化。

```solidity
pragma solidity ^0.8.0;

contract Example {
    uint256 immutable public myImmutable;

    constructor(uint256 _value) {
        myImmutable = _value;
    }

    function getImmutable() public view returns (uint256) {
        return myImmutable;
    }
}
```

### 区别

1. **初始化时机**：`constant` 变量必须在声明时进行初始化，而 `immutable` 变量可以在声明时不进行初始化，但必须在构造函数中进行初始化。
2. **适用范围**：`constant` 变量只能用于基本类型和字符串，而 `immutable` 变量可以用于任何类型的变量，包括复杂类型（如数组、结构体和映射）。

### 注意事项

- 在 Solidity 0.8.0 及更高版本中，建议使用 `immutable` 而不是 `constant`，因为 `immutable` 提供了更大的灵活性。（灵活性就是可以晚点声明，随机应变的能力更强）
- `constant` 和 `immutable` 变量都是只读的，不能在合约的其他函数中修改它们的值。

仅仅到了这里还是会让人疑惑，为什么要有这样的功能，除却节省 gas、优化编译真的有这个必要么？

从功能上理解应该会好理解一些：
constant 可以用于业务手续费，一些元数据的存放，而 immutable 更适合于 `有些情况下，不可变的值需要在合约部署时根据外部输入来确定。例如，一个去中心化金融（DeFi）合约可能需要根据用户的初始存款来设置某些参数。`



### 2024.09.29
#### 学习笔记

不同类型的引用变量相互赋值时，修改其中一个的值，不会导致另一个的值随之改变的是以下哪种情况：

选择一个答案
A. 合约中的 storage 赋值给本地的 storage
B. 合约中的 memory 赋值给本地的 memory
C. 合约中的 storage 赋值给本地的 memory
D. 以上全部

```
在以太坊智能合约中，变量的存储位置主要有三种：storage、memory 和 calldata。它们之间的赋值和修改行为如下：
A. 合约中的storage赋值给本地的storage：这种情况下，赋值实际上是一个引用赋值。如果修改了本地storage变量的值，合约中的storage变量的值也会随之改变。
B. 合约中的memory赋值给本地的memory：memory 是一个临时存储区域，通常用于函数调用时传递参数或局部变量。如果一个memory变量被赋值给另一个memory变量，它们是相互独立的副本，修改一个不会影响另一个。
C. 合约中的storage赋值给本地的memory：这种情况下，memory变量会获得storage变量的一个副本。修改memory中的副本不会影响storage中的原始值。
根据上述解释，正确答案是：
B. 合约中的memory赋值给本地的memory
以及
C. 合约中的storage赋值给本地的memory
因为这两种情况下，修改其中一个变量的值不会导致另一个变量的值随之改变。选项A会导致值的改变，因为它们是引用同一个存储位置。选项D不正确，因为它包含了A选项。

```

补充：
不过，之所以答案是 C 而不是 B 或者 "D. 以上全部"，是因为题目问的是**“不同类型的引用变量相互赋值时”**。关键在于"不同类型"：

B 选项：memory 赋值给 memory，虽然是值的拷贝，但 memory 和 memory 是相同类型的数据位置，不符合“不同类型”的条件。
C 选项：storage 赋值给 memory，这是一个**从永久存储位置（storage）赋值给临时存储位置（memory）**的操作，属于不同类型的数据位置，这种情况下是值拷贝，符合题目所述的条件。
因此，选 C 是因为它满足“不同类型的引用变量相互赋值”这一条件，且是值的拷贝。


消耗 gas 最多的变量类型为：

A. 状态变量
B. 局部变量
C. 全局变量


```
	•	A. 状态变量
解释：
在 Solidity 中，不同类型的变量对 gas 消耗的影响是不同的。其中，状态变量是消耗 gas 最多的变量类型。
	•	状态变量： 存储在链上，是永久性的，每次读写都会消耗 gas。初始化一个新的存储槽需要 20000 gas，修改一个已有的存储槽需要 5000 gas。
	•	局部变量： 存储在内存中，是临时的，函数调用结束后会被销毁。相对于状态变量，局部变量的 gas 消耗较小。
	•	全局变量： 在 Solidity 中没有明确的全局变量概念。如果指的是合约级别的变量，那么通常是指状态变量。

```


### 2024.09.30
#### 学习笔记




**有如下一段合约代码，执行 initStudent 方法后，student. Id 和 student. Score 的值分别为**

```
contract StructTypes {
    struct Student{
        uint256 id;
        uint256 score; 
    }
   Student student;
   function initStudent() external{
        student.id = 100;
        student.score = 200;
        Student storage _student = student;
        _student.id = 300;
        _student.score = 400;
    }
}
```

选择一个答案

A. 300 400

B. 100 200

C. 300 200

D. 100 400


在这个题目当中，存在两个两个结构体；
第一个结构体是初始的时候就有的结构体，这个时候初始结构体里面被赋值为了 100 和 200。
第二次赋值，是对于新产生的 `_student` 进行赋值，这个时候对于 `_student.id` 和 `_student.score` 进行了赋值。
但是此时需要注意的是，`_student` 来自于 `Student storage _student = student;`，所以他们变量的引用的位置是一致的，所以 `student.id` 和 `student.score` 的值也发生了改变。


**可以作为 mapping 中值（value）的变量类型是**

选择一个答案
A. struct
B. string
C. address
D. 以上均可
返回上一题

- **哈希碰撞：** 如果将 struct 作为 key，不同的 struct 可能计算出相同的哈希值，导致哈希碰撞，从而无法正确地从 mapping 中获取到对应的 value。
- **复杂类型：** struct 通常包含多个成员变量，这些成员变量的类型可能不同，这使得哈希函数的实现变得复杂。
- **版本差异：** 不同的 Solidity 版本中，struct 的哈希计算方式可能不同，这会导致在不同版本之间迁移合约时出现问题。

说白了就是，mapping 是一张速查表，或者理解为一个储物柜，储物柜格子里面放什么都行，但是如果储物柜的标号总是乱改那就没法找到具体的储物柜了。



**给映射变量 map 新增键值对的方法：**

选择一个答案

A. `map(_Key) = _Value;`

B. `map[_Key] = _Value;`

C. `map.push(_Key, _Value);`


答案 B

solidity 当中仅有动态数组支持 `push` 操作。



### 2024.10.01
#### 学习笔记


 4.在如下的合约中，我们定义了四个 immutable 的变量 y1, y2, y3, y4。

```
uint256 immutable y1;
address immutable y2;
address immutable y3;
uint256 immutable y4;
constructor (uint256 _y4){
    y1 = block.number;
    y2 = address(this);
    y3 = msg.sender;
    y4 = _y4;
}
```


其中，确实有必要在构造函数 constructor 中才赋值的一项是：

选择一个答案

A. y1

B. y2

C. y3

D. y4

返回上一题

答案为 y4 。

```
这里强调下关于编译时便定义的这个概念：像block.number、address(this)、msg.sender这些都是在编译时就会获取的，所以不用再去在构造函数的时候去赋值。
```


### 2024.10.02
#### 学习笔记
在 Solidity 中，virtual 关键字用于声明一个函数可以被继承的合约中的子合约重写。它通常与 override 一起使用，后者在子合约中重写父合约中的函数时需要。

用法背景
在 Solidity 中，合约是可以继承的，子合约可以继承父合约的函数、状态变量等。但是，默认情况下，父合约中的函数是不可被重写的。如果你希望允许子合约重写某个函数，那么你需要在父合约的函数定义中使用 virtual 关键字。

```
pragma solidity ^0.8.0;

contract Parent {
    function sayHello() public pure virtual returns (string memory) {
        return "Hello from Parent";
    }
}

contract Child is Parent {
    function sayHello() public pure override returns (string memory) {
        return "Hello from Child";
    }
}

```

在这个例子中：

Parent 合约中的 sayHello 函数被声明为 virtual，这意味着它可以被子合约重写。
Child 合约继承了 Parent 合约，并且通过使用 override 关键字对 sayHello 函数进行了重写。



`很多时候写一些函数的时候并不确定后续这个函数是否需要被重写，那么我可以写最初的合约的时候把所有合约都加一个virtual关键字么`


在 Solidity 中，你可以在编写初始合约时将所有函数声明为 virtual，以允许将来有可能重写这些函数。但是，这样做有一些权衡和注意事项：

优点
灵活性：将函数标记为 virtual 后，未来子合约可以根据需要自由地进行重写，增加了代码的扩展性。
简化继承设计：如果你不确定哪些函数在未来可能需要重写，提前使用 virtual 可以避免以后修改父合约代码的麻烦，减少升级合约的复杂性。
缺点
安全性隐患：允许函数被重写可能会引入潜在的安全问题，尤其是对于一些关键功能。如果某些函数意外地被重写，可能会导致不可预料的行为。
代码可读性降低：如果所有函数都标记为 virtual，可能让其他开发人员误以为这些函数应该被重写，增加了代码的复杂性和混乱感。
开发成本：默认所有函数可以被重写可能会导致设计不清晰，使得后续代码维护更加困难。通常，只有明确需要扩展的函数才应该标记为 virtual。
设计建议
最小权限原则：仅在你确定某个函数需要被重写时才添加 virtual，这符合 Solidity 安全开发的最佳实践。
分层设计：对于需要扩展的功能，可以将它们放在特定的合约中，并明确标记为 virtual，而非随意为所有函数添加这个关键字。



### 2024.10.03
#### 学习笔记

紧急打卡记录，笔记后记

### 2024.10.04
#### 学习笔记

不同答案存疑

在 Solidity（一种用于编写以太坊智能合约的编程语言）中，合约继承是通过使用 `is` 关键字来实现的。当合约 C 需要继承合约 A 和合约 B 时，你应该首先列出合约 B（因为它已经继承了合约 A），然后是合约 A。但这里有一点需要注意：实际上，在 Solidity 中，你不需要再次列出已经通过其他合约间接继承的合约。因此，如果合约 B 已经继承了合约 A，那么当合约 C 继承合约 B 时，它自动也会继承合约 A。

所以，正确的写法应该是：


```solidity
contract A {
    // 合约A的代码
}

contract B is A {
    // 合约B的代码，同时继承了合约A的功能
}

contract C is B {
    // 合约C的代码，继承了合约B（以及因此间接继承了合约A）的功能
}
```
在这个例子中，合约 C 通过继承合约 B，自动获得了合约 A 和合约 B 的所有功能和状态变量。因此，正确答案是 B：


```solidity
contract C is B, A;
```
但实际上，由于 Solidity 的继承机制，你只需要写：


```solidity
contract C is B;
```
这样合约 C 就会自动继承合约 B 和合约 A 的所有内容。所以，在提供的选项中，最接近正确答案的是 B，但严格来说，它应该是 `contract C is B;`。


### 2024.10.05
#### 学习笔记


## 抽象合约
抽象合约的一般饮用场景是在于：一些场景存在需求，但是具体的解决方案并未明确，所以先挖一个坑占着位置，可以标注为抽象。并且可以在具体的函数关键字部分再加一个 `virtual` 方便后续继承重写。

```soldity
abstract contract InsertionSort{
    function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
}
```



## 接口

接口的作用是起到一种信息或者物质的传递。
就拿电池而言，不论是小米电池还是南孚电池都需要满足一正一负、七号规格才能放在空调遥控器里面用。

而对于智能合约而言，对于那写 dapps ，别人根本就没那么多的精力去关心你里面怎么洗的，你就按照大家既成的规范老老实实的把数据怎么传输的，按照接口放出来就好了。


比如这个 `ERC721`

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
<img width="1174" alt="image" src="https://github.com/user-attachments/assets/2afce06e-b4b1-4894-9299-592a810e98ee">




这里作者举了两个例子，一个是用过继承来将接口和合约连接起来，另外一个就是直接通过地址连接起来。

例子 1
<img width="1159" alt="image" src="https://github.com/user-attachments/assets/f873f93e-d63a-4baf-b67c-b4e2f90add5d">


例子 2

```soldiity
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



这里再详细的整理一下：


接口合约在 Solidity 中确实有两种主要的使用方式：**通过继承连接接口与合约**，以及 **通过合约的区块链地址直接交互**。我们可以分别来看这两种方法。

### 1. 通过继承连接接口与合约

这种方式是 Solidity 中最常见的接口使用方式。开发者通过继承接口合约，明确实现接口中定义的所有函数。在这种情况下，接口提供了一种规范，任何实现该接口的合约都必须遵循该规范。

#### 示例：

```solidity
// 定义接口合约
interface IMyInterface {
    function foo() external;
}

// 实现接口的合约
contract MyContract is IMyInterface {
    function foo() external override {
        // 实现接口中的函数逻辑
    }
}
```

在这里，`MyContract` 通过 `is IMyInterface` 继承了接口，并且实现了接口中定义的 `foo()` 函数。编译器会强制要求 `MyContract` 实现所有接口中的函数。

这种继承方式的优点是强制合约实现标准化接口，尤其在协议设计或模块化开发时非常常见。例如，很多 DeFi 项目中的合约使用了统一的接口规范（如 ERC 20、ERC 721 等）。

### 2. 通过合约的区块链地址直接交互

第二种方式是**通过合约地址**与接口定义的合约直接交互，而不必继承接口。这种方式的典型场景是与已部署在区块链上的合约进行交互。你不需要继承这个合约，只需要知道它的接口，然后通过合约地址来调用它的函数。

#### 示例：

假设有一个已部署的 ERC 20 代币合约，我们可以使用其接口通过地址与其交互：

```solidity
// 定义 ERC20 接口
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

// 使用合约地址与已部署的合约交互
contract MyContract {
    function transferTokens(address tokenAddress, address recipient, uint256 amount) public {
        IERC20 token = IERC20(tokenAddress);  // 使用接口实例化已部署的合约
        token.transfer(recipient, amount);    // 调用已部署合约的 transfer 函数
    }
}
```

在这个例子中，`IERC20` 是定义好的接口合约，`MyContract` 并没有继承它，而是通过 `tokenAddress`（已部署 ERC 20 合约的地址）与该合约交互。**这种方式可以在不继承的情况下与任何已知接口的合约进行交互**，并且你只需要合约的 ABI（Application Binary Interface）和区块链上的地址。

### 总结：
1. **继承方式**：合约通过继承接口合约，必须实现接口中定义的所有函数。这种方式主要用于编写新的合约，确保它们遵循特定的规范或协议。
   
2. **通过地址直接交互**：合约通过已部署的合约地址，基于接口与外部合约交互。这种方式用于与已经在区块链上存在的合约进行交互，特别是当你需要与外部合约（如 DeFi 协议或代币合约）进行通信时。

你对接口合约的理解完全正确，这两种方式都很常用，取决于场景需求。
## 接口和抽象合约的差异

在 Solidity 中，**抽象合约** 和 **接口合约** 是两个不同的概念，但它们有一些关联和相似性。你看到的一些案例没有使用抽象合约就定义接口，可能是因为它们使用了 `interface` 关键字，专门用于定义接口合约。在理解两者的区别和关联之前，先了解各自的定义：

### 1. 抽象合约 (Abstract Contracts)
抽象合约是指至少有一个没有完整实现的函数的合约。抽象合约无法被直接实例化，必须通过继承和重写其未实现的函数来使用。使用 `abstract` 关键字声明抽象合约：

```solidity
pragma solidity ^0.8.0;

abstract contract AbstractContract {
    function foo() public virtual; // 没有实现的函数
}
```

在 Solidity 0.6.0 及更高版本中，任何没有实现的函数所在的合约都必须标记为 `abstract`。

### 2. 接口合约 (Interface Contracts)
接口合约是一个只声明函数签名的合约，没有任何函数的实现。它是合约设计的一种规范，确保所有实现它的合约都必须实现接口中定义的所有函数。接口合约通过 `interface` 关键字声明：

```solidity
pragma solidity ^0.8.0;

interface MyInterface {
    function foo() external;
}
```

#### 接口合约的规则：
- 不能包含任何状态变量。
- 不能实现任何函数。
- 不能有构造函数。
- 不能继承自其他合约，但可以继承其他接口。

### 抽象合约与接口的区别和联系

#### 主要区别：
1. **实现方式**：
   - **接口合约** 中的所有函数都不能有实现，只能定义函数的签名。
   - **抽象合约** 可以包含部分或全部函数实现，但至少有一个没有实现的函数。

2. **状态变量**：
   - **接口合约** 不允许定义状态变量。
   - **抽象合约** 可以定义状态变量。

3. **构造函数**：
   - **接口合约** 不允许有构造函数。
   - **抽象合约** 可以包含构造函数。

4. **函数可见性**：
   - **接口合约** 中的函数必须声明为 `external`。
   - **抽象合约** 中的函数可以是 `public`, `internal` 或 `external`。

#### 联系：
- 抽象合约可以看作是接口合约的一种扩展，因为它们可以定义未实现的函数，同时还允许有实现的函数和状态变量。
- 如果一个抽象合约中没有任何已实现的函数，它在功能上等同于接口合约。

### 示例

#### 接口合约：

```solidity
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
```

#### 抽象合约：

```solidity
abstract contract ERC20 is IERC20 {
    mapping(address => uint256) private balances;

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }
    
    // 未实现的函数
    function transfer(address recipient, uint256 amount) public virtual override;
}
```

#### 总结：
- **接口合约** 更严格，只能定义规范（函数签名），而不能包含实现。
- **抽象合约** 则可以包含部分实现，是接口合约的灵活扩展形式。
- 如果你只需要定义函数的规范，且不需要任何逻辑或状态变量，使用 `interface` 更合适；如果你需要定义部分逻辑或状态，同时允许子合约完成剩余部分的实现，使用抽象合约更合适。
- 


### 2024.10.06
#### 学习笔记

### 2024.10.07
#### 学习笔记


在 Solidity 中，当我们谈论抽象合约和未实现的函数时，我们需要了解几个关键概念：

1. **抽象合约**：一个包含至少一个未实现函数（即没有函数体的函数）的合约。抽象合约不能被实例化，只能被其他合约继承。
2. **纯函数**：使用`pure`关键字标记的函数保证不会读取或修改合约的状态。这意味着它不会访问区块链上的任何数据。
3. **视图函数**：使用`view`关键字标记的函数保证不会修改合约的状态，但它可以读取区块链上的数据。
4. **函数可见性**：Solidity中有四种函数可见性修饰符：`public`、`private`、`internal`和`external`。


	* `public`：函数可以从任何地方被调用。
	* `private`：函数只能从定义它的合约内部被调用。
	* `internal`：函数可以从定义它的合约或其派生合约中被调用。
	* `external`：函数只能从合约外部被调用（例如，通过交易）。

现在，让我们分析每个选项：

A. `abstract contract A{ function foo(uint a) internal pure virtual returns(uint); }`

* 这个选项是正确的。`foo`函数被标记为`internal`和`pure`，并且是`virtual`的，这意味着它必须在派生合约中被实现。由于它是`internal`的，它只能在合约内部或其派生合约中被调用。

B. `abstract contract A{ function foo(uint a) public view returns(uint); }`

* 这个选项也是正确的，但有一个小问题。虽然`foo`函数被正确地标记为`public`和`view`，但它不是`virtual`的。在Solidity中，抽象函数应该使用`virtual`关键字，尽管在某些情况下省略它可能不会导致编译错误。然而，为了清晰和一致性，最好显式地使用`virtual`关键字。

C. `contract A{ function foo(uint a) external pure virtual returns(uint); }`

* 这个选项是错误的。`external`和`pure`修饰符可以一起使用，但`virtual`修饰符通常与`internal`或`public`一起使用。`external`函数通常不是`virtual`的，因为它们是从合约外部调用的，而不是通过继承来实现的。

D. `contract A{ function foo(uint a) internal returns(uint); }`

* 这个选项也是错误的。虽然`foo`函数被正确地标记为`internal`，但它没有使用`pure`或`view`关键字，这意味着它可能会修改合约的状态。此外，它不是`virtual`的，这意味着它不需要在派生合约中被实现。

综上所述，最符合题目要求的选项是A。然而，B选项也是有效的，尽管它省略了`virtual`关键字。在实际编程中，最好显式地使用`virtual`关键字来明确表示函数需要在派生合约中被实现。

因此，最准确的答案是 A，但如果考虑到省略 `virtual` 关键字的情况，B 也可以被视为正确。然而，根据题目的要求和 Solidity 的最佳实践，A 是最合适的答案。

#疑问 

被标记为 abstract 的合约能否被部署？

选择一个答案
A. 能
B. 不能
C. 如果实现了所有函数的子合约已经被部署，则该合约能被部署


### 2024.10.08
#### 学习笔记


今天主要学习了异常处理机制

### 2024.10.09
#### 学习笔记


error TransferNotOwner(); // 自定义error


### 2024.10.10
#### 学习笔记


### Error 

Error 的使用格式类似于 event，是分离使用的。必须先定义一个 error，然后再去配个 revert 一起使用。并且error的的预先定义也和event类似，预先定义的错误提示并没有实际的内容，只是定义了一个错误的大的类似于函数名的外部格式

```
error TransferNotOwner();



function transferOwner1(uint256 tokenId, address newOwner) public {
    if(_owners[tokenId] != msg.sender){
        revert TransferNotOwner();
        // revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```
### 2024.10.11
#### 学习笔记

## import
库合约本质是一个特殊的智能合约，设计出来就是被当作工具的。本身是包含了一些常用的功能。
而 import 则是一种代码模块化的方式，在各种编程语言当中均有涉及，当然，也可以使用 import 导入库合约。


### 2024.10.12
#### 学习笔记

这里不太理解为什么可以直接转账。

<img width="1262" alt="image" src="https://github.com/user-attachments/assets/3ec38c2a-52c5-4d6a-9e53-ae5972ff52ba">


### 2024.10.13
#### 学习笔记


## 三种转账 ETH 的差异

### transfer
	•	用法是接收方地址.transfer(发送ETH数额)。
	•	transfer()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
	•	transfer()如果转账失败，会自动revert（回滚交易）。


```
// 用transfer()发送ETH
function transferETH(address payable _to, uint256 amount) external payable{
    _to.transfer(amount);
}
```



### Send

	•	用法是接收方地址.Send (发送 ETH 数额)。
	•	send ()的 gas 限制是 2300，足够用于转账，但对方合约的 fallback ()或 receive ()函数不能实现太复杂的逻辑。
	•	send ()如果转账失败，不会 revert。
	•	send ()的返回值是 bool，代表着转账成功或失败，需要额外代码处理一下。

```
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



### call[​]( https://www.wtf.academy/docs/solidity-102/SendETH/#call "call 的直接链接")

- 用法是`接收方地址.call{value: 发送ETH数额}("")`。
- `call()`没有`gas`限制，可以支持对方合约`fallback()`或`receive()`函数实现复杂逻辑。
- `call()`如果转账失败，不会`revert`。
- `call()` 的返回值是 `(bool, bytes)`，其中 `bool` 代表着转账成功或失败，需要额外代码处理一下。
```
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


### 2024.10.14
#### 学习笔记

## uniswap v 2 pair 

```solidity

function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external lock {
    // 其他逻辑...

    // 乐观的发送代币到to地址
    if (amount0Out > 0) _safeTransfer(_token0, to, amount0Out);
    if (amount1Out > 0) _safeTransfer(_token1, to, amount1Out);

    // 调用to地址的回调函数uniswapV2Call
    if (data.length > 0) IUniswapV2Callee(to).uniswapV2Call(msg.sender, amount0Out, amount1Out, data);

    // 其他逻辑...

    // 通过k=x*y公式，检查闪电贷是否归还成功
    require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'UniswapV2: K');
}
```

首先看下这个 uniswap v2 pair 合约，这里称之为 pair 合约是因为 swap 当中是有着交易对的存在，而交易对的对则是 pair 相同的意思。而进行闪电贷的钱也是交易对池子中的钱。
在 swap 项目中一般会存在多个 pair 合约，对应着不用的交易对，各个 pair 合约各不影响。

接着我们来看这个合约相对于其他合约第一眼看起来让人觉得陌生的地方：
- **Amount 0 Out**    对于这种有进有出的交易，按照常理一般会定义为 in\out，但是这里都是 out  是为了方便确定用户具体需要那种 token 出去
- **To**    一般我们会直接使用 address 或者 sender 来指代 swap 的调用地址或者调用合约。但是这里使用 to 来指代调用合约是为了
- **调用 flash 合约位于 swap 转账之下**： 这是为了在进行贷款之前先把贷款合约需要的钱锁定住，不然如果有别人同时接待那不是可能会出现一份钱两个人争的情况吗。不过也不用担心现实世界默认的先签字再资金的惯例，这个 flash 设计的逻辑就是原子性的，后面的 flash 如果没有成功，那么之前的 transfer 也会撤销回滚。
- **IUniswapV 2 Callee** ： 这是一个接口类型。这一个整体是一个接口类型的转换工具，会把调用合约按照这个 swap 的规定转换为接口形式，方便调用后续的函数
- **balance 0 Adjusted**  这是一个调整后的余额查询函数，即接待合约有没有进行还款，具体的计算还需要恒定乘积模型，即是 balance 0 Adjusted 后面的那些计算命令。

随后继续来看下 flash 合约的实现
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

// UniswapV2闪电贷回调接口
interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}

// UniswapV2闪电贷合约
contract UniswapV2Flashloan is IUniswapV2Callee {
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IUniswapV2Factory private constant factory = IUniswapV2Factory(UNISWAP_V2_FACTORY);

    IERC20 private constant weth = IERC20(WETH);

    IUniswapV2Pair private immutable pair;

    constructor() {
        pair = IUniswapV2Pair(factory.getPair(DAI, WETH));
    }

    // 闪电贷函数
    function flashloan(uint wethAmount) external {
        // calldata长度大于1才能触发闪电贷回调函数
        bytes memory data = abi.encode(WETH, wethAmount);

        // amount0Out是要借的DAI, amount1Out是要借的WETH
        pair.swap(0, wethAmount, address(this), data);
    }

    // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        // 确认调用的是 DAI/WETH pair 合约
        address token0 = IUniswapV2Pair(msg.sender).token0(); // 获取token0地址
        address token1 = IUniswapV2Pair(msg.sender).token1(); // 获取token1地址
        assert(msg.sender == factory.getPair(token0, token1)); // ensure that msg.sender is a V2 pair

        // 解码calldata
        (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

        // flashloan 逻辑，这里省略
        require(tokenBorrow == WETH, "token borrow != WETH");

        // 计算flashloan费用
        // fee / (amount + fee) = 3/1000
        // 向上取整
        uint fee = (amount1 * 3) / 997 + 1;
        uint amountToRepay = amount1 + fee;

        // 归还闪电贷
        weth.transfer(address(pair), amountToRepay);
    }
}
```

随后我们来看下这个合约中的令人觉得比较陌生的部分
- **Lib. Sol**  这里不是具体的合约名称无法具体的得知，但是可以推断出来时类似于数学运算等合约的。
- **IUniswapV 2 Callee**  这里的这个就是上文 pair 合约中实现 to 的接口话的一个函数，把传进来参数给他按照本合约的要求变化一下。
- **UNISWAP_V 2_FACTORY**   第一眼看到这个工厂合约可能会令然非常好奇，直接部署不就完了么但是工厂合约名字是工厂，但是不止承担了交易对的创建等生产性功能，也承担了一些比如登记自己整个项目有多少个交易对，承接用户发起的交易等接口职能和管理职能。
- **Constructor**   第一眼看到这个构造函数就很不明白，先前不是已经有了一个 pair 合约了么，为什么这里还要再去写一个构造函数呢？  原因是这样了，确实这个合约的上面写了两个代币的地址，但是这不是交易对啊所以需要从 IUniswapV 2 Pair 接口搞一个交易对的对象出来，方便后续的操作。
- **abi** 一般我们所熟知的 ABI 是一种接口的规范，而这个 abi 则是 solidity 内部的内置全局变量，就是一个自带的功能箱对象。



## uniswap v3
pool 池合约
```solidity
function flash(
    address recipient,
    uint256 amount0,
    uint256 amount1,
    bytes calldata data
) external override lock noDelegateCall {
    // 其他逻辑...

    // 乐观的发送代币到to地址
    if (amount0 > 0) TransferHelper.safeTransfer(token0, recipient, amount0);
    if (amount1 > 0) TransferHelper.safeTransfer(token1, recipient, amount1);

    // 调用to地址的回调函数uniswapV3FlashCallback
    IUniswapV3FlashCallback(msg.sender).uniswapV3FlashCallback(fee0, fee1, data);

    // 检查闪电贷是否归还成功
    uint256 balance0After = balance0();
    uint256 balance1After = balance1();
    require(balance0Before.add(fee0) <= balance0After, 'F0');
    require(balance1Before.add(fee1) <= balance1After, 'F1');

    // sub is safe because we know balanceAfter is gt balanceBefore by at least fee
    uint256 paid0 = balance0After - balance0Before;
    uint256 paid1 = balance1After - balance1Before;

    // 其他逻辑...
}
```

随后我们再来看下这个 uniswap V3
- 首先是 <=  ，这个在 solidity 当中是左侧小于等于右侧的意思，第一眼看去很像追加符号
- **balance 0 After**   这个默认情况下会给人造成一个误解会让认为是对于每个客户的一个金额变化的记录工具，实际不是这样的。因为本身这种 flash 是原子性的，一个交易内借出，一个交易内换回去，所以这个的金额是整体的全局金额进行了。


   
<!-- Content_END -->
