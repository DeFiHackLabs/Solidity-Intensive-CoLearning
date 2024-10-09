---
timezone: Asia/Shanghai
---

# MrF

1. 一个有拖延症的程序员

2. 可以的
   

<!-- Content_START -->
### 2024.09.23
1 学习什么是Solidity 以及Remix工具
新建了第一个 HelloWeb3 程序


### 2024.09.24

1 学习了101 第二章
知识点 1：Solidity中的变量类型 值类型  引用类型 映射类型
      2：address 与 payable address 的区别
      3：uint256（256位正整数） uint（正整数） int（整数，包括负数）  的区别


### 2024.09.25

1 学习了101 第三章
知识点 1：public：内部和外部均可见。
        private：只能从本合约内部访问，继承的合约也不能使用。
        external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
        internal: 只能从合约内部访问，继承的合约可以用。
      2： pure 与  view  关键字的区别 payable代表的意思。
      3: https://github.com/DeFiHackLabs/Solidity-Intensive-CoLearning/blob/MrF/content/MrF/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20240925234418.png

### 2024.09.26

1 学习了101 第四章
知识点 1 returns：跟在函数名后面，用于声明返回的变量类型及变量名。
        return：用于函数主体中，返回指定的变量。
      2 命名式返回  解构式赋值  两者区别

### 2024.09.28

1 学习了101 第五章 第六章
知识点 1 引用类型(Reference Type)：包括数组（array）和结构体（struct）
      2 存储位置有三类：storage，memory和calldata  三者区别点 gas 消耗
      3 状态变量（state variable），局部变量（local variable）和全局变量(global variable) 三者作用域的区别

第六章 知识点
      1 引用类型, array, struct 的基本用法
      2 创建数组的规则 有动态数组与固定长度数组区别

### 2024.09.29

1 学习了101 第七章
知识点 1 映射类型 mapping 映射的_KeyType只能选择Solidity内置的值类型，而_ValueType可以使用自定义的类型
      2 映射的存储位置必须是storage 
      3学习映射的原理 映射不储存任何键（Key）的资讯，也没有length的资讯， 初始值都是各个type的默认值，如uint的默认值是0。

### 2024.10.01

1 学习了101 第八章
知识点 1 映射mapping: 所有元素都为其默认值的mapping
        结构体struct: 所有成员设为其默认值的结构体
        数组array 动态数组: [] 静态数组（定长）: 所有成员设为其默认值的静态数组
      2 delete a会让变量a的值变为初始值


### 2024.10.02

1 学习了101 第九章 常数 constant和immutable
  知识点
   1 不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。
   2 只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable
   3 初始化之后，尝试改变它的值，会编译不通

   第十章  控制流
  知识点
  1  学习了 if-else  for循环 while循环 do-while循环 三元运算符
  2 插入算法中，变量j有可能会取到-1，引起报错

  第十一章 构造函数和修饰器
  
  1  构造函数（constructor），每个合约可以定义一个，并在部署合约的时候自动运行一次。它可以用来初始化合约的一些参数
  2  修饰器 modifier 的主要使用场景是运行函数前的检查，减少代码冗余。


### 2024.10.03

1 学习了101 第十二章 事件 Event
知识点
1 两个特点 可以通过RPC接口订阅和监听这些事件，并在前端做响应。 再就是经济 Gas少
2 每条日志记录都包含主题topics和数据data两部分
3 日志的主题： 长度：不能超过 4。 第一个元素：事件的签名哈希。 剩余元素：至多 3 个 indexed 参数（用于筛选和检索）。
4 indexed 参数： 作用：相当于事件的索引键，用于快速搜索和查询。 大小限制：每个 indexed 参数固定为 256 位。 超长参数处理：如果参数（如字符串）太长，会自动哈希化并存储。
5 数据 data  事件中不带 indexed的参数会被存储在 data 部分

 第十三章 继承
知识点
1 继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承
2 virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
  override：子合约重写了父合约中的函数，需要加上override关键字。
3 多重继承 继承时要按辈分最高到最低的顺序排 



### 2024.10.04

1 学习了101 第十四章 抽象合约和接口
知识点
1 接口
不能包含状态变量
不能包含构造函数
不能继承除接口外的其他合约
所有函数都必须是external且不能有函数体
继承接口的非抽象合约必须实现接口定义的所有功能
2 抽象合约
未实现的函数需要加virtual，以便子合约重写。合约标为abstract

2 十五章 异常
1 在执行当中，error必须搭配revert（回退）命令使用。
2 require(检查条件，"异常的描述")，gas随着描述异常的字符串长度增加
3 assert(检查条件），当检查条件不成立的时候，就会抛出异常
4 error方法gas最少，其次是assert，require方法消耗gas最多

十六章  函数重载
1 名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数

十七章 库合约
1 库合约是一种特殊的合约，为了提升Solidity代码的复用性和减少gas而存在
2 不能存在状态变量
不能够继承或被继承
不能接收以太币
不可以被销毁
3 指令using A for B;  通过库合约名称调用函数

十八章 Import
1 倒入方式 通过源文件相对位置导入 ，过源文件网址导入网上的合约的全局符号，通过npm的目录导入  ，通过指定全局符号导入合约特定的全局符号

十九章 接收ETH receive和fallback
 1 使用场景 接收ETH 处理合约中不存在的函数调用（代理合约proxy contract）
 2 msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。

### 2024.10.05
二十章 发送ETH
1 transfer gas限制是2300 如果转账失败，会自动revert
2 send()的gas限制是2300 如果转账失败，不会revert
3 接收方地址.call{value: 发送ETH数额}("") ，无限制 如果转账失败，不会revert


二十一章 调用其他合约
1  调用已部署合约 _Name(_Address).f(）
2 创建合约变量，然后通过它来调用目标函

二十二章 call 详解
1 目标合约地址.call(字节码); 其中字节码利用结构化编码函数abi.encodeWithSignature获得：abi.encodeWithSignature("函数签名", 逗号分隔的具体参数) ，函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)。
2 目标合约地址.call{value:发送数额, gas:gas数额}(字节码);

二十三章 Delegatecall 代理委托
1 代理合约（Proxy Contract）：将智能合约的存储合约和逻辑合约分开 
2 EIP-2535 Diamonds（钻石）：钻石是一个支持构建可在生产中扩展的模块化智能合约系统的标准。

二十四章 二十五章 创建合约

1 CREATE 与 CREATE2 创建合约的区别 CREATE2不需要部署 可以提前计算创建合约地址

### 2024.10.06
二十六章 删除合约

1已经部署的合约无法被SELFDESTRUCT了。
2 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。
3 在坎昆升级前，合约会被自毁。但是在升级后，合约依然存在，只是将合约包含的ETH转移到指定地址，而合约依然能够调用。

二十七章 ABI编码解码

1 ABI常配合call来实现对合约的底层调用
2 ethers.js中常用ABI实现合约的导入和函数调用。
3 对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用

二十八章 Hash
1 Keccak256函数是Solidity中最常用的哈希函数
2 单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
灵敏性：输入的消息改变一点对它的哈希改变很大。
高效性：从输入的消息到哈希的运算高效。
均一性：每个哈希值被取到的概率应该基本相等。
抗碰撞性

二十九章 函数选择器Selector

1 calldata中前4个字节是selector
2 method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数

三十章 Try Catch
1 try-catch只能被用于external函数或创建合约时constructor
2 只能用于外部合约调用和合约创建。
如果try执行成功，返回变量必须声明，并且与返回的变量类型相同


### 2024.10.07
三十一章  ERC20
1 ERC20是以太坊上的代币标准
2 IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件。
三十二章 代币水龙头

水龙头合约中
amountAllowed设定每次能领取代币数量（默认为100，不是一百枚，因为代币有小数位数）。
tokenContract记录发放的ERC20代币合约地址。
requestedAddress记录领取过代币的地址。

三十三章  空投合约
1 利用循环，一笔交易将ERC20代币发送给多个地址。
三十四章 ERC721
1 非同质化代币，授权或转账都要明确tokenId；而ERC20只需要明确转账的数额即可。
2 IERC721是ERC721标准的接口合约，规定了ERC721要实现的基本函数。

三十五章 荷兰拍卖
1 荷兰拍卖（Dutch Auction）是一种特殊的拍卖形式。 亦称“减价拍卖”，它是指拍卖标的的竞价由高到低依次递减直到第一个竞买人应价（达到或超过底价）时击槌成交的一种拍卖。
2 获取拍卖实时价格：getAuctionPrice()函数通过当前区块时间以及拍卖相关的状态变量来计算实时拍卖价格。

三十六章 . 默克尔树
1 erkle Tree是一种自下而上构建的加密树，每个叶子是对应数据的哈希，而每个非叶子为它的2个子节点的哈希。

2 复杂的Merkle Tree可以利用javascript库merkletreejs来生成和管理，链上只需要存储一个根值，非常节省gas。很多项目方都选择利用Merkle Tree来发放白名单。

三十七章 数字签名 Signature
1 数字签名算法叫双椭圆曲线数字签名算法
2 身份认证：证明签名方是私钥的持有人。
不可否认：发送方不能否认发送过这个消息。
完整性：通过验证针对传输消息生成的数字签名，可以验证消息是否在传输过程中被篡改。
3 由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济

### 2024.10.09
三十八章 NFT交易所
1 合约包含4个事件，对应挂单list、撤单revoke、修改价格update、购买purchase这四个行为
2 合约需要实现fallback()函数来接收ETH。

三十九章 链上随机数 
1 链上的全局变量作为种子，利用keccak256()哈希函数来获取伪随机数，并不安全 由于这种方法是最便捷的链上随机数生成方法，大量项目方依靠它来生成不安全的随机数
2 链下生成随机数，然后通过预言机把随机数上传到链上

四十章 ERC1155
1 ERC1155标准，它支持一个合约包含多种代币 多用于gamefi 

四十一章 WETH
1  以太币本身并不符合ERC20标准，包装ETH成为WETH 

<!-- Content_END -->