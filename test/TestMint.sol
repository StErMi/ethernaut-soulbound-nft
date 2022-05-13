// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./BestExp.sol";

/// @title Test for Ownership
contract TestMint is BestExp {

    // emulete the event model just for testing
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function setUp() public override {
        super.setUp();
        
        vm.prank(owner);
        exp.setApprovedMinter(minter);
    }

    /// @notice Only minter role can mint
    function testOnlyMinterCanMint() public {
        vm.prank(owner);
        vm.expectRevert(Exp.OnlyMinter.selector);
        exp.mint(user);
    }

    // @notice Mint successful
    function testMint() public {
        uint256 totalSupplyBefore = exp.totalSupply();
        uint256 userBalanceBefore = exp.balanceOf(user);
        
        vm.prank(minter);
        vm.expectEmit(true, true, true, false);
        emit Transfer(address(0), user, totalSupplyBefore);
        uint256 tokenId = exp.mint(user);

        assertEq(tokenId, totalSupplyBefore);
        assertEq(exp.ownerOf(tokenId), user);
        assertEq(exp.balanceOf(user), userBalanceBefore + 1);
        assertEq(exp.totalSupply(), totalSupplyBefore + 1);
    }


}
