pragma solidity ^0.5.0;

import "./NewCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


// Smartcontract that manages the entire CrodSale process, minting NEW (NewCoin) tokens and allowing users to exchange ETH and for NEW.


// Inherit the crowdsale contracts
contract NewCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        uint rate, // contract rate in TKNbits >>> 1000000000000000000 TKNbits is equal to 1 TKN
        address payable wallet, // fundraising wallet. All ETH raised in Crowdsale will accrue at this wallet address
        NewCoin token, // define token to be used inside  NewCoinSale
        uint goal, // target number (minumum) tokens to sell. if sales < goal, contract returns ETH to participants
        uint cap, // the maximum number of tokens to be minted
        
    )
        // Pass the constructor parameters to the crowdsale contracts.
        NewCoinSale (rate,wallet,token)
        CappedCrowdsale (goal)
        TimedCrowdsale (fakenow, fakenow + 1 minutes) // test
        // TimedCrowdsale (now, now + 24 weeks) // production
        RefundablePostDeliveryCrowdsale (goal)
        public
    {
        // constructor can stay empty as logic included in contracts inherited from OpenZeppelin
    }
}

contract NewCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet, // this address will receive all Ether raised by the sale
        uint goal
        //uint fakenow // test
    )
        public
    {
        // Create the NewCoin and keep its address handy
        NewCoin token = new NewCoin(name, symbol,0); // create new token w params name, symbol, initial supply
        token_address = address(token); // fetchs token address
        
        // Create the NewCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        NewCoinSale token_sale = new NewCoinSale(1, wallet, token, goal, cap, fakenow, fakenow + 1 minutes); // test
        // NewCoinSale token_sale = new NewCoinSale(1, wallet, token, goal, cap, now, now + 24 weeks); // production
        token_sale_address_address = address(token_sale);
        
        // make the NewCoinSale contract a minter, then have the NewCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
