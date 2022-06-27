// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

import "./ZombieHelper.sol";
import "./safemath.sol";

contract ZombieBattle is ZombieHelper {
    using SafeMath for uint256;

    uint256 randNonce = 0;
    uint256 attackVictoryProbability = 70;

    function randMod(uint256 _modulus) internal view returns (uint256) {
        randNonce.add(1);
        uint256 time = uint256(keccak256(abi.encodePacked((block.timestamp))));
        uint256 sender = uint256(keccak256(abi.encodePacked((msg.sender))));
        uint256 rand = uint256(keccak256(abi.encodePacked(randNonce)));
        uint256 random = (time + sender + rand) % _modulus;
        return random % _modulus;
    }

    function attack(uint256 _zombieId, uint256 _targetId)
        external
        ownerOf(_zombieId)
    {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint256 rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount++;
            myZombie.level++;
            enemyZombie.lossCount++;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount++;
            enemyZombie.winCount++;
            feedAndMultiply(_targetId, myZombie.dna, "zombie");
        }
        _triggerCooldown(myZombie);
    }
}
