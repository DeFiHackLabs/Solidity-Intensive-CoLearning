// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// hash
contract Helloworld {
    string str = "0xAA";

    function hash(uint _num,  string memory _string, address _addr) external pure returns(bytes32){
        return keccak256(abi.encodePacked(_num,_string,_addr));
    }

    function weakHash(string memory _str) external view returns(bool){
        return keccak256(abi.encodePacked(_str)) == keccak256(abi.encodePacked(str));
    }

    function weakHash(string memory _str1,string memory _str2) external pure returns(bool){
        return keccak256(abi.encodePacked(_str1)) == keccak256(abi.encodePacked(_str2));
    }
}
