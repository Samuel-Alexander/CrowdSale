pragma solidity ^0.5.0;

import "./NewCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// Inherit the crowdsale contracts
contract NewCoinSale is Crowdsale, MintedCrowdsale {

    constructor(
        // Fill in the constructor parameters!
        uint rate, 
        address payable wallet, 
        NewCoin token
    )
        // Pass the constructor parameters to the crowdsale contracts.
        NewCoinSale(rate,wallet,token)
        public
    {
        // constructor can stay empty
    }
}

contract NewCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;

    constructor(
        // Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet // this address will receive all Ether raised by the sale
    )
        public
    {
        // Create the NewCoin and keep its address handy
        NewCoin token = new NewCoin(name, symbol,0);
        token_address = address(token);
        
        // Create the PewCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        NewCoinSale newcoin_sale = new NewCoinSale(1, wallet, token);
        token_sale_address_address = address(newcoin_sale);
        
        // make the NewCoinSale contract a minter, then have the NewCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
