---
timezone: Asia/Shanghai
---

---

# nate

1. 自我介绍
   我叫nate，来自上海。刚学习solidity两周非常高兴参与此次共学
2. 你认为你会完成本次残酷学习吗？
   当然
## Notes

<!-- Content_START -->

### 2024.09.23

#### 学习內容: 
  WTF Solidity01-05
  1. 学习使用在线IDE`remix`编译部署solidity代码
  2. solidity中特殊数据类型`address`
     - address: 存储一个 20 字节的值（以太坊地址的大小)
     - payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账
  4. solidity中常见的function modifier，定义方法时需明确指出：
     - public：内部和外部均可见
     - private：只能从本合约内部访问，继承的合约也不能使用
     - external：只能从合约外部访问（但内部可以通过 this.f() 来调用）
     - internal: 只能从合约内部访问，继承的合约可以用
  5. solidty中常见状态变量的modifier`public\private\internal`,作用与方法类似，未定义默认为internal
  6. 方法关键字pure和view
     - pure：对状态变量不可读写
     - view：对状态变量可读但不可写
  7. 状态变量关键字`storage\memory\calldata`用来表示数据存储位置：
     - storage：合约里的状态变量默认都是storage，存储在链上
     - memory和calldata：存在于evm内存中，calldata不可更改 

### 2024.09.24
  WTF solidity06-10
  1. 学习solidity中数组，结构体和mapping类型
     - bytes作为特殊的数组无需添加[]且不能申明byte[],单字节数组可由bytes和byte1[]表示
     - 数组有点像java里的对象，mapping类似于哈希表
  2. 熟悉常用变量初始值
  3. constant和immutable。状态变量声明这两个关键字之后，不能在初始化后更改数值，immutable修饰的状态变量可在构造器中赋值  

<!-- Content_END -->
