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

<!-- Content_END -->
