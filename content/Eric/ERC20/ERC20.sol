pragma solidity ^0.8.20;

import {IERC20} from "./IERC20.sol";

contract ERC20 is IERC20{

    mapping (address => uint256) public override  balanceOf;

    mapping (address => mapping (address => uint256)) public override allowance;

    uint256 public override totalSupply;

    string public name ; // 名称
    string public symbol ; // 代号
    uint256 public decimals = 18 ; // 小数位

    constructor (string _name, string _symbol){
        name = _name ;
        symbol = _symbol;
    }

    error TransferFromError();

    function transfer(address _to, uint256 _value) public override returns (bool) {
        require(balanceOf[msg.sender] > _value, "it's not enough value to transfer");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender , _to, _value);
        return true;
    }

    function approve (address _spender ,uint256 _amount) public override returns (bool){
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(address _from , address _to , uint256 _amount) external override returns (bool) {
        if(allowance[_from][msg.sender] < _amount  || balanceOf[_from] < _amount){
            revert TransferFromError();
        }
        allowance[_from][msg.sender] -= _amount;
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }


}