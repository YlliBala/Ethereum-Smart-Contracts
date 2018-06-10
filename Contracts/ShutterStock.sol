pragma solidity ^0.4.22;


contract shutterstock{
    
    //inicimi i variablave te nevojshme
    address private  owneri;
    //Qekjo osht relative sipas addreses se kontrates qe i ka bo deploy per Tokena.
    address private AdressaCoinit = 0xef55bfac4228981e850936aaf042951f7b146e41;
    
    TokInter b = TokInter(AdressaCoinit);
    
    constructor() public{
        owneri = msg.sender;
    }
    
    struct PublisherInfo{
        address addresa;
        uint256 cmimi;
        string hashiFoto;
    }
    
    mapping(uint256 => PublisherInfo) Publikuesit;
    
    function PublikoFoto(uint256 _idp,uint256 _cmimi,string _hashi) public {
        Publikuesit[_idp] = PublisherInfo({
            addresa : msg.sender,
            cmimi : _cmimi,
            hashiFoto : _hashi
        });
    }

    function BuyFoto(uint _idp) public returns(string){
        require(b.transfer(msg.sender,Publikuesit[_idp].addresa,Publikuesit[_idp].cmimi));
        
        return (Publikuesit[_idp].hashiFoto);
    }
    
    function LexoCmiminPerFoto(uint _idp) public view returns(uint256){
        return Publikuesit[_idp].cmimi;
    }
    
}

contract TokInter{
    
        function balanceOf(address _owner) public view returns (uint256);
    
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    
        function transfer(address _from,address _to, uint256 _value) public returns (bool);
        
        function approve(address _spender, uint256 _value) public returns (bool success);
        
        function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    
    }
    