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

### 2024.09.26

- WTF102章节内容：接收ETH、发送ETH、调用其他合约

#### 笔记

- 接收ETH:receive和fallback

```solidity
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
```

- 接收ETH

| function | gas limit | 是否支持对方合约fallback() or receive实现复杂逻辑 | 是否支持revert | 返回值 |
| --- | --- | --- | --- | --- |
|  paybale(_to).transfer(amount) | 2300 | 否 | 支持 | no returns |
| _to.send(amount) | 2300 | 否 | 不支持 | bool |
| _to.call{value: amount}("") | none | 是 | 不支持 | (bool,bytes) |

- gas limit

执行交易或合约时所能消耗的最大计算资源。如果你设定的 gas limit 是 100,000 gas，那么你的交易在任何情况下都不会消耗超过 100,000 gas。如果交易需要的 gas 超过了这个限制，交易就会失败。

- 调用其他合约

```solidity
function callSetX(address _Address, uint256 _x) external{
        OtherContract(_Address).setX(_x);
}
function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}
function callGetX2(address _Address) external view returns (uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
    //语法糖，隐式调用的是_to.call(value: msg.value);
}
```

### 2024.09.25
- WTF101章节内容：抽象合约和接口、异常
- WTF102章节内容：重载、库合约、Import

#### 笔记

- 接口规则
    1. 不能包含状态变量
    2. 不能包含构造函数
    3. 不能继承除接口外的其他合约
    4. 所有函数都必须是external且不能有函数体
    5. 继承接口的非抽象合约必须实现接口定义的所有功能
- 异常

  1.error
    
    ```solidity
    error TransferNotOwner();
    revert TransferNotOwner();
    //省gas
    ```
    
    2.Require
    
    ```solidity
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    //随着字符串增加gas增加
    ```
    
    3.Assert
    
    ```solidity
    assert(_owners[tokenId] == msg.sender);
    //只能抛出异常
    ```

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
