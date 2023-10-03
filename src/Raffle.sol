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

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

/**
 * @title a sample Raffle contract
 * @author mohit
 * @notice this contract is for creating a raffle
 * @dev implements the ChainLink VRFv2
 */
contract Raffle {
    error Raffle__NotEnoughEthSent(); //add the name of the contract before the name of the error
    error TimeIntervalNotPassed();

    uint256 private immutable i_entranceFee; // we use the i_ prefix for immutable variables
    address payable[] private s_players;
    //@dev duration of the lottery in seconds
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;   //written in caps to indicate that it is a constant
    uint32 private immutable i_callbackGasLimit;
    uint32 private constant NUM_WORDS = 1;
    /**
     * Events
     */
    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee, uint256 interval, address vrfCoordinator,bytes32 gasLane,uint64 subscriptionId,uint32 callbackGasLimit) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
    }

    function enterRaffle() public payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        //now a good practice is to emit an event whenever we update the state of the contract
        //1. it makes migration easier
        //2. makes the front-end indexing easier.

        emit EnteredRaffle(msg.sender);
    }

    //1. get a random number
    //2. use that random number to pick a winner
    //3. be automatically called
    function pickWinner() public {
        //check to see if the time has passed
        if (block.timestamp - s_lastTimeStamp < i_interval) {
            revert ();
        }
        // s_lastTimeStamp = block.timestamp;
        //requesting a random number is two steps process
        //1. request a RNG(random number generator) from the chainlink VRF
        //2. get the random number
     uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, //gasLane
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    /**
     * Getter Function
     */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
