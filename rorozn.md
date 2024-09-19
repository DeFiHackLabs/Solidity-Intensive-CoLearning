---
timezone: Asia/Shanghai
---

# rorozn

1. 自我介绍:  
   web2 转全职 web3 萌新, 希望找个 remote 工作

2. 你认为你会完成本次残酷学习吗？  
   会！学完试着参加黑客松

## Notes

<!-- Content_START -->

### 2024.09.15

#### **1.三行代码**

- 软件许可最好写上
- 注意结尾;号
- 注意 pragma 拼写，a 不是 o！

```solidity
// SPDX-License-Identifier:MIT

pragma solidity>=0.8.21; //solidity版本 ^相当于>=

contract HelloWeb3{ //合约内容
    string public _string = "Hello Web3!!";
}
```

- 部署 deploy 向链上写入代码，要消耗 gas 的

#### **2.值类型**

- payable 关键字：账户相关，可以转账、查余额
- bytes1 有 2 个 16 进制，0xff，bytes32 就有 64 个 16 进制，1 个 16 进制位=2\*\*4，bytes32=32\*2\*4=256 个 0
- [运算符优先级](https://docs.soliditylang.org/zh/v0.8.19/cheatsheet.html)

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract ValueType{
    bool public _bool= true;
    int public  _int = -1;
    uint public _uint =1;
    uint256 public _number= 20240915;
    //address
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1= payable (_address);
    uint256 public balance = _address1.balance;

    bytes32 public _byte32 = "solidity";
    string public text = "text";
    bytes1 public _byte = 0x01;
    bytes1 public _byte2 = 'b';

    //几乎很少用
    enum ActionSet{ Buy, Hold, Sell}
    ActionSet action = ActionSet.Hold;
    //enum转unit
    function enumToUint() external view returns(uint){
        return uint(action);
    }

}
```

- uint 要注意减法时的溢出，比如插入排序时，0-1 溢出了

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

contract InsertSort {
    uint[] private m_uintArr;

    function insertSort () public  { //插入排序
        for(uint i=1; i<m_uintArr.length; i++){
            uint j = i; //为什么用j= i-1的方式不行： 因为uint类型 0-1就溢出啦！！！
            uint value = m_uintArr[i];
            while(j>=1 && m_uintArr[j-1]>value){
                m_uintArr[j] = m_uintArr[j-1];
                j--;
            }
            m_uintArr[j] = value;
        }
    }

    // function insertSort2 () public  {
    //     for(uint i=1; i<m_uintArr.length; i++){
    //         uint j = i-1; //j= i-1 无符号整形，溢出
    //         uint value = m_uintArr[i];
    //         while(j>=0 && m_uintArr[j]>value){
    //             m_uintArr[j+1] = m_uintArr[j];
    //             j--;
    //         }
    //         m_uintArr[j+1] = value;
    //     }
    // }

    function input(uint[] memory _arr) public {
        m_uintArr = _arr;
    }

    function showArr() view public returns(uint[] memory){
        return m_uintArr;
    }
}
```

### 2024.09.16

#### **tintinland 的作业**

[TTlandTask](https://github.com/chesley666/TTlandTask/)

- task2-1： 插入排序，注意 unit 类型，0-1 时会溢出
- task2-2： 简易 nftswap 实现暂时还不会，先用 ai 生成代码并读懂，全部学完之后再实现一遍

#### **btc/eth 基础**

朋友问了我一些问题，觉得还是应该复习一下基础

- **btc 的 fees 和矿工挖矿的收益是 1 个东西吗？**  
  比特币的转账手续费（也称为矿工费）和挖矿奖励（block reward）是两个相关但独立的概念。挖矿奖励是矿工成功挖出一个区块时获得的固定数量的新生成的比特币。而交易手续费则是用户在进行比特币交易时支付给矿工的费用，以激励矿工将他们的交易包含在区块中。随着比特币挖矿奖励的减半，交易手续费在矿工收入中所占的比例将逐渐增加，并可能最终成为矿工的主要收入来源。
- **btc 和 bch 分叉改了哪里？**
  BCH 的分叉涉及到对原始比特币代码的修改，比如增加区块大小、改变共识算法等。BCH 在 2017 年的分叉为了解决 BTC 的可扩展性问题，通过增加区块大小来允许更多的交易，从而减少费用和交易时间。分叉前链上数据一致，分叉后因为代码本质上就已经不一致了所以数据肯定不一致
- **btc 的 fees 和 eth 的 gas 的区别？**
  BTC 的交易费用主要由交易的大小（以字节为单位）决定，费用是交易大小乘以每字节的费用率。  
  ETH 的 Gas 费用包括基本费用（base fee）和优先费用（priority fee）。基本费用依据 EVM 里指令消耗算力的情况，而优先费用则是用户为了使交易更快被处理而支付给矿工的小费。EIP-1559 引入了基本费用和最大费用（max fee）：用户愿意为每单位 Gas 支付的最高费用，EIP-4844（2024）改变里费用计算结构，尤其是 calldata 部分，在高交易量时减少了费用，对 layer2 层有影响？。  
  [CKB/EVM 简介](https://accu.cc/content/ckb/evm/)
- **btc 的 fees 计算依据？交易失败时 fees 怎么处理？**

  - 交易大小：比特币交 fees 用通常按 sat/vByte 计算。交易数据量越大费用越高。例如，UTXO 模型下，多个输入和输出的交易体积大，费用也就高。
  - 网络拥堵情况：在网络活动高峰期间，未确认交易的池（mempool）可能会变得拥挤。为了快速确认交易，会提高 fees，从而推高 avg fees。
  - 用户偏好：可以手动设置交易 fees。
  - 交易复杂性：某些交易使用特殊功能，如多重签名（multisig），这会增加交易的数据大小。

    **当交易失败时，处理费用的方式可能会有所不同。如果交易未能进入区块链，即未被任何矿工确认，那么交易发起者可能有机会通过以下方式处理费用：**

  - 执行代码出错通常不会发生，交易被网络节点接受之前会经过验证（签名、默克尔树等技术），但可能出现 网络问题、交易费过低导致长时间未被确认、交易格式不符合网络规则等原因。
  - 交易未被确认：因为任何原因未能被矿工确认并包含在区块链中，那么这笔交易的手续费不会被退还给用户，也不会支付给矿工。它会留在比特币的内存池（mempool）中，直到交易被确认或从内存池中移除。
  - 交易被拒绝：如果交易因为格式错误或其他严重问题被网络节点拒绝，那么这笔交易的手续费同样不会被退还，也不会支付给矿工。
  - 交易被取消：在某些情况下，如果交易尚未被确认，用户可以通过提高交易费用来“替换”原来的交易（Replace-by-Fee, RBF），允许用户通过支付更高费用来鼓励矿工优先处理其交易。在这种情况下，原始交易的手续费将由矿工保留，而新交易将包含新的更高的费用。
  - 交易被确认：一旦交易被确认并包含在区块链中，交易费用就会被支付给将该交易包含在区块中的矿工。

- **eth 的 gas 计算依据？交易失败时 gas 怎么处理？**  
  笼统的说，根据 evm 里指令消耗算力多少，区块的大小(50%为界)，用户的 tip 设置；当执行 revert/require/assert 函数时,0.8.0 之前，gas 会被消耗掉不返还；0.8.0 之后的版本，revert 和 require 错误现在使用 EVM 的 REVERT 操作码，它允许错误信息被包含在交易回执中，并且剩余的 gas 可以被返还。
- **UTXO 模型**  
  **A 有 7btc(5，2 两个未花费)，现在要转给 B 3btc，从 A 发起交易到 B 钱包查看到钱，发生了什么？换成 eth 的话过程又是怎样的？**

  - **BTC 交易过程：**
    [体验区块链](https://andersbrownworth.com/blockchain/coinbase)

    1. 创建交易：A 的钱包软件会创建一笔交易，这笔交易指定了 B 的比特币地址作为收款方，并且指定了转账金额为 3 BTC。
    2. 选择 UTXO：为了完成这笔交易，A 的钱包会从 A 控制的未花费交易输出（UTXO）中选择足够的 BTC 来支付 3 BTC 给 B，以及支付给矿工的交易费。A 有 7 BTC，其中 5 BTC 是未花费的，因此可能选择这 5 BTC 的 UTXO。
    3. 生成新 UTXO：在比特币系统中，交易是通过消耗旧的 UTXO 并创建新的 UTXO 来完成的。这意味着 A 的 5 BTC UTXO 将被消耗，并生成两个新的 UTXO：一个 3 BTC 的 UTXO 给 B，一个小于 2 BTC 的 UTXO 作为找零返回给 A（因为 A 只需要支付 3 BTC，所以剩余的 BTC 会作为找零）。
    4. 交易签名(**椭圆曲线算法**)：A 使用与要花费的 UTXO 关联的私钥对交易进行签名，以证明 A 有权使用这些 UTXO 中的 BTC。
    5. 广播交易：签名后的交易被广播到比特币网络中，矿工节点会接收到这笔交易。
    6. 交易验证：网络中的矿工节点会验证交易的有效性，包括检查签名是否与 UTXO 匹配，以及确保 A 的比特币余额足够。
    7. 交易进入内存池 mempool： 一旦交易通过验证，它就会被加入到节点的内存池中。内存池中的交易会根据交易费用进行排序，因为矿工在打包区块时倾向于选择手续费较高的交易。
    8. 打包交易（**数字摘要**）：矿工从他们的内存池中选择交易，并将其打包成一个区块。矿工通常会优先选择那些手续费较高的交易。
    9. 工作量证明（**默克尔树**）：矿工通过解决工作量证明（PoW）难题来挖掘新区块，这个过程需要大量的计算力。  
       **区块的数据结构：** header(prehash,curhash,交易摘要)+交易内容，**具体待补充**

    10. 区块确认：当新区块被添加到区块链上，这笔交易就得到了初步确认。随着更多的区块在该区块之后被添加，交易的确认度会增加。通常，6 个确认被认为是安全的，这意味着交易几乎不可能被逆转。
    11. 更新钱包余额：一旦交易被确认，B 的钱包会更新显示新的 3 BTC 余额，而 A 的钱包会扣除 3 BTC 并增加找零的 BTC。

  - **ETH 交易过程（send）：**  
    **以后更新**

- **第 1 比 btc 交易怎么从发起到写入区块的？在创世区块时，当全网只有 1 个节点机器的时候，代码如何运行的？**  
  创世区块的哈希值为 000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f，这是一个 coinbase 交易，它将 50 个比特币作为区块奖励分配给中本聪。然而，这笔奖励由于创世区块在代码中的特殊处理，实际上无法被使用。  
   在比特币的早期版本中，创世区块的代码被直接写入比特币**客户端**软件中，当软件启动时，它会创建这个区块并将其作为区块链的起点。这个过程**不需要网络**中的其他节点参与，因为创世区块是**硬编码**的，它不依赖于网络中的其他区块或交易。在比特币的 C++源代码中，创世区块被定义为一个特殊的案例，它的各个参数（如时间戳、难度目标、Nonce 值等）都是**预先设定好**的。

### 2024.09.17

3. **函数**

- 函数可见性  
  private/internal/external/public 必须有  
  payable 只有在包含了账户相关的功能时才需要
  view 只读没写，pure 没读没写

4. **函数输出**

- returns: 函数返回声明， 如果声明时定义了变量名就自动返回，函数里不用再写 return

```solidity
  function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];

  // 直接命名式返回，returns时声明变量名，return直接返回值
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}
}
```

- return：函数里返回指定变量
- 多个变量返回： return(a,b)
- 解构式赋值

```solidity
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return(1, true, [uint256(1),2,5]);
}

(_number, _bool, _array) = returnNamed();
(, _bool2, ) = returnNamed(); //只要其中的_bool2
```

### 2024.09.19

5. **变量存储和作用域**

- storage：链上， 合约里的状态变量
- memory： 内存， 函数参数，临时变量
- calldata：内存，不能修改

```solidity
function Calldata(uint[] calldata _x) public pure returns(uint[] calldata){
  return(_x);
}
```

- 引用：相当于指针,s 引用 s/m 引用 m：映像本体；s 引用 m：不影响
- 作用域：  
  状态变量：合约内，函数外，链上存储  
  局部变量：函数里，内存里  
  全局变量：solidity 预留关键字，注意 solidity 里没有小数点，所以要用预留单位表示数据，[全局变量](https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions)

```solidity
1wei =1;
1gwei = 1e9;
1 ether = 1e18;
1 seconds =1;
1 minutes = 60;
1 hours = 3600;
1 days = 86400;
1 weeks = 604800;
```

### 2024.09.20

### 2024.09.21

### 2024.09.22

### 2024.09.23

<!-- Content_END -->
