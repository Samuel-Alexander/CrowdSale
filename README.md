![what-is-crowdsale-of-cryptocurrency](https://user-images.githubusercontent.com/75221323/121783379-d29b4200-cb73-11eb-882f-5b271456f3ed.jpg)


## Libraries and Dependencies
* [Remix IDE](https://remix.ethereum.org)
* [Ganache](https://www.trufflesuite.com/ganache)
* [MetaMask](https://metamask.io/)
* [OpenZeppelin Solidity Library](https://docs.openzeppelin.com/contracts/4.x/)
* [Kovan Faucet](https://faucet.kovan.network/)


## Summary
This repo contains an executable solidity smart contract designed to facilitate the crowdsale of a unique token for purposes of funding a new network. This contract manages the entire crowdsale process, allowing users to send ETH and get back NEW (NewCoin). This contract mints tokens automatically and distributes them to buyers in one transaction.

Some additional features of the contract include:
* Funding cap of 300 ETH with embedded trigger to refund any purchases in excess of the cap
* Time cap of 24 weeks
* A unique ERC20 token

Implemented OpenZeppelin solidity components include:  `Crowdsale`, `CappedCrowdsale`, `TimedCrowdsale`, `RefundableCrowdsale`, and `MintedCrowdsale`.

Pre-production test of Crowdsale conducted on the Kovan testnet.

## Project Design

### Creating the project



Using Remix, create a file called `NewCoin.sol` and create a standard `ERC20Mintable` token. 

![Screen Shot 2021-06-15 at 4 27 32 PM](https://user-images.githubusercontent.com/75221323/122125980-b78c3480-cdf6-11eb-9fcb-5f48c01585af.png)


Create a new contract named `NewCoinCrowdsale.sol`, and prepare it like a standard crowdsale.

![Screen Shot 2021-06-17 at 5 44 16 PM](https://user-images.githubusercontent.com/75221323/122481125-c2300080-cf93-11eb-9679-892028a87818.png)



### Testing the Crowdsale

The crowdsale can be tested on the local networkl by sending Ether to the crowdsale from a different account (**not** the same account that is raising funds). Once it is confirmed that the crowdsale works as expected, the token may be added to MyCrypto for a test transaction. The time functionality may be tested by replacing `now` with `fakenow`, and creating a setter function to modify `fakenow` to whatever time you want to simulate. You can also set the `close` time to be `now + 5 minutes`, or whatever timeline you'd like to test for a shorter crowdsale.

When sending Ether to the contract, make sure you hit your `goal` that you set, and `finalize` the sale using the `Crowdsale`'s `finalize` function. In order to finalize, `isOpen` must return false (`isOpen` comes from `TimedCrowdsale` which checks to see if the `close` time has passed yet). Since the `goal` is 300 Ether, you may need to send from multiple accounts. If you run out of prefunded accounts in Ganache, you can create a new workspace.

Remember, the refund feature of `RefundablePostDeliveryCrowdsale` only allows for refunds once the crowdsale is closed **and** the goal is met. See the [OpenZeppelin RefundableCrowdsale](https://docs.openzeppelin.com/contracts/2.x/api/crowdsale#RefundableCrowdsale) documentation for details as to why this is logic is used to prevent potential attacks on your token's value.

You can add custom tokens in MyCrypto from the `Add custom token` feature:

![add-custom-token](https://i.imgur.com/p1wwXQ9.png)

You can also do the same for MetaMask. Make sure to purchase higher amounts of tokens in order to see the denomination appear in your wallets as more than a few wei worth.

### Deploying the Crowdsale

Deploy the crowdsale to the Kovan or Ropsten testnet, and store the deployed address for later. Switch MetaMask to your desired network, and use the `Deploy` tab in Remix to deploy your contracts. Take note of the total gas cost, and compare it to how costly it would be in reality. Since you are deploying to a network that you don't have control over, faucets will not likely give out 300 test Ether. You can simply reduce the goal when deploying to a testnet to an amount much smaller, like 10,000 wei.


