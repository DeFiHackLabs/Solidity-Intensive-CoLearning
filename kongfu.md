---
timezone: America/Los_Angeles
---

> 请在上边的 timezone 添加你的当地时区，这会有助于你的打卡状态的自动化更新，如果没有添加，默认为北京时间 UTC+8 时区
> 时区请参考以下列表，请移除 # 以后的内容

timezone: Pacific/Honolulu # 夏威夷-阿留申标准时间 (UTC-10)

timezone: America/Anchorage # 阿拉斯加夏令时间 (UTC-8)

timezone: America/Los_Angeles # 太平洋夏令时间 (UTC-7)

timezone: America/Denver # 山地夏令时间 (UTC-6)

timezone: America/Chicago # 中部夏令时间 (UTC-5)

timezone: America/New_York # 东部夏令时间 (UTC-4)

timezone: America/Halifax # 大西洋夏令时间 (UTC-3)

timezone: America/St_Johns # 纽芬兰夏令时间 (UTC-2:30)

timezone: Asia/Dubai # 海湾标准时间 (UTC+4)

timezone: Asia/Kolkata # 印度标准时间 (UTC+5:30)

timezone: Asia/Dhaka # 孟加拉国标准时间 (UTC+6)

timezone: Asia/Bangkok # 中南半岛时间 (UTC+7)

timezone: Asia/Shanghai # 中国标准时间 (UTC+8)

timezone: Asia/Tokyo # 日本标准时间 (UTC+9)

timezone: Australia/Sydney # 澳大利亚东部标准时间 (UTC+10)

---

KungfuPanda

1. 自我介绍
   A man interested in Crypto
2. 你认为你会完成本次残酷学习吗？
   yes
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
- setup Foundary 的运行环境
- 使用mkdir 命令建立 co—learning的文件夹
- 使用forge init命令初始化
- 使用 forge compile 编译 HelloWeb3.sol
- 新开窗口用anvil创建一条本机链
- 使用forge create部署HelloWeb3.sol合约

结果如下：
[⠃] Compiling...
No files changed, compilation skipped
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0x957fd94ac366ec5eef8c849dae9993b04b03c456cd61fd116621b44138bdf743

- cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "_string()" --rpc-url http://127.0.0.1:8545
  得到_string的字节码， decode该字节码得到 “Hello，World” 字符串
    
<!-- Content_END -->
