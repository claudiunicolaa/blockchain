pragma solidity ^0.4.19;

/**
 * The Election contract assure the voting process.
 */
contract Election {
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	mapping (uint => Candidate) public candidates;
	mapping (address => bool) voters;
	
	uint public candidatesCount;

	constructor () public  {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}	

	function addCandidate (string name) private {
		candidatesCount++;
		Candidate memory candidate = Candidate(candidatesCount, name, 0);
		candidates[candidatesCount] = candidate;
	}
	
	function vote (uint candidateId) public {
		require (!voters[msg.vote]);
		require (candidateId >0 && candidateId <= candidatesCount);

		voters[msg.sender] = true;

		candidates[candidateId].voteCount ++;
		
	}
	
}
