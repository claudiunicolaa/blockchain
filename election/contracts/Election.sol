pragma solidity ^0.4.22;

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
    uint public candidatesCount;
    mapping (address => bool) public voters;

    event votedEvent (uint indexed _candidateId);

    constructor () public  {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }	

    function addCandidate (string _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    
    function vote (uint candidateId) public {
        // msg.sender it is a global variable
        require (!voters[msg.sender], "Already voted.");
        // check the candidate exists
        require (candidateId > 0 && candidateId <= candidatesCount, "Candidate not exists");

        // record the vote
        voters[msg.sender] = true;
        // update the candidates vote count
        candidates[candidateId].voteCount ++;

        //trigger event
        emit votedEvent(candidateId);
    }
    
}
