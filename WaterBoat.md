---
timezone: Asia/Shanghai
---


# WaterBoat

1. 自我介绍

Hi，我是WaterBoat，目前在深圳自由要饭中。

2. 你认为你会完成本次残酷学习吗？

会的

## Notes

<!-- Content_START -->

### 2024.09.23

##### Solidity 是什么

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7af14412fd1483cbf7330ca717823ce~tplv-k3u1fbpfcp-image.image#?w=1300&#x26;h=1300&#x26;s=1665&#x26;e=svg&#x26;a=1&#x26;b=000000" alt="Solidity logo" width="150">

Solidity 是一门面向合约的、为实现智能合约而创建的高级编程语言。这门语言受到了 C++，Python 和 Javascript 语言的影响，设计的目的是能在以太坊虚拟机（EVM）上运行。

Solidity 是静态类型语言，支持继承、库和复杂的用户定义类型等特性。

##### 开发工具

###### Remix

`remix`是以太坊官方推荐的智能合约开发IDE（集成开发环境），适合新手，可以在浏览器中快速部署测试智能合约，你不需要在本地安装任何程序。

网址：[remix.ethereum.org](https://remix.ethereum.org/)

进入`remix`，我们可以看到最左边的菜单有三个按钮，分别对应文件（写代码的地方），编译（跑代码），部署（部署到链上）。我们点新建（`Create New File`）按钮，就可以创建一个空白的`solidity`合约

![808fa2e3af25459cbc069f4fe976f05f_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232238085.jpg)

我们来编写一段代码

```solidity
// SPDX-License-Identifier: MIT // 不写这个编辑器会警告,但是不影响运行
pragma solidity ^0.8.0; // 指定编译器版本 不允许小于 0.8.0 或大于 0.9.0的编译器编译

contract HelloWorld { // 创建合约(contract) 名字为 HelloWorld
    // 定义变量类型为 string 变量名威 _string 赋值为 HelloWorld
    string public _string = "HelloWorld!";
}
```

编写好代码之后我们点击左侧的编译

![18c051af6f0d49989dc8ff4abb2a49ea_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232239365.jpg)

然后点击部署

![12](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240038.jpg)

点击即可查看到值

######  VSCode

如果你不喜欢在线的编译工具我们可以使用本地环境来进行编译代码

在 VScode 中搜索插件 [Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity) 进行安装,作用是让代码进行高亮和补充一些代码提示

![111](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240976.jpg)

接下来我们打开 [remix](https://remix.ethereum.org/)

来到首页点击`Access File System`

![10f56a71c479438db788f17610ab7097_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232241733.jpg)

出现提示让我们安装一个 npm 包,我们根据文档的说明进行一下安装

```sh
npm install -g @remix-project/remixd
```

然后我们创建一个 sol 文件并在终端中找到他的文件夹所在地输入命令 `remixd`

![1a651ca9d68248c0a9c2d685a49bb6b7_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232242918.jpg)

并在网页上点击`content`进行连接即可完成

![image-20240426153811790](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/96b2e832ac8649b581574c1cd6922b18~tplv-k3u1fbpfcp-jj-mark:0:0:0:0:q75.image#?w=1066\&h=1024\&s=193843\&e=png\&b=212235)

##### 总结

这一讲,我们介绍了 solidity 、开发工具 remix 并且介绍了一下 vscode 和 remix 如何进行联动编写 HelloWorld。





### 2024.09.24

#### Solidity 数据类型

在 Solidity 中数据类型分为:

1. 值类型 (Value Type): 布尔类型、整型等，因为它们的变量通过值传递
2. 引用类型 (Reference Type): 数组、结构体，赋值的时候传递的是地址
3. 映射类型 (Mapping Type):类似于JS中的对象存储键值对,也可以理解为哈希表



#### 值类型

##### 1.布尔型(bool)

布尔类型只有两个值,`true`或`false`



```sol
bool public _bool = true
```



布尔值的运算符包括：

- `!` （逻辑非）
- `&&` （逻辑与，"and"）
- `||` （逻辑或，"or"）
- `==` （等于）
- `!=` （不等于）

短路运算



```sol
true || false // true
true && false // true

false || true // true
false && true // false

```

在 `||` 运算中第一个条件为 `true`时则中断运算返回 `true`

在 `&&` 运算中第一个条件为 `false` 时则中断运算返回`false`



##### 2.整型

整型举例

```sol
int public _int = 1 // 整数,包括负数
uint public _uint = -1 // 正整数
uint256 public _number = 114514 // 256位正整数
```

常用的整型运算符包括：

- 比较运算符（返回布尔值）： `<=`， `<`，`==`， `!=`， `>=`， `>`
- 算数运算符： `+`， `-`， `*`， `/`， `%`（取余），`**`（幂）

> 注意`0**0` 被EVM定义为 `1`



##### 3.地址类型

地址类型(address)有两类：

- 普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
- payable address: 比普通地址多了 `transfer` 和 `send` 两个成员方法，用于接收转账。



```sol
// 地址
address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
address payable public _address1 = payable(_address); // payable address，可以转账、查余额
// 地址类型的成员
uint256 public balance = _address1.balance; // balance of address
```



##### 4.字节数组



字节数组分为定长和不定长两种：

- 定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 `bytes1`, `bytes8`, `bytes32` 等类型。定长字节数组最多存储 32 bytes 数据，即`bytes32`。
- 不定长字节数组: bytes、string属于引用类型（之后的章节介绍），数组长度在声明之后可以改变。



```sol
// 固定长度的字节数组
bytes32 public _byte32 = "MiniSolidity"; 
bytes1 public _byte = _byte32[0]; 


bytes public data;
string public _string = "1232131";
```



##### 5. 枚举

枚举（`enum`）是 Solidity 中用户定义的数据类型。它主要用于为 `uint` 分配名称，使程序易于阅读和维护。类似于 Typescript 中的枚举类型

```solidity
// 用enum将uint 0， 1，表示为 teacher, student
enum School {teacher, student }
School action = School.student;
```

枚举可以显式地和 `uint` 相互转换，并会检查转换的正整数是否在枚举的长度内，否则会报错：

```solidity
// enum可以和uint显式的转换
function enumToUint() external view returns(uint){
    return uint(action);
}
```



#### 总结

学习了 Solidity 中值类型，包括布尔型、整型、地址、定长字节数组和枚举







<!-- Content_END -->