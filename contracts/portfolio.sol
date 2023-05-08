//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";



contract portfolioLedger{}


contract Portfolio is ERC1155{
    
    constructor(string memory _URI) ERC1155(_URI) {

    }

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