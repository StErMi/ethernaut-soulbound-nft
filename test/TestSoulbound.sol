// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./BaseTest.sol";

/// @title Test for Ownership
contract TestSoulbound is BaseTest {

    uint256 tokenId;

    function setUp() public override {
        super.setUp();

        vm.prank(alice);
        tokenId = expNFT.mint();
    }

    /// @notice Token is Soulbound, cannot call approve
    function testCannotApprove() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.approve(bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call getApproved
    function testCannotGetApprove() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.getApproved(tokenId);
    }

    /// @notice Token is Soulbound, cannot call setApprovalForAll
    function testCannotSetApprovalForAll() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.setApprovalForAll(bob, true);
    }

    /// @notice Token is Soulbound, cannot call isApprovedForAll
    function testCannoIsApprovedForAll() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.isApprovedForAll(alice, bob);
    }

    /// @notice Token is Soulbound, cannot call transferFrom
    function testCannotTransferFrom() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.transferFrom(alice, bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call safeTransferFrom
    function testCannotSafeTransferFrom() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.safeTransferFrom(alice, bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call safeTransferFrom
    function testCannotSafeTransferFromWithBytes() public {
        vm.expectRevert(EthernautExp.Soulbound.selector);
        expNFT.safeTransferFrom(alice, bob, tokenId, "");
    }


}
