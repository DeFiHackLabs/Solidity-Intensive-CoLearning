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


### 2024.09.24


// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;


contract testFunction{

    uint256 public number = 5;

    constructor() payable {}

    function add() external {//外部可以调用
        number = number+100;
    }
    function addpure(uint256 a) external pure returns(uint256 num){//不能看也不能操作链上的元素
        num = a;
    }

    function addpure() external view returns(uint256){
        return number;
    }
    
    function addview() external view returns(uint256 num){ //只能看不能修改
        num = number;  
    }

    function minus() internal  { //只能内部调用
        number = number-1;
    }
    function minusCall() external { //只能外部调用
        minus();
    }
    
    function minusPayable() external payable returns(uint256 balance){
        minus();
        balance = address(this).balance;
    }

    
}
第三小节，学习了函数的定义，函数的作用范围和权限的概念。
函数可见性关键字：  public 内部外部都可见 private 内部可见，不可继承 external 只能外部可见  internal 只能内部可见与private的区别是可继承
权限关键字：pure不能看也不能修改  view只能看  不显式定义的话既可以看也可以修改  payable修饰的话可以支付etl
returns 定义返回的类型(不是必须的)，方法体内可以return，也可以用returns后边定义的参数结合return使用



// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;
contract testReturn{
    //返回多个参数
    function returnMuliti() external pure returns(uint256 number,string memory name,bool b){
        return (1,"test",false);
    }
    //命名式返回
    function returnNamed() public pure returns(uint256 number,string memory name,bool b){
       number =2;
       name = "test";
       b = false;
    }
    //解构式读取
    function readName() external pure returns(uint256 number,string memory name,bool b){
        (number,name,b) = returnNamed();
        //返回部分值
        (,name,) = returnNamed();
    }
}
第四小节主要是返回值的相关操作，可以返回多个值，也可以读取别的方式的返回值再选择性的返回
注意点：1.调用别的方法时，被调用方法不能申明成external，否则内部方法无法访问
        2.string和array数组，定义时需要用memory修饰

contract testStorage{
    uint[] public arr = [2,3,4];

    function fstorage() public{  //存储在链上，修改后的值会同步到链上
        uint[] storage arr2 = arr;
        arr2[0] =100;
    }
    function fmemory() public view{ //存放在内存上，修改后的值不会同步到链上
        uint[] memory arr3 = arr;
        arr3[1] =50;
    }
    function fcalldata(uint[] calldata data) public pure returns(uint[] calldata){//只用来读取参数
       return data;
    }

    function readData() public view returns(uint[] memory a){ //读取arr的值，看是否被修改
       a = arr;  
    }
}
第五小节，变量存储的位置
storage 存储在链上，修改后的值会同步到链上
memory 存储在内存中，修改的值不会同步到链上
calldata 存储在内存中，且不能更改，所以一般用到做参数



contract testStruct{
    uint256[]  arr1 = new uint256[](5); //动态数组，后边申明的是长度
    uint256[3] arr2 = [1,2,3]; //定长数组,申明的是值
    function initArray() external pure returns(uint[] memory arr){
        uint[] memory a = new uint[](3);
        a[0] =1;
        a[1] =2;
        a[2] =3;
        arr = a;
    }
    uint[] public  arr4;
    function pushpopArray() public  returns(uint[] memory ){
         arr4.push(2); 
         arr4.push(4);
         return arr4;
    }
    struct student{
        string name;
        uint256 age;
    }

    student stu;
    function initStudent()external {
        stu = student({name:"test",age:10});
    }
    function initStudent2() external {
        stu.name = "lala";
        stu.age = 20;
    }
}
学习了动态数组和定长数组的创建和赋值方式，动态数组如果用memory修饰需要定义长度，不能使用pop,push方法
因为pop,push的数组必须存在链上
还学习了结构体的声明，主要写了常用的初始化方式，如果部署后想知道初始化的结果，需要将stu声明成public

<!-- Content_END -->
