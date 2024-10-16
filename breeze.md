---
timezone: Asia/Shanghai
---

---

# Breeze

1. 自我介绍; 
I'm Breeze, a software development engineer specializing in front-end and script development

2. 你认为你会完成本次残酷学习吗？
of course 
   
## Notes

<!-- Content_START -->

### 2024.09.23
I studied lessons 01-03 of the Solidity 101 course from WTF Academy and completed the corresponding tasks
### 2024.09.24
completed lessons 04-06
### 2024.09.26
completed lessons 07-09
### 2024.09.27
completed lessons 10-12
### 2024.09.28
completed lessons 12-15
### 2024.09.29
completed lessons 16-18
### 2024.09.30
completed lessons 19-21
### 2024.10.01
completed lessons 22-24；
### 2024.10.02
completed lessons 25-27；
### 2024.10.05
completed lessons 28-30；

Todo:
- Proxy Contract
- EIP-2535 Diamonds
### 2024.10.06
completed lessons 31-33；

Todo:
- design fintness token by using ERC20

### 2024.10.09
Completed all tasks of Solidity 101 with a score of 100 for each task.

### 2024.10.10
Completed all tasks of Solidity 101 with a score of 100 for each task.

### 2024.10.11
design Tua toekn contract which is follow ERC20, the sourceCode is https://github.com/weifengHuang/fitness-dapp/blob/main/packages/hardhat/contracts/TuaToken.sol

### 2024.10.12

proxy contract:
 - https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies
 - Unstructured Storage Proxies: avoid the Storage collision ; and the proxy contract don't need set the logic proxy variable;


 ```
 pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;
    address public admin;

    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    function upgrade(address newImplementation) external {
        require(msg.sender == admin, "Only admin can upgrade");
        implementation = newImplementation;
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}
 ```

 ```
contract Proxy {
    address private _implementation;
}

contract LogicV1 {
    uint256 private _value;
    // other functions...
}

contract LogicV2 {
    uint256 private _value;
    uint256 private _taxRate; 
    // new variable and function
}
 ```

### 2024.10.13

complete the Todos which are markd in 2024.10.05； 
 - https://eips.ethereum.org/EIPS/eip-2535 
 - proxy contract vs diamond contract
 - diamond contract smart contract code and how get and set storage 

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDiamondCut {
    enum FacetCutAction {Add, Replace, Remove}
    
    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors;
    }

    function diamondCut(
        FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata
    ) external;

    event DiamondCut(FacetCut[] _diamondCut, address _init, bytes _calldata);
}

contract DiamondCutFacet is IDiamondCut {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be contract owner");
        _;
    }

    function diamondCut(
        FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata
    ) external override onlyOwner {
        for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {
            FacetCut memory cut = _diamondCut[facetIndex];
            if (cut.action == FacetCutAction.Add) {
                addFunctions(cut.facetAddress, cut.functionSelectors);
            } else if (cut.action == FacetCutAction.Replace) {
                replaceFunctions(cut.facetAddress, cut.functionSelectors);
            } else if (cut.action == FacetCutAction.Remove) {
                removeFunctions(cut.facetAddress, cut.functionSelectors);
            }
        }

        emit DiamondCut(_diamondCut, _init, _calldata);

        if (_init != address(0)) {
            (bool success, ) = _init.delegatecall(_calldata);
            require(success, "DiamondCut: _init function reverted");
        }
    }

    function addFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        // 实现添加功能的逻辑
    }

    function replaceFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        // 实现替换功能的逻辑
    }

    function removeFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {
        // 实现移除功能的逻辑
    }
}

contract DiamondExample {
    IDiamondCut.FacetCut[] diamondCut;
    function upgradeDiamond(address newFacet) external {
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("newFunction()"));

        diamondCut.push(IDiamondCut.FacetCut({
            facetAddress: newFacet,
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: functionSelectors
        }));

        IDiamondCut(address(this)).diamondCut(diamondCut, address(0), "");

        delete diamondCut;
    }
}

### 2024.10.15
completed lessons 34-35；ERC165，ERC721

```
<!-- Content_END -->
