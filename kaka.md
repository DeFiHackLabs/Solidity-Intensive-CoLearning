---
timezone: Asia/Shanghai
---

---
# 卡卡

1. 自我介绍 <br>
一名计算机技术爱好者，从事计算机安全领域的工作。不久前接触到区块链，被去中心化的愿景所吸引。打算深入学习相关的技术，期待与大佬们交流学习！

2. 你认为你会完成本次残酷学习吗？ <br>
一定的！
   
## Notes

<!-- Content_START -->

### 2024.09.15
学习内容：了解规则，完成报名。

### 2024.09.23
学习内容：<br>
学习第一讲的内容，了解了Solidity语言大概的结构，并在Remix上运行hello world程序。

### 2024.09.24
学习内容：<br>
#### 基础数据类型：

布尔类型：`bool`，值为`true`或`false`。

整数类型：有符号整数`int`和无符号整数`uint`。大小均为256 bits

可以指定不同位数，如`int8` `int16` `int32` .... `int256`(也即int)

地址类型：`address`用于存储20字节的以太坊地址。分为payable和非payable两种。



#### 复杂数据结构：

数组`array`：

支持定长数组和动态数组。数组中的元素可以是任何类型。

```
// 定长数组
uint[5] fixedArray = [1, 2, 3, 4, 5];

// 动态数组
uint[] dynamicArray;
```

`bytes`和`string`类型的变量是特殊的`arrays`。他们有一些相应的函数。

字节类型：`bytes`和`byte`。`byte`是定长的字节数组，等价于`bytes1`。`bytes`是动态字节数组。

```
bytes32 fixedByteArray = "Hello"; // 固定长度为32的字节数组
bytes dynamicByteArray = "Hello";  // 动态字节数组
```

字符串：`string`，动态大小的UTF-8编码字符串。

映射`mapping`：

键值对数据结构。键需要为基础数据类型，而值可以是任意类型。映射不支持遍历或取出所有键值对，但可以通过键访问对应的值。

结构体`struct`：

枚举`enum`：用于定义一组离散的常量，便于处理有限状态的情况。



引用类型有：`struct`、`array`、`mapping`。如果使用引用类型，则始终必须显式提供存储该类型的数据区域

每个引用类型都有一个附加注释，即“data location”，说明其存储位置。data location有三个选择：`memory`、`storage`、`calldata`

- memory：其生命周期仅限外部函数调用；
- storage：状态变量存储的位置，其生命周期仅限于合约的生命周期；
- calldata：包含函数参数的特殊数据位置；一个不可修改、非持久的区域，用于存储函数参数。

行为：

- storage和memory（或来自 calldata）之间的赋值总是创建一个独立的副本。
- 从memory到memory的赋值仅创建引用。
- 从storage到本地存储变量(**local**)的赋值也仅分配一个引用。
- 对存储的所有其他分配始终进行复制。这种情况的示例是对状态变量或存储结构类型的局部变量的成员的赋值，即使局部变量本身只是一个引用。???


### 2024.09.25
学习内容：<br>
`require`和`assert`是用于进行条件检查的函数。

`require(condition, "Error message")` 用于确保条件为真，如果条件为假，合约将抛出异常并回滚。

`assert(condition)` 通常用于检查逻辑错误。如果条件为假，将导致所有状态变化被回滚，并消耗所有的 Gas。



Solidity使用状态恢复（state-reverting）异常来处理错误。此类异常会撤销当前调用（及其所有子调用）中对状态所做的所有更改，并向调用者标记错误。

**revert**：

回滚可以被revert语句和revert函数触发。

```
// revert语句
revert CoustomError(arg1,arg2);
// revert函数
revert();
revert("description");
```

使用自定义错误示例通常比字符串描述便宜得多

自定义error

### 2024.09.26
学习内容：<br>
内建函数：msg

- msg.sender：消息调用者
- msg.data：完整的调用数据，不可修改，函数参数存储在其中；
- msg.gas：返回当前交易剩余的可用gas
- msg.sig：函数调用数据的前四个字节，指定要调用的函数；
- msg.value：通过消息发送给合约的wei的数量

gasleft()是一个内置的Solidity函数，它返回当前以太坊交易中剩余的gas量。

<!-- Content_END -->
