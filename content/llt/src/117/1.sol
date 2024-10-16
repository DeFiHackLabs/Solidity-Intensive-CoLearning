// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// 删除合约
contract Helloworld {
    uint public value = 10;

    constructor() payable {}

    function beibei() external {
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }
}

contract DeployContract {

    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }

    constructor() payable {}

    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }

    // 新的提案删除功能只有在合约 创建-自毁 这两个操作处在同一笔交易时才能生效。
    // 新的提案删除功能只有在合约 创建-自毁 这两个操作处在同一笔交易时才能生效。
    function demo() public payable returns (DemoResult memory){
        Helloworld del = new Helloworld{value:msg.value}(); // 创建
        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });
        del.beibei(); // 自毁
        return res;
    }
}
