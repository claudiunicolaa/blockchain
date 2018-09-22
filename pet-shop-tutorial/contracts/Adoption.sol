pragma solidity ^0.4.24;

/**
 * The Adoption contract specify the adoption process.
 * Into a block can be 16 adopters.
 */
contract Adoption {
	address[16] public adopters;

	function adopt(uint petId) public returns(uint res) {
		
		require (petId >= 0 && petId < 15);
		adopters[petId] = msg.sender;

		return petId;
	}

	function getAdopters() public view returns(address[16])  {
		return adopters;
	}
	
}
