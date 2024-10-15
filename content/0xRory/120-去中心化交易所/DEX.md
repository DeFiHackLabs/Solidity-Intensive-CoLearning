### 56. 去中心化交易所

將介紹恆定乘積自動做市商（Constant Product Automated Market Maker, CPAMM），它是去中心化交易所的核心機制，被Uniswap，PancakeSwap等一系列DEX採用。教學合約由Uniswap-v2合約簡化而來，包括了CPAMM最核心的功能。

#### 自動做市商

自動做市商（Automated Market Maker，簡稱AMM）是一種演算法，或者說是一種在區塊鏈上運行的智慧合約，它允許數位資產之間的去中心化交易。

AMM 的引入開創了一種全新的交易方式，無需傳統的買家和賣家進行訂單匹配，而是透過一種預設的數學公式（例如，常數乘積公式）創建一個流動性池，使得用戶可以隨時進行交易。

#### 恆定總和自動做市商

恆定總和自動做市商（Constant Sum Automated Market Maker, CSAMM）是最簡單的自動做市商模型，我們從它開始。它在交易時的約束為:

k=x+y

其中
k為常數。也就是說，在交易前後市場中可樂和美元數量的總和保持不變。舉個例子，市場中流動性有10 瓶可樂和10 美元，此時

k=20，可樂的價格為1 美元/瓶。我很渴，想拿出2 美元來換可樂。交易後市場中的美元總量變為12，根據約束

k=20，交易後市場中有8 瓶可樂，價格為1 美元/瓶。我在交易中得到了2 瓶可樂，價格為1 美元/瓶。

`CSAMM` 的優點是可以確保代幣的相對價格不變，這點在穩定幣兌換中很重要，大家都希望1 USDT 總是能兌換出1 USDC。但它的缺點也很明顯，它的流動性很容易耗盡：我只需要10 美元，就可以把市場上可樂的流動性耗盡，其他想喝可樂的用戶就沒辦法交易了。

以下我們介紹擁有」無限「流動性的恆定乘積自動做市商。

#### 恆定乘積自動
恆定乘積自動做市商（CPAMM）是最受歡迎的自動做市商模型，最早被Uniswap 採用。它在交易時的約束為:

k=x∗y

其中

k為常數。也就是說，在交易前後市場中可樂和美元數量的乘積保持不變。同樣的例子，市場中流動性有10 瓶可樂和10 美元，此時

k=100，可樂的價格為1 美元/瓶。我很渴，想拿出10 美元來換可樂。如果在CSAMM 中，我的交易會換來10 瓶可樂，並耗盡市場上可樂的流動性。但在CPAMM 中，交易後市場中的美元總量變為20，根據約束

k=100，交易後市場中有5 瓶可樂，價格為

20/5=4美元/瓶。我在交易中得到了5 瓶可樂，價格為

10/5=2美元/瓶。

CPAMM 的優點是擁有「無限」流動性：代幣的相對價格會隨著買賣而變化，越稀缺的代幣相對價格會越高，避免流動性被耗盡。上面的例子中，交易讓可樂從1 美元/瓶上漲到4 美元/瓶，以避免市場上的可樂被買斷。

下面，讓我們建立一個基於CPAMM 的極簡的去中心化交易所。


#### 去中心化交易所合約
下面，我們用智能合約寫一個去中心化交易所SimpleSwap，支援用戶交易一對代幣。

SimpleSwap繼承了ERC20 代幣標準，方便記錄流動性提供者提供的流動性。在構造器中，我們指定一對代幣地址token0和token1，交易所僅支援這對代幣。reserve0和reserve1記錄了合約中代幣的儲備量。

```solidity

contract SimpleSwap is ERC20 {
    // 代币合约
    IERC20 public token0;
    IERC20 public token1;

    // 代币储备量
    uint public reserve0;
    uint public reserve1;
    
    // 构造器，初始化代币地址
    constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
        token0 = _token0;
        token1 = _token1;
    }
}
```

交易所主要有兩類參與者：
`流動性提供者（Liquidity Provider，LP）`
`交易者（Trader）`。


- 流動性提供

流動性提供者給市場流動性，讓交易者獲得更好的報價和流動性，並收取一定費用

因為SimpleSwap合約繼承了ERC20 代幣標準，在計算好LP份額後，可以將份額以代幣形式鑄造給用戶。

下面的`addLiquidity()`函數實作了添加流動性的功能，主要步驟如下：

- 將用戶新增的代幣轉入合約，需要用戶事先給合約授權。
- 根據公式計算添加的流動性份額，並檢查鑄造的LP數量。
- 更新合約的代幣儲備量。
- 給流動性提供者鑄造LP代幣。
- 釋放Mint事件。

```solidity
event Mint(address indexed sender, uint amount0, uint amount1);

// 添加流动性，转进代币，铸造LP
// @param amount0Desired 添加的token0数量
// @param amount1Desired 添加的token1数量
function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
    // 将添加的流动性转入Swap合约，需事先给Swap合约授权
    token0.transferFrom(msg.sender, address(this), amount0Desired);
    token1.transferFrom(msg.sender, address(this), amount1Desired);
    // 计算添加的流动性
    uint _totalSupply = totalSupply();
    if (_totalSupply == 0) {
        // 如果是第一次添加流动性，铸造 L = sqrt(x * y) 单位的LP（流动性提供者）代币
        liquidity = sqrt(amount0Desired * amount1Desired);
    } else {
        // 如果不是第一次添加流动性，按添加代币的数量比例铸造LP，取两个代币更小的那个比例
        liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);
    }

    // 检查铸造的LP数量
    require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

    // 更新储备量
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    // 给流动性提供者铸造LP代币，代表他们提供的流动性
    _mint(msg.sender, liquidity);
    
    emit Mint(msg.sender, amount0Desired, amount1Desired);
}
```

- 下面的`removeLiquidity()`函數實現移除流動性的功能，主要步驟如下：

    - 取得合約中的代幣餘額。
    - 以LP的比例計算要轉出的代幣數量。
    - 檢查代幣數量。
    - 銷毀LP份額。
    - 將相應的代幣轉帳給用戶。
    - 更新儲備量。
    - 釋放Burn事件。

```solidity
// 移除流动性，销毁LP，转出代币
// 转出数量 = (liquidity / totalSupply_LP) * reserve
// @param liquidity 移除的流动性数量
function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
    // 获取余额
    uint balance0 = token0.balanceOf(address(this));
    uint balance1 = token1.balanceOf(address(this));
    // 按LP的比例计算要转出的代币数量
    uint _totalSupply = totalSupply();
    amount0 = liquidity * balance0 / _totalSupply;
    amount1 = liquidity * balance1 / _totalSupply;
    // 检查代币数量
    require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');
    // 销毁LP
    _burn(msg.sender, liquidity);
    // 转出代币
    token0.transfer(msg.sender, amount0);
    token1.transfer(msg.sender, amount1);
    // 更新储备量s
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    emit Burn(msg.sender, amount0, amount1);
}
```

#### 交易

有了这一核心公式后，我们可以着手实现交易功能了。下面的 swap() 函数实现了交易代币的功能，主要步骤如下：

- 用户在调用函数时指定用于交换的代币数量，交换的代币地址，以及换出另一种代币的最低数量。
- 判断是 token0 交换 token1，还是 token1 交换 token0。
- 利用上面的公式，计算交换出代币的数量。
- 判断交换出的代币是否达到了用户指定的最低数量，这里类似于交易的滑点。
- 将用户的代币转入合约。
- 将交换的代币从合约转给用户。
- 更新合约的代币储备量。
- 释放 Swap 事件。

```solidity
// swap代币
// @param amountIn 用于交换的代币数量
// @param tokenIn 用于交换的代币合约地址
// @param amountOutMin 交换出另一种代币的最低数量
function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
    require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
    require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');
    
    uint balance0 = token0.balanceOf(address(this));
    uint balance1 = token1.balanceOf(address(this));

    if(tokenIn == token0){
        // 如果是token0交换token1
        tokenOut = token1;
        // 计算能交换出的token1数量
        amountOut = getAmountOut(amountIn, balance0, balance1);
        require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
        // 进行交换
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        tokenOut.transfer(msg.sender, amountOut);
    }else{
        // 如果是token1交换token0
        tokenOut = token0;
        // 计算能交换出的token1数量
        amountOut = getAmountOut(amountIn, balance1, balance0);
        require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
        // 进行交换
        tokenIn.transferFrom(msg.sender, address(this), amountIn);
        tokenOut.transfer(msg.sender, amountOut);
    }

    // 更新储备量
    reserve0 = token0.balanceOf(address(this));
    reserve1 = token1.balanceOf(address(this));

    emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
}
``` 

### simpleSwap.sol
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleSwap is ERC20 {
    // 代币合约
    IERC20 public token0;
    IERC20 public token1;

    // 代币储备量
    uint public reserve0;
    uint public reserve1;
    
    // 事件 
    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1);
    event Swap(
        address indexed sender,
        uint amountIn,
        address tokenIn,
        uint amountOut,
        address tokenOut
        );

    // 构造器，初始化代币地址
    constructor(IERC20 _token0, IERC20 _token1) ERC20("SimpleSwap", "SS") {
        token0 = _token0;
        token1 = _token1;
    }

    // 取两个数的最小值
    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    // 计算平方根 babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    // 添加流动性，转进代币，铸造LP
    // 如果首次添加，铸造的LP数量 = sqrt(amount0 * amount1)
    // 如果非首次，铸造的LP数量 = min(amount0/reserve0, amount1/reserve1)* totalSupply_LP
    // @param amount0Desired 添加的token0数量
    // @param amount1Desired 添加的token1数量
    function addLiquidity(uint amount0Desired, uint amount1Desired) public returns(uint liquidity){
        // 将添加的流动性转入Swap合约，需事先给Swap合约授权
        token0.transferFrom(msg.sender, address(this), amount0Desired);
        token1.transferFrom(msg.sender, address(this), amount1Desired);
        // 计算添加的流动性
        uint _totalSupply = totalSupply();
        if (_totalSupply == 0) {
            // 如果是第一次添加流动性，铸造 L = sqrt(x * y) 单位的LP（流动性提供者）代币
            liquidity = sqrt(amount0Desired * amount1Desired);
        } else {
            // 如果不是第一次添加流动性，按添加代币的数量比例铸造LP，取两个代币更小的那个比例
            liquidity = min(amount0Desired * _totalSupply / reserve0, amount1Desired * _totalSupply /reserve1);
        }

        // 检查铸造的LP数量
        require(liquidity > 0, 'INSUFFICIENT_LIQUIDITY_MINTED');

        // 更新储备量
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        // 给流动性提供者铸造LP代币，代表他们提供的流动性
        _mint(msg.sender, liquidity);
        
        emit Mint(msg.sender, amount0Desired, amount1Desired);
    }

    // 移除流动性，销毁LP，转出代币
    // 转出数量 = (liquidity / totalSupply_LP) * reserve
    // @param liquidity 移除的流动性数量
    function removeLiquidity(uint liquidity) external returns (uint amount0, uint amount1) {
        // 获取余额
        uint balance0 = token0.balanceOf(address(this));
        uint balance1 = token1.balanceOf(address(this));
        // 按LP的比例计算要转出的代币数量
        uint _totalSupply = totalSupply();
        amount0 = liquidity * balance0 / _totalSupply;
        amount1 = liquidity * balance1 / _totalSupply;
        // 检查代币数量
        require(amount0 > 0 && amount1 > 0, 'INSUFFICIENT_LIQUIDITY_BURNED');
        // 销毁LP
        _burn(msg.sender, liquidity);
        // 转出代币
        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);
        // 更新储备量
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        emit Burn(msg.sender, amount0, amount1);
    }

    // 给定一个资产的数量和代币对的储备，计算交换另一个代币的数量
    // 由于乘积恒定
    // 交换前: k = x * y
    // 交换后: k = (x + delta_x) * (y + delta_y)
    // 可得 delta_y = - delta_x * y / (x + delta_x)
    // 正/负号代表转入/转出
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
        require(amountIn > 0, 'INSUFFICIENT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
        amountOut = amountIn * reserveOut / (reserveIn + amountIn);
    }

    // swap代币
    // @param amountIn 用于交换的代币数量
    // @param tokenIn 用于交换的代币合约地址
    // @param amountOutMin 交换出另一种代币的最低数量
    function swap(uint amountIn, IERC20 tokenIn, uint amountOutMin) external returns (uint amountOut, IERC20 tokenOut){
        require(amountIn > 0, 'INSUFFICIENT_OUTPUT_AMOUNT');
        require(tokenIn == token0 || tokenIn == token1, 'INVALID_TOKEN');
        
        uint balance0 = token0.balanceOf(address(this));
        uint balance1 = token1.balanceOf(address(this));

        if(tokenIn == token0){
            // 如果是token0交换token1
            tokenOut = token1;
            // 计算能交换出的token1数量
            amountOut = getAmountOut(amountIn, balance0, balance1);
            require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
            // 进行交换
            tokenIn.transferFrom(msg.sender, address(this), amountIn);
            tokenOut.transfer(msg.sender, amountOut);
        }else{
            // 如果是token1交换token0
            tokenOut = token0;
            // 计算能交换出的token1数量
            amountOut = getAmountOut(amountIn, balance1, balance0);
            require(amountOut > amountOutMin, 'INSUFFICIENT_OUTPUT_AMOUNT');
            // 进行交换
            tokenIn.transferFrom(msg.sender, address(this), amountIn);
            tokenOut.transfer(msg.sender, amountOut);
        }

        // 更新储备量
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token1.balanceOf(address(this));

        emit Swap(msg.sender, amountIn, address(tokenIn), amountOut, address(tokenOut));
    }
}
```
看來後續要在多學一點..