// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./BestExp.sol";

/// @title Test for Ownership
contract TestSoulbound is BestExp {

    uint256 tokenId;

    function setUp() public override {
        super.setUp();
        
        vm.prank(owner);
        exp.setApprovedMinter(minter);

        vm.prank(minter);
        tokenId = exp.mint(user);
    }

    

    /// @notice Token is Soulbound, cannot call transferFrom
    function testCannotTransferFrom() public {
        vm.expectRevert(Exp.Soulbound.selector);
        exp.transferFrom(user, minter, tokenId);
    }

    /// @notice Token is Soulbound, cannot call safeTransferFrom
    function testCannotSafeTransferFrom() public {
        vm.expectRevert(Exp.Soulbound.selector);
        exp.safeTransferFrom(user, minter, tokenId);
    }


}
