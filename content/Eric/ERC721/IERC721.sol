pragma solidity ^0.8.20;

interface IERC721 {

    // 记录从from地址发送NFT到to地址
    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    // 记录from地址收钱to地址转移NFT的权限
    event Approval(address indexed from, address indexed to, uint256 tokenId);

    // 批量授权
    event ApprovalForAll(address indexed owner, address indexed to);

    // 返回某个地址的nft数量
    function balanceOf(address _address) external returns (uint256);

    // 返回某个nft的所有者
    function ownerOf(uint256 tokenId) external returns(address);

    // 将NFt从from地址转移到to地址
    function transferFrom(address from, address to, uint256 tokenId) external returns(bool);

    // 安全转帐，如果接收地址是合约，则要求合约实现ERC721Receiver
    function safeTransferFrom(address from, address to, uint256 tokenId) external returns(bool);

    // 调用者收钱approve地址，可以转移你的NFT
    function approve(address approve, uint256 tokenId) external returns (bool);

    // 查询nft被授权给了哪个地址
    function getApprove(uint256 tokenId) external returns (address);

    // 将自己的nft批量授权给其他人
    function setApprovalForAll(address to) external returns (bool);

    // 查询自己的nft 授权给了谁
    function isApprovalForAll(address from)  external returns(address);

    // 安全转帐，如果接收地址是合约，则要求合约实现ERC721Receiver
    function safeTransferFrom(address from, address to, uint256 tokenId,bytes data) external returns(bool);

}