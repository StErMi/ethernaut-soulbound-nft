// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


interface IEthernautExp {

    /// @notice Mint a new EthernautExp NFT
    /// @return The token ID of the minted NFT
    function mint() external returns (uint256);
}
