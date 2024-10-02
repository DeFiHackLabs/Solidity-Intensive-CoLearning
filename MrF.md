---
timezone: Asia/Shanghai
---

# MrF

1. 一个有拖延症的程序员

2. 可以的
   

<!-- Content_START -->
### 2024.09.23
1 学习什么是Solidity 以及Remix工具
新建了第一个 HelloWeb3 程序


### 2024.09.24

1 学习了101 第二章
知识点 1：Solidity中的变量类型 值类型  引用类型 映射类型
      2：address 与 payable address 的区别
      3：uint256（256位正整数） uint（正整数） int（整数，包括负数）  的区别


### 2024.09.25

1 学习了101 第三章
知识点 1：public：内部和外部均可见。
        private：只能从本合约内部访问，继承的合约也不能使用。
        external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
        internal: 只能从合约内部访问，继承的合约可以用。
      2： pure 与  view  关键字的区别 payable代表的意思。
      3: https://github.com/DeFiHackLabs/Solidity-Intensive-CoLearning/blob/MrF/content/MrF/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20240925234418.png

### 2024.09.26

1 学习了101 第四章
知识点 1 returns：跟在函数名后面，用于声明返回的变量类型及变量名。
        return：用于函数主体中，返回指定的变量。
      2 命名式返回  解构式赋值  两者区别

### 2024.09.28

1 学习了101 第五章 第六章
知识点 1 引用类型(Reference Type)：包括数组（array）和结构体（struct）
      2 存储位置有三类：storage，memory和calldata  三者区别点 gas 消耗
      3 状态变量（state variable），局部变量（local variable）和全局变量(global variable) 三者作用域的区别

第六章 知识点
      1 引用类型, array, struct 的基本用法
      2 创建数组的规则 有动态数组与固定长度数组区别

### 2024.09.29

1 学习了101 第七章
知识点 1 映射类型 mapping 映射的_KeyType只能选择Solidity内置的值类型，而_ValueType可以使用自定义的类型
      2 映射的存储位置必须是storage 
      3学习映射的原理 映射不储存任何键（Key）的资讯，也没有length的资讯， 初始值都是各个type的默认值，如uint的默认值是0。

### 2024.10.01

1 学习了101 第八章
知识点 1 映射mapping: 所有元素都为其默认值的mapping
        结构体struct: 所有成员设为其默认值的结构体
        数组array 动态数组: [] 静态数组（定长）: 所有成员设为其默认值的静态数组
      2 delete a会让变量a的值变为初始值


   

<!-- Content_END -->