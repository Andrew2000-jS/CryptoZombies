// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

contract ZombieModel {
    event NewZombie(uint256 zombieId, string _name, uint256 _dna);

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] internal zombies;

    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(Zombie(_name, _dna));
        uint256 id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        internal
        pure
        returns (uint256)
    {
        // generate a random number
        bytes memory newByte = bytes(_str);
        uint256 element = uint256(keccak256(newByte));

        return element;
    }
}
