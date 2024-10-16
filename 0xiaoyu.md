---
timezone: Asia/Shanghai
---

---
# 0xiaoyu

1. 自我介绍

   Hotcoin Research的技术研究员、资深 gamer

2. 你认为你会完成本次残酷学习吗？

   努力完成，冲


## Notes

<!-- Content_START -->

### 2024.09.23

學習內容: 

- [solidity-101 第一课](https://www.wtf.academy/docs/solidity-101/HelloWeb3)

笔记：

HelloWeb3.sol

```
// SPDX-License-Identifier: MIT
// 开源代码的许可证类型

pragma solidity ^0.8.21;
// 指定编译器版本，表示此合约兼容0.8.21及以上版本，但不兼容0.9.0及以上版本

// 定义一个名为HelloWeb3的智能合约
contract HelloWeb3{

    // 定义一个名为_string的公共字符串变量，并初始化为"Hello Web3!"
    string public _string = "Hello Web3!";
    // public 关键字使得这个变量可以被外部读取
}
```

### 2024.09.24

學習內容: 

- [solidity-101 第二课 值类型](https://www.wtf.academy/docs/solidity-101/ValueTypes/)
- [solidity-101 第三课 函数输出](https://www.wtf.academy/docs/solidity-101/Function/)

笔记：值类型和函数

#### 1. 值类型

Solidity 中的值类型包括：

##### 1.1 布尔型 (bool)

- 取值：`true` 或 `false`
- 运算符：`!`（非）、`&&`（与）、`||`（或）、`==`（等于）、`!=`（不等于）
- 注意：`&&` 和 `||` 遵循短路规则

##### 1.2 整型 (int/uint)

- `int`：包括负数的整数
- `uint`：正整数
- `uint256`：256位正整数
- 运算符：
  - 比较：`<=`、`<`、`==`、`!=`、`>=`、`>`
  - 算术：`+`、`-`、`*`、`/`、`%`（取余）、`**`（幂）

##### 1.3 地址类型 (address)

- 普通地址：存储 20 字节的值
- payable address：可以接收转账，有 `transfer` 和 `send` 方法

##### 1.4 定长字节数组

- 属于值类型
- 类型：`bytes1`, `bytes8`, `bytes32` 等
- 最多存储 32 bytes 数据

##### 1.5 枚举 (enum)

- 用户定义的数据类型
- 可以和 uint 显式转换

#### 2. 函数

Solidity 函数的基本结构：

```
solidity
function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]
```

#####  2.1 函数可见性

- `public`：内部和外部均可见
- `private`：只能从本合约内部访问
- `external`：只能从合约外部访问
- `internal`：只能从合约内部和继承的合约访问

#####  2.2 函数权限/功能关键字

- `pure`：不能读取也不能写入状态变量
- `view`：能读取但不能写入状态变量
- `payable`：可以接收 ETH 转账

#####  2.3 状态修改

以下操作被视为修改链上状态：

1. 写入状态变量
2. 释放事件
3. 创建其他合约
4. 使用 `selfdestruct`
5. 通过调用发送以太币
6. 调用任何未标记 `view` 或 `pure` 的函数
7. 使用低级调用
8. 使用包含某些操作码的内联汇编

##### 2.4 注意事项

- 合约中定义的函数需要明确指定可见性
- `public|private|internal` 也可用于修饰状态变量
- 包含 `pure` 和 `view` 关键字的函数直接调用不需要支付 gas 费用


### 2024.09.25

學習內容: 

- [solidity-101 第四课 函数输出](https://www.wtf.academy/docs/solidity-101/Return)

笔记：

#### 1. return 和 returns

- `returns`: 函数声明的一部分，指定返回类型
- `return`: 在函数体内使用，指定实际返回的值

思考：为什么Solidity需要这两个关键字？其他语言是如何处理的？
- Solidity使用这两个关键字是为了提高代码的清晰度和灵活性。returns在函数声明中指定返回类型，使函数签名更明确；return在函数体中指定实际返回的值。
- 许多其他语言（如JavaScript、Python）只使用一个return关键字。Solidity的方式更接近于静态类型语言如Java或C++，但更明确地分离了声明和实现。
- 这种设计有助于智能合约的静态分析和优化，对于在区块链上运行的代码来说非常重要。

#### 2. 多变量返回

```solidity
function returnMultiple() public pure returns(uint256, bool, uint256[3] memory){
    return(1, true, [uint256(1),2,5]);
}
```

注意点：
- 返回数组时需要指定 `memory`
- 数组元素类型需要明确（如 `uint256(1)`）

问题：多变量返回在哪些场景下特别有用？有什么潜在的缺点吗？
- 使用场景：
  - 当函数需要返回多个相关但不同类型的数据时，如用户信息（ID、名称、余额）。
  - 在需要同时返回操作结果和状态信息时，如（是否成功、错误信息、影响的记录数）。
  - 在复杂计算中，需要返回多个计算结果。

- 潜在缺点：
  - 可能增加gas消耗，特别是当返回大型数据结构时。
  - 如果返回值过多，可能降低代码可读性。
  - 调用者必须处理所有返回值，即使只需要其中一部分，可能导致效率低下。

#### 3. 命名式返回

```solidity
function returnNamed() public pure returns(uint256 _number, bool _bool, uint256[3] memory _array){
    _number = 2;
    _bool = false;
    _array = [uint256(3),2,1];
}
```

优点：
- 代码更清晰
- 自动返回，不需要 `return` 语句

思考：命名式返回如何影响gas消耗？在大型合约中使用命名式返回有什么注意事项？
- Gas消耗：
  - 命名式返回可能略微增加部署成本，因为它在合约中定义了额外的变量。
  - 但在执行时，它可能轻微减少gas消耗，因为不需要额外的return语句。

- 大型合约注意事项：
  - 保持一致性：在整个合约中统一使用命名式返回或普通返回，以提高可读性。
  - 避免名称冲突：在大型合约中，要注意返回变量名称不要与其他函数或状态变量冲突。
  - 文档化：由于命名式返回使函数签名更复杂，确保有良好的文档说明每个返回值的含义。
  - 考虑可维护性：虽然命名式返回可以提高可读性，但在频繁修改的合约中可能增加维护难度。

#### 4. 解构式赋值

全部赋值：
```solidity
(_number, _bool, _array) = returnNamed();
```

部分赋值：
```solidity
(, _bool2, ) = returnNamed();
```

思考：解构式赋值如何提高代码的可读性和效率？在处理复杂返回值时有什么技巧？

- 提高可读性和效率：
  - 允许直观地将多个返回值分配给变量，使代码更简洁。
  - 可以只提取需要的值，忽略其他值，减少不必要的变量声明。
  - 使函数调用和值分配在一行内完成，提高代码密度。

- 处理复杂返回值的技巧：
  - 使用有意义的变量名，与返回值的命名保持一致。
  - 对于不需要的值，使用下划线（_）占位。
  - 考虑将相关的返回值组合成结构体，使解构更有组织。
  - 在复杂情况下，可以先解构到临时变量，然后再处理，以提高代码清晰度。



#### 5. 深入思考

1. Solidity的函数返回机制与其他语言（如JavaScript或Python）有何不同？这些差异背后的原因是什么？

答：
Solidity的函数返回机制与JavaScript或Python有几个关键差异：

a) 静态类型 vs 动态类型：
   - Solidity: 强制在函数声明时指定返回类型（使用`returns`关键字）。
   - JavaScript/Python: 动态类型，不需要预先声明返回类型。

   原因：Solidity的静态类型系统有助于在编译时捕获错误，提高合约的安全性和性能。在区块链环境中，这一点尤为重要，因为部署后的错误修复成本很高。

b) 多值返回：
   - Solidity: 原生支持多值返回，无需额外包装。
   - JavaScript: 通常使用数组或对象来返回多个值。
   - Python: 支持元组解包，类似Solidity的多值返回。

   原因：Solidity的设计考虑了智能合约的特殊需求，如同时返回操作状态和结果值，这在区块链交易中很常见。

c) 命名返回：
   - Solidity: 支持命名返回值，可以在函数签名中声明返回变量名。
   - JavaScript/Python: 不支持在函数签名中命名返回值。

   原因：这增加了Solidity代码的自文档化能力，对于复杂合约的阅读和审计非常有帮助。

d) Gas考虑：
   - Solidity: 返回机制设计考虑了gas优化。
   - JavaScript/Python: 不需要考虑类似的资源限制。

   原因：在以太坊网络中，每个操作都有gas成本，Solidity的设计需要平衡表达能力和执行效率。

2. 在智能合约的上下文中，函数返回值的设计如何影响合约的安全性和效率？

答：
函数返回值的设计对智能合约的安全性和效率有重大影响：

a) 安全性：
   - 类型安全：明确指定返回类型可以防止类型相关的错误和攻击。
   - 状态表达：返回值可以清晰地表达操作的结果和合约状态，减少误解和错误使用。
   - 错误处理：适当的返回值设计（如使用布尔值表示成功/失败）可以促进更好的错误处理。
   - 重入攻击防护：谨慎设计返回值可以帮助防止某些类型的重入攻击。

b) 效率：
   - Gas优化：返回值的数量和类型直接影响gas消耗。返回大型数据结构可能导致高gas成本。
   - 执行时间：复杂的返回值处理可能增加合约的执行时间，影响性能。
   - 存储考虑：返回存储在状态变量中的数据vs内存中的数据有不同的gas成本。

c) 可维护性和可读性：
   - 清晰的返回值设计使合约更容易理解和维护。
   - 适当使用命名返回可以提高代码的自文档化程度。

d) 接口设计：
   - 返回值是合约公共接口的一部分，影响其他合约和DApp如何与之交互。
   - 设计良好的返回值可以提高合约的可组合性和可扩展性。

3. 考虑gas优化，如何在返回多个值和保持代码清晰之间取得平衡？

答：
在Solidity中平衡多值返回和代码清晰度，同时考虑gas优化，可以采取以下策略：

a) 结构化返回：
   - 对于相关的多个返回值，考虑使用结构体。这可以提高代码清晰度，同时在某些情况下可能比多个独立变量更gas高效。
   - 例如：`struct Result { bool success; uint256 value; string message; }`

b) 权衡返回值数量：
   - 限制返回值的数量。通常，3-4个返回值是一个好的上限。
   - 如果需要返回更多值，考虑将它们组织成结构体或分割成多个函数。

c) 使用事件代替部分返回值：
   - 对于不直接影响合约执行流程的信息，考虑使用事件而不是返回值。
   - 事件在某些情况下可能更gas高效，特别是对于大量数据。

d) 利用命名返回：
   - 使用命名返回可以提高代码可读性，同时不增加gas成本。
   - 例如：`function example() public view returns (uint256 value, bool success) { ... }`

e) 考虑返回值的数据位置：
   - 对于大型数据结构，考虑返回内存引用而不是存储引用可以节省gas。
   - 但要注意，这可能影响数据的持久性。

f) 使用紧凑编码：
   - 对于需要返回的小整数值，考虑打包成一个更大的整数，然后在客户端解包。
   - 这可以减少返回值的数量，但可能降低代码可读性。

g) 权衡返回vs修改状态：
   - 在某些情况下，将结果存储在状态变量中而不是直接返回可能更gas高效，特别是如果这些值会被频繁访问。

h) 文档和注释：
   - 无论采用哪种方法，确保通过注释和文档清晰解释返回值的含义和使用方法。

通过仔细考虑这些因素，可以在gas效率、代码清晰度和合约安全性之间找到适当的平衡点。最佳方法往往取决于特定合约的需求和使用场景。


### 2024.09.26

學習內容: 

- [solidity-101 第五课 变量数据存储和作用域](https://www.wtf.academy/docs/solidity-101/DataStorage/)


笔记

#### 1.Solidity 变量数据存储和作用域

引用类型（Reference Type）
- 包括数组（array）和结构体（struct）
- 占用存储空间大，使用时必须声明数据存储位置

数据存储位置
- storage
  - 合约里的状态变量默认使用
  - 存储在链上，类似计算机硬盘
  - 消耗 gas 多
- memory
  - 用于函数参数和临时变量
  - 存储在内存中，不上链
  - 消耗 gas 少
  - 适用于返回变长数据类型（如 string, bytes, array 等）
- calldata
  - 类似 memory，存储在内存中，不上链
  - 变量不可修改（immutable）
  - 常用于函数参数

数据位置赋值规则

- storage 到 local storage：创建引用，修改会影响原变量
- memory 到 memory：创建引用，修改会影响原变量
- 其他情况：创建独立副本，修改不影响原变量

变量作用域

- 状态变量
  - 存储在链上
  - 所有合约内函数可访问
  - gas 消耗高
- 局部变量
  - 仅在函数执行过程中有效
  - 存储在内存中，不上链
  - gas 消耗低
- 全局变量
  - Solidity 预留关键字
  - 可在函数内直接使用，无需声明
  - 例如：msg.sender, block.number, msg.data 等


以太单位与时间单位

- 以太单位：wei, gwei, ether
- 时间单位：seconds, minutes, hours, days, weeks

##### 思考

1. 为什么 Solidity 需要不同的数据存储位置？
解答：Solidity 设计不同的数据存储位置主要是为了优化智能合约的执行效率和降低 gas 成本。storage 存储在链上，适合需要永久保存的数据，但 gas 成本高；memory 和 calldata 存储在内存中，适合临时数据，gas 成本低。这种设计让开发者可以根据数据的用途和生命周期选择最合适的存储位置。

2. calldata 和 memory 的主要区别是什么？
解答：虽然 calldata 和 memory 都存储在内存中，但主要区别在于：

- calldata 中的数据是不可修改的，而 memory 中的数据可以修改。
- calldata 主要用于函数参数，特别是外部函数的参数，而 memory 可用于函数参数和临时变量。
- calldata 通常比 memory 更节省 gas，因为它不需要将数据复制到内存中。


3. 为什么 Solidity 中要引入以太单位和时间单位？
解答：引入这些单位主要是为了提高代码的可读性和减少错误：

- 以太单位（如 wei, gwei, ether）帮助开发者在处理不同精度的以太币值时更加直观和准确，避免因单位转换错误导致的问题。
- 时间单位（如 seconds, minutes, hours）使得在合约中处理时间相关的逻辑时更加清晰和易于理解，减少了因手动计算时间而可能产生的错误。


### 2024.09.27

學習內容: 

- [solidity-101 第六课 引用类型](https://www.wtf.academy/docs/solidity-101/ArrayAndStruct/)

笔记

#### 1. 数组（Array）

- 固定长度数组
   - 声明格式：T[k]（T 为元素类型，k 为长度）
   - 例：uint[8] array1;

- 可变长度数组（动态数组）
  - 声明格式：T[]
  - 例：uint[] array4;
  - 特殊情况：bytes 是数组，不需要加 []

- 创建数组规则
   - memory 修饰的动态数组需用 new 操作符创建，且长度固定
   - 数组字面常数用方括号初始化，类型以第一个元素为准

- 数组成员
   - length：数组元素数量
   - push()：动态数组末尾添加元素
   - pop()：移除动态数组最后一个元素



#### 2. 结构体（Struct）

定义方法
```
struct Student {
    uint256 id;
    uint256 score;
}
```

赋值方法
-  在函数中创建 storage 引用
- 直接引用状态变量
- 构造函数式


#### 3. 思考与解答

1. 为什么 Solidity 中区分固定长度和可变长度数组？
这种区分主要是为了优化性能和 gas 消耗。

- 固定长度数组：预先知道大小，可以更高效地分配存储空间，适用于元素数量固定的场景。
- 可变长度数组：灵活性更高，可以动态添加或删除元素，适用于元素数量不确定的场景，但可能消耗更多 gas。


2. bytes 和 byte[] 有什么区别？

- bytes 是动态字节数组，更紧凑，gas 成本更低。
- byte[] 是单字节数组的动态数组，每个元素占用单独的存储槽，gas 成本较高。
- 对于大多数情况，bytes 是更优选择，除非需要修改单个字节。


3. 结构体的不同赋值方法有什么优缺点？

- Storage 引用：可以修改状态变量，但需注意引用的生命周期。
- 直接引用状态变量：简洁直观，但每次赋值都会修改状态变量。
- 构造函数式：一次性初始化所有字段，代码简洁。
- Key-value 方式：可读性好，适合字段较多的结构体。

选择哪种方法取决于具体需求、代码可读性和 gas 优化考虑。



### 2024.09.28

學習內容: 

- [solidity-101 第七课 映射类型 mapping](https://www.wtf.academy/docs/solidity-101/Mapping/)

笔记


#### 映射（Mapping）的基本概念
- 通过键（`Key`）查询对应的值（`Value`）
- 声明格式：`mapping(_KeyType => _ValueType)`
- 示例：
  ```solidity
  mapping(uint => address) public idToAddress; // id映射到地址
  mapping(address => address) public swapPair; // 币对的映射，地址到地址
  ```

#### 映射的规则
1. `_KeyType` 只能是 Solidity 内置的值类型（如 `uint`、`address`），不能用自定义结构体
2. 映射的存储位置必须是 `storage`
3. 声明为 `public` 时，Solidity 自动创建 getter 函数
4. 新增键值对语法：`_Var[_Key] = _Value`

#### 映射的原理
1. 不储存键（`Key`）的信息，没有 length 信息
2. 使用 `keccak256(abi.encodePacked(key, slot))` 作为 offset 存取 value
3. 未赋值的键初始值为该类型的默认值（如 uint 默认为 0）

#### 思考与解答
1. 为什么映射的 `_KeyType` 不能使用自定义结构体？
   - 这可能是为了确保键的唯一性和哈希计算的效率。内置类型有固定的大小和明确的哈希方法，而自定义结构体可能导致复杂性和不确定性。

2. 映射为什么必须存储在 `storage` 中？
   - 映射通常用于存储大量数据和持久化信息。`storage` 是区块链上的永久存储空间，适合存储这种需要长期保存的数据结构。

3. 映射不存储键信息会有什么影响？
   - 这意味着我们无法直接获取所有的键或遍历映射。如果需要这些功能，通常需要额外维护一个数组来存储所有的键。


### 2024.09.28

學習內容: 

- [solidity-101 第七课 映射类型 mapping](https://www.wtf.academy/docs/solidity-101/Mapping/)

笔记


#### 映射（Mapping）的基本概念
- 通过键（`Key`）查询对应的值（`Value`）
- 声明格式：`mapping(_KeyType => _ValueType)`
- 示例：
  ```solidity
  mapping(uint => address) public idToAddress; // id映射到地址
  mapping(address => address) public swapPair; // 币对的映射，地址到地址
  ```

#### 映射的规则
1. `_KeyType` 只能是 Solidity 内置的值类型（如 `uint`、`address`），不能用自定义结构体
2. 映射的存储位置必须是 `storage`
3. 声明为 `public` 时，Solidity 自动创建 getter 函数
4. 新增键值对语法：`_Var[_Key] = _Value`

#### 映射的原理
1. 不储存键（`Key`）的信息，没有 length 信息
2. 使用 `keccak256(abi.encodePacked(key, slot))` 作为 offset 存取 value
3. 未赋值的键初始值为该类型的默认值（如 uint 默认为 0）

#### 思考与解答
1. 为什么映射的 `_KeyType` 不能使用自定义结构体？
   - 这可能是为了确保键的唯一性和哈希计算的效率。内置类型有固定的大小和明确的哈希方法，而自定义结构体可能导致复杂性和不确定性。

2. 映射为什么必须存储在 `storage` 中？
   - 映射通常用于存储大量数据和持久化信息。`storage` 是区块链上的永久存储空间，适合存储这种需要长期保存的数据结构。

3. 映射不存储键信息会有什么影响？
   - 这意味着我们无法直接获取所有的键或遍历映射。如果需要这些功能，通常需要额外维护一个数组来存储所有的键。



### 2024.09.29

學習內容: 

- [solidity-101 第八课  变量初始值](https://www.wtf.academy/docs/solidity-101/InitialValue/)

笔记

#### 值类型初始值
- `boolean`: `false`
- `string`: `""`
- `int`: `0`
- `uint`: `0`
- `enum`: 枚举中的第一个元素
- `address`: `0x0000000000000000000000000000000000000000` (或 `address(0)`)
- `function`:
  - `internal`: 空白函数
  - `external`: 空白函数

示例代码：
```solidity
bool public _bool; // false
string public _string; // ""
int public _int; // 0
uint public _uint; // 0
address public _address; // 0x0000000000000000000000000000000000000000

enum ActionSet { Buy, Hold, Sell}
ActionSet public _enum; // 第1个内容Buy的索引0

function fi() internal{} // internal空白函数
function fe() external{} // external空白函数 
```

#### 引用类型初始值
- 映射 `mapping`: 所有元素都为其默认值的 `mapping`
- 结构体 `struct`: 所有成员设为其默认值的结构体
- 数组 `array`:
  - 动态数组: `[]`
  - 静态数组（定长）: 所有成员设为其默认值的静态数组

示例代码：
```solidity
uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
uint[] public _dynamicArray; // `[]`
mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
// 所有成员设为其默认值的结构体 0, 0
struct Student{
    uint256 id;
    uint256 score; 
}
Student public student;
```

#### `delete` 操作符
`delete a` 会让变量 `a` 的值变为初始值。

示例代码：
```solidity
bool public _bool2 = true; 
function d() external {
    delete _bool2; // delete 会让_bool2变为默认值，false
}
```

#### 思考与解答

1. 为什么了解变量的初始值很重要？
   - 了解初始值有助于避免潜在的错误和意外行为。例如，在条件判断中，如果不知道 `bool` 类型的初始值是 `false`，可能会导致逻辑错误。

2. 动态数组和静态数组的初始值有什么区别？为什么会有这种区别？
   - 动态数组的初始值是空数组 `[]`，而静态数组的初始值是所有元素都设为默认值的数组。这是因为静态数组的长度是固定的，必须在创建时就分配所有空间，而动态数组可以根据需要增长。

3. `delete` 操作符和将变量赋值为其类型的默认值有什么区别？
   - 从结果上看，两者是相同的。但 `delete` 操作符更加通用，可以用于任何类型，包括复杂的数据结构。此外，使用 `delete` 可能在某些情况下更节省 gas，因为它直接将存储槽重置为初始状态。
  

### 2024.09.30

學習內容: 

- [solidity-101 第九课  常数](https://www.wtf.academy/docs/solidity-101/Constant/)

笔记

#### constant（常量）
- 必须在声明时初始化
- 声明后不能更改值
- 适用于数值变量、string 和 bytes

示例代码：
```solidity
uint256 constant CONSTANT_NUM = 10;
string constant CONSTANT_STRING = "0xAA";
bytes constant CONSTANT_BYTES = "WTF";
address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
```

#### immutable（不变量）
- 可以在声明时或构造函数中初始化
- 初始化后不能更改值
- 适用于数值变量，不适用于 string 和 bytes
- 从 Solidity v8.0.21 开始，不需要显式初始化

示例代码：
```solidity
uint256 public immutable IMMUTABLE_NUM = 9999999999;
address public immutable IMMUTABLE_ADDRESS;
uint256 public immutable IMMUTABLE_BLOCK;
uint256 public immutable IMMUTABLE_TEST;

constructor(){
    IMMUTABLE_ADDRESS = address(this);
    IMMUTABLE_NUM = 1118;
    IMMUTABLE_TEST = test();
}

function test() public pure returns(uint256){
    uint256 what = 9;
    return(what);
}
```

#### 思考与解答

1. 为什么使用 constant 和 immutable 可以节省 gas？
   - 使用 constant 和 immutable 可以节省 gas，因为这些变量的值在编译时就已确定，不需要在运行时从存储中读取。编译器可以直接将这些值硬编码到字节码中，减少了存储和读取操作，从而降低了 gas 消耗。

2. constant 和 immutable 的主要区别是什么？在什么情况下应该选择使用 immutable 而不是 constant？
   - 主要区别在于初始化时机和灵活性。constant 必须在声明时初始化，而 immutable 可以在构造函数中初始化。当变量的值需要在部署时动态确定，但之后不再改变时，应该使用 immutable。例如，合约拥有者的地址可能在部署时才能确定，这时就适合使用 immutable。

3. 为什么 string 和 bytes 可以声明为 constant 但不能声明为 immutable？
   - 这与 Solidity 的内部实现有关。constant 变量在编译时就完全确定，可以直接嵌入字节码。而 immutable 变量虽然也是常量，但其值是在构造函数中设置的。对于定长类型（如 uint、address），这种延迟初始化很容易实现。但对于不定长类型（如 string 和 bytes），在构造函数中初始化会涉及到复杂的存储分配问题，因此目前不支持将它们声明为 immutable。


### 2024.10.01

學習內容: 

- [solidity-101 第十课  控制流，用Solidity实现插入排序](https://www.wtf.academy/docs/solidity-101/InsertionSort/)

笔记

#### Solidity 控制流
Solidity 的控制流与其他编程语言类似，主要包括：

1. if-else 语句
2. for 循环
3. while 循环
4. do-while 循环
5. 三元运算符

此外，还有 `continue` 和 `break` 关键字可用于控制循环流程。

#### 插入排序算法实现

##### Python 实现
首先看一下 Python 中的插入排序实现：

```python
def insertionSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1
        while j >=0 and key < arr[j] :
            arr[j+1] = arr[j]
            j -= 1
        arr[j+1] = key
    return arr
```

##### Solidity 实现（错误版本）
直接将 Python 代码转换为 Solidity 可能导致错误：

```solidity
function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {    
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i-1;
        while( (j >= 0) && (temp < a[j])){
            a[j+1] = a[j];
            j--;
        }
        a[j+1] = temp;
    }
    return(a);
}
```

##### Solidity 实现（正确版本）
修复后的正确 Solidity 实现：

```solidity
function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
    for (uint i = 1;i < a.length;i++){
        uint temp = a[i];
        uint j=i;
        while( (j >= 1) && (temp < a[j-1])){
            a[j] = a[j-1];
            j--;
        }
        a[j] = temp;
    }
    return(a);
}
```

#### 思考与解答

1. 为什么直接将 Python 代码转换为 Solidity 会导致错误？
   - 解答：主要原因是 Solidity 中的 uint 类型不能取负值。在 Python 版本中，j 可能会变为 -1，而在 Solidity 中这会导致下溢（underflow）错误。

2. Solidity 中的控制流与其他语言有什么显著区别？
   - 解答：Solidity 的控制流结构与其他语言大致相同。然而，由于 Solidity 是为智能合约设计的语言，在使用循环时需要特别注意 gas 消耗。过于复杂或长时间运行的循环可能导致交易失败。

3. 在实现算法时，Solidity 相比其他语言有哪些需要特别注意的地方？
   - 解答：
     - 类型安全：需要格外注意变量类型，特别是有符号和无符号整数的使用。
     - Gas 优化：需要考虑算法的效率，尽量减少循环次数和存储操作。
     - 数组操作：Solidity 中的数组操作可能比其他语言更受限制，需要谨慎处理。
     - 精度问题：处理小数时需要特别注意，因为 Solidity 不直接支持浮点数。

### 2024.10.02

學習內容: 

- [solidity-101 第十一课  构造函数和修饰器](https://www.wtf.academy/docs/solidity-101/Modifier/)

笔记

#### 构造函数（Constructor）

构造函数是一种特殊的函数，在合约部署时自动运行一次，用于初始化合约状态。

##### 特点：
- 每个合约只能有一个构造函数
- 在合约部署时自动执行
- 可以用来初始化合约的状态变量

##### 示例代码：
```solidity
address owner; // 定义owner变量

constructor(address initialOwner) {
    owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
}
```

##### 注意：
Solidity 0.4.22 版本之前，构造函数使用与合约同名的函数来定义。新版本使用 `constructor` 关键字，以避免潜在的命名错误。

#### 修饰器（Modifier）

修饰器是 Solidity 特有的语法，用于在函数执行前进行条件检查，可以减少代码重复并提高可读性。

##### 特点：
- 用于函数的声明
- 可以在函数执行前进行条件检查
- 使用 `_` 符号表示函数主体的插入点

##### 示例代码：
```solidity
modifier onlyOwner {
   require(msg.sender == owner); // 检查调用者是否为owner地址
   _; // 如果是的话，继续运行函数主体；否则报错并revert交易
}

function changeOwner(address _newOwner) external onlyOwner {
   owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
}
```

#### 思考与解答

1. 为什么构造函数在合约中很重要？
   - 解答：构造函数对于合约的初始化至关重要。它允许我们在部署时设置关键的状态变量，如所有者地址、初始代币供应量等。这种机制确保了合约在开始运行时就处于正确的初始状态。

2. 修饰器和普通函数有什么区别？为什么要使用修饰器？
   - 解答：修饰器与普通函数的主要区别在于其用途和语法。修饰器主要用于在函数执行前进行条件检查，而不是执行具体的业务逻辑。使用修饰器可以提高代码的可重用性和可读性，特别是在需要对多个函数应用相同的访问控制或验证逻辑时。

3. 在使用修饰器时，`_` 符号的作用是什么？
   - 解答：在修饰器中，`_` 符号表示被修饰函数的执行点。修饰器中 `_` 之前的代码会在函数主体执行之前运行，`_` 之后的代码会在函数主体执行之后运行。这允许开发者在函数执行的不同阶段插入自定义逻辑。


### 2024.10.03

學習內容: 

- [solidity-101 第十二课  事件](https://www.wtf.academy/docs/solidity-101/Event/)

笔记


#### 事件的特点
1. 响应性：应用程序可以通过 RPC 接口订阅和监听这些事件，并在前端做出响应。
2. 经济性：相比于链上存储变量，事件是一种更经济的数据存储方式。

#### 事件的声明和使用

##### 声明事件
```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

- 使用 `event` 关键字声明
- 可以包含 `indexed` 参数，最多 3 个

##### 释放事件
```solidity
function _transfer(address from, address to, uint256 amount) external {
    _balances[from] -= amount;
    _balances[to] += amount;
    emit Transfer(from, to, amount);
}
```

- 使用 `emit` 关键字释放事件

#### EVM 日志结构

EVM 日志包含两部分：
1. 主题（topics）：
   - 第一个元素是事件签名的哈希
   - 最多可包含 3 个 indexed 参数
2. 数据（data）：
   - 存储非 indexed 参数
   - 可以存储任意大小的数据

#### 思考与解答

1. 为什么事件比直接存储状态变量更经济？
   - 解答：事件数据存储在交易的日志中，而不是在合约的存储空间。日志操作的 gas 成本远低于存储操作。此外，事件数据不占用合约的永久存储空间，进一步降低了成本。

2. `indexed` 参数和非 `indexed` 参数有什么区别？
   - 解答：
     - `indexed` 参数：
       - 存储在日志的 topics 中
       - 可以被高效地检索和过滤
       - 最多 3 个
       - 如果是大型数据（如字符串），会被哈希处理
     - 非 `indexed` 参数：
       - 存储在日志的 data 部分
       - 可以存储任意大小的数据
       - 不能直接被检索，但存储成本更低

3. 事件在智能合约开发中有哪些常见用途？
   - 解答：
     - 记录重要的状态变化（如代币转账）
     - 为 DApp 前端提供数据更新通知
     - 作为去中心化预言机的数据源
     - 提供合约操作的审计跟踪
     - 在不增加存储成本的情况下保存历史数据



### 2024.10.04

學習內容: 

- [solidity-101 第十三课  继承](https://www.wtf.academy/docs/solidity-101/Inheritance/)

笔记


#### 继承的基本规则
- `virtual`: 父合约中希望子合约重写的函数需要加上此关键字。
- `override`: 子合约重写父合约函数时需要加上此关键字。

#### 继承类型

1. 简单继承
   - 使用 `is` 关键字实现继承
   - 子合约可以重写父合约的函数

2. 多重继承
   - 可以继承多个合约
   - 继承顺序应从最高辈分到最低
   - 重写多个父合约的同名函数时，需要指明所有父合约名

3. 修饰器继承
   - 修饰器可以像函数一样被继承和重写

4. 构造函数继承
   - 可以在继承声明时指定父构造函数参数
   - 可以在子合约构造函数中调用父构造函数

5. 钻石继承（菱形继承）
   - 一个派生类同时有两个或以上的基类
   - 使用 `super` 关键字时会调用继承链上的每个相关函数

#### 调用父合约函数
1. 直接调用：`父合约名.函数名()`
2. 使用 `super` 关键字：`super.函数名()`

#### 思考与解答

1. 为什么 Solidity 中的继承顺序很重要？
   - 解答：Solidity 中的继承顺序决定了函数的优先级。在多重继承中，越靠右的合约优先级越高。这影响了 `super` 关键字的行为和函数重写的解析顺序。

2. `virtual` 和 `override` 关键字的作用是什么？
   - 解答：`virtual` 表明一个函数可以被子合约重写，`override` 表示该函数重写了父合约的函数。这种机制增加了代码的可读性和安全性，防止意外重写。

3. 钻石继承中的 `super` 关键字与普通继承有何不同？
   - 解答：在钻石继承中，`super` 会按照特定顺序调用所有相关的父合约函数，而不仅仅是最近的父合约。这种行为基于 C3 线性化算法，确保每个合约只被调用一次，避免重复执行。



### 2024.10.05

學習內容: 

- [solidity-101 第十四课  抽象合约和接口](https://www.wtf.academy/docs/solidity-101/Interface/)

笔记


#### 抽象合约
- 定义：包含至少一个未实现函数的合约
- 特点：
  - 必须使用 `abstract` 关键字声明
  - 未实现的函数需要加 `virtual` 关键字
- 示例：
  ```solidity
  abstract contract InsertionSort {
      function insertionSort(uint[] memory a) public pure virtual returns(uint[] memory);
  }
  ```

#### 接口
- 定义：类似于抽象合约，但不实现任何功能
- 规则：
  1. 不能包含状态变量
  2. 不能包含构造函数
  3. 不能继承除接口外的其他合约
  4. 所有函数都必须是 external 且没有函数体
  5. 继承接口的非抽象合约必须实现所有功能
- 重要性：
  - 定义了合约的骨架和交互方式
  - 提供函数选择器和接口 ID 信息
- 示例（IERC721 接口）：
  ```solidity
  interface IERC721 is IERC165 {
      event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
      // ... 其他事件和函数声明
      function balanceOf(address owner) external view returns (uint256 balance);
      // ... 其他函数声明
  }
  ```

#### 接口的应用
- 用于与已知实现特定接口的合约交互
- 示例：与 BAYC (ERC721 代币) 交互
  ```solidity
  contract interactBAYC {
      IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
      
      function balanceOfBAYC(address owner) external view returns (uint256 balance) {
          return BAYC.balanceOf(owner);
      }
      
      // ... 其他交互函数
  }
  ```

#### 思考与解答

1. 抽象合约和接口的主要区别是什么？
   - 解答：
     - 抽象合约可以包含已实现的函数和状态变量，而接口不能。
     - 抽象合约的函数可以有不同的可见性，接口的所有函数必须是 external。
     - 抽象合约可以继承其他合约和接口，而接口只能继承其他接口。

2. 为什么接口在智能合约开发中如此重要？
   - 解答：
     - 标准化：接口定义了标准（如 ERC20、ERC721），使得不同的合约可以遵循相同的规范。
     - 互操作性：通过接口，不同的合约可以轻松地相互交互，而不需要了解具体实现。
     - 抽象：接口提供了一层抽象，使得开发者可以专注于功能而不是实现细节。
     - 升级性：通过接口，可以更容易地升级合约实现而不影响其他依赖它的合约。

3. 在实际开发中，如何选择使用抽象合约或接口？
   - 解答：
     - 使用抽象合约：当你想要提供一些基本实现，但又想留下一些函数供子合约实现时。
     - 使用接口：当你想定义一个纯粹的契约或标准，不包含任何实现时。
     - 通常，对于标准化的协议（如 ERC 标准），使用接口更为常见。


### 2024.10.07

學習內容: 

- [solidity-101 第十五课  异常](https://www.wtf.academy/docs/solidity-101/Errors/)

笔记


#### Error
- 引入版本：Solidity 0.8.4
- 特点：
  - 高效（省 gas）
  - 可携带参数
  - 可在合约外部定义
- 用法：
  ```solidity
  error TransferNotOwner(); // 无参数
  error TransferNotOwner(address sender); // 带参数

  function transferOwner1(uint256 tokenId, address newOwner) public {
      if (_owners[tokenId] != msg.sender) {
          revert TransferNotOwner();
          // 或 revert TransferNotOwner(msg.sender);
      }
      _owners[tokenId] = newOwner;
  }
  ```

#### Require
- 特点：
  - 常用于条件检查
  - gas 消耗随错误信息长度增加
- 用法：
  ```solidity
  function transferOwner2(uint256 tokenId, address newOwner) public {
      require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
      _owners[tokenId] = newOwner;
  }
  ```

#### Assert
- 特点：
  - 主要用于内部错误检查和不变量检查
  - 不提供错误信息
- 用法：
  ```solidity
  function transferOwner3(uint256 tokenId, address newOwner) public {
      assert(_owners[tokenId] == msg.sender);
      _owners[tokenId] = newOwner;
  }
  ```

#### Gas 消耗比较
基于 Solidity 0.8.17 版本：
1. `error` 方法：24457 gas（带参数：24660 gas）
2. `require` 方法：24755 gas
3. `assert` 方法：24473 gas

#### 思考与解答

1. 为什么 `error` 是最新引入的异常处理机制？它解决了什么问题？
   - 解答：`error` 解决了之前异常处理机制的几个问题：
     - Gas 效率：相比 `require`，`error` 消耗更少的 gas，特别是在错误信息较长时。
     - 参数传递：允许传递参数，提供更详细的错误信息。
     - 可读性：可以在合约外定义，使代码结构更清晰。
     - 标准化：便于创建特定于应用的错误类型。

2. 在什么情况下应该使用 `assert` 而不是 `require` 或 `error`？
   - 解答：`assert` 主要用于以下情况：
     - 检查内部错误，即那些在正常情况下绝不应该发生的错误。
     - 验证不变量，即在合约的整个生命周期中应该始终为真的条件。
     - 用于测试和调试过程中捕获意外情况。
   使用 `assert` 表明开发者认为这种情况永远不应该发生，如果发生，就表明合约中存在严重的逻辑错误。

3. 考虑到 gas 消耗，如何在实际开发中选择使用 `error`、`require` 或 `assert`？
   - 解答：
     - 对于需要向用户提供详细错误信息的情况，优先使用 `error`，因为它既省 gas 又能提供充分信息。
     - 对于简单的条件检查，特别是在旧版本的 Solidity 中，可以使用 `require`。
     - 对于内部一致性检查和不变量验证，使用 `assert`。
     - 在新项目中，尽可能使用 `error` 替代 `require`，以优化 gas 使用。



### 2024.10.08

學習內容: 

- [solidity-102 第十六课  函数重载](https://www.wtf.academy/docs/solidity-102/Overloading/)
- [solidity-102 第十七课  库](https://www.wtf.academy/docs/solidity-102/Library/)

笔记


#### 函数重载

Solidity 允许函数重载，即同名但参数不同的函数可以共存。重载函数在编译后会有不同的函数选择器。

##### 示例
```solidity
function saySomething() public pure returns(string memory){
    return("Nothing");
}

function saySomething(string memory something) public pure returns(string memory){
    return(something);
}
```

##### 实参匹配
调用重载函数时，编译器会尝试匹配参数类型。如果多个函数匹配，会报错。

```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```

调用 `f(50)` 会报错，因为 50 既可以是 uint8 也可以是 uint256。

#### 库合约

库合约是特殊的合约，用于提高代码复用性和减少 gas 消耗。它们与普通合约的主要区别：
1. 不能存在状态变量
2. 不能继承或被继承
3. 不能接收以太币
4. 不可被销毁

##### Strings 库合约示例
```solidity
library Strings {
    function toString(uint256 value) public pure returns (string memory) {
        // 实现细节...
    }

    function toHexString(uint256 value) public pure returns (string memory) {
        // 实现细节...
    }
}
```

##### 使用库合约的方法
1. 使用 `using for` 指令：
   ```solidity
   using Strings for uint256;
   function getString1(uint256 _number) public pure returns(string memory){
       return _number.toHexString();
   }
   ```

2. 直接通过库合约名调用：
   ```solidity
   function getString2(uint256 _number) public pure returns(string memory){
       return Strings.toHexString(_number);
   }
   ```

#### 思考与解答

1. 函数重载的优势和潜在风险是什么？
   - 优势：
     - 提高代码可读性，允许使用相同的函数名处理不同类型的输入。
     - 增加代码的灵活性，可以为不同情况提供专门的实现。
   - 潜在风险：
     - 可能导致函数调用的歧义，特别是在参数类型相近时。
     - 增加代码复杂性，可能使调试变得困难。

2. 为什么库合约不能有状态变量？这种限制带来了什么好处？
   - 解答：库合约不能有状态变量是为了保持其无状态性和可重用性。这种限制带来的好处包括：
     - 降低 gas 消耗，因为不需要存储状态。
     - 提高代码的可移植性和复用性，因为库函数不依赖于特定的状态。
     - 简化了库的使用和维护，因为不需要考虑状态管理的问题。

3. 在实际开发中，如何选择使用普通函数、重载函数或库函数？
   - 解答：选择取决于具体需求：
     - 普通函数：用于一般的功能实现，适合大多数情况。
     - 重载函数：当需要处理不同类型的输入，但逻辑相似时使用。
     - 库函数：对于常用的、通用的功能，特别是那些不需要访问合约状态的功能，使用库函数可以提高代码复用性和 gas 效率。


### 2024.10.09

學習內容: 

- [solidity-102 第十八课  Import](https://www.wtf.academy/docs/solidity-102/Import/)
- [solidity-102 第十九课  接收ETH receive和fallback](https://www.wtf.academy/docs/solidity-102/Fallback/)

笔记


#### Import

##### 导入方法
1. 通过源文件相对位置导入
   ```solidity
   import './Yeye.sol';
   ```

2. 通过源文件网址导入
   ```solidity
   import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
   ```

3. 通过 npm 目录导入
   ```solidity
   import '@openzeppelin/contracts/access/Ownable.sol';
   ```

4. 导入特定的全局符号
   ```solidity
   import {Yeye} from './Yeye.sol';
   ```

##### 注意事项
- import 语句应放在版本声明之后，其他代码之前。

#### Receive 和 Fallback 函数

##### Receive 函数
- 用于接收 ETH
- 声明方式：`receive() external payable { ... }`
- 不能有参数和返回值
- 每个合约最多有一个 receive 函数

##### Fallback 函数
- 在调用不存在的函数时触发
- 也可用于接收 ETH
- 声明方式：`fallback() external payable { ... }`
- 可以没有 payable 修饰符

##### 触发规则
```
接收ETH
   |
msg.data是空？
 /        \
是         否
 |          |
receive()存在？ fallback()
 /       \
是        否
 |         |
receive()  fallback()
```

#### 思考与解答

1. Import 的不同方式有什么优缺点？
   - 解答：
     - 相对路径导入：简单直接，但可能导致路径问题。
     - 网址导入：方便引用公共库，但依赖网络连接。
     - npm 导入：适合使用包管理，但需要设置项目环境。
     - 特定符号导入：可以减少命名冲突，但可能降低代码可读性。

2. 为什么 receive 函数不能有参数和返回值？
   - 解答：receive 函数设计用于简单接收 ETH。无参数和返回值可以：
     - 简化函数调用过程
     - 减少 gas 消耗
     - 避免与其他函数签名冲突
     - 确保兼容性，因为发送 ETH 的交易可能没有额外数据

3. 在什么情况下应该使用 fallback 而不是 receive？
   - 解答：应在以下情况使用 fallback：
     - 需要处理带有数据的 ETH 转账
     - 实现代理合约功能
     - 需要在调用不存在的函数时执行特定逻辑
     - 不想区分纯 ETH 转账和带数据的调用时



### 2024.10.10

學習內容: 

- [solidity-102 第二十课  发送ETH](https://www.wtf.academy/docs/solidity-102/SendETH/)
- [solidity-102 第二十一课  调用其他合约](https://www.wtf.academy/docs/solidity-102/CallContract/)

笔记


#### 发送ETH

Solidity 提供三种方法发送 ETH：`transfer()`、`send()` 和 `call()`。

##### transfer()
- 用法：`接收方地址.transfer(发送ETH数额)`
- gas 限制：2300
- 失败时自动 revert

```solidity
function transferETH(address payable _to, uint256 amount) external payable {
    _to.transfer(amount);
}
```

##### send()
- 用法：`接收方地址.send(发送ETH数额)`
- gas 限制：2300
- 返回 bool 值表示成功或失败

```solidity
function sendETH(address payable _to, uint256 amount) external payable {
    bool success = _to.send(amount);
    if(!success){
        revert SendFailed();
    }
}
```

##### call()
- 用法：`接收方地址.call{value: 发送ETH数额}("")`
- 无 gas 限制
- 返回 (bool, bytes)

```solidity
function callETH(address payable _to, uint256 amount) external payable {
    (bool success,) = _to.call{value: amount}("");
    if(!success){
        revert CallFailed();
    }
}
```

#### 调用其他合约

##### 方法1：传入合约地址
```solidity
function callSetX(address _Address, uint256 x) external {
    OtherContract(_Address).setX(x);
}
```

##### 方法2：传入合约变量
```solidity
function callGetX(OtherContract _Address) external view returns(uint x) {
    x = _Address.getX();
}
```

##### 方法3：创建合约变量
```solidity
function callGetX2(address _Address) external view returns(uint x) {
    OtherContract oc = OtherContract(_Address);
    x = oc.getX();
}
```

##### 方法4：调用合约并发送ETH
```solidity
function setXTransferETH(address otherContract, uint256 x) payable external {
    OtherContract(otherContract).setX{value: msg.value}(x);
}
```

#### 思考与解答

1. 为什么 `call()` 被推荐用于发送 ETH？
   - 解答：
     - 灵活性：`call()` 没有 gas 限制，可以执行更复杂的逻辑。
     - 安全性：返回值可以让我们处理失败情况，避免静默失败。
     - 兼容性：适用于不同版本的 Solidity。
     - 可扩展性：可以调用任意函数，不仅限于发送 ETH。

2. 在调用其他合约时，传入合约地址和传入合约变量有什么区别？
   - 解答：
     - 传入合约地址更灵活，可以在运行时决定调用哪个合约。
     - 传入合约变量在编译时提供类型检查，可以增加代码的安全性。
     - 传入合约变量可以提高代码可读性，明确表示期望的合约类型。
     - 底层实现上，两者都是传递地址，但合约变量提供了额外的类型信息。

3. 在实际开发中，如何选择合适的跨合约调用方式？
   - 解答：选择取决于具体需求：
     - 如果需要高度灵活性，使用传入地址的方法。
     - 如果强调类型安全和代码可读性，使用合约变量。
     - 如果需要频繁调用同一合约，可以创建合约变量以提高效率。
     - 如果需要同时转账和调用函数，使用 `call()` 方法。



### 2024.10.11

- [solidity-102 第二十二课  Call](https://www.wtf.academy/docs/solidity-102/Call/)
- [solidity-102 第二十三课  Delegatecall](https://www.wtf.academy/docs/solidity-102/Delegatecall/)

笔记


#### Call

`call` 是 `address` 类型的低级成员函数，用于与其他合约交互。

##### 特点：
- 返回值为 `(bool, bytes memory)`，分别表示调用是否成功和目标函数的返回值。
- 推荐用于发送 ETH 和触发 `fallback` 或 `receive` 函数。
- 不推荐用于调用其他合约的常规函数。

##### 使用语法：
```solidity
目标合约地址.call{value: 发送数额, gas: gas数额}(abi.encodeWithSignature("函数签名", 参数1, 参数2, ...));
```

##### 示例：
```solidity
function callSetX(address payable _addr, uint256 x) public payable {
    (bool success, bytes memory data) = _addr.call{value: msg.value}(
        abi.encodeWithSignature("setX(uint256)", x)
    );
    emit Response(success, data);
}
```

#### Delegatecall

`delegatecall` 是一种特殊的函数调用，它在调用者的上下文中执行目标合约的代码。

##### 特点：
- 执行目标合约的代码，但在调用合约的上下文中。
- 状态变更影响调用合约，而不是目标合约。
- `msg.sender` 保持为原始调用者。

##### 使用语法：
```solidity
目标合约地址.delegatecall(abi.encodeWithSignature("函数签名", 参数1, 参数2, ...));
```

##### 示例：
```solidity
function delegatecallSetVars(address _addr, uint _num) external payable {
    (bool success, bytes memory data) = _addr.delegatecall(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );
}
```

#### 思考与解答

1. `call` 和 `delegatecall` 的主要区别是什么？
   - 解答：
     - `call` 在目标合约的上下文中执行，而 `delegatecall` 在调用合约的上下文中执行。
     - `call` 改变目标合约的状态，`delegatecall` 改变调用合约的状态。
     - `call` 中 `msg.sender` 是调用合约地址，`delegatecall` 中保持为原始调用者地址。
     - `call` 可以发送 ETH，而 `delegatecall` 不能。

2. 为什么 `delegatecall` 在使用时需要特别小心？
   - 解答：
     - 存储布局必须匹配：调用合约和目标合约的状态变量结构必须相同，否则可能导致意外的状态更改。
     - 安全风险：如果目标合约不安全或被恶意修改，可能导致调用合约的状态被破坏。
     - 升级风险：在代理模式中使用时，新版本合约必须保持与旧版本兼容的存储布局。

3. 在实际开发中，`call` 和 `delegatecall` 的主要应用场景是什么？
   - 解答：
     - `call` 主要用于：
       1. 发送 ETH 到其他合约。
       2. 调用未知合约或无 ABI 的合约函数。
       3. 处理低级别的交互，如触发 fallback 函数。
     - `delegatecall` 主要用于：
       1. 实现代理合约模式，支持合约逻辑的可升级性。
       2. 实现库合约，允许代码重用而不复制代码。
       3. 在 DApp 中实现模块化和可扩展的智能合约系统（如 EIP-2535 Diamonds）。

### 2024.10.12 

- [solidity-102 第二十四课  在合约中创建新合约](https://www.wtf.academy/docs/solidity-102/Create/)
- [solidity-102 第二十五课  CREATE2](https://www.wtf.academy/docs/solidity-102/Create2/)

笔记

#### CREATE方法

-  用途：在合约中创建新的合约
- 语法：`Contract x = new Contract{value: _value}(params)`
- 地址计算：新地址 = hash(创建者地址, nonce)
- 特点：地址不可预测，因为nonce会随时间变化

#### CREATE2方法

- 目的：让合约地址独立于未来事件，可以预先计算
- 语法：`Contract x = new Contract{salt: _salt, value: _value}(params)`
- 地址计算：新地址 = hash("0xFF", 创建者地址, salt, initcode)
- 组成部分：
  - 0xFF：常数，避免与CREATE冲突
  - 创建者地址：调用CREATE2的当前合约地址
  - salt：创建者指定的bytes32类型值
  - initcode：新合约的初始字节码



#### 极简Uniswap实现

- Pair合约：管理币对地址
- PairFactory合约：创建新币对，管理币对地址
- CREATE2在PairFactory中的应用：
  - 使用token地址计算salt
  - 使用CREATE2部署Pair合约
  - 初始化Pair合约并更新地址映射



#### 思考与解答

为什么Uniswap不在constructor中更新token0和token1地址？

- 解答：因为Uniswap使用CREATE2创建合约，这样可以实现地址预测。如果在constructor中更新，就无法预先知道确切的合约字节码，从而影响地址预测的准确性。


CREATE2的优势是什么？

- 解答：可以预先计算合约地址，无论未来区块链上发生什么
- 使得合约部署更加灵活和可控
- 在某些场景下，可以优化gas使用（如Uniswap V2中减少了跨合约调用）


CREATE2的实际应用场景：

- 交易所为新用户预留钱包合约地址
- 在Uniswap V2中，用于创建交易对，实现确定性的pair地址计算


在使用CREATE2时，如何处理构造函数带参数的情况？

- 解答：需要将参数和initcode一起打包进行哈希计算
- 示例：`keccak256(abi.encodePacked(type(Pair).creationCode, abi.encode(address(this))))`



### 2024.10.14

- [solidity-102 第二十六课  删除合约](https://www.wtf.academy/docs/solidity-102/DeleteContract/)
- [solidity-102 第二十七课  ABI编码解码](https://www.wtf.academy/docs/solidity-102/ABIEncode/)
- [solidity-102 第二十八课  Hash](https://www.wtf.academy/docs/solidity-102/Hash/)

笔记


#### 删除合约

##### selfdestruct 的演变
1. 最初命名为 `suicide`，后改为 `selfdestruct`。
2. 在 v0.8.18 版本中被标记为"不再建议使用"。
3. 以太坊坎昆（Cancun）升级后，功能发生重大变化（EIP-6780）。

##### 坎昆升级后的 selfdestruct
1. 已部署的合约无法被 `selfdestruct` 删除。
2. 只有在同一笔交易中创建并 `selfdestruct` 的合约才能被删除。
3. 主要功能变为转移合约中的 ETH 到指定地址。

##### 使用方法
```solidity
selfdestruct(_addr);
```
`_addr` 是接收合约剩余 ETH 的地址。

##### 示例代码

1. 转移 ETH 功能（坎昆升级后）:
```solidity
contract DeleteContract {
    uint public value = 10;
    constructor() payable {}
    receive() external payable {}
    function deleteContract() external {
        selfdestruct(payable(msg.sender));
    }
    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}
```

2. 同笔交易内实现合约创建-自毁:
```solidity
contract DeployContract {
    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }
    constructor() payable {}
    function demo() public payable returns (DemoResult memory){
        DeleteContract del = new DeleteContract{value:msg.value}();
        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });
        del.deleteContract();
        return res;
    }
}
```

##### 思考与解答

1. 为什么以太坊要改变 `selfdestruct` 的功能？
   - 解答：
     - 提高网络安全性：防止合约被意外或恶意删除。
     - 简化状态管理：有助于实现 Verkle Tree 等优化。
     - 减少潜在的漏洞：`selfdestruct` 曾被用于一些攻击向量。

2. `selfdestruct` 的变化对已有的 DApp 有何影响？
   - 解答：
     - 依赖 `selfdestruct` 删除功能的合约可能需要重新设计。
     - 某些升级或应急机制可能需要重新考虑。
     - 合约审计和安全评估标准可能需要更新。

3. 在不能删除合约的情况下，如何实现类似的紧急停止功能？
   - 解答：
     - 实现暂停机制：使用 `pause()` 函数来停止关键功能。
     - 使用代理模式：允许将逻辑合约升级到新版本。
     - 实现权限控制：只允许特定角色执行敏感操作。


##### 注意事项
1. 限制 `selfdestruct` 的调用权限，通常只允许合约所有者调用。
2. 谨慎使用 `selfdestruct`，它可能引起安全问题和用户信任问题。
3. 考虑使用替代方案，如暂停功能或可升级合约模式。


#### ABI编码解码

##### ABI 编码方法

1. **abi.encode**
   - 功能：将给定参数按 ABI 规则编码，每个参数填充为 32 字节。
   - 用途：主要用于与智能合约交互。
   ```solidity
   function encode() public view returns(bytes memory result) {
       result = abi.encode(x, addr, name, array);
   }
   ```

2. **abi.encodePacked**
   - 功能：将参数按最小所需空间编码，省略填充的零。
   - 用途：用于节省空间，如计算数据哈希。
   ```solidity
   function encodePacked() public view returns(bytes memory result) {
       result = abi.encodePacked(x, addr, name, array);
   }
   ```

3. **abi.encodeWithSignature**
   - 功能：类似 abi.encode，但第一个参数为函数签名。
   - 用途：调用其他合约时使用。
   ```solidity
   function encodeWithSignature() public view returns(bytes memory result) {
       result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
   }
   ```

4. **abi.encodeWithSelector**
   - 功能：类似 abi.encodeWithSignature，但使用函数选择器。
   - 用途：更底层的合约调用。
   ```solidity
   function encodeWithSelector() public view returns(bytes memory result) {
       result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
   }
   ```

##### ABI 解码方法

**abi.decode**
- 功能：解码 abi.encode 生成的二进制编码。
- 用途：将编码数据还原为原始参数。
```solidity
function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
    (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
}
```

##### 思考与解答

1. 为什么需要不同的 ABI 编码方法？
   - 解答：
     - abi.encode：标准方法，用于合约间完整数据交互。
     - abi.encodePacked：节省空间，适用于不需要完整 ABI 的场景，如计算哈希。
     - abi.encodeWithSignature 和 abi.encodeWithSelector：用于更灵活的跨合约调用。

2. abi.encodePacked 和 abi.encode 的主要区别是什么？
   - 解答：
     - abi.encode 对每个参数填充到 32 字节，保证了数据的完整性和一致性。
     - abi.encodePacked 压缩编码，省略了填充，节省空间但可能导致歧义。
     - abi.encode 更安全，特别是处理动态类型时；abi.encodePacked 更节省 gas。

3. 在实际开发中，如何选择合适的编码方法？
   - 解答：
     - 与合约交互：使用 abi.encode 或 abi.encodeWithSignature。
     - 计算哈希：使用 abi.encodePacked 以节省 gas。
     - 底层调用：根据需要选择 abi.encodeWithSignature 或 abi.encodeWithSelector。
     - 处理动态类型：优先使用 abi.encode 以避免潜在的哈希冲突。


##### ABI 的使用场景
1. 合约间的底层调用：
   ```solidity
   bytes4 selector = contract.getValue.selector;
   bytes memory data = abi.encodeWithSelector(selector, _x);
   (bool success, bytes memory returnedData) = address(contract).staticcall(data);
   require(success);
   return abi.decode(returnedData, (uint256));
   ```

2. 在 ethers.js 中导入和调用合约：
   ```javascript
   const wavePortalContract = new ethers.Contract(contractAddress, contractABI, signer);
   const waves = await wavePortalContract.getAllWaves();
   ```

3. 调用未开源或反编译后的合约函数：
   ```solidity
   bytes memory data = abi.encodeWithSelector(bytes4(0x533ba33a));
   (bool success, bytes memory returnedData) = address(contract).staticcall(data);
   require(success);
   return abi.decode(returnedData, (uint256));
   ```


#### Hash

##### 哈希函数的性质
1. 单向性：正向计算简单，反向计算困难
2. 灵敏性：输入微小变化导致输出大幅变化
3. 高效性：计算速度快
4. 均一性：哈希值分布均匀
5. 抗碰撞性：
   - 弱抗碰撞性：难以找到具有相同哈希值的不同输入
   - 强抗碰撞性：难以找到任意两个具有相同哈希值的不同输入

##### Solidity 中的 Keccak256
Keccak256 是 Solidity 中最常用的哈希函数。用法：
```solidity
bytes32 hash = keccak256(abi.encodePacked(data));
```

注意：Ethereum 和 Solidity 中的 SHA3 实际上指的是 Keccak256，而非标准的 NIST-SHA3。

##### 应用示例

1. 生成数据唯一标识：
```solidity
function hash(uint _num, string memory _string, address _addr) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_num, _string, _addr));
}
```

2. 演示弱抗碰撞性：
```solidity
function weak(string memory string1) public view returns (bool) {
    return keccak256(abi.encodePacked(string1)) == _msg;
}
```

3. 演示强抗碰撞性：
```solidity
function strong(string memory string1, string memory string2) public pure returns (bool) {
    return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
}
```

##### 思考与解答

1. 为什么 Keccak256 在 Solidity 中如此重要？
   - 解答：
     - 安全性：Keccak256 提供了高度的安全性和抗碰撞能力。
     - 确定性：相同输入总是产生相同的输出，这对智能合约的可预测性很重要。
     - 广泛应用：用于生成唯一标识符、数据完整性验证、签名验证等。
     - 以太坊特性：是以太坊生态系统的标准哈希函数，用于地址生成、交易签名等。

2. abi.encodePacked 和 keccak256 的组合使用有什么优势？
   - 解答：
     - 灵活性：abi.encodePacked 允许组合不同类型的数据。
     - 效率：相比单独使用 keccak256，这种组合可以更有效地处理复杂数据结构。
     - 唯一性：能够为复杂的数据结构生成唯一的哈希值。
     - Gas 优化：在某些情况下可以节省 gas，因为 encodePacked 压缩了数据。

3. 在智能合约中，哈希函数的抗碰撞性有何实际意义？
   - 解答：
     - 安全性：防止攻击者通过构造特定输入来伪造数据或签名。
     - 唯一性保证：确保合约中的唯一标识符（如 tokenId）的真实唯一性。
     - 数据完整性：确保存储或传输的数据未被篡改。
     - 隐私保护：可以存储数据的哈希值而非原始数据，增加隐私保护。


### 2024.10.15

- [solidity-102 第二十九课 函数选择器Selector](https://www.wtf.academy/docs/solidity-102/Selector/)
- [solidity-102 第三十课 Try Catch](https://www.wtf.academy/docs/solidity-102/TryCatch/)

笔记

#### 函数选择器Selector

##### msg.data 和函数选择器
- `msg.data` 是完整的 calldata，包含函数选择器和参数。
- 函数选择器是 `msg.data` 的前 4 个字节。

示例代码：
```solidity
event Log(bytes data);

function mint(address to) external {
    emit Log(msg.data);
}
```

##### 函数签名和 Method ID
- 函数签名：`"函数名(参数类型1,参数类型2,...)"`
- Method ID：函数签名的 Keccak 哈希的前 4 个字节
- Selector 与 Method ID 相匹配时，表示调用该函数

计算 Method ID 示例：
```solidity
function mintSelector() external pure returns(bytes4 mSelector) {
    return bytes4(keccak256("mint(address)"));
}
```

##### 不同参数类型的 Selector 计算

1. 基础类型参数
   ```solidity
   function elementaryParamSelector(uint256 param1, bool param2) external returns(bytes4) {
       return bytes4(keccak256("elementaryParamSelector(uint256,bool)"));
   }
   ```

2. 固定长度类型参数
   ```solidity
   function fixedSizeParamSelector(uint256[3] memory param1) external returns(bytes4) {
       return bytes4(keccak256("fixedSizeParamSelector(uint256[3])"));
   }
   ```

3. 可变长度类型参数
   ```solidity
   function nonFixedSizeParamSelector(uint256[] memory param1, string memory param2) external returns(bytes4) {
       return bytes4(keccak256("nonFixedSizeParamSelector(uint256[],string)"));
   }
   ```

4. 映射类型参数
   ```solidity
   function mappingParamSelector(DemoContract demo, User memory user, uint256[] memory count, School mySchool) external returns(bytes4) {
       return bytes4(keccak256("mappingParamSelector(address,(uint256,bytes),uint256[],uint8)"));
   }
   ```

##### 使用 Selector 调用函数
```solidity
function callWithSignature() external {
    (bool success1, bytes memory data1) = address(this).call(abi.encodeWithSelector(0x3ec37834, 1, 0));
}
```

##### 思考与解答

1. 为什么需要函数选择器？
   - 解答：
     - 效率：快速识别要调用的函数，无需解析整个调用数据。
     - 节省存储：只需存储 4 字节，而不是完整函数签名。
     - 标准化：提供了一种统一的函数识别方法。

2. 函数选择器与 ABI 的关系是什么？
   - 解答：
     - 函数选择器是 ABI（Application Binary Interface）的一部分。
     - ABI 定义了如何编码函数调用和数据结构。
     - 选择器使得 ABI 能够高效地路由函数调用。

3. 如何处理函数选择器冲突？
   - 解答：
     - 冲突概率低：4 字节提供了 2^32 种可能，冲突较罕见。
     - 重命名函数：如果发生冲突，可以通过修改函数名来解决。
     - 使用接口：通过接口来区分同名但不同合约的函数。


#### Try Catch

##### try-catch 基本语法

```solidity
try externalContract.f() {
    // 调用成功时执行的代码
} catch {
    // 调用失败时执行的代码
}
```

注意事项：
- 只能用于 external 函数调用或合约创建。
- 可以使用 `this.f()` 替代 `externalContract.f()`。
- 如果函数有返回值，需要在 try 后声明 `returns(returnType val)`。

##### 捕获特定异常

```solidity
try externalContract.f() returns(returnType) {
    // 调用成功的代码
} catch Error(string memory reason) {
    // 捕获 revert 和 require 抛出的异常
} catch Panic(uint errorCode) {
    // 捕获 Panic 类型的错误（如 assert 失败、溢出等）
} catch (bytes memory lowLevelData) {
    // 捕获其他类型的 revert
}
```

##### 实战示例

1. 外部合约 OnlyEven：

```solidity
contract OnlyEven {
    constructor(uint a) {
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function onlyEven(uint256 b) external pure returns(bool success) {
        require(b % 2 == 0, "Ups! Reverting");
        success = true;
    }
}
```

2. 处理外部函数调用异常：

```solidity
contract TryCatch {
    event SuccessEvent();
    event CatchEvent(string message);
    event CatchByte(bytes data);

    OnlyEven even;

    constructor() {
        even = new OnlyEven(2);
    }

    function execute(uint amount) external returns (bool success) {
        try even.onlyEven(amount) returns(bool _success) {
            emit SuccessEvent();
            return _success;
        } catch Error(string memory reason) {
            emit CatchEvent(reason);
        }
    }
}
```

3. 处理合约创建异常：

```solidity
function executeNew(uint a) external returns (bool success) {
    try new OnlyEven(a) returns(OnlyEven _even) {
        emit SuccessEvent();
        success = _even.onlyEven(a);
    } catch Error(string memory reason) {
        emit CatchEvent(reason);
    } catch (bytes memory reason) {
        emit CatchByte(reason);
    }
}
```

##### 思考与解答

1. 为什么 try-catch 只能用于外部函数调用或合约创建？
   - 解答：
     - 内部一致性：保证合约内部逻辑的一致性和可预测性。
     - 性能考虑：内部调用的异常处理可能导致额外的gas消耗。
     - 外部交互风险：外部调用更容易失败，需要更robust的错误处理。

2. try-catch 与传统的 require 和 assert 有什么区别？
   - 解答：
     - 粒度：try-catch 提供更细粒度的错误处理。
     - 灵活性：允许在捕获异常后继续执行，而不是直接回滚。
     - 用途：try-catch 主要用于处理外部调用，require 和 assert 用于内部状态检查。

3. 在实际开发中，如何选择使用 try-catch 还是 require/assert？
   - 解答：
     - 外部调用：优先使用 try-catch 处理可能的失败情况。
     - 内部状态验证：使用 require 进行常规检查，assert 用于不应发生的情况。
     - 代码可读性：根据具体情况选择更清晰、易维护的方式。



<!-- Content_END -->
