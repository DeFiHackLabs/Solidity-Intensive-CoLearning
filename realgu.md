---
timezone: Asia/Shanghai
---

---

# realgu

1. 自我介绍  
   TradFi Dev  

3. 你认为你会完成本次残酷学习吗？  
   会，下死命令
   
## Notes

<!-- Content_START -->

### 2024.09.23
这部分之前学过，快速过一遍，记一下有趣的地方
1. // SPDX-License-Identifier: MIT 注释不写会有warning
2. 在 Remix 编辑代码的页面，按 Ctrl + S 即可编译代码
3. 三种整型：int uint uint256
4. payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账
5. 在以太坊中，以下语句被视为修改链上状态：
-写入状态变量。
-释放事件。
-创建其他合约。
-使用 selfdestruct.
-通过调用发送以太币。
-调用任何未标记 view 或 pure 的函数。
-使用低级调用（low-level calls）。
-使用包含某些操作码的内联汇编。
6. pure 函数既不能读取也不能写入链上的状态变量
7. view函数能读取但也不能写入状态变量
8. 非 pure 或 view 的函数既可以读取也可以写入状态变量

### 2024.09.24
1. returns：跟在函数名后面，用于声明返回的变量类型及变量名。return：用于函数主体中，返回指定的变量。
2. 命名式返回（第一次见到）
3. storage：合约里的状态变量默认都是storage，存储在链上。
4. memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
5. calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。
6. storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
7. [全局变量列表](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)
8. bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

### 2024.09.25
1. 声明映射的格式为mapping(_KeyType => _ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型
2. 映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型
3. 映射的存储位置必须是storage
4. 声明但没赋值的变量都有它的初始值或默认值
5. delete a会让变量a的值变为初始值
6. constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。
7. immutable变量可以在声明时或构造函数中初始化
8. Solidity中最常用的变量类型是uint，也就是正整数，取到负值的话，会报underflow错误。而在插入算法中，变量j有可能会取到-1，引起报错。这里，我们需要把j加1，让它无法取到负值。

### 2024.09.26
1. 注意：构造函数在不同的Solidity版本中的语法并不一致，在Solidity 0.4.22之前，构造函数不使用 constructor 而是使用与合约名同名的函数作为构造函数而使用，由于这种旧写法容易使开发者在书写时发生疏漏（例如合约名叫 Parents，构造函数名写成 parents），使得构造函数变成普通函数，引发漏洞，所以0.4.22版本及之后，采用了全新的 constructor 写法。
2. event Transfer(address indexed from, address indexed to, uint256 value);
3. 每条日志记录都包含主题topics和数据data两部分
4. 可以在测试网sepolia发event，在etherscan看到

### 2024.09.27
1. virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。override：子合约重写了父合约中的函数，需要加上override关键字。
2. 继承时要按辈分最高到最低的顺序排，contract Erzi is Yeye, Baba
3. 修饰器（Modifier）同样可以继承，用法与函数继承类似，在相应的地方加virtual和override关键字即可。
4. 在这个例子中，调用合约people中的super.bar()会依次调用Eve、Adam，最后是God合约。虽然Eve、Adam都是God的子合约，但整个过程中God合约只会被调用一次。


### 2024.09.28
接口类似于抽象合约，但它不实现任何功能。接口的规则：  
- 不能包含状态变量  
- 不能包含构造函数  
- 不能继承除接口外的其他合约  
- 所有函数都必须是external且不能有函数体  
- 继承接口的非抽象合约必须实现接口定义的所有功能
  
如果我们知道一个合约实现了IERC721接口，我们不需要知道它具体代码实现，就可以与它交互。  

1. error必须搭配revert（回退）命令使用。
2. gas随着描述异常的字符串长度增加，比error命令要高。使用方法：require(检查条件，"异常的描述")
3. 我们可以看到，error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas，大家要多用！

<!-- Content_END -->
