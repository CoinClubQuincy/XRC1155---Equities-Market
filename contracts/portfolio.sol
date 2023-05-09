//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./marketplace.sol";

contract portfolioLedger{
    string portfolioTokenURI;   //URI formart for users
    address marketplaceAddress; //address of marketplace Contract

    address public portfolioContractAddress;
    uint totalAccounts = 0;
    
    constructor(uint _totalHandlers,string memory _URI){
        portfolioTokenURI = _URI;
        marketplaceAddress = address(new Marketplace(_totalHandlers,_URI));
        totalAccounts++;
    }
    mapping(string => Ledger) ledger;
    mapping(uint => numberLedger) numbLedger;
    struct Ledger{
        string account;
        uint accountNumber;
        address portfolio;
        bool exist;
    }
    struct numberLedger{
        string account;
        address portfolio;  
        bool exist; 
    }
    //Create new User Account
    function createAccount(string memory _account)public returns(string memory,address){
        portfolioContractAddress = address(new Portfolio(portfolioTokenURI,_account,address(this),marketplaceAddress));
        ledger[_account] = Ledger(_account,totalAccounts,portfolioContractAddress,true);
        numbLedger[totalAccounts] = numberLedger(_account,portfolioContractAddress,true);
        totalAccounts++;
        return ("new account created", portfolioContractAddress);
    }
    //check and view new user Account
    function checkAccount(string memory _account,uint accountNumber)public returns(string memory,address,bool){
        if(ledger[_account].exist = true || numbLedger[accountNumber].exist){
            return (ledger[_account].account,ledger[_account].portfolio,ledger[_account].exist);
        }else{
            return ("none",0x0000000000000000000000000000000000000000,false);
        }
    }
    //forward funds from one user name to another
    function forwardFunds(string memory _reciver)public payable returns(bool){
        string memory account_;
        address portfolio_;
        bool exist_;
        (account_, portfolio_, exist_) = checkAccount(_reciver,0);
        require(exist_ == true, "User does not exist");
        payable(portfolio_).transfer(msg.value);
        return true;
    }
}

contract Portfolio is ERC1155{
    uint public handlerToken;
    string public accountName;

    Marketplace public marketplace;
    portfolioLedger public DAppLedger;

    constructor(string memory _URI,string memory _name,address _DAppLedger,address _marketplace) ERC1155(_URI) {
        handlerToken = uint(keccak256(abi.encodePacked(_URI)));
        _mint(msg.sender,handlerToken,1, "");

        accountName = _name;
        DAppLedger = portfolioLedger(_DAppLedger);
        marketplace = Marketplace(_marketplace);
    }
    modifier broker{
        require(marketplace.balanceOf(msg.sender,marketplace.handlerToken()) <= 1, "broker does not hold handler token");
        _;
    }
    modifier handler{
        require(balanceOf(msg.sender,handlerToken) <= 1, "user does not hold handler token");
        _;
    }

    function BrokerageAdmin(address _user)public returns(bool){
        //remove token from users address to a new address
    }
    function sendFunds(string memory _reciver)public handler returns(bool){
        // bool success = payable(portfolioLedgerAddress).transfer{value: msg.value}(
        //     abi.encodeWithSignature("forwardFunds(string)", _reciver)
        // );
        // return success;
    }

    function createList() public view handler returns(uint){}
    function buyListToken() public view handler returns(uint){}
    function cancelList() public view handler returns(uint){}
    function transfer() public view handler returns(uint){}
    function makeOffer() public view handler returns(uint){}
    function acceptOffer() public view handler returns(uint){}
    function cancelOffer() public view handler returns(uint){}
    function depositEscrow() public view handler returns(uint){}
    function withdrawEscrow() public view handler returns(uint){}
    function createAuction() public view handler returns(uint){}
    function placeBid() public view handler returns(uint){}
    function cancelAuction() public view handler returns(uint){}
    function claimAuction() public view handler returns(uint){}
}