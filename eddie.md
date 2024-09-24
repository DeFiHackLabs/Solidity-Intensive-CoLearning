---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍

大家好，我是eddie，智能合约初学者，希望和大家共同进步，WGMI

2. 你认为你会完成本次残酷学习吗？

必须的，恰好有一段时间可以用于本次学习活动中；
   
## Notes

<!-- Content_START -->
### 2024.09.24
- WTF101章节内容：映射类型、变量初始值、常数、控制流、构造函数和修饰器、事件、继承
#### 笔记

- map
  
1、key仅支持内置值类型，value支持struct

2、存储位置为storage，这里的map只用来记录关系，而不是一个类型；

3、当映射声明为public 时候，自动创建getter函数

4、val[key] = val

- constant和immutable

数值变量可以声明`constant`和`immutable`；

`string`和`bytes`可以声明为`constant`，但不能为`immutable`。
- EVM Log

用于存储Solidity Event，是函数和区块链之间的模块；

Topics: 描述事件,事件的签名（哈希）+最多3个indexed参数（256bit）

data: 事件的值，可存储任意大小的数据；
- 构造函数的继承

```Solidity
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
//调用父合约的构造函数
contract C is A {
	constructor(uint _c) A(_c * _c) {}
}//这里是C继承了父合约的构造函数，将_c为参数，_c*_c作为父合约构造函数的参数调用；
```

### 2024.09.23
- WTF101章节：HelloWeb3（三行代码）、数值类型、函数类型、函数输出、变量数据存储、引用类型
#### 笔记内容
uint256和uint实际上是一样的，都是0到2^256-1这个范围区间内；
一个字符2个字节；

> 四种函数可见性说明符，共有4种。
> 
> - **`public`**：内部和外部均可见。
> - **`private`**：只能从本合约内部访问，继承的合约也不能使用。
> - **`external`**：只能从合约外部访问（但内部可以通过 **`this.f()`** 来调用，**`f`**是函数名）。
> - **`internal`**: 只能从合约内部访问，继承的合约可以用。（默认状态变量的可见性）

> Pure和View、Default
> 针对的是修改链上state的权限
> - `Pure` 不能读、不能写
> - `View` 只能读、不能写
> - `Default` 能读、能写

> 数据位置：
> 
> - **`storage`**:合约里的状态变量默认都是`storage`，存储在链上。
> - **`memory`**：函数里的参数和临时变量一般用**`memory`**，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。|
> - **`calldata`**：和`memory`类似，存储在内存中，不上链。与`memory`的不同点在于`calldata`变量不能修改（`immutable`），一般用于函数的参数。例子：

memory修饰的数组的大小为定长类型


<!-- Content_END -->
