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


### 2024.09.24

#### 1. 插入排序实现

逻辑：

分为内外两个循环，外循环从index=1开始逐个获取元素，内循环将arr[index] 和 arr[<index]的数据进行比较。将大于arr[index]的数据往后排，一直找到小于它的数，将arr[index]放在它后面

```
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Test{

    function insertSort(uint[] memory arr) pure public returns(uint[] memory) {
        for (uint i=1; i<arr.length; i++) 
        {
            uint key = arr[i];
            uint j = i;
            while( j >=1 && key < arr[j-1]){
                arr[j] = arr[j-1];
                j--;
                //需要注意j的类型为无符号整数uint，所以当j--的行为导致j<0时会报错，因此将j的下限设为1
            }
            arr[j] = key;
        }
        return arr;
    }
}
```

#### 2. 修饰器

可以将其理解为函数的前置的判断条件

```
    //状态变量
    address owner;
    //修饰器
    modifier onlyOwner {
        require(msg.sender == owner);//需要满足这个条件
        _;//条件满足后继续执行，有点像委托
    }
```

###


### 2024.09.26

#### 1. 事件

```
event Transfer(address indexed from,address indexed to,uint256 value);
```
作用：

1. 事件能够被前端ether.js订阅
2. 事件的消耗(2000gas)要比链上存储一个变量要少(20000gas),但是这个作用性要存疑

>indexed修饰的变量，能够被保存在虚拟机日志的topics中，方便查询

日志结构

1. topics

topics数组的长度要求<=4，且indexed修饰的参数<=3

数组的首位存储 keccak("Transfer(address,address,uint256)")的结果

2. data

不带indexed修饰的参数值

#### 2. 继承

各种开发语言都有继承这一特性。学习时只要注意solidity语言与其他语言的区别即可。

描述继承关系关键词: <strong>is</strong>

抽象关键词: <strong>virtual</strong>

子类重写关键词: <strong>overrid</strong>

1. 函数继承

大部分高级语言都只允许继承一个类，允许继承多个接口。对solidity语言来说，它允许继承多个合约。要求越底层、兼容性越高的要排在前面。

比如：

```solidity

contract child is grandPa,father{
    function say() public override{

    }
}

```

2. 修饰器继承

3. 构造函数继承

``` solidity
// 构造函数的继承
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}

//方式1
contract B is A(3){

}

//方式2
contract C is A {
    constructor(uint _C) A(_C){

    }
}

```

4. 调用父合约的参数

```solidity
//方式1：通过super关键词，使用当前的最靠近的父级的方法
function callP() public{
    super.test();
}
//方法2： 直接制定继承的父级
function callP1() public {
    Papa.test();
}

```

5. 钻石继承

```solidity
/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}

//执行的顺序将会是：
//people eve adam god 
//且god只会在结尾被调用一次

```

###


### 2024.09.27

#### 1.抽象合约

合约中存在未实现的函数。

抽象合约中，是可以存在已经实现的函数的,且不需要子合约实现。如果没有被virtual修饰，子合约实现会编译报错。如Hi()。

在solidity中，如果要对abstract合约的部分function进行实现，必须要预先设为virtual，且自合约必须要经过override的修饰。

```solidity
abstract contract Father {
    function Say() public pure virtual returns(uint res){
        res = 1;
    }

    function Hi() public pure returns(uint){
        return 1;
    }

    function Ha() public pure virtual returns(uint);
}

contract Test is Father{
    function Say() public pure  override  returns(uint res){
        res = 2;
    }

    function Ha() public pure override  returns(uint){
        return 0;
    }

}
```

#### 2. 接口

规则：

1. 不能包含状态变量
2. 不能包含构造函数
3. 不能继承除接口外的其他合约
4. 所有函数都必须是external且不能有函数体
5. 继承接口的非抽象合约必须实现接口定义的所有功能

观察erc20的接口，发现事件的定义也是在接口的书写范围内的。

#### 2. 异常

抛出异常的三种方式： error require assert

1. error

需要配合revert(回退)使用。

```solidity
error TransferNotOwner(address sender);//自定义error

function TransferOwner(uint256 tokenId,address newOwner) public {
    if(owners[tokenId]!= msg.sender){
        revert TransferNotOwner(msg.sender);
    }
    owners[tokenId] = newOwner;
}
```

2. require 

缺点是errormessage的长度会影响gas

```solidity
require(condition,"error messager");
```

3. assert

开发人员测试使用。不会记录errormessage。


> gas消耗: error < assert < require

###

### 2024.09.28

#### 1. 重载

函数重载，即函数名称相同，但是入参不同的

```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```

#### 2. 库合约

高级语言都会有的东西。solidity的库合约看起来是已经部署在线上的，可以直接引用。

特点：

1. 不能存在状态变量
2. 不能够继承或被继承
3. 不能接收以太币
4. 不可以被销毁

使用方式：

1. using for语法

```solidty 
//library
library Strings {
    
}

// 利用using for指令
using Strings for uint256;

function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```

2. 直接库合约名称调用

这个有点像静态对象函数直接调用

```solidity
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```

###

### 2024.09.29

#### 导入

关键词 <strong>import</strong>

导入方式：

1. 通过文件的相对位置导入
2. 通过全局符号，导入合约特定的全局符号
3. 通过网址引入
4. 通过npm的目录导入

```solidity

//1
import './3_Ballot.sol';
//2
import {Ballot} from  './3_Ballot.sol';
//3
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
//4
import '@openzeppelin/contracts/access/Ownable.sol';

```

接下来就可以很简单的像使用库一样，通过using for语句或者直接静态函数引用的方式来使用。

###

### 2024.09.30

#### 1. 接收eth

solidity的特殊回调函数： receive() fallback()

使用场景：

1. 接收eth
2. 处理合约中不存在的函数调用(代理合约proxy contract)

> reveive

作用： 合约接收eth转账时被调用的函数

限制： 一个合约最多有一个receive()函数

声明方式: reveice() external payable {}

逻辑：内部逻辑不能太复杂，这收到发送方的方法影响，如果发送方使用send和transfer方法发送eht，就会有2300的gas限制。

code:

```solidty
event Received(address Sender,uint Value);

reveice() external payable {
    emit Received(msg.sender,msg.value);
}
```

> fallback

作用： 调用合约不存在的函数时被触发。也可用于接收eth，也可用于代理合约。

声明方式： fallback() external payable //(paybale修饰可选) {}

> 区别

```text
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
```

如果两者均不存在，则直接向合约中发送eth会报错。

但是可以在调用有被payable关键词修饰的function时，发送eth，这也能达到同样的效果，而且不需要调用这两个特殊回调函数。


#### 2. 发送eth

发送eth的方式

1. transfer()
2. send()
3. call() //推荐

```solidity
contract Sender {
    event SendFail(address to,uint256 amount);
    event CallFail(address to,uint256 amount);

    constructor() payable {}

    receive() external payable { }

    //transfer 的gas限制是2300，如果接收方合约地址的receive()或者fallback()过于复杂，则会失败
    //好消息是，transfer失败自动revert
    function transferEth(address payable to,uint256 amount) external payable {
        to.transfer(amount); // 只要是个address类型即可 合约一定要实现收款函数，账户本身就可以接收
    }

    function getBalance() view public returns(uint256) {
        return address(this).balance;
    } 

    //也是有2300的gas限制，失败后不会自动revert，所以返回值是bool类型，可以用来按照情况revert()
    function sendEth(address payable to,uint256 amount) external payable {
        bool success = to.send(amount);
        if(!success){
            emit SendFail(to, amount);
            revert();
        }
    }

    // to.call{value:value}(""); 没有gas限制，接收方的接收回调可以实现复杂逻辑
    // 失败不会自动revert
    function callEth(address payable to,uint256 amount) external payable {
        (bool success,) = to.call{value:amount}("");
        if(!success){
            emit CallFail(to,amount);
            revert();
        }
    }

}
```

那我在想一个特殊情况，如果我把receive()的实现搞复杂一点，然后使用sendEth，但是我失败后不revert，是不是接收方还是会收到eth呢？

经过尝试后确实是这样，而且执行不会报错，出发了SendFail事件。

当我通过transfer做这个事件的时候就失败了，因为他失败自动回滚，不会触发对应的内容。

这也从侧面说明了，solidity语言中，event事件的发送也是同步的。

###

### 2024.10.01

#### 调用已部署合约

核心逻辑就是，通过获取已部署合约的实例，调用实例中的方法。

获取已部署合约的方式：

1. conractName(contractAddress).f(x)
2. contract.f(x)

这就要求，调用方要获得已调用方的合约代码(接口)信息。

这就引出了另外一个call的方式，他也能够做到调用第三方合约，而且，它并不需要知道调用方的合约源代码或者接口(abi)信息。

```solidity
(bool success,bytes memory data) = address.call(abi.encodeWithSignature("func(address,uint)",address,uint);
```

> 通过call来调用第三方合约，推荐的方法就是通过已知合约代码信息的方式来调用，通过call的方式来调用是不推荐的。且容易出现风险。

###

### 2024.10.02

#### delegateCall

跟call的核心区别是上下文。delegateCall的上下文是调用方，而call的上下文是被调用方。

结合其他高级语言来理解，delegateCall实际上更类似于调用另一个实体类的方法，我可以利用这个实体类的各个静态参数，但是不会改变他们，我改变的只是调用者本身的信息。

限制：

1. 调用方、被调用方的参数必须完全一致，即使是顺序也需要一致。

从这些方面理解，delegateCall调用的，就是一个可变更的，执行逻辑。

###

### 2024.10.03

#### 合约创建新合约

1. create

```solidity
//如果被调用方构造合约是payable，可以通过下面这个value的方式发送eth
Contract x = new Contract{value:value}(params);
```

```solidity
contract Pair{
    address public factory;
    address public token1;
    address public token2;

    constructor() payable {
        factory = msg.sender;
    }

    function initialize(address _token1,address _token2) external {
        require(msg.sender == factory,"");
        token1 = _token1;
        token2 = _token2;
    }

}

contract Factory {
    mapping(address => mapping (address => address)) public getPair;
    address[] public allPairs;

    function createPair(address _token1,address _token2) external returns(address){
        Pair pair = new Pair();
        pair.initialize(_token1, _token2);
        allPairs.push(address(pair));
        getPair[_token1][_token2] = address(pair);
        getPair[_token2][_token1] = address(pair);
        return address(pair);
    }
}
```


###

<!-- Content_END -->
