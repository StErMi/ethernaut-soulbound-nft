// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./BaseTest.sol";

/// @title Test for Ownership
contract TestSoulbound is BaseTest {

    uint256 tokenId;

    function setUp() public override {
        super.setUp();

        vm.prank(alice);
        tokenId = userExp.mint();
    }

    /// @notice Token is Soulbound, cannot call approve
    function testCannotApprove() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.approve(bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call getApproved
    function testCannotGetApprove() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.getApproved(tokenId);
    }

    /// @notice Token is Soulbound, cannot call setApprovalForAll
    function testCannotSetApprovalForAll() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.setApprovalForAll(bob, true);
    }

    /// @notice Token is Soulbound, cannot call isApprovedForAll
    function testCannoIsApprovedForAll() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.isApprovedForAll(alice, bob);
    }

    /// @notice Token is Soulbound, cannot call transferFrom
    function testCannotTransferFrom() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.transferFrom(alice, bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call safeTransferFrom
    function testCannotSafeTransferFrom() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.safeTransferFrom(alice, bob, tokenId);
    }

    /// @notice Token is Soulbound, cannot call safeTransferFrom
    function testCannotSafeTransferFromWithBytes() public {
        vm.expectRevert(UserExp.Soulbound.selector);
        userExp.safeTransferFrom(alice, bob, tokenId, "");
    }


}
