---
timezone: Asia/Shanghai
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加标准时间 (UTC-9)

timezone: America/Los_Angeles # 太平洋标准时间 (UTC-8)

timezone: America/Denver # 山地标准时间 (UTC-7)

timezone: America/Chicago # 中部标准时间 (UTC-6)

timezone: America/New_York # 东部标准时间 (UTC-5)

timezone: America/Halifax # 大西洋标准时间 (UTC-4)

timezone: America/St_Johns # 纽芬兰标准时间 (UTC-3:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

# Robin

1. 自我介绍
   
   大家好，我是Robin，一名专注于Java后端开发的技术爱好者。在多年的编程经历中，我积累了丰富的服务器端应用构建经验，尤其是在高性能、高并发处理方面有所涉猎。最近对Web3领域产生了浓厚的兴趣，它所倡导的去中心化网络理念以及区块链技术的应用前景深深吸引了我。我相信，未来互联网的发展趋势将更加开放与透明，而Web3正是这一趋势的核心体现。我希望能够在这个新兴领域中探索更多可能，并与其他志同道合的朋友共同学习成长。如果有机会，我也期待能够贡献自己的力量，参与到Web3相关项目的实践中去。

2. 你认为你会完成本次残酷学习吗？
   
   当然，我认为我会完成这次学习。虽然我知道这个过程中可能会遇到很多挑战和困难，但我已经做好了充分的准备。既然已经制定了一份详细的学习计划，我就会确保自己有足够的资源和支持来应对可能出现的问题。此外，我对这个领域的兴趣和热情也是推动我前进的强大动力。我相信，通过坚持不懈的努力，我一定能够克服这些挑战并完成学习目标

## Notes

<!-- Content_START -->

### 2024.09.23

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
