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
    }
    //Create new User Account
    function createAccount(string memory _account)public returns(string memory,address){
        portfolioContractAddress = address(new Portfolio(portfolioTokenURI,_account));
        ledger[_account] = Ledger(_account,totalAccounts,portfolioContractAddress,true);
        numbLedger[totalAccounts] = numberLedger(_account,portfolioContractAddress);
        totalAccounts++;
        return ("new account created", portfolioContractAddress);
    }
    //check and view new user Account
    function checkAccount(string memory _account,uint accountNumber)public returns(string memory,address,bool){
        if(ledger[_account].exist = true){
            return (ledger[_account].account,ledger[_account].portfolio,ledger[_account].exist);
        }else{
            return ("none",0x0000000000000000000000000000000000000000,false);
        }
    }
}


contract Portfolio is ERC1155{
    uint public handlerToken;
    address public marketplace;
    string public accountName;
    
    constructor(string memory _URI,string memory _name) ERC1155(_URI) {
        handlerToken = uint(keccak256(abi.encodePacked(_URI)));
        _mint(msg.sender,handlerToken,1, "");
        accountName = _name;
    }
    modifier broker{
        //require(balanceOf(msg.sender,handlerToken) <= 1, "broker does not hold handler token");
        _;
    }
    modifier handler{
        require(balanceOf(msg.sender,handlerToken) <= 1, "user does not hold handler token");
        _;
    }

    function BrokerageAdmin()public returns(bool){}

    function createList() public view returns(uint){}
    function buyListToken() public view returns(uint){}
    function cancelList() public view returns(uint){}
    function transfer() public view returns(uint){}
    function makeOffer() public view returns(uint){}
    function acceptOffer() public view returns(uint){}
    function cancelOffer() public view returns(uint){}
    function depositEscrow() public view returns(uint){}
    function withdrawEscrow() public view returns(uint){}
    function createAuction() public view returns(uint){}
    function placeBid() public view returns(uint){}
    function cancelAuction() public view returns(uint){}
    function claimAuction() public view returns(uint){}
}