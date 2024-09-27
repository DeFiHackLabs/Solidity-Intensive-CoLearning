---
timezone: Asia/Shanghai
---


---

# Lisa

1. 自我介绍 
   軟體工程師， Solidity 初學者


2. 你认为你会完成本次残酷学习吗？
   會努力。
   
## Notes

<!-- Content_START -->

### 2024.09.23
#### Deploy
[Remix](https://remix.ethereum.org/) file, compiler, deploy

#### Value Types
bool, integer, address, bytes, enum
- address (20 bytes), payable address (transfer & send)

#### Function
```
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

- {internal|external|public|private}: 可見性
   - external： 整能從合約外部 or 內部 this.<function name>()
   - internal: 繼承合約可用
   - 定義的  function 一定要有


### 2024.09.24
#### Return
returns 定義回傳值

#### Data Storage
- Category
   - storage: 鍊上
   - memory, calldata: 暫存

a = b a 改動會改到 b (reference)
- Scope
   - state variable: contract (out of func), gas high
   - local variable: in func
   - global variable: 保留字

$單位 0 代替小數點

### 2024.09.25
#### Array
memory -> new
array 中第一個元素 type 決定

### 2024.09.26
#### Map
Key -> Value (Key 規定)
storage \ public -> getter

<!-- Content_END -->