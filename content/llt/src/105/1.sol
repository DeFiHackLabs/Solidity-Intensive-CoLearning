// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    // 常数
    // uint256 constant number = 1;
    // string constant str = "1231";

    // uint256 immutable number1 = 2;

    // uint256 public immutable IMMUTABLE_NUM = 9999999999;
    // address public immutable IMMUTABLE_ADDRESS;
    // uint256 public immutable IMMUTABLE_BLOCK;
    // uint256 public immutable IMMUTABLE_TEST;

    // constructor() {
    //     IMMUTABLE_ADDRESS = address(this);
    //     IMMUTABLE_NUM = 1118;
    //     IMMUTABLE_TEST = test();
    // }

    // function test() public pure returns (uint256) {
    //     uint256 what = 9;
    //     return (what);
    // }

    // 插入排序
    function insetSort(uint256[] memory arr)
        public
        pure
        returns (uint256[] memory)
    {
        for (uint256 i = 1; i < arr.length; i++) {
            uint256 temp = arr[i];
            uint256 j = i;
            while (j >= 1 && temp < arr[j - 1]) {
                arr[j] = arr[j - 1];
                j--;
            }
            arr[j] = temp;
        }

        return arr;
    }
}
