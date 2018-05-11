pragma solidity ^0.4.22; contract AiTradeBot{
    
    //inicimi i variablave te nevojshme
    address private owneri;
    //Qekjo osht relative sipas addreses se kontrates qe i ka bo deploy 
per Tokena.
    address private AdressaCoinit = 
0x9aa976307fa0dc803aaac06c0d0863de63bc3743;
    
    AiBot b = AiBot(AdressaCoinit);
    
    constructor() public{
        owneri = msg.sender;
    }
    
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
    
    function MbushInfo(uint _GID,string _P1,string _P2,string 
_Arena,uint _G1,uint _G2,uint _perqindja,uint _shuma)
    public {
        require(owneri == msg.sender);
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
    /***
     * Te dhenat dalin te detalis se nuk mund ta perdorim view per kete 
kontrat,
     * per ndryshe mund te perdorim event per shfaqjen e infove
     */
    function BuyInfo(uint _GID,uint256 shuma) public 
returns(string,string,string,uint256,uint256,uint256){
        b.transfer(msg.sender,owneri,shuma);
        
        return 
(lojrat[_GID].P1,lojrat[_GID].P2,lojrat[_GID].Arena,lojrat[_GID].G1,lojrat[_GID].G2,lojrat[_GID].perqindjaSaktesis);
    }
    
    function LexoShumen(uint _GID) public view returns(uint256){
        return lojrat[_GID].shuma;
    }
    
    function lexoBalancen (address _addresa)public view 
returns(uint256){
        return b.balanceOf(_addresa);
    }
    
    function transferoPare(address _to, uint256 _vlera) public {
         b.transfer(msg.sender,_to,_vlera);
    }
   
}
contract AiBot{
    
        function balanceOf(address _owner) public view returns 
(uint256);
    
        function transferFrom(address _from, address _to, uint256 
_value) public returns (bool);
    
        function transfer(address _from,address _to, uint256 _value) 
public returns (bool);
        
        function approve(address _spender, uint256 _value) public 
returns (bool success);
        
        function allowance(address _owner, address _spender) public view 
returns (uint256 remaining);
    
    }
    
