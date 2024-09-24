---
timezone: Asia/Shanghai
---

# Heâ€‹len

1. 自我介绍
   
   凡事都有第一次，喜歡體驗新事物的小女子。
  
2. 你认为你会完成本次残酷学习吗？
   
   我會盡我洪荒之力盡量完成本次共學目標，但有時以大我為目標，有時也會量力而為，比昨天的自己再進步一點就滿足。
   
## Notes

<!-- Content_START -->

### 2024.09.24

# 今日筆記-除錯
1.確認 Solidity 版本的相容性
檢視發現 Compiler 版本與合約版本不一致（0.8.27 V.S 0.8.21)，統一改為Solidity 合約中自訂版本

2.檢視[影片](https://www.youtube.com/watch?v=rKKRGRHUiiQ)確認操作沒問題

3.合約已發佈

### 2024.09.23
# Real Note
進度：01_HelloWeb3
使用开发工具：Remix 練習寫一個[智能合約](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.26+commit.8a97fa7a.js),熟悉部署程序
```
// 智能合約命名Heâ€len
// 內容：Hello my world!
// 完成編譯後，要按compile
pragma solidity ^0.8.21;
contract len{
    string public _string = "Hello my world";
}

```
但卡住了,evm version:cancun

## Sample Notes
學習內容: 
- A 系列的 Ethernaut CTF, 之前做了差不多了. POC: [ethernaut-foundry-solutions](https://github.com/SunWeb3Sec/ethernaut-foundry-solutions)
- A 系列的 QuillAudit CTF 題目的網站關掉了, 幫大家收集了[題目](./Writeup/SunSec/src/QuillCTF/), 不過還是有幾題沒找到. 有找到題目的人可以在發出來.
- A 系列的 DamnVulnerableDeFi 有持續更新, 題目也不錯. [Damn Vulnerable DeFi](https://github.com/theredguild/damn-vulnerable-defi/tree/v4.0.0).
- 使用 [Foundry](https://book.getfoundry.sh/) 在本地解題目, 可以參考下面 RoadClosed 為例子
- ``forge test --match-teat testRoadClosedExploit -vvvv``
#### [QuillAudit CTF - RoadClosed](./Writeup/SunSec/src/QuillCTF/RoadClosed.sol)
```
  function addToWhitelist(address addr) public {
    require(!isContract(addr), "Contracts are not allowed");
    whitelistedMinters[addr] = true;
  }

  function changeOwner(address addr) public {
    require(whitelistedMinters[addr], "You are not whitelisted");
    require(msg.sender == addr, "address must be msg.sender");
    require(addr != address(0), "Zero address");
    owner = addr;
  }

  function pwn(address addr) external payable {
    require(!isContract(msg.sender), "Contracts are not allowed");
    require(msg.sender == addr, "address must be msg.sender");
    require(msg.sender == owner, "Must be owner");
    hacked = true;
  }

  function pwn() external payable {
    require(msg.sender == pwner);
    hacked = true;
  }
```
- 解決這個題目需要成為合約的 owner 和 hacked = true.
- On-chain: 可以透過 ``cast send`` 或是 forge script 來解.
- Local: 透過 forge test 通常是在local解題, 方便 debug.
- RoadClosed 為例子我寫了2個解題方式. testRoadClosedExploit 和 testRoadClosedContractExploit (因為題目有檢查msg.sender是不是合約, 所以可以透過constructor來繞過 isContract)
- [POC](./Writeup/SunSec/test/QuillCTF/RoadClosed.t.sol) 

### 

<!-- Content_END -->
