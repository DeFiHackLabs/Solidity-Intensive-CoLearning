---
timezone: Asia/Shanghai
---


# YourName

1. 自我介绍

大家好，我是bayazi。开始入门区块链。

2. 你认为你会完成本次残酷学习吗？

会完成的
   
## Notes

<!-- Content_START -->

### 2024.09.23

完成了1~10

Solidity中的变量类型：

1.值类型(Value Type)

2.引用类型(Reference Type)

3.映射类型(Mapping Type):

函数：

public：内部和外部均可见。

private：只能从本合约内部访问，继承的合约也不能使用。

external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。

internal: 只能从合约内部访问，继承的合约可以用。

注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。

注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。

[pure|view|payable]：决定函数权限/功能的关键字

包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

pure：既不能读取也不能写入链上的状态变量

view：能读取但也不能写入状态变量

returns：跟在函数名后面，用于声明返回的变量类型及变量名。

return：用于函数主体中，返回指定的变量。

可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值

存储位置：

Solidity数据存储位置有三类：storage，memory和calldata。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少

1.storage：合约里的状态变量默认都是storage，存储在链上。

2.memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。

3.calldata：不可变的memory

变量的作用域：

1.状态变量：在合约内、函数外声明，存储在链上

2.局部变量：函数执行过程中有效的变量，在内存中

3.全局变量：全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用

（一个文件内好像只能部署最先的合约？，05运行的时候只显示了DataStorage）

数组array

固定长度数组：T[k]

可变长度数组（动态数组）：T[]

bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

数组成员

length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。

push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。

push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。

pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。

映射Mapping

声明映射的格式为mapping(_KeyType => _ValueType)

_KeyType只能选择Solidity内置的值类型，_ValueType可以使用自定义的类型

映射的存储位置必须是storage

如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value

给映射新增的键值对的语法为_Var[_Key] = _Value

delete a会让变量a的值变为初始值。

插入排序

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Sort {

    function sort(uint[] memory a) public pure returns(uint[] memory){
        for(uint i = 1; i < a.length; i++){
            uint j = i;
            while (j > 0) {
                if (a[j-1] > a[j]){
                    uint temp = a[j - 1];
                    a[j - 1] = a[j];
                    a[j] =  temp;
                }
                else {
                    break;
                }
                j--;
            }
        }
        return(a);
    }
}

```

### 2024.09.24

构造函数

constructor每个合约可以定义一个，并在部署合约的时候自动运行一次

修饰器

声明函数拥有的特性，并减少代码冗余

事件

是`EVM`上日志的抽象，它具有两个特点：

响应：应用程序ethers.js可以通过`RPC`接口订阅和监听这些事件，并在前端做响应。

经济：事件是`EVM`上比较经济的存储数据的方式，每个大概消耗2,000 `gas`；相比之下，链上存储一个新变量至少需要20,000 `gas`。

声明事件

事件的声明由`event`关键字开头，接着是事件名称，括号里面写好事件需要记录的变量类型和变量名

释放事件

我们可以在函数里释放事件。在下面的例子中，每次用`_transfer()`函数进行转账操作的时候，都会释放`Transfer`事件，并记录相应的变量

EVM日志

每条日志记录都包含主题`topics`和数据`data`两部分。

主题：用于描述事件，长度不能超过`4`。它的第一个元素是事件的签名（哈希）

数据：事件中不带 `indexed`的参数会被存储在 `data` 部分中

继承

`virtual`: 父合约中的函数，如果希望子合约重写，需要加上`virtual`关键字。

`override`：子合约重写了父合约中的函数，需要加上`override`关键字。

多重继承

1.继承时要按辈分最高到最低的顺序排

2.如果某一个函数在多个继承的合约里都存在，比如例子中的`hip()`和`pop()`，在子合约里必须重写，不然会报错。

3.重写在多个父合约中都重名的函数时，`override`关键字后面要加上所有父合约名字，例如`override(Yeye, Baba)`。

修饰器继承

`Solidity`中的修饰器（`Modifier`）同样可以继承，用法与函数继承类似，在相应的地方加`virtual`和`override`关键字即可。

构造函数继承

1.在继承时声明父构造函数的参数

2.在子合约的构造函数中声明构造函数的参数

调用父合约的函数

1.直接调用

2.super调用最近父合约函数

钻石继承

指一个派生类同时有两个或两个以上的基类

在多重+菱形继承链条上使用`super`关键字时，需要注意的是使用`super`会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。

抽象合约

如果一个智能合约里至少有一个未实现的函数，即某个函数缺少主体`{}`中的内容，则必须将该合约标为`abstract`，不然编译会报错；另外，未实现的函数需要加`virtual`，以便子合约重写。

接口

接口类似于抽象合约，但它不实现任何功能。接口的规则：

1.不能包含状态变量

2.不能包含构造函数

3.不能继承除接口外的其他合约

4.所有函数都必须是external且不能有函数体

5.继承接口的非抽象合约必须实现接口定义的所有功能

接口提供了两个重要的信息：

1.合约里每个函数的`bytes4`选择器，以及函数签名`函数名(每个参数类型）`。

2.接口id

异常

1.error：方便且高效（省`gas`）

error必须搭配revert

2.require：`gas`随着描述异常的字符串长度增加

3.assert：程序员写程序debug

### 2024.09.25

重载

不允许修饰器（`modifier`）重载

实参匹配

如果出现多个匹配的重载函数，则会报错

库合约

库合约是一系列的函数合集

1.不能存在状态变量

2.不能够继承或被继承

3不能接收以太币

4.不可以被销毁

`import`语句可以帮助我们在一个文件中引用另一个文件的内容

### 2024.09.26

准备明天的预推免摸了

### 2024.09.27

**`Solidity`支持两种特殊的回调函数**，`receive()`和`fallback()`

1.接收ETH

2.处理合约中不存在的函数调用（代理合约proxy contract）

接收ETH函数 receive

`receive()`函数是在合约收到`ETH`转账时被调用的函数。一个合约最多有一个`receive()`函数

回退函数 fallback

`fallback()`函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约`proxy contract`

receive和fallback的区别

合约接收`ETH`时，`msg.data`为空且存在`receive()`时，会触发`receive()`；`msg.data`不为空或不存在`receive()`时，会触发`fallback()`，此时`fallback()`必须为`payable`。均不存在报错

**`Solidity`有三种方法向其他合约发送`ETH`**，他们是：`transfer()`，`send()`和`call()`，其中`call()`是被鼓励的用法。

**transfer：**

1.用法是`接收方地址.transfer(发送ETH数额)`。

2.`transfer()`的`gas`限制是`2300`，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。

3.`transfer()`如果转账失败，会自动`revert`（回滚交易）。

**send：**

1.用法是`接收方地址.send(发送ETH数额)`。

2.`send()`的`gas`限制是`2300`，足够用于转账，但对方合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑。

3.`send()`如果转账失败，不会`revert`。

4.`send()`的返回值是`bool`，代表着转账成功或失败，需要额外代码处理一下。

**call：**

1.用法是`接收方地址.call{value: 发送ETH数额}("")`。

2.`call()`没有`gas`限制，可以支持对方合约`fallback()`或`receive()`函数实现复杂逻辑。

3.`call()`如果转账失败，不会`revert`。

4.`call()`的返回值是`(bool, bytes)`，其中`bool`代表着转账成功或失败，需要额外代码处理一下。

调用已部署合约

在`Solidity`中，一个合约可以调用另一个合约的函数，这在构建复杂的DApps时非常有用。

1.传入合约地址

2.传入合约变量

3.创建合约变量

4.调用合约并发送ETH

### 2024.09.28

**call：**

`call` 是`address`类型的低级成员函数，它用来与其他合约交互。它的返回值为`(bool, bytes memory)`，分别对应`call`是否成功以及目标函数的返回值。

`call`是`Solidity`官方推荐的通过触发`fallback`或`receive`函数发送`ETH`的方法。

**delegatecall：**

`delegatecall`与`call`类似，是`Solidity`中地址类型的低级成员函数。

一个投资者（用户`A`）把他的资产（`B`合约的`状态变量`）都交给一个风险投资代理（`C`合约）来打理。执行的是风险投资代理的函数，但是改变的是资产的状态。

目前`delegatecall`主要有两个应用场景：

1.代理合约（`Proxy Contract`）：**将智能合约的存储合约和逻辑合约分开**：代理合约（`Proxy Contract`）存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约（`Logic Contract`）里，通过`delegatecall`执行。当升级时，只需要将代理合约指向新的逻辑合约即可。

2.EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。钻石是具有多个实施合约的代理合约。

两个合约变量存储布局必须相同

B通过call来调用C的setVars()函数，将改变合约C里的状态变量

B通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量

### 2024.09.29

在以太坊链上，用户（外部账户，`EOA`）可以创建智能合约，智能合约同样也可以创建新的智能合约。

有两种方法可以在合约中创建新合约，`create`和`create2`

`create`的用法很简单，就是`new`一个合约，并传入新合约构造函数所需的参数

`CREATE2` 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址

`CREATE2`的用法和之前讲的`CREATE`类似，同样是`new`一个合约，并传入新合约构造函数所需的参数，只不过要多传一个`salt`参数

#### 如果部署合约构造函数中存在参数

计算时，需要将参数和initcode一起进行打包

**create2的实际应用场景**

1.交易所为新用户预留创建钱包合约地址。

2.由 `CREATE2` 驱动的 `factory` 合约，在`Uniswap V2`中交易对的创建是在 `Factory`中调用`CREATE2`完成。这样做的好处是: 它可以得到一个确定的`pair`地址, 使得 `Router`中就可以通过 `(tokenA, tokenB)` 计算出`pair`地址, 不再需要执行一次 `Factory.getPair(tokenA, tokenB)` 的跨合约调用。

**selfdestruct**

`selfdestruct`命令可以用来删除智能合约，并将该合约剩余`ETH`转到指定地址。`selfdestruct`是为了应对合约出错的极端情况而设计的

1.已经部署的合约无法被`SELFDESTRUCT`了。

2.如果要使用原先的`SELFDESTRUCT`功能，必须在同一笔交易中创建并`SELFDESTRUCT`。

**注意**

1.对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符`onlyOwner`进行函数声明。

2.当合约中有`selfdestruct`功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用`selfdestruct`向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

### 2024.09.30

**ABI**是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型.

`Solidity`中，`ABI编码`有4个函数：`abi.encode`, `abi.encodePacked`, `abi.encodeWithSignature`, `abi.encodeWithSelector`。而`ABI解码`有1个函数：`abi.decode`，用于解码`abi.encode`的数据。

abi.encode

将给定参数利用ABI规则编码。`ABI`被设计出来跟智能合约交互，他将每个参数填充为32字节的数据，并拼接在一起。如果要和合约交互，要用的就是`abi.encode`

abi.encodePacked

将给定参数根据其所需最低空间编码。它类似 `abi.encode`，但是会把其中填充的很多`0`省略。比如，只用1字节来编码`uint8`类型。当想省空间，并且不与合约交互的时候，可以使用`abi.encodePacked`

abi.encodeWithSignature

与`abi.encode`功能类似，只不过第一个参数为`函数签名`。当调用其他合约的时候可以使用。

abi.encodeWithSignature

与`abi.encodeWithSignature`功能类似，只不过第一个参数为`函数选择器`，为`函数签名`Keccak哈希的前4个字节。

abi.decode

`abi.decode`用于解码`abi.encode`生成的二进制编码，将它还原成原本的参数。

`Keccak256`函数是`Solidity`中最常用的哈希函数

### 2024.10.01

**函数选择器**

当我们调用智能合约时，本质上是向目标合约发送了一段`calldata`，发送的`calldata`中前4个字节是`selector`（函数选择器）。

`calldata`就是告诉智能合约，我要调用哪个函数，以及参数是什么。

`method id`定义为`函数签名`的`Keccak`哈希后的前4个字节，当`selector`与`method id`相匹配时，即表示调用该函数。在同一个智能合约中，不同的函数有不同的函数签名，因此我们可以通过函数签名来确定要调用哪个函数。

映射类型参数通常有：`contract`、`enum`、`struct`等。在计算`method id`时，需要将该类型转化成为`ABI`类型。0

**try-catch**

在`Solidity`中，`try-catch`只能被用于`external`函数或创建合约时`constructor`（被视为`external`函数）的调用。

### 2024.10.02

**ERC20**

`ERC20`是以太坊上的代币标准，它实现了代币转账的基本逻辑：

账户余额(balanceOf())

转账(transfer())

授权转账(transferFrom())

授权(approve())

代币总供给(totalSupply())

授权转账额度(allowance())

代币信息（可选）：名称(name())，代号(symbol())，小数位数(decimals())

**IERC20**

`IERC20`是`ERC20`代币标准的接口合约，规定了`ERC20`代币需要实现的函数和事件。 之所以需要定义接口，是因为有了规范后，就存在所有的`ERC20`代币都通用的函数名称，输入参数，输出参数。 在接口函数中，只需要定义函数名称，输入参数，输出参数，并不关心函数内部如何实现。

**代币水龙头**

代币水龙头就是让用户免费领代币的网站/应用。

### 2024.10.03

**空投 Airdrop**

空投是币圈中一种营销策略，项目方将代币免费发放给特定用户群体。为了拿到空投资格，用户通常需要完成一些简单的任务，如测试产品、分享新闻、介绍朋 友等。项目方通过空投可以获得种子用户，而用户可以获得一笔财富，两全其美。

因为每次接收空投的用户很多，项目方不可能一笔一笔的转账。利用智能合约批量发放`ERC20`代币，可以显著提高空投效率

**ERC165**

智能合约可以声明它支持的接口，供其他合约检查

**IERC721**

`IERC721`是`ERC721`标准的接口合约，规定了`ERC721`要实现的基本函数。它利用`tokenId`来表示特定的非同质化代币，授权或转账都要明确tokenId

<!-- Content_END -->
