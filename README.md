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

Inherited OpenZeppelin solidity components include:  `Crowdsale`, `CappedCrowdsale`, `TimedCrowdsale`, `RefundableCrowdsale`, and `MintedCrowdsale`.

Pre-production test of Crowdsale conducted on the Kovan testnet.

## Project Design

### Creating the project



Using Remix, create a file called `NewCoin.sol` and create a standard `ERC20Mintable` token. 

![Screen Shot 2021-06-15 at 4 27 32 PM](https://user-images.githubusercontent.com/75221323/122125980-b78c3480-cdf6-11eb-9fcb-5f48c01585af.png)


Create a new contract named `NewCoinCrowdsale.sol`, and prepare it like a standard crowdsale.

![Screen Shot 2021-06-17 at 5 44 16 PM](https://user-images.githubusercontent.com/75221323/122481125-c2300080-cf93-11eb-9679-892028a87818.png)



### Deploying the Crowdsale

1. Begin by connecting to a test network such as Kovan or Ropsten

<img width="357" alt="Screen Shot 2021-06-18 at 10 38 40 AM" src="https://user-images.githubusercontent.com/75221323/122585699-63b16380-d021-11eb-9a5e-fa1e15a729ab.png">

2. As needed, you may fund your wallet using a test faucet. 

<img width="783" alt="Screen Shot 2021-06-18 at 10 39 53 AM" src="https://user-images.githubusercontent.com/75221323/122585820-893e6d00-d021-11eb-9c10-ac84fd92ec7a.png">


3. Compile NewCoinCrowdsale.sol and deploy NewCoinSaleDeployer from the contract dropdown menu.

<img width="195" alt="Screen Shot 2021-06-18 at 10 41 17 AM" src="https://user-images.githubusercontent.com/75221323/122586010-bee35600-d021-11eb-83a6-a10bdb30691c.png">

<img width="345" alt="Screen Shot 2021-06-18 at 10 42 20 AM" src="https://user-images.githubusercontent.com/75221323/122586142-e508f600-d021-11eb-94e0-04a3141d782c.png">


4. In the Deploy dropdown, set name to "NewCoin", symbol to "NEW", and wallet as the address of your Metamask. THe goal should be set to 300 ETH, but for testing purposes, it may make sense to reduce the goal to ensure there is sufficient test ETH available in your wallet(s).

<img width="208" alt="Screen Shot 2021-06-18 at 10 44 40 AM" src="https://user-images.githubusercontent.com/75221323/122586381-387b4400-d022-11eb-9fbe-eb8f1f0cee90.png">


5. Hit Transact and then Confirm when prompted by Metamask.

<img width="356" alt="Screen Shot 2021-06-18 at 10 47 11 AM" src="https://user-images.githubusercontent.com/75221323/122586666-8f811900-d022-11eb-991b-5cbcaecbe053.png">


6. Under Deployed Contracts, note the token_address and token_sale_address. These will be needed to deploy the NewCoin and NewCoinSale contracts.

<img width="195" alt="Screen Shot 2021-06-18 at 10 48 15 AM" src="https://user-images.githubusercontent.com/75221323/122586791-b50e2280-d022-11eb-8afa-e681ca9ecd28.png">

7. Select the NewCoin from the contract dropdown menu and paste the token address to At Address field then click the At Address button.

<img width="205" alt="Screen Shot 2021-06-18 at 10 51 10 AM" src="https://user-images.githubusercontent.com/75221323/122587163-1e8e3100-d023-11eb-998a-eae1af080d07.png">

8. Copy the token_sale_address from the PupperCoinSaleDeployer deployed contract and switch the contract to PupperCoinSale then paste the token_sale_address into the AT Address field and click At Address button.
<img width="207" alt="Screen Shot 2021-06-18 at 10 56 34 AM" src="https://user-images.githubusercontent.com/75221323/122587799-e0ddd800-d023-11eb-95ef-a9ffee0034fe.png">


All contracts should now be deployed:
<img width="201" alt="Screen Shot 2021-06-18 at 10 57 24 AM" src="https://user-images.githubusercontent.com/75221323/122587872-fc48e300-d023-11eb-8d9a-b62908629972.png">


9. Open Ganache and copy down the address of the wallet that you wish to fund. Note: this should be a different address than the one you used for the NewCoinSaleDeployer contract. 
<img width="689" alt="Screen Shot 2021-06-18 at 10 54 31 AM" src="https://user-images.githubusercontent.com/75221323/122587615-a8d69500-d023-11eb-8a17-44dde4b07932.png">

10. Under Deployed Contracts, expand the NewCoinSale contract and enter an address from Ganache as the beneficiary under buyTokens. Change to desired value and transact.

<img width="201" alt="Screen Shot 2021-06-18 at 10 58 45 AM" src="https://user-images.githubusercontent.com/75221323/122588011-2e5a4500-d024-11eb-8d4b-a56808f3e26e.png">


A successful transaction will be recorded on the blockchain:
<img width="994" alt="Screen Shot 2021-06-18 at 11 03 00 AM" src="https://user-images.githubusercontent.com/75221323/122588489-c9531f00-d024-11eb-9b15-ce0bca8d2c6b.png">


<img width="352" alt="Screen Shot 2021-06-18 at 11 04 03 AM" src="https://user-images.githubusercontent.com/75221323/122588628-ec7dce80-d024-11eb-9d21-7aac1f4368f0.png">


### Additional Notes:
* Once it is confirmed that the crowdsale works as expected, the token may be added to MyCrypto for a test transaction. 
* The time functionality may be tested by replacing `now` with `fakenow`, and creating a setter function to modify `fakenow` to whatever time you want to simulate. You can also set the `close` time to be `now + 5 minutes`, or whatever timeline you'd like to test for a shorter crowdsale.
* When sending Ether to the contract, make sure you hit your `goal` that you set, and `finalize` the sale using the `Crowdsale`'s `finalize` function. In order to finalize, `isOpen` must return false (`isOpen` comes from `TimedCrowdsale` which checks to see if the `close` time has passed yet). Since the `goal` is 300 Ether, you may need to send from multiple accounts. If you run out of prefunded accounts in Ganache, you can create a new workspace.
* Remember, the refund feature of `RefundablePostDeliveryCrowdsale` only allows for refunds once the crowdsale is closed **and** the goal is met. See the [OpenZeppelin RefundableCrowdsale](https://docs.openzeppelin.com/contracts/2.x/api/crowdsale#RefundableCrowdsale) documentation for details as to why this is logic is used to prevent potential attacks on your token's value.
* You can add custom tokens in MyCrypto from the `Add custom token` feature:
![add-custom-token](https://i.imgur.com/p1wwXQ9.png)
* You can also do the same for MetaMask. Make sure to purchase higher amounts of tokens in order to see the denomination appear in your wallets as more than a few wei worth.
