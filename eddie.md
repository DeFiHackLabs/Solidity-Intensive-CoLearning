---
timezone: Asia/Shanghai
---

# YourName

1. 自我介绍

大家好，我是eddie，智能合约初学者，希望和大家共同进步，WGMI

2. 你认为你会完成本次残酷学习吗？

必须的，恰好有一段时间可以用于本次学习活动中；
   
## Notes
<!-- Content_START -->

### 2024.10.03

Solidity103章节内容：荷兰拍卖、默克尔树

Ethers101章节内容：HelloVitalik

#### 笔记

- merkle tree

  [关于Merkle证明](https://learnblockchain.cn/article/5297)
  
  通过两两哈希，来获取根节点，利用根节点的可验证性，来保护整个数据不被篡改；

  Merkle proof即为从叶子节点到根节点的路径；

- 相关代码

  [dutchAuction.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/NftAuction)

  [merkletree.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/NftWhitelist)

### 2024.10.02

WTF103章节内容：ERC721

#### 笔记

- IERC165
检查一个智能合约是否支持ERC721的接口
    
    ```solidity
    //ERC721中实现该接口
    function supportsInterface(bytes4 interfaceId) external pure override returns (bool)
        {
            return
                interfaceId == type(IERC721).interfaceId ||
                interfaceId == type(IERC165).interfaceId;
        }
    ```
    
- 确保目标合约实现了onERC721Received()函数
    
    ```solidity
    function _checkOnERC721Received(address operator,address from,address to,uint256 tokenId,bytes memory data) internal {
        if (to.code.length > 0) {
            try IERC721Receiver(to).onERC721Received(operator, from, tokenId, data) returns (bytes4 retval) {
                if (retval != IERC721Receiver.onERC721Received.selector) {
                //利用函数选择器来验证，对to地址进行强制转换
                    revert IERC721Errors.ERC721InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    // non-IERC721Receiver implementer
                    revert IERC721Errors.ERC721InvalidReceiver(to);
                } else {
                    /// 用汇编抛出更详细和自定义的错误信息
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        }
    }
    ```
    
- 相关代码

    [erc721](https://github.com/eddiehsu66/SolidityCase/tree/main/ERC721)


### 2024.10.01

WTF103章节内容: 空投合约

#### 笔记

- 空投合约
    
    _to.call(value:amount){””}
    这里的value默认单位为wei，如果需要发送ether，可以amount * 1 ether 来进行换算

- 相关代码

    [airdrop合约](https://github.com/eddiehsu66/SolidityCase/tree/main/Airdrop)

### 2024.09.30

WTF103章节内容：ERC20、代币水龙头

#### 笔记

- IERC20接口
    
    ```solidity
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from,address to,uint256 amount) external returns (bool);
    ```
    
- 相关代码：

    [erc20](https://github.com/eddiehsu66/SolidityCase/tree/main/ERC20)

    [tokenFaucet](https://github.com/eddiehsu66/SolidityCase/tree/main/TokenFaucet)

### 2024.09.29

WTF102章节内容：Hash、TryCatch

#### 笔记

- 选择器
    
    即为bytes4(keccak256("fixedSizeParamSelector(uint256[3])"))，可以理解作为函数的标识符；

    此处需要注意空格，uint换为uint256；
    
    ```solidity
    contract DemoContract {
    }
    
    contract Selector{
        struct User {
            uint256 uid;
            bytes name;
        }
        enum School { SCHOOL1, SCHOOL2, SCHOOL3 }
        function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4 selectorWithMappingParam){
            emit SelectorEvent(this.mappingParamSelector.selector);
            //mappingParamSelector中DemoContract需要转化为address
            //结构体User需要转化为tuple类型(uint256,bytes)
            //枚举类型School需要转化为uint8
            return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
        }
        function callWithSignature() external{
        //利用选择器来进行函数调用
    	    (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
        }
    }
    ```
    
- 异常捕捉
    
    ```solidity
    try externalContract.f() returns(returnType){
    } catch Error(string memory /*reason*/) {
        // revert和require→用Error(string memory)进行捕捉
    } catch Panic(uint /*errorCode*/) {
        // assert→用Panic()进行捕捉|
    } catch (bytes memory) {
        // 通用的，不考虑区分Error和Panic
        // 例如revert() require(false) revert自定义类型的error
    }
    ```


### 2024.09.28

- WTF102章节内容：在合约中创建新合约、Create2、删除合约、ABI编码解码

#### 笔记

- 使用CREATE创建合约
  
新地址 = hash(创建者地址，nonce)

- 使用CREATE2创建合约
新地址 = hash(常数，创建者地址，salt，initcode)
    ```
    predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
    	    bytes1(0xff),
    	    address(this),
    	    salt,
	    keccak256(type(Pair).creationCode)
	    )))));
    bytes32 salt = keccak256(abi.encodePacked(token0, token1));
    // 用create2部署新合约
    Pair pair = new Pair{salt: salt}();
    ```

- ABI
应用二进制接口，是与以太坊智能合约交互的标准。数据基于他们的类型编码；并且由于编码后不包含类型信息，解码时需要注明它们的类型。
    ```solidity
    abi.encode()//为每个参数填充32字节的数据来并拼接
    abi.encodePacked()//和encode相比，将填充的很多0省略，节省空间，但无法和合约交互
    abi.encodeWithSignature()//第一个参数为函数签名FunctionName
    //函数选择器：就是通过函数名和参数进行签名处理(Keccak–Sha3)来标识函数，可以用于不同合约之间的函数调用
    abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);//第一个参数为函数选择器
    abi.decode()
    ```


### 2024.09.27

- WTF102章节内容：Call、Delegatecall

#### 笔记

- 通过call来进行调用某一个合约函数
    
    ```solidity
    address.call(abi.encodeWithSignature(”function signature”,prop))
    //当call 不存在的函数时，返回依然为success，但返回的data为0x0，实质调用了目标合约的fallback函数
    ```
    
- delegatecall
    
    要求当前合约中的状态变量和被调用合约中的状态变量相同；
    即为在调用过程中，delegatecall的执行结果可以修改当前合约的状态变量；
    
    **`要求变量类型和声明顺序必须相同，变量名可以不同；`**
    
    原因：变量名对于storage并不重要，storage是基于位置的；Solidity将状态变量以线性布局的方式存储在合约的storage slots中，如，第一个变量存在slot 0，第二个在slot1；

### 2024.09.26

- WTF102章节内容：接收ETH、发送ETH、调用其他合约

#### 笔记

- 接收ETH:receive和fallback

```solidity
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

- 接收ETH

| function | gas limit | 是否支持对方合约fallback() or receive实现复杂逻辑 | 是否支持revert | 返回值 |
| --- | --- | --- | --- | --- |
|  paybale(_to).transfer(amount) | 2300 | 否 | 支持 | no returns |
| _to.send(amount) | 2300 | 否 | 不支持 | bool |
| _to.call{value: amount}("") | none | 是 | 不支持 | (bool,bytes) |

- gas limit

执行交易或合约时所能消耗的最大计算资源。如果你设定的 gas limit 是 100,000 gas，那么你的交易在任何情况下都不会消耗超过 100,000 gas。如果交易需要的 gas 超过了这个限制，交易就会失败。

- 调用其他合约

```solidity
function callSetX(address _Address, uint256 _x) external{
        OtherContract(_Address).setX(_x);
}
function callGetX(OtherContract _Address) external view returns(uint x){
    x = _Address.getX();
}
function callGetX2(address _Address) external view returns (uint x){
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
function setXTransferETH(address otherContract, uint256 x) payable external{
    OtherContract(otherContract).setX{value: msg.value}(x);
    //语法糖，隐式调用的是_to.call(value: msg.value);
}
```

### 2024.09.25
- WTF101章节内容：抽象合约和接口、异常
- WTF102章节内容：重载、库合约、Import

#### 笔记

- 接口规则
    1. 不能包含状态变量
    2. 不能包含构造函数
    3. 不能继承除接口外的其他合约
    4. 所有函数都必须是external且不能有函数体
    5. 继承接口的非抽象合约必须实现接口定义的所有功能
- 异常

  1.error
    
    ```solidity
    error TransferNotOwner();
    revert TransferNotOwner();
    //省gas
    ```
    
    2.Require
    
    ```solidity
    require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    //随着字符串增加gas增加
    ```
    
    3.Assert
    
    ```solidity
    assert(_owners[tokenId] == msg.sender);
    //只能抛出异常
    ```

### 2024.09.24
- WTF101章节内容：映射类型、变量初始值、常数、控制流、构造函数和修饰器、事件、继承
#### 笔记

- map
  
1、key仅支持内置值类型，value支持struct

2、存储位置为storage，这里的map只用来记录关系，而不是一个类型；

3、当映射声明为public 时候，自动创建getter函数

4、val[key] = val

- constant和immutable

数值变量可以声明`constant`和`immutable`；

`string`和`bytes`可以声明为`constant`，但不能为`immutable`。
- EVM Log

用于存储Solidity Event，是函数和区块链之间的模块；

Topics: 描述事件,事件的签名（哈希）+最多3个indexed参数（256bit）

data: 事件的值，可存储任意大小的数据；
- 构造函数的继承

```Solidity
abstract contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }
}
//调用父合约的构造函数
contract C is A {
	constructor(uint _c) A(_c * _c) {}
}//这里是C继承了父合约的构造函数，将_c为参数，_c*_c作为父合约构造函数的参数调用；
```

### 2024.09.23
- WTF101章节：HelloWeb3（三行代码）、数值类型、函数类型、函数输出、变量数据存储、引用类型
#### 笔记内容
uint256和uint实际上是一样的，都是0到2^256-1这个范围区间内；
一个字符2个字节；

> 四种函数可见性说明符，共有4种。
> 
> - **`public`**：内部和外部均可见。
> - **`private`**：只能从本合约内部访问，继承的合约也不能使用。
> - **`external`**：只能从合约外部访问（但内部可以通过 **`this.f()`** 来调用，**`f`**是函数名）。
> - **`internal`**: 只能从合约内部访问，继承的合约可以用。（默认状态变量的可见性）

> Pure和View、Default
> 针对的是修改链上state的权限
> - `Pure` 不能读、不能写
> - `View` 只能读、不能写
> - `Default` 能读、能写

> 数据位置：
> 
> - **`storage`**:合约里的状态变量默认都是`storage`，存储在链上。
> - **`memory`**：函数里的参数和临时变量一般用**`memory`**，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。|
> - **`calldata`**：和`memory`类似，存储在内存中，不上链。与`memory`的不同点在于`calldata`变量不能修改（`immutable`），一般用于函数的参数。例子：

memory修饰的数组的大小为定长类型


<!-- Content_END -->
