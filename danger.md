---
timezone: Asia/Shanghai
---


---

# danger

1. 自我介绍：
   
 -  大家好，各位助学老师好，我是一名编程小白，曾在跑节点与撸毛项目中使用ubuntu系统时接触过一些代码，但大部分都是使用一键脚本或直接按照教程复制粘贴代码，对代码内容基本一知半解，希望通过共学教程学习更多的知识。

2. 你认为你会完成本次残酷学习吗？

 -  我相信我可以！
   
## Notes

<!-- Content_START -->
### 2024.09.13
- 通过学习残酷共学GitHub提交教程,进行报名；通过浏览各位学友的自我介绍及代码，优化个人笔记相关内容。
  
### 2024.09.23

   作为一个代码小白，看了Solidity第一课的视频（https://www.youtube.com/watch?v=KWW9Y09erDM&list=PL-edkZcvwC5a7qIaHG4Rsj6DkOM3YH3eT）和网站（https://www.wtf.academy/docs/solidity-101/HelloWeb3/）  上的相关内容，看了之后的大概印象是：Solidity是运行在以太坊虚拟机上（Evm）的智能合约的编程语言，它的开发工具是Remix。

下边是对照网页和搜索引擎提炼的相关学习要点，为以后温习做准备。

学习内容：

- 1、以太坊虚拟机（英文EVM）：
  
之前用VM软件在windows系统的电脑上装过ubuntu系统，以太坊虚拟机从字面意思理解就是运行在eth链上的虚拟机，即为ETH上的VM,简称EVM。

- 2、智能合约（英文smart contract）：
  
智能合约是一种智能协议，在区块链内制定合约时使用，当中内含了代码函数(function),也能和其他合约进行交互、做决策、存储资料及发送以太币等功能。智能合约主要提供验证及执行合约内所订立的条件。智能合约允许在没有第三方的情况下进行可信交易。这些交易可追踪且不可逆转。

- 3、Solidity
  
Solidity是运用在EVM上智能合约的编程语言。

Solidity是一直面相  对象  和  静态类型  的语言。

它支持继承、库和复杂的用户定义类型，使开发人员能用轻松地构建复杂的智能合约。此外Solidity 非常适合开发各种功能，如投票、众筹、拍卖和多重签名钱包。它提供了丰富的内置函数和库，帮助开发人员快速实现这些功能。它的优势在于安全又灵活。静态类型有助于捕捉常见错误，提高代码的安全性，同时，支持各种库和用户自定义类型使开发人员能够灵活得构建复杂的智能合约。

- 4、开发工具：Remix
  
  Remix是以太坊推荐的智能合约集成开发环境（IDE),合适像我这样的小白新手，可以在浏览器里快手开发和部署合约，无需在本地安装任何程序。网站是https://remix.ethereum.org ，用github注册并登录了该网站，以保存相关学习文件
  
   - 4.1 Remix左侧菜单有五个按钮，分别对应文件（编写代码）、搜索、编译（运行代码）、部署和发交易（将合约部署到链上）、git，点击create new file 即可生成格式为.sol的空白Solidity合约。

  ![image](https://github.com/user-attachments/assets/9eefd823-47a7-43ee-9141-346936913130)
### 

   - 4.2 写了名为hellword的第一个Soliduty合约，合约内容如下

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.21;
    contract helloworld{ 
    string public _string = "hello web3";
    }
 这个程序有一行注释和三行代码，拆解程序，学习Solidity的代码源文件的结构

        // SPDX-License-Identifier: MIT
        
 - 4.2.1 第一行是注释，说明代码使用的软件许可（license），这里使用的是MIT许可，代码使用的软件许可，可以在https://spdx.org/licenses/ 里搜索mit查找，如果不写许可，编译时会出现warning,但程序仍然能运行。注释以“//"开头，后边跟注释内容，注释不会被程序执行。
   
       pragma solidity ^0.8.21;
    
 - 4.2.2 第2行声明源文件所使用的Solidity版本，因为不同版本的语法有所差异，一般都是最新版本的上一个版本。“^0.8.21”表示该程序适用于从当前版本到不大于重大版本更新的所有版本，即适用于0.8.21到<0.9

 - 在版本管理中，0.8.21 一般的代表的意义是:
0: major version 
8: minor version
21: patch version

major version 一般代表是大版本, 大于0 就代表出了一个稳定版本, 不同的大版本之间可能包含 breaking change, 升级大版本就要小心

而 ^ 代表的是 compatible with version, 它有两个意思, 

如果是对于已经有稳定版本的, 比如 ^1.2.3, 那么^ 就代表, major version 不能升级, 其实的小版本或者 patch 版本都可以升级，即 ^.1.2.3 = from 1.2.3 to < 2.0.0

对于还没有发布稳定版本，例如 ^0.8.21, 他的意思就是, 可以升级，但是不要变动到版本号中最左边的非零数字, 即 ^0.8.21 is 大于等于 0.8.21, 但小于0.9,  因为升级到0.9 就意味着 最左边的非零数字(left-most non-zero)变了

Solidity语句以分号;结尾

    contract helloworld{ 
    string public _string = "hello web3";
    }
- 4.2.3 第3、4行是合约部分。第三行创建合约并声明合约名字为helloword。第4行是合约内容，声明了一个string(字符串）变量 _string，并赋值为“hello web3”。

在remix编辑代码的页面，按Ctrl+s 即可编译代码，编译完成后，看是否有报错，根据报错提示修改相应代码，然后进入部署界面选择相应的Remix环境，remxi会分配一些测试账户，每个账户有100个eth测试代币，点击depoly，即可部署所写合约。
部署成功后，在下方会看到名为helloword的合约，点击_string,即可看到“hello web3”。
<!-- Content_END -->
