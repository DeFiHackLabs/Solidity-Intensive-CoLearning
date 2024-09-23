---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加标准时间 (UTC-9)

timezone: America/Los_Angeles # 太平洋标准时间 (UTC-8)

timezone: America/Denver # 山地标准时间 (UTC-7)

timezone: America/Chicago # 中部标准时间 (UTC-6)

timezone: America/New_York # 东部标准时间 (UTC-5)

timezone: America/Halifax # 大西洋标准时间 (UTC-4)

timezone: America/St_Johns # 纽芬兰标准时间 (UTC-3:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# Robin

1. 自我介绍

   大家好，我是Robin，一名专注于Java后端开发的技术爱好者。在多年的编程经历中，我积累了丰富的服务器端应用构建经验，尤其是在高性能、高并发处理方面有所涉猎。最近对Web3领域产生了浓厚的兴趣，它所倡导的去中心化网络理念以及区块链技术的应用前景深深吸引了我。我相信，未来互联网的发展趋势将更加开放与透明，而Web3正是这一趋势的核心体现。我希望能够在这个新兴领域中探索更多可能，并与其他志同道合的朋友共同学习成长。如果有机会，我也期待能够贡献自己的力量，参与到Web3相关项目的实践中去。

2. 你认为你会完成本次残酷学习吗？

   当然，我认为我会完成这次学习。虽然我知道这个过程中可能会遇到很多挑战和困难，但我已经做好了充分的准备。既然已经制定了一份详细的学习计划，我就会确保自己有足够的资源和支持来应对可能出现的问题。此外，我对这个领域的兴趣和热情也是推动我前进的强大动力。我相信，通过坚持不懈的努力，我一定能够克服这些挑战并完成学习目标

## Notes

<!-- Content_START -->

### 2024.09.23

學習內容:

- [x] 了解Web3的基本概念

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```
- [x] 学习solidity值类型

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract ValueTypes{


    // 布尔类型

    bool public _bool  = true;

    // 布尔运算 （&& 与 || 遵循短路规则）
    bool public _bool1 = !_bool; //取非值为false
    bool public _bool2 = _bool && _bool1; // 与，两个为true结果为true，否则结果为false
    bool public _bool3 = _bool || _bool1; // 或，两个为false结果为false，否则结果为true
    bool public _bool4 = _bool == _bool1; // 判断是否相等，相等为true，不等为false
    bool public _bool5 = _bool != _bool1; // 判断是否不相等，不相等为true, 相等为false



    // 整形
    int public _int = -1; // 整数，包含负数
    uint public _uint = 1; // 正整数
    uint256 public _number = 20240923; // 256位正整数（一个字节为8位，相当于32字节）

    // 整数运算
    uint256 public _number1 = _number + 1; // 四则运算：+ - * /
    uint256 public _number2 = _number1 ** 2; // 幂运算
    uint256 public _number3 = 7 % 1; // 取余
    bool public _numberBoll = _number1 > _number3; // 比较运算 < > <= >= == !=

    // 地址
    
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // 此地址下的账户余额


    // 定长字节数组
    bytes32 public _bytes32 = "MiniSolidity"; // 最大的字节数组为32字节。 MiniSolidity占12字节
    bytes1 public _bytes1 = _bytes32[0]; // 取第0号索引，就是第一个字节 M (0x4d)

    // 枚举
    enum ActionSet{Buy, Sell, Hold}
    ActionSet public _actionSet = ActionSet.Buy;

    // 枚举与int的转换
    // view 表示 函数不会对合约变量作修改
    function enum2Int() external view returns(uint){
        return uint(_actionSet);
    }
}
```
- [x] 学习solidity函数

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract FunctionTypes{
  // function 固定语法 声明这是一个函数
  // <function name> 函数名称
  // [parameter types1, parameter types2, ...] 函数的参数
  // {public | private | external | internal} public 代表内部和外部均可以访问，private 代表仅合约内部可访问， external 只能从合约外部访问，但是内部可以采用this.f()的方式调用，internal 只能从合约内部访问，继承的合约可以访问。
  // [pure | view | payable] pure 代表不可读 不可写 状态变量， view 可读不可写状态变量，payable表示该函数可转入ETH


  uint256 public number = 5;

  function add() external{
    number += 1;
  }

  function addPure(uint256 _number) external pure returns(uint256){
    return _number += 1;
  }

  function addView() external view returns(uint256 new_number){
    new_number = number + 1;
  }

  function mius() internal {
    number -= 1;
  }

  function miusCall() external {
    mius();
  }

  function miusPayable() external payable returns(uint256 balance){
    mius();
    balance = address(this).balance;
  } 

}
```

- [x] 学习solidity返回值

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Return{
    // returns 在函数体上声明返回值类型以及变量名
    // return 用于函数主体，如果returns中申明了变量名，可不用return关键字
    // 解构式赋值中：读取所有的返回值，要按照顺序声明变量，并用逗号隔开，如果只读取某个值，则只声明要读取的变量，不读取的变量为空，但要保留逗号



    function returnMultiple() public pure returns(uint256,bool,bytes1){
        return(1,true,"X");
    }

    function returnNamed() public pure returns(uint256 a,bool b,bytes1 c){
        a = 111;
        b = true;
        c = "x";
    }

    function readReturn() public pure {
        uint256 number ;
        bytes1 byteArray;
        bool flag;
    
        (number,,byteArray) = returnNamed();
        (,flag,) = returnMultiple();
    }
}
```
<!-- Content_END -->
