// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./interface/IExp.sol";

/// @title Exp nft contract
/// @notice The NFT Token is soulbound
contract Exp is IExp, ERC721, Ownable { 

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @notice
    address public minter;

    /// @notice Total supply of minted EXP NFT
    uint256 public totalSupply;

    // ERRORS
    error Soulbound();
    error OnlyMinter();
    error EmptyMinter();
    error OldMinterEqualNewMinter();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @notice Emitted when the minter role is updated
    /// @param minter The new minter address
    event MinterUpdated(address indexed minter);

    /*//////////////////////////////////////////////////////////////
                                 MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyMinter() {
        if( msg.sender != minter ) revert OnlyMinter();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                 CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() ERC721("EXP", "EXP") {
        totalSupply = 0;
    }

    /*//////////////////////////////////////////////////////////////
                                 PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Set the new minter user
    /// @dev only owner can call this method
    /// @param newMinter the new minter
    function setApprovedMinter(address newMinter) external onlyOwner {
        // the new minter cannot be a empty
        if( newMinter == address(0) ) revert EmptyMinter();
        // the new minter cannot be the same as the old one (prevent event spam)
        if( newMinter == minter ) revert OldMinterEqualNewMinter();

        minter = newMinter;
        emit MinterUpdated(newMinter);
    }

    /// @notice Mint a new EXP NFT
    /// @dev only minter can call this method
    /// @param to The receiver of th eminted nft
    /// @return The token ID of the minted NFT
    function mint(address to) external override onlyMinter returns (uint256) {
        uint256 tokenId = totalSupply;
        _safeMint(to, tokenId);
        totalSupply = totalSupply + 1;
        return tokenId;

    }
    
    /// @notice Overridden to be soulbound, NFT cannot be transferred
    function transferFrom(
        address,
        address,
        uint256
    ) public override pure {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, NFT cannot be transferred
    function safeTransferFrom(
        address,
        address,
        uint256
    ) public override pure {
        revert Soulbound();
    }
}
