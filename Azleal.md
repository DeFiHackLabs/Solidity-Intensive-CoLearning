---
timezone: Asia/Shanghai
---

# Azleal

1. 自我介绍
> 全栈开发，重新复习一下solidity

2. 你认为你会完成本次残酷学习吗？
> 可以
   
## Notes

<!-- Content_START -->
### 2024.09.23
1. remix的使用

2. 变量类型
   - 值类型: 赋值时候直接传递数值
   - 引用类型: 包括数组和结构体，这类变量占空间大，赋值时候直接传递地址
   - 映射类型: Mapping
  
### 2024.09.24
1. 函数的基本形式
   `function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [virtual|override] [<modifiers>] [returns (<return types>)]{ <function body> }`
2. 数据存储的位置
   - calldata: 存在内存中，不可变，多用于参数传递
   - memory: 存在内存中，当返回结果为变长类型时必须使用memory
   - storage: 存在链上。
消耗gas的多少如下: calldata < memory < storage

一些节省gas的tips: 函数体内将storage遍历转化为memory变量，能够在后续使用的过程中有效降低gas。


<!-- Content_END -->
