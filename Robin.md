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

### 2024.09.24

學習內容:

- [x] 了解变量的存储和作用域

1. 存储位置
   - storage: 存储在区块链上，永久保存
   - memory: 存储在内存中，函数调用结束后，数据消失
   - calldata: 与memory类似，但是被calldata修饰的参数是只读的，不可修改
2. 作用域
   - state variable: 合约中声明的变量，存储在storage中
   - local variable: 函数中声明的变量，存储在memory中
   - function parameter: 函数的参数，存储在memory中
   - global variable: 全局变量，存储在storage中
   其中全局变量参考：[全局变量](https://docs.soliditylang.org/zh/v0.8.21/units-and-global-variables.html)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DataStorage{
    /**
     *  数据的存储位置：
     *   1、storage: 合约里的状态变量都是存储在链上的，默认是storage。消耗gas多，类似存硬盘
     *   2、memory: 函数里的参数和变量一般都是memory。消耗gas少，不上链，临时存储，类似内存。如果返回数据类型都是变长的情况，如：string/bytes/array/自定义结构体，都应该使用memory修饰
     *   3、calldata: 与memory类似，但不可修改，一般修饰参数
     */
      mapping(uint256 => uint256) public storageValue;  // storage

     function storageTest(uint256[] calldata _param) external pure  returns(uint256[1] memory){
        // _param不可修改
        uint256[1] memory x = [_param[0]]; //memory
        return x;
     }
    /**
     *  数据的引用 或 创建副本
     *   1、storage类型变量赋值给storage类型变量的时候，是引用类型
     *   2、memory类型变量赋值给memory类型变量的时候，也是引用类型
     *   3、其他情况赋值后的变量是新的副本，修改变量不会相互影响
     */

      function referenceTest() external returns(uint8){
         mapping(uint256 => uint256) storage a = storageValue;
         a[1] = 1; // a的改变会影响storageValue的改变
         uint8[1] memory mV = [5];
         uint8[1] memory mV2 = mV;
         mV2[0] = 1; //mV2的改变会影响mV的改变
         return mV[0];
      }

    /**
     *  变量的作用域
     *   1、状态变量：合约内，函数外声明，存储在链上，消耗gas高
     *   2、局部变量：声明在函数内，函数退出后变量无效，不上链，消耗gas低
     *   3、全局变量：比如msg.sender,msg.data,block.timestamp....等等，参照：https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions
     */

     uint256 i = 0; // 状态变量，似乎并未要求放在最前面（但实际一般不会这么写...）
     function test() external view returns(address _address){
       _address = msg.sender; // msg.sender 为全局变量 _address为局部变量
    }
}
```

### 2024.09.25

學習內容:

- [x] 了解array、struct、mapping的使用
   - array: 数组，可以是固定长度或者动态长度，bytes是特殊的数组。动态数组拥有push和pop两个成员函数
   - struct: 结构体，可以定义多个不同类型的变量，类似于C语言的结构体
   - mapping: 映射，类似于键值对，可以存储不同类型的数据，键是唯一的，映射的存储位置必须是storage

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 录入学生成绩，保存通过测验的学生编号，并记录分数top10
contract ReferenceType{

    // 定义结构体: 学生
    struct Student{
        string name;
        uint8 age;
        uint256 score;
    }

    // 定义动态数组：通过测验的学生编号
    uint256[] passedStudents;
    
    // 定义静态数组：top10的分数
    uint256[10] topScore10;

    // 定义mapping
    mapping(uint256 => Student) public studentNumberMapping;

    // 定义uint256
    uint256 maxStudentNumber = 0;

    // 保存学生信息
    function save(string calldata _name, uint8 _age, uint256 _score) external returns(uint256 _studentNumber){
        _studentNumber = maxStudentNumber++;
        studentNumberMapping[_studentNumber] = Student({name:_name, age:_age, score:_score});
        if(_score > 60){
            passedStudents.push(_studentNumber);
        }
    }

    // 分数前十
    function sortTopScore10() external {
        uint256 len = passedStudents.length;
        for (uint256 s = 0; s < len; s++){
            uint256 studentNumber = passedStudents[s];
                Student memory student = studentNumberMapping[studentNumber];
                uint256 score = student.score;

                uint256 tmp = score;
                for(uint256 t = 0; t < 10; t++){
                    if(tmp > topScore10[t]){
                        uint256 origin = topScore10[t];
                        topScore10[t] = tmp;
                        tmp = origin;
                    }
                }

        }
    }

    function viewTopScore10() external  view returns(uint256[10] memory top){
       top = topScore10;
    }
}
```

### 2024.09.26

學習內容:

- [x] 了解solidity中各种类型的初始化值

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract MyContract{
    bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000
    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum; // 第1个内容Buy的索引0
    function fi() internal{} // internal空白函数
    function fe() external{} // external空白函数 
}
```
- [x] 了解solidity中的常量constant、immutable关键字
    - constant: 修饰函数，表示函数不会修改状态变量，不消耗gas，不上链
    - immutable: 修饰状态变量，表示状态变量只能在构造函数中赋值，不可修改，不消耗gas，不上链

- [x] 了解控制流
    - if...else
    - for
    - while
    - do...while
    - 三元运算符

```solidity

<!-- Content_END -->
