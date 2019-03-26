pragma solidity ^0.5 ;

/**
 * The PowerGrid contract specify the interaction of end-user with the power grid.
 * 
 * The smart contract provides the functionality to:
 * 		- put energy into power grid (putEnergy)
 * 		- retrieve energy from power grid (retrieveEnergy).
 *
 * 1 unit of energy represents 4 tokens (see calculateNumberOfTokens method).
 */
contract PowerGrid {
	
	uint public energyCount;
	mapping (address => uint) public balances;

	constructor() public {
		energyCount = 0;
	}
	
	function putEnergy(uint amount) public {
		energyCount += amount;
		balances[msg.sender] += calculateNumberOfTokens(amount);
	}

	function retrieveEnergy(uint amount) public {
		require(energyCount >= amount, 'Amount exceds the energy stored into PowerGrid right now.');
		require(balances[msg.sender] >= calculateNumberOfTokens(amount), 'Amount exceds your current balance.');
		energyCount -= amount;
		balances[msg.sender] -= calculateNumberOfTokens(amount);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}

	function calculateNumberOfTokens(uint amount) internal pure returns (uint) {
		return amount * 4;
	}
}
