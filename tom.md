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

### 2024.09.27

#### 变量数据存储和作用域

- 引用类型 数组和结构体
- 数据存储类型有三类: storage 、 memory、calldata 
- storage存储在链上，gas高
- memory、calldata存储在内存中gas低
#### 用法
- storage：合约里的状态变量默认都是storage，存储在链上。

- memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。

- calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract VarTest{

    function testCallData(int[] calldata a) public pure returns(int b){
       return (a[0]);
    }


    uint[] public uArray = [1,2,3];

    function testVar() public {
        uint[] storage bArray = uArray;
        bArray[0] = 6;
    }

    //状态变量
    int a = -1;


    //局部变量
    function testVar22() external pure {
        uint b = 2;
    }

    //全局变量
    function testGlobal() public view{
        address a = msg.sender;
        uint blockId = block.number;
    }

    // 以太单位
    //solidity 不包含小数，以0作为代替，方便计算
    // wei:1
    // gwei: 1e9 = 100000000
    // ether: 1e18 = 100000000000000000

    function weiUnit() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns (uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure  returns (uint) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

}
```


### 

### 2024.09.28
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ArrayTest{

    /**
    * 数组 array
    数组（Array）是Solidity常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种
    **/

    //固定长度
    int[4] a;
    bytes1[5] b;
    address[100]  c;

    //可变长度  方框中不声明长度
    int[] a1;
    bytes1[] b2;
    address[] c3;
    bytes d;

    //创建数组需要使用的规则 使用memory修饰, 可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变
    function f() public pure {
        uint[] memory array8 = new uint[](5);    

        //创建动态数组
        uint[] memory dArray = new uint[](5);
        dArray[0] = 1;
        dArray[1] = 2;
        dArray[2] = 3;

        // 数组成员 
        uint len = dArray.length; //长度
        // dArray.push(); //动态数组拥有push(x)成员，可以在数组最后添加一个x元素
        // dArray.pop(); //移除最后一个元素
    }


     // 结构体 struct  Solidity支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法
     //跟java中类的概念相似
     // 结构体

    struct Student{
        uint256 id;
        uint256 score; 
    }

    Student student; // 初始一个student结构体

    //  给结构体赋值
    // 方法1:在函数中创建一个storage的struct引用
    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

    
    
}
```
###

### 2024.09.29
## 映射Mapping

在映射中，人们可以通过键（`Key`）来查询对应的值（`Value`），比如：通过一个人的`id`来查询他的钱包地址。

声明映射的格式为`mapping(_KeyType => _ValueType)`，其中`_KeyType`和`_ValueType`分别是`Key`和`Value`的变量类型。例子：

```solidity
mapping(uint => address) public idToAddress; // id映射到地址
mapping(address => address) public swapPair; // 币对的映射，地址到地址
```
###

<!-- Content_END -->
