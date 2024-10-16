### 57. 閃電貸

「閃電貸攻擊」這個詞大家一定聽過，但是什麼是閃電貸？如何寫閃電貸合約？這一講，我們將介紹區塊鏈中的閃電貸。

閃電貸（Flashloan）是DeFi的一種創新，它允許用戶在一個交易中藉出並迅速歸還資金，而無需提供任何抵押。

想像一下，你突然在市場中發現了一個套利機會，但需要準備100萬u的資金才能完成套利。

在Web2，你去銀行申請貸款，需要審批，很可能錯過套利的機會。另外，如果套利失敗，你不光要支付利息，還需要歸還損失的本金。

而在Web3，你可以在DeFI平台（Uniswap，AAVE，Dodo）中進行閃電貸獲取資金，就可以在無擔保的情況下借100萬u的代幣，執行鏈上套利，最後再歸還貸款和利息。

閃電貸利用了以太坊交易的原子性：

一個交易（包括其中的所有操作）要么完全執行，要么完全不執行。

如果一個用戶嘗試使用閃電貸並在同一個交易中沒有歸還資金，那麼整個交易都會失敗並被回滾，就像它從未發生過一樣。因此，DeFi平台不需要擔心借款人還不上款，因為還不上的話就意味著錢沒借出去；

同時，借款人也不用擔心套利不成功，因為套利不成功的話就還不上款，也就代表借錢沒成功。


![alt text](image.png)

首先，要理解閃電貸會需要知道他就是在一筆交易內完成 借貸，操作，所以如果可以在短時間內到可以支付fee 的費用，與所借的資金，那麼就可以進行閃電貸。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

// UniswapV2闪电贷回调接口
interface IUniswapV2Callee {
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}

// UniswapV2闪电贷合约
contract UniswapV2Flashloan is IUniswapV2Callee {
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IUniswapV2Factory private constant factory = IUniswapV2Factory(UNISWAP_V2_FACTORY);

    IERC20 private constant weth = IERC20(WETH);

    IUniswapV2Pair private immutable pair;

    constructor() {
        pair = IUniswapV2Pair(factory.getPair(DAI, WETH));
    }

    // 闪电贷函数
    function flashloan(uint wethAmount) external {
        // calldata长度大于1才能触发闪电贷回调函数
        bytes memory data = abi.encode(WETH, wethAmount);

        // amount0Out是要借的DAI, amount1Out是要借的WETH
        pair.swap(0, wethAmount, address(this), data);
    }

    // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        // 确认调用的是 DAI/WETH pair 合约
        address token0 = IUniswapV2Pair(msg.sender).token0(); // 获取token0地址
        address token1 = IUniswapV2Pair(msg.sender).token1(); // 获取token1地址
        assert(msg.sender == factory.getPair(token0, token1)); // ensure that msg.sender is a V2 pair

        // 解码calldata
        (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

        // flashloan 逻辑，这里省略
        require(tokenBorrow == WETH, "token borrow != WETH");

        // 计算flashloan费用
        // fee / (amount + fee) = 3/1000
        // 向上取整
        uint fee = (amount1 * 3) / 997 + 1;
        uint amountToRepay = amount1 + fee;

        // 归还闪电贷
        weth.transfer(address(pair), amountToRepay);
    }
}
```

- 计算闪电贷费用：
    - Uniswap V2 收取借贷金额的 0.3% 作为费用。
    - 公式：fee = (amount1 * 3) / 997 + 1，并向上取整。
    - 计算需要偿还的总金额：amountToRepay = amount1 + fee。

- 归还闪电贷
        weth.transfer(address(pair), amountToRepay);

#### 2. Uniswap V3闪电贷
与Uniswap V2在swap()交换函数中间接支持闪电贷不同，Uniswap V3在Pool池合约中加入了flash()函数直接支持闪电贷。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

// UniswapV3闪电贷回调接口
// 需要实现并重写uniswapV3FlashCallback()函数
interface IUniswapV3FlashCallback {
    /// 在实现中，你必须偿还池中由 flash 发送的代币及计算出的费用金额。
    /// 调用此方法的合约必须经由官方 UniswapV3Factory 部署的 UniswapV3Pool 检查。
    /// @param fee0 闪电贷结束时，应支付给池的 token0 的费用金额
    /// @param fee1 闪电贷结束时，应支付给池的 token1 的费用金额
    /// @param data 通过 IUniswapV3PoolActions#flash 调用由调用者传递的任何数据
    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external;
}

// UniswapV3闪电贷合约
contract UniswapV3Flashloan is IUniswapV3FlashCallback {
    address private constant UNISWAP_V3_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    uint24 private constant poolFee = 3000;

    IERC20 private constant weth = IERC20(WETH);
    IUniswapV3Pool private immutable pool;

    constructor() {
        pool = IUniswapV3Pool(getPool(DAI, WETH, poolFee));
    }

    function getPool(
        address _token0,
        address _token1,
        uint24 _fee
    ) public pure returns (address) {
        PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(
            _token0,
            _token1,
            _fee
        );
        return PoolAddress.computeAddress(UNISWAP_V3_FACTORY, poolKey);
    }

    // 闪电贷函数
    function flashloan(uint wethAmount) external {
        bytes memory data = abi.encode(WETH, wethAmount);
        IUniswapV3Pool(pool).flash(address(this), 0, wethAmount, data);
    }

    // 闪电贷回调函数，只能被 DAI/WETH pair 合约调用
    function uniswapV3FlashCallback(
        uint fee0,
        uint fee1,
        bytes calldata data
    ) external {
        // 确认调用的是 DAI/WETH pair 合约
        require(msg.sender == address(pool), "not authorized");
        
        // 解码calldata
        (address tokenBorrow, uint256 wethAmount) = abi.decode(data, (address, uint256));

        // flashloan 逻辑，这里省略
        require(tokenBorrow == WETH, "token borrow != WETH");

        // 归还闪电贷
        weth.transfer(address(pool), wethAmount + fee1);
    }
}
```
Uniswap V3每笔闪电贷的手续费与交易手续费一致。

#### 3. AAVE V3闪电贷


```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Lib.sol";

interface IFlashLoanSimpleReceiver {
    /**
    * @notice 在接收闪电借款资产后执行操作
    * @dev 确保合约能够归还债务 + 额外费用，例如，具有
    *      足够的资金来偿还，并已批准 Pool 提取总金额
    * @param asset 闪电借款资产的地址
    * @param amount 闪电借款资产的数量
    * @param premium 闪电借款资产的费用
    * @param initiator 发起闪电贷款的地址
    * @param params 初始化闪电贷款时传递的字节编码参数
    * @return 如果操作的执行成功则返回 True，否则返回 False
    */
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool);
}

// AAVE V3闪电贷合约
contract AaveV3Flashloan {
    address private constant AAVE_V3_POOL =
        0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;

    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    ILendingPool public aave;

    constructor() {
        aave = ILendingPool(AAVE_V3_POOL);
    }

    // 闪电贷函数
    function flashloan(uint256 wethAmount) external {
        aave.flashLoanSimple(address(this), WETH, wethAmount, "", 0);
    }

    // 闪电贷回调函数，只能被 pool 合约调用
    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata)
        external
        returns (bool)
    {   
        // 确认调用的是 DAI/WETH pair 合约
        require(msg.sender == AAVE_V3_POOL, "not authorized");
        // 确认闪电贷发起者是本合约
        require(initiator == address(this), "invalid initiator");

        // flashloan 逻辑，这里省略

        // 计算flashloan费用
        // fee = 5/1000 * amount
        uint fee = (amount * 5) / 10000 + 1;
        uint amountToRepay = amount + fee;

        // 归还闪电贷
        IERC20(WETH).approve(AAVE_V3_POOL, amountToRepay);

        return true;
    }
}
```

- 计算闪电贷费用：
    - AAVE V3 收取借贷金额的 0.5% 作为费用。
    - 公式：fee = (amount * 5) / 10000 + 1。
    - 计算需要偿还的总金额：amountToRepay = amount + fee。

- 归还闪电贷
        IERC20(WETH).approve(AAVE_V3_POOL, amountToRepay);



閃電貸很創新，但我感覺就是包裝起來可以一次性借貸的服務，只是用合約實現真的是很屌，感覺也不是對程式的理解而是對金融的理解，這樣的合約也是很有價值的。 之後還是要複習一下。

