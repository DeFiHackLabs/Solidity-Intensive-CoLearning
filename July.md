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

<!-- Content_END -->
