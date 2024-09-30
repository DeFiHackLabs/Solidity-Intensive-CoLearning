// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import IERC20 from "../ERC20/IERC20.sol" ;

contract AirDrop {

    function transferMultiAddress(address _token, address[]  calldata _addressArray,
        uint256[] calldata _amountArray) external returns (bool){
        // 检查数组长度是否相等
        require(_addressArray.length == _amountArray, "数组参数长度不相等");

        IERC20 erc20 = IERC20(_token);
        // 检查授权额度是否充足
        uint8 sum = getSum(_addressArray);
        require(sum <= erc20.allowance(msg.sender, address(this)),"授权额度不足");

        for(uint8 i = 0 ; i< _addressArray.length ; i++){
            // 先给自己mint1000个代币，然后在授权给空投合约代币
            // 再调用transferFrom函数让空投合约把自己的代币转移到其他地址中
            erc20.transferFrom(msg.sender, _addressArray[i], _amountArray[i]);
        }
        return true;
    }

    function getSum(uint256[] calldata _amountArray) internal pure returns(uint256){
        uint8 sum = 0 ;
        for(uint8 i = 0 ; i<_amountArray.length; i++){
            sum += _amountArray[i];
        }
        return sum;
    }

}
