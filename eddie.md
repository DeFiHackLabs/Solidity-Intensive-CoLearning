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

### 2024.10.14

Ethers102章节：识别ERC721合约、编码calldata、批量生成钱包/批量转账/批量归集

- interfaceId补充
    
    ```solidity
    interfaceId = type(IERC721).interfaceId
    //该Id通过计算所有函数选择器的异或得到
    //常见interfaceId:
    //IERC165: 0x01ffc9a7;IERC721: 0x80ac58cd
    ```
    
- 接口类Interface
    
    ```ts
    const interface = ethers.Interface(abi)
    const interface2 = contract.interface
    
    interface.getSighash("balanceOf")
    //获取函数选择器
    interface.encodeDeploy("Wrapped ETH", "WETH")
    //编码构造器的参数，可以附在合约字节码的后面
    interface.encodeFunctionData("balanceOf", ["0xc778417e063141139fce010982780140aa0cd5ab"])
    //编码函数的calldata
    interface.decodeFunctionResult("balanceOf", resultData)
    //解码函数的返回值
    ```
    
- 通过calldata来调用函数
    
    ```ts
    const param1 = contractWETH.interface.encodeFunctionData(
        "balanceOf",
        [address]
      );
    const tx1 = {
        to: addressWETH,
        data: param1
    }
    const balanceWETH = await provider.call(tx1)
    ```

### 2024.10.13

Ethers101章节：检索事件，监听合约事件、事件过滤、BigInt和单位转换

102章节：StaticCall

- 监听合约
    
    ```tsx
    contract.on("eventName", function)//持续监听
    contract.once("eventName", function)//监听一次
    const contractUSDT = new ethers.Contract(contractAddress, abi, provider);
    contractUSDT.once('Transfer', (from, to, value)=>{
        console.log()
      })
    ```
    
- 事件过滤
    
    ```tsx
    contract.filters.Transfer(myAddress)//过滤来自myAddress地址的Transfer事件
    contract.filters.Transfer(null, myAddress)//过滤所有发给 myAddress地址的Transfer事件
    contract.filters.Transfer(myAddress, otherAddress)//过滤所有从 myAddress发给otherAddress的Transfer事件
    contract.filters.Transfer(null, [ myAddress, otherAddress ])//过滤所有发给myAddress或otherAddress的Transfer事件
    ```
    
- StaticCall
    
    ```tsx
    //调用节点的eth_call、用于模拟状态改变函数的结果；在发送交易之前检查交易是否会失败
    const tx2 = await contractDAI.transfer.staticCall("vitalik.eth", ethers.parseEther("10000"), {from: address})
    ```

### 2024.10.12

Ethers101章节：提供其Provider、读取合约信息、发送ETH、合约交互、部署合约

[ethers.js Documentation](https://docs.ethers.org/v6/)

- Contract读取
    
    ```tsx
    const abiERC20 = [
      "function name() view returns (string)",
      "function symbol() view returns (string)",
      "function totalSupply() view returns (uint256)",
      "function balanceOf(address) view returns (uint)",
    ];
    const addressDAI = '0x6B175474E89094C44Da98b954EedeAC495271d0F'
    let provider = new ethers.InfuraProvider("mainnet", INFURA_API_KEY);
    const contract = new ethers.Contract(addressDAI, abiERC20, provider);//只读
    const wallet1 = ethers.Wallet.createRandom()
    const contract = new ethers.Contract(addressDAI, abiERC20, wallet1);//可写
    ```
    
- 创建钱包的api
    
    ```tsx
    const wallet1 = ethers.Wallet.createRandom()//创建钱包
    const wallet2 = new ethers.Wallet(privateKey, provider)//从私钥导入
    const wallet3 = ethers.Wallet.fromPhrase(mnemonic.phrase)//从助记词导入
    ```

### 2024.10.11

EVM opcode101章节: Hello Opcodes

Solidity 103章节：去中心化交易所、闪电贷

- EVM的执行模型
    
  1. 当一个交易被接收并准备执行时，以太坊会初始化一个新的执行环境并加载合约的字节码。
  
  2. 字节码被翻译成Opcode，被逐一执行。每个Opcodes代表一种操作，比如算术运算、逻辑运算、存储操作或者跳转到其他操作码。

  3. 每执行一个Opcodes，都要消耗一定数量的Gas。如果Gas耗尽或者执行出错，执行就会立即停止，所有的状态改变（除了已经消耗的Gas）都会被回滚。

  4. 执行完成后，交易的结果会被记录在区块链上，包括Gas的消耗、交易日志等信息。
    
- gas 计算

  通过opcodes，以太坊规定了每个opcode的gas消耗，复杂度越高的opcodes消耗越多的gas；如ADD操作消耗3 gas，SSTORE操作消耗20000 gas等等
- flashloan

  即为在一笔TX中同时完成借贷-执行-还款三个行为；

### 2024.10.10

Solidity 103章节：ERC-2612 ERC20Permit，多重调用

- Nonce补充

  nonce用于确认交易顺序，撤销pending中的交易，确定生成的合约地址

- ERC20Permit

  这里的用途主要是分离permit的发起者和gas的付费人（实际进行approve）的两个角色，用户仅仅需要进行签名即可进行交易，用于近似的cex体验；

- Multicall

  calldata同样可以修饰结构体的声明，Call calldata calli；calli直接从调用数据中读取，不需要复制到内存，从而节省gas；

- 相关代码

  [ERC20Permit.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/ERC20Permit)

  [MultiCall.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/MultiCall)


### 2024.10.09

Solidity 103章节：ERC4626代币化金库标准、EIP712类型化数据签名

- ERC4626

  用vault这个名称不太好理解到底在干嘛，应该换为shareToken，这个名称会好理解一些，可以视作veToken的前身；
  
- EIP712

  钱包会展示签名消息的原始数据，用户可以在验证数据符合预期之后签名；
    
  ```solidity
  //EIP712Domain,它包含了合约的 name，version（一般约定为 “1”），chainId，和 verifyingContract（验证签名的合约地址）
  bytes32 private constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
  //使用场景自定义一个签名的数据类型,如果需要修改number，那么需要指定；
  bytes32 private constant STORAGE_TYPEHASH = keccak256("Storage(address spender,uint256 number)");
  bytes32 private DOMAIN_SEPARATOR;
  uint256 number;
  address owner;

  constructor(){
      DOMAIN_SEPARATOR = keccak256(abi.encode(
	  EIP712DOMAIN_TYPEHASH, // type hash
	  keccak256(bytes("EIP712Storage")), // name
	  keccak256(bytes("1")), // version
	  block.chainid, // chain id
	  address(this) // contract address
      ));
      owner = msg.sender;
  }
  ```
    
- 相关代码
    
    [sharedToken.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/ERC4626)
    
    [EIP712Storage.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/EIP712Storage)

### 2024.10.08

Solidity 103章节：多签钱包

- 多签钱包

  通过一个bytes数组来存储签名，之后根据每个签名的长度为65进行分离，挨个验证，当通过数目大于等于threshold后，执行交易；
    
  ```solidity
  currentOwner = ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", dataHash)), v, r, s);
  ```
    
- 代码
  [MultisigWallet.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/MultisigWallet)

### 2024.10.07

Solidity 103章节内容：代理合约、可升级合约、透明代理、通用可升级代理

- 代理合约

在fallback()回调函数中基于delegatecall来调用被代理合约；
    
```solidity
//需要注意这一段汇编，目的是使得fallback()能够返回值
assembly {
	// 将msg.data拷贝到内存里
	// calldatacopy操作码的参数: 内存起始位置，calldata起始位置，calldata长度
	calldatacopy(0, 0, calldatasize())

	// 利用delegatecall调用implementation合约
	// delegatecall操作码的参数：gas, 目标合约地址，input mem起始位置，input mem长度，output area mem起始位置，output area mem长度
	// output area起始位置和长度位置，所以设为0
	// delegatecall成功返回1，失败返回0
	let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

	// 将return data拷贝到内存
	// returndata操作码的参数：内存起始位置，returndata起始位置，returndata长度
	returndatacopy(0, 0, returndatasize())

	switch result
	// 如果delegate call失败，revert
	case 0 {
	    revert(0, returndatasize())
	}
	// 如果delegate call成功，返回mem起始位置为0，长度为returndatasize()的数据（格式为bytes）
	default {
	    return(0, returndatasize())
	}
    }
```
    
- 选择器冲突

  函数选择器为函数签名的哈希的前4个字节；
    
  如”burn(uint256)”和(collate_propagate_storage()”具有相同的选择器；
    
- 透明代理

  管理员：调用代理合约的可升级函数对合约升级，不能通过回调函数调用逻辑合约

  其他用户：不能调用可升级函数，但是可以调用逻辑合约的函数。

- 通用可升级代理

  将升级函数放在逻辑合约中，并检查调用者是否为管理员；
  
- 相关代码

  [ProxyContract case](https://github.com/eddiehsu66/SolidityCase/tree/main/ProxyContract)
    
  [UUProxyContract case](https://github.com/eddiehsu66/SolidityCase/tree/main/UUProxyContract)

### 2024.10.06

Solidity 103章节内容：WETH、分账、线性释放、代币锁

- 函数参数的位置指定

  主要针对引用类型：数组、结构体、映射、字符串

  `memory`:表示数据将被存储在内存中，适用于需要修改或者临时存储的数据，允许在函数内容 修改参数内容，但会消耗更多gas；

  `calldata`:calldata为只读，最省gas，直接从调用数据中读取，不需要复制到内存；

- 代码
    
    [WETH.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/WETH)
    
    [PaymentSplit.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/PaymentSplit)
    
    [TokenVesting.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/TokenVesting)
    
    [TokenLocker.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/TokenLocker)

### 2024.10.05

Solidity 103章节内容：NFT交易所、ERC1155

- ERC1155

在`ERC721`中，每个代币都有一个`tokenId`作为唯一标识，每个`tokenId`只对应一个代币；而在`ERC1155`中，每一种代币都有一个`id`作为唯一标识，每个`id`对应一种代币。

- 代码
    
    [NftSwap.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/NftExchanger)
    
    [ERC1155.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/ERC1155)

### 2024.10.04

Solidity103章节内容：数字签名、链上随机数

#### 笔记

- 椭圆曲线签名算法ECDSA

  签名目的为证明当前为私钥的持有者、以及被签名数据没有被篡改过；

  该博客讲的非常详细 [What is the math behind elliptic curve cryptography? | HackerNoon](https://hackernoon.com/what-is-the-math-behind-elliptic-curve-cryptography-f61b25253da3)
    
- 和前端如何验证流程
    
    hash(A,B) → metamask公钥 →signature
  
    hash(A,B) →msgHash
  
    verify(msgHash,signature) → signer，这个signer 是否和metamask签名的公钥是否相同
    
- 调用LINK生成随机数

  注意：订阅 ID 类型已从 VRF V2 中的 **`uint64`** 变为 VRF V2.5 中的 **`uint256`**
  
- 相关代码

  [signature.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/Sign)
  
  [RandomNum.sol](https://github.com/eddiehsu66/SolidityCase/tree/main/RandomNum)

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
