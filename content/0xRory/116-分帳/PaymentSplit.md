### 42. 分帳

`分帳合約`，該合約允許ETH將按權重轉給一組帳戶中，進行分帳。

程式碼部分由OpenZeppelin函式庫的`PaymentSplitter`合約簡化而來。

分帳就是依照一定比例分錢財。

在現實中，常常會有「分贓物」的事情發生；

而在區塊鏈的世界裡，`Code is Law` 我們可以事先把每個人應分的比例寫在智能合約中，獲得收入後，再由智能合約來進行分帳。

#### 分帳合約

分帳合約( PaymentSplit)具有以下幾個特點：

- 在創建合約時定好分帳受益人`payees`和`每人的份額shares`。
- 份額可以是相等，也可以是其他任意比例。
- 在該合約收到的所有`ETH`中，每個受益人將能夠提取與其分配的份額成比例的金額。
- 分帳合約遵循`Pull Payment模式`，付款不會自動轉入帳戶，而是保存在此合約中。受益人透過呼叫`release()`函數觸發實際轉帳。

##### 事件
分帳合約中共有3一個事件：

- `PayeeAdded`：增加受益人事件。
- `PaymentReleased`：受益人提款事件。
- `PaymentReceived`：分帳合約收款事件。

如下：

```solidity
    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合约收款事件
```

##### 狀態變數

分帳合約中共有5個狀態變量，用來記錄受益地址、份額、支付出去的ETH等變數：

- `totalShares`：總份額，為shares的和。
- `totalReleased`：從分帳合約向受益人支付出去的ETH，為released的和。
- `payees`：address數組，記錄受益人地址
- `shares`：address到uint256的映射，記錄每個受益人的份額。
- `released`：address到uint256的映射，記錄分帳合約支付給每個受益人的金額。

```solidity
    uint256 public totalShares; // 总份额
    uint256 public totalReleased; // 总支付

    mapping(address => uint256) public shares; // 每个受益人的份额
    mapping(address => uint256) public released; // 支付给每个受益人的金额
    address[] public payees; // 受益人数组
```

##### 函數

建構函數：始化受益人數組`_payees`和分帳份額數組`_shares`，其中數組長度不能為0，兩個數組長度要相等。 `_shares`中元素要大於0，_payees中位址不能為0位址且不能有重複位址。

`receive()`：回呼函數，在分帳合約收到ETH時釋放PaymentReceived事件。
`release()`：分帳函數，為有效受益人地址_account分配對應的ETH。任何人都可以觸發這個函數，但ETH會轉給受益人地址account。呼叫了releasable()函數。
`releasable()`：計算一個受益人地址應領取的ETH。呼叫了pendingPayment()函數。
`pendingPayment()`：根據受益人地址_account, 分帳合約總收入_totalReceived和該地址已領取的錢_alreadyReleased，計算該受益人現在應分的ETH。
`_addPayee()`：新增受益人函數及其份額函數。在合約初始化的時候被調用，之後不能修改。

```solidity
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
```

重點：
  - 這邊是一開始就設定好每個帳戶的分帳比例，並且在合約中記錄下來 constructor 建構函數的時候就做了這個動作
  - `payees`是受益人的地址，`shares`是每個受益人的份額
  - 條件 return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased; 這個條件是計算每個受益人應得的ETH
  - 可以看到規則都是智能合約裡面，幾本上規則都是公開透明的，不會有人為的操作