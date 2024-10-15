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
    - constant: 声明时初始化，且不可被更改
    - immutable: 可以在声明的时候 或者 构造函数中初始化，且不可被更改，如果声明的时候和在构造函数中同时初始化，以构造函数中的为准

- [x] 了解控制流
    - if...else
    - for
    - while
    - do...while
    - 三元运算符

### 2024.09.27

學習內容:

- [x] 利用控制流实现数组的插入排序
- [x] 构造函数
- [x] 修饰器
   ownable的标准实现：https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract MyContract{

    address public deployOwner ;

    // 构造函数
    constructor (){
        deployOwner = msg.sender;
    }

    // 修饰器
    modifier onlyOwner {
        require(deployOwner == msg.sender, "only owner!");
        _;
    }

    // 排序：编程时注意uint256是无符号，不能小于0，否则报错。 函数这里因为用了onlyOwner修饰器，修饰器中访问量global变量，所以，不能使用pure修饰器
    function sorted(uint256[] memory _param) external view onlyOwner returns(uint256[] memory){
        uint256 len = _param.length;
        for(uint256 i = 1; i < len; i++){

            uint256 tmp = _param[i];
            uint256 j = i;

            while((j >= 1) && tmp < _param[j - 1]){
                _param[j] = _param[j-1];
                j--;
            }
            _param[j] = tmp;
        }
        return _param;
    }
}

```
### 2024.09.28

學習內容:

- [x] 事件
    - event 关键字申明事件  emit关键字发送事件
    - EVM使用Log来存储事件。
        - 每条日志包含 topics和data两部分。topics是一个最大长度为4的数组，第一个元素存储事件签名，后面三个可用于存储indexed索引。所以事件的索引最多三个
        - data存储复杂数据，消耗的gas比topics小。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract eventContract{
    event CustomerEvent(address indexed from,string message);

    function emitEventFunction(string memory message) external {
        emit CustomerEvent(msg.sender, message);
    }
}
```

### 2024.09.29

學習內容:

- [x] 继承
    - 简单继承 is 关键字
    - 多继承 逗号分隔多个父合约 顺序：辈分越高越靠前
    - 修饰器也能继承
    - 钻石继承中super调用函数顺序

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 声明一个动物合约，所有动物都应该有自己的名字，并且能发出声音
contract Animal{

    event SPEAK_EVENT(address indexed from, string message);

    string public name;

    constructor(string memory _name){
        name = _name;
    }

    function speak(string calldata message) public  virtual {
        emit SPEAK_EVENT(msg.sender, message);
    }
}

// 声明一个人类合约，继承动物并能够跑步
contract Human is Animal{

    event RUN_EVENT(address indexed runner);

    constructor(string memory _name) Animal(_name){

    }

    function speak(string calldata message) public virtual override {
        emit SPEAK_EVENT(msg.sender, string(abi.encodePacked("my name is ",name," : ",message)));
    }

    function _run() internal virtual {
        emit RUN_EVENT(msg.sender);
    }

    // 摸鱼
    function _touchFish() internal virtual {

    }
}

// 工作
contract Work{
    event WORK_EVENT(address from, string produce);
    // 打黑工
    function _workHard() internal virtual {
        emit WORK_EVENT(msg.sender, "work work hard");
    }

    // 摸鱼
    function _touchFish() internal virtual {

    }
}


// 牛马
contract Joker is Human,Work{
    constructor(string  memory _name) Human(_name) Work(){

    }

    // 打黑工
    function workHard() external {
        super._workHard();
        _touchFish();
    }

    function run() external   {
        super._run();
    }

    // 摸鱼
    function _touchFish() internal override(Human,Work)  {
        emit WORK_EVENT(msg.sender, "lalalalalala...");
    }
}

```
### 2024.09.30

學習內容:

- [x] 抽象合约
   - abstract关键字修饰合约 
   - 抽象合约中的函数可以缺少主体。
   - 没有主体的函数要使用virtual关键字修饰
   - 普通合约继承抽象合约，必须实现抽象合约中的所有未实现的函数
- [x] 接口
   - interface关键字修饰接口
   - 不能包含状态变量
   - 不能包含构造函数
   - 不能继承除接口以外的其他合约
   - 所有函数必须是external，且不能有函数体
   - 继承接口的非抽象合约，必须实现接口定义的所有功能
- [x] 异常
   -  error: 定义异常，搭配revert使用, revert用于抛出异常
   - require: 检查条件是否满足，不满足则抛出异常
   - assert: 检查不可能发生的错误，如果发生则抛出异常
   - error 灵活性高，方便高效且消耗gas少，推荐使用；require 书写方便，消耗gas比error多；assert 消耗gas最多，不推荐使用

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 计算器接口
interface Calculator {
    // 折扣事件
    event DiscountsEvent(address indexed owner, uint256 originPrice, uint256 discountsPrice);
    // 根据当前价计算优惠力度并返回
    function calcDiscounts(uint256 currentPrice) external pure returns(uint256);
}

// 电商计算器，实现计算接口
abstract contract EBusinessCalculator is Calculator{
    // 判断是否VIP
    function _isVip(address owner) internal view virtual returns(bool);

    // 根据当前加个进行折扣
    function calcDiscounts(uint256 currentPrice) external pure  virtual  override  returns(uint256);

    // 返回当前用户折扣后的价格
    function discountPrice(address owner, uint256 currentPrice) public returns(uint256){
        uint256 discountsPrice;
        if(_isVip(owner)){
            discountsPrice = currentPrice - this.calcDiscounts(currentPrice);
        }else{
            discountsPrice = currentPrice;
        }
        emit DiscountsEvent(owner, currentPrice, discountsPrice);
        return discountsPrice;
    }
}


// 京东商城折扣价计算
contract JdCalculator is EBusinessCalculator{

    // 自定义错误
    error AddressError(address ads);

    address public vip;
    constructor(){
        vip = msg.sender;
    }
      
     function _isVip(address owner) internal view override  returns(bool){
        if(owner == address(0)){
            // 抛出异常
            revert AddressError(owner);
        }
       return owner == vip;
     }

    function calcDiscounts(uint256 currentPrice) external pure override  returns(uint256){

        if(currentPrice < 10){
            return 0;
        }
        if(currentPrice < 50){
            return 3;
        }
        if(currentPrice < 100){
            return 5;
        }
        return 10;
    }
}
```

### 2024.10.01

學習內容:

- [x] 重载（修饰器不可重载）
   -  重载就是名称相同，但是输入参数类型不同的函数可以同时存在，他们视为不同的函数，我们把它叫做重载
        
比如：

  ```solidity

            function add(uint256 a, uint256 b) public pure returns(uint256){
                return a + b;
            }
            // 重载函数，函数名相同，参数不同，实现不同功能
            function add(uint256 a ) public pure returns(uint256){
                return a + 1;
            }
 ```
- [x] 库合约
        库合约类似工具库，他与普通合约的区别在于：
- 不能存在状态变量
- 不能继承或者被继承
- 不能接收以太币
- 不可以被销毁
- 用关键字library声明库合约
        
        
  比如：

  ```solidity
            library Math{
                function add(uint256 a, uint256 b) public pure returns(uint256){
                    return a + b;
                }
            }
  ```
        
 - [x] 使用库合约：
    -  利用using A for B 将库A附加到B
    -  B 可以直接调用A中的函数，且函数的第一个参数是B
    - 也可以直接调用A中的函数，但是需要传入第一个参数
        
        ```solidity
            contract Test{
                using Math for uint256;
                
                uint256 public result;
                function test() public pure returns(uint256){
                    return result.add(2);
                }
            }
        ```

   ### 2024.10.02

學習內容:

- [x] import关键字
    - 通过源文件相对位置引入：import './A.sol';
    - 通过源文件网络地址引入：import 'https://github.com/xxx/xxx/xxx/A.sol';
    - 通过npm目录导入源文件：import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
    - 导入特定的内容：import {A, B, C} from './A.sol';
  
- [x] 接收ETH
    - receive函数
        - 一个合约最多有一个receive函数
        - 声明不需要function关键字
        - 不能有任何参数和返回值
        - 必须包含payable和external
        - receive函数不应该有复杂逻辑
    - fallback函数
        - 一个合约最多有一个fallback函数
        - 不能有任何参数和返回值
        - 必须包含payable和external
        - 不需要function关键字
        - msg为空且存在receive函数时调用receive函数
        - msg不为空或者不存在receive函数时调用fallback函数
        - fallback函数必须是payable
receive函数和fallback函数都不存在的时候 直接向合约发送ETH会报错。但是可以通过其他payable函数发送ETH。

 * 在恶意合约中，可能存在嵌入恶意消耗gas的内容或者直接让转账失败的代码，导致一些退款、转账等操作失败，造成合约不能正常工作 。所以在写合约的时候一定要注意这种情况

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract MyReceiveAndFallbackContract{
    event ReceiveEvent(address sender, uint256 balance);
    event FallbackEvent(address sender, uint256 balance, bytes data);
    receive() external payable {
        emit ReceiveEvent(msg.sender, msg.value);
     }

     fallback() external payable{
        emit FallbackEvent(msg.sender, msg.value, msg.data);
     }

}
```

### 2024.10.03

學習內容:

- [x] 发送ETH
    - call: 没有gas限制，不会revert，返回值是bool，代表转账正常或者失败（推荐）
        - 接收方地址.call({value: 发送ETH的数额})("")，返回值是bool
    - transfer: 2300gas限制，转账失败会revert
        - 接收方地址.transfer(发送ETH的数额);  无返回值
    - send: 2300gas限制，转账失败会返回false 不会revert，几乎不使用
           - 接收方地址.send(发送ETH的数额);  返回值是bool


### 2024.10.04

學習內容:

- [x] 调用其他合约的几种方法
   - 通过其他合约地址调用：OtherContract(_addresss).functionName();
   - 通过参数直接传入合约：function callOtherContract(OtherContract _address);
   - 通过合约地址获取合约：OtherContract _otherContract = OtherContract(_address);


```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract MyContract{
    function method1(OtherContract _address, uint256 cakeNum) external {
        _address.setMyCake(cakeNum);
    }
    function method2(address _address, uint256 cakeNum)external {
        OtherContract(_address).setMyCake(cakeNum);
    }
    function method3(address _address, uint256 cakeNum) external {
        OtherContract oc = OtherContract(_address);
        oc.setMyCake(cakeNum);
    }

}


contract OtherContract{

   mapping(address => uint256) private cake;

   function setMyCake(uint256 cakeNum)external payable {
    cake[msg.sender] = cakeNum;
   }

    // 通过指定合约地址查询对应合约地址拥有的cake数量
   function showMyCake(address owner) external view returns(uint256 cakeNum){
    cakeNum = cake[owner];
   }

}
```


### 2024.10.05

學習內容:

- [x] call调用其他函数
     - call函数是低级函数，返回值为(bool, bytes memory),其中bool代表调用是否成功，bytes memory代表调用的返回值
     - call是官方推荐发送以太币，触发fallback和receive函数的方式
     - 一般来说不建议使用call调用其他函数，推荐采用声明合约变量后的调用方式
     - call的使用规则：目标函数地址.call(abi.encodeWithSignature("functionName(parameterType[,...])", parameterValue[,...]))
     - call调用其他函数的时候还可以指定eth和gas: 目标函数地址.call{value: 1 ether, gas: 100000}(abi.encodeWithSignature("functionName(parameterType[,...])", parameterValue[,...]))
     - 如果call调用的目标函数不存在，则会触发调用fallback函数

### 2024.10.06

學習內容:

- [x] delegatecall调用函数
   - 和call类似
   - 区别：只能指定gas不能指定eth。delegateCall是代理调用，实际调用者为用户。call是直接调用，实际调用者为调用发起者。
   - delegatecall有安全隐患，使用时要保证当前合约和目标合约状态变量的存储结构一致且保证目标合约安全
   - 使用场景：代理合约、[EIP-2535 Diamonds](https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard)
    


```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// call和delegatecall的区别

// 存储合约
contract ContractA{
    event ContractAMsgAdd(bool indexed,bytes);
    event ContractAMsgDelegateAdd(bool indexed,bytes);
    mapping(address => string) public msgMapping; // 合约A运行后，delegateCall会将状态变量存储到合约A：mapping为：(合约用户地址：message信息)

    function setMapping(address _contractBAddress, string memory messages) external {
       
       // 直接调用 状态变量存储在合约B中，address为 合约A的地址
       (bool success, bytes memory data) = _contractBAddress.call(abi.encodeWithSignature("addMsg(string)", messages));
        emit ContractAMsgAdd(success, data);
        // 代理调用 状态变量存储在合约A中，address为  用户的地址
        (bool success2, bytes memory data2) = _contractBAddress.delegatecall(abi.encodeWithSignature("addMsg(string)", messages));
        emit ContractAMsgDelegateAdd(success2, data2);
    }
}

// 逻辑合约
contract ContractB{
    event AddMsgEvent(address indexed,string); 
    mapping(address => string) public msgMapping; // 合约A运行后，call会将状态变量存储到合约B：mapping为：(合约B地址：message信息)
    function addMsg(string memory messages) external {
        msgMapping[msg.sender] = messages;
        emit AddMsgEvent(msg.sender, messages);
    }
}
```

### 2024.10.07

學習內容:

- [x] 创建合约

    -  create方式创建合约
        - 用法：`Contract x = new Contract{value: 1 ether}(params);` 如果构造函数是payable，可以通过value传入eth
        - 地址计算：`新地址 = hash(创建者地址, nonce)` 因为nonce会随时间改变，所以地址不可预测
       
    -  create2方式创建合约
        - 用法：`Contract x  = new Contract{salt: _salt, value: 1 ether}(params);` 如果构造函数是payable，可以通过value传入eth
        - 地址计算：
           - `新地址 = hash("0xFF",创建者地址, salt, initcode)`
           - `0xFF` 是固定值
           - `initcode` 新合约的初始字节码（合约的Creation Code和构造函数的参数）
           - `salt` 一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
           - 创建者地址：调用 CREATE2 的当前合约（创建合约）地址。


### 2024.10.08

學習內容:

- [x] 销毁合约

    - 关键字selfdestruct
    - 作用：销毁合约，将合约余额发送到指定地址
    - 用法：`selfdestruct(_address);`, 其中_address为接收合约余额的地址
    - 坎昆升级前：合约被销毁，合约余额会被转移到指定地址；坎昆升级后：同一笔交易内创建的合约可以被销毁，余额会被转到指定地址。已经部署的合约不会被销毁，但是余额会被转到指定账户。
    - 调用selfdestruct时，指定的address没有fallback和receive函数，也能接收ETH
    - 应用场景：selfdestruct时智能合约的紧急按钮，发生THE DAO攻击时，可以通过selfdestruct销毁合约，将合约余额转移到指定账户。


### 2024.10.09

學習內容:

- [x] ABI的编码解码
   - abi.encode
       - 用法：`abi.encode(param1, param2, ...)`，将每个参数填充为32个字节的数据，并拼合在一起
   - abi.encodePacked
       - 用法：`abi.encodePacked(param1, param2, ...)`，与abi.encode类似， 但是会压缩空间。当想省空间且不与合约交互的时候可以使用，比如算一些数据的hash时
   - abi.decode
       - 用法：`(type1 var1, type2 var2, ...) = abi.decode(data, (type1, type2, ...))`，将abi.encode编码的数据解码为指定的数据类型
   - abi.encodeWithSignature
       - 用法：`abi.encodeWithSignature("functionName(parameterType[,...])", parameterValue[,...])`，第一个参数为函数签名，后面为函数参数，返回编码后的数据。当调用其他合约的时候可用  
    - abi.encodeWithSelector
       - 用法：`abi.encodeWithSelector(bytes4(keccak256("functionName(parameterType[,...])")), parameterValue[,...])`，与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。

- [x] hash函数
    - keccak256
        - 用法：`keccak256(abi.encodePacked(param1, param2, ...))`，计算参数的keccak256哈希值
        - 和sha3区别：sha3由keccak标准化而来，SHA3就和keccak计算的结果不一样
        - Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3
    - hash的性质
        - 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举
        - 灵敏性：输入的消息改变一点对它的哈希改变很大
        - 高效性：从输入的消息到哈希的运算高效
        - 均一性：每个哈希值被取到的概率应该基本相等
        - 弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
        - 强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的
    - hash的应用
        - 生成数据唯一标识
        - 加密签名
        - 安全加密


### 2024.10.10

學習內容:

- [x] 函数选择器
    - 概念 calldata的前四个字节是函数选择器selector
    - 用法 selector = ` byte4(keccak256("functionName(parameterType[,...])"))`
    - 注意：uint和int在函数签名中要使用uint256和int256
    - 利用函数选择器调用函数：` address(_address).call(abi.encodeWithSelector(byte4(keccak256("functionName(parameterType[,...])"))))`


- [x] try-catch
    - 概念：用于捕获合约内部的异常
    - 用法：
        ```solidity
        try externalContract.f() returns (bool success) {
            // 成功
        } catch Error(string memory reason) {
            // 失败
        } catch (bytes memory lowLevelData) {
            // 失败
        }
        ```
    - 注意：只能被用于external函数或创建合约时constructor（被视为external函数）的调用

### 2024.10.11

學習內容:

- [x] ERC20 以太坊上的代币标注，实现代币基本逻辑
     - 账户余额 `balanceOf()`
     - 转账 `transfer()`
     - 授权转账`transferFrom()`
     - 授权`approve()`
     - 代币总供给`totalSupply()`
     - 授权转账额度`allowance()`
     - 代币信息（可选）：名称、符号、小数位数
- [x] IERC20：ERC20标准的接口定义
  - 两个事件
    - 转账事件 Transfer `event Transfer(address indexed from, address indexed to, uint256 value);`
    - 授权事件 Approval `event Approval(address indexed owner, address indexed spender, uint256 value);`
  - 六个函数
     - 返回代币总供给`function totalSupply() external view returns (uint256);`
     - 返回账户余额`function balanceOf(address account) external view returns (uint256);`
     - 返回授权转账额度`function allowance(address owner, address spender) external view returns (uint256);`
     - 转账`function transfer(address recipient, uint256 amount) external returns (bool);`
     - 授权转账` function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);`
     - 授权`function approve(address spender, uint256 amount) external returns (bool);`


### 2024.10.12

學習內容:

- [x] 代币水龙头
- [x] 空投合约
- [x] ERC721 标准 （根据EIP721改进建议形成的ERC721标准）
   - ERC165用于检查合约是否是支持ERC721或者ERC1155的接口
     ```solidity
          function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
             return
                interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
                interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
                interfaceId == 0x5b5e139f || // ERC165 Interface ID for ERC721Metadata
                interfaceId == 0x780e9d63;   // ERC165 Interface ID for ERC721Enumerable 
          }
     ```
   - IERC721是ERC721的接口定义
   - IERC721包含三个事件：Transfer(转账时释放)、Approval（授权时释放）、ApprovalForAll（批量授权时释放）
   - IERC721包含了9个函数
      - balanceOf：返回某地址NTF的持有量
      - ownerOf：返回某NTF的持有者
      - transferFrom：转移NTF
      - safeTransferFrom：安全转移NTF(接收方合约必须实现IERC721Receiver接口的onERC721Received函数)
      - approve：授权NTF
      - setApprovalForAll：批量授权NTF
      - isApprovedForAll：检查是否批量授权
      - safeTransferFrom：安全转移NTF(函数重载，多了data参数)
   - IERC721Metadata是IERC721的扩展接口
      - name：返回NTF的名称
      - symbol：返回NTF的符号
      - tokenURI：返回NTF的元数据URI（ERC721特有函数）

### 2024.10.13

學習內容:

- [x] 荷兰拍卖，一种拍卖形式，价格由高逐渐降低，知道有人愿意购买，避免gas war
    - 与荷兰拍卖相关的参数：
        - COLLECTOIN_SIZE：NFT总量。
        - AUCTION_START_PRICE：荷兰拍卖起拍价，也是最高价。
        - AUCTION_END_PRICE：荷兰拍卖结束价，也是最低价/地板价。
        - AUCTION_TIME：拍卖持续时长。
        - AUCTION_DROP_INTERVAL：每过多久时间，价格衰减一次。
        - auctionStartTime：拍卖起始时间（区块链时间戳，block.timestamp）

### 2024.10.14

學習內容:

- [x] 发送、接收代币、合约调用 实践

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Supermarket{
    address private owner;
    // 货物
    mapping(string name => Thing[]) public goods;
    //  条码：价格
    mapping(uint256 => uint256) public priceMapping;
    // 总金额
    uint256 private totalMoney;
    // 订单
    mapping(address buyer => Order[10000]) private orders;
    mapping(address buyer => uint256) private orderLen;

    // 收据
    mapping(uint256 => address owner) public evidence;

    struct Order{
        uint256 time;
        uint256[] tokens;
        uint256 sumMoney; 
    }

    struct Thing{
        uint256 token;
        string name;
    }




    modifier OwnerOnly(){
        require(msg.sender == owner, "owner only");
        _;
    }

    modifier GoodsEnough(string memory _name, uint256 _count){
        require(goods[_name].length >= _count, "goods not enough!");
        _;
    }
    // 商品锁，避免超卖
    modifier GoodsLock(string memory name){
        // TODO
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    // 商品上架
    function grounding(string memory _name, uint256 _token, uint256 _price) public OwnerOnly{
        Thing[] storage things = goods[_name];
        things.push(Thing({token:_token, name:_name}));
        priceMapping[_token] =  _price;
        
    }

    // 出售
    function sell(string memory _name, uint256 _count)external  GoodsLock(_name) GoodsEnough(_name, _count)  returns(uint256 orderNumber, uint256 _sumMoney){
 
        uint256[] memory _tokens = new uint256[](_count);
      
        Thing[] storage things = goods[_name];

        
        for(uint256 i; i<_count; i++){
            Thing memory thing = things[things.length -1];
            things.pop();
            _tokens[i] = thing.token;
            _sumMoney += priceMapping[_tokens[i]];
        }

  
        orderLen[msg.sender] += 1;
       
        Order[10000] storage ownerOrders = orders[msg.sender];
        
        ownerOrders[orderLen[msg.sender]] = Order({  time:block.timestamp,tokens:_tokens,sumMoney:_sumMoney });

        orderNumber = orderLen[msg.sender];

    }

    // 支付
    function pay(uint256 orderNumber) external  payable returns(uint256[] memory tokens){
        Order storage order =  orders[msg.sender][orderNumber];
         require(order.sumMoney != 0, "Order does not exist or already paid"); // 检查订单是否存在且未支付

        uint256 sumMoney = order.sumMoney; 

        if(msg.value < sumMoney){
            revert();
        }
        if(msg.value > sumMoney){
           uint256 balance =  msg.value - sumMoney;
           (bool success,) = payable(msg.sender).call{value:balance}("");
           if(!success){
            revert();
           }
        }
        tokens = order.tokens;
        for(uint256 i ; i < tokens.length; i++){
            evidence[tokens[i]] = msg.sender;
        }
         delete orders[msg.sender][orderNumber]; // 防止重复支付
    } 
}

// 消费者
contract Customer{
    event PurchaseEvent(uint256 indexed orderNumber, uint256 indexed sumMoney);
    event PayEvent(bool indexed success, bytes  data);
    function buy(string memory _name, uint256 _count,address targetContract) public returns(uint256[] memory _tokens){
        Supermarket sm = Supermarket(targetContract);
       (uint256 orderNumber, uint256 _sumMoney) = sm.sell(_name, _count);
       emit PurchaseEvent(orderNumber, _sumMoney);
       (bool success, bytes memory data) = targetContract.call{value:_sumMoney}(abi.encodeWithSignature("pay(uint256)", orderNumber));
        emit PayEvent(success, data);
        if(success){
            _tokens =  abi.decode(data, (uint256[]));
        }
    }

    // 给合约账户打点钱，不然没钱支付呀
    receive() external payable { }
}
```



### 2024.10.15

學習內容: 

- [x] 默克尔树
  
  - 默克尔树的构建
     由叶子节点开始，两两配对，然后计算hash，再两两配对，直到根节点。
  - 默克尔树发放白名单，合约中只需要记录root节点，验证时只需要提供proof和leaf即可。然后将白名单存储到后端服务器，极大的减少了区块链的存储压力。
  - 默克尔树的验证方式
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract MerkleTreeContract{
    // 默克尔树的验证方法: 根据proof和leaf计算root
    function computeProof(bytes32[] memory proof, bytes32 leaf) external pure returns(bytes32 computedHash){
        computedHash = leaf;
        for(uint256 i ; i < proof.length; i++){
            computedHash = _hashPair(computedHash, proof[i]);
        }
    }
    function _hashPair(bytes32 a, bytes32 b)private pure returns(bytes32 computeHash){
            computeHash =  a < b ? keccak256(abi.encodePacked(a,b)) : keccak256(abi.encodePacked(b,a));
    }
}
```
- [x] 数字签名
  - 私钥加密消息，公钥验证消息
  - 消息在以太坊标准中，需要将消息进行hash后，在前面加上`\x19Ethereum Signed Message:\n32`，然后再进行hash，最后进行签名。
  - 利用签名也可以发放白名单，将私钥对白名单进行签名，合约中只需要存储公钥（一般来说就是签名地址）即可。
  -  由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济；
     但由于用户要请求中心化接口去获取签名，不可避免的牺牲了一部分去中心化；
     额外还有一个好处是白名单可以动态变化，而不是提前写死在合约里面了，因为项目方的中心化后端接口可以接受任何新地址的请求并给予白名单签名。
  - 创建签名
     - 打包消息hash = `keccak256(abi.encodePacked(_account, _tokenId))`
     - 计算以太坊签名 `keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash))`
     - 利用web3.py签名
   ```python
        from web3 import Web3, HTTPProvider
        from eth_account.messages import encode_defunct
        
        private_key = "0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b"
        address = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
        rpc = 'https://rpc.ankr.com/eth'
        w3 = Web3(HTTPProvider(rpc))
        
        #打包信息
        msg = Web3.solidity_keccak(['address','uint256'], [address,0])
        print(f"消息：{msg.hex()}")
        #构造可签名信息
        message = encode_defunct(hexstr=msg.hex())
        #签名
        signed_message = w3.eth.account.sign_message(message, private_key=private_key)
        print(f"签名：{signed_message['signature'].hex()}") 
   ```
  - 验证签名
     - 通过签名和消息恢复公钥(最后对比公钥和签名者是否相同来验证签名)
       签名是由数学算法生成的。这里我们使用的是rsv签名，签名中包含r, s, v三个值的信息。而后，我们可以通过r, s, v及以太坊签名消息来求得公钥。下面的recoverSigner()函数实现了上述步骤，它利用以太坊签名消息 _msgHash和签名 _signature恢复公钥（使用了简单的内联汇编）
    ```solidity
        // @dev 从_msgHash和签名_signature中恢复signer地址
    function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address){
        // 检查签名长度，65是标准r,s,v签名的长度
        require(_signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        // 目前只能用assembly (内联汇编)来从签名中获得r,s,v的值
        assembly {
            /*
            前32 bytes存储签名的长度 (动态数组存储规则)
            add(sig, 32) = sig的指针 + 32
            等效为略过signature的前32 bytes
            mload(p) 载入从内存地址p起始的接下来32 bytes数据
            */
            // 读取长度数据后的32 bytes
            r := mload(add(_signature, 0x20))
            // 读取之后的32 bytes
            s := mload(add(_signature, 0x40))
            // 读取最后一个byte
            v := byte(0, mload(add(_signature, 0x60)))
        }
        // 使用ecrecover(全局函数)：利用 msgHash 和 r,s,v 恢复 signer 地址
        return ecrecover(_msgHash, v, r, s);
    }
    ```
     - 对比公钥并验证签名（使用ECDSA库）
    ```solidity
          // ECDSA验证，调用ECDSA库的verify()函数
          function verify(bytes32 _msgHash, bytes memory _signature)
          public view returns (bool)
          {
          return ECDSA.verify(_msgHash, _signature, signer);
          }
    ```

<!-- Content_END -->
