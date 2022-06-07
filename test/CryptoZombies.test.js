const CryptoZombies = artifacts.require("CryptoZombies");

contract("CryptoZombies", () => {
  beforeEach(async () => {
    this.CryptoZombie = await CryptoZombies.deployed();
  });

  it("Should be deployed", async () => {
    const address = await this.CryptoZombie.address;

    assert.notEqual(address, 0x0);
    assert.notEqual(address, null);
    assert.notEqual(address, undefined);
    assert.notEqual(address, "");
  });

  it("Shoud create a zombie and show it", async () => {
    const randomZombie = await this.CryptoZombie.createRandomZombie("Andrew");
    assert.equal(randomZombie.logs.length, 1);
    assert.equal(randomZombie.logs[0].event, "NewZombie");
    assert.equal(randomZombie.logs[0].args._name, "Andrew");

    const zombieToShow = await this.CryptoZombie.showZombies(0);
    assert.equal(zombieToShow.name, "Andrew");
  });

  it("Should feeding and multiply zombie", async () => {
    const feedingAndMultiply = await this.CryptoZombie.feeding(
      0,
      1,
      "New Zombie"
    );
    assert.equal(feedingAndMultiply.logs.length, 1);
    assert.equal(feedingAndMultiply.logs[0].event, "NewZombie");
    assert.equal(feedingAndMultiply.logs[0].args._name, "New Zombie");
  });
});
