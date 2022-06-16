// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    uint256 public num;

    People[] public people;

    struct People {
        uint256 num;
        string name;
    }

    function addPerson(string memory _name, uint256 _num) public {
        people.push(People(_num, _name));
    }


    function store(uint256 _num) public {
        num = _num;
    }

    // "view" and "pure" functions don't spend any gas unless they are called within a function that costs gas
    //   "view" doesn't change blockchain state
    //   "pure" prevents reading any value from the contract (does not depend on contract state)

    // "returns" specifies the return type
    function retrieve() public view returns(uint256){
        return num;
    }
}
