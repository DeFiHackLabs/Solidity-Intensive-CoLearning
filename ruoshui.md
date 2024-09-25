---
timezone: Asia/Shanghai
---

# ruoshui

come on
   
## Notes

<!-- Content_START -->

### 2024.09.23
1、在 Remix 中使用整型运算时，运算符红色，结果编译正常，还以为是错误了呢

2、用 ai 查询了下 uint 和 unit256 的区别，说是没啥区别，使用起来是一样的

3、用 payable 修饰的 address 类型多了 `transfer` 和 `send` 方法 

4、bytes32 最多存储 32 bytes 数据，通常用 16 进制存储

5、四种函数可见性说明符，需明确指定，无默认

   - `public`：内部和外部均可见。
   - `private`：只能从本合约内部访问，继承的合约也不能使用。
   - `external`：只能从合约外部访问（但内部可以通过 `this.f()` 来调用，`f`是函数名）。
   - `internal`: 只能从合约内部访问，继承的合约可以用。
     
6、决定函数权限/功能的关键字，默认能读能写不可支付

   - `payable`：可支付的，运行的时候可以往合约里面转钱
   - `pure`：不能读不能写
   - `view`：只能看不能写

pure 使用示例

```solidity
// pure: 纯纯牛马
function addPure(uint256 _number) external pure returns(uint256 new_number){
    new_number = _number + 1;
}
```
### 2024.09.24
1、返回值 return 和 returns

   - `returns`：跟在函数名后面，用于声明返回的变量类型及变量名，如果标明了返回变量名，可无需 `return`
   - `return`：用于函数主体中，返回指定的变量
     
2、三种存储位置

   - `storage`：合约里的状态变量默认都是`storage`，存储在链上，消耗 gas 高。赋值给 `storage` 修饰的新变量，修改新变量值会影响原变量，用 `memory` 修饰的则不会
   - `memory`：函数里的参数和临时变量一般用`memory`，存储在内存中，不上链，消耗 gas 低。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构
   - `calldata`：和`memory`类似，存储在内存中，不上链。与`memory`的不同点在于`calldata`变量不能修改（`immutable`），一般用于函数的参数

3、常见全局变量，完整[链接](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)

   - `blockhash(uint blockNumber)`: (`bytes32`) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
   - `block.coinbase`: (`address payable`) 当前区块矿工的地址
   - `block.gaslimit`: (`uint`) 当前区块的gaslimit
   - `block.number`: (`uint`) 当前区块的number
   - `block.timestamp`: (`uint`) 当前区块的时间戳，为unix纪元以来的秒
   - `gasleft()`: (`uint256`) 剩余 gas
   - `msg.data`: (`bytes calldata`) 完整call data
   - `msg.sender`: (`address payable`) 消息发送者 (当前 caller)
   - `msg.sig`: (`bytes4`) calldata的前四个字节 (function identifier)
   - `msg.value`: (`uint`) 当前交易发送的 `wei` 值
   - `block.blobbasefee`: (`uint`) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
   - `blobhash(uint index)`: (`bytes32`) 返回跟当前交易关联的第 `index` 个blob的版本化哈希（第一个字节为版本号，当前为`0x01`，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。

4、以太单位

- `wei`: 1
- `gwei`: 1e9 = 1000000000
- `ether`: 1e18 = 1000000000000000000

### 2024.09.25
1、`bytes`是一个不需要加 `[]` 的数组，不能用 `byte[]` 声明单字节数组，可以使用`bytes`或`bytes1[]`，`bytes` 比 `bytes1[]` 省gas

2、`uint[]`数组元素 type 通常以第一个为准，如果不指定，会根据上下文推断元素 type, 默认为最小单位类型 `uint8`

3、对于 `memory` 修饰的动态数组，可以用 `new` 操作符来创建，但是必须声明长度，并且声明后长度不能改变

   ```solidity
       uint[] memory array8 = new uint[](5);
       bytes memory array9 = new bytes(9);
   ```
4、数组成员

- `length`: `memory`数组的长度在创建后是固定的
- `push()`: `动态数组`拥有`push()`成员，可以在数组最后添加一个`0`元素，并返回该元素的引用
- `push(x)`: `动态数组`拥有`push(x)`成员，可以在数组最后添加一个`x`元素
- `pop()`: `动态数组`拥有`pop()`成员，可以移除数组最后一个元素

5、两种结构体构造函数赋值方法

```solidity
   // 结构体 Struct
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student student; // 初始一个student结构体

    function initStudent3() external {
        student = Student(3, 90);
    }

    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }
```

6、映射的 `_KeyType` 只能选择 Solidity 内置的值类型，比如 `uint`，`address`等; 映射的存储位置必须是 `storage`

```solidity
   mapping(uint => address) public idToAddress; // id映射到地址
   mapping(address => address) public swapPair; // 币对的映射，地址到地址

   function writeMap (uint _Key, address _Value) public{
      idToAddress[_Key] = _Value;
   }
```
### 

<!-- Content_END -->
