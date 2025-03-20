// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePasswordManager {
    struct Credential {
        string username;
        string encryptedPassword;
    }

    mapping(address => Credential[]) private userCredentials;

    event CredentialAdded(address indexed user, string username);
    event CredentialUpdated(address indexed user, string username);
    event CredentialDeleted(address indexed user, string username);

    function addCredential(string memory _username, string memory _encryptedPassword) public {
        userCredentials[msg.sender].push(Credential(_username, _encryptedPassword));
        emit CredentialAdded(msg.sender, _username);
    }

    function updateCredential(uint index, string memory _username, string memory _encryptedPassword) public {
        require(index < userCredentials[msg.sender].length, "Invalid index");
        userCredentials[msg.sender][index] = Credential(_username, _encryptedPassword);
        emit CredentialUpdated(msg.sender, _username);
    }

    function deleteCredential(uint index) public {
        require(index < userCredentials[msg.sender].length, "Invalid index");
        string memory username = userCredentials[msg.sender][index].username;
        
        // Remove credential by swapping with the last element and popping it
        userCredentials[msg.sender][index] = userCredentials[msg.sender][userCredentials[msg.sender].length - 1];
        userCredentials[msg.sender].pop();
        
        emit CredentialDeleted(msg.sender, username);
    }

    function getCredentials() public view returns (Credential[] memory) {
        return userCredentials[msg.sender];
    }
}
