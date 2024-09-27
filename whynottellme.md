---
timezone: Asia/Shanghai
---
# whynottellme
1. 大家好！我在这次学习之前只有一点python脚本的使用经验，对区块链也只有初步的了解。我从9月中旬开始尝试学习web3编程，刚好碰上这次残酷共学，我相信这是一个非常好的学习机会。
2. 一定会。
   
## Notes

<!-- Content_START -->

### 2024.09.23
####  1. Hello Web3
`Solidity`是用于编写智能合约的语言，有两个特点：1、基于对象；2、高级。

开发工具：`Remix`。 是以太坊官方推荐的IDE，可以在浏览器中直接运行或安装在本地。

网址：https://remix.ethereum.org

```
// SPDX-License-Identifier: MIT
// 上一行是注释，说明代码所使用的软件许可（license），这里使用的是 MIT 许可
pragma solidity ^0.8.21;
// 上一行声明源文件所使用的 Solidity 版本。本例中表示源文件将不允许小于 0.8.21 版本或大于等于 0.9.0 的编译器编译（第二个条件由 ^ 提供）
contract HelloWeb3{
    string public _string = "Hello Web3!";
}
```

编译并部署代码：
 - 在 `Remix` 编辑代码的页面，按 `Ctrl + S` 即可编译代码。
 - 编译完成后，点击左侧菜单的“部署”按钮，进入部署页面。点击 `Deploy`（黄色按钮），即可部署我们编写的合约。


### 2024.09.24
####  2. 值类型
##### 值类型(Value Type)
这类变量赋值时候直接传递数值
1. 布尔型
2. 整型
   ```
   int public _int = -1; // 整数，包括负数
   uint public _uint = 1; // 正整数，uint默认为uint256
   uint256 public _number = 20220330; // 256位正整数
   ```
3. 地址类型
   存储一个 20 字节的值（以太坊地址的大小）
4. 字节数组
   分为定长和不定长2种
5. 枚举 enum
   主要用于为 uint 分配名称，使程序易于阅读和维护。它与 C 语言 中的 enum 类似，使用名称来代替从 0 开始的 uint。是一个比较冷门的变量，几乎没什么人用。
   ```
   // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
   enum ActionSet { Buy, Hold, Sell }
   // 创建enum变量 action
   ActionSet action = ActionSet.Buy;
   // enum可以和uint显式的转换,并会检查转换的正整数是否在枚举的长度内，否则会报错
   function enumToUint() external view returns(uint){
       return uint(action);
   }
   ```
##### 引用类型(Reference Type)
这类变量占空间大，赋值时候直接传递地址（类似指针）
##### 映射类型(Mapping Type)
存储键值对，可以理解为哈希表

### 2024.09.26
####  3. 函数
`function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]`

 - `function`：声明函数时的固定用法

- `<function name>`：函数名。

- `(<parameter types>)`：参数(变量类型和名称)

- `{internal|external|public|private}`：函数可见性说明符，共有4种。
   1. `public`：内部和外部均可见。
   2. `private`：只能从本合约内部访问，继承的合约也不能使用。
   3. `external`：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
   4. `internal`: 只能从合约内部访问，继承的合约可以用。
   - 定义函数时需要明确指定可见性，没有默认值。
   - 定义状态变量时可不指定，默认为`internal`。`public|private|internal` 可用于修饰状态变量。public变量会自动生成同名的`getter`函数，用于查询数值。
- `[pure|view|payable]`：决定函数权限/功能的关键字。
   - `payable`运行的时候可以给合约转入ETH。
   - `pure`函数既不能读取也不能改写状态变量。
   - `view`函数可以读取状态变量。

- `[returns ()]`：函数返回的变量类型和名称。
<!-- Content_END -->
