// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/EthernautExp.sol";
import "./MockExp.sol";
import "./Utilities.sol";

contract BaseTest is Test {
    MockExp exp;
    EthernautExp expNFT;
    Utilities utilities;

    address alice;
    address bob;

    function setUp() public virtual {
        utilities = new Utilities();

        address payable[] memory users = utilities.createUsers(2);
        alice = users[0];
        bob = users[1];

        exp = new MockExp();
        expNFT = new EthernautExp(exp);

        // mint 10 exp to Alice
        exp.mint(alice, 10);

        assertEq(exp.balanceOf(alice), 10);
    }
}