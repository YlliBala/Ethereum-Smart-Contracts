pragma solidity ^0.4.22;


contract KickStarter{
    
    //inicimi i variablave te nevojshme
    uint totaliMoney=0;
    uint counter=0;
    address private  owneri1 = msg.sender;
    
    struct kontribuesi{
        address personale;
        string emri;
        uint numri ;
        uint vlera;
        bool kaVotuar;
        
    }
    
    modifier onlyOwner{
        require(msg.sender == owneri1);
        _;
    }

    //kan me u rujt kontribuesit per me pas casje ne votim
    mapping (address => kontribuesi) kontribuesit;
    //kan me u rujt votat e kontribuesve
    bool[] Votat;
    
    /* Funksioni qe u mundeson te kontribojn kerkon qe minimumi te jet 0.9Eth;
       Ka validim qe atyre qe kan kontribuar tu mundesoj te drejten per te votuar;
    */
      function contribute()public  payable  {
          require(msg.value > 900000000000000000 );
          
          totaliMoney += msg.value;
          
          kontribuesit[msg.sender].vlera = msg.value;
          
          kontribuesit[msg.sender].numri = 1;
  }
  
    /**
     * Funksioni qe mundeson per te votuar,
     * Votat mund te ipen me True=Pozitive(Yes),Flase=Negativ(No).
     * Ka validim qe secili votues te kete te drejten te votoj vetem nje here.
     */
  function voto(bool _votaIme) public  {
      require(kontribuesit[msg.sender].numri == 1 && kontribuesit[msg.sender].kaVotuar == false );
      
      kontribuesit[msg.sender].kaVotuar = true;
      
      Votat.push(_votaIme);
  }
    /*Eshte funksion qe kthen totalin e Eth qe jane mbledhur nga kontribimet
      Kthen shumen ne Eth;
      Te drejta qasje ka vetem pronari i kontrates;
    */
  function ShikoBalancinTotal() public onlyOwner view returns(uint){
      //E kthen bilancin wetem ne ether;
      return totaliMoney/1000000000000000000;
  }
  
  /*Funksioni qe kalkulon perqindjen e votave Pozitive;
  Perqindja kthehet ne formen e rrumbullaksuar duke mos i mare parasyshe numrat dhjetore;
  */
  function kalkuloPerqindjen() private  returns(uint256){

      for (uint i = 0; i < Votat.length; i++)
      {
          if(Votat[i]==true){
              counter += 1;
          }
      }
      return (counter*100)/Votat.length;
  }
  
  /**
   * Funksioni qe shfaq perqindjen ne restin e thirrjes;
   * Te drejta qasje ka vetem pronari i kontrates;
   */
  function getPerqindjenPoz() public view returns(uint256){
      return kalkuloPerqindjen();
  }
  
      


    
}