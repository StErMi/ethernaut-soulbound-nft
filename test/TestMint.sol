// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "./BaseTest.sol";
import "forge-std/console.sol";

/// @title Test for Ownership
contract TestMint is BaseTest {

    // emulete the event model just for testing
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function setUp() public override {
        super.setUp();
    }

    /// @notice Only minter role can mint
    function testUniqueMint() public {
        vm.startPrank(alice);

        // mint an NFT
        expNFT.mint();

        // try to mint again and fail
        vm.expectRevert(EthernautExp.Unique.selector);
        expNFT.mint();

        vm.stopPrank();
    }

    /// @notice Mint successful
    function testMint() public {
        uint256 totalSupplyBefore = expNFT.totalSupply();
        uint256 userBalanceBefore = expNFT.balanceOf(alice);
        
        vm.prank(alice);
        vm.expectEmit(true, true, true, false);
        emit Transfer(address(0), alice, totalSupplyBefore);
        uint256 tokenId = expNFT.mint();

        assertEq(tokenId, totalSupplyBefore);
        assertEq(expNFT.ownerOf(tokenId), alice);
        assertEq(expNFT.balanceOf(alice), userBalanceBefore + 1);
        assertEq(expNFT.totalSupply(), totalSupplyBefore + 1);
    }

    /// @notice Mint successful
    function testTokenURI() public {
        vm.prank(alice);
        uint256 tokenId = expNFT.mint();

        string memory tokenUri = expNFT.tokenURI(tokenId);
        console.log('tokenUri ->', tokenUri);
    }


}
