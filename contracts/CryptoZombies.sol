// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;
import "./core/model/ZombieModel.sol";
import "./core/modifiers/Modifiers.sol";

contract CryptoZombies is ZombieModel, Modifiers {
    function createRandomZombie(string memory _name)
        public
        onlyOne(ownerZombieCount[msg.sender])
    {
        uint256 dna = _generateRandomDna(_name);
        _createZombie(_name, dna);
    }

    function feeding(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _newName
    ) public onlyOnwer(msg.sender) {
        _feedAndMultiply(_zombieId, _targetDna, _newName);
    }

    function showZombies(uint256 index) public view returns (Zombie memory) {
        Zombie memory zombie = zombies[index];
        return zombie;
    }
}
