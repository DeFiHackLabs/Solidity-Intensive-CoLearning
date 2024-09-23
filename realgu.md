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

### 

<!-- Content_END -->
