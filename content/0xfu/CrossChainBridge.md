
### 跨链桥

跨链桥是一种区块链协议，它允许在两个或多个区块链之间移动数字资产和信息。例如，一个在以太坊主网上
运行的ERC20代币，可以通过跨链桥转移到其他兼容以太坊的侧链或独立链。

#### 跨链桥种类

1. Burn/Mint
	在源链上销毁（burn）代币，然后在目标链上创建（mint）同等数量的代币。此方法好处是代币的总供应
	量保持不变，但是需要跨链桥拥有代币的铸造权限，适合项目方搭建自己的跨链桥。

2. Stake/Mint
	在源链上锁定（stake）代币，然后在目标链上创建（mint）同等数量的代币（凭证）。源链上的代币被锁定，
	当代币从目标链移回源链时再解锁。这是一般跨链桥使用的方案，不需要任何权限，但是风险也较大，当源链
	的资产被黑客攻击时，目标链上的凭证将变为空气。

3. Stake/Unstake
	在源链上锁定（stake）代币，然后在目标链上释放（unstake）同等数量的代币，在目标链上的代币可以
	随时兑换回源链的代币。这个方法需要跨链桥在两条链都有锁定的代币，门槛较高，一般需要激励用户在跨链桥锁仓。