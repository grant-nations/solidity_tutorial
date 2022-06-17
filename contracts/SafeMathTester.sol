//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0; //note: in >= v0.7.6, overflow is checked.

contract SafeMathTester{
    uint8 public bigNumber = 255;

    function add() public {
        bigNumber++;
    }
}