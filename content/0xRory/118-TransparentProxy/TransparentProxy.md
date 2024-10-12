### 48. 透明代理

介紹代理合約的選擇器衝突（Selector Clash），以及此問題的解決方案：透明代理（Transparent Proxy）。

#### 選擇器衝突（Selector Clash）

選擇器怎麼生成：
ex:

  `mint(address account)` -> `bytes4(keccak256("mint(address)"))` =  `0x6a627842`

函數選擇器只有4個位元組，`範圍很小，因此兩個不同的函數可能會有相同的選擇器`，例如下面兩個函數：
(也就是說很常會衝突 )

```solidity
  // 选择器冲突的例子
  contract Foo {
      function burn(uint256) external {}
      function collate_propagate_storage(bytes16) external {}
  }
```

範例中，函數`burn()`和`collate_propagate_storage()`的選擇器都為`0x42966c68`，是一樣的，這種情況稱為「選擇器衝突」。在這種情況下，EVM無法透過函數選擇器分辨使用者呼叫哪個函數，因此該合約無法通過編譯。

就算合約函數衝突也是可以正常部署，所以要特別注意

目前，有兩個可升級合約標準解決了這個問題：`透明代理Transparent Proxy`和`通用可升級代理UUPS`。

- 目前，有兩個可升級合約標準解決了這個問題：透明代理Transparent Proxy和通用可升級代理UUPS。

總結：

  - 基本上透明代理合約就是增加了 `admin` 的判定，再升級的時候就判定一次
  ```solidity
      // fallback函数，将调用委托给逻辑合约
    // 不能被admin调用，避免选择器冲突引发意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
    ```

  - 當然判定越多 gas fee 消耗更多。