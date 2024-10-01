// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// ------ 调用父合约的函数 ------ //
// contract Yeye {
//     event Log(string msg);

//     function hip() public virtual {
//         emit Log("Yeye");
//     }

//     function yeye() public virtual {
//         emit Log("Yeye");
//     }
// }

// contract Baba is Yeye {
//     function hip() public virtual override {
//         emit Log("Baba");
//     }

//     function baba() public virtual {
//         emit Log("Baba");
//     }
// }

// contract Erzi is Yeye, Baba {
//     function hip() public override(Yeye, Baba) {
//         emit Log("Erzi");

//         super.hip();
//     }

//     function erzi() public {
//         emit Log("Erzi");

//         Yeye.hip();
//     }
// }


// 钻石继承


/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {
    event Log(string message);

    function foo() public virtual {
        emit Log("God.foo called");
    }

    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {
    function foo() public virtual override {
        emit Log("Adam.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
