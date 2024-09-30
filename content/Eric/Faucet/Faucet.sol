// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "../ERC20/IERC20.sol";

contract Faucet {

    uint256 public amount = 100;
    mapping(address => bool) public isGet;
    address public tokenAddress;

    event SendToken(address indexed _address, uint256 indexed amount);

    constructor(address _address){
        tokenAddress = _address;
    }

    function getToken() external returns(bool){
        require(!isGet[msg.sender],"已经领取过了");
        isGet[msg.sender] = true;
        IERC20(tokenAddress).transfer(msg.sender, amount);

        emit SendToken(msg.sender, amount);
        return true;
    }

}
