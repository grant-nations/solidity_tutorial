//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUSD = 50 * 1e18;
    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{
        // Want to be able to se a minimum fund amount in USD
        // 1. How to send ETH to this contract?
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough"); // 1 * 10^18 wei
        // revert undoes any previous action and returns gas that would have been used after the revert.
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner{

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // Three different ways to send ETH

        // // transfer:
        // payable(msg.sender).transfer(address(this).balance);

        // // send:
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call:
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not owner");
        _; // <-- means do the rest of the code that this modifier is applied to
    }
}