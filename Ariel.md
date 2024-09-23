---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍
我是Ariel,在參與本次共學前從未接觸過Solidity 與智能合約相關知識，發現自己太多不了解的知識，想要扎實從頭學起～

2. 你认为你会完成本次残酷学习吗？
我覺得我可以完成本次殘酷共學。為了完成此次學習，我有空出每天一段時間，希望可以幫助我成功完成學習。
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
WTF Academy #1-5
![1000005316](https://github.com/user-attachments/assets/8a67b9f8-ff71-43a5-bf23-3eefc2545d19)

#2 enum枚举:uint 分配名稱與維護

#3 函數類型：prue/view

#4 函數輸出：命名式返回/結構式賦值（读取函数的全部或部分返回值）

#5 儲存位置
1.
store:狀態變量、上鏈
memory：參數與臨時變量，內存中不上鏈
calldata：類memory,不可修改

2. 會影響變量：
storage->storage
memory ->memory

3. 作用域：

狀態：鏈上，gas消耗高
局部：函數執行過程中，內存，完成消失，函數內聲明
全局：可不聲明，為預留關鍵字

3个常用的全局变量：msg.sender，block.number和msg.data，他们分别代表请求发起地址，当前区块高度，和请求数据。下面是一些常用的全局变量，更完整的列表请看这个链接：
blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
block.coinbase: (address payable) 当前区块矿工的地址
block.gaslimit: (uint) 当前区块的gaslimit
block.number: (uint) 当前区块的number
block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
gasleft(): (uint256) 剩余 gas
msg.data: (bytes calldata) 完整call data
msg.sender: (address payable) 消息发送者 (当前 caller)
msg.sig: (bytes4) calldata的前四个字节 (function identifier)
msg.value: (uint) 当前交易发送的 wei 值
block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量。


4. 乙太單位
精度表示，以0代替小數點
wei: 1
gwei: 1e9 = 1000000000
ether: 1e18 = 1000000000000000000

5. 時間單位

### 2024.

<!-- Content_END -->
