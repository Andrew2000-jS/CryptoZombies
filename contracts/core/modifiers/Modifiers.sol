// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

contract Modifiers {
    address private _onwer;

    constructor() {
        _onwer = msg.sender;
    }

    modifier onlyOnwer(address _addr) {
        require(_addr == _onwer, "Only owner can do this action");
        _;
    }

    modifier onlyOne(uint256 _quantity) {
        require(_quantity == 0, "Can't create more than one zombie");
        _;
    }
}
