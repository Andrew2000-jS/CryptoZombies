// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;
import "./Ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint256 zombieId, string _name, uint256 _dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;
    uint256 cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] internal zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) public ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(
            Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)
        );
        uint256 id = zombies.length - 1;

        zombieToOwner[id] = msg.sender;
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

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        randDna = randDna - (randDna % 100);
        _createZombie(_name, randDna);
    }
}
