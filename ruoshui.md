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


### 

<!-- Content_END -->
