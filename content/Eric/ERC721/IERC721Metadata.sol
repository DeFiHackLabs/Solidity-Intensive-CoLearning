// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {IERC721} from "./IERC721.sol";

interface IERC721Metadata is IERC721{

    // 返回代币名称
    function name() external view returns (string memory);

    // 返回代币符号
    function symbol() external view returns (string memory);

    // 通过tokenId查询URL、
    function tokenURI(uint256 tokenId) external view returns (string memory);

}
