//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample{
    uint256 public result;

    // don't add "function" to the recieve function.
    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}