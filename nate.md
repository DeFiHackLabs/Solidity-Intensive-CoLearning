---
timezone: Asia/Shanghai
---

---

# nate

1. 自我介绍
   我叫nate，来自上海。刚学习solidity两周非常高兴参与此次共学
2. 你认为你会完成本次残酷学习吗？
   当然
## Notes

<!-- Content_START -->

### 2024.09.23

#### 学习內容: 
  WTF Solidity01-05
  1. 学习使用在线IDE`remix`编译部署solidity代码
  2. solidity中特殊数据类型`address`
     - address: 存储一个 20 字节的值（以太坊地址的大小)
     - payable address: 比普通地址多了 transfer 和 send 两个成员方法，用于接收转账
  4. solidity中常见的function modifier，定义方法时需明确指出：
     - public：内部和外部均可见
     - private：只能从本合约内部访问，继承的合约也不能使用
     - external：只能从合约外部访问（但内部可以通过 this.f() 来调用）
     - internal: 只能从合约内部访问，继承的合约可以用
  5. solidty中常见状态变量的modifier`public\private\internal`,作用与方法类似，未定义默认为internal
  6. 方法关键字pure和view
     - pure：对状态变量不可读写
     - view：对状态变量可读但不可写
  7. 状态变量关键字`storage\memory\calldata`用来表示数据存储位置：
     - storage：合约里的状态变量默认都是storage，存储在链上
     - memory和calldata：存在于evm内存中，calldata不可更改 

### 2024.09.24
  WTF solidity06-10
  1. 学习solidity中数组，结构体和mapping类型
     - bytes作为特殊的数组无需添加[]且不能申明byte[],单字节数组可由bytes和byte1[]表示
     - 数组有点像java里的对象，mapping类似于哈希表
  2. 熟悉常用变量初始值
  3. constant和immutable。状态变量声明这两个关键字之后，不能在初始化后更改数值，immutable修饰的状态变量可在构造器中赋值
### 2024.09.25
  WTF solidity11-15
  1. 构造器和修饰器
  2. event
     以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。topic为事件签名的哈希，在topic中可以包括最多三个
     indexed参数，不带indexed值被放在data中
  3. 继承  
     virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字  
     override：子合约重写了父合约中的函数，需要加上override关键字
  4. 多重继承  
     继承时要按辈分最高到最低的顺序排。比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，不然就会报错。
     如果某一个函数在多个继承的合约里都存在，在子合约里必须重写，不然会报错  
     重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)
  5. 抽象合同  
     若合同至少有个函数没有方法体不能包含状态变量则需要添加关键字abstract定义为抽象合同
  6. 接口
     - 不能包含构造函数
     - 不能继承除接口外的其他合约
     - 所有函数都必须是external且不能有函数体
     - 继承接口的非抽象合约必须实现接口定义的所有功能
  7. error，require，assert
     ``` js
     // 自定义error
     error TransferNotOwner()
     // 自定义带参数的error
     error TransferNotOwner()
     // 必须配合revert使用
     function transferOwner1(uint256 tokenId, address newOwner) public {
       if(_owners[tokenId] != msg.sender){  
        revert TransferNotOwner();  
        // revert TransferNotOwner(msg.sender);  
       }  
       _owners[tokenId] = newOwner;
     }
     ```
     require使用方法：require(检查条件，"异常的描述")，gas随着描述异常的字符串长度增加，比error命令要高  
     assert 使用方法：assert(检查条件），当检查条件不成立的时候，就会抛出异常,但不能抛出描述
     ```js
     function transferOwner2(uint256 tokenId, address newOwner) public {  
       require(_owners[tokenId] == msg.sender, "Transfer Not Owner");  
       _owners[tokenId] = newOwner;  
     }
     function transferOwner3(uint256 tokenId, address newOwner) public {  
       assert(_owners[tokenId] == msg.sender);  
       _owners[tokenId] = newOwner;  
     }
     ```
### 2024.09.26
   WTF solidity24-25
   #### create, create2  
   solidity中提供两种在合约中创建合约实例的方法
   ``` text
   // 通过create创建合约
   Contract x = new Contract{value: _value}(params)
   // 通过create2创建合约
   Contract x = new Contract{salt:_salt, value: _value}(params)
   ```
   其中Contract是要创建的合约名，x是合约对象，如果构造函数是payable，可以创建时转入_value数量的ETH，_salt为随机的bytes32值，params是新合约构造函数的参数
   - CREATE如何计算地址
   ``` text
   智能合约可以由其他合约和普通账户利用CREATE操作码创建。 在这两种情况下，新合约的地址都以相同的方式计算：创建者的地址(通常为部署的钱
包地址或者合约地址)和nonce(该地址发送交易的总数,对于合约账户是创建的合约总数,每创建一个合约nonce+1)的哈希。

新地址 = hash(创建者地址, nonce)
```
创建者地址不会变，但nonce可能会随时间而改变，因此用CREATE创建的合约地址不好预测。

   - CREATE2如何计算地址
``` text
  CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。用CREATE2创建的合
约地址由4个部分决定：
0xFF：一个常数，避免和CREATE冲突
CreatorAddress: 调用 CREATE2 的当前合约（创建合约）地址
salt：一个创建者指定的bytes32类型的值，它的主要目的是用来影响新创建的合约的地址
initcode: 新合约的初始字节码（合约的Creation Code和构造函数的参数）

新地址 = hash("0xFF",创建者地址, salt, initcode)
```
   #### uniswap中create2应用
   --- 
   ``` 
   function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'UniswapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'UniswapV2: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IUniswapV2Pair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            ))));
    }

     uniswap提供两种代币的交换，其工产合约核心函数createPair可创建代币对合约`UniswapV2Pair`实例通过内联汇编assembly中
   evm操作码create2创建实例，其中通过哈希token1和token2地址生成salt，bytecode为UniswapV2Pair的创建字节码。由于一对token
   的地址是可知的，UniswapV2Pair合约的地址也是不变的，所以较容易推出一对代币的UniswapV2Pair合约地址。而采用create创建合约
   的话，合约地址会随创建账户的状态而变化不好预测
   ```
### 2024.09.27
WTF solidity34-35
1. [ERC721](https://eips.ethereum.org/EIPS/eip-165)
2. [openzeppelin erc721实现](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721)
3. IERC721函数
- `balanceOf`：返回某地址的NFT持有量`balance`。
- `ownerOf`：返回某`tokenId`的主人`owner`。
- `transferFrom`：普通转账，参数为转出地址`from`，接收地址`to`和`tokenId`。
- `safeTransferFrom`：安全转账（如果接收方是合约地址，会要求实现`ERC721Receiver`接口）。参数为转出地址`from`，接收地址`to`和`tokenId`。
- `approve`：授权另一个地址使用你的NFT。参数为被授权地址`approve`和`tokenId`。
- `getApproved`：查询`tokenId`被批准给了哪个地址。
- `setApprovalForAll`：将自己持有的该系列NFT批量授权给某个地址`operator`。
- `isApprovedForAll`：查询某地址的NFT是否批量授权给了另一个`operator`地址。
- `safeTransferFrom`：安全转账的重载函数，参数里面包含了`data`。 
4. [ERC165](https://eips.ethereum.org/EIPS/eip-165)
5. 荷兰拍卖合约实现
### 2024.09.29
WTF solidity41
1. WETH
   合约将用户传来的Eth转换为wrapped eth,即符合ERC20标准的代币，方便用户交互DAPP。用户也可销毁存储在合约中的WETH来换取eth  
### 2024.09.30
WTF solidity42
1. PaymentSplit  
   分账合约，通过构造器初始化各个账户所在份额，用户根据份额可通过合约将收益进行提款   
### 2024.10.01
WTF solidity43-44
1. 实现锁仓合约tokenLocker和tokenvest合约
### 2024.10.02
WTF solidity45
1. 实现时间锁合约
### 2024.10.03
WTF solidity16-18   
1. 库合约和普通合约区别：  
    - 不能存在状态变量
    - 不能够继承或被继承
    - 不能接收以太币
    - 不可以被销毁
2. library两种使用方法
   ``` solidity
   // 使用Strings库
   contract WTF17{
   
    // 1. 使用指令 using A for B, B类型可以直接使用A库内中方法并且该变量作为第一个参数参数 
    using Strings for uint256;

    function f1(uint256 _in) public pure returns (string memory) {
        return _in.toHexString();
    }

   // 2. 直接通过库名调用
    function f2(uint256 _in) public pure returns (string memory) {
        return Strings.toHexString(_in);
    }
   }
   ```
3. import三种引用方式
   ``` solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.21;

   // 1. 通过文件相对位置import
   import './Yeye.sol';
   // 通过全局符号导入特定的合约
   import {Yeye} from './Yeye.sol';
   // 2. 通过网址引用
   import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
   // 3. 通过npm的目录导入
   import '@openzeppelin/contracts/access/Ownable.sol';

   contract Import {
      // 成功导入Address库
       using Address for address;
      // 声明yeye变量
       Yeye yeye = new Yeye();

      // 测试是否能调用yeye的函数
      function test() external{
        yeye.hip();
      }
   }
   ```   
### 2024.10.04
WTF solidity19-20
1. receive和fallback
   两种特殊的回调方法，可用来接收以太（fallback用payable修饰时），当向合约转账未call指定方法（data域为空）则会调用receive(),
   若data域不为空但其函数未在合约中则调用fallback()
2. call,transfer,send使用
   ``` solidity
   
   // 2300 gas fee限制
   function transferEth(address payable _to, uint256 amount) external payable {
       _to.transfer(amount);
    }

    function sendEth(address payable _to, uint256 amount) external payable {
       bool success = _to.send(amount);
       if(!success) revert SendFailed();
    }

    // call可选择gas fee
    function callEth(address payable _to, uint256 amount) external payable {
       (bool success,) = _to.call{value:amount}("");
       if(!success) revert CallFailed();
    }
   ``` 
### 2024.10.05
WTF solidity21-23  
1. 调用其他合约    
   ``` solidity
   
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.23;
   import {OtherContract} from "./WTF21.sol";

   contract OtherCall{
    function callSetX(address _Address, uint256 x) external {
       OtherContract(_Address).setX(x);
    }

    function callGetX(OtherContract _Address) external view returns(uint) {
       return _Address.getX();
    }

    function callGetX2(address _Address) external view returns(uint) {
       OtherContract oc = OtherContract(_Address);
       return oc.getX();
    }

    // 调用合约并发送ETH
    function callSetXWithETH(address _Address, uint256 x) external payable {
       OtherContract(_Address).setX{value:msg.value}(x);
    }
   // 使用call调用getX()
    function callGetX3(address _Address) external returns(uint256) {
        (, bytes memory data) = _Address.call(abi.encodeWithSignature("getX()"));
        return abi.decode(data, (uint256));
    }

    // 使用call调用setX()
    function callSetX3(address _Address, uint x) external payable returns(uint256) {
        (, bytes memory data) = _Address.call{value:msg.value}(abi.encodeWithSignature("setX(uint256)",x));
        return abi.decode(data, (uint256));
    }

    // 使用call调用不存在的方法会报错
    function callFoo(address _Address, uint x) external payable returns(uint256) {
        (, bytes memory data) = _Address.call{value:msg.value}(abi.encodeWithSignature("Foo(uint256)",x));
        return abi.decode(data, (uint256));
    }
    }
   ```
2.  delegatecall  
    当B call C，上下文是C，当B delegetecall C，上下文为B  
### 2024.10.06
WTF solidity26-28  
1. selfdestruct  
   使用`selfdestruct(_target)`可进行合约自毁并将剩余以太转移到_target地址。
   `SELFDESTRUCT will recover all funds to the target but not delete the account, except when called in the same transaction as creation` 在Cancun硬分叉之后，只有合约创建和自毁在一个交易中才会删除合约
2. abi编码
   abi提供四种编码方式`encode/encodePacked/encodeWithSignature/encodeWithSelector`，`encodePacked`是`encode`的压缩版，
   `encodeWithSignature/encodeWithSelector`和函数有关生成的编码开头带有四字节的函数选择器，`encodeWithSignature`第一个参数为函数签名，`encodeWithSelector`第一个参数为函数选择器
   ``` solidity
   contract abi{
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xAA";
    uint[2] array = [5, 6]; 

    function encode() view external returns(bytes memory){
        return abi.encode(x,addr,name,array);
    } 

    function encodePacked() view external returns(bytes memory){
        return abi.encodePacked(x,addr,name,array);
    } 

    function encodeWithSignature() public view returns(bytes memory result) {
        result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
    }

    function encodeWithSelector() public view returns(bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")),
    x, addr, name, array);
    }
    }
   ```
3. solidity最常用的哈希函数keccak256     
### 2024.10.07
WTF solidity29-30
1. 函数选择器   
   发送给合约的calldata其实为合约中函数的method id和参数abi编码组成的16进制字节码，其中method id为函数签名`函数名（逗号分隔的参数类型)`
   后通过 keccak256 hash后的前四个字节
2. 计算method id -> `bytes4(keccak256("函数名(参数类型1,参数类型2,...)"))`
   - 基础类型参数中uint需写成uint256，int为int256
   - 固定长度类型参数 如uint8[3]写为uint8[3]
   - 可变长度类型参数 如address[]写为address[]
   - 映射类型参数 合约对象需转成address，结构体为(成员类型1,成员类型2,...)，枚举为uint8
3. try/catch     
### 2024.10.08
WTF solidity31-33
1. [ERC-20](https://eips.ethereum.org/EIPS/eip-20)  
   [OpenZeppelin实现](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC20)
2. IERC721函数
- `totalSupply`：返回代币总供给
- `balanceOf`：返回账户余额
- `transfer`：转账
- `allowance`：返回授权额度
- `approve`：授权
- `transferFrom`：授权转账 
3. 两个简单的ERC20应用合约faucet和airdrop   
### 2024.10.09
WTF solidity36-37
#### 以太坊中密码学应用
1. Merkle tree
   节点由hash关联，父节点为孩子节点的hash。其特征方便证明一个值是否存在于merkle tree当中，只需要提供merkle proof即可。比特币和以太坊
   中应用其验证交易是否存在
2. 签名
   以太坊中采用双椭圆曲线数字签名算法（ECDSA）
   1. 先将需要签名的信息进行`abi.encodePacked()`编码，再用`keccak256`进行hash
   2. 将处理过的信息前加上`"\x19Ethereum Signed Message:\n32"`字符，再用`keccak256`进行hash
   3. 将处理后的信息利用钱包和私钥进行签名
   4. 通过签名和处理后的信息获取公钥
      ``` solidity
      // @dev 从_msgHash和签名_signature中恢复signer地址
      function recoverSigner(bytes32 _msgHash, bytes memory _signature) internal pure returns (address){
        // 检查签名长度，rsv格式签名一般长度为65位，r32位，s32位，v1位
        require(_signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        // 目前只能用assembly (内联汇编)来从签名中获得r,s,v的值
        assembly {
            /*
            solidity中动态数组前32字节存的是数组的长度
            add(sig, 32) = sig的指针 + 32
            等效为略过signature的前32 bytes
            mload(p) 载入从内存地址p起始的接下来32 bytes数据
            */
            // 略过前32位获取r
            r := mload(add(_signature, 0x20))
            // 略过前64位获取r
            s := mload(add(_signature, 0x40))
            // 最后一个byte为v
            v := byte(0, mload(add(_signature, 0x60)))
        }
        // 使用ecrecover(全局函数)：利用 msgHash 和 r,s,v 恢复 signer 地址
        return ecrecover(_msgHash, v, r, s);
      }
      ```
### 2024.10.10
WTF solidity38-39 
1. nftswap合约实现
### 2024.10.11
WTF solidity40
1. ERC1155
   较ERC20和ERC721不同，ERC1155标准允许一个合约中包含多个同质化和非同质化代币，每一种代币有一个id来标识。`mapping(uint256 => mapping(address => uint256)) private _balances`
### 2024.10.12
WTF solidity46-50
1. 代理模式  
   合约在部署之后无法修改，为了更改和升级可采用代理模式。代理模式将合约数据和逻辑分开，数据存在代理合约中，逻辑则写在
   逻辑合约里，用户直接调用代理合约，代理合约再通过delegate call调用逻辑合约
2. 合约升级  
   升级合约只需要管理者调用升级函数修改代理合约里的逻辑合约地址即可
3. 相关问题  
   由于代理合约和逻辑为不同合约，所以两个合约可能产生选择器冲突问题，即用户在调用逻辑合约中相关函数，由于该函数的method id和代理合约中的函数的method id相同。解决方案（针对代理合约中升级函数和逻辑合约中的函数选择器冲突）：
   - `透明代理`代理合约里的升级函数智能管理员调用，管理员不可以调用逻辑合约里的函数
   - `可升级代理（uups，universal upgradeable proxy standard）`将升级函数写在逻辑合约中
4. 实现多签钱包合约
### 2024.10.14
WTF solidity51-53
### 2024.10.15
WTF solidity54-57
<!-- Content_END -->
