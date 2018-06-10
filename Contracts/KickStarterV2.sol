
pragma solidity ^0.4.16;


contract Crowdsale {
    
    address public beneficiary;
    uint public fundingGoal;
    uint public amountRaised;
    uint public deadline;
    uint private counter=0;
    
   // uint public price;
    mapping(address => uint256) public balanceOf;
    bool fundingGoalReached = false;
    bool crowdsaleClosed = false;
    
    //Struktura per kontribuesit 
    struct kontribuesi{
        address personale;
        string emri;
        uint numri ;
        uint vlera;
        bool kaVotuar;
    }
    
    //kan me u rujt kontribuesit per me pas casje ne votim
    mapping (address => kontribuesi) kontribuesit;
    //kan me u rujt votat e kontribuesve
    bool[] Votat;
    

    /**
     * Constructor function
     *
     * Setup the owner
     */
      constructor(
        uint fundingGoalInEthers,
        uint durationInMinutes
    ) public {
        beneficiary = msg.sender;
        fundingGoal = fundingGoalInEthers * 1 ether;
        deadline = now + durationInMinutes * 1 minutes;

    }

    /**
     * Fallback function
     *
     * The function without name is the default function that is called whenever anyone sends funds to a contract
     */
    function contribute() public payable {
        require(!crowdsaleClosed && msg.value > 900000000000000000);
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
        amountRaised += amount;
        
        kontribuesit[msg.sender].vlera = msg.value;
          
        kontribuesit[msg.sender].numri = 1;
    }
    
    /**
     * Funksioni qe mundeson per te votuar,
     * Votat mund te ipen me True=Pozitive(Yes),Flase=Negativ(No).
     * Ka validim qe secili votues te kete te drejten te votoj vetem nje here.
     */
    function voto(string _votaIme) public returns (string)  {
        require(kontribuesit[msg.sender].numri == 1 && kontribuesit[msg.sender].kaVotuar == false );
        
        uint wordYes = uint(keccak256("Yes"));
        uint wordNo = uint(keccak256("No"));
        
        if(wordYes == uint(keccak256(_votaIme)))
        {
            kontribuesit[msg.sender].kaVotuar = true;
            Votat.push(true);
            return "Vota u regjistrua me sukses";
        }
        else if(wordNo == uint(keccak256(_votaIme))) {
            kontribuesit[msg.sender].kaVotuar = true;
            Votat.push(false);
            return "Vota u regjistrua me sukses";
        }
        else {
            return "Ka pasur nje error vota nuk eshte regjistruar";
        }
    }
  
    /**
     * Funksioni qe kalkulon perqindjen e votave Pozitive;
     * Perqindja kthehet ne nje numer 4shifror, duke pasur parasyshe qe 2 numrat e pare(x dhe y) jane dhjetshet kurse 2 numrat e fundit(a dhe b) jan numrat pas presjes dhjetore. 
     * P.sh. xy.ab% => xyab , 50.59% => 5059;
     */
    function kalkuloPerqindjen() private  returns(uint256){
      for (uint i = 0; i < Votat.length; i++)
      {
          if(Votat[i]==true){
              counter += 1;
          }
      }
      return (counter*1000)/Votat.length;
    }
    
    
    /**
     * Funksioni qe shfaq perqindjen ne restin e thirrjes;
     * Te drejta qasje ka vetem pronari i kontrates;
     */
    function getPerqindjenPoz()  public view  returns(uint256){
        return kalkuloPerqindjen();
    }


    modifier afterDeadline() { if (now >= deadline)_; }


    /*** 
     * Check if goal was reached
     *
     * Checks if the goal or time limit has been reached and ends the campaign
     */
    function checkGoalReached() public afterDeadline {
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            //return true;
            //GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }


    /**ME RANDSI E GATSHME PER KTHIMIN E PAREVE
     * Withdraw the funds
     *
     * Checks to see if goal or time limit and vote % above 51% has been reached, and if so, and the funding goal was reached,
     * sends the entire amount to the beneficiary. If goal was not reached, each contributor can withdraw
     * the amount they contributed.
     */
    function safeWithdrawal() public {
        if(getPerqindjenPoz() < 5000){
            if (now >= deadline){
                if (!fundingGoalReached){
                    uint amount = balanceOf[msg.sender];
                    balanceOf[msg.sender] = 0;
                    if (amount > 0) {
                        if (msg.sender.send(amount)) {
                            //return "Ethat ju kan kthy personit qe i ka dergu per shkak te deshtimit te mbledhjes";
                        } else {
                            balanceOf[msg.sender] = amount;
                            //return "ethat nuk munden te kthehen te personi";
                        }
                    }
                }
            }
        } else{/*return "ethat nuk munden te kthehen te personi se hala osht e hapur mbledhje e eth";*/}

        if (fundingGoalReached && beneficiary == msg.sender && getPerqindjenPoz() >= 5000) {
            if (beneficiary.send(amountRaised)) {
                //return "Ethat jon shku te pronari!!!";
            } else {
                //If we fail to send the funds to beneficiary, unlock funders balance
                fundingGoalReached = false;
                //return"If we fail to send the funds to beneficiary, unlock funders balance";
            }
        }
    }
    
}
