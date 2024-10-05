pragma solidity ^0.8.20;

import {IERC721} from "./IERC721.sol";
import {IERC721Metadata} from "./IERC721Metadata.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';


contract ERC721 is IERC721Metadata{
    using Strings for uint256;
    using Address for address;


    string public  name;
    string public  symbol;

    constructor  (string memory name, string memory symbol){
        name = name;
        symbol = symbol;
    }


}