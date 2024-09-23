---
timezone: Asia/Shanghai
---

---

# YourName

1. 自我介绍
  大家好我叫Chen Bing Wei，我以前只有學習過往佔前後都開發，從未接觸solidity與smart contract這類的東西，但今年因緣際會下修了一門叫分散式金融導論的課，助教教的非常好，讓我對這個領域充滿極大的興趣，或許未來可以做跨領域的結合，結合網路服務，金融科技，與機器學習等現在所學的知識，創造出能對人類有所貢獻的東西，因此想藉由這次機會挑戰自己，參加此次活動逼迫自己學習。

2. 你认为你会完成本次残酷学习吗？
  會

## Notes

<!-- Content_START -->

### 2024.09.23

#### WTF is Solidity?
- Solidity is a programming language used for creating smart contracts on the Ethereum Virtual Machine (EVM).
- Solidity has two characteristics:
  1. **Object-oriented**: After learning it, you can use it to make money by finding the right projects.
  2. **Advanced**: If you can write smart contract in Solidity, you are the first class citizen of Ethereum.

#### Development tool: Remix
Remix is an smart contract development IDE (Integrated Development Environment) recommended by Ethereum official.
- Advantages
  1. **Suitable for Beginners**: It allows for quick deployment and testing of smart contracts in the browser, without needing to install any programs on your local machine.
  2. **Gas Estimation Issue**: It will estimation the cost of gas on every functions and display behind them, which can remind developers that wheter functions should be optimized or not.
- Disadvantages
  1. **Limited to Browser**: Since Remix is a browser-based IDE, it can be less stable or responsive compared to desktop IDEs like VSCode, especially when working with larger projects or multiple open files.
  2. **Collaboration Limitations**: Remix doesn’t have built-in features for real-time collaboration or version control like Git, making it more difficult to work in teams.

Website: [remix.ethereum.org](https://remix.ethereum.org)

#### The first Solidity program

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract HelloWeb3 {
    string public _string = "Hello Web3!";
}
```
1. The first line is a comment, which denotes the software license (license identifier) used by the program. We are using the MIT license. **If you do not indicate the license used, the program can compile successfully but will report an warning during compilation**. Solidity's comments are denoted with "//", followed by the content of the comment (which will not be run by the program). Details can be found in the [SPDX-License
documentation](https://spdx.org/licenses/).
2. The second line declares the **Solidity version** used by the source file, because the syntax of different versions is different. This line of code means that the source file will not allow compilation by compilers version **lower than v0.8.4 and not higher than v0.9.0** [0.8.4, 0.9.0).
  - There is slight difference among distinct
versions: 0.4.22 -> constructor, 0.8.0 -> safeMath
  - Include the pragma version in every file: Locking the version is preferable, except for libraries.
  - Pattern: pragma solidity x.y.z: e.g. **pragma solidity ^0.8.3 : [0.8.3, 0.9.0)** or **pragma solidity >=0.8.3 <0.8.7**
3. Lines 3 and 4 are the main body of the smart contract. Line 3 creates a contract with the name `HelloWeb3`. Line 4 is the content of the contract. Here, we created a string variable called _string and assign "Hello Web3!" as value to it.

#### Summary
In the first day, I learned what is `Solidity`, `Remix IDE`, and completed our first Solidity program - `HelloWeb3`.

### 

<!-- Content_END -->
