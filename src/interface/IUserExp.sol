// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


interface IUserExp {

    /// @notice Mint a new UserExp NFT
    /// @return The token ID of the minted NFT
    function mint() external returns (uint256);
}
