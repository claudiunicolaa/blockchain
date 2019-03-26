App = {
  web3Provider: null,
  contracts: {},

  init: function () {
    return App.initWeb3();
  },

  initWeb3: function () {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function () {
    $.getJSON('PowerGrid.json', function (data) {
      var PowerGridArtifact = data;

      App.contracts.PowerGrid = TruffleContract(PowerGridArtifact);
      App.contracts.PowerGrid.setProvider(App.web3Provider);

      App.loadAccount();
      App.setUnits();
    });
  },

  loadAccount: () => {
    web3.eth.getCoinbase((err, account) => {
      if (err === null) {
        App.account = account;
        $("#accountAddress").html("Your Account: " + account);

        App.contracts.PowerGrid.deployed().then((instance) => {
          return instance.getBalance(account);
        }).then((balance) => {
          $("#accountBalance").html("Your Balance: " + balance + " tokens");
        }).catch((err) => {
          console.log(err.message);
        });
      }
    });
  },

  setUnits: () => {
    App.contracts.PowerGrid.deployed().then((instance) => {
      return instance.energyCount();
    }).then((count) => {
      $('#energyUnits').html(count + " Units");
    }).catch((err) => {
      console.log(err.message);
    });
  },

  put: () => {
    let amount = $('#putAmount').val();
    App.contracts.PowerGrid.deployed().then((instance) => {
      instance.putEnergy(amount, {
        from: App.account
      });
      App.loadAccount();
      App.setUnits();
    }).catch((err) => {
      console.log(err.message);
    });
  },

  retrieve: () => {
    let amount = $('#retrieveAmount').val();
    App.contracts.PowerGrid.deployed().then((instance) => {
      return instance.retrieveEnergy(amount, {
        from: App.account
      });
    }).then(() => {
      App.loadAccount();
      App.setUnits();
      App.hideErrDiv('errorRetrieveAmount');
    }).catch((err) => {
      const errMessage = err.message.replace('VM Exception while processing transaction: revert', '');
      App.showErrDiv('errorRetrieveAmount', errMessage);
    });
  },

  showErrDiv: (id, errMessage) => {
    $(`#${id}`).html(errMessage).removeClass("hide").hide().fadeIn("slow");
  },

  hideErrDiv: (id) => {
    $(`#${id}`).addClass("hide").fadeOut("slow");
  }
};

$(function () {
  $(window).load(function () {
    App.init();
  });
});