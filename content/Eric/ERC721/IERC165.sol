// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IERC165 {

    // 如何合约实现了传入的interfaceId，则返回true
    function supportsInterface(bytes4 interfaceId) external view returns(bool);

}
