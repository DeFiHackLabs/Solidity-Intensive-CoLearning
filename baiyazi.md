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

<!-- Content_END -->
