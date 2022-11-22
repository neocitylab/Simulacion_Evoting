pragma solidity >=0.4.2 <0.9.0;

contract Election {
    //Model a candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Store Candidates
    // Fetch Candidate
    mapping(uint256 => Candidate) public candidates;

    // Store Candidate Count
    uint256 public candidatesCount;

    // Store accounts which have voted
    mapping(address => bool) public voters;

    // voted event
    event votedEvent(uint256 indexed _candidateId);

    // Constructor
    constructor() public {
        addCandidate("Anya");
        addCandidate("Damian");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        // require that address hasn't voted before
        require(!voters[msg.sender]);

        // require vote only for valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote count
        candidates[_candidateId].voteCount++;

        // trigger vote event
        emit votedEvent(_candidateId);
    }
}
