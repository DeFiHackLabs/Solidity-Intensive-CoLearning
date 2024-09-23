---
timezone: Asia/Shanghai


# YourName

1. 自我介绍
   我是李磊，很高兴可以参加这次集训
2. 你认为你会完成本次残酷学习吗？
   肯定会
## Notes

<!-- Content_START -->

### 2024.09.23
// SPDX-License-Identifier: MIT 
pragma solidity ~0.8.21; //声明编译的版本，也可以写成 pragma solidity >0.8.21 <'0.9.0' 
contract helloworld{ //声明合约名称
    string public name = 'helloworld'; //声明属性,必须设置为public,不然不可见
}

第一小节，学习了sol文件的基本格式，编译和部署，第一行是solidity文件的固定格式,下边的都已经添加注释，我目前用的remix客户端进行编写

// SPDX-License-Identifier: MIT 
pragma solidity ~0.8.21;

contract valueType{

   //布尔类型
   bool public bol = true;
   bool public bol2 = !bol;  //false
   bool public bol3 = bol && bol2;  //false
   bool public bol4 = bol || bol; //true
   bool public bol5 = bol == bol3; //false
   bool public bol6 = bol !=bol3; //true;


   //整数类型
    int public num = -1; //整数包含负值
    uint public num1 =2; //正整数
    uint256 public num2 = 3; //范围大的正整数
    uint256 public num3  = num1+1;
    uint256 public num4  = 2*2; //4
    uint256 public num5 = num4%2; //0
    bool public bol8 = num4>num5; //true
    bool bol7 = num4>num5; //无法读取因为没有设置public


    //地址类型
    address public addr =0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable  public addr1 = payable(addr);
    uint256 public balance = addr1.balance;

    //定长字节数组
    bytes32 public byt = "creayzysolidity";
    bytes1 public byt1 = byt[0] ;

    //枚举类

    enum actionList{Buy,Sell,Hold}
    actionList public action = actionList.Buy;

    function getActionIndex() public view returns(uint idx){
        idx = uint(action); //将uint8转为
    }

}
第二小节学习了solidity基本的数据类型，如果不声明为public，外界防问不到 bool 
布尔类型，判断true，false用来做逻辑运算 
uint 正整数，不申明长度就默认为uint256,可以用来做基本的运算 
address 地址类型，地址唯一，payable修饰后可以接收转账，比普通用户多了transfer和send方法 余额属于地址的一个变量，可以直接获取 
bytes 定长数组，声明时需要定义长度 
枚举类型enum 目前不常用


<!-- Content_END -->
