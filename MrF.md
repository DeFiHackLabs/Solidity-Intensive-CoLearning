---
timezone: Asia/Shanghai
---

# MrF

1. 一个有拖延症的程序员

2. 可以的
   

<!-- Content_START -->
### 2024.09.23
1 学习什么是Solidity 以及Remix工具
新建了第一个 HelloWeb3 程序


### 2024.09.24

1 学习了101 第二章
知识点 1：Solidity中的变量类型 值类型  引用类型 映射类型
      2：address 与 payable address 的区别
      3：uint256（256位正整数） uint（正整数） int（整数，包括负数）  的区别


### 2024.09.25

1 学习了101 第三章
知识点 1：public：内部和外部均可见。
        private：只能从本合约内部访问，继承的合约也不能使用。
        external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
        internal: 只能从合约内部访问，继承的合约可以用。
      2： pure 与  view  关键字的区别 payable代表的意思。
      3: https://github.com/DeFiHackLabs/Solidity-Intensive-CoLearning/blob/MrF/content/MrF/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20240925234418.png

### 2024.09.26

1 学习了101 第四章
知识点 1 returns：跟在函数名后面，用于声明返回的变量类型及变量名。
        return：用于函数主体中，返回指定的变量。
      2 命名式返回  解构式赋值  两者区别

### 2024.09.28

1 学习了101 第五章 第六章
知识点 1 引用类型(Reference Type)：包括数组（array）和结构体（struct）
      2 存储位置有三类：storage，memory和calldata  三者区别点 gas 消耗
      3 状态变量（state variable），局部变量（local variable）和全局变量(global variable) 三者作用域的区别

第六章 知识点
      1 引用类型, array, struct 的基本用法
      2 创建数组的规则 有动态数组与固定长度数组区别

### 2024.09.29

1 学习了101 第七章
知识点 1 映射类型 mapping 映射的_KeyType只能选择Solidity内置的值类型，而_ValueType可以使用自定义的类型
      2 映射的存储位置必须是storage 
      3学习映射的原理 映射不储存任何键（Key）的资讯，也没有length的资讯， 初始值都是各个type的默认值，如uint的默认值是0。

### 2024.10.01

1 学习了101 第八章
知识点 1 映射mapping: 所有元素都为其默认值的mapping
        结构体struct: 所有成员设为其默认值的结构体
        数组array 动态数组: [] 静态数组（定长）: 所有成员设为其默认值的静态数组
      2 delete a会让变量a的值变为初始值


### 2024.10.02

1 学习了101 第九章 常数 constant和immutable
  知识点
   1 不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。
   2 只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable
   3 初始化之后，尝试改变它的值，会编译不通

   第十章  控制流
  知识点
  1  学习了 if-else  for循环 while循环 do-while循环 三元运算符
  2 插入算法中，变量j有可能会取到-1，引起报错

  第十一章 构造函数和修饰器
  
  1  构造函数（constructor），每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数
  2  修饰器 modifier 的主要使用场景是运行函数前的检查，减少代码冗余。


### 2024.10.03

1 学习了101 第十二章 事件 Event
知识点
1 两个特点 可以通过RPC接口订阅和监听这些事件，并在前端做响应。 再就是经济 Gas少
2 每条日志记录都包含主题topics和数据data两部分
3 日志的主题： 长度：不能超过 4。 第一个元素：事件的签名哈希。 剩余元素：至多 3 个 indexed 参数（用于筛选和检索）。
4 indexed 参数： 作用：相当于事件的索引键，用于快速搜索和查询。 大小限制：每个 indexed 参数固定为 256 位。 超长参数处理：如果参数（如字符串）太长，会自动哈希化并存储。
5 数据 data  事件中不带 indexed的参数会被存储在 data 部分

 第十三章 继承
知识点
1 继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承
2 virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
  override：子合约重写了父合约中的函数，需要加上override关键字。
3 多重继承 继承时要按辈分最高到最低的顺序排 



### 2024.10.04

1 学习了101 第十四章 抽象合约和接口
知识点
1 接口
不能包含状态变量
不能包含构造函数
不能继承除接口外的其他合约
所有函数都必须是external且不能有函数体
继承接口的非抽象合约必须实现接口定义的所有功能
2 抽象合约
未实现的函数需要加virtual，以便子合约重写。合约标为abstract

2 十五章 异常
1 在执行当中，error必须搭配revert（回退）命令使用。
2 require(检查条件，"异常的描述")，gas随着描述异常的字符串长度增加
3 assert(检查条件），当检查条件不成立的时候，就会抛出异常
4 error方法gas最少，其次是assert，require方法消耗gas最多

十六章  函数重载
1 名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数

十七章 库合约
1 库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在
2 不能存在状态变量
不能够继承或被继承
不能接收以太币
不可以被销毁
3 指令using A for B;  通过库合约名称调用函数

十八章 Import
1 倒入方式 通过源文件相对位置导入 ，过源文件网址导入网上的合约的全局符号，通过npm的目录导入  ，通过指定全局符号导入合约特定的全局符号

十九章 接收ETH receive和fallback
 1 使用场景 接收ETH 处理合约中不存在的函数调用（代理合约proxy contract）
 2 msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。
<!-- Content_END -->