// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
// Creating a token manually
contract MyCustom_token{
    // Creating a structure that contains token_detail
    struct token_details{
        string token_name;
        string symbol;
        uint256 TotalSupply;
        address Owner; 
    }
    // Mapping the address between the address and balance
    mapping (address=>uint256) public balances;
    // Creating an event for checking or emitting details
    event Transfer(address indexed _from,address indexed _to,uint256 _value);
    event Minting(address indexed _owner,uint256 _value);
    // Creating a struct variable 
    token_details public my_token_details;

    // Creating a Connstructor to initaize the Token with Prefered name,Token,owner_detail and giving all the toekns to the user
    constructor(string memory _name,string memory _symbol,uint256 _initalSupply){
        my_token_details.token_name =_name;
        my_token_details.symbol=_symbol;
        my_token_details.TotalSupply=_initalSupply;
        balances[msg.sender]=_initalSupply;
        my_token_details.Owner=msg.sender;
    }
    // Creating a balance function
    function balance_of_user(address _owner) public view returns (uint256){
        return balances[_owner];
    }
    // Creating a Transfer Function for Transfering the tokens from sender to the recipent
    function transfer(address _to, uint256 _value) public returns ( bool success){
        require(balances[msg.sender]>=_value,"Insufficient balance");//Checking if the user has sufficent amount token or not
        require(_to !=address(0),"Cannot Transfer the token Address invaild");//checking if user sending to 0 address

        balances[msg.sender]-=_value;

        balances[_to]+=_value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    // Show the owner of the tokens
    function Owner() public view  returns  (address){
        return my_token_details.Owner;
    }
    // Minting new Tokens can be invoked by the Creator only
    function mint(address _owner,uint256 _value) public returns (bool success){
        require(_owner != my_token_details.Owner,"Only Owner of the token can mint the token");
        require(_owner != address(0),"Owner address cannot be zero");
        my_token_details.TotalSupply+=_value;

        return true;
    }
    
}
// If you want to use ERC20 Then Comment the Manual one and uncomment the the ERC20 one.
// Using openzeplin and ERC20 to create a token ERC20 can create token by just calling _mint
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// contract Mytoken is ERC20{
//     constructor() ERC20("Token","TK"){
//         _mint(msg.sender,1000000*(10**uint256(decimals())));
//     }
// }

