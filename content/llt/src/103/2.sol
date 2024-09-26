// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    // // 固定长度
    // uint256[5] arr1;

    // // 可变
    // uint256[] arr2;

    // // 固长 + 可变
    // uint256[] arr3 = new uint256[](5);

    // function change() external {
    //     arr1[0] = 5;
    //     arr1[1] = 6;
    //     arr1[2] = 7;

    //     arr2.push();
    //     arr2.push(5);

    //     arr3[0] = 5;
    //     arr3[1] = 6;
    //     arr3[2] = 7;
    //     arr3.push(78);
    // }

    // function changePop() external {
    //     arr2.pop();
    // }

    // function getArr1() external view returns (uint256[5] memory) {
    //     return arr1;
    // }

    // function getArr2() external view returns (uint256[] memory) {
    //     return arr2;
    // }

    // function getArr3() external view returns (uint256[] memory) {
    //     return arr3;
    // }

    // 结构体
    struct Person {
        string name;
        uint256 age;
    }

    Person public person; // 初始一个person结构体

    // 四种方法结构体赋值
    function change1() external {
        Person storage _person = person;
        _person.name = "a";
        _person.age = 22;
    }

    function change2() external {
        person.name = "b";
        person.age = 23;
    }

    function change3() external {
        person = Person("c", 24);
    }

    function change4() external {
        person = Person({
            name:"d",
            age: 25
        });
    }
}
