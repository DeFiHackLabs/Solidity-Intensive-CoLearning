---
timezone: Asia/Shanghai
---

---

# Kurt

1. 自我介绍
java程序员转web3,啥都想学
2. 你认为你会完成本次残酷学习吗？
   会
## Notes

<!-- Content_START -->
### 2024.09.23
今天复习solidity-101，重温一下solidity基础部分，把solidity-101测试题全部做到100%。记录一下
![image](https://github.com/user-attachments/assets/b532428b-953a-4a66-9171-f5b78dd70f5c)

### 2024.09.24
16. 函数重载
Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。

在调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错。下面这个例子有两个叫f()的函数，一个参数为uint8，另一个为uint256：
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}

我们调用f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。

17. 库合约
库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在。库合约是一系列的函数合集，由大神或者项目方创作，咱们站在巨人的肩膀上，会用就行了。

他和普通合约主要有以下几点不同：

不能存在状态变量
不能够继承或被继承
不能接收以太币
不可以被销毁
需要注意的是，库合约重的函数可见性如果被设置为public或者external，则在调用函数时会触发一次delegatecall。而如果被设置为internal，则不会引起。对于设置为private可见性的函数来说，其仅能在库合约中可见，在其他合约中不可用。

如何使用库合约
我们用Strings库合约的toHexString()来演示两种使用库合约中函数的办法。

利用using for指令

指令using A for B;可用于附加库合约（从库 A）到任何类型（B）。添加完指令后，库A中的函数会自动添加为B类型变量的成员，可以直接调用。注意：在调用的时候，这个变量会被当作第一个参数传递给函数：

// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}

Copy
通过库合约名称调用函数

// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
18. Import
在Solidity中，import语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。本教程将向你介绍如何在Solidity中使用import语句。

import用法
1.通过源文件相对位置导入，例子：

// 通过文件相对位置import
import './Yeye.sol';

2.通过源文件网址导入网上的合约的全局符号，例子：

// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

3.通过npm的目录导入，例子：

import '@openzeppelin/contracts/access/Ownable.sol';

4.通过指定全局符号导入合约特定的全局符号，例子：

import {Yeye} from './Yeye.sol';

5.引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前。

### 2024.09.25

### 2024.09.26

### 2024.09.27

### 2024.09.28

### 2024.09.29

### 2024.09.30

<!-- Content_END -->
