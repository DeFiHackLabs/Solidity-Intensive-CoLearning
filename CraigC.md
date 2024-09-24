---
timezone: Asia/Shanghai
---

---

# CraigC

1. 自我介绍
一个只学过一点点编程的小白,想要在Web3长远的走下去

2. 你认为你会完成本次残酷学习吗？
绝对可以!
   
# Notes

<!-- Content_START -->
### 2024.09.23
## 101-01
```
// 声明软件许可
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3 {       //contract创建合约,并声明合约名为‘HelloWeb3’
    string public _string = "Hello Web3!"; //创建了一个名_string的string变量
}
//每行代码以;结束
```
## 101-02
```
/*
solidity中有3种常用的变量类型
1.值类型(value type):包括布尔型、整型等,这类变量赋值时直接传递数值
2.引用类型(Reference type):包括数组和结构体,占用空间大,赋值时直接传递地址
3.映射类型(mapping type):solidit中存储键值对的数据结构,可以理解为哈希表*/ 

// 值类型
// 1.bool
/*布尔值的运算符
!   逻辑非
&&  逻辑与(and) 
||  逻辑或(or)
==  等于
!=  不等于*/

contract Bool1 {
    //布尔值
    bool public _bool = false ;
    //布尔运算
    bool public _bool1 = ! _bool;
    bool public _bool2 = _bool && _bool1;//所有结果true才输出true//
    bool public _bool3 = _bool || _bool1;//任一为true就输出true//
    bool public _bool4 = _bool == _bool1;
    bool public _bool5 = _bool != _bool1;
    //&&和||遵循短路原则:&&中第一个条件为false不会再继续判断;||第一个条件为true时不会再继续判断//
}

contract Integer {
//2.整型

    int public _int = -1;//整数,包括负数
    uint public _uint = 0;//非负整数
    uint256 public _num = 20240923;//256位非负整数

    //比较运算符(返回布尔值): <=, <, ==, !=, >=,>//
    //整数运算符:+ - * / %(取余) **(幂)
    
    uint256 public _num1 = _num + 1;
    uint256 public _num2 = _num1 - _num;
    uint256 public _num3 = _num * 2;
    uint256 public _num4 = _num / 2;
    uint256 public _num5 = 10%4;
    uint256 public _num6 = 2**5;
    bool public _numbool = _num1 > _num2;
}

contract Address {
//3.地址类型
    /*地址类型有两类:
    1.普通地址(address) 存储一个20字节[以太坊地址大小]的值
    2.payable address,比address多了transfer,send两种成员方法用于接收转账*/
    
    address public _address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable public _address1 = payable (_address);

    uint256 public _balance = _address.balance;//.balance是solidity内置属性,用来查询地址ETH余额,单位为wei(10^-18eth)
}

contract Bytes {

    //字节数组//
    /*字节数组分为定长和不定长两种：
    定长: 属于值类型，数组长度在声明之后不能改变。根据字节数组的长度分为不同类型。定长字节数组最多存储32bytes数据，即bytes32。
    不定长: 属于引用类型,数组长度在声明之后可以改变,包括bytes等。*/
    
    bytes32 public _bytes32 = "Craig.yc";
    bytes1 public _byte1 = _bytes32[0];//索引_byte32的第一个字节(索引从0开始1),获取到C的ASCII值并存储在_bytes1中
}





//习题//



contract Enum {
    //enum是自定义的数据类型,主要用于为uint分配名称,提升可读性//
    enum ActionSet {Buy, Hold, Sell}
    ActionSet action = ActionSet.Buy;
}
//测试习题中的问题//
contract test {
    address payable public addr = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    function sendEther() external payable {
        addr.transfer(1);
    }//虽然报错,但应该是合约转入addr//
}
//bytes4 表示4字节(32bit),4bit=1十六进制位//


contract test_5 {
    bool public a = 1+1!=2||0/1==1;//false
    bool public b = 1+1!=2||1-1>0;//false
    bool public c = 1+1==2&&1**2==2;//false,后者为false,全true才输出true
    bool public d = 1-1==0&&1%2==1;//true,全true
}
```

### 2024.09.24
## 101-03 函数
solidity中函数的形式如下:   
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

1. fuction:声明函数  
2. function name:函数名  
3. parameter types:(变量类型 名称)  
4. {internal|external|public|private}:函数可见型说明符  
    - internal:只能合约内部访问,继承合约可用  
    -  external:只能合约外部访问(内部可通过this.FunctionName()调用)    
    -  public:全部可见  
    -  private:合约内部访问,继承不可用   
**[合约中定义的函数要有明确指向性,无默认值]**    

5. [pure|view|payable] :函数权限关键字 

### pure,view,payable
payable:可支付,能为合约支付eth  
pure:既不能读取也不能写入链上状态   
view:能读取但不能写入链上状态

非pure和view函数既可读取也可写入状态变量


```
contract FuncType1 {
    uint256 public num = 5;
    function add() external {
        num = num +1;
    }//add运行时num被写入了

    function addPure(uint256 _Num) external pure returns(uint256 _NewNum){
        _NewNum = _Num + 1;
    }//被标记为pure的add()的函数无法写入,只能return一个值

    function addView() external view returns (uint256 _num1){
        _num1 = num + 1;
    }//被标记为view的函数可以读取链上状态,可以读取到add()函数中的num
}

contract FuncType2 {
    uint256 public num = 10;
    //internal:内部函数
    function minus() internal {
        num = num - 1;
    }
    //合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }//可以从合约外部调用,通过这个external函数调用minus()函数}


    function minusPayable() external payable returns(uint256 balance){
        minus();
        balance = address(this).balance;
    }//payable函数通过当前地址向合约转入eth,并调用了minus()函数
}
```

<!-- Content_END -->
