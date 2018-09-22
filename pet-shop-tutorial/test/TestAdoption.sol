pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

/**
 * The TestAdoption contract define the tests of Adoption contract.
 */
contract TestAdoption {
	Adoption adoption = Adoption(DeployedAddresses.Adoption());

	function testUserCanAdoptPet() public {
		uint petId = 8;
		uint returnedPetId = adoption.adopt(petId);

		Assert.equal(returnedPetId, petId, "Adoption of pet ID 8 should be recorded");
	}

	function testGetAdopterAddressByPetId() public {
		address expected = this;
		address adopter = adoption.adopters(8);

		Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
	}
	
	function testGetAdopterAddressByPetIdInArray()public {
		address expected = this;
		// attribute memory tells Solidity to temporarily store into the memory.
		address[16] memory adopters = adoption.getAdopters();

		Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
	}
	
}



