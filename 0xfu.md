---
timezone: Asia/Shanghai
---


# 0xfu

1. 自我介绍

  大家好，我是0xfu，有5年 Golang 开发经验，熟悉 Solidity 和 React，加入共学营和大家一起学习!

2. 你认为你会完成本次残酷学习吗？

  一定可以的!!!

## Notes

已经学习过101、102课程并且获得WTF链上证书，本次共学以学习103课程为主，同时巩固之前的学习。

学习计划：

- 103课程从31-57节从27节课程，在22天的共学期间完成学习

- 对于有深度的章节进行拓展学习，并输出技术文章	



<!-- Content_START -->

### 2024.09.23

#### ERC20代币标准

ERC20代币标准规定了一个同质化代币（合约）要满足的基本功能（函数）, 如下：

- 账户余额(balanceOf())
- 转账(transfer())
- 授权转账(transferFrom())
- 授权(approve())
- 代币总供给(totalSupply())
- 授权转账额度(allowance())

由 **IERC20** 接口合约定义规范，**IERC20** 是 **ERC20** 代币标准的接口合约，接口和 Golang 中的接口一样，只定义规范不定义实现，由继承接口的合约完成函数的实现。对于外部调用者来说，合约通过继承接口的方式约定了其可以被调用的函数集合（实现的功能）。

#### 拓展

由接口原理可知 **ERC20** 合约不是必须要继承 **IERC20** 接口的，只要实现了 **ERC20** 标准需要的功能函数就可以算是一个 **ERC20** 合约；但是继承接口可以确保合约实现 **ERC20** 标准所需的所有功能和事件，从而保证与其他合约和工具的兼容性; 不继承可能导致与其他依赖 **ERC20** 标准的工具或合约的兼容性问题，所以现在继承 **IERC20** 接口是普遍的做法。

对于调用方来说，尤其一个功能复杂的 Dapp， 为了避免意外的错误，可以用 **supportsInterface** 方法检查合约是否符合预期的标准接口，帮助调用者动态确认合约的功能，避免在调用不存在的方法时导致错误，同时提高合约的灵活性和安全性。

**supportsInterface** 是 **ERC165** 提出的，**ERC165** 合约用于检测合约是否支持特定的接口。其主要目的是允许合约在运行时声明它们支持的接口，从而实现更好的互操作性。 对于一个ERC20合约，可以通过继承 **ERC165** 合约来支持这种检测。

**supportsInterface** 实现：

```Solidity

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is IERC20, ERC165 {
    // 实现 IERC20 的方法...

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC20).interfaceId || super.supportsInterface(interfaceId);
    }
}

```

为什么有的著名的 **ERC20** 合约没有继承 **IERC20** 和 **ERC165** ？

由于历史原因，很多著名合约发布时 **IERC20** 标准和 **ERC165** 标准还没有普遍采用，许多早期合约并没有成熟的标准可以参考，所以都没有继承这些后期确定的标准。


### 


### 2024.09.24

#### 水龙头合约

实现了一个水龙头合约，用户通过调用 **requestToken()** 函数获取测试代币。

#### 拓展：

通过合约实现的水龙头如何规避女巫和限制领水速率？
一般的水龙头都是使用主钱包利用web2接口调用转账方法进行控制的，本次实现的水龙头合约只是为了学习使用，不具有业务参考意义。


### 


### 2024.09.25

#### 空投合约

在空投合约中需要注意：

- 检查 **_addresses** 和 **_amounts** 的长度是否一致
- 检查空投合约的授权额度是否大于要空投的代币数量总和

#### 安全问题

因为空投合约中会使用到循环逻辑，对于循环逻辑要非常谨慎安全问题，尤其是注意 [Dos攻击](https://github.com/AmazingAng/WTF-Solidity/blob/main/S09_DoS/readme.md) 。

### 


### 2024.09.26

#### ERC721代币标准

ERC721标准是为了抽象非同质化的物品，相比于ERC20代币，很多实物是无法非同质化的，不能用同质化代币来抽象。满足ERC721
标准的代币称为 NFT。

#### EIP 和 ERC

EIP可以是 Ethereum 生态中任意领域的改进, 比如新特性、ERC、协议改进、编程工具等等。

ERC全称 Ethereum Request For Comment (以太坊意见征求稿), 用以记录以太坊上应用级的各种开发标准和协议。如典型的
Token标准(ERC20, ERC721)、名字注册(ERC26, ERC13), URI范式(ERC67), Library/Package格式(EIP82), 钱包格式(EIP75,EIP85)。

#### IERC721Receiver 接口合约

如果一个合约没有实现ERC721的相关函数，转入的NFT就进了黑洞，永远转不出来了。为了防止误转账，ERC721实现了
safeTransferFrom()安全转账函数，目标合约必须实现了IERC721Receiver接口才能接收ERC721代币，不然会revert。
IERC721Receiver接口只包含一个onERC721Received()函数。

```Solidity
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
```

#### IERC721Metadata

IERC721Metadata 是 ERC721 的拓展接口，实现了3个查询metadata元数据的常用函数：

```Solidity
interface IERC721Metadata is IERC721 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 tokenId) external view returns (string memory);
}
```



ERC721 主合约实现了IERC721，IERC165 和 IERC721Metadata 接口合约，在开发自己的
NFT 合约时可以通过继承 ERC721 合约从而快速高效的进行业务开发。

### 


### 2024.09.27

#### 荷兰拍

荷兰拍卖（Dutch Auction）是一种特殊的拍卖形式, 指拍卖标的的竞价由高到低依次递减，参与者在看到当前价格后，可以选
择立即购买（出价）或等待进一步降价, 最先出价的买家将获得商品。


特点：
- 透明性：价格逐渐降低，所有参与者可以看到当前价格，有助于形成公平竞争环境。
- 效率：通过时间限制和逐步降价，能够快速达成交易，减少了漫长的谈判过程。
- 真实需求反映：买家可以根据自己的需求决定出价，有助于更好地反映市场需求。
- 减少库存风险：对于卖家来说，荷兰拍可以帮助更快地清理库存，降低持有成本。
- 吸引竞争：可以通过逐步降价吸引更多买家参与，增加成交的可能性。


web3荷兰拍的案例：

- Azuki(Azuki通过荷兰拍卖筹集了超过8000枚ETH)
- World of Women



#### BeraAl 荷兰拍合约

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BeraApDutchAuction is Ownable, ERC721 {
    uint256 public constant COLLECTION_SIZE = 10000; // NFT总数
    uint256 public constant AUCTION_START_PRICE = 1 ether; // 起拍价
    uint256 public constant AUCTION_END_PRICE = 0.1 ether; // 结束价（最低价）
    uint256 public constant AUCTION_TIME = 10 minutes; // 拍卖时间
    uint256 public constant AUCTION_DROP_INTERVAL = 1 minutes; // 每过多久时间，价格衰减一次
    uint256 public constant AUCTION_DROP_PER_STEP =
        (AUCTION_START_PRICE - AUCTION_END_PRICE) /
        (AUCTION_TIME / AUCTION_DROP_INTERVAL); // 每次价格衰减步长
    
    uint256 public auctionStartTime; // 拍卖开始时间戳
    string private _baseTokenURI;   // metadata URI
    uint256[] private _allTokens; // 记录所有存在的tokenId 

    constructor() Ownable(msg.sender) ERC721("BeraAp Dutch Auction", "BERAAP") {
        auctionStartTime = block.timestamp;
    }


    function totalSupply() public view virtual returns (uint256) {
        return _allTokens.length;
    }

   
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }

    // 拍卖mint函数
    function auctionMint(uint256 quantity) external payable{
        uint256 _saleStartTime = uint256(auctionStartTime); // 建立local变量，减少gas花费
        require(_saleStartTime != 0 && block.timestamp >= _saleStartTime, "sale has not started yet"); // 检查是否设置起拍时间，拍卖是否开始
        require(totalSupply() + quantity <= COLLECTION_SIZE, "not enough remaining reserved for auction to support desired mint amount"); // 检查是否超过NFT上限

        uint256 totalCost = getAuctionPrice() * quantity; // 计算mint成本
        require(msg.value >= totalCost, "Need to send more ETH."); // 检查用户是否支付足够ETH
        
        // Mint NFT
        for(uint256 i = 0; i < quantity; i++) {
            uint256 mintIndex = totalSupply();
            _mint(msg.sender, mintIndex);
            _addTokenToAllTokensEnumeration(mintIndex);
        }
        // 多余ETH退款
        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost); //注意一下这里是否有重入的风险
        }
    }

    // 获取拍卖实时价格
    function getAuctionPrice() public view returns (uint256) {
        if (block.timestamp < auctionStartTime) {
			return AUCTION_START_PRICE;
        }else if (block.timestamp - auctionStartTime >= AUCTION_TIME) {
			return AUCTION_END_PRICE;
        } else {
			uint256 steps = (block.timestamp - auctionStartTime) / AUCTION_DROP_INTERVAL;
			return AUCTION_START_PRICE - (steps * AUCTION_DROP_PER_STEP);
        }
    }

    function setAuctionStartTime(uint32 timestamp) external onlyOwner {
        auctionStartTime = timestamp;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }
}


```

### 



### 2024.09.28 

提交被覆盖，待补充

###


### 2024.09.29

#### 数字签名

以太坊使用的数字签名算法叫双椭圆曲线数字签名算法（ECDSA），基于双椭圆曲线“私钥-公钥”对的数字签名算法。

ECDSA:
- 公钥
- 私钥


NFT项目方可以利用ECDSA的验证特性发放白名单，而且签名是线下的不需要Gas，经济又方便。

```Solidity

contract SignatureNFT is ERC721 {
    address immutable public signer; // 签名地址
    mapping(address => bool) public mintedAddress;   // 记录已经mint的地址

    // 构造函数，初始化NFT合集的名称、代号、签名地址
    constructor(string memory _name, string memory _symbol, address _signer)
    ERC721(_name, _symbol)
    {
        signer = _signer;
    }

    // 利用ECDSA验证签名并mint
    function mint(address _account, uint256 _tokenId, bytes memory _signature)
    external
    {
        bytes32 _msgHash = getMessageHash(_account, _tokenId); // 将_account和_tokenId打包消息
        bytes32 _ethSignedMessageHash = ECDSA.toEthSignedMessageHash(_msgHash); // 计算以太坊签名消息
        require(verify(_ethSignedMessageHash, _signature), "Invalid signature"); // ECDSA检验通过
        require(!mintedAddress[_account], "Already minted!"); // 地址没有mint过


        mintedAddress[_account] = true; // 记录mint过的地址, 防止重入攻击
        _mint(_account, _tokenId); // mint
    }

    function getMessageHash(address _account, uint256 _tokenId) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_account, _tokenId));
    }

    function verify(bytes32 _msgHash, bytes memory _signature) public view returns (bool) {
        return ECDSA.verify(_msgHash, _signature, signer);
    }
}
```

###



### 2024.09.30


#### NFT 交易所

用Solidity搭建一个零手续费的NFT交易所
- 卖家：出售NFT的一方，可以挂单list、撤单revoke、修改价格update。
- 买家：购买NFT的一方，可以购买purchase。
- 订单：卖家发布的NFT链上订单，一个系列的同一tokenId最多存在一个订单，其中包含挂单价格price和持有人owner信息。当一个订单交易完成或被撤单后，其中信息清零。


#### 合约事件

```Solidity
event List(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
event Purchase(address indexed buyer, address indexed nftAddr, uint256 indexed tokenId, uint256 price);
event Revoke(address indexed seller, address indexed nftAddr, uint256 indexed tokenId);
event Update(address indexed seller, address indexed nftAddr, uint256 indexed tokenId, uint256 newPrice);
```

###


### 2024.10.1

#### 随机数

由于以太坊上所有数据都是公开透明（public）且确定性（deterministic）的，没法像其他编程语言一样给
开发者提供生成随机数的方法，在web3上可以使用链上或链下方法生成随机数。


#### 链上随机数生成
可以将一些链上的全局变量作为种子，利用keccak256()哈希函数来获取伪随机数。

```Solidity
function getRandomOnchain() public view returns(uint256){
    bytes32 randomBytes = keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number-1)));

    return uint256(randomBytes);
}
```
这种方法因为使用的种子数据都是公开的， 所以使用者可以预测出这些种子生成的随机数, 其次旷工可以操纵 blockhash 和 
block.timestamp 使得生成的随机数符合他的利益。

###



### 2024.10.2

#### ERC1155 


以太坊EIP1155提出了一个多代币标准ERC1155，允许一个合约包含多个同质化和非同质化代币。ERC1155在GameFi应用最多，
Decentraland、Sandbox等知名链游都使用它。


在ERC1155中，每一种代币都有一个id作为唯一标识，每个id对应一种代币。这样代币种类就可以非同质的在同一个合约里
管理了，并且每种代币都有一个网址uri来存储它的元数据，类似ERC721的tokenURI。


#### ERC1155的元数据接口合约IERC1155MetadataURI

```Solidity
interface IERC1155MetadataURI is IERC1155 {
    /**
     * @dev 返回第`id`种类代币的URI
     */
    function uri(uint256 id) external view returns (string memory);
}

```

如果某个id对应的代币总量为1，就是非同质化代币；如果某个id对应的代币总量大于1，就是同质化代币，因为这些代币都
分享同一个id，类似ERC20。


#### IERC1155 合约

IERC1155接口合约抽象了EIP1155需要实现的功能，其中包含4个事件和6个函数。与ERC721不同，因为ERC1155包含多类代币，它实
现了批量转账和批量余额查询，可以一次操作多种代币。



#### ERC1155 接收合约

与ERC721标准类似，为了避免代币被转入黑洞合约，ERC1155要求代币接收合约继承IERC1155Receiver并实现两个接收函数：

- onERC1155Received()：单币转账接收函数，接受ERC1155安全转账safeTransferFrom 需要实现并返回自己的选择器0xf23a6e61。

- onERC1155BatchReceived()：多币转账接收函数，接受ERC1155安全多币转账safeBatchTransferFrom 需要实现并返回自己的选择器0xbc197c81。


###



<!-- Content_END -->
