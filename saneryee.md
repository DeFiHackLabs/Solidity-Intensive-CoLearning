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

# YourName

1. 自我介绍
   
   学习 Solidity，想成为一名 Smart contract Auditor。

2. 你认为你会完成本次残酷学习吗？
   
   会。
   
## Notes

<!-- Content_START -->

### 2024.09.23

Class: WTF Academy Solidity 101 1-4

Key points：
- `address` size = 20 byte
- `address payable` with memebers `transfer` and `send`
- from `address` type to `payable address` type:  `payable(_address)`
- Fixed-length byte arrays: **value type**
- Variable-length byte arrays **reference type**
- Use cases of byte arrays
  1. Information encoding and decoding: Multiple pieces of information, suce as flags and status,can be encoded into a single byte arrays to save gas.
- Function
  ```solidity
      function <function name> (<parameter types>) [internal|external|public|private] [virtual|override|pure|view|payable] [returns (<return types>)]
  ```

  ```mermaid
   graph TD
      A[Start] --> B{Choose visibility modifier}
      B -->|Externally callable| C[external]
      B -->|Internally callable| D[internal]
      B -->|Callable both externally and internally| E[public]
      B -->|Only callable within current contract| F[private]
      
      C & D & E & F --> G{Requires Ether payment?}
      G -->|Yes| H[payable]
      G -->|No| I{Modifies state?}
      
      I -->|Yes| J[No additional modifier needed]
      I -->|No| K{Reads state?}
      
      K -->|Yes| L[view]
      K -->|No| M[pure]
      
      H & J & L & M --> N{Is it a base class function?}
      N -->|Yes| O[virtual]
      N -->|No| P{Overrides a base class function?}
      
      P -->|Yes| Q[override]
      P -->|No| R[End]
      
      O --> R
      Q --> R
  ```  
- return: Destructuring assignments
  
  ```
   // Named return, still support return
    function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
        return(1, true, [uint256(1),2,5]);
    }
   ...
   uint256 _number;
   bool _bool;
   uint256[3] memory _array;
   (_number, _bool, _array) = returnNamed();
   ...
   (, _bool2, ) = returnNamed();

  ```
<!-- Content_END -->
