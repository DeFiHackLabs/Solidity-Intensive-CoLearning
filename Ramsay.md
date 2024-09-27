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

`twosum` 非常简单，真正写起来的时候才意识到 Solidity 和其他编程语言的差别， Solidity 的 mapping 不像正常的 hashmap 那样，它是不支持 =contains= 函数的，所以我只好用另外一个 mapping 来模拟 contains 的函数，但是这样又会增加存储的开销。

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
  - topics[1-n]: 保存被声明成 `indexed` 类型的参数，最多3个参数
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

<!-- Content_END -->
