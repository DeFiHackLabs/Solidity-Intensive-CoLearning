---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容


timezone: Asia/Shanghai



---

# July

1. Hi 大家好，我是java开发 目前想要学习web3 寻找新的方向

2. 你认为你会完成本次残酷学习吗？ 一定会 加油！

## Notes

<!-- Content_START -->

### 2024.09.23

學習內容:
- 了解Solidity基础类型 
- 值类型(Value Type) 布尔型/整型/地址类型/字节定长数组/枚举类型
- 引用类型(Reference Type)
- 映射类型(Mapping Type)

#### [QuillAudit CTF - RoadClosed](./Writeup/SunSec/src/QuillCTF/RoadClosed.sol)

```
    bool public _bool = true;

    bool public _bool1 = !_bool; // 取非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不相等
    

    int public _int = -1; // 整数，包括负数
    uint public _uint = 1; // 正整数
    uint256 public _number = 20220330; // 256位正整数
    
    // 比较运算符（返回布尔值）： <=， <，==， !=， >=， >
    
    // 数组定长
    bytes32 public _byte32 = "HelloSolidity"; 
    bytes1 public _byte = _byte32[0]; 
    
    // 普通地址 0x 20字节长度 存储以太坊地址
    // payable address 可以用于接收转账
    
    // 枚举类型与java枚举类似
    enum PaySet { Buy, Hold, Sell }
    PaySet action = PaySet.Buy;
```

###  

### 2024.09.24

* 函数必须明确指定可见性，状态变量可不写默认可见性是internal
* pure代表不需要读或者写链上的数据 既不能读取也不能改写状态变量
* view代表需要读取链上的数据 但不能改写
* pure和view都不会消耗gas费，但是非pure/view的函数调用申明了pure/view的函数需要付gas
* internal: 内部函数 external: 外部函数 public: 公共函数 private: 私有函数
* payable: 用于接收以太币的函数

```
    // internal: 内部函数
    function minus() internal {
    number = number - 1;
    }
    
    // 合约内的函数可以调用内部函数
    function minusCall() external {
    minus();
    }
    
    function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}
```
* returns跟在函数名后面，用于声明返回的变量类型及变量名。
* return用于函数主体中，返回指定的变量。


###


<!-- Content_END -->
