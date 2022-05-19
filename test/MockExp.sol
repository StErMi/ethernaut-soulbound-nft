// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Mock Exp
contract MockExp is ERC20 {

    /*//////////////////////////////////////////////////////////////
                                 CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() ERC20("EXP", "EXP") {}

    /*//////////////////////////////////////////////////////////////
                                 PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Mint EXP tokens and send them to `to` user
    /// @dev only minter can call this method
    /// @param to The receiver of the minted tokens
    /// @param amount The amount of exp to be minted
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}