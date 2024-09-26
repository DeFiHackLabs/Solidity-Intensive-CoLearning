---
timezone: Asia/Shanghai
---



# Rumbia

1. 自我介绍
    一个酷爱web3的未来伟大交易者

2. 你认为你会完成本次残酷学习吗？
   要么完成，要么死亡  
   
## Notes

<!-- Content_START -->

### 2024.09.23
一、 git操作
Git是一个分布式版本控制系统
克隆仓库            git clone 
查看分支            git branch(git branch -r 列出远程跟踪分支 git branch -a 本地和远程all分支)
创建分支            git checkout -b <branch-name> 
添加文件到暂存区     git add 
提交修改            git commit -m "message"(将暂存区的修改提交到本地的仓库 message用来描述提交的内容)
推送修改到远程仓库   git push (更新远程仓库状态)
二、solidity 
Solidity 是一种用于编写以太坊虚拟机（EVM）智能合约的编程语言.
Remix -> IDE
//----许可证
// SPDX-License-Identifier: MIT
//----"^"符号-----
“^0.8.21” 表示要求使用的 Solidity 编译器版本至少为 0.8.21，但不包括下一个主版本（0.9.0 及以上版本）。
符号 “^” 在版本范围指定中被称为 “caret” 符号，
它允许使用与指定版本具有相同主版本号和更高的次版本号及补丁版本号，只要不破坏向后兼容性。
pragma solidity ^0.8.21;
//合约
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
### 
### 2024.09.24
一、关于solidity的变量类型
1.值类型(Value Type)
    bool 
    uint（num） -->正整数 num是bit位 e.g： uint256 public _a = 20220330; // 256位正整数
    int 
    **address：**
    一、定义:
        address 是solidity特有的 
        address类型的变量可以存储一个 20 字节的值，代表一个以太坊账户地址。这个地址可以是外部账户（由用户控制的账户，拥有私钥）或合约账户的地址。
        通常以十六进制形式表示，例如0x1234567890abcdef1234567890abcdef12345678。
        二、主要属性和方法
        balance属性：可以使用address.balance来查询一个地址的以太币余额。例如，address payable someAddress; uint256 balance = someAddress.balance;可以获取地址someAddress的以太币余额并存储在变量balance中。    
        transfer方法：用于向一个地址发送以太币。例如，someAddress.transfer(100);将向地址someAddress发送 100 wei（以太坊的最小货币单位）的以太币。这个方法会抛出异常如果发送失败。
        send方法：也用于发送以太币，但它返回一个布尔值表示发送是否成功。例如，bool success = someAddress.send(100);如果发送成功，success将为true，否则为false。
        call方法：可以用于与其他合约进行交互或执行低级别的调用。它接受一个字节数组作为参数，可以指定要调用的函数和传递的参数。例如，(bool success, bytes memory data) = someAddress.call(abi.encodeWithSignature("someFunction()"));执行对地址someAddress上的 “someFunction” 函数的调用。
    **Q1:**
    address payable addr;
    addr.transfer(1);
    **合约向addr 转账 1wei**
    定长字节数组(数值类型):数组长度在声明之后不能改变. e.g.:bytes1 bytes32 其最多存储32bytes数据  
        一字节等于8bit
    enum (太冷门了,无人问津...)
2.引用类型(Reference Type)
    不定长字节数组
3.映射类型(Mapping Type)
4.函数类型(Function Type)
### 

### 2024.09.25
**function**
一、形式：
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
function：声明函数时的固定用法。要编写函数，就需要以 function 关键字开头。
<function name>：函数名。
(<parameter types>)：圆括号内写入函数的参数，即输入到函数的变量类型和名称。（传入的参数 及其类型）
{internal|external|public|private}：函数可见性说明符，共有4种。
public：内部和外部均可见。
external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
private：只能从本合约内部访问，继承的合约也不能使用。
internal: 只能从合约内部访问，继承的合约可以用。
[pure|view|payable]：决定函数权限/功能的关键字。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。
[returns ()]：函数返回的变量类型和名称。
**public 和 extenal 的区别**
一、函数可见性范围
public函数：
**可以在内部（合约内部的其他函数）和外部（通过交易调用合约）被访问。**
对于合约内部的调用，public函数的调用方式与内部函数相同，可以直接调用。
对于外部调用，通常通过交易发送到合约地址来触发。
external函数：
主要用于外部调用。不能在合约内部以与内部函数相同的方式调用（即不能直接使用 “函数名 ()” 的方式调用），但可以通过 “**this. 函数名 ()**” 的方式从合约内部进行外部调用。
二、Gas 开销和效率
external函数在某些情况下可能**具有较低的 Gas 开销**，特别是在处理复杂的数据结构或进行大量的外部调用时。
这是因为external函数在接收参数时采用不同的方式，它将参数存储在 calldata 区域而不是内存中，这可以**节省一些 Gas**。
public函数在内部调用时可能更加方便，因为它们可以像内部函数一样被调用，不需要特殊的语法。但在处理外部调用时，可能会有一些额外的 Gas 开销，因为参数通常会被复制到内存中。

合约中定义的函数需要明确指定可见性，没有默认值！！！
public|private|internal 也可用于修饰状态变量。
public变量会自动生成同名的**getter函数**，用于查询数值。未标明可见性类型的状态变量，默认为internal。

**Prue 和 view ：**：
一句话总结： 当不需要读取和写入链上的状态变量 用prue
             当只读不写的时候 用view
最重要的是：**用户从外部调用包含这两个关键字的函数时不消耗gas!**
**internal v.s. external**:
1.可见性
     internal ：只有在当前合约内部以及当前合约派生的合约内部访问，外部不可以!
     external：可以从合约外部通过交易访问，也可以在派生合约中被访问 （this.Functionname（））
2.gas开销：
external: 接收参数时会把参数存在**calldate**区域，节省gas 
internal :处理合约内部调用更加高效 ，不需要处理外部调用的一些额外开销. 接收参数时会把参数存在memory

**payable**:
// payable: 递钱，能给合约支付eth的函数
function minusPayable() external payable returns(uint256 balance) {
    minus();    
    balance = address(this).balance;
}

**calldate**
-------wait day05----...

**函数返回值**： 
**return 和 returns :**
returns 跟在函数名后面，用于声明返回值的变量类型及变量名 （可以不声明变量名哦 只是不推荐这么写哈哈哈）
return：写在函数主体内，返回指定变量.
// 返回多个变量
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
这里 1，2，5 要强转成uint256（） 因为编译器默认为uint8 类型不匹配
下面是返回类型：
**命名式返回**：
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
//不需要return 只需要为returns里声明的变量赋值即可 当然 return 也不错哈

// 命名式返回，依然支持return
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
**解构式赋值**：
uint256 _number;
bool _bool;
uint256[3] memory _array;
(_number, _bool, _array) = returnNamed();
如果只想读取部分 e.g. _array
(, ,_array ) = returnNamed();


###
### 2024.09.26
 
变量数据存储和作用域  
Morkdown笔记的用法...

#### 1.Solidity 变量数据存储和作用域

引用类型（Reference Type）
- 包括数组（array）和结构体（struct）
- 占用存储空间大，使用时必须声明数据存储位置
  （这就是为啥数组后面不加memory会报错的原因哈）
数据存储位置
- storage
  - **合约里的状态变量默认使用**
  - 存储在链上，类似计算机硬盘
  - 消耗 gas 多
- memory
  - **用于函数参数和临时变量**
  - 存储在内存中，不上链
  -  花费gas 少，
  
- calldata
  - **类似 memory，存储在内存中，不上链**
  - 变量不可修改（immutable）
  - 常用于函数参数

数据位置赋值规则
**基于传值和传址**
- storage 到 local storage：创建引用，修改会影响原变量
- memory 到 memory：创建引用，修改会影响原变量
- 其他情况：创建独立副本，修改不影响原变量
```solidity
uint[] x = [1,2,3]; // 状态变量：数组 x

function fStorage() public{
    //声明一个storage的变量 xStorage，指向x。**修改xStorage也会影响x**
    uint[] storage xStorage = x;
    xStorage[0] = 100;
}
```
**变量作用域**

- 状态变量
  - 存储在链上
  - 所有合约内函数可访问
  - gas 消耗高

```solidity
    contract Variables {
    uint public a1 = 1;
    uint public y=999;
   
}
```
- 局部变量
  - 仅在函数执行过程中有效
  - 存储在内存中，不上链
  - gas 消耗低
```solidity
function bar() external pure returns(uint){
    uint xx = 1;
    uint yy = 3;
    uint zz = xx + yy;
    return(zz);
}

```
- 全局变量
  - Solidity 预留关键字
  - 可在函数内直接使用，无需声明
  - [全局变量使用文档](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
就比如下面：
以太单位与时间单位  
solidity中不存在小数点！！ 用0来代替小数点，来确保交易的精度
- 以太单位：wei, gwei, ether
- wei: 1
- gewi: 1e9=1000000000
- ether: 1e18=1000000000000000000

    时间单位：可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。
- 时间单位：seconds, minutes, hours, days, weeks


#
<!-- Content_END -->
