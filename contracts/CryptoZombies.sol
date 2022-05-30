// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;
import "./model/ZombieModel.sol";

contract CryptoZombies is ZombieModel {
    function generateRandomZombie(string memory _name) public {
        uint256 dna = _generateRandomDna(_name);
        _createZombie(_name, dna);
    }

    function showZombies(uint256 index) public view returns (Zombie memory) {
        Zombie memory zombie = zombies[index];
        return zombie;
    }
}
