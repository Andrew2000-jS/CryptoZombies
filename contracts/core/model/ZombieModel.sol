// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

contract ZombieModel {
    event NewZombie(uint256 zombieId, string _name, uint256 _dna);

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] internal zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) public ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(Zombie(_name, _dna));
        uint256 id = zombies.length - 1;

        ownerZombieCount[msg.sender]++;
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

    uint256 internal dnaModulus = 10**16;

    function _feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _newName
    ) internal {
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie(_newName, newDna);
    }
}
