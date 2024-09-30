pragma solidity ^0.8.20;

interface IERC20 {

    /**
    * 当value单位的货币从from地址转移到to地址时
    */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
    * owner授权给spender账户 value单位的货币
    */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 返回代币总量
    function totalSupply() external view returns (uint256);

    // 返回账户地址的余额
    function balanceOf(address _address) external view returns (uint256);

    // 从调用者账户转移_amount数量的代币 到'_to'账户地址 ，如果成功，返回true
    function transfer(address _to , uint256 _amount) external returns (bool);

    // 返回owner账户授权给spender账户的额度
    function allowance(address _owner , address _spender) external view returns (uint256);

    // 调用者账户给spender账户授权amount数量代币的额度
    function approve(address _spender, uint256 _amount) external returns (bool);

    // 从_from账户向_to账户转移_amount数量的代币，授权额度也会减少
    function transferFrom(address _from, address _to , uint256 _amount) external returns (bool);

}

