---
timezone: Asia/Shanghai
---

# jaxrunboo

1. 自我介绍
> 后端开发，寻求新挑战

2. 你认为你会完成本次残酷学习吗？
> 稳稳的

## Notes

<!-- Content_START -->

### 2024.09.23

#### 1. pragma solidity ^0.8.21;

<strong>0</strong>: 主版本号 

<strong>8</strong>: 次版本号 

<strong>21</strong>: 补丁版本号</br>

   指定编译器版本的编译指令，含义： version >=0.8.21 && version <0.9.0

   另外的表达方式 ： pragma solidity >=0.8.21<0.9.0;

#### 2. 数据类型

1. 值类型

包括布尔型(bool)、整型(int)、地址类型(address)、定长字节数组(bytes1)、枚举(enum)

地址类型分为普通地址和payable addressd,地址长度32bytes(字节),十六进制数就是64位

payable address存在transfer和send两个成员方法，用于接收和转账?todo

2. 引用类型

数组(array) 不定长字节数组(bytes) 结构体(struct)

引用类型变量较为复杂，在使用时需要声明数据存储的位置

数据存储位置分类：

    1. storage
    数据存储在链上，可以认为是整个合约的全局参数
    2. memory
    函数的入参和临时变量，一般使用memory，存储在内存中，不上链
    3. calldata
    存储在内存中，不上链。他的特点是不可变更，多用于函数参数



3. 映射类型

哈希表(map)

```
// 含义就是 key为int类型，value为address类型的hash表
mapping(uint => address) public map1;
```


#### 3. 函数

1. 权限关键字

pure | view | payable

pure: 表示不对链上状态进行读写

view: 表示对链上状态的读

无：变更链上状态

payable: 附带payable修饰的函数，能够在执行时向合约中转入eth


### 

<!-- Content_END -->
