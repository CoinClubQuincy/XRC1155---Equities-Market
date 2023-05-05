// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
//Smart contract
contract Asset is ERC1155 {
    //toal tokens
    uint public totalCoins = 0;
    uint public handlerToken;
    //Execute some code when contract is launched
    constructor(string memory _URI) ERC1155(_URI) {
        handlerToken = uint(keccak256(abi.encodePacked(_URI)));
        _mint(msg.sender,handlerToken,1, "");
    }
    modifier handler(){
        require(balanceOf(msg.sender,handlerToken) == 1, "user does not hold handlerToken");
        _;
    }
    //map token number to struct and mappping
    mapping(uint => Tokens) public tokens;
    struct Tokens{
        string name;
        string currentType;
        string total;
        string issure;
        string description;
    }
    //function to add or create a token
    function AddToken(string memory name, string memory currentType,uint total,string memory issure,string memory description)public handler returns(bool){
        //creates the token
        _mint(msg.sender,totalCoins,total, "");
        //asigns attributes
        tokens[totalCoins] = Tokens(name,currentType,total,issure,description);
        //keeps track of ammount of tokens
        totalCoins++;
        return true;
    }
    //handler Can redeem funds from contract
    function redeemContractValue()public handler returns(bool){
        payable(msg.sender).transfer(address(this).balance);
        return true;
    }
}