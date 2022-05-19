// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./interface/IUserExp.sol";

/// @title Exp nft contract
/// @notice The NFT Token is soulbound
contract UserExp is IUserExp, ERC721, Ownable { 
    using Strings for uint256;

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @notice Total supply of the NFT
    uint256 public totalSupply;

    /// @notice
    address public minter;

    /// @notice
    IERC20 public exp;

    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    /// @notice Error thrown when the exp contract is 0 address
    error InvalidExp();

    /// @notice Error thrown if the user try to access to transfer methods
    error Soulbound();

    /// @notice Error thrown if the user try mint more than one nft
    error Unique();

    /*//////////////////////////////////////////////////////////////
                                 CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(IERC20 _exp) ERC721("UserExp", "UserExp") {
        if( address(_exp) == address(0) ) {
            revert InvalidExp();
        }

        exp = _exp;
    }

    /*//////////////////////////////////////////////////////////////
                                 PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Mint a new NFT
    /// @dev user can own only one NFT
    /// @return The token ID of the minted NFT
    function mint() external returns (uint256) {
        if( balanceOf(msg.sender) != 0 ) {
            revert Unique();
        }

        uint256 tokenId = totalSupply;
        _mint(msg.sender, tokenId);
        totalSupply = totalSupply + 1;
        return tokenId;

    }


    /// @notice Draw the SVG of the exp of an user
    /// @param tokenId ID of the user NFT
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        address owner = ownerOf(tokenId);
        uint256 expBalance = exp.balanceOf(owner);

        string[3] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 800 600"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text transform="matrix(1 0 0 1 0 0)" font-weight="normal" xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_1" y="308" x="347.52344" stroke-width="0" stroke="#000" fill="#ffffff">Ethernaut EXP</text><text transform="matrix(1 0 0 1 0 0)" xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_2" y="360.5" x="376" stroke-width="0" stroke="#000" fill="#ffffff">';

        parts[1] = expBalance.toString();

        parts[2] = "</text></svg>";

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2]));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Item #',
                        tokenId.toString(),
                        '", "description": "Ethernaut Experience in the Web3 world.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(output)),
                        '"}'
                    )
                )
            )
        );
        output = string(abi.encodePacked("data:application/json;base64,", json));

        return output;
    }    
    
    /*//////////////////////////////////////////////////////////////
                                 ERC721 OVERRIDE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    
    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function approve(address to, uint256 tokenId) public pure override {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function getApproved(uint256 tokenId) public pure override returns (address) {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function setApprovalForAll(address operator, bool approved) public pure override {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function isApprovedForAll(address owner, address operator) public pure override returns (bool) {
        revert Soulbound(); 
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public pure override {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public pure override {
        revert Soulbound();
    }

    /// @notice Overridden to be soulbound, tokens cannot be transferred
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public pure override {
        revert Soulbound();
    }
}
