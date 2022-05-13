// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


interface IExp {

    // PUBLIC FUNCTION

    function setApprovedMinter(address newMinter) external;

    /// @notice Mint a new EXP NFT
    /// @param to Address that will receive the NFT
    /// @return The token ID of the minted NFT
    function mint(address to) external returns (uint256);
}
