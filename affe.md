---
timezone: Asia/Shanghai
---

---

# affe

1. 自我介绍

affe，目前在 GCC 做和公共物品相关的事儿。主要负责技术相关的内容。

2. 你认为你会完成本次残酷学习吗？

会。一直想学 Solidity，断断续续看了一些零散的内容，也正在部署一些合约。
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
- storage 的变量赋值给函数参数时，是引用类型的传递
- memory 赋值给 memory 参数也是引用传递
- 其他情况下都是值传递
- 状态变量（storage）在合约内，函数外声明；局部变量是在函数内声明的局部变量，memory 类型，不上链。全局变量都是 Solidty 预留的关键字，可以在函数内不声明直接使用。
- bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。
- 对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：
- Q： 为什么memory 定长数组赋值给可变长数组的时候会拷贝值？好神奇。
- 映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型。下面这个例子会报错，因为_KeyType使用了我们自定义的结构体
- mapping 必须是在 storage 中
- 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。这个行为感觉非常奇怪。
- Nansen Dune
- 继承时要按辈分最高到最低的顺序排。
- 如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。
- 为什么给 sendETH 合约调用 transfer 的时候，需要给定一个 Value值，而不用先给SendETH 合约转账 ？

```
 1. Transaction Execution Order:
The EVM (Ethereum Virtual Machine) processes transactions in a specific order. The transfer of Ether (ETH) from the sender to the contract (the msg.value) happens before the function code is executed.
2. Steps in Transaction Processing:
a) Verify the transaction (signature, nonce, etc.)
b) Deduct the transaction cost (gas gas price) from the sender's account
c) Transfer the msg.value from the sender to the contract
d) Execute the contract code
```


### 2024.09.24
- 今天在用 Remix 跟着写合约，写了一个简单的 ERC20 实现了 Burn 的合约。感觉 Solidity 的复杂度很大程度在于，需要考虑 “任何人都可能发送任意形式的请求”，这个和传统在 VPC 里的微服务价格差别很大。在私有网络里一个服务会大概接收到哪种类型的服务是确定的，需要考虑的 Edge Case 比较少，心智负担比较轻，而且安全的保证是几层几层的（物理层，网络层，各种 RBAC 啥的），但是在以太坊里，很大程度上安全依赖于业务代码，这要求写业务代码的时候必须考虑到安全问题以及各种 Edge Case.

### 2024.09.26

- 今天在看 Wagmi 和 Wallet Connect 相关的内容。我在 lido 的 dao-voting-ui 仓库里看源代码，梳理了整个 UI 和合约侧交互的逻辑。 web3 的 交互需要把 Contract 的 Abi 的 Json 文件传给 Wagmi，然后 Wagmi 会生成一些代码来给JS 调用 （React 则是以各种 Hook 的形式。 这里很麻烦，没有上手实践，明天继续看代码。



### 2024.09.26
- 今天对着 WTF 34 写 ERC721 的实现，总算搞懂了 NFT 是如何被实现的。
- 说一个我觉得有意思的点：NFT 就是通过合约内的 tokenUri() 以及 tokenId 指向IPFS上的一个数据文件。所有的交易部分都是在合约里。看懂了这一点就觉得很神奇。


### 2024.09.28

- a lot of the restrictions in smart contract is around :  Contracts are immutable after deployment
- 在看 OZ Upgradable
- Hardhat 的 Upgradable 的这个工具，确实会检查是否已经有部署的 Implementation Contract，并且除非impl contract 有改变，否则不会部署新的impl contract。是不是这就是导致了不同的proxy contract 都指向了同一个 impl contract
- Beacon Proxy 是做什么的 ？有点不太理解具体的场景。
- Etherscan 上的源代码不是天生就现实出来，需要人为Verify And Publish.
- The Hardhat plugin keeps track of all the implementation contracts you have deployed in an `.openzeppelin` folder in the project root. You will find one file per network there. It is advised that you commit to source control the files for all networks except the development ones
- So basically the deployed contracts is in the .openzeppelin folder. Maybe when I delete them it will deploy new contracts for me.
- 合约的验证需要指定 Compiler 以及 Compiler 参数，许可证版本，以及源代码。
- 下一步是继续看 Proxy 合约的一些知识，以及一些常见的 Proxy 合约。
    - UUPS 代理
    - Transparent 代理
    - Beacon 代理
<!-- Content_END -->
