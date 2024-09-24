---
timezone: Asia/Shanghai
---

---

# YuanboXie

1. 自我介绍: Web3 & AI researcher

2. 你认为你会完成本次残酷学习吗？大概率可以
   
## Notes

- WTF Academy Solidity 101 1-15
- WTF Academy Solidity 102 16-30
- WTF Academy Solidity 103 31-50
- 完成取得 Solidity 101、102 链上证书

<!-- Content_START -->

### 2024.09.23

之前看过这个，但好久没写又忘了。今天重新捡起来复习一下。

- [101-1] 测试题有个地方第一遍打错了：`带有 pragma solidity ^0.8.4; 的智能合约能否被 solidity 0.8版本编译？`，答案是不行，这个0.8.4是只能被>=0.8.4的编译
- [101-2] 类型：value type、reference type、mapping type;
    - solidity 特殊类型：address，以及 payable address: `payable(address)`,后者比普通地址多了 transfer 和 send 方法, 以及可以通过 `address.balance` 查询余额;
    - 定长字节数组、不定长字节数组
    - enum

```solidity
address payable addr;
addr.transfer(1); // 注意这个是从合约给 addr 转账的意思，单位是 wei
```

- [101-3] function: 
```solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- {internal|external|public|private}：可见性，合约中定义的函数需要明确指定可见性，它们没有默认值。public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。
    - public：内部和外部均可见。
    - private：只能从本合约内部访问，继承的合约也不能使用。
    - external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
    - internal: 只能从合约内部访问，继承的合约可以用。
- [pure|view|payable]：决定函数权限/功能的关键字。
    - pure: 既不能读取也不能写入链上的状态变量;
    - view: 能读取但也不能写入状态变量;
    - payable: 带 payable 的 function 可以存 ether;

以太坊交易需要支付 gas fee。合约的状态变量存储在链上，gas fee 很贵，如果计算不改变链上状态，就可以不用付 gas。包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

### 2024.09.24

- [101-4] 函数输出
- Solidity 中与函数输出相关的有两个关键字：return和returns。它们的区别在于：
    - returns：跟在函数名后面，用于声明返回的变量类型及变量名。
        - 命名式返回
    - return：用于函数主体中，返回指定的变量。
```solidity
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){ // 数组类型返回值默认必须用 memory 修饰
    return(1, true, [uint256(1),2,5]);
}
```
- 解构赋值:
```solidity
(_number, _bool, _array) = returnNamed();
(, _bool2, ) = returnNamed();
```
- [101-5] 变量数据存储和作用域 storage/memory/calldata
- 引用类型(Reference Type)：包括数组（array）和结构体（struct），由于这类变量比较复杂，占用存储空间大，我们在使用时必须要声明数据存储的位置。
- Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。
    - storage：合约里的状态变量默认都是storage，存储在链上。
    - memory：函数里的参数和临时变量一般用 memory，存储在内存中，不上链。如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
    - calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改，一般用于函数的参数。
- 在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。
```solidity
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
    uint[] storage xStorage = x;
    uint[] memory xMemory = x; // memory 不会修改 storage 所以不是引用，此外 memory 赋值给 memory，会创建引用，改变新变量会影响原变量。
    xStorage[0] = 100;
}
```
- 全局变量、局部变量、状态变量
    - 全局变量：都是solidity预留关键字。他们可以在函数内不声明直接使用。 详细查看: [docs](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
        - msg.sender
        - block.number
        - msg.data
        - blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
        - block.coinbase: (address payable) 当前区块矿工的地址
        - block.gaslimit: (uint) 当前区块的gaslimit
        - block.number: (uint) 当前区块的number
        - block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
        - gasleft(): (uint256) 剩余 gas
        - msg.data: (bytes calldata) 完整call data
        - msg.sender: (address payable) 消息发送者 (当前 caller)
        - msg.sig: (bytes4) calldata的前四个字节 (function identifier)
        - msg.value: (uint) 当前交易发送的 wei 值
        - block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
        - blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。
- 货币单位
    - wei: 1
    - gwei: 1e9 = 1000000000
    - ether: 1e18 = 1000000000000000000
- 时间单位
    - 1 seconds: 1
    - 1 minutes: 60 seconds = 60
    - 1 hours: 60 minutes = 3600
    - 1 days: 24 hours = 86400
    - 1 weeks: 7 days = 604800

- [101-6] array、struct
    - 固定长数组、变长数组
        - bytes 比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
        - 对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。
        ```solidity
        // memory动态数组
        uint[] memory array8 = new uint[](5);
        bytes memory array9 = new bytes(9);
        ```
        - array.length
        - 动态数组
            - array.push()
            - array.pop()

<!-- Content_END -->
