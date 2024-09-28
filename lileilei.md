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


### 2024.09.25
// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;

contract Mapping{

    mapping(uint=>address) public iptoaddress;

    function getData(uint ip) public view returns(address){//根据key获取value
       address addr = iptoaddress[ip];
       return addr;
    }

    function writeMap() public {//map赋值
        iptoaddress[123] = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    }
}
第七小节mapping的赋值和根据key获取value，相当于java的map，key不能使用自定义的类型
存储位置必须是storage

第八小节学习了不同类型变量的默认值
bool: false,string:"",int uint :0,enum:枚举的第一个值，address:address(0),struct是各个元素的默认值

第九个小节 常量的申明
constant  声明后必须初始化，初始化后不可变
immutable 可在声明货构造器中初始化，更加灵活

第10个小节学习了循环，因为跟java相差不大，只写示例

// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;

contract looptest{
    function ifelsetest(uint num) public pure returns(bool){
        if (num>0){
            return true;
        }else{
            return false;
        }
    }
    function fortest() public pure returns(uint sum){
        for (uint i=0;i<10;i++){
            sum+=i;
        }
    }
    function forwhile() public pure returns(uint){
        uint sum =0 ;
        uint i=0;
        while(i<10){
            sum+=i;
            i++;
        }
        return sum;
    }
    function tenarytest(uint x,uint y) public pure returns(uint a){
        return x>y?x:y;
    }
//插入排序
    function insertSort(uint[] memory a) public pure returns(uint[] memory){
        for(uint i=1;i<a.length;i++){
            uint temp = a[i];
            uint j=i;
            while((j>=1)&&temp<a[j-1]){
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return a;
    }
}


contract modifiertest{

    address public ownAddress;

    constructor (address addr){
        ownAddress = addr;
    }

    modifier onlyOwner{
        require (msg.sender == ownAddress); //如果校验通过会进行后边的业务操作
        _;
    }

    function changeOwner(address newAddr) external onlyOwner{
        ownAddress = newAddr;
    }
}
学习了修饰器和构造器的创建方式，构造器在初始化的时候会并且只会运行一次
修饰器一旦定义可以多次使用，简化了代码，常用来校验权限


### 2024.09.26
contract testEvent{
    mapping(address=>uint) public balanceMap;
    event Transfer(address indexed from,address indexed to,uint value);

    function transfer(address from,address to,uint value) public {
        balanceMap[from] = 1000;
        balanceMap[from] -= value;
        balanceMap[to] +=value;
        emit Transfer(from,to,value);
    }
}
学习了事件的创建和简单使用，使用事件的好处：1.节省gas
2.如果用indexed修饰，会根据索引生成一个topic，保存到日志中，便于查询，最多三个
3.前端可以对该事件进行订阅监听，相应。
4.事件和数据一起保存，保证了安全性

// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;
contract older{
    event log(string message);
    function pip()public virtual { //virtual表示需要被继承
        emit log("your grandpa is pip");
    }
    function pop() public{
        emit log("your grandpa is pop");
    }
}
contract old is older{
    function pip() public virtual override {//实现了父类函数，并且需要子类继承
        emit log("your baba is pip");
    }
    function popping() public  {
        emit log("popping");
    }
}
contract young is older,old{ //多重继承，从高到低依次申明
    function pip() public  override(older,old) {
        emit log("the young is pip");
    }
    function callParentPip() public {
       super.popping(); //调用的是直接上级的方法
    }
}

修饰器的继承
contract Base{
    modifier exactDividedBy2And3(uint a) virtual{
        require(a%3==0 && a%2==0); //校验通过后再进行后边的操作
        _;
    }
}
contract cal is Base{
    function getData(uint num) public exactDividedBy2And3(num) pure returns(uint,uint){
        return getRes(num);
    }
    function getRes(uint num) public pure returns(uint x,uint y){
        x = num%2;
        y = num%3;
    }
}

继承：函数，构造器和修饰器都可以继承，简化了代码
需要被继承时函数声明为virtual,实现时加override 关键字
多次继承的话需要按优先级申明继承的顺序，如果继承的多个合约都有一个共同的函数，super.函数()会调用上一级的方法
修饰器继承后使用时，跟的参数需要与前边函数调用的参数保持一致


contract errtest{
    error transferOwner();
    mapping(uint=>address) private owners;
    function transferNotOwner(uint token,address newOwner) public {
         if(owners[token] != msg.sender){
            revert transferOwner();
         }
         owners[token] = newOwner;
    }
    function testRequire(uint token,address newOwner) public view{
        require(owners[token] == msg.sender,"transfer not owner");
        owners[token] == newOwner;
    }
    function testAssert(uint token,address newOwner) public{
        assert(owners[token]==msg.sender);
        owners[token]= newOwner;
    }
}

error 搭配revert使用，可以返回报错信息，gas最少
require 可以自定义返回的报错信息
assert gas最多，返回的错误信息未知
上边mapping没初始化，所以都会报错


### 2024.09.27

pragma solidity ~0.8.21;
contract overrideTest{

    function getString() public pure returns(string memory){
        return "hello";
    }
    function getString(string memory msg) public pure returns(string memory){
        
        return string.concat("hello",msg); 
    }
    function f(uint8 _in) public pure returns(uint8 out){
        out=_in;
    }
    function f(uint256 _in) public pure returns(uint256 out){
        out=_in;
    }
}
重载就是可以声明多个相同名字不同参数类型的方法

<!-- Content_END -->