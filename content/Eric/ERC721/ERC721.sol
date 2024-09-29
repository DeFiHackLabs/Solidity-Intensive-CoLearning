pragma solidity ^0.8.20;

import {IERC721} from "./IERC721.sol";

contract ERC721 is IERC721{

    string public  name;
    string public  symbol;

    constructor  (string memory name, string memory symbol){
        name = name;
        symbol = symbol;
    }


}