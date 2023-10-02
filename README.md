# proveable random raffle contract

## about
this code makes a provable random smart lottery. this will basically be a lottery where the winner is chosen randomly.

## what do we want to do ?

1. users can enter by paying a ticket fee
   1. the ticket fee will be given to the winner of the lottery
2. after x period of time the lottery will choose a winner
   1. this will be done programmatically 
3. using the Chainlink VRF(verifiable random function) we will get a random number & the chainlink automation 
   1. Chainlink VRF =>choose the winner randomly 
   2. Chainlink Automation => time based trigger 