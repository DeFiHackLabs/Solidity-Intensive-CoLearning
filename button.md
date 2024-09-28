---
timezone: Asia/Shanghai
---

---

# button

1. 自我介绍

    WTF Academy 成员，参与过WTF Academy相关开发、校对、翻译，担任本次学习的助教

2. 你认为你会完成本次残酷学习吗？
   
   可以完成

## Notes

<!-- Content_START -->
### 2024.09.27
学习 控制流，控制流即逻辑处理，都是正常开发常见的。

学习到一种插入算法常见错误，uint处理到负数后会报错，大家需要仔细处理。

学习 构造函数和修饰器，构造函数是一种特殊函数，每个合约只能部署一个，用于初始化变量。

修饰器用于处理函数的调用权限，只有某个地址可调用。

学习事件，包括事件的结构和如何触发事件。

evm中的log可以存储事件，分为主题和数据两部分。

### 2024.09.26
学习变量初始化，看到奇怪的名词，空白函数，发现只是起占位的作用，可以在继承函数中实现具体功能，但是具体用途和模板函数有什么区别呢？

AI解释也比较笼统，没理解，后续结合项目了解。

变量初始化完成后可以进行恢复初始化，和C++中的理解不同的是，delete实现的操作是恢复变量的初始值，而不是直接删除这个变量，那看来是只能

进行修改，而不能删除？还是有些奇怪。

学习常数，常数有在声明时候必须初始化的常数，并且不能修改。

也有可以分开处理的常数。


### 2024.09.25
学习函数输出，正常的函数调用中，我们会与协作人员规定函数返回格式，但是代码并没有强力检查。

从而很多情况下，会出现函数结果与预期不符，导致程序崩溃的问题，在web3中规定，一个函数有两个返回值。

returns返回规定的数据格式，return返回具体的返回值。

基于此进行的扩展，可以直接在returns中返回的指定的变量，这样就相当于是初始化，然后直接在函数中调用，就不需要return主动返回。

返回的值也可以留空，不处理。

学习数据位置，正常的数据对象分为两种，变量和常量，在web3中，因为不同的数据的存储是有成本的，

链上成本高，storage数据存储在链上，消耗gas高。

不在链上，就分为两种，一种是常量 calldata ，一种是变量 memory。

变量又分为三种，有一种又是特殊的，可以上链的，是状态变量。

其他的就是常见的局部变量和全局变量。

全局变量又分为两个类型，web3是处理时间与金钱问题，所以以太单位全是整数，没有小数点概念。

时间也是需要精确处理，提高合约的可读性和可维护性。

学习 引用类型，有数组和结构体。

学习映射的规则，比较重要的是映射也是链上的变量数据。

### 2024.09.24

学习 数值类型，除传统的类型外，web3中多了几种类型，分别是地址类，定长字节数组。

此外可以把enum显式转化为int。

学习 函数，我们在常见的函数分类中，分为类内函数和类外函数。

在web3中，有更多的分类，将内外有了更明确的分类。

又分为了

1. 内外可同时使用的
2. 只能从外调用的
3. 只能从合约内调用的，继承的合约可用
4. 只能从本合约内调用的，继承的合约也不可用

因为web3中更多都是基于账户操作，权限也更为专业。
分为三种类型，在这节中学习了常见的payable类型函数，用于交易操作。

### 2024.09.23

辅导大家使用git

### 

<!-- Content_END -->