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
     ```js
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

     uniswap提供两种代币的交换，其工产合约核心函数createPair可创建代币对合约`UniswapV2Pair`实例通过内联汇编assembly中
   evm操作码create2创建实例，其中通过哈希token1和token2地址生成salt，bytecode为UniswapV2Pair的创建字节码。由于一对token
   的地址是可知的，UniswapV2Pair合约的地址也是不变的，所以较容易推出一对代币的UniswapV2Pair合约地址。而采用create创建合约
   的话，合约地址会随创建账户的状态而变化不好预测
   ```

<!-- Content_END -->
