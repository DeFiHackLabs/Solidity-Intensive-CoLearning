---
timezone: Asia/Taipei
---

---

1. 大約十年安卓開發。想學合約很久了，有很多問題想問。側鏈和L2的差異。OP Stack為什麼那麼快就可以建一條新鏈。POS的安全性如何保證，是靠質押越多越安全？僅剩少數質押者是不是也不去中心。

2. 你认为你会完成本次残酷学习吗？ 應該會

<!-- Content_START -->

### 2024.09.22
學習內容: 
報名

### 2024.09.23
學習內容: 
使用Remix, 跑Hellow,word。
ps.每按一次deploy 按鈕,會部署一次合約

### 2024.09.24
認識一些value type,變數宣告時先型態，再public

### 2024.09.25
function的結構
function有三種權限，pure, view, payable<br>
payable或不指定要花 gas<br>
pure, view不花 gas<br>

### 2024.09.26
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}

// 命名式返回
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return( 2, false, [uint256(3),2,1]);
}

但修飾詞memory要到下一課才有解釋。

### 2024.09.27
array和 struct 需要的儲存空間比較大故需指定類型, storage在鏈上, memory和 calldata在 local，比較省gas.
今天首次操作debug, 原來要是live debug,要按 forward才會變動

### 2024.09.28
array和struct的使用，先看快速掃過。
array型態在第一個元素宣告即可。如果使用memory則是固定長度。

### 2024.09.29
mapping可以認知為dictionary, key-value pair
key只允許內建型態，value可以使用自定義struct

### 2024.09.30
變數的初始值，delete操作符可以讓變數恢復初始值。

### 2024.10.01
設置常數有兩種 constant, immutable，immutable可以在 constructor才指定。
指定常數可以省gas。
string和 bytes不能用 immutable修飾。

string public immutable _string = "Hello Web3! 0923-2"; => X
TypeError: Immutable variables cannot have a non-value type.

### 2024.10.02
solidity版的 insert sort的眉角是
uint，也就是正整数，取到负值的话，会报underflow错误。而在插入算法中，变量j有可能会取到-1，引起报错。

### 2024.10.03
學習 constructor,和修飾function的修飾器, 可以自定義修飾器

### 2024.10.04
將101完結，且做考題。
interface那邊，對於選擇器怎麼理解比較好，就是一個指標，給呼叫者指過去?

### 2024.10.05
WTF solidity 102開始

### 2024.10.06
1.solidity的function可以overloading, 目前自己尚未有應用的實例
2.使用 library有兩種，
一種是 using A for B, 將B擴展功能．Kotlin也有這樣的功能．
另一種是直接使用，例如 String.toHexString()．

### 2024.10.07
先記錄補充教材
來自SunSec整理
DEV - Learning Solidity, Blockchain, DeFi
https://github.com/Cyfrin/foundry-full-course-f23
https://www.levelupweb3.xyz/solidity
https://github.com/ethereumbook/ethereumbook
https://cryptozombies.io/
https://solidity-by-example.org/
https://github.com/OffcierCia/DeFi-Developer-Road-Map 
https://github.com/LearnWeb3DAO/14-Days-of-Solidity 
https://github.com/0xronin/30-days-SmartContractProgrammer
https://github.com/OffcierCia/DeFi-Developer-Road-Map
https://www.youtube.com/watch?v=hMwdd664_iw&list=PLO5VPQH6OWdULDcret0S0EYQ7YcKzrigz
https://www.youtube.com/watch?v=M576WGiDBdQ
https://www.youtube.com/watch?v=wXo3S8k1ueg&list=PLgPmWS2dQHW9u6IXZq5t5GMQTpW7JL33i
https://www.youtube.com/playlist?list=PLFcDwmPMBkzu5xMbFh3Vi1COI3bAoBaSI

### 2024.10.08
import和 receive

### 2024.10.09
調用其他合約和詳解call
一個合約錢包預設即有 receive和send功能

### 2024.10.10
在合約中創建合約 is done.

### 2024.10.11
`create`的合約地址不好預測

CREATE2的目的是为了让合约地址独立于未来的事件。不管未来区块链上发生了什么，你都可以把合约部署在事先计算好的地址上。用CREATE2创建的合约地址由4个部分决定：
新地址 = hash("0xFF",创建者地址, salt, initcode)

### 2024.10.12
在以太坊坎昆（Cancun）升级中，EIP-6780被纳入升级以实现对Verkle Tree更好的支持。EIP-6780减少了SELFDESTRUCT操作码的功能。根据提案描述，当前SELFDESTRUCT仅会被用来将合约中的ETH转移到指定地址，而原先的删除功能只有在合约创建-自毁这两个操作处在同一笔交易时才能生效。所以目前来说：

已经部署的合约无法被SELFDESTRUCT了。
如果要使用原先的SELFDESTRUCT功能，必须在同一笔交易中创建并SELFDESTRUCT。

### 2024.10.13
1.
Keccak256和sha3
这是一个很有趣的事情：

sha3由keccak标准化而来，在很多场合下Keccak和SHA3是同义词，但在2015年8月SHA3最终完成标准化时，NIST调整了填充算法。所以SHA3就和keccak计算的结果不一样，这点在实际开发中要注意。
以太坊在开发的时候sha3还在标准化中，所以采用了keccak，所以Ethereum和Solidity智能合约代码中的SHA3是指Keccak256，而不是标准的NIST-SHA3，为了避免混淆，直接在合约代码中写成Keccak256是最清晰的。

2.
method id、selector和函数签名
method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数

### 2024.10.14
水龍頭合約，
我们在水龙头合约中定义3个状态变量
amountAllowed设定每次能领取代币数量（默认为100，不是一百枚，因为代币有小数位数）。
tokenContract记录发放的ERC20代币合约地址。
requestedAddress记录领取过代币的地址。

空投合約，
multiTransferToken()函数：发送ERC20代币空投，包含3个参数：
_token：代币合约地址（address类型）
_addresses：接收空投的用户地址数组（address[]类型）
_amounts：空投数量数组，对应_addresses里每个地址的数量（uint[]类型）
该函数有两个检查：第一个require检查了_addresses和_amounts两个数组长度是否相等；第二个require检查了空投合约的授权额度大于要空投的代币数量总和。

### 2024.10.15
利用Merkle Tree发放NFT白名单
一份拥有800个地址的白名单，更新一次所需的gas fee很容易超过1个ETH。而由于Merkle Tree验证时，leaf和proof可以存在后端，链上仅需存储一个root的值，非常节省gas，项目方经常用它来发放白名单。很多ERC721标准的NFT和ERC20标准代币的白名单/空投都是利用Merkle Tree发出的，比如optimism的空投。

但有個疑問，參數需要輸入地址陣列，這個錢包地址陣列一定是兩個嗎，又要如何找到。

利用签名发放白名单
NFT项目方可以利用ECDSA的这个特性发放白名单。由于签名是链下的，不需要gas，因此这种白名单发放模式比Merkle Tree模式还要经济。方法非常简单，项目方利用项目方账户把白名单发放地址签名（可以加上地址可以铸造的tokenId）。然后mint的时候利用ECDSA检验签名是否有效，如果有效，则给他mint。

### 2024.10.16
代币锁
为什么要锁定流动性？
如果项目方毫无征兆的撤出流动性池中的LP代币，那么投资者手中的代币就无法变现，直接归零了。这种行为也叫rug-pull，仅2021年，各种rug-pull骗局从投资者那里骗取了价值超过28亿美元的加密货币。

代币锁合约
开发者在部署合约时规定锁仓的时间，受益人地址，以及代币合约。
开发者将代币转入TokenLocker合约。
在锁仓期满，受益人可以取走合约里的代币。

时间锁
在区块链，时间锁被DeFi和DAO大量采用。它是一段代码，他可以将智能合约的某些功能锁定一段时间。它可以大大改善智能合约的安全性，举个例子，假如一个黑客黑了Uniswap的多签，准备提走金库的钱，但金库合约加了2天锁定期的时间锁，那么黑客从创建提钱的交易，到实际把钱提走，需要2天的等待期。在这一段时间，项目方可以找应对办法，投资者可以提前抛售代币减少损失。

时间锁合约
在创建Timelock合约时，项目方可以设定锁定期，并把合约的管理员设为自己。

时间锁主要有三个功能：
创建交易，并加入到时间锁队列。
在交易的锁定期满后，执行交易。
后悔了，取消时间锁队列中的某些交易。
项目方一般会把时间锁合约设为重要合约的管理员，例如金库合约，再通过时间锁操作他们。

时间锁合约的管理员一般为项目的多签钱包，保证去中心化。




<!-- Content_END -->
