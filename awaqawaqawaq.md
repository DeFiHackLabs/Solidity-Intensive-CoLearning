
---
timezone: Asia/Shanghai
---



# awaqawaqawaq

1. 区块链新人,没有经验，啥也不会，不过总有开始的一步(
 
2. 你认为你会完成本次残酷学习吗？ maybe(70%)
   
## Notes

<!-- Content_START -->

### 2024.09.23
时间：45min  學習內容: solidity101 1~5

- [Solidity](https://www.wtf.academy/docs/solidity-101/HelloWeb3/) 是一种用于编写以太坊虚拟机（EVM）智能合约的编程语言。

- 值类型(Value Type)/引用类型(Reference Type)/映射类型(Mapping Type)
- 函数格式
```solidity  
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```
- 注意：Pure函数是不修改状态，纯计算函数
- internal external payable
- 返回值：return 和 returns
  returns (<return types>) 是函数的返回值声明，用于指定函数的返回类型。它必须紧跟在函数名和参数列表之后，并且用圆括号括起来。
  

  ```solidity
  function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array)
  ```
    returns 中标明返回变量的名称。Solidity 会初始化这些变量，并且自动返回这些函数的值，无需使用 return。
- storage，memory和calldata
  
storage（合约的状态变量）赋值给本地storage（函数里的）,memory赋值给memory，会创建引用 
- tansfer的默认单位是wei

### 2024.09.24
时间：90min  學習內容: solidity101 5~10
- array：
  - bytes比较特殊，是数组，但是不用加[]
  - memory动态数组，可以用new操作符来创建，但是必须声明长度
  - 如果创建的是动态数组，你需要一个一个元素的赋值

- struct
- Mapping，struct和array不可以作为mapping的key
- 变量初始值
- 0x00 = 1 byte
- constant和immutable
  -string可以是constant，但是不能是immutable，**constant的值在编译时确定，immutable的值在部署时确定**。
- 定义时赋值为显示赋值，构造函数为隐式赋值
  
### 2024.09.25
时间：90min  學習內容: solidity101 11~15
- 构造函数
- modifier  类似decorator
- event  
  - Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：
  
      响应：应用程序（ethers.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。

      经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

  - event <event name>(<parameter types>);  // 声明事件
  - emit <event name>(<parameter values>);  // 触发事件
  - indexed 记的参数可以理解为检索事件的索引“键”
- require和revert
  - error 可自定义，可包含信息，revert error()  **gas最低**
  - require(condition, "error message");  // 如果条件为false，则回滚交易并返回错误信息
  - revert("error message");  // 回滚交易并返回错误信息
- assert
  - assert(condition);  // 如果条件为false，则回滚交易并返回错误信息，并且不会返回任何错误信息
- 继承 
  - virtual 和 override
  - 钻石继承（菱形继承）使用super会调用继承链条上的每一个合约的相关函数
- 抽象合约  接口
  - 接口与合约ABI（Application Binary Interface）等价，可以相互转换，通过 IERC721 IERC721等可以调用实现接口功能的合约
  - 接口不能包含状态变量，只能包含函数声明
  - 接口不能包含构造函数，也不能包含函数体
  - 接口不能继承其他合约，只能继承其他接口

### 2024.09.26
时间：90min  學習內容: solidity102 16~20
- overloading 重载 
- 库合约 
  - using A for B;语法糖 B.xxx()调用A函数 
  - A.xxx()
  - Strings：将uint256转换为String
  
    Address：判断某个地址是否为合约地址

    Create2：更安全的使用Create2 EVM opcode

    Arrays：跟数组相关的库合约

- import
- receive 和 fallback
- 接收ETH调用 receive，fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。一般external payable修饰
- transfer send call
- tansfer和send的区别在于，如果接收者合约没有receive函数，那么transfer会回滚交易，而send会返回一个布尔值，表示交易是否成功。
- call和send的区别在于，call可以调用合约的任何函数，而send只能发送ETH。call可以返回一个布尔值，表示交易是否成功，也可以返回一个字节数组，表示函数的返回值。
- (bool success,) = _to.call{value: amount}(""); // 使用call发送ETH, **("")为msg，如果receive()无法处理，就会调用fallback()**
### 2024.09.27
- _Name(_Address).f()，其中f()是要调用的函数。
-  如果能直接调用原合约的set() 是不安全的
-  call
   - 目标合约地址.call(字节码); abi.encodeWithSignature("函数签名", 逗号分隔的具体参数) 
   - 返回 (bool, bytes memory) 需要通过abi.decode解码
   - 失败会调用 fallback()函数
-  Delegatecall
     - 而当用户A通过合约B来delegatecall合约C的时候，执行的是合约C的函数，但是上下文仍是合约B的：msg.sender是A的地址，并且如果函数改变一些状态变量，产生的效果会作用于合约B的变量上。
     - ![](https://images.mirror-media.xyz/publication-images/VgMR533pA8WYtE5Lr65mQ.png?height=698&width=1860) 
 
     - ![](https://images.mirror-media.xyz/publication-images/JucQiWVixdlmJl6zHjCSI.png?height=702&width=1862)
### 2024.09.29
- create & create2
  - Contract x = new Contract{value: _value}(params) 
      - Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数。
      - 新地址 = hash(创建者地址, nonce)
- create2 
      - CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。用CREATE2创建的合约地址由4个部分决定：

        0xFF：一个常数，避免和CREATE冲突
        CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址。
        salt（盐）：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址。
        initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）。
    - 新地址 = hash("0xFF",创建者地址, salt, initcode)
    - Contract x = new Contract{salt: _salt, value: _value}(params)
### 2024.09.30
- selfdestruct
    -  selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。
    - 在以太坊坎昆（Cancun）升级中，EIP-6780被纳入升级以实现对Verkle Tree更好的支持。EIP-6780减少了SELFDESTRUCT操作码的功能。 **已经部署的合约无法被SELFDESTRUCT了。 如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。**
    - selfdestruct(payable(msg.sender));
    - 使用selfdestruct()函数删除合约时，合约中的所有状态变量都会被删除，但合约中的函数仍然可以访问这些状态变量。因此，在删除合约之前，应该确保所有状态变量都被正确地处理。
    - 对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
    当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的selfdestruct功能会为攻击者打开攻击向量(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

- ABI编码
    -  ABI（Application Binary Interface）是以太坊和其他区块链平台中用于定义智能合约与外部应用程序（如前端、其他合约）之间交互的规范。
    -  abi.encode, 
    -  abi.encodePacked, //压缩数据，无法正常交互
    -  abi.encodeWithSignature, 
    -  abi.encodeWithSelector
    -  abi.encodeWithSelector(bytes4(0x533ba33a));**通过abi函数选择器，address(contract).staticcall(data)来调用相关函数**
-  Hash
    -  生成数据唯一标识
    -  Solidity使用keccak256，返回一个32字节的哈希值。

### 2024.10.01
-  Selector
    -  4字节的函数选择器，**也就是8个16进制位**，用于标识函数
    - msg.data 储存完整的calldata
    -  bytes4(keccak256("transfer       (address,uint256)"))
    - 映射类型参数 contract、enum、struct等，需要将该类型转化成为ABI类型。如：结构体User需要转化为tuple类型(uint256,bytes)，枚举类型School需要转化为uint8
-  call
    -  address(contract).call(data)
    -  address(contract).call{value: 1 ether}(data)
    -  address(contract).call{gas: 100000}(data)
- Try Catch
    -  try address(contract).call(data) returns (bool success, bytes memory returnData) {
        // 处理返回值
    } catch Error(string memory reason) {
        // 处理错误
         // catch失败的 revert() 和 require()
    } catch (bytes memory) {
        // 处理其他类型的错误
        // catch失败的 assert()

    }
-  Revert
    -  revert("Error message");
### 2024.10.02
- 写了简单的实现erc20接口的合约和faucet 合约 ，并通过remix测试合约功能
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "./IERC20.sol";

contract Faucet {
    event  SendToken(address indexed _to, uint indexed_value);
    address public tokenAddress;
    uint public amount=1000;
    mapping(address=>bool) public requestedAddresses;
    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress;
    }
    function requestTokens() external returns (bool) {
        require(!requestedAddresses[msg.sender],"fuck you looser!");
        IERC20 tokens = IERC20(tokenAddress);
        require(tokens.balanceOf(address(this))>=amount,":(");
        tokens.transfer(msg.sender, amount);
        requestedAddresses[msg.sender] = true;
        emit SendToken(msg.sender, amount);
        return true;
    }
}
contract MyTokenTest is IERC20 {
    mapping (address => uint256) public override balanceOf;
    mapping (address => mapping (address => uint256)) public override allowance;
    uint256 public override totalSupply;
    string public name ;
    string public symbol ;
    uint8 public decimals = 18;
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;//不能用this.name=_name;
        totalSupply = _initialSupply ;
    }
    function transfer(address reciver, uint256 _value) public override returns (bool) {
        balanceOf[msg.sender] -= _value;
        balanceOf[reciver] += _value;
        emit Transfer(msg.sender, reciver, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public override returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        require(allowance[_from][msg.sender] >= _value);
        allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        return true;
    }
    function mint(uint _value) external {
        balanceOf[msg.sender] += _value;
        totalSupply += _value;
        emit Transfer(address(0), msg.sender, _value);
    }
    function burn(uint _value) external {
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Transfer(msg.sender, address(0), _value);
    }

}
```
### 2024.10.03
- 学习了ERC721相关知识
### 2024.10.04
- 学习了荷兰拍卖和空投合约相关知识

### 2024.10.07
- 学习了openzeppelin的ERC721代码，在remix上进行了实验
- _tokenApprovals(mapping(uint256 tokenId => address))记录某个代币的approval, _operatorApprovals记录了某个地址对于某个地址的授权。
```solidity
    function _update(address to, uint256 tokenId, address auth) internal virtual returns (address) {
        address from = _ownerOf(tokenId);

        // Perform (optional) operator check
        if (auth != address(0)) {
            _checkAuthorized(from, auth, tokenId);
        }

        // Execute the update
        if (from != address(0)) {
            // Clear approval. No need to re-authorize or emit the Approval event
            _approve(address(0), tokenId, address(0), false);

            unchecked {
                _balances[from] -= 1;
            }
        }

        if (to != address(0)) {
            unchecked {
                _balances[to] += 1;
            }
        }

        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

        return from;//返回上一个owner
    }
```
- update函数更新了token的owner，并且更新了token的balance，并且更新了token的approval。需要**_approve(address(0), tokenId, address(0), false);**来清除approval。当代币approve给address(0)，就相当于burn。
- _mint需要检查上一个owner，如果不是address(0)，说明token已经存在，进行revert。
- safe会进行ERC721Utils.checkOnERC721Received(_msgSender(), address(0), to, tokenId, data);判断目标合约是否支持ERC721Receiver，如果支持，则调用onERC721Received，否则revert。
```solidity
function _checkOnERC721Received(
    address operator,
    address from,
    address to,
    uint256 tokenId,
    bytes memory data
) internal {
    if (to.code.length > 0) {
        try IERC721Receiver(to).onERC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
            if (retval != IERC721Receiver.onERC721Received.selector) {
                // Token rejected
                revert IERC721Errors.ERC721InvalidReceiver(to);
            }
        } catch (bytes memory reason) {
            if (reason.length == 0) {
                // non-IERC721Receiver implementer
                revert IERC721Errors.ERC721InvalidReceiver(to);
            } else {
                /// @solidity memory-safe-assembly
                assembly {
                    revert(add(32, reason), mload(reason))
                }
            }
        }
    }
}
```

```solidity
// ERC721接收者接口：合约必须实现这个接口来通过安全转账接收ERC721
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
```
- 目标合约需要实现接口完善处理逻辑
  
### 2024.10.08
学习了DutchAuction和MerkleTree,并且研究了源码，在remix进行验证
**value选项框中可以指定传入给payable函数的eth，我之前竟然不知道，想了好久该如何调用函数的同时传入eth:(**

### 2024.10.09
学习了数字签名 和 NFT交易所 源码，并在remix上进行了验证
- 数字签名
- 签名的内容利用abi.encodePacked()函数打包，然后用keccak256()计算哈希，作为消息的摘要，然后利用私钥对摘要进行签名，得到r,s,v三个参数，v是0或1，代表使用的曲线类型，r,s是签名结果，然后利用公钥验证签名。
- 消息可以是能被执行的交易，也可以是其他任何形式。为了避免用户误签了恶意交易，EIP191提倡在消息前加上"\x19Ethereum Signed Message:\n32"字符，并再做一次keccak256哈希，作为以太坊签名消息。经过toEthSignedMessageHash()函数处理后的消息，不能被用于执行交易
- 利用签名发放白名单 (https://github.com/AmazingAng/WTF-Solidity/blob/main/37_Signature/Signature.sol)
### 2024.10.10
- 学习了链上随机数，分账，weth合约，研究了相关源码
```solidity
    /** 
    * 输入uint256数字，返回一个可以mint的tokenId
    * 算法过程可理解为：totalSupply个空杯子（0初始化的ids）排成一排，每个杯子旁边放一个球，编号为[0, totalSupply - 1]。
    每次从场上随机拿走一个球（球可能在杯子旁边，这是初始状态；也可能是在杯子里，说明杯子旁边的球已经被拿走过，则此时新的球从末尾被放到了杯子里）
    再把末尾的一个球（依然是可能在杯子里也可能在杯子旁边）放进被拿走的球的杯子里，循环totalSupply次。相比传统的随机排列，省去了初始化ids[]的gas。
    */
    function pickRandomUniqueId(uint256 random) private returns (uint256 tokenId) {
        //先计算减法，再计算++, 关注(a++，++a)区别
        uint256 len = totalSupply - mintCount++; // 可mint数量
        require(len > 0, "mint close"); // 所有tokenId被mint完了
        uint256 randomIndex = random % len; // 获取链上随机数

        //随机数取模，得到tokenId，作为数组下标，同时记录value为len-1，如果取模得到的值已存在，则tokenId取该数组下标的value
        tokenId = ids[randomIndex] != 0 ? ids[randomIndex] : randomIndex; // 获取tokenId
        ids[randomIndex] = ids[len - 1] == 0 ? len - 1 : ids[len - 1]; // 更新ids 列表
        ids[len - 1] = 0; // 删除最后一个元素，能返还gas
    }
```
- 有趣的随机数算法
- WETH
 - 因为eth不支持一些defi，所以包装成weth
- 分账
### 2024.10.11
学习了线性释放，代币锁，时间锁合约，并在remix上进行了验证
通过bytes32 txHash = getTxHash(target, value, signature, data, executeTime);来确定交易唯一

### 2024.10.12
学习了代理合约的相关知识，并在remix上进行了验证
- 代理合约
- 可升级合约
- 透明代理(解决 逻辑合约 和 代理合约 abi重名问题)
- UUPS代理(将升级函数放在逻辑合约中，逻辑合约必须保证有相关的升级函数)
- := 在 Solidity 中，:= 是一种特殊的符号，用于 Yul 代码（Solidity 的低级中间语言）。它用于赋值操作
### 2024.10.14
学习了ERC4626,EIP712,ERC-2612的相关知识，并在remix上进行了验证

### 2024.10.15
学习了AMM相关知识，了解了相关概念计算
- 用sqrt(xy)代表流动性，相比于xy更加线性的描述
- p=dy/dx 即为切线斜率
- 提供lp的唯一风险就是Impermanent loss ，无论币价上涨或者下跌
- uniswap v3做出了很多改变
- 阅读了uniswap部分源码
### 2024.10.16
学习了闪电贷合约，阅读了uniswap源码
如果没有还上，说明钱没借出去
<!-- Content_END -->
