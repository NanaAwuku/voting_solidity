// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    struct Voter {
        bool hasVoted;
        uint votedCandidateId;
    }

    mapping(address => Voter) public voters;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;

    constructor() {
        candidatesCount = 0;
    }

    function addCandidate(string memory _name) public {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function removeCandidate(uint _candidateId) public {
        delete candidates[_candidateId];
    }

    function getAllCandidates() public view returns(Candidate[] memory) {
        Candidate[] memory _candidates = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            _candidates[i-1] = candidates[i];
        }
        return _candidates;
    }

    function castVote(uint _candidateId) public {
        require(!voters[msg.sender].hasVoted, "This voter has already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate to vote for.");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedCandidateId = _candidateId;

        candidates[_candidateId].voteCount ++;
    }
}
