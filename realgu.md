---
timezone: Asia/Shanghai
---

---

# realgu

1. 自我介绍
   TradFi Dev

3. 你认为你会完成本次残酷学习吗？
   会，下死命令
   
## Notes

<!-- Content_START -->

### 2024.09.23
这部分之前学过，快速过一遍，记一下有趣的地方
1. // SPDX-License-Identifier: MIT 注释不写会有warning
2. 在 Remix 编辑代码的页面，按 Ctrl + S 即可编译代码
3. 三种整型：int uint uint256
4. payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账
5. 在以太坊中，以下语句被视为修改链上状态：
-写入状态变量。
-释放事件。
-创建其他合约。
-使用 selfdestruct.
-通过调用发送以太币。
-调用任何未标记 view 或 pure 的函数。
-使用低级调用（low-level calls）。
-使用包含某些操作码的内联汇编。
6. pure 函数既不能读取也不能写入链上的状态变量
7. view函数能读取但也不能写入状态变量
8. 非 pure 或 view 的函数既可以读取也可以写入状态变量

### 2024.09.24
1. returns：跟在函数名后面，用于声明返回的变量类型及变量名。return：用于函数主体中，返回指定的变量。
2. 命名式返回（第一次见到）
3. storage：合约里的状态变量默认都是storage，存储在链上。
4. memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
5. calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。
6. storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
7. [全局变量列表](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
8. bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

### 

<!-- Content_END -->
