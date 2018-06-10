pragma solidity ^0.4.22;

import './SafeMath.sol';


contract AiTradeBot{
    
    //inicimi i variablave te nevojshme
    address private  owneri;
    //Qekjo osht relative sipas addreses se kontrates qe i ka bo deploy per Tokena.
    address private AdressaCoinit = 0x9aa976307fa0dc803aaac06c0d0863de63bc3743;
    
    TokenInter b = TokenInter(AdressaCoinit);
    
    constructor() public{
        owneri = msg.sender;
    }
    
    struct produkti{
        string emri;
        uint256 cmimi;
        uint256 stock;
    }
    
    struct bleresi{
        uint256 napolonat;
        uint256 blerjetTotal;
    }
    
    mapping(uint256 => produkti) produktet;
    mapping(address => bleresi) bleresit;
    
    function MbushProdukte(uint _PID,string _emri,uint256 _cmimi,uint256 _stock) public {
        require(owneri == msg.sender);
        
        produktet[_PID] = produkti({
            emri : _emri,
            cmimi : _cmimi,
            stock : _stock
        });
    }
    //2jat bashk
    function MbushStock(uint256 _PID,uint256 _stockAdd) public {
        require(owneri == msg.sender);
        
        produktet[_PID].stock = SafeMath.add(produktet[_PID].stock,_stockAdd);
    }
    
    function BlejProduktin(uint256 _Pid,uint256 _sasia) public {
        require(!(produktet[_Pid].stock == 0)); 
        
         uint256 Nshuma = 0;
         uint256 Pshuma = 0;
        
        Nshuma =  produktet[_Pid].cmimi * _sasia;
        Pshuma =  produktet[_Pid].cmimi * _sasia;
        
        
        if(bleresit[msg.sender].napolonat >= 100){
            uint nHere = 0;
            uint256 zbritje = 0;
            uint256 nMaxHere = 0;
            
            nHere = SafeMath.div(bleresit[msg.sender].napolonat,100);
            nMaxHere = SafeMath.div(Nshuma,3);
            
            if(nHere>nMaxHere){
                
            zbritje = SafeMath.mul(nMaxHere,3);    
            
            Nshuma = SafeMath.sub(Nshuma,zbritje);
            
            b.transfer(msg.sender,owneri,Nshuma);
                
            }else{
                
            zbritje = SafeMath.mul(nHere,3);    
            
            Nshuma = SafeMath.sub(Nshuma,zbritje);
            
            b.transfer(msg.sender,owneri,Nshuma);
            }
 
        }
        else {
            b.transfer(msg.sender,owneri,Nshuma);
        }
       
        bleresit[msg.sender].blerjetTotal = SafeMath.add(bleresit[msg.sender].blerjetTotal,Pshuma); 
        
        if(Pshuma>= 10){
            uint256 Nhere;
            uint256 napolonat1;
            
            Nhere = SafeMath.div(Pshuma,10); 
            
            napolonat1 = SafeMath.mul(Nhere,3);
        }
        
    }
    

    
    function LexoCmimin(uint _PID) public view returns(uint256){
        return produktet[_PID].cmimi;
    }
    
    function lexoStock (uint _PID)public view returns(uint256){
        return produktet[_PID].stock;
    }
    



}

contract TokenInter{
    
        function balanceOf(address _owner) public view returns (uint256);
    
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    
        function transfer(address _from,address _to, uint256 _value) public returns (bool);
        
        function approve(address _spender, uint256 _value) public returns (bool success);
        
        function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    
    }
    