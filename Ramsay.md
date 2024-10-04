---
timezone: America/Los_Angeles
---


# YourName

1. 自我介绍:
   Hi, 我是Ramsay, 对新事物比较感兴趣，自认为是个喜欢学习的人，所以就来参加 Solidity 的学习.

2. 你认为你会完成本次残酷学习吗？
  尽力而为，不中途放弃.
   
## Notes

<!-- Content_START -->

### 2024.09.23

#### 01 Helloworld

##### License header
课程提到的未添加 License 会导致出现编译 warning, 这个是我第一个接触会因为没有注明 License 而告警的编程语言，可能是因为区块链的透明性，所以天然就拥抱开源。

搜索了一下，发现并非 Solidity 并非一开始就有这个特性，而是在 [0.6.8](https://forum.openzeppelin.com/t/solidity-0-6-8-introduces-spdx-license-identifiers/2859) 引入的，只是 Release Note 里面没有注明动机

##### Version mechanism

> 这行代码表示源文件将不允许小于 0.8.21 版本或大于等于 0.9.0 的编译器编译（第二个条件由 ^ 提供）

```solidity
pragma solidity ^0.8.21;
```

课程未说明的是，`^` 机制是如何运作。在版本管理里面，以 `0.8.21` 为例：

- 0: major version
- 8: minor version
- 21: patch version

major version 大于0就意味着发布了稳定版本，稳定版本的意思就是起码 1.0 之后，不升级 major version 不会出现 breaking change, 算是一个 commitment, 而未发布稳定版本就意味着，当下我们还在开发，接口什么的可能会变。

而 `^version`: 代表 *Compatible with version*, 它有两个含义。

如果发布了稳定版本，那么就意味着会自动帮你升级 minor version 和 patch version, major version 不动. 如 `^1.2.3` 就意味着大于 1.2.3 小于 2.0.0 

如果未发布稳定版本，例如 ^0.8.21, 他的意思就是, 可以升级，但是不要变动到版本号中最左边的非零数字, 即 ^0.8.21 is 大于等于 0.8.21, 但小于0.9,  因为升级到0.9 就意味着最左边的非零数字(left-most non-zero)变了.

类似含义的还有 `~version`: 意味着 *Approximately equivalent to version*, 就是只升级 patch version, 不会变动 major version 和 minor version.

上面提到的其实是Javascript NPM 的规则，Solidity 直接站在 [npm](https://docs.soliditylang.org/en/v0.8.27/layout-of-source-files.html#pragmas) 的肩膀上了, 官网文档:

> It is possible to specify more complex rules for the compiler version, these follow the same syntax used by npm.

##### Nitpick

(属于吹毛求疵类型，如果能改掉就更好了)

示例中的变量不要使用 `_string` 这样没有含义的命名

#### 02 Type

value type, reference type, enum, array, vector 这些概念在其他语言中都大同小异，比如Java 中, primitive type 就是 value type, 默认是传值, class 就是 reference type, 默认是传引用，而 C++ 是都可以有，可以自行设计。

> enum 是一个比较冷门的变量，几乎没什么人用。

其实 enum 在定义有限个常量时，是非常有用，类如星期，月份等.

##### Address Type

Address type 是 Solidity 特有的类型，我接触的编程语言都没有这个概念，所以我研读了一下官方文档。

> address: Holds a 20 byte value (size of an Ethereum address).

> address payable: Same as address, but with the additional members transfer and send.

> The idea behind this distinction is that address payable is an address you can send Ether to, while you are not supposed to send Ether to a plain address, for example because it might be a smart contract that was not built to accept Ether.

因为 Solidity 是构建在 EVM 之上的，EVM可以说是 smart contract 的基石，而地址就是EVM这基石的每个砖块的唯一标识符，可以类比成运行在计算机的程序，每个变量都会有自己唯一的内存地址。

而 `address payable` 就是一串可以接收 Ethereum 的地址（我可以理解成是合法的 Ethereum 地址）, address 就是一串 20byte 的字符串（或许是合法的地址）

address 只能通过 `payable(<address>)` 转换成 `address payable`, 我估计这个函数的内部会校验 address 地址的合法性.

address type 还内置了一系列的[函数](https://docs.soliditylang.org/en/v0.8.27/units-and-global-variables.html#address-related)

By the way, Solidity 也是我接触的，第一门类型有两个以上关键词的语言，想必这样会增加编译器的解析成语法树的成本，另外可读性也不是很好:

```
address payable x = payable(0x123);
address myAddress = address(this);
```

我很容易把 `payable` 当作是变量名, 把 `address payable` 合并成 `adrpay` 可能更符合我的品味，并且易于编译器处理.

##### Contract Type

Contract 目前在我的理解里就是类比Java 中的Class, 就是用户定义的，包含数据与函数的，运行在虚拟机(JVM/EVM)上的最小代码单元. contract 与 address 之间可以通过 `address(x)` 函数进行显式转换.

如果想要把 contract 转换成 address payable, 要么 contract 定义了 `receive` 或 `payable` 回调函数，要么使用 `payable(address(x))` 来作转换

##### User-defined Value type 

> A user-defined value type allows creating a zero cost abstraction over an elementary value type.

zero cost abstraction 这个是我在C++和Rust 之外, 第一次听到有语言标榜 zero cost abstraction ，只是看下来，这个 User-defined value type 就是一个 alias, 其实就是 C++ 的 [`typedef` 或者 `using`](https://stackoverflow.com/questions/10747810/what-is-the-difference-between-typedef-and-using) 

和 zero cost abstraction 并没有什么关系.

#### 03 Function

Solidity 这个函数签名方式着实是有点不习惯，可见性修饰符放在参数括号之后。

`pure` 和 `view` 是其他语言所没有的关键的，严格来说是 `pure` 没有, `view` 类似 C++ 的 `const` 关键字，是只读的意思。

虽然作者在教程解释得很有趣，但是 [`pure function`](https://en.wikipedia.org/wiki/Pure_function) 其实是来自函数式编程中的概念，有两个含义：
1. 给定相同的输入，就一定会返回相同的输出，和数学中的函数一样
2. 没有副作用 (side effect), 类如文件读写，或者修改变量的操作.

根据官方文档，另外一个函数有趣的点在于，两个函数类型是可以隐式转换的，只要他们的函数签名，返回类型，可见性，以及状态可变性之间存在包含关系：

> A function type A is implicitly convertible to a function type B if and only if their parameter types are identical, their return types are identical, their internal/external property is identical and the state mutability of A is more restrictive than the state mutability of B. In particular:
> - pure functions can be converted to view and non-payable functions
> - view functions can be converted to non-payable functions
> - payable functions can be converted to non-payable functions

`payable` 函数可以转换为 `non-payable` 函数，因为官方的说法是， `payable` 可以收，也可以不收（只收0个ETH），那么也可以看成 `non-payable`. 但是 `non-payble` 不能收就是不能收，没法转成 `payable`, 所以只能单向转换.

#### 04 Return

Solidity的函数声明实在是太多关键字，这次我第一个见过需要使用 `returns` 来标识函数返回值的语言。

既有 C++/Java 这样把函数返回值声明在参数前的，也有 Rust/Golang这样把函数返回值声明在参数之后的，Solidity 还需要个专门的关键字来声明返回值，可能是因为区块链的严谨性，需要显式声明一切。

命名式返回(named return values) 是 [Golang 上](https://go.dev/tour/basics/7)也有的特性，只是我更习惯直接使用 return value 进行返回，既可以实现 early return, 也不用担心重构变量名之后，需要同步修改返回值中的变量名。

解构式赋值(Destructuring assignment), 一个很有用的特性，特别是一个函数会返回多个值的时候，可以直接对多个变量赋值。

#### 05 Data Storage

这个是 Solidity 特有的特性，需要指定数据存储的位置。因为 Solidity 运行在EVM上，存储上链的数据 `storage` 需要比较多的 gas, 而存储在内存上 `memory/calldata` 则相对便宜，那么 Solidity 的开发人员是否和60-70年代的开发者一样，需要为节省存储空间而绞尽脑汁优化程序呢？

这肯定是个有趣的体验。

从Java的角度来理解， `storage` 类似存储在堆上(heap), `memory/calldata` 存储在栈上(stack), 所以类(合约)实例的成员变量存储在 heap 上，函数变量存储在栈上

赋值操作在C++和Rust有比较多的规则，因为他们都是给开发者足够的自由度来管理内存，决定是否 copy，或者是 move. Solidity的赋值也给我类似的感觉，因为 gas fee的原因，所以 Solidity的赋值操作要兼具性能和成本考量.

- memory 与 memory 之间的赋值是创建新的引用
- storage 与 local storage 之间的赋值也是创建引用
- 其他情况都是复制值

### 2024.09.24

#### 06 Array and Struct

对 Solidity 上的动态数组的概念有些疑惑，按照官方文档:

> Dynamically-sized arrays can only be resized in storage. In memory, such arrays can be of arbitrary size but the size cannot be changed once an array is allocated.

也就是只有存储在链上动态数组可以变更 size，在 memory 的数组的 size 在初始化后就无法变更，那么这是否还能叫动态数组呢？也就是意味着，对于 memory 类型的数组， `push` 函数无法使用。

而 `bytes` 和 `string` 都是特殊类型的数组，bytes 包含任意长度的字节数据，而 string 包含任意长度的UTF-8数据。除此之外，还 bytes1 和 bytes:
- bytes: 是动态数组，可以包含任意数量的字节
- bytes1: 是固定长度数组，只包含一个字节

不知道为什么要这么设计, 将 `bytes1` 从只包含一个字节的固定数组，设计成 `byte` 类型, 表示一个字节，不是更合理嘛, 还不需要这个奇怪的命名.

##### Dangling reference

Solidity 也可能会出现野指针的问题，Solidity 只允许对引用类型声明引用（指针），所以野指针也只会出现在嵌套的引用类型上，如下：

```solidity
contract C {
    uint[][] s;

    function f() public {
        // Stores a pointer to the last array element of s.
        uint[] storage ptr = s[s.length - 1];
        // Removes the last array element of s.
        s.pop();
        // Writes to the array element that is no longer within the array.
        ptr.push(0x42);
        // Adding a new element to ``s`` now will not add an empty array, but
        // will result in an array of length 1 with ``0x42`` as element.
        s.push();
        assert(s[s.length - 1][0] == 0x42);
    }
}
```

##### Array slice

Solidity 也支持数组切片的特性，如 `x[start:end]`, 不过目前只支持 calldata 类型的数组。 `start` 和 `end` 都不是必填的, start 默认是0，end默认是数组长度

##### Struct

Solidity 的 Struct 不是类似 C++/Java 的 struct, 作为数据与函数的集合，而更像是C中的struct，只作为数据的载体，不包含函数实现。

需要注意的是，Solitidy 的结构体成员不能包含结构体本身, 如:

```solidity
struct Campaign {
  uint fundingGoal;
  Campaign self; // 不支持这样的语法
}
```

因为Solidity 需要在编译期知道结构体的大小，如果包含自己，那么就会变成无限递归，编译器就无法推断出结构体的大小了, 进而分配内存

### 2024.09.25

#### 07 Mapping

`mapping(KeyType KeyName? => ValueType ValueName?)` 这个语法不知道是否是向 Ruby 借鉴的呢? `keyType` 可以是内置的值类型, `bytes`, `string`, 任意的合约或者是枚举类型. 其他用户自定义的类型或复杂类型, 如 `mapping`, `struct`, `array` 都无法作为 key，为什么呢?

我查了一下，原因可能是以下几个方面:
1. Hash function limitations: EVM 内置的hash 函数Keccak-256 对基础类型有优化, 处理复杂类型或者自定义类型效率就没有那么高
2. Storage layout: 基础类型因为简单，存储和计算 hash 值就简单高效，而复杂类型因为其内存布局比较复杂，所以效率没有那么高
3. Gas costs: 使用复杂类型作为Key很可能会增加 gas 费，所以直接禁用复杂类型有助于降低gas 费

`Mapping` 只可以当作是合约的状态变量，函数内的状态变量，不能用作函数参数或者返回值；对于包含 `Mapping` 的数组和结构体，也会有同样的限制.

Ethereum 基金会定义的用于发币的 `ERC20` 协议：
```solidity
totalSupply()
balanceOf(account)
transfer(to, amount)
allowance(owner, spender)
approve(spender, amount)
transferFrom(from, to, amount)
```

其中的 [`allowance`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol#L113) 函数操作的 [`_allowances`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol#L32) 就是一个 Mapping 

另外一个需要注意的点是，Solidity 默认是不支持遍历 mapping 的，但是有第三方实现了可遍历的 mapping: 
> You cannot iterate over mappings, i.e. you cannot enumerate their keys. It is possible, though, to implement a data structure on top of them and iterate over that.

猜测还是因为 gas 费的限制, 遍历一个包含很多数据的 mapping 时间复杂度是 O(N), 而 mapping lookup 是 O(1), 前者可能需要大量的 gas fee. 

#### 08 InitialValue

在Solidity中，声明但没赋值的变量都有它的初始值或默认值, 对于不同类型的变量，Solidity 会设置不同类型的默认值。

看到Solidity默认赋值的行为时，我难免会有疑问，为什么 Rust 和 C++ 不这么做呢？所以我问了下Claude:

> If it's beneficial, why doesn't Rust and C++ support default value for declared variable?

> Rust:

> - Zero-cost abstractions: Rust aims to provide high-level features without runtime cost. Automatic initialization would add overhead.
> - Explicit is better than implicit: Rust favors explicitness to avoid subtle bugs and make code behavior clear.
> - Safety through compile-time checks: Rust's borrow checker prevents use of uninitialized variables, catching potential errors at compile time rather than runtime.
> - Performance: Allowing uninitialized memory can be more efficient in some cases, especially for large data structures.
> - Use-case flexibility: Some algorithms benefit from working with uninitialized memory for performance reasons.

> C++:

> - Performance: C++ prioritizes performance, and automatic initialization could introduce unnecessary overhead.
> - Backwards compatibility: C++ has a long history and changing this behavior could break existing code.
> - Low-level control: C++ provides fine-grained control over memory, which includes the ability to work with uninitialized memory when needed.
> - Use in systems programming: Like Rust, C++ is often used in contexts where direct memory manipulation is necessary.
> - Optimization opportunities: Leaving variables uninitialized allows compilers more freedom for optimizations.

> While Solidity's approach is beneficial in its context (smart contracts on a blockchain), it's not universally superior. 

的确很合理，Solidity和Rust/C++定位不同，选择的策略也不同.

`delete` 操作符可以重置一个变量为初始化值，所以 `delete` 的含义应该是 `reset`. `delete` 同样支持操作动态数组，将其长度重置为0；或者是静态数组，将静态数组中每个的元素重置为初始化值。

需要注意的是, `delete` 同样支持只操作数组中的某个元素 `delete a[x]`, 就重置了下标为 x 的元素，数组中的其他元素就保持不变.

另外, `delete` 对 `mapping`是没有效果的，如果一个 struct a包含 mapping, `delete a` 不会重置 `mapping` 为初始化值。但是 delete 支持删除 mapping 中的特定的 key, 如 `delete a[x]` 就是删除了 key=x 的值。

#### 09 Constant

`constant` 和 `immutable` 都是用来声明常量的, 数值变量可以声明 `constant`和 `immutable`；string和bytes可以声明为constant，但不能为immutable.

那么两者之间有什么差别呢？什么时候应该使用哪一个关键字来声明常量呢？

总结下来，主要是赋值时机和 gas 费的差别:

##### Value assignment

`constant` 必须是在编译期确定，所以必须是在声明时初始化，会被直接写入到字节码中；而 `immutable` 修饰的变量，可以在运行时确定，即在构造器中指定，也会被写入到字节码中。

二者声明的变量都不会存储在链上，都会被写入到字节码中

##### Gas cost

读取 constant 变量是不需要任何 gas 的, 而读取 immutable 是需要一点 gas 费的，当然也比读取其他非常量便宜很多。

##### Use case

`constant` 一般用来指定编译期已知的变量，如数字或者是所有合约都一样的配置；`immutable` 则是用于部署后不变的值，如合约地址或者是因合约而异的配置值

### 2024.09.26
#### 10 Control Flow

Solidity 的控制流和其他语言基本是一模一样了。

既然教程用 Solidity 写了个插入排序，那么我就不写插入排序了，写个 leetcode 的起手题: [twosum](https://leetcode.com/problems/two-sum/description/) .

> Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
> You may assume that each input would have exactly one solution, and you may not use the same element twice.
> You can return the answer in any order.

> Example 1:

> Input: nums = [2,7,11,15], target = 9
> Output: [0,1]
> Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

> Example 2:
> Input: nums = [3,2,4], target = 6
> Output: [1,2]

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract TwoSum {
    mapping (uint32 => uint32) public num_indics;
    mapping (uint32 => bool) public contains;

    function twoSum(uint32[] calldata input, uint32 target) external payable returns (uint32[] memory){
        for(uint32 i = 0; i < input.length; i++){
            num_indics[input[i]] = i;
            contains[input[i]] = true;
        }
        uint32[] memory result = new uint32[](2);
        for(uint32 i = 0; i < input.length; i++){
            if (contains[target - input[i]] && i != num_indics[target - input[i]]){
                result[0] = i;
                result[1] = num_indics[target - input[i]];
                return result;
            }
        }

        // not found
        return result;
    }
}
```

`twosum` 非常简单，真正写起来的时候才意识到 Solidity 和其他编程语言的差别， Solidity 的 mapping 不像正常的 hashmap 那样，它是不支持 `contains 函数的，所以我只好用另外一个 mapping 来模拟 contains 的函数，但是这样又会增加存储的开销。

顺便推荐个 web3 的 Leetcode，用 Solidity 来解决编程题：https://dapp-world.com

#### 11 Constructor 

0.4.22之前的构造器函数估计是向 Java 学习的，使用与合约名同名的函数作为构造函数而使用，但是Java中的构造函数是和普通函数不一样的，是没有返回值的，所以无法与普通函数混淆。

但是 Solidity 并没有这样的限制，函数并不一定要强制声明返回值，所以使得构造函数可能成普通函数，引发漏洞。

所以0.4.22版本及之后，采用了全新的 constructor 写法，这个就是向 Javascript 学习，显式声明构造函数。（感觉这个语法设计着实没有深思熟虑）

与Java/C++ 不同的是，因为 Solidity 没有函数重载的概念，所以 Solidity 最多只有一个构造函数，如果没有显式声明构造函数，就使用默认的构造函数。

### 2024.09.27

#### 11 Modifier

Modifier 类似其他语言的装饰器，或者是切面编程，可以运行函数主体前或者运行后执行对应的操作。常见的用法是把包含 Modifier 的合约定义成库，然后通过继承来使用相应的 `Modifier`:

```solidity
contract owned {
    constructor() { owner = payable(msg.sender); }
    address payable owner;

    // This contract only defines a modifier but does not use
    // it: it will be used in derived contracts.
    // The function body is inserted where the special symbol
    // `_;` in the definition of a modifier appears.
    // This means that if the owner calls this function, the
    // function is executed and otherwise, an exception is
    // thrown.
    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }
}

contract priced {
    // Modifiers can receive arguments:
    modifier costs(uint price) {
        if (msg.value >= price) {
            _;
        }
    }
}

contract Register is priced, owned {
    mapping(address => bool) registeredAddresses;
    uint price;

    constructor(uint initialPrice) { price = initialPrice; }

    // It is important to also provide the
    // `payable` keyword here, otherwise the function will
    // automatically reject all Ether sent to it.
    function register() public payable costs(price) {
        registeredAddresses[msg.sender] = true;
    }

    // This contract inherits the `onlyOwner` modifier from
    // the `owned` contract. As a result, calls to `changePrice` will
    // only take effect if they are made by the stored owner.
    function changePrice(uint price_) public onlyOwner {
        price = price_;
    }
}
```

而 `_` 指代的就是被修改的函数主体。

#### 12 Event

如果从存储的角度来思考事件(Event)，也可以解释为什么存储在事件的gas费会比链上便宜那么多。

存储在链上的最大特点就是不可篡改，意味着有多个节点都对写入的值达成共识（可以理解成多副本冗余），而日志并不存储在链上，就是不需要网络节点达成共识，类似于单机存储，成本自然就下来。

如果所有存储的内容都需要达成共识，开销也太大了。

按照 Event 的 [ABI 标准](https://docs.soliditylang.org/en/v0.8.27/abi-spec.html#abi-events), 事件包含以下的内容:
- address: 合约地址
- topics 数组:
  - topics[0]: 第一个元素的值是 "anonymous" 或者 `keccak(EVENT_NAME+"("+EVENT_ARGS.map(canonical_type_of).join(",")+")")`, `canonical_type_of` 是用来获取参数类型的函数
  - topics[1-3]: 保存被声明成 `indexed` 类型的参数，最多3个参数
  - 所以 topics 数组的长度最大为4，最多包含3个参数，因为第1个参数被用来标识事件了
- data: 就是存储的数据，对应的就是没有被声明成 `indexed` 的参数

`indexed` 可以标记值类型，枚举，静态数组和 string （如果超过256个字节，就会使用 Keccak 函数计算 hash 值，确保长度都是固定的），但不可用来标记 mapping, struct 和动态数组。

其他语言中也有事件的概念，如 Javascript 里面有许多浏览器操作的事件，如点击按钮，移动鼠标等等。我们同样可以使用 `web3.js` 这个库来订阅我们感兴趣的事件：

```js
var options = {
    fromBlock: 0,
    address: web3.eth.defaultAccount,
    topics: ["0x0000000000000000000000000000000000000000000000000000000000000000", null, null]
};
web3.eth.subscribe('logs', options, function (error, result) {
    if (!error)
        console.log(result);
})
    .on("data", function (log) {
        console.log(log);
    })
    .on("changed", function (log) {
});

```

### 2024.09.28

#### 13 Inheritance

Solidity 的继承基本就是借鉴 C++的，无论是 `virtual`, `override` 关键字，还是构造函数的继承，又或者是多继承。

虽然Solidity 的继承是借鉴 C++ 的, 但是 C++ 继承的问题， Solidity 也加以限制了。如C++中的多继承，函数名冲突问题:

```c++
class A{
public:
    void func();
};
class B{
private:
    bool func() const;
};
class C: public A, public B{ ... };

C c;
c.func();           // 歧义！
```

虽然`B::func`是私有的，但仍然会编译错, 编译器不知道 `c.func()` 指的是哪个类的`func`。而在 Solidity 中，如果继承的父类有重名函数， `Solidity` 编译器会要求重新，无论这个函数是否有声明成 `virtual`：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract A {
    uint data = 2;
    function func() public {

    }
}

contract B {

    function func() public  {

    }
}

contract C is A, B {} // => 编译器报错, TypeError: Derived contract must override function "func". Two or more base classes define function with same name and parameter types.
```

另外，如果`A`, `B` 中有相同的状态变量，如 `data`, `C` 继承自 A,B 的话，也会报错: `DeclarationError: Identifier already declared.`, 从而规避掉 C++ 多继承情况下，同名函数或者同名变量的歧义问题。

C++的菱形继承是多继承的特例，因为存在类成员变量和函数，变成一个更复杂的问题了，而 Solidity 通过禁止在继承链上出现同名的变量和函数，规避掉这个问题。

Effective C++ 和 More Effective C++ 作者 Scott Meyers对于多继承的建议是
1. 如果能不使用多继承，就不用他；
2. 如果一定要多继承，尽量不在里面放数据

Java 就吸取了第二条建议，然后设计了 `Interface`, 不允许定义状态变量。

使用 Solidity 的时候，我也是同样的观点，如果能不使用多继承，就不用; 如果一定要多继承，就不要定义数据变量。

其实我是不理解 `Solidity` 都支持 `Interface`了，为什么还需要学C++的多继承呢，直接借鉴Java的单继承 + 多接口组合不是更清晰嘛？

C++的多继承是因为它是面向对象的先驱, 历史悠久, Python 搞多继承是因为没有 `Interface` 的概念，现在是 C++ 和 Java 的特点都拿过来了, 反而是复杂化了。

在面向对象中，继承通常是和多态组合发挥作用的，而 Solidity 也是支持多态的，如：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Base contract
contract Animal {
    function speak() public virtual returns (string memory) {
        return "Animal sound";
    }
}

// Derived contract 1
contract Dog is Animal {
    function speak() public virtual override returns (string memory) {
        return "Woof";
    }
}

// Derived contract 2
contract Cat is Animal {
    function speak() public override returns (string memory) {
        return "Meow";
    }
}

// Test contract
contract TestPolymorphism {
    function getAnimalSound(Animal animal) public returns (string memory) {
        return animal.speak();
    }
}
```

### 14 Interface

Solidity 的 Interface 和 abstract contract 基本就是参照 Java的 Interface 和 abstract class 了(准确来说，应该是Java8之前的Interface, Java8 之后, interface 也可以有默认函数实现了).

Java Interface中所有的函数默认是 public 的, Solidity Interface 中的函数默认是 external； Solidity Interface 不允许定义任何变量, 但是可以定义事件，Java Interface 允许定义常量 `public static final` 

使用 Interface 在 Solidity 中实现多态:

```solidity
interface Animal {
    function makeSound() external view returns (string memory);
}
// Contract Dog implementing the Animal interface
contract Dog is Animal {
    function makeSound() external pure override returns (string memory) {
        return "Woof";
    }
}

// Contract Cat implementing the Animal interface
contract Cat is Animal {
    function makeSound() external pure override returns (string memory) {
        return "Meow";
    }
}
contract AnimalShelter {
    function getAnimalSound(Animal animal) public view returns (string memory) {
        // Polymorphic behavior: Treats both Dog and Cat as an Animal
        return animal.makeSound();
    }
}

```

课程中无聊猿(BAYC)的交互, 其实就是多态的一种应用，`BAYC` 就是若干个实现了代币 `IERC721` 接口的代币之一. 

另外一个非常关键的知识点就是合约的ABI 与接口等价，RPC 接口调用的ABI，背后实际调用的是定义的各式接口。

### 2024.09.29

#### Error handling

按照官方文档的说明，Solidity使用的是 state-reverting exception，我是第一次了解 state-reverting 的异常。

它的大概含义是，如果出现异常，那么函数调用及其子函数调用导致的所有的状态变更，都需要回滚(reverted, undone), 概念理解起来和数据库的异常处理很类似，只是成功和失败两个状态，没有中间态，失败就回滚所有操作，保证原子性。

Solidity 内置的错误类型有两种 `Error(string)` 和 `Panic(uint256)`. `Error` 就类似 Java 中的常规错误(`CheckedException`), 可以预期会发生的; Panic 就类似 Java 中的`UncheckedException`, 就是通常来表示在没有 bug 代码中就不应该出现的错误，比如数组越界，除0等等。

文档提及的 `state-reverting` 是通过 `revert` 函数来实现的，它接受一个 `Error` 类型作为参数，`revert` 回滚状态，并将传入的错误向调用方抛出，调用方也会自动向它的调用方抛出，直到遇到 `try/catch` 语句捕获异常。
（原来还一个 `throw` 的关键字，具有同样的功能，不过在 0.4.13 被废弃，后面就被移除了，估计是只强调了「向上抛出」的语义，没有强制「回滚」）

而 `assert` 和 `require` 就是两个在预期条件不满足时，分别用来抛出 `Panic` 和 `Error` 的函数，差别就是 `require` 还可以指定一下错误信息, 两个函数内部都会调用 `revert` 来回滚状态，并将异常向上抛出。

Solidity 的 try/catch 和 Java 也很类似:

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.1;

interface DataFeed { function getData(address token) external returns (uint value); }

contract FeedConsumer {
    DataFeed feed;
    uint errorCount;
    function rate(address token) public returns (uint value, bool success) {
        // Permanently disable the mechanism if there are
        // more than 10 errors.
        require(errorCount < 10);
        try feed.getData(token) returns (uint v) {
            return (v, true);
        } catch Error(string memory /*reason*/) {
            // This is executed in case
            // revert was called inside getData
            // and a reason string was provided.
            errorCount++;
            return (0, false);
        } catch Panic(uint /*errorCode*/) {
            // This is executed in case of a panic,
            // i.e. a serious error like division by zero
            // or overflow. The error code can be used
            // to determine the kind of error.
            errorCount++;
            return (0, false);
        } catch (bytes memory /*lowLevelData*/) {
            // This is executed in case revert() was used.
            errorCount++;
            return (0, false);
        }
    }
}
```

catch 语句可以用来匹配不同的错误类型，优先级从上到下，就是如果匹配到某个 catch 语句，就不会向下继续走了。

前面两个 catch 语句就是用来捕获 Solidity 内置的 `Error` 和 `Panic` 类型，而 `catch(bytes memory lowLevelData)` 就比较有趣，有错误数据它能 catch 到，没有错误数据它也能 catch 到， `bytes memory` 就是用来获取底层错误信息，相当于是用来兜底的。

所以想要 catch 住所有的错误，要不用 `catch {...}` (不指定错误类型)，要不用 `catch (byte memory lowLevelData) {...}` catch 底层错误信息.

Solidity 101 课程到此结束, 耶.

### 2024.09.30

#### 16 Overloading

函数重载的概念在C++ 和 Java 中都是非常常见且有用的功能的，可以编写多个同名但是函数签名不一样的参数。

对于课程提到的实参匹配问题：

```solidity
function f(uint8 _in) public pure returns (uint8 out) {
    out = _in;
}

function f(uint256 _in) public pure returns (uint256 out) {
    out = _in;
}
```

调用 `f(50)` 的确会报错，因为 `50` 既可以转换成 `uint8` 也可以转换成 `uint256`，解决方法就是显式给出类型，如`uint8 number = 50;`. 

但是调用 `f(256)` 却不会报错，因为 `256` 只能转换 `uint256`, `uint8` 的最大值为 `255`.

#### 17 Library

就像所有的库一样，Solidity的库目标也是为了复用，定义一个库合约，然后被多个合约调用，减少代码冗余。

而在Solidity，库合约其实可以看作是所有合约隐式的基类，库合约不会出现在继承链里面，但是调用库合约就好像调用基类的函数一样, 通过`L.f()` 这样的语法, 我个人是不太喜欢用 `using for`指令，太隐式了，涉及到钱的东西，还是显式调用好。

而关于库合约限制，不能存储状态变量，不能继承或者被继承，以及不能接收Ether等，都是为了可以让库合约成为纯粹的库，避免引入状态导致问题。

关于合约调用合约，有三个关键的底层函数，`CALL`, `DELEGATECALL`, `CALLCODE`(已废弃).

`CALL` 是最常用的，用来调用其他合约的或者发送Ether的函数，当调用`CALL`的时候，他会创建自己的上下文；而 `DELEGATECALL` 和 `CALL` 类似，最大的差别是它可以保存合约调用者的状态，意味着它会使用调用方的状态，而非被调用方的状态。

而调用库合约，用的就是`DELEGATECALL`.

谈到库，另外一个绕不开的话题就是怎么引用第三方现成的库合约，这就需要包管理器(package manager), Java有Maven, Javascript 有NPM, Solidity 用啥呢? 下节分解.

### 2024.10.01

#### 18 Import

上一个章节提到了库合约，要使用库合约，肯定是要和包管理器结合，需要一种方式来把库合约引入进来。

在 Solidity 比较流行的一种包管理方式是使用 NPM, 类似本地开发，安装 `OpenZeppelin` 的库:

```sh
npm install @openzeppelin/contracts
```

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyContract {
    using SafeMath for uint256;
    // Your code
}

```

或者像Golang 那样，通过 http/https 链接来直接引入资源，但是这种方式有个缺点就是没有版本机制，也就是如果依赖的库合约文件升级了，那么你就直接引用了最新的库合约，可能引入了 breaking change, 所以使用 full url 引入库合约的时候，就要小心一些。

```
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol'; // Address.sol 文件一旦更新，就会直接导入最新文件
```

除了NPM之外，还有其他的Solidity 包管理器，如 `ethPM` 和 `DappTools`.

### 2024.10.02
#### 19 Receive/Fallback

在最差情况下, `receive` 函数只有大概2300 gas可用，没有太多余地做打日志之外的操作。按照官方文档的说法，下面的操作会消耗超过2300 gas：
1. 向链上写入数据
2. 创建合约
3. 调用会消耗大量 gas 的外部函数
4. 发送 Ether. （没错，这意味着你无法在接收 Ether 的函数里面发送 Ether, 不然你大概率会因为 out of gas 被接收失败）

虽然 `receive` 和 `fallback` 函数都可以用来接收 Ether, 但是使用 `fallback` 来处理接受 Ether 并不是推荐的做法，顾名思义， `fallback` 函数应该处理的是兜底的失败逻辑，而不是处理正常的接收逻辑。

就类似于不应该依赖 `try/catch` 来处理正常的逻辑分支。

上文提到，没有 `receive` 和 `fallback` 函数是无法接收 Ether, 但是凡事也有例外，也有一种特殊情况，就是作为矿工奖励的接收方(coinbase transaction), 你没有 `receive` 和 `fallback` 函数也能接收 Ether, 这是 by design 的功能，因为 EVM 的标准并没有声明应该如何处理这种转账，所以合约无法拒绝。

强塞进来的钱，想拒绝都没有办法。

按照 EVM 的规定，发送Ether时，`msg.data` 应该是为空的，所以这就是为什么 `msg.data`为空且存在 `receive()` 时，会触发 `receive()`

#### 20 SendETH

Solidity 有三个函数可以用来发送 Ether: 
1. `transfer`: 有 2300 gas 限制, 合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑; 转账失败会自动回滚.
2. `send`: 有 2300 gas 限制, 合约的`fallback()`或`receive()`函数不能实现太复杂的逻辑; 转账失败不会自动回滚，需要判断转账结果
3. `call`: 无gas限制, 可以支持对方合约`fallback()`或`receive()`函数实现复杂逻辑; 转账失败不会自动回滚，需要判断转账结果

推荐使用 `call` 来发送Ether，除了gas无限制的优点外，还有一个课程未提及的点, 就是在2019年12月的Istanbul Hardfork后, `transfer` 和 `send` 变成没有那么安全了，而 `call` 可搭配防重入锁来抵御重入攻击。

所谓的重入攻击，指的是有合约A（受害者）和合约B(攻击者):
1. 合约A调用合约B
2. 在合约A的调用完成前，合约B反过来调用合约A
3. 这样就会形成递归调用，就有可能把合约A的钱耗高，或者出现预期外的情况。

以代码为例，结合前文学到的 `fallback` 函数:

```solidity
// Vulnerable Contract A
contract VictimContract {
    mapping(address => uint) public balances;

    function withdraw() public {
        uint balance = balances[msg.sender];
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success);
        balances[msg.sender] = 0;
    }
}

// Attacker Contract B
contract AttackerContract {
    VictimContract public victim;

    constructor(address _victimAddress) {
        victim = VictimContract(_victimAddress);
    }

    fallback() external payable {
        if (address(victim).balance >= 1 ether) {
            victim.withdraw();
        }
    }

    function attack() external payable {
        victim.withdraw();
    }
}
```

1. 攻击者调用合约B的 `attack` 函数
2. `attack` 函数调用合约A的 `withdraw` 函数
3. 因为没有定义 `receive` 函数，合约A给合约B转账的时候，就会调用到合约B的 `fallback` 
4. 当合约A调用合约B的 `fallback` 函数，函数还没有返回，也就是合约A的`withdraw` 还没有结束, `fallback` 再次调用合约A的 `withdraw` 函数
5. 循环调用，直到耗尽合约A的所有资金为止。

2016年导致 Ethereum 分裂成 Ethereum classic 和 Ethereum 的DAO 攻击就是重入攻击.

而在调用 `call` 时，配合防重入的 modifier，就能抵御这样的攻击：

```solidity
bool private locked;

modifier noReentrant() {
    require(!locked, "No re-entrancy");
    locked = true;
    _;
    locked = false;
}

---
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SafeEtherTransfer is ReentrancyGuard {
    function sendEther(address payable _to, uint256 _amount) public nonReentrant {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed.");
    }
}
```

### 2024.10.03
#### 21 CallContract

> 没有谁是一座孤岛. ——John Donn

每个人都与他人相互关联，缺一不可，合约也类似，单个的合约并不能发挥太大的作用，只有多个合约相互组合，才能构建出复杂，强大的DAPP。

在微服务的视角，想要调用微服务中某个提供特定功能的服务，只需要知道 host + port 就可以发起调用(先不考虑授权机制)，而在 solidity 的世界，只需要知道合约的地址或者通过 import 引入其他合约就能发起调用，合约地址就是已部署合约的唯一标识。

```solidity
contract Callee {
    uint256 public x;

    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }
}

contract Caller {
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

}

```

假设合约 `Callee` 部署在地址 `0xd9145CCE52D386f254917e481eB44e9943F39138`, `Caller` 想要调用它，只需要 `setXFromAddress(0xd9145CCE52D386f254917e481eB44e9943F39138, 256)`, 就能发起调用.

或者 `setX(0xd9145CCE52D386f254917e481eB44e9943F39138, 256)`, Solidity 会把地址转换成合约 `Callee` 的引用，然后再发起调用。

除去通过地址或者合约引用发起调用， Solidity 还支持通过之前学过的，用来转账的 `call` 函数来调用其他合约，但是函数比较底层，一般不推荐用来调用其他合约.

### 2024.10.04
#### 22 Call

不推荐使用 `call` 来调用其他合约的原因，课程并没有解释得很详细，主要是笼统地说不推荐使用，背后的原因我认为大概有以下几点：

`call`调用失败的回滚不会向上传递, 介绍 error-handling 的时候有提到，solidity的异常是 revert-state，也就是意味着出现异常时，会在调用栈向上回滚，而 `call` 在调用失败的时候并不会自动向上回滚，除非手动添加回滚操作:

```solidity
(bool success, ) = targetContract.call(abi.encodeWithSignature("someFunction()"));
require(success, "Call failed");
```

使用 `call` 调用跳过了编译器的类型检查，非常容易导致 bug, 比如把 `targetContract.call(abi.encodeWithSignature("someFunction()"));`中 `someFunction` 写成了 `somFunction`, 也能编译通过并执行, 无法检查函数是否存在或者参数类型，参数个数是否有误.

总结而言，`call` 就类似 Python 或者 Javascript 中的 `eval` 函数，可以直接将字符串当作代码来执行, 并返回执行结果.

#### 23 delegatecall

`delegatecall` 的确非常神奇，我这次是没有想到在其他语言中的类似的功能, 使用 `delegatecall` 有个非常强大的功能，意味着它可以在运行时从其他合约地址动态加载代码，但是仍然使用本合约的上下文，也就意味着可以只把代码拿过来用，无需关心状态变化。

智能合约一旦部署，就无法修改。如果重新部署一个新合约，既会导致旧合约所有内部数据的丢失，也会导致合约地址的变更，这对于用户来说是不可接受的。

为了解决这个问题，人们提出了基于 Proxy 的合约升级方案。这种方案的核心思想是， 将合约的代码和数据分离，面向客户的是负责保存数据的 Proxy 合约， 但是 Proxy 中不包含任何逻辑代码，只是将所有的请求，都转发给实现业务代码的 Implementation 合约。

当需要升级时，只需要部署一个新的 Implementation 合约，然后将 Proxy 合约的指针更新为新的 Implementation 合约地址即可.

假如有一个代理合约，可以理解成课程中的合约B, 还有一个具体实现的合约，可以理解成合约C.

```solidity
// Proxy contract
contract Proxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function upgradeTo(address _newImplementation) public {
        implementation = _newImplementation;
    }

    fallback() external payable {
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }
}

// Implementation contract
contract ImplementationV1 {
    uint public value;

    function setValue(uint _value) public {
        value = _value;
    }
}
```

用户A通过合约B(代理合约)来调用合约C(具体的实现合约), 当合约C 升级之后，只需要调用 `upgradeTo` 接口，传入新合约D的地址，就可以让合约B 把请求转发给新合约D, 用户也不需要变成合约地址，因为用户只需要知道合约B的地址即可。

因为合约B调用合约C或者合约D 使用的都是 `delegatecall`, 所以在合约C或者D看来，就和用户A直接调用他们没有差别，通过 `delegatecall` 就实现了合约的平滑升级，类似CI/CD中的灰度发布了.

<!-- Content_END -->
