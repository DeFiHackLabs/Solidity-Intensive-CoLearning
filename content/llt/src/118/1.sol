// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Helloworld {
    uint256 x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xAA";
    uint256[2] array = [5, 6];

    function abiEncode() external view returns (bytes memory result) {
        result = abi.encode(x, addr, name, array);

        // 编码/解码在线地址: https://adibas03.github.io/online-ethereum-abi-encoder-decoder/#/encode

        //000000000000000000000000000000000000000000000000000000000000000a 0 ~ 32
        //0000000000000000000000007a58c0be72be218b41c608b7fe7c5bb630736c71 32~ 64
        //00000000000000000000000000000000000000000000000000000000000000a0 64~ 96(a0代表string开始位置 16*10 = 160 ,代表存储位置是160 开始)
        //0000000000000000000000000000000000000000000000000000000000000005 96~ 128
        //0000000000000000000000000000000000000000000000000000000000000006 128~ 160
        //0000000000000000000000000000000000000000000000000000000000000004 160~ 192 （代表string的长度）
        //3078414100000000000000000000000000000000000000000000000000000000 192~ 224 (代表 0xAA 的十六进制； 线上转换地址 https://string-functions.com/string-hex.aspx)
    }

    function abiEncodePacked() external view returns (bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
        // 0x000000000000000000000000000000000000000000000000000000000000000a7a58c0be72be218b41c608b7fe7c5bb630736c713078414100000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006，由于abi.encodePacked对编码进行了压缩，长度比abi.encode短很多。
    }

    function abiEncodeWithSignature(address _addr, uint256 _x)
        external
        returns (uint256)
    {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setX(uint256)", _x)
        );

        require(success);

        uint256 result = abi.decode(data, (uint256));

        return result;
    }

    function abiEncodeWithSelector(address _addr, uint256 _x)
        external
        returns (uint256)
    {
        // bytes4 selector = bytes4(keccak256("setX(uint256)"));
        bytes4 selector = B.setX.selector;

        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSelector(selector, _x)
        );

        require(success);

        uint256 result = abi.decode(data, (uint256));

        return result;
    }

}

contract B {
    uint256 public x;

    function setX(uint256 _x) external returns (uint256) {
        x = _x;
        return x + 1;
    }
}
