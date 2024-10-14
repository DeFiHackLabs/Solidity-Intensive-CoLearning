pragma solidity ^0.8.20;

import {IERC721} from "./IERC721.sol";
import {IERC165} from "./IERC165.sol";
import {IERC721Metadata} from "./IERC721Metadata.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

contract ERC721 is IERC721Metadata{
    using Strings for uint256;

    string public  override name;
    string public  override symbol;
    mapping(uint => address) private _owners; // 通过tokenID查找拥有者
    mapping(address => uint) private _balances;// 通过地址查找nft数量
    mapping(uint => address) private _tokenApprovals; //通过tokenId查询授权者
    mapping(address => mapping(address => bool)) private _operatorApprovals;// 授权者到被授权者的映射

    error ERC721InvalidReceiver(address receiver);// 无效的接收者

    constructor  (string memory name, string memory symbol){
        name = name;
        symbol = symbol;
    }

    function supportsInterface(bytes4 interfaceId) external pure override returns (bool){
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId;
    }

    function ownerOf(uint tokenId) public view override returns (address owner){
        owner = _owners[tokenId];
        require(owner != address(0), "token doesn't exist");
    }



}