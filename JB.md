---
timezone: Asia/Shanghai
---

---

#Lin JianBin

1. 自我介绍
  我是JAVA出身，但目前在新加坡从事ETL工作，想要探索新的方向。

2. 你认为你会完成本次残酷学习吗？
   我必须完成。
   
## Notes
<!-- Content_START -->

### 2024.09.23
学习了函数类型，并在remix上做了一些练习，以下是我的学习内容。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract HelloWeb3{
    string public _string = "Hello Web3!";
    
    uint256 public  number = 5;
    uint public  count=1;
    uint public  balance = 0;

    function add() internal {
        number +=1;
    }

    function addView() external  view returns(uint256 newmuber){
        newmuber = number + 5;
    }

    function addPure(uint256 _number) external pure returns (uint256 new_number)  {
        new_number = _number + 1;
    }

    function addPublic() public {
        count += 5;
    }

    function addExternal() external  {
        count += 5;
    }

    function addPrivate() private {
        count += 5;
    }

    function addInternal() internal {
        count += 5;
    }

    function deposit(  ) internal  {
        balance -= 1;
    }

    function depositPayable() external payable {
        balance += 3;
    }
    
    function depositBalance() external returns(uint balance) {
        deposit();
        balance = address(this).balance;
   }
}
```

### 2024.09.24

2. 学习payable方法, 手动充值ETH。
   
![image](https://github.com/user-attachments/assets/1754e61f-5dc7-44e9-82cc-e0b2a4537a07)

2024.09.24
#今天学习了函数的输出，可以同时输出多种不同类型。下面是在remix中练习。
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract function_practice{
    uint256[3] array;

    //test return mutiple results
    function returnMutiple() public pure returns(uint256, bool, uint256[3] memory){

        return (1,true, [uint256(1),2,4]);
    }
    
    //命名式返回
    function returnMutiple2() public pure returns(uint256 _number, bool _bool, uint256[3] memory
     _array){
        _number = 3;
        _bool = true;
        _array = [uint256(1), 2, 3];
    }

    //命名式返回支持return
    function returnMutiple3() public pure returns (uint256 _number, bool _bool, uint256[3] memory 
    _array){
        return(1, false, [uint256(3), 4, 6]);
    }

    //解构式赋值
    function readFromFuction() public pure returns(uint256 , bool, uint256[3] memory) {
        uint256 _number;
        bool _bool;
        uint256[3] memory _array;
        (_number,_bool, _array ) = returnMutiple();
        return (_number, _bool, _array);
    }
}
```
![image](https://github.com/user-attachments/assets/c31a3b3c-569d-42ec-9cf1-9c0fe3a5c4fc)

### 2024.09.25
1. 学习了变量的数据存储和作用域。以下是在remix上的练习。
   // SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract solidity_start5{
    uint[] xMemory = new uint[] (5);

    uint public _s = 3;
    string private  _string = "a";
    bool private  _bool = true;

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
    //参数为calldata数组，不能被修改
    // _x[0] = 0 //这样修改会报错
    return(_x);
}
    function testStorage() public {
        //此处不能使用pure或view关键字，因为下面的_storage[0]会修改状态变量。
        uint[] storage _storage = xMemory;
        _storage[0] = 3;
    }

    function testStorage2() internal view {
        uint[] memory _storage = xMemory;
        _storage[2] = 4;
    }

    //修改state variable 的值。
    function changeStateVariables() external   {
        _s = 5;
        _string = "JB";
        _bool = false;
    }

    //局部变量
    function declareLocalVariable() external pure returns(uint256 ll) {
        uint _x = 3;
        uint _y = 6;
        ll = _x + _y;
    }

    function globalVariable() public view returns(address, uint, bytes memory) {
        address _address = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return (_address, blockNum, data);
    }

    function weuint() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function guint() external pure returns(uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherTest() external pure returns(uint) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

     //时间单位
    function secondUint() external pure returns(uint){
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUint() external pure returns(uint){
        assert(1 minutes == 60);
        return 1 minutes;
    }

    function hoursUint() external pure returns(uint) {
        assert(1 hours == 3600);
        return 1 hours;
    }
    
    function daysUnit() external pure returns(uint) {
    assert(1 days == 86400);
    assert(1 days == 24 hours);
    return 1 days;
    }

    function weeksUnit() external pure returns(uint) {
    assert(1 weeks == 604800);
    assert(1 weeks == 7 days);
    return 1 weeks;
    }

}
    
   ![image](https://github.com/user-attachments/assets/21b0875e-a9a1-4aed-9bb8-432f39e46b70)
   ![image](https://github.com/user-attachments/assets/09ea5ed9-caf9-4ae5-bb91-021e782ee68f)

### 2024.09.26
1.学习了数组的声明以及赋值方式。
2.学习了struct的声明以及4种赋值方式。和JAVA中的POJO 类很像。
3.如下是做的练习。
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract array_struct {

//结构体
    struct Student{
    uint256 id;
    uint256 score; 
    }
    
    // 初始一个student结构体
    Student public  student;

    //固定长数组
    uint[3] _array1;
    //不固定数组
    uint[] _array2;
    //不固定数组
    uint [] _array3 = new uint[](3);
     //固定长数组
    bytes1[2] _byte1;
     //固定长数组
    address[10] _address;
    bytes array;

    function memory_array() external pure {
        uint[] memory _array4 = new uint[](3);
        _array4[0] = 3;
        _array4[1] = 4;
        _array4[2] = 3;
    
    }

    function callG() public  {
        g([uint(3),3,5]);
    }
    
    
    function g(uint[3] memory _as) public  returns (uint[] memory  ) {
        _array3 = _as;
        _array3.push(3);
        return _array3;
    }
    

    function initStudent1() external  {
        Student storage _student = student;
        _student.id = 11;
        _student.score = 100;
    }

    //直接引用strut。
    function initStudent2() external  {
        student.id = 3;
        student.score = 90;
    }

    //构造函数
    function initStudent3() external  {
        student = Student(3,90);
    }
    
    //key-value形式
    function initStudent4() external   {
        student = Student({id:3,score:40});
    }

}
![image](https://github.com/user-attachments/assets/73680974-14b3-471a-858b-278fc538c978)

总结：对语法不熟悉，对数组修饰符之间的变量赋值影响理解不够深刻。

##2024/09/27
学习了mapping的映射。
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Map{

    mapping (uint => address) public idAddress;
    mapping (address => address) public swaPair;

    // struct Student{
    // uint256 id;
    // uint256 score; 
    // }

    mapping (address => address) public student;

    function writeMap (uint _Key, address _Value) public {
        idAddress[_Key] = _Value;
    }


}



<!-- Content_END -->