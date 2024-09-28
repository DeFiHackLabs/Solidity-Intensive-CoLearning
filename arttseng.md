---
timezone: Asia/Taipei
---

---

1. 大約十年安卓開發。想學合約很久了，有很多問題想問。側鏈和L2的差異。OP Stack為什麼那麼快就可以建一條新鏈。POS的安全性如何保證，是靠質押越多越安全？僅剩少數質押者是不是也不去中心。

2. 你认为你会完成本次残酷学习吗？ 應該會

<!-- Content_START -->

### 2024.09.22
學習內容: 
報名

### 2024.09.23
學習內容: 
使用Remix, 跑Hellow,word。
ps.每按一次deploy 按鈕,會部署一次合約

### 2024.09.24
認識一些value type

### 2024.09.25
function的結構
function有三種權限，pure, view, payable<br>
payable或不指定要花 gas<br>
pure, view不花 gas<br>

### 2024.09.26
// 命名式返回
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}

// 命名式返回
function returnNamed2() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    return( 2, false, [uint256(3),2,1]);
}

但修飾詞memory要到下一課才有解釋。

### 2024.09.27
array和 struct 需要的儲存空間比較大故需指定類型, storage在鏈上, memory和 calldata在 local，比較省gas.
今天首次操作debug, 原來要是live debug,要按 forward才會變動

### 2024.09.28
array和struct的使用，先看快速掃過。
array型態在第一個元素宣告即可。如果使用memory則是固定長度。

<!-- Content_END -->