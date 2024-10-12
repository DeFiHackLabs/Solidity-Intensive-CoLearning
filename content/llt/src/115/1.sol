// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// call
contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth的事件，记录amount和gas
    event Log(uint256 amount, uint256 gas);

    receive() external payable { }

    fallback() external payable {}

    // 返回合约ETH余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
        _x = x;
        // 如果转入ETH，则释放Log事件
        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns (uint256 x) {
        x = _x;
    }
}

contract callContract {
    event Log(bytes);

    // 调用目标合约的setX函数
    function callSetX(address _addr,uint x) external  {
        (bool seccess,bytes memory data ) = _addr.call(abi.encodeWithSignature("setX(uint256)", x));
        require(seccess);

        emit Log(data);
    }

    // 调用目标合约的getX函数
    function callGetX(address _addr) external  {
        (bool seccess, bytes memory data) = _addr.call(abi.encodeWithSignature("getX()"));
        require(seccess);

        emit Log(data);
    }

    // 调用一个不存在的函数
    function noFunction(address _addr,uint x) external  {
        (bool seccess,) = _addr.call(abi.encodeWithSignature("foo(uint256)", x));
        require(seccess);
    }

}
