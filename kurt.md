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

### 2024.09.28

### 2024.09.29

### 2024.09.30

<!-- Content_END -->
