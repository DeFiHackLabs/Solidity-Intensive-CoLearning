---
timezone: Asia/Shanghai
---


# YourName

1. 自我介绍

大家好，我是bayazi。开始入门区块链。

2. 你认为你会完成本次残酷学习吗？

会完成的
   
## Notes

<!-- Content_START -->

### 2024.09.23

完成了1~10

Solidity中的变量类型：

1.值类型(Value Type)

2.引用类型(Reference Type)

3.映射类型(Mapping Type):

函数：

public：内部和外部均可见。

private：只能从本合约内部访问，继承的合约也不能使用。

external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。

internal: 只能从合约内部访问，继承的合约可以用。

注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。

注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。

[pure|view|payable]：决定函数权限/功能的关键字

包含 pure 和 view 关键字的函数是不改写链上状态的，因此用户直接调用它们是不需要付 gas 的（注意，合约中非 pure/view 函数调用 pure/view 函数时需要付gas）。

pure：既不能读取也不能写入链上的状态变量

view：能读取但也不能写入状态变量

returns：跟在函数名后面，用于声明返回的变量类型及变量名。

return：用于函数主体中，返回指定的变量。

可以在 returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值

存储位置：

Solidity数据存储位置有三类：storage，memory和calldata。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少

1.storage：合约里的状态变量默认都是storage，存储在链上。

2.memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。

3.calldata：不可变的memory

变量的作用域：

1.状态变量：在合约内、函数外声明，存储在链上

2.局部变量：函数执行过程中有效的变量，在内存中

3.全局变量：全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用

（一个文件内好像只能部署最先的合约？，05运行的时候只显示了DataStorage）

数组array

固定长度数组：T[k]

可变长度数组（动态数组）：T[]

bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

数组成员

length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。

push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。

push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。

pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。

映射Mapping

声明映射的格式为mapping(_KeyType => _ValueType)

_KeyType只能选择Solidity内置的值类型，_ValueType可以使用自定义的类型

映射的存储位置必须是storage

如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value

给映射新增的键值对的语法为_Var[_Key] = _Value

delete a会让变量a的值变为初始值。

插入排序

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Sort {

    function sort(uint[] memory a) public pure returns(uint[] memory){
        for(uint i = 1; i < a.length; i++){
            uint j = i;
            while (j > 0) {
                if (a[j-1] > a[j]){
                    uint temp = a[j - 1];
                    a[j - 1] = a[j];
                    a[j] =  temp;
                }
                else {
                    break;
                }
                j--;
            }
        }
        return(a);
    }
}
```

<!-- Content_END -->
