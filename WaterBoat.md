---
timezone: Asia/Shanghai
---


# WaterBoat

1. 自我介绍

Hi，我是WaterBoat，目前在深圳自由要饭中。

2. 你认为你会完成本次残酷学习吗？

会的

## Notes

<!-- Content_START -->

### 2024.09.23

##### Solidity 是什么

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7af14412fd1483cbf7330ca717823ce~tplv-k3u1fbpfcp-image.image#?w=1300&#x26;h=1300&#x26;s=1665&#x26;e=svg&#x26;a=1&#x26;b=000000" alt="Solidity logo" width="150">

Solidity 是一门面向合约的、为实现智能合约而创建的高级编程语言。这门语言受到了 C++，Python 和 Javascript 语言的影响，设计的目的是能在以太坊虚拟机（EVM）上运行。

Solidity 是静态类型语言，支持继承、库和复杂的用户定义类型等特性。

##### 开发工具

###### Remix

`remix`是以太坊官方推荐的智能合约开发IDE（集成开发环境），适合新手，可以在浏览器中快速部署测试智能合约，你不需要在本地安装任何程序。

网址：[remix.ethereum.org](https://remix.ethereum.org/)

进入`remix`，我们可以看到最左边的菜单有三个按钮，分别对应文件（写代码的地方），编译（跑代码），部署（部署到链上）。我们点新建（`Create New File`）按钮，就可以创建一个空白的`solidity`合约

![808fa2e3af25459cbc069f4fe976f05f_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232238085.jpg)

我们来编写一段代码

```solidity
// SPDX-License-Identifier: MIT // 不写这个编辑器会警告,但是不影响运行
pragma solidity ^0.8.0; // 指定编译器版本 不允许小于 0.8.0 或大于 0.9.0的编译器编译

contract HelloWorld { // 创建合约(contract) 名字为 HelloWorld
    // 定义变量类型为 string 变量名威 _string 赋值为 HelloWorld
    string public _string = "HelloWorld!";
}
```

编写好代码之后我们点击左侧的编译

![18c051af6f0d49989dc8ff4abb2a49ea_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232239365.jpg)

然后点击部署

![12](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240038.jpg)

点击即可查看到值

######  VSCode

如果你不喜欢在线的编译工具我们可以使用本地环境来进行编译代码

在 VScode 中搜索插件 [Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity) 进行安装,作用是让代码进行高亮和补充一些代码提示

![111](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232240976.jpg)

接下来我们打开 [remix](https://remix.ethereum.org/)

来到首页点击`Access File System`

![10f56a71c479438db788f17610ab7097_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232241733.jpg)

出现提示让我们安装一个 npm 包,我们根据文档的说明进行一下安装

```sh
npm install -g @remix-project/remixd
```

然后我们创建一个 sol 文件并在终端中找到他的文件夹所在地输入命令 `remixd`

![1a651ca9d68248c0a9c2d685a49bb6b7_tplv-k3u1fbpfcp-jj-](https://cdn.jsdelivr.net/gh/Silence-dream/bed@master/img/202409232242918.jpg)

并在网页上点击`content`进行连接即可完成

![image-20240426153811790](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/96b2e832ac8649b581574c1cd6922b18~tplv-k3u1fbpfcp-jj-mark:0:0:0:0:q75.image#?w=1066\&h=1024\&s=193843\&e=png\&b=212235)

##### 总结

这一讲,我们介绍了 solidity 、开发工具 remix 并且介绍了一下 vscode 和 remix 如何进行联动编写 HelloWorld。

<!-- Content_END -->