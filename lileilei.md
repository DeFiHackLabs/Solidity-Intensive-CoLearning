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

### 2024.09.28
import "./Strings.sol";
using Strings for uint256;
contract LibraryTest{
    function getString(uint256 number)  public pure returns(string memory){
        return number.toHexString();
    }

    function getString2(uint256 number) public pure returns(string memory){
        return Strings.toHexString(number);
    }
}
使用库合约跟java的工具类一样，可以直接使用已经定义好的方法
将library导入，在通过using A for B 将A的函数赋予B

// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;

contract otherContract{
  
    uint256 private x=0;
    event log(uint amount,uint gas);
    function setx(uint256 amount) public payable {
        x = amount;
        if(amount>0){
            emit log(msg.value,gasleft());
        }
    }

    function getx() public view returns(uint256){
        return x;
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
}

contract callother{
    function callSetx(address addr,uint x)external {
       // otherContract con = otherContract(addr); 
      // con.setx(x);
       otherContract(addr).setx(x);
    }
    function callGetx(otherContract addr) public view returns(uint){
        return addr.getx();
    }
}
调用其他的合约，跟上边的库合约类似


contract receiveEth{
    event recEth(address from,uint256 value);
    event fallbackEth(address,uint256 value,bytes data);
    //因为有gas限制，receive和fallback逻辑不能太复杂
    receive() external payable { 
        emit recEth(msg.sender,msg.value);
    }
    fallback() external payable{
        emit fallbackEth(msg.sender, msg.value, msg.data);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }


}


contract callEth{
    error sendfailed(); //搭配revert使用
    error callfailed();
    //三种发送eth的方法：call,transfer,send
    constructor() payable {}
    receive() external payable { }
     
    function transferEth(address payable  to,uint amount) external {
        to.transfer(amount);
    }

    function sendEht(address payable to ,uint amount) external {
        bool success = to.send(amount);
        if(!success){
            revert sendfailed();
        }
    }

    function callerEth(address payable to,uint amount)external {
        (bool success, )= to.call{value: amount}("");
        if(!success){
            revert callfailed();
        }
    }
}
发送eth和接收eth，地址和结构体需要用payable修饰
发送可以用transfer,call,send
transfer 有gas限制2300，失败后会revert
send 有gas限制，失败后不会自动revert，一般不会用
call 没有gas限制，常用


### 2024.09.29
import "./other.sol";
contract callOther{
    event log(string message);

    function callSetx(address payable addr,uint amount) public payable {
          (bool success,bytes memory data) = addr.call{value:msg.value}(abi.encodeWithSignature("setx(uint256)", amount));
          if(success){
            emit log("success");
          }
    }
    function callGetx(address payable addr) public returns(uint256){
        (bool success,bytes memory data) = addr.call(abi.encodeWithSignature("getx()"));
        if(success){
            emit log(string(abi.encodePacked(abi.decode(data, (uint256)))));
        }
        return abi.decode(data, (uint256));
    }
    function callnotexist(address payable addr)public{
        (bool success,bytes memory data) = addr.call(abi.encodeWithSignature("selects()"));
        if(!success){
            emit log("the method is not exist");
        }
    }
}
使用call调用其他的合约方法，abi.encodeWithSignature("setx(uint256)")会找到对应的方法，如果有入参的话在后边指定
call还可以发送eth，addr.call(value:msg.value) 这个value指的是当前合约拥有的eth,也可以手动指定数值
调用不存在的方法时，会自动fallback()

pragma solidity ~0.8.21;

contract c{
    uint256 public number;
    address public addr;
   function setVars(uint256 num) external{
     number = num;
     addr = msg.sender;
   }
}
contract B{
    uint public number;
    address public addr;
    function callSetVars(address _addr,uint amount) public {
        (bool success,bytes memory data) = _addr.call(abi.encodeWithSignature("setVars(uint256)", amount));
    }
    function callVars(uint amount,address _addr) public{
        (bool success,bytes memory data) = _addr.delegatecall(abi.encodeWithSignature("setVars(uint256)", amount));
    }
}
call调用目标方法直接修改目标的方法的属性
delegatecall 是A调用B资产执行c的代理方法，修改的B的属性值，这会B相当于目标方法，c成了代理方法。


// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;

contract Pair{
    address public factory;
    address public token1;
    address public token2;

    constructor(){
        factory = msg.sender;
    }

    function init(address _token1,address _token2) public{
        require(factory == msg.sender);
        token1 = _token1;
        token2 = _token2;
    }
}


contract pairFactory{

    mapping(address=>mapping(address=>address)) public getPair;
    address[] public allPair;
    function createPair(address tokenA,address tokenB)public returns(address addPair) {
        Pair pp  = new Pair();
        pp.init(tokenA, tokenB);
        addPair = address(pp); //生成一个当前初始化的地址 
        allPair.push(addPair);
        getPair[tokenA][tokenB] =  addPair; //修改map的key,value
        getPair[tokenB][tokenA] = addPair;
    }
}


contract pairCreate2{ 
    mapping(address=>mapping(address=>address)) public getPair;
    address[] public allPair;

    function createPair2(address tokenA,address tokenB) public returns(address pairAdd){
        //create2跟create不一样的地方是多了salt参数
        (address token1,address token2) = tokenA>tokenB?(tokenB,tokenA):(tokenA,tokenB);
        bytes32 salt = keccak256(abi.encodePacked(token1,token2));
        Pair pp = new Pair{salt:salt}();
        pp.init(tokenA,tokenB);
        pairAdd = address(pp);
        allPair.push(pairAdd);
        getPair[tokenA][tokenB] = pairAdd;
        getPair[tokenB][tokenA] = pairAdd;
    }
}
create跟create2的区别就是create2需要sa


### 2024.09.30
contract deleteContract{
    receive() external payable { 

    }
    event log(address addr);
    uint public value=10;
    constructor() payable {}
    event log(string mesg);

    function deletecontract() public{
        emit log(msg.sender);
        selfdestruct(payable (msg.sender));
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}
删除合约，删除后eth会返回到调用方
import "./deleteContray.sol";
contract deployContract{
    constructor() payable{}
    event log(address addr,uint balance,uint value);
    error callfailed();

    struct DemoResult{
       address addr;
       uint balance;
       uint value;
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
    
    //先给deleteContract发送ETH
    function callEth(address payable addr,uint amount) public{
        (bool success,bytes memory data) = addr.call{value:amount}("");
        if(!success){
            revert callfailed();
        }
    }
    function deploycontract() public payable returns(DemoResult memory){
       deleteContract ddl = new deleteContract{value:msg.value}();
       DemoResult memory res = DemoResult({
        addr:address(ddl),
        balance: ddl.getBalance(),
        value:ddl.value()
       });
       emit log(res.addr,res.balance,res.value); 
       ddl.deletecontract();
       return res;
    }
}
先发送eth给deleteContract,在调用删除合约的方法，看etl是否会返回当前合约的balance

contract encode{
    uint x =10;
    string name ='leiii';
    uint[2] arr = [5,6];

    function encoded() public  view returns(bytes memory){ //可以与合约进行交互
        return abi.encode(x,name,arr);
    }

    function encodePacked()public view returns(bytes memory){ //节省空间但是不能与合约交互
        return abi.encodePacked(x,name,arr);
    }

    function encodeWithSignature() public view returns(bytes memory){
        return abi.encodeWithSignature("foo(uint256,string,uint256[2])",x,name,arr);
    }

    function encodeWithSelector() public view returns(bytes memory result){
        result =  abi.encodeWithSelector(bytes4(keccak256("foo(uint256,string,uint256[2])")), x, name, arr);
    }

    function decode(bytes memory data) public pure returns(uint256 dx,string memory dname,uint256[2] memory adrr ){
        (dx,dname,adrr) = abi.decode(data, (uint256,string,uint256[2]));
    }
}
加密和解密常用的方法
encode() 将参数都编译成32字节的数据在拼接到一起，可以调用其他的合约，安全性高，省资源
encodePacked 常用来取hash值
encodeWithSelector和encodeWithSignature一样，但是select在选择方法时更精准




### 2024.10.01

contract hashTest{

    bytes32 msg2= keccak256(abi.encode(0xAA));
    function hh(string memory name,address addr,uint num)public  pure returns(bytes32){
        return keccak256(abi.encodePacked(name,addr,num));
    }


    function weak(address addr,uint256 num) public  view returns(bool){
         return keccak256(abi.encodePacked(addr,num)) == msg2;
    }

    function strong(string memory str1,string memory str2) public pure returns(bool){
        return keccak256(abi.encodePacked(str1)) ==keccak256(abi.encodePacked(str2));
    }
}
hash常用来做数字唯一标识和安全加密

### 2024.10.02
contract selectorTest{
    function noParam() external pure returns(bytes4){
        return bytes4(keccak256("noParam()"));
    }

    function selecttor() public{
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256("noParam()")));
        bytes memory data3 = abi.encodeWithSelector(0xc2cfaca2);
       (bool success,bytes memory data2) = address(this).call(abi.encodeWithSelector(0xc2cfaca2));
    }
abi.encodeWithSelector 需要先算出被调用方法的hash值,上边结果是一致的


### 2024.10.03   

// SPDX-License-Identifier: MIT
pragma solidity ~0.8.21;

contract onlyEven{
    constructor(uint a ){
        require(a!=0,"invalid number");
        assert(a!=1);
    }

    function onlyeven(uint b) external pure returns(bool){
        require(b%2==0,"up,revert");
        return true;
    }
}

contract tryCatch{
    event successEvent();
    event catchEvent(string message);
    event catchByte(bytes data);
    onlyEven oe;
    constructor(){
        oe = new onlyEven(2);
    }
    function execute(uint num) public  returns(bool success){
        try oe.onlyeven(num){
            emit successEvent();
            success = true;
        }catch Error(string memory reason){
            emit catchEvent(reason);
        }
    }
    这个方法因为已经初始化构造器，所以只有successEvent和catchEvent会被释放
    function exeuteNew(uint a) public returns(bool success){
        try new onlyEven(a) returns(onlyEven oe){
            emit successEvent();
            success = oe.onlyeven(a);
        }catch Error(string memory reason){
            emit catchEvent(reason);
        } catch(bytes memory data){
            emit catchByte(data);
        }
    }
}
//new onlyEven会涉及到初始化构造器，在初始化构造器会校验0，1，assert返回的不是error类型，不会被Error捕获，会在catchBytes

### 2024.10.04
contract ERC20 is IERC20{  
    // 定义一个映射来存储每个账户的余额  
    mapping(address=>uint256) public override balanceOf;  
    // 定义一个嵌套映射来存储每个账户授权给其他账户的代币额度  
    mapping(address=>mapping(address=>uint256)) public override allowance;  
    // 存储代币的总供应量  
    uint256 public override totalSupply;  
    // 代币的名称  
    string public name;  
    // 代币的符号  
    string public symbol;  
    // 代币的小数位数，通常设置为18  
    uint256 public decimal=18;  
  
    // 构造函数，初始化代币的名称和符号  
    constructor(string memory name1,string memory symbol1){  
        name = name1;  
        symbol = symbol1;  
    }  
      
    // 转账函数，从调用者账户向接收者账户转账  
    function transfer(address recipient,uint amount) public override returns(bool){  
        balanceOf[msg.sender] -=amount; // 从发送者账户中扣除金额  
        balanceOf[recipient] +=amount; // 向接收者账户中添加金额  
        // 触发Transfer事件，记录转账信息  
        emit Transfer(msg.sender,recipient, amount);  
        return true; // 转账成功  
    }  
  
    // 授权函数，允许一个账户（spender）从调用者账户中最多花费指定数量的代币  
    function approve(address spender,uint amount) public override returns(bool){  
        allowance[msg.sender][spender] = amount; // 设置授权额度  
        // 触发Approval事件，记录授权信息  
        emit Approval(msg.sender,spender,amount);  
        return true; // 授权成功  
    }  
  
    // 从一个账户向另一个账户转账，但这次转账是基于之前设置的授权额度  
    function transferFrom(address sender,address recipient,uint amount) public override  returns(bool){  
        require(allowance[sender][msg.sender] >= amount, "ERC20: transfer amount exceeds allowance"); // 检查授权额度是否足够  
        allowance[sender][msg.sender] -= amount; // 减少授权额度  
        balanceOf[sender] -= amount; // 从发送者账户中扣除金额  
        balanceOf[recipient] +=amount; // 向接收者账户中添加金额  
        // 触发Transfer事件，记录转账信息  
        emit Transfer(sender, recipient, amount);  
        return true; // 转账成功  
    }  
  
    // 铸币函数，只有合约外部可以调用，用于向调用者账户增加代币  
    function mint(uint amount) external {  
        balanceOf[msg.sender] +=amount; // 向调用者账户增加代币  
        totalSupply+=amount; // 更新总供应量  
        // 触发Transfer事件，记录从地址0（通常代表“无”或“创建”）到调用者账户的铸币信息  
        emit Transfer(address(0),msg.sender,amount);  
    }  
  
    // 烧币函数，只有合约外部可以调用，用于从调用者账户销毁代币  
    function burn(uint amount) external {  
        require(balanceOf[msg.sender] >= amount, "ERC20: burn amount exceeds balance"); // 检查调用者账户余额是否足够  
        balanceOf[msg.sender]-=amount;   
        totalSupply -= amount; // 更新总供应量  
        // 触发Transfer事件，记录从调用者账户到地址0（销毁）的烧币信息  
        // 注意：原代码中的balanceOf[msg.sender]+=amount是错误的，应为减少，但为保持原样，此处注释说明  
        emit Transfer(msg.sender, address(0), amount);  
    }  
}

### 2024.10.05
import "./ERC20.sol";
contract Faucet{

    uint public amountAllowed=100;
    address public tokenContract;
    mapping(address=>bool) public requestedAddress;

    event SendToken(address indexed Receiver,uint indexed Amount);

    constructor(address _tokenContract){
        tokenContract = _tokenContract;
    }
    //用户领取代币操作
    function requestTokens()external {
        require(!requestedAddress[msg.sender],"only once"); //每个账户只能领取一次
        IERC20 token = IERC20(tokenContract);
        require(token.balanceOf(address(this))>amountAllowed,"Faucet empty");
        token.transfer(msg.sender, amountAllowed); //发送代币
        requestedAddress[msg.sender] = true;
        emit SendToken(msg.sender, amountAllowed);
    }
}    
代币水龙头发送代币，需要校验地址是否领取，代币是否已发放完



### 2024.10.06
import "./ERC20.sol";
//批量发送代币
contract AirDrop{
    mapping(address=>uint) failTransferList;
    function multiTransferToken(address _token,address[] calldata _address,uint256[] calldata _amount)external {
        require(_address.length == _amount.length,"length is not equal");
        IERC20 token = IERC20(_token);
        uint _amountSum = getSum(_amount);
        require(token.allowance(msg.sender, address(this))>_amountSum,"need approve token amount");

        for(uint i=0;i<_address.length;i++){
            token.transferFrom(msg.sender, _address[i], _amount[i]);
        }
    }

    //向多个地址转移ETF
    function multiTransferETH(address payable[] calldata _address,uint [] calldata _amount) public payable {
        require(_address.length== _amount.length,"must be equal");//校验长度
        // for循环，利用transfer函数发送ETH
        for(uint i=0;i<_address.length;i++){
           (bool success,) = _address[i].call{value: _amount[i]}("");//call发送ETH
           if(!success){
            failTransferList[_address[i]] = _amount[i];
           }
        }
    }

    //失败后重试
    function withdrawFromFailList(address _to)public{
        uint failAmount = failTransferList[_to];
        require(failAmount>0,"the address not fail");
        failTransferList[_to] = 0;//先将这个地址职位空
        (bool success,) = _to.call{value:failAmount}("");
        require(!success,"fail withdraw");
    }

   
    function getSum(uint[] calldata _arr) public pure returns(uint sum){
        for (uint i=0;i<_arr.length;i++){
            sum = sum+_arr[i];
        }
    }

}

### 2024.10.07

ERC165检查了合约是否实现了ERC721,ERC1155的接口
import "./ierc165.sol";
contract erc721 is ierc165{
    function supportsInterface(bytes4 interfaceId)  external pure override  returns(bool){
        return interfaceId == type(ierc165).interfaceId;
    }
}

先直接实现下这个接口，但是会报错需要将erc721设置成abstract，明天待续

### 2024.10.08

ERC721用tokenId表示非同质化的代币，所以转账和授权都需要携带tokenId
学习精准授权
    function _approve(address owner,address to,uint tokenId) private{
        _tokenApprovals[tokenId] =to;
        emit Approval(owner,to,tokenId);
    }

    function approve(address to ,uint tokenId)external override {
        address owner = _owners[tokenId];
        require(msg.sender==owner || _operatorApprovals[msg.sender][to],"not owner nor approval all");
        _approve(owner, to, tokenId);
    }
 批量授权
    function setApprovalForAll(address operator, bool approved) external override {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
查询授权地址
    function getApproved(uint tokenId) external view override returns(address){
        require(_owners[tokenId] != address(0),"token not exist");
        return _tokenApprovals[tokenId];
    }

### 2024.10.09
function _checkOnERC721Received(address from,address to,uint tokenId,bytes memory data) private{
        if(to.code.length>0){
            try IERC721Receiver(to).onERC721Received(msg.sender,from,tokenId,data) returns(bytes4 retval){
                if(IERC721Receiver.onERC721Received.selector != retval){
                    revert ERC721InvalidReceiver(to);
                }
            }catch (bytes memory reason){
                if(reason.length == 0){
                    revert ERC721InvalidReceiver(to);
                }else{
                    assembly{
                        revert(add(32,reason),mload(reason))
                    }
                }
            }
        }
    }
  检测是否实现了IERC721Receiver这个接口，只有实现了这个接口才能进行转账  
 function _safeTransfer(address owner,address from,address to,uint tokenId,bytes memory _data) private {
        _transfer(owner,from,to,tokenId);
        _checkOnERC721Received(from,to,tokenId,_data);
    }
  上边校验通过后，进行transfer操作  

### 2024.10.10
function mint(address to,uint tokenId) internal  virtual{
        require(to != address(0),"mint to zero address"); //不可以是空的地址，不然会失败
        require(_owners[tokenId] == address(0),"token already mint"); //第一次铸币，tokenId没有对应的地址
        _balances[to] +=1; //更新代币地址的余额
        _owners[tokenId] = to; //建立对应关系
        emit Transfer(address(0),to,tokenId); //释放事件，记录日志
    }

    function burn(uint tokenId) internal  virtual{
        address owner = ownerOf(tokenId); //根据tokenId找地址
        require(msg.sender == owner,"must be owner");
        _approve(owner, address(0), tokenId); //授权
        _balances[owner] -=1; //减余额
        delete _owners[tokenId]; //置空
        emit Transfer(owner,address(0),tokenId);

    }
    学习了铸币和销毁币的操作


### 2024.10.11
荷兰拍卖，代币的价格会随着时间从大到小依次递减
function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // 检查是否设置起拍时间，拍卖是否开始
        require(
        totalSupply() + quantity <= COLLECTION_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // 检查是否超过NFT上限

        uint256 totalCost = getAuctionPrice() * quantity; // 计算mint成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 检查用户是否支付足够ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多余ETH退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); //注意一下这里是否有重入的风险
        }
    }
    还可以手动设置拍卖的价格
    function setAuctionStartTime(uint32 timestamp) external onlyOwner {
        auctionStartTime = timestamp;
    }



### 2024.10.12
function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费
        require(
        _saleStartTime != 0 && block.timestamp >= _saleStartTime,
        "sale has not started yet"
        ); // 检查是否设置起拍时间，拍卖是否开始
        require(
        totalSupply() + quantity <= COLLECTOIN_SIZE,
        "not enough remaining reserved for auction to support desired mint amount"
        ); // 检查是否超过NFT上限

        uint256 totalCost = getAuctionPrice() * quantity; // 计算mint成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 检查用户是否支付足够ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多余ETH退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); //注意一下这里是否有重入的风险
        }
    }

项目方取出筹集的ETH：项目方可以通过withdrawMoney()函数提走拍卖筹集的ETH。
    // 提款函数，onlyOwner
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}(""); // call函数的调用方式详见第22讲
        require(success, "Transfer failed.");
    }





   ### 2024.10.14
   哈希树是自下而上的加密树，一个字节的hash值来自于子节点的hash
   verify()函数：利用proof数来验证leaf是否属于根为root的Merkle Tree中，如果是，则返回true。它调用了processProof()函数。
   processProof()函数：利用proof和leaf依次计算出Merkle Tree的root。它调用了hashPair()函数。
   hashPair()函数：用keccak256()函数计算非根节点对应的两个子节点的哈希（排序后）

   function hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return a < b ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
    }


   ### 2024.10.15
   function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
        // 哈希的长度为32
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
    hash签名，还可用web3签名

   ### 2024.10.17
   学习了nft常用的交易逻辑：挂单list、撤单revoke、修改价格update、购买purchase
   交易主体就是订单
   function purchase(address _nftAddr, uint256 _tokenId) payable public {
        Order storage _order = nftList[_nftAddr][_tokenId]; // 取得Order        
        require(_order.price > 0, "Invalid Price"); // NFT价格大于0
        require(msg.value >= _order.price, "Increase price"); // 购买价格大于标价
        // 声明IERC721接口合约变量
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this), "Invalid Order"); // NFT在合约中

        // 将NFT转给买家
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 将ETH转给卖家，多余ETH给买家退款
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value-_order.price);

        delete nftList[_nftAddr][_tokenId]; // 删除order

        // 释放Purchase事件
        emit Purchase(msg.sender, _nftAddr, _tokenId, _order.price);
    }

    
  
<!-- Content_END -->
