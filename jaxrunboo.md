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
    函数的入参和临时变量，一般使用memory，存储在内存中，不上链。他用来修饰可变的变量。
    3. calldata
    存储在内存中，不上链。他的特点是不可变更，多用于函数参数。



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

声明方式: reveive() external payable {}

逻辑：内部逻辑不能太复杂，这收到发送方的方法影响，如果发送方使用send和transfer方法发送eth，就会有2300的gas限制。

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

### 2024.10.04

#### 1. create2

计算地址方式

1. create

address = hash(msg.sender,nonce)

nonce往往会产生变更，因此产生的地址不好预测

2. create2 

而create2是想要，不论未来发生什么，产生的地址是不变的。

address = hash("0xff",msg.sender,salt,initCode);

所需参数：

1. 固定常数 0xff
2. 合约创建者，msg.sender
3. salt bytes32字节的值，主要用来影响新合约创建的地址
4. initcode  新合约的初始字节码，合约的creationCode和构造函数的参数

用法：

```solidity
Contract x = new Contract{salt: salt,value: value}(params);
```

按这个用法，固定常数 、 initcode都没在create的时候展示，但是在预计算地址时，计算所需用到了这些信息。

合约实现：

```solidity 
contract Factory2 {
    mapping (address => mapping (address => address)) public getPair;
    address[] public allPairs;

    function createPair(address _token0,address _token1) external returns(address) {
        (address token0,address token1) = _token0 > _token1?(_token1,_token0):(_token0,_token1);
        bytes32 salt = keccak256(abi.encodePacked(token0,token1));
        Pair pair = new Pair{salt: salt}();
        pair.initialize(_token0, _token1);

        address p = address(pair);
        allPairs.push(p);

        getPair[_token0][_token1] = p;
        getPair[_token1][_token0] = p;
        return p;
    }
}
```

地址计算：

```solidity
function caculateAddr(address _token0,address _token1) external view returns(address) {
    (address token0,address token1) = _token0 > _token1?(_token1,_token0):(_token0,_token1);
    bytes32 salt = keccak256(abi.encodePacked(token0,token1));
    address predictAddress = address(uint160(uint(keccak256(
        abi.encodePacked(bytes1(0xff),address(this),salt,keccak256(type(Pair).creationCode))
        ))));
    return predictAddress;
}
```

###

### 2024.10.05 

#### 合约自毁

selfdestruct

坎昆升级后，这个功能不会销毁当前合约，只会向目的合约转入当前合约所有eth。

除非是合约创建和合约销毁在同一个方法内执行。不过确实想不到有什么应用场景。

不过不建议使用，有安全性问题和信任问题。

不过搜索了一下the dao攻击，倒是蛮有意思。

这是黑客攻击eth链，导致出现大量经济损失。而v神他们选择放弃去中心化，对当时的eth进行分叉。

现在的eth是分叉后的结果，之前的现在叫etc。

确实是违背去中心化的本意，但是没做这件事情，eth还能不能活着都不一定。

###

### 10.06 abi编码解码

Application Binary Interface 

#### ABI编码

编码函数

1. abi.encode 

将每个参数填充为32字节(64位16进制)的数据，所有参数会拼接在一起。

用途：

直接跟合约进行交互

2. abi.encodePacked

根据参数所需的最低空间编码。动作是跟encode相同，但是他会省略对存储来说多余的0。

用途：

不直接跟合约交互，节省空间，计算数据的hash。

3. abi.encodeWithSignature

功能与encode相同，32字节全字节填充，只是限定了第一个参数必须是函数签名。

4. abi.encodeWithSelector

功能与encodeWithSignature相同，但是限定了第一个参数必须是函数选择器。

函数签名：

```solidity
foo(uint256,address,string)
```

函数选择器：

```solidity
//函数选择器为函数签名经过keccak hash加密后的前四个字节 结果例如： 0xe87082f1
bytes4(keccak256("foo(uint256,address,string)"))
```

编码函数的返回类型都是： bytes

#### ABI解码

abi.decode

只能用于解码encode生成的二进制编码，把它还原成原本的参数。其他的编码方式无法解码。

#### 用途

1. 合约底层调用

```solidity

    function Test() public returns(address) {
        DC dc = new DC();
        //获取函数选择器
        bytes4 selector = dc.Say.selector;
        bytes memory data = abi.encodeWithSelector(selector,msg.sender);
        //合约底层调用
        (bool success , bytes memory returnData ) = address(dc).staticcall(data);
        require(success);
        return abi.decode(returnData, (address));
    }
```
2. ethers.js实现合约调用
3. 不开源的合约反编译或者不知道合约代码，但是知道函数选择器的4个字节，可以通过1中的方式调用

```solidity
    function Test1() public returns(address ){
        DC dc = new DC();//假设一个合约地址
        bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a),msg.sender);
        //静态调用
        (bool success,bytes memory res) = address(dc).staticcall(data);
        require(success);
        return abi.decode(res, (address));
    }
```

###

### 10.07

#### hash

可以认为是一个单向加密，通过 keccak256 来实现。

#### 函数选择器

调用智能合约的本质，就是发送一段calldata。其中前四个字节，也就是0x之后的8位16进制数，即为函数选择器。

告诉智能合约，要调用哪个方法。

bytes4(keccak256("say(address)")) // return bytes

使用场景：

```solidity 

 // 使用selector来调用函数
function callWithSignature() external{
    // 调用elementaryParamSelector函数
    (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
}

```

#### try catch使用

solidity语言的try catch跟大多数语言不一致。

```solidity

try this.func() returns(uint256) {

}
catch Error(string memory reason){

}

```

###

### 10.08

#### ERC20

一个标准的代币规范

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

interface Token {

    /// @param _owner The address from which the balance will be retrieved
    /// @return balance the balance
    function balanceOf(address _owner) external view returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transfer(address _to, uint256 _value)  external returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return success Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return success Whether the approval was successful or not
    function approve(address _spender  , uint256 _value) external returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return remaining Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract TestErc20 is Token {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances; // 账户的代币数据
    mapping (address => mapping (address => uint256)) public allowed; // 账户的授权数量
    uint256 public totalSupply; // 释放代币总量
    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX

    constructor(uint256 _initialAmount, string memory _tokenName, uint8 _decimalUnits, string  memory _tokenSymbol) {
        balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }

    //直接进行代币划转
    function transfer(address _to, uint256 _value) public override returns (bool success) {
        //1. 合理性验证 账户代币余额充足
        require(balances[msg.sender] >= _value, "token balance is lower than the value requested");
        //2. 数据变更
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        //3. 事件日志
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    //授权后的代币划转 
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        //1. 合理性验证 账户代币余额充足，授权账户的授权代币数量充足
        require(balances[_from] >= _value && allowance >= _value, "token balance or allowance is lower than amount requested");
        //2. 数据变更 
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) { //可能是安全上限 防止溢出
            allowed[_from][msg.sender] -= _value;
        }
        //3. 日志记录
        emit Transfer(_from, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance) {
        return balances[_owner];
    }

    // 基于代理账户授权数量，代理账户可以进行转出
    // 看这个意思，授权的数量是可以被覆盖的
    function approve(address _spender, uint256 _value) public override returns (bool success) {
        //授权无需进行合理性验证，因为在转出的时候，如果授权方没有足够的代币数量，一样是无法转出
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function mint(uint256 count) external {
        balances[msg.sender] += count;
        totalSupply += count;
        emit Transfer(address(0), msg.sender, count);
    }

    function burn(uint256 count) external {
        balances[msg.sender]-= count;
        totalSupply -= count;
        emit Transfer(msg.sender, address(0), count);
    }

}

```

#### 水龙头合约

跟其他语言比对起来还是有很多区别的

1. 数据的函数有限，没有低时间复杂度的查询方法，因此很多情况需要采用map的形式
2. 接口的声明，不能使用new语句

> 使用起来还是有规律的，比如要有明确的事件定义，要尽量早的做数据合理性判断，数据更新要考虑全面，结束后要发出事件

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Fauct {
    /*
    0. 分发事件记录
    1. 代币合约地址
    2. 已领取地址map
    3. 每次领取限制 这个限制对精度的影响需要确认
    */

    event SendToken(address indexed to);

    address public tokenAddress;
    //有点疑惑的是，我是不是可以只用一个数组表示，因为只要记录了就说明已经领取了，没有其他情况
    mapping (address => bool) public requestedAddressMap;
    //address[] public requestedAddressArr;
    //实际使用的时候发现，数组没有像其他高级语言一样有类似contain的时间复杂度O(1)的用法，所有只能循环查询，时间复杂度为O(n)

    uint256 public limit = 1000;

    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress;
    }

    function GetToken() external {
        require(!requestedAddressMap[msg.sender],"has get");
        //接口实现不能使用new? 又是跟正常语言不同的内容
        IERC20 token = IERC20(tokenAddress);
        require(token.balanceOf(tokenAddress) >= limit,"address has not token");
        token.transfer(msg.sender, limit);

        //token发送完后要修改当前的水龙头状态
        requestedAddressMap[msg.sender] = true;
        //日志记录
        emit SendToken(msg.sender);
    }

}
```

###

### 10.10

#### 空投合约

这就已经没有什么特殊的应用了，按照之前总结的

1. 验证
2. 执行
3. 事件日志

去写就行了

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Airdrop {
    /*
    这个合约只是一个发放空投的行为
    有两个发放的方案
    1. 直接把币转给这个合约，他自己去分发 手续费= token转账费用+分发费用
    2. 一个用户有币，授权给这个合约，合约去分发 手续费= 授权费用+分发费用
    我可以都写来试试
    */

    event Drop(address indexed _to, address indexed _count);

    address public tokenAddress;

    //方案一 初始化的时候我要给这个合约要空投的代币地址 合约要能执行动作，也要给他点手续费
    constructor(address _tokenAddress) payable {
        tokenAddress = _tokenAddress;
    }

    function transfer1(address[] calldata _addresses,uint256[] calldata _counts) external {
        require(_addresses.length == _counts.length,"arr not right");
        IERC20 token = IERC20(tokenAddress);
        require(token.balanceOf(address(this)) >= getAmount(_counts),"token not enough");

        for (uint256 i =0; i<_addresses.length; i++) 
        {
            token.transfer(_addresses[i], _counts[i]);
        }
    }

    function transfer2(address[] calldata _addresses,uint256[] calldata _counts) external {
        require(_addresses.length == _counts.length,"arr not right");
        IERC20 token = IERC20(tokenAddress);
        require(token.allowance(msg.sender, address(this)) >= getAmount(_counts),"token not enough");

        for (uint256 i =0; i<_addresses.length; i++) 
        {
            token.transferFrom(msg.sender, _addresses[i], _counts[i]);
        }
    }

    //求和
    function getAmount(uint256[] calldata _counts) private pure returns(uint256 total){
        for (uint256 i = 0; i<_counts.length; i++) 
        {
            total += _counts[i];
        }
    }

}
```

### 

### 10.11

#### WETH

WETH相当于用erc20把eth重新包了一层。给eth提供了erc20的属性。怪不得在uniswap的交易日志中都是weth的交换行为。

写这个逻辑的时候我的观念发生了变化，合约本身是可以没有eth作为手续费的，执行人提供手续费就可以了，合约完全可以看做一个可外部调用的方法。

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {

    event Deposit(address indexed account,uint256 indexed count);
    event WithDraw(address indexed account,uint256 indexed count);

    constructor () ERC20("WETH","WETH") payable  {

    }

    fallback() external payable { 
        deposit();
    }

    receive() external payable { 
        deposit();
    }

    function deposit() payable  public  {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function widthdraw(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount,"not enough weth");
        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(_amount);
        emit WithDraw(msg.sender, _amount);
    }

}
```

###

### 10.13

#### 代币锁

跟之前的线性释放区别不大，都是因为合约无法直接定时做动作，所以是在用户release的时候，计算现在合理的状况。


```solidity
pragma solidity >=0.8.2 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract TokenLock {
    event LockStart(address indexed beneficiary,address indexed token,uint256 startTime,uint256 lockTime);
    event Release(address indexed beneficiary,address indexed token,uint256 releaseTime,uint256 amount);

    address public immutable beneficiary;
    address public immutable token;
    uint256 public immutable startTime;
    uint256 public immutable lockTime;

    constructor(address _beneficiary,address _token,uint256 _lockTime){
        beneficiary = _beneficiary;
        token = _token;
        startTime = block.timestamp;
        lockTime = _lockTime;

        emit LockStart(beneficiary, token, startTime, lockTime);
    }

    function release() public {
        require(block.timestamp>= startTime+lockTime,"not end");
        IERC20 tt = IERC20(token);
        uint256 count1=tt.balanceOf(address(this));

        require(count1 > 0,"not enough token");
        tt.transfer(beneficiary, count1);

        emit Release(beneficiary, token, block.timestamp, count1);
    }
```

### 10.14 

#### 时间锁

是一种安全机制，即使用户有权限做操作，也需要经过一段时间的缓冲期。一旦出现问题，这个缓冲期可以做很多修正操作。

代码相关：

这其中有bytes和bytes32两种类型。但是bytes作为出入参、临时变量时需要使用memory来修饰，但是bytes32不需要。

经查证，产生这个区别的原因是：bytes表示不定长的入参，evm无法确定他是存储在内存中还是链上，所以需要明确的指定。

而bytes32是定长的变量，明确的知道是存储在哪个位置，所以无需额外指定。


```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TimeLock {
    //TODD: 现在不知道txhash是什么内容 executeTime用uint就可以存储了
    event QueueTransaction(bytes32 indexed txHash,address indexed target,uint256 value,string signature,bytes data,uint executeTime);
    event ExecuteTransaction(bytes32 indexed txHash,address indexed target,uint256 value,string signature,bytes data,uint executeTime);
    event CancelTransaction(bytes32 indexed txHash,address indexed target,uint256 value,string signature,bytes data,uint executeTime);
    event NewAdmain(address indexed newAdmin);

    //state
    address public admin;
    uint public delay;//锁定期 s 
    uint public constant GRACE_PERIOD = 7 days;//交易有效期，过期作废
    mapping (bytes32 => bool) public queuedTransactions;//记录所有在时间队列的交易
    bytes public test;

    //limit
    modifier onlyeOwner() {
        require(msg.sender == admin,"TimeLock: Caller not admin");
        _;
    }

    modifier onlyTimeLock() {
        require(msg.sender == address(this),"TimeLock: caller not timeLock");
        _;
    }

    //fucntion
    constructor(uint _delay,bytes memory _test){
        delay = _delay;
        admin = msg.sender;
        test = _test;
    }

    //通过onlyTimelock，将修改admin的行为也写入时间锁
    function changeAdmin(address newAdmin) public onlyTimeLock {
        admin = newAdmin;
        emit NewAdmain(newAdmin);
    }

    //将参数编码后写入任务队列
    function queueTransaction(address target,uint256 value,string memory signature,bytes memory data,uint executeTime) public onlyeOwner returns (bytes32){
        require(executeTime > block.timestamp + delay,"executeTime not statisfy");
        bytes32 txHash = getTxHash(target,value,signature,data,executeTime);
        queuedTransactions[txHash] = true;
        emit QueueTransaction(txHash, target, value, signature, data, executeTime);
        return txHash;
    }

    //从队列中取消，要求这个tx已经排入队列中
    function cancelTransaction(address target,uint256 value,string memory signature,bytes memory data,uint executeTime) public onlyeOwner {
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        require(queuedTransactions[txHash],"not queued");
        queuedTransactions[txHash] = false;
        emit CancelTransaction(txHash, target, value, signature, data, executeTime);
    }

    //
    function executeTransaction(address target,uint256 value,string memory signature,bytes memory data,uint executeTime) public payable  onlyeOwner  returns(bytes memory){
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        require(queuedTransactions[txHash],"");
        require(block.timestamp >= executeTime,"can't execute");
        require(block.timestamp <= executeTime + GRACE_PERIOD,"");
        queuedTransactions[txHash] = false;

        bytes memory callData;
        //signature 函数签名
        if(bytes(signature).length == 0){
            callData = data;
        }
        else{
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))),data);
        }
        (bool success ,bytes memory returnData) = target.call{value: value}(callData);
        require(success,"error");

        emit ExecuteTransaction(txHash, target, value, signature, data, executeTime);
        return returnData;
    }

    //keccak256的结果是bytes32类型
    function  getTxHash(address target,uint256 value,string memory signature,bytes memory data,uint executeTime) private pure returns(bytes32){
        return keccak256(abi.encode(target,value,signature,data,executeTime));
    }
}

```

> staticCall 和 call的区别：
staticCall是调用合约中的只读方法，且不能发送eth，call可以调用合约的中的修改状态的方法，基本上是万能的。

###

### 10.15

#### 代理合约

代理合约的核心逻辑，将合约的状态数据和逻辑行为拆分开来，让逻辑行为能够被替换。

下面写的是按照内联汇编的方式，将行为区分成calller、proxy、logic三个动作。

logic存储逻辑，可被替换

proxy存储状态，可用的数据更新存储在这里

caller只是一个用call做调用的例子，没那么重要

> wtf的这一节错误非常多，很不利于学习，需要自己好好去执行和分析结果。

这里不直接使用 addr.delegatecall(abi.encodeSignature("",data)) 来进行委托调用，而是选择使用内联汇编的方式，是因为fallback无返回值，
而通过内联汇编的方式，能够得到返回值。

那这里为什么一定要使用fallback来实现呢？我直接使用delegatecall的方式有什么问题呢？

想不通，只觉得是炫技，感觉都能做到。


```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

//代理合约，状态存储
contract Proxy {
    address public implementation;
    uint public x = 1;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function callTest(bytes memory data) public returns(bytes memory){
         address _implementation = implementation;
         ( ,bytes memory res) = _implementation.delegatecall(data);
         return res;
    }

    //用这个方式，可以有返回值
    //fallback 可以接收eth,当被调用本合约中不存在的函数时，也会触发
    fallback() external payable { 
        address _implementation = implementation;
        assembly{
            //数据保存在内存
            //calldatacopy(t,f,s): 将calldata入参从位置f开始，复制s个字节长度的数据，保存在mem(内存)的位置t
            calldatacopy(0,0,calldatasize())

            //利用delegatecall来调用implementation合约
            //delegatecall(g,a,in,insize,out,outsize): 调用地址implementation的合约，输入为mem[in..(in+insize)],输出为mem[out...(out+outsize)] 
            //提供g wei的以太坊gas, 这个操作码在错误时返回0，成功时返回1
            let result := delegatecall(gas(),_implementation,0,calldatasize(),0,0)

            //returndatacopy(t,f,s) 将returndata(输出数据)从位置f开始，复制s个字节的到mem(内存)的位置t
            returndatacopy(0,0,returndatasize())

            switch result
            case 0 {
                revert(0,returndatasize())
            }
            default {
                //返回数据
                return(0,returndatasize())
            }
        }
    }
}

//逻辑合约
contract Logic {
    address public implementation;
    uint public x = 99;
    event CallSuccess();

    function increment() external returns(uint){
        emit CallSuccess();
        x = x + 1;
        return x;
    }
}

contract Caller {
    address public proxy;

    constructor(address _proxy){
        proxy = _proxy;
    }

    function increment() external returns(uint) {
        (,bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
        return abi.decode(data, (uint));
    }
}
```

###

<!-- Content_END -->
