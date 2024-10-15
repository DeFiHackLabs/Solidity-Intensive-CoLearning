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


### 2024.10.3

####  WETH

当 ERC20 标准出现的时候， ETH本身并不符合 ERC20 标准，为了提高ETH在链上的互操作性，并使 ETH 可被用在 Dapp 中, 
WTH 只是对 ETH 进行封装以符合 ERC20 标准。


#### WETH 合约

目前在用的主网WETH合约写于2015年，那时候solidity是0.4版本，用0.8版本重新写一个WETH。
- 存款：包装，用户将ETH存入WETH合约，并获得等量的WETH。
- 取款：拆包装，用户销毁WETH，并获得等量的ETH。


```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20{
    // 事件：存款和取款
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    // 构造函数，初始化ERC20的名字和代号
    constructor() ERC20("WETH", "WETH"){
    }

    // 回调函数，当用户往WETH合约转ETH时，会触发deposit()函数
    fallback() external payable {
        deposit();
    }
    // 回调函数，当用户往WETH合约转ETH时，会触发deposit()函数
    receive() external payable {
        deposit();
    }

    // 存款函数，当用户存入ETH时，给他铸造等量的WETH
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    // 提款函数，用户销毁WETH，取回等量的ETH
    function withdraw(uint amount) public {
        require(balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}
```

###



### 2024.10.4

#### 分账
可以事先把每个人应分的比例写在智能合约中，获得收入后，再由智能合约来进行分账。

#### 分账合约

分账合约(PaymentSplit)具有以下几个特点：
- 在创建合约时定好分账受益人payees和每人的份额shares。
- 份额可以是相等，也可以是其他任意比例。
- 在该合约收到的所有ETH中，每个受益人将能够提取与其分配的份额成比例的金额。
- 分账合约遵循Pull Payment模式，付款不会自动转入账户，而是保存在此合约中。受益人通过调用release()函数触发实际转账。

```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * 分账合约 
 * @dev 收到ETH会存在分账合约中，需要每个受益人调用release()函数来领取。
 */
contract PaymentSplit{
    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合约收款事件

    uint256 public totalShares; // 总份额
    uint256 public totalReleased; // 总支付

    mapping(address => uint256) public shares; // 每个受益人的份额
    mapping(address => uint256) public released; // 支付给每个受益人的金额
    address[] public payees; // 受益人数组

    /**
     * @dev 初始化受益人数组_payees和分账份额数组_shares
     * 数组长度不能为0，两个数组长度要相等。_shares中元素要大于0，_payees中地址不能为0地址且不能有重复地址
     */
    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // 检查_payees和_shares数组长度相同，且不为0
        require(_payees.length == _shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(_payees.length > 0, "PaymentSplitter: no payees");
        // 调用_addPayee，更新受益人地址payees、受益人份额shares和总份额totalShares
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }

    /**
     * @dev 回调函数，收到ETH释放PaymentReceived事件
     */
    receive() external payable virtual {
        emit PaymentReceived(msg.sender, msg.value);
    }

    /**
     * @dev 为有效受益人地址_account分帐，相应的ETH直接发送到受益人地址。任何人都可以触发这个函数，但钱会打给account地址。
     * 调用了releasable()函数。
     */
    function release(address payable _account) public virtual {
        // account必须是有效受益人
        require(shares[_account] > 0, "PaymentSplitter: account has no shares");
        // 计算account应得的eth
        uint256 payment = releasable(_account);
        // 应得的eth不能为0
        require(payment != 0, "PaymentSplitter: account is not due payment");
        // 更新总支付totalReleased和支付给每个受益人的金额released
        totalReleased += payment;
        released[_account] += payment;
        // 转账
        _account.transfer(payment);
        emit PaymentReleased(_account, payment);
    }

    /**
     * @dev 计算一个账户能够领取的eth。
     * 调用了pendingPayment()函数。
     */
    function releasable(address _account) public view returns (uint256) {
        // 计算分账合约总收入totalReceived
        uint256 totalReceived = address(this).balance + totalReleased;
        // 调用_pendingPayment计算account应得的ETH
        return pendingPayment(_account, totalReceived, released[_account]);
    }

    /**
     * @dev 根据受益人地址`_account`, 分账合约总收入`_totalReceived`和该地址已领取的钱`_alreadyReleased`，计算该受益人现在应分的`ETH`。
     */
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // account应得的ETH = 总应得ETH - 已领到的ETH
        return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased;
    }

    /**
     * @dev 新增受益人_account以及对应的份额_accountShares。只能在构造器中被调用，不能修改。
     */
    function _addPayee(address _account, uint256 _accountShares) private {
        // 检查_account不为0地址
        require(_account != address(0), "PaymentSplitter: account is the zero address");
        // 检查_accountShares不为0
        require(_accountShares > 0, "PaymentSplitter: shares are 0");
        // 检查_account不重复
        require(shares[_account] == 0, "PaymentSplitter: account already has shares");
        // 更新payees，shares和totalShares
        payees.push(_account);
        shares[_account] = _accountShares;
        totalShares += _accountShares;
        // 释放增加受益人事件
        emit PayeeAdded(_account, _accountShares);
    }
}
```

###


### 2024.10.5

#### 线性释放
项目方一般会约定代币归属条款（token vesting），在归属期内逐步释放代币，减缓抛压，并防止团队和资本
方过早躺平, 线性释放指的是代币在归属期内匀速释放。

### 

### 2024.10.6

#### 代币锁

代币锁(Token Locker)是一种简单的时间锁合约，它可以把合约中的代币锁仓一段时间，受益人在
锁仓期满后可以取走代币。
代币锁一般是用来锁仓流动性提供者LP代币的。

#### 代币锁合约

锁仓ERC20代币的合约TokenLocker:
- 在部署合约时规定锁仓的时间，受益人地址，以及代币合约
- 将代币转入TokenLocker合约
- 在锁仓期满，受益人可以取走合约里的代币


```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenLocker {

    // 事件
    event TokenLockStart(address indexed beneficiary, address indexed token, uint256 startTime, uint256 lockTime);
    event Release(address indexed beneficiary, address indexed token, uint256 releaseTime, uint256 amount);

    // 被锁仓的ERC20代币合约
    IERC20 public immutable token;
    // 受益人地址
    address public immutable beneficiary;
    // 锁仓时间(秒)
    uint256 public immutable lockTime;
    // 锁仓起始时间戳(秒)
    uint256 public immutable startTime;

    constructor(IERC20 token_, address beneficiary_, uint256 lockTime_) {
        require(lockTime_ > 0, "TokenLock: lock time should greater than 0");

        token = token_;
        beneficiary = beneficiary_;
        lockTime = lockTime_;
        startTime = block.timestamp;

        emit TokenLockStart(beneficiary_, address(token_), block.timestamp, lockTime_);
    }

    // 在锁仓时间过后，将代币释放给受益人。
    function release() public {
        require(block.timestamp >= startTime+lockTime, "TokenLock: current time is before release time");

        uint256 amount = token.balanceOf(address(this));
        require(amount > 0, "TokenLock: no tokens to release");

        token.transfer(beneficiary, amount);

        emit Release(msg.sender, address(token), block.timestamp, amount);
    }
}
```


###


### 2024.10.7

#### 时间锁

可以将智能合约的某些功能锁定一段时间，大大改善智能合约的安全性。

#### Timelock

在创建Timelock合约时可以设定锁定期，并把合约的管理员设为自己。

时间锁主要有三个功能：
- 创建交易，并加入到时间锁队列
- 在交易的锁定期满后，执行交易
- 取消时间锁队列中的某些交易

项目方一般会把时间锁合约设为重要合约的管理员，例如金库合约，再通过时间锁操作。 时间锁合约的管
理员一般为项目的多签钱包，保证去中心化。

Timelock合约中共有2个modifier:
- onlyOwner()：被修饰的函数只能被管理员执行
- onlyTimelock()：被修饰的函数只能被时间锁合约执行


```Solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Timelock{
    event CancelTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    event ExecuteTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature,  bytes data, uint executeTime);
    event QueueTransaction(bytes32 indexed txHash, address indexed target, uint value, string signature, bytes data, uint executeTime);
    event NewAdmin(address indexed newAdmin);

    address public admin; // 管理员地址
    uint public constant GRACE_PERIOD = 7 days; // 交易有效期，过期的交易作废
    uint public delay; // 交易锁定时间 （秒）
    mapping (bytes32 => bool) public queuedTransactions; // txHash到bool，记录所有在时间锁队列中的交易

    // onlyOwner modifier
    modifier onlyOwner() {
        require(msg.sender == admin, "Timelock: Caller not admin");
        _;
    }

    // onlyTimelock modifier
    modifier onlyTimelock() {
        require(msg.sender == address(this), "Timelock: Caller not Timelock");
        _;
    }

    constructor(uint delay_) {
        delay = delay_;
        admin = msg.sender;
    }

	// 即使使用了 onlyTimelock 也可以将函数的可见性设置为 public, 提高接口的清晰性
	// TODO: 是不是设置为 private 更合适?
	// changeAdmin  的调用是在本合约内利用 ExecuteTransaction 执行
    function changeAdmin(address newAdmin) public onlyTimelock {
        admin = newAdmin;

        emit NewAdmin(newAdmin);
    }

    function queueTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner returns (bytes32) {
        // 检查：交易执行时间满足锁定时间
        require(executeTime >= getBlockTimestamp() + delay, "Timelock::queueTransaction: Estimated execution block must satisfy delay.");
        // 计算交易的唯一识别符：一堆东西的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 将交易添加到队列
        queuedTransactions[txHash] = true;

        emit QueueTransaction(txHash, target, value, signature, data, executeTime);
        return txHash;
    }

    function cancelTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public onlyOwner{
        // 计算交易的唯一识别符：一堆东西的hash
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 检查：交易在时间锁队列中
        require(queuedTransactions[txHash], "Timelock::cancelTransaction: Transaction hasn't been queued.");
        // 将交易移出队列
        queuedTransactions[txHash] = false;

        emit CancelTransaction(txHash, target, value, signature, data, executeTime);
    }

    function executeTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 executeTime) public payable onlyOwner returns (bytes memory) {
        bytes32 txHash = getTxHash(target, value, signature, data, executeTime);
        // 检查：交易是否在时间锁队列中
        require(queuedTransactions[txHash], "Timelock::executeTransaction: Transaction hasn't been queued.");
        // 检查：达到交易的执行时间
        require(getBlockTimestamp() >= executeTime, "Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
        // 检查：交易没过期
       require(getBlockTimestamp() <= executeTime + GRACE_PERIOD, "Timelock::executeTransaction: Transaction is stale.");
        // 将交易移出队列
        queuedTransactions[txHash] = false;

        // 获取call data
        bytes memory callData;
        if (bytes(signature).length == 0) {
            callData = data;
        } else {
			// 这里如果采用encodeWithSignature的编码方式来实现调用管理员的函数，请将参数data的类型改为address。
			// 不然会导致管理员的值变为类似"0x0000000000000000000000000000000000000020"的值。
			// 其中的0x20是代表字节数组长度的意思.
            callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
        }
        // 利用call执行交易
        (bool success, bytes memory returnData) = target.call{value: value}(callData);
        require(success, "Timelock::executeTransaction: Transaction execution reverted.");

        emit ExecuteTransaction(txHash, target, value, signature, data, executeTime);

        return returnData;
    }

    function getBlockTimestamp() public view returns (uint) {
        return block.timestamp;
    }

    function getTxHash(address target, uint value, string memory signature, bytes memory data, uint executeTime) public pure returns (bytes32) {
        return keccak256(abi.encode(target, value, signature, data, executeTime));
    }
}
```

### 

### 2024.10.8

#### [代理合约](./content/0xfu/ProxyContract.md)

### 

### 2024.10.9

#### [可升级合约](./content/0xfu/UpgradeContract.md)

### 

### 2024.10.10

#### [透明代理](./content/0xfu/TransparentProxy.md)

### 
 
### 2024.10.11

#### [多签钱包](./content/0xfu/MultisigWallet.md)

### 


### 2024.10.12

#### [ERC4626](./content/0xfu/ERC4626.md)

### 


### 2024.10.13

#### [ERC712](./content/0xfu/EIP712.md)

### 


### 2024.10.14

#### [ERC20Permit](./content/0xfu/ERC20Permit.md)

### 

<!-- Content_END -->
