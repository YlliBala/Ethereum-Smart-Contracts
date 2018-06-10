pragma solidity ^0.4.22;


contract BetBastFun{
    
    //inicimi i variablave te nevojshme
    address private  owneri1 = msg.sender;
    address private AdressaCoinit = 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a;
    address private une = 0x2d13027baa4d36e8f62931cebe63fe7064bffc34;
    
    BetBast b = BetBast(AdressaCoinit);
    
    struct GameBetInfo{
        string P1;
        string P2;
        string Arena;
        uint256 G1;
        uint256 G2;
        uint256 perqindjaSaktesis;
        uint256 shuma;
    }
    
    mapping(uint => GameBetInfo) lojrat;
    
    function MbushInfo(uint _GID,string _P1,string _P2,string _Arena,uint _G1,uint _G2,uint _perqindja,uint _shuma)
    public {
        require(owneri1 == msg.sender);
        
       /** 
        lojrat[_GID].P1 = _P1;
        lojrat[_GID].P2 = _P2;
        lojrat[_GID].Arena = _Arena;
        lojrat[_GID].G1 = _G1;
        lojrat[_GID].G2 = _G2;
        lojrat[_GID].perqindjaSaktesis = _perqindja;
        */
        
        lojrat[_GID] = GameBetInfo({
            P1 : _P1,
            P2 : _P2,
            Arena : _Arena,
            G1 : _G1,
            G2 : _G2,
            perqindjaSaktesis : _perqindja,
            shuma : _shuma 
            
        });
        
    }
   
    
    function BuyInfo(uint _GID,uint256 shuma) public view  returns(string,string,string,uint256,uint256,uint256){
        b.transfer(msg.sender,0x436459362f06a8aE56161c6c13E85D2EeC8D148B,shuma);
        
        return (lojrat[_GID].P1,lojrat[_GID].P2,lojrat[_GID].Arena,lojrat[_GID].G1,lojrat[_GID].G2,lojrat[_GID].perqindjaSaktesis);
    }
    
    function TestTransfer(address _add) public view returns(bool){
        return b.transfer(msg.sender,_add,50);
    }
    
    function LexoShumen(uint _GID) public view returns(uint256){
        return lojrat[_GID].shuma;
    }
    
    function lexoBalancen (address _addresa)public view returns(uint256){
        return b.balanceOf(_addresa);
    }
    
    function transferoPare(address _to, uint256 _vlera) public  {
         b.transfer(msg.sender,_to,_vlera);
    }
    
    function Approvo(address _spender,uint256 _vlera)public returns(bool){
        
        return b.approve(_spender,_vlera);
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return b.allowance(_owner,_spender);
    }

    
}

contract BetBast{
    
        function balanceOf(address _owner) public view returns (uint256);
    
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    
        function transfer(address _from,address _to, uint256 _value) public returns (bool); 
        
        function approve(address _spender, uint256 _value) public returns (bool success);
        
        function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    
    }
    