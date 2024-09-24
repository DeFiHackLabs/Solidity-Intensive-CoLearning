---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍
我是Vic，一名从业7年的前端开发

3. 你认为你会完成本次残酷学习吗？
   是的，必须完成！
## Notes

<!-- Content_START -->

### 2024.09.23
编译器 remix
```
// 声明许可证
// SPDX License-Identifier: MIT

// solidity版本号，大于0.8.19
pragma solidity ^0.8.19;

// 声明HelloWorld
contract HelloWorld {
    // 生命公开字符hi，输出Hello World
    string public hi = "Hello World";

}
```

### 2024年9月24日
#### 数据类型，bool，uint，address，byte，enum
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Types {
    // bool类型
    bool public open = false;
    bool public open1 = !open; // true
    bool public open2 = open && open1; // fasle
    bool public open3 = open || open1; // true
    bool public open4 = open == open1; // false
    bool public open5 = open != open1; // true

    // 整数
    // 整数分成: 整数(正整数、负整数) 正整数，平时只用uint，uint256其实就是uint
    int public stair = -18;
    uint public stair1 = 18;
    uint256 public stair2 = 0;

    // 数字运算 + - * / ** %
    uint public num = 100;
    uint public num1 = num + 1; // 101
    uint public num2 = num - 2; // 98
    uint public num3 = num * 2; // 200
    uint public num4 = num / 4; // 25
    uint public num5 = num ** 2; // 10000
    uint public num6 = num % 3; //1

    // 比价运算 <= < == != > >=
    bool public compare = 3 <= 3; // true
    bool public compare1 = 3 < 3; // fasle
    bool public compare2 = 3 == 3; // true
    bool public compare3 = 3 != 3; // false
    bool public compare4 = 3 > 3; //fasle
    bool public compare5 = 3 >= 3; //true

    // 地址
    /*
        普通地址（address）: 存储一个 20 字节的值（以太坊地址的大小）。
        payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账。

        1byte = 8bit = 1111 1111 = 0xFF
        所以1byte可以是2个16进制数据
    */
    address public wade = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address payable public  wade1 = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    uint256 public balance = wade.balance;

    // 定长字节数组
    /*
        字节数组分为定长和不定长两种：

        定长字节数组: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为 bytes1, bytes8, bytes32 等类型。定长字节数组最多存储 32 bytes 数据，即bytes32。
        不定长字节数组: 属于引用类型（之后的章节介绍），数组长度在声明之后可以改变，包括 bytes 等。
    */
    bytes32 public _byte32 = "MiniSolidity"; // 0x4d696e69536f6c69646974790000000000000000000000000000000000000000
    bytes12 public _byte12 = "MiniSolidity"; // 0x4d696e69536f6c6964697479
    bytes1 public _byte1 = _byte12[0]; // 0x4d

    // 枚举enum（很少人用）
    enum ActionSet { Buy, Hold, Sell }
    ActionSet public action = ActionSet.Hold;

    // enum与uint可以相互转换
    // 枚举可以显式地和 uint 相互转换，并会检查转换的正整数是否在枚举的长度内，否则会报错
    function enumToUint() external view returns (uint) {
        return uint(action); // 1
    }
}
```


<!-- Content_END -->
