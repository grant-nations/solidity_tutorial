//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUSD = 50 * 1e18;
    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        // Want to be able to se a minimum fund amount in USD
        // 1. How to send ETH to this contract?
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough"); // 1 * 10^18 wei
        // revert undoes any previous action and returns gas that would have been used after the revert.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }



    // function withdraw(){}
}