---
timezone: Asia/Shanghai
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

# JackChou

1. 自我介绍
   是個後端工程師, 在工作上有碰到一點合約ㄝ, 想要做WEB3工程師
2. 你认为你会完成本次残酷学习吗？
   會
   
## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 
- For this week, I will target on finishing solidity 101
- Finished solidity 101, 1-4
  - 3.function
    ```
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.4;
    contract Quiz3{
        // complete following funciton, let it return the sum of x and y
        function sum(uint x, uint y) pure external returns (uint sumXY){
            sumXY = x+y;
        }
    }
    ```
    output
    ```
    decoded input	{
      "uint256 x": "2",
      "uint256 y": "3"
    }
    decoded output	{
      "0": "uint256: sumXY 5"
    }
    ```
    - In Solidity, functions can be marked as `pure`, `view`, or `payable` to indicate their behavior. `pure` functions do not modify the contract's state, while `view` functions can read the state but not modify it. `payable` functions can receive Ether.
  - 4.function Output 
    - There are two keywords related to function output: return and returns:
    ```
    returns is added after the function name to declare variable type and variable name;
    return is used in the function body and returns desired variables.
        // returning multiple variables
        function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
                return(1, true, [uint256(1),2,5]);
            }
    ```
### 

<!-- Content_END -->
