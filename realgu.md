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


### 2024.09.29
开始102  
1. Solidity中允许函数进行重载（overloading），即名字相同但输入参数类型不同的函数可以同时存在，他们被视为不同的函数。注意，Solidity不允许修饰器（modifier）重载。
2. 我们调用f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。
3. 库合约和普通合约主要有以下几点不同：  
- 不能存在状态变量
- 不能够继承或被继承
- 不能接收以太币
- 不可以被销毁
4. 常用的库  Strings：将uint256转换为String  
Address：判断某个地址是否为合约地址  
Create2：更安全的使用Create2 EVM opcode  
Arrays：跟数组相关的库合约
5. import四种用法
6. receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable   
7. fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。
8. 合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错（你仍可以通过带有payable的函数向合约发送ETH）。
9. Solidity有三种方法向其他合约发送ETH，他们是：transfer()，send()和call()，其中call()是被鼓励的用法。

### 2024.09.30
1. 我们可以利用合约的地址和合约代码（或接口）来创建合约的引用：_Name(_Address)，其中_Name是合约名，应与合约代码（或接口）中标注的合约名保持一致，_Address是合约地址。然后用合约的引用来调用它的函数：_Name(_Address).f()，其中f()是要调用的函数。
2. OtherContract(_Address).setX(x);
3. _Address.getX();
4. OtherContract oc = OtherContract(_Address);x = oc.getX();
5. OtherContract(otherContract).setX{value: msg.value}(x);
6. 目标合约地址.call(字节码);
7. 字节码 = abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
8. 函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)
9. call不是调用合约的推荐方法，因为不安全。但他能让我们在不知道源代码和ABI的情况下调用目标合约，很有用。

### 2024.10.02
1. 此时，调用合约B中的callSetVars，传入参数为合约C地址和10。运行后，合约C中的状态变量将被修改：num被改为10，sender变为合约B的地址
2. 由于是delegatecall，上下文为合约B。在运行后，合约B中的状态变量将被修改：num被改为100，sender变为你的钱包地址。合约C中的状态变量不会被修改。
3. B call C，上下文为C；而B delegatecall C，上下文为B
4. delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额
5. create的用法很简单，就是new一个合约，并传入新合约构造函数所需的参数：Contract x = new Contract{value: _value}(params)
6. 其中Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数。

### 2024.10.03
1. CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。
2. create2的实际应用场景  
- 交易所为新用户预留创建钱包合约地址。  
- 由 CREATE2 驱动的 factory 合约，在Uniswap V2中交易对的创建是在 Factory中调用CREATE2完成。这样做的好处是: 它可以得到一个确定的pair地址, 使得 Router中就可以通过 (tokenA, tokenB) 计算出pair地址, 不再需要执行一次 Factory.getPair(tokenA, tokenB) 的跨合约调用。
3. 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
4. selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址
5. abi.encode:将每个参数填充为32字节的数据，并拼接在一起。如果你要和合约交互，你要用的就是abi.encode。
6. 当你想省空间，并且不与合约交互的时候，可以使用abi.encodePacked，例如算一些数据的hash时
7. abi.encodeWithSignature: 与abi.encode功能类似，只不过第一个参数为函数签名，比如"foo(uint256,address,string,uint256[2])"。当调用其他合约的时候可以使用。
8. abi.encodeWithSelector: 与abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。  
  
一个好的哈希函数应该具有以下几个特性：  

单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。  
灵敏性：输入的消息改变一点对它的哈希改变很大。  
高效性：从输入的消息到哈希的运算高效。  
均一性：每个哈希值被取到的概率应该基本相等。  
抗碰撞性：  
弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。  
强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。  

sha3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。所以SHA3就和keccak计算的结果不一样，这点在实际开发中要注意。  
以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。  

### 2024.10.04
1. msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）。
2. 前4个字节为函数选择器selector，后面32个字节为输入的参数
3. 注意，在函数签名中，uint和int要写为uint256和int256。
4. 映射类型参数通常有：contract、enum、struct等。在计算method id时，需要将该类型转化成为ABI类型。例如，如下函数mappingParamSelector中DemoContract需要转化为address，结构体User需要转化为tuple类型(uint256,bytes)，枚举类型School需要转化为uint8。因此，计算该函数的method id的代码为bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"))。
5. try-catch只能被用于external函数或创建合约时constructor
6. 只能用于外部合约调用和合约创建。
7. 如果try执行成功，返回变量必须声明，并且与返回的变量类型相同。
8. SuccessEvent是调用成功会释放的事件，而CatchEvent和CatchByte是抛出异常时会释放的事件，分别对应require/revert和assert异常的情况。even是个OnlyEven合约类型的状态变量。

### 2024.10.06
1. IERC20是ERC20代币标准的接口合约，规定了ERC20代币需要实现的函数和事件
2. IERC20定义了2个事件：Transfer事件和Approval事件，分别在转账和授权时被释放
3. IERC20定义了6个函数: totalSupply, balanceOf, transfer, allowance, approve, transferFrom

### 2024.10.07
1. 最早的代币水龙头是比特币（BTC）水龙头：现在BTC一枚要$30,000，但是在2010年，BTC的价格只有不到$0.1，并且持有人很少。为了扩大影响力，比特币社区的Gavin Andresen开发了BTC水龙头，让别人可以免费领BTC。撸羊毛大家都喜欢，当时就有很多人去撸，一部分变为了BTC的信徒。BTC水龙头一共送出了超过19,700枚BTC，现在价值约6亿美元！
2. 注释代码有Dos攻击风险, 并且transfer 也是不推荐写法: _addresses[i].transfer(_amounts[i]);
3. 这里的漏洞在于，refund() 函数中利用循环退款的时候，是使用的 call 函数，将激活目标地址的回调函数，如果目标地址为一个恶意合约，在回调函数中加入了恶意逻辑，退款将不能正常进行。
4. 通过ERC165标准，智能合约可以声明它支持的接口，供其他合约检查。简单的说，ERC165就是检查一个智能合约是不是支持了ERC721，ERC1155的接口。
5. EIP可以是 Ethereum 生态中任意领域的改进, 比如新特性、ERC、协议改进、编程工具等等。ERC全称 Ethereum Request For Comment (以太坊意见征求稿), 用以记录以太坊上应用级的各种开发标准和协议。如典型的Token标准(ERC20, ERC721)、名字注册(ERC26, ERC13), URI范式(ERC67), Library/Package格式(EIP82), 钱包格式(EIP75,EIP85)。ERC协议标准是影响以太坊发展的重要因素, 像ERC20, ERC223, ERC721, ERC777等, 都是对以太坊生态产生了很大影响。所以最终结论：EIP包含ERC。  

很多逻辑错误都可能导致智能合约拒绝服务，所以开发者在写智能合约时要万分谨慎。以下是一些需要特别注意的地方：  

1. 外部合约的函数调用（例如 call）失败时不会使得重要功能卡死，比如将上面漏洞合约中的 require(success, "Refund Fail!"); 去掉，退款在单个地址失败时仍能继续运行。
2. 合约不会出乎意料的自毁。
3. 合约不会进入无限循环。
4. require 和 assert 的参数设定正确。
5. 退款时，让用户从合约自行领取（push），而非批量发送给用户(pull)。
6. 确保回调函数不会影响正常合约运行。
7. 确保当合约的参与者（例如 owner）永远缺席时，合约的主要业务仍能顺利运行。

### 2024.10.08
1. IERC165接口合约只声明了一个supportsInterface函数，输入要查询的interfaceId接口id，若合约实现了该接口id，则返回true.当查询的是IERC721或IERC165的接口id时，返回true；反之返回false。
2. 利用tokenId来表示特定的非同质化代币，授权或转账都要明确tokenId；而ERC20只需要明确转账的数额即可。
3. 对于有N个叶子结点的Merkle Tree，在已知root根值的情况下，验证某个数据是否有效（属于Merkle Tree叶子结点）只需要ceil(log₂N)个数据（也叫proof），非常高效
4. 一份拥有800个地址的白名单，更新一次所需的gas fee很容易超过1个ETH。而由于Merkle Tree验证时，leaf和proof可以存在后端，链上仅需存储一个root的值，非常节省gas，项目方经常用它来发放白名单。很多ERC721标准的NFT和ERC20标准代币的白名单/空投都是利用Merkle Tree发出的，比如optimism的空投。
5. 

<!-- Content_END -->
