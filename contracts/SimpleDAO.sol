// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDAO {
    struct Proposal {
        string description;
        uint256 voteYes;
        uint256 voteNo;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public isMember;

    constructor(address[] memory members) {
        for (uint256 i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    modifier onlyMember() {
        require(isMember[msg.sender], "Not a DAO member");
        _;
    }

    function createProposal(string calldata desc) external onlyMember {
        proposals.push(Proposal(desc, 0, 0, false));
    }

    function vote(uint256 index, bool support) external onlyMember {
        Proposal storage prop = proposals[index];
        require(!prop.executed, "Already executed");

        if (support) prop.voteYes++;
        else prop.voteNo++;
    }

    function execute(uint256 index) external onlyMember {
        Proposal storage prop = proposals[index];
        require(!prop.executed, "Already executed");

        prop.executed = true;
    }
}
