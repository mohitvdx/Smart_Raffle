// Layout contract elements in the following order:

// Pragma statements
// Import statements
// Interfaces
// Libraries
// Contracts

// Inside each contract, library or interface, use the following order:

// Type declarations
// State variables
// Events
// Errors
// Modifiers
// Functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title a sample Raffle contract
 * @author mohit 
 * @notice this contract is for creating a raffle
 * @dev implements the ChainLink VRFv2
 */ 
contract Raffle{
    error Raffle__NotEnoughEthSent(); //add the name of the contract before the name of the error 


    uint256 private immutable i_entranceFee;// we use the i_ prefix for immutable variables
    address payable[] private s_players;

    constructor(uint256 entranceFee){
        i_entranceFee = entranceFee;
    }
    function enterRaffle() public payable{
        if(msg.value < i_entranceFee){
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        //now a good practice is to emit an event whenever we update the state of the contract
            //1. it makes migration easier
            //2. makes the front-end indexing easier.

    }

    function pickWinner() public {}

    /** Getter Function */
    function getEntranceFee() public view returns(uint256){
        return i_entranceFee;
    }
}