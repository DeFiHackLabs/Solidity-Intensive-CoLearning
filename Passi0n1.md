---
timezone: Asia/Shanghai
---
---

# Passi0n1

1. hi,我是Passi0n1。我对于传统安全比较了解，对于web3安全仅有一些基础，希望可以精进自己的技术。
2. 你认为你会完成本次残酷学习吗？会的。

## Notes

<!-- Content_START -->
### 2024.09.23
#### 学习笔记
函数可见性说明符：
从可见范围，依次变窄的角度去描述：

`public`   合约内外均可访问

`external` 只能从合约外部进行调用，但是如果合约内部真的有调用的需要的花可以通过 `this.f()` 进行调用.

`internal` 只可以由合约内部以及继承的合约调用

`private`  只能从本合约内部访问，即使是继承的合约也不能使用


在此处可以注意一些合约在部署的时候可见性规范不到位，导致的合约漏洞

参考一个由于可见性造成的漏洞
https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7
```
function initWallet(address[] _owners, uint _required, uint _daylimit) {    
  initDaylimit(_daylimit);    
  initMultiowned(_owners, _required);  
}
```
当然，本身 `initWallet` 函数在初始化的时候没有进行调用者身份检查就存在问题。



决定函数权限/功能的关键字:

`payable` 此关键字可以说明某个函数可以接收 E

### 

<!-- Content_END -->
