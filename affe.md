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


### 

<!-- Content_END -->
