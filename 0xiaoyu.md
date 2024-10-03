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


<!-- Content_END -->
