---
timezone: Asia/Shanghai
---

---

# Tom

1. 自我介绍
我叫Tom,我来学习solidity,加油

2. 你认为你会完成本次残酷学习吗？
   我坚信我会
   
## Notes

<!-- Content_START -->


### 2024.09.23

主要学习知识点: solidity的格式
- 1. 以软件许可作为每个sol文件的开头(标准格式)
- 2. 声明solidity的版本,为了更好的兼容语法,比如 0.8.21代表只兼容这个版本,还可以使用版本区间,来表明大于某个版本，或小于某个版本
- 3. 学习了合约代码以什么关键字开头，contract为关键字，然后定义这个合约的名称(跟java定义类的方式基本一致)
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

//合约开头许定义关键字
contract Helloworld3{
    string public _a = "hello world3 2024.09.23";
}
```
### 

### 2024.09.24
主要学习知识点: solidity的格式
- 1. 学习了remix开发工具的初步使用, 使用步骤为新建sol文件->编写代码->编译->部署->查看结果(简单的调用public变量获取值)
- 2. 学习了solidity的数据格式,包括bool,int,uint,address,bytes这几种类型,和各自的使用场景
     bool 表示 true/false,  int表示正整数, uint表示负整数 address用来存储 地址， bytes存储字节数组   
```
// 1.布尔类型，true/false
    bool public isSuccess = true;

    //布尔运算
    bool public  b2 = !isSuccess; //取反
    bool public  b3 = isSuccess && b2; //与
    bool public  b4 = isSuccess || b2; //或  短路规则
    bool public  b5 = isSuccess == b2; //是否相等
    bool public  b6 = isSuccess != b2; //是否不等

    // 2.整数
    int public myInt = -5;  //整数 可以表示负数
    uint public myInt2 = 5;  //整数 只表示正整数
    uint256 public maxInt = 23423; //256表示允许存储的字节数

    // 3.运算  +、-、*、/、%、** 、 > < != == <= >=
    int public addCount = myInt + 1;
    uint public addSum = myInt2 + 1;
    int public mins = myInt -3;
    int public c = myInt * 10;
    int public c2 = myInt /2;

    uint public c3 = 7 % 2;

    uint public c4 = myInt2 ** 2;

    bool public isRight = c < c2;

    //4.地址类型 address
    address public myWalletAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public myBalance = myWalletAddress.balance;
    // payable 关键字可以进行转账
    address payable public  payAddress = payable(myWalletAddress);

    uint public myBalance2 = payAddress.balance;

    //5.定长数组和非定长数组   bytes1,bytes2,bytes32      非定长数组bytes
    bytes1 public by1 = "a";
    bytes32 public  by2 = "hellobyte";

```
###

### 2024.09.25

##### 函数
- function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
- 函数的概念在很多语言中都有，js，java，python等，solidity中的函数跟其他的语言很像，包括函数关键字、名称、参数、函数权限关键字、返回值等
  
1. `function`：声明函数时的固定用法。要编写函数，就需要以 `function` 关键字开头。

2. `<function name>`：函数名。

3. `(<parameter types>)`：圆括号内写入函数的参数，即输入到函数的变量类型和名称。

4. `{internal|external|public|private}`：函数可见性说明符，共有4种。

    - `public`：内部和外部均可见。
    - `private`：只能从本合约内部访问，继承的合约也不能使用。
    - `external`：只能从合约外部访问（但内部可以通过 `this.f()` 来调用，`f`是函数名）。
    - `internal`: 只能从合约内部访问，继承的合约可以用。

    **注意 1**：合约中定义的函数需要明确指定可见性，它们没有默认值。

    **注意 2**：`public|private|internal` 也可用于修饰状态变量。`public`变量会自动生成同名的`getter`函数，用于查询数值。未标明可见性类型的状态变量，默认为`internal`。

5. `[pure|view|payable]`：决定函数权限/功能的关键字。`payable`（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。`pure` 和 `view` 的介绍见下一节。

6. `[returns ()]`：函数返回的变量类型和名称。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloFunction {
    // 函数


    // internal,external,public,private

    // public 内部和外部均可见
    function add() public  {
        number += 5;
    }
    //  private 只能从本合约内部访问，外部不可见，继承的合约也不可使用
    function private() private  {
        number += 10;
    }

    // internal 只能从合约内部访问，外部不可见，继承的合约可以使用
    function internal() internal {
        number += 15;
    }

    // external 只能从合约外部访问，但是内部可以通过 this.f()来调用，f是函数名字
    function external() external {
        number += 20;
    }
}

```
### 


<!-- Content_END -->
