var PowerGrid = artifacts.require('./PowerGrid');

contract('PowerGrid', function (accounts) {
  it('initalizes the energy count with zero', () => {
    return PowerGrid.deployed().then((instance) => {
      return instance.energyCount();
    }).then(function (count) {
      assert.equal(count, 0);
    });
  });

  it('put energy into power grid', () => {
    let powerGridInstance;

    return PowerGrid.deployed().then((instance) => {
      powerGridInstance = instance;

      instance.putEnergy(10, {
        from: accounts[1]
      });

      return instance.getBalance.call((accounts[1]));
    }).then(balance => {
      assert.equal(balance.valueOf(), 40);

      return powerGridInstance.energyCount()
    }).then(count => {
      assert.equal(count, 10);
    }).then(() => { // second time
      powerGridInstance.putEnergy(5, {
        from: accounts[1]
      });

      return powerGridInstance.getBalance.call((accounts[1]));
    }).then(balance => {
      assert.equal(balance.valueOf(), 60);

      return powerGridInstance.energyCount()
    }).then(count => {
      assert.equal(count, 15);
    });
  });

  it('retrieve energy from power grid', () => {
    return PowerGrid.deployed().then((instance) => {
      instance.putEnergy(20, {
        from: accounts[2]
      })

      instance.retrieveEnergy(10, {
        from: accounts[2]
      })
    });
  });

});