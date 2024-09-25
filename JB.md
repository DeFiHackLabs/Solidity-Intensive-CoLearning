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

### 2024.09.23
2. 学习payable方法, 手动充值ETH。
![image](https://github.com/user-attachments/assets/1754e61f-5dc7-44e9-82cc-e0b2a4537a07)

2024.09.24
#今天学习了函数的输出，可以同时输出多种不同类型。下面是在remix中练习。
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

    ![image](https://github.com/user-attachments/assets/c31a3b3c-569d-42ec-9cf1-9c0fe3a5c4fc)



}
<!-- Content_END -->
