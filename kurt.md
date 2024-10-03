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
```
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```
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
```
// 利用using for指令
using Strings for uint256;
function getString1(uint256 _number) public pure returns(string memory){
    // 库合约中的函数会自动添加为uint256型变量的成员
    return _number.toHexString();
}
```

通过库合约名称调用函数
```
// 直接通过库合约名调用
function getString2(uint256 _number) public pure returns(string memory){
    return Strings.toHexString(_number);
}
```
18. Import

在Solidity中，import语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。本教程将向你介绍如何在Solidity中使用import语句。

import用法
1.通过源文件相对位置导入，例子：
```
// 通过文件相对位置import
import './Yeye.sol';
```
2.通过源文件网址导入网上的合约的全局符号，例子：
```
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
```
3.通过npm的目录导入，例子：
```
import '@openzeppelin/contracts/access/Ownable.sol';
```
4.通过指定全局符号导入合约特定的全局符号，例子：
```
import {Yeye} from './Yeye.sol';
```
5.引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前。

### 2024.09.25
19. 接收ETH receive和fallback

Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：

接收ETH
处理合约中不存在的函数调用（代理合约proxy contract）

1.接收ETH函数 receive

receive()函数是在合约收到ETH转账时被调用的函数。一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：receive() external payable { ... }。receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。

2.回退函数 fallback

fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:fallback() external payable { ... }。

3.receive和fallback的区别
receive和fallback都能够用于接收ETH，他们触发的规则如下：
```
触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()   fallback()
```
20. 发送ETH
    
Solidity有三种方法向其他合约发送ETH，他们是：transfer()，send()和call()，其中call()是被鼓励的用法。

1.transfer
用法是接收方地址.transfer(发送ETH数额)。
transfer()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
transfer()如果转账失败，会自动revert（回滚交易）。

```
// 用transfer()发送ETH
function transferETH(address payable _to, uint256 amount) external payable{
    _to.transfer(amount);
}
```

2.send
用法是接收方地址.send(发送ETH数额)。
send()的gas限制是2300，足够用于转账，但对方合约的fallback()或receive()函数不能实现太复杂的逻辑。
send()如果转账失败，不会revert。
send()的返回值是bool，代表着转账成功或失败，需要额外代码处理一下。
```
error SendFailed(); // 用send发送ETH失败error

// send()发送ETH
function sendETH(address payable _to, uint256 amount) external payable{
    // 处理下send的返回值，如果失败，revert交易并发送error
    bool success = _to.send(amount);
    if(!success){
        revert SendFailed();
    }
}
```
3.call
用法是接收方地址.call{value: 发送ETH数额}("")。
call()没有gas限制，可以支持对方合约fallback()或receive()函数实现复杂逻辑。
call()如果转账失败，不会revert。
call()的返回值是(bool, bytes)，其中bool代表着转账成功或失败，需要额外代码处理一下。
```
error CallFailed(); // 用call发送ETH失败error

// call()发送ETH
function callETH(address payable _to, uint256 amount) external payable{
    // 处理下call的返回值，如果失败，revert交易并发送error
    (bool success,) = _to.call{value: amount}("");
    if(!success){
        revert CallFailed();
    }
}
```
### 2024.09.26
21. 调用其他合约
    
1. 传入合约地址
```
我们可以在函数里传入目标合约地址，生成目标合约的引用，然后调用目标函数。以调用OtherContract合约的setX函数为例，我们在新合约中写一个callSetX函数，传入已部署好的OtherContract合约地址_Address和setX的参数x：

function callSetX(address _Address, uint256 x) external{
    OtherContract(_Address).setX(x);
}
复制OtherContract合约的地址，填入callSetX函数的参数中，成功调用后，调用OtherContract合约中的getX验证x变为123
```
2. 传入合约变量
```
我们可以直接在函数里传入合约的引用，只需要把上面参数的address类型改为目标合约名，比如OtherContract。下面例子实现了调用目标合约的getX()函数。

注意：该函数参数OtherContract _Address底层类型仍然是address，生成的ABI中、调用callGetX时传入的参数都是address类型

function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}
复制OtherContract合约的地址，填入callGetX函数的参数中，调用后成功获取x的值
```
3. 创建合约变量
```
我们可以创建合约变量，然后通过它来调用目标函数。下面例子，我们给变量oc存储了OtherContract合约的引用：

function callGetX2(address _Address) external view returns(uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
复制OtherContract合约的地址，填入callGetX2函数的参数中，调用后成功获取x的值
```
4. 调用合约并发送ETH
如果目标合约的函数是payable的，那么我们可以通过调用它来给合约转账：_Name(_Address).f{value: _Value}()，其中_Name是合约名，_Address是合约地址，f是目标函数名，_Value是要转的ETH数额（以wei为单位）。
```
OtherContract合约的setX函数是payable的，在下面这个例子中我们通过调用setX来往目标合约转账。

function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
}
复制OtherContract合约的地址，填入setXTransferETH函数的参数中，并转入10ETH
```
22. Call

call 是address类型的低级成员函数，它用来与其他合约交互。它的返回值为(bool, bytes memory)，分别对应call是否成功以及目标函数的返回值。

call是Solidity官方推荐的通过触发fallback或receive函数发送ETH的方法。
不推荐用call来调用另一个合约，因为当你调用不安全合约的函数时，你就把主动权交给了它。推荐的方法仍是声明合约变量后调用函数，见第21讲：调用其他合约
当我们不知道对方合约的源代码或ABI，就没法生成合约变量；这时，我们仍可以通过call调用对方合约的函数。
call的使用规则
call的使用规则如下：
```
目标合约地址.call(字节码);
其中字节码利用结构化编码函数abi.encodeWithSignature获得：
```
```
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
函数签名为"函数名（逗号分隔的参数类型）"。例如abi.encodeWithSignature("f(uint256,address)", _x, _addr)。
```
另外call在调用合约时可以指定交易发送的ETH数额和gas数额：
```
目标合约地址.call{value:发送数额, gas:gas数额}(字节码);
```
23. Delegatecall
### 2024.09.27
24. 在合约中创建新合约
    在以太坊链上，用户（外部账户，EOA）可以创建智能合约，智能合约同样也可以创建新的智能合约。去中心化交易所uniswap就是利用工厂合约（PairFactory）创建了无数个币对合约（Pair）。
Uniswap V2核心合约中包含两个合约：
```
UniswapV2Pair: 币对合约，用于管理币对地址、流动性、买卖。
UniswapV2Factory: 工厂合约，用于创建新的币对，并管理币对地址。
```
下面我们用create方法实现一个极简版的Uniswap：Pair币对合约负责管理币对地址，PairFactory工厂合约用于创建新的币对，并管理币对地址。
Pair合约
```
contract Pair{
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }
}
```
PairFactory
```
contract PairFactory{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
        // 创建新合约
        Pair pair = new Pair(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }
}
```
25. CREATE2
CREATE2 操作码使我们在智能合约部署在以太坊网络之前就能预测合约的地址。Uniswap创建Pair合约用的就是CREATE2而不是CREATE。这一讲，我将介绍CREATE2的用法

CREATE2如何计算地址
CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。用CREATE2创建的合约地址由4个部分决定：

0xFF：一个常数，避免和CREATE冲突
CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
新地址 = hash("0xFF",创建者地址, salt, initcode)
Copy
CREATE2 确保，如果创建者使用 CREATE2 和提供的 salt 部署给定的合约initcode，它将存储在 新地址 中。

如何使用CREATE2
### 2024.09.28
26. 删除合约
    
    selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。selfdestruct是为了应对合约出错的极端情况而设计的。它最早被命名为suicide（自杀），但是这个词太敏感。为了保护抑郁的程序员，改名为selfdestruct；在 v0.8.18 版本中，selfdestruct 关键字被标记为「不再建议使用」，在一些情况下它会导致预期之外的合约语义，但由于目前还没有代替方案，目前只是对开发者做了编译阶段的警告，相关内容可以查看 EIP-6049。

然而，在以太坊坎昆（Cancun）升级中，EIP-6780被纳入升级以实现对Verkle Tree更好的支持。EIP-6780减少了SELFDESTRUCT操作码的功能。根据提案描述，当前SELFDESTRUCT仅会被用来将合约中的ETH转移到指定地址，而原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以目前来说：

已经部署的合约无法被SELFDESTRUCT了。
如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。

27. ABI编码解码
    
    ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。
    ABI编码有4个函数：abi.encode, abi.encodePacked, abi.encodeWithSignature, abi.encodeWithSelector。而ABI解码有1个函数：abi.decode
### 2024.09.29
未更新
### 2024.09.30
28. Hash

    Hash的性质
一个好的哈希函数应该具有以下几个特性：

单向性：从输入的消息到它的哈希的正向运算简单且唯一确定，而反过来非常难，只能靠暴力枚举。
灵敏性：输入的消息改变一点对它的哈希改变很大。
高效性：从输入的消息到哈希的运算高效。
均一性：每个哈希值被取到的概率应该基本相等。
抗碰撞性：
弱抗碰撞性：给定一个消息x，找到另一个消息x'，使得hash(x) = hash(x')是困难的。
强抗碰撞性：找到任意x和x'，使得hash(x) = hash(x')是困难的。
Hash的应用
生成数据唯一标识
加密签名
安全加密
Keccak256
Keccak256函数是Solidity中最常用的哈希函数，用法非常简单：

哈希 = keccak256(数据);

29. 函数选择器Selector

### 2024.10.02
30. Try Catch

在Solidity中，try-catch只能被用于external函数或创建合约时constructor（被视为external函数）的调用。基本语法如下：
```
try externalContract.f() {
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```
其中externalContract.f()是某个外部合约的函数调用，try模块在调用成功的情况下运行，而catch模块则在调用失败时运行。

同样可以使用this.f()来替代externalContract.f()，this.f()也被视作为外部调用，但不可在构造函数中使用，因为此时合约还未创建。

如果调用的函数有返回值，那么必须在try之后声明returns(returnType val)，并且在try模块中可以使用返回的变量；如果是创建合约，那么返回值是新创建的合约变量。
```
try externalContract.f() returns(returnType val){
    // call成功的情况下 运行一些代码
} catch {
    // call失败的情况下 运行一些代码
}
```

另外，catch模块支持捕获特殊的异常原因：
```
try externalContract.f() returns(returnType){
    // call成功的情况下 运行一些代码
} catch Error(string memory /*reason*/) {
    // 捕获revert("reasonString") 和 require(false, "reasonString")
} catch Panic(uint /*errorCode*/) {
    // 捕获Panic导致的错误 例如assert失败 溢出 除零 数组访问越界
} catch (bytes memory /*lowLevelData*/) {
    // 如果发生了revert且上面2个异常类型匹配都失败了 会进入该分支
    // 例如revert() require(false) revert自定义类型的error
}
```
### 2024.10.03
刷题![image](https://github.com/user-attachments/assets/f9ab66f1-36ca-4f3d-8d12-39e7af231dd3)

### 2024.10.04
### 2024.10.05
### 2024.10.06
### 2024.10.07
### 2024.10.08
### 2024.10.09
### 2024.10.10
    
<!-- Content_END -->
