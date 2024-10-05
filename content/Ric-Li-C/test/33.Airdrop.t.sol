// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Airdrop} from "../src/33.Airdrop.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockToken is IERC20 {
    string public name = "MockToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;

    constructor(uint256 initialSupply) {
        _mint(msg.sender, initialSupply);
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    function _mint(address account, uint256 amount) internal {
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            _balances[sender] >= amount,
            "ERC20: transfer amount exceeds balance"
        );

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}

contract AirdropTest is Test {
    Airdrop public airdrop;
    MockToken public token;
    address public owner = address(0x999);
    address public user1 = address(0x123);
    address public user2 = address(0x456);
    address public user3 = address(0x789);

    function setUp() public {
        vm.startPrank(owner);
        // Deploy MockToken with an initial supply
        token = new MockToken(1000 ether);
        // Deploy Airdrop contract
        airdrop = new Airdrop();

        // Transfer some tokens to the airdrop contract
        // token.transfer(address(airdrop), 1000 ether);
        token.approve(address(airdrop), 1000 ether);
        vm.stopPrank();
    }

    function testMultiTransferTokenSuccess() public {
        address[] memory recipients = new address[](2);
        recipients[0] = user1;
        recipients[1] = user2;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100 ether;
        amounts[1] = 200 ether;

        vm.prank(owner);
        airdrop.multiTransferToken(address(token), recipients, amounts);

        assertEq(token.balanceOf(user1), 100 ether);
        assertEq(token.balanceOf(user2), 200 ether);
    }

    function testMultiTransferToken_InsufficientAllowance() public {
        address[] memory recipients = new address[](1);
        recipients[0] = user3;

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 5000 ether; // This exceeds the allowance

        vm.expectRevert("Need Approve ERC20 token");
        airdrop.multiTransferToken(address(token), recipients, amounts);
    }

    function testMultiTransferETH() public {
        uint ethValue = 1 ether;
        vm.deal(owner, ethValue);

        address payable[] memory recipients = new address payable[](2);
        recipients[0] = payable(user1);
        recipients[1] = payable(user2);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 0.5 ether;
        amounts[1] = 0.5 ether;

        vm.prank(owner);
        airdrop.multiTransferETH{value: ethValue}(recipients, amounts);

        assertEq(user1.balance, 0.5 ether);
        assertEq(user2.balance, 0.5 ether);
    }

    function testMultiTransferETH_InsufficientETH() public {
        uint ethValue = 1 ether;
        vm.deal(owner, ethValue);

        address payable[] memory recipients = new address payable[](2);
        recipients[0] = payable(user1);
        recipients[1] = payable(user2);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 0.5 ether;
        amounts[1] = 10 ether; // This will fail

        vm.prank(owner);
        vm.expectRevert("Transfer amount error");
        airdrop.multiTransferETH{value: ethValue}(recipients, amounts);
    }

    function testMultiTransferETH_UnsuccessfulTransfer() public {
        uint ethValue = 10.5 ether;
        vm.deal(owner, ethValue);

        // Deploy a new RefusingEther contract
        RefusingEther re = new RefusingEther();

        address payable[] memory recipients = new address payable[](2);
        recipients[0] = payable(user1);
        recipients[1] = payable(address(re));

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 0.5 ether;
        amounts[1] = 10 ether; // This will fail

        vm.prank(owner);
        airdrop.multiTransferETH{value: ethValue}(recipients, amounts);

        // Check that the failed transfer is recorded
        assertEq(airdrop.failTransferList(address(re)), 10 ether);
    }

    // `testFail` is keyword, while `test...Fail` is OK
    function testWithdrawFromFailList() public {
        uint ethValue = 10.5 ether;
        vm.deal(owner, ethValue);

        address payable[] memory recipients = new address payable[](1);
        recipients[0] = payable(user1);

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 0.5 ether;

        vm.prank(owner);
        airdrop.multiTransferETH{value: amounts[0]}(recipients, amounts);

        // Deploy a new ConditionalEtherReceiver contract
        ConditionalEtherReceiver cer = new ConditionalEtherReceiver(airdrop);

        // Add a failed transfer for ConditionalEtherReceiver contract
        address payable[] memory recipientsFail = new address payable[](1);
        recipientsFail[0] = payable(address(cer));
        uint256[] memory amountsFail = new uint256[](1);
        amountsFail[0] = 10 ether; // This will fail

        vm.prank(owner);
        airdrop.multiTransferETH{value: amountsFail[0]}(
            recipientsFail,
            amountsFail
        );

        // Try to withdraw the failed amount
        vm.expectRevert("Fail withdraw");
        cer.withdrawFromFailList();

        // Enable ether reception
        cer.enableEtherReception();
        cer.withdrawFromFailList();

        assertEq(address(cer).balance, 10 ether);
    }
}

contract RefusingEther {
    // This function is called when the contract receives Ether without any data
    receive() external payable {
        revert("This contract does not accept Ether");
    }

    // This function is called when the contract receives Ether with data
    fallback() external payable {
        revert("This contract does not accept Ether");
    }
}

contract ConditionalEtherReceiver {
    Airdrop airdrop;
    bool private isAcceptingEther;

    constructor(Airdrop _airdrop) {
        airdrop = _airdrop;
    }

    function withdrawFromFailList() public {
        airdrop.withdrawFromFailList();
    }

    function enableEtherReception() public {
        isAcceptingEther = true;
    }

    // This function is called when the contract receives Ether without any data
    receive() external payable {
        if (!isAcceptingEther) {
            revert("This contract does not accept Ether");
        }
    }

    // This function is called when the contract receives Ether with data
    fallback() external payable {
        if (!isAcceptingEther) {
            revert("This contract does not accept Ether");
        }
    }
}
