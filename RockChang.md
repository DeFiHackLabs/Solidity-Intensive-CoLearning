---
timezone: Asia/Taipei
---
---

# RockChang

1. 自我介绍
    Hi 我是Rock, 將會好好學習solidity知識！

3. 你认为你会完成本次残酷学习吗？
   我相信我會的
   
## Notes

<!-- Content_START -->

### 2024.09.23
1. Hello Web3

    依照教學使用remix ethereumIDE 開發Solidity寫出Hello Web3

    - 總之，什麼都不管的，直接建立一個新的檔案，命名為`HelloWeb3.sol`
    - 填入三行程式碼
        > 第一行要註釋，我手動輸入打錯字，竟然也會提示錯誤，很有趣
        
        > 第二行是編譯器版本，如果不知道，可以到Solitidy Compiler頁面找當前最新的版本來用

        > 第三行就是合約內容，包在contract裡面
    
    - 輸入好後儲存，到Deploy頁面，點下Deploy
    - Deploy完成後到左下角點擊String按鈕後，點開右邊的Call ....，尋找`decoded output`欄位，可以看到hello web3了
    -  花了一些時間在IDE上面打轉


2. ValueType
    - 依照教學去deploy了bool運算並查看了結果
    - 依照教學去deploy了整數運算，並查看結果
    - 地址有分`成address`和`payable address`兩種類型
    - 定长字节数组，理解成可以存一些數據，會省一些Gas?!
    

### 2024.09.24        
1. 在WTF完成前兩章的測驗
2. 學習第三張，function 功能，可視性的功能上{internal|external|public|private}，感覺重點在於，如果function要給外部call，就選擇public或者external，內部訪問就寫private或者是internal，測試的話一開始寫public比較方便。
3. about function permission的部分，分成[pure|view|payable]，而pure和view主要主要跟gas有關，而pure和view的function是不修改鏈上的狀態，也就不會被收gas，而教學上用瑪利歐的比喻也非常能理解
4. pure和view的部分比較不容易分得清楚
5. 完成了第三章的測驗
6. 學習第四章returns/return，並完成了第四章測驗


### 2024.09.25
1. 了解變數儲存的三種不同類型，storage、memory和calldata，memory和calldata是儲存在RAM裡面，，消耗的gas少，storage是儲存在硬碟上的，消耗gas大
2. 了解變數作用區，分別為狀態狀態、局部、全域三種類型，一般來說在合約內宣告的變數為狀態變數，而再pure function內的變數，因為跳出後，內部的變數就無效了，因此是儲存於RAM內，而全域變數則為預留關鍵字
3. 完成了第五章測驗
4. 完成了第六章測驗

### 2024.09.26
1. 學習了第七章mapping，但是還需要更多的範例或練習，才能夠更了解mapping能運用在哪一些用途上
2. 完成了第七章的測驗
3. 學習了變數宣告但不賦值時會有一個預設的值
4. 使用delete變數，可以將變數的值變為預設值
5. 完成了第八章的測驗
6. 第九章有點需要慢慢理解
    这一讲，我们介绍Solidity中和常量相关的两个关键字，constant（常量）和immutable（不变量）。状态变量声明这两个关键字之后，不能在初始化后更改数值。这样做的好处是提升合约的安全性并节省gas。

    另外，只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。


<!-- Content_END -->
