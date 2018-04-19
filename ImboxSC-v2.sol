pragma solidity ^0.4.0; contract Inbox{
   
    struct msgData {
        address sender;
        address pranuesi;
        address bcc;
        string subject;
        string message;
        string imageURL;
        uint timeStamp;
    }
    mapping(uint => msgData) Mesazhet;
    
    uint[] public numratEMesazhave;
    
    function shkruajMesazhin(uint _numriMesazhit, address _derguesi, 
address _pranuesi, string _subject, string _message, string _imageURL, 
address _bcc) public{
            var msgData = Mesazhet[_numriMesazhit];
            
            msgData.sender = _derguesi;
            msgData.pranuesi = _pranuesi;
            msgData.subject = _subject;
            msgData.message = _message;
            msgData.bcc = _bcc;
            msgData.imageURL = _imageURL;
            msgData.timeStamp = now;
            //'now' e merr timeStamp ipas Linux time;
            
            //'-1' vyn nese don me gjet vendodhjen e pushit ne array 
mbasi array jon 0based duhet me ja zbrit 1 per vendodhjen
            // e pushit
            numratEMesazhave.push(_numriMesazhit) -1;
            
        }
        
        /*kthen numrat e mesazhave qe jon gjeneru deri qetash, ka mujt 
me kon edhe diqka tjeter p.sh. me kon Subjekti i mesazhit
        Ose per me kon unik mundet me kon Hashi i mesazhit qe e kerkon
        Per arsye thjeshtesi e kom lon numer.
        */
    function getNrMesazheve() view public returns(uint[]){
        return numratEMesazhave;
        
    }
    
    function getMessazhin(uint NrMesazhit) view public 
returns(address,address,string,string,address,string,uint){
        //limiton te drejtat e qasjes ne mesazh vetem ata qe jon ne 
Sender,Reciver,BCC (nese e din numrin e mesazhit)
        require(msg.sender == Mesazhet[NrMesazhit].sender || msg.sender 
== Mesazhet[NrMesazhit].pranuesi ||
        msg.sender == Mesazhet[NrMesazhit].bcc);
        
        //Mundesh mos me qit BCC me u dok mbasi osht sekret.
        return(Mesazhet[NrMesazhit].sender,Mesazhet[NrMesazhit].pranuesi,Mesazhet[NrMesazhit].subject,Mesazhet[NrMesazhit].message,
        Mesazhet[NrMesazhit].bcc,Mesazhet[NrMesazhit].imageURL,Mesazhet[NrMesazhit].timeStamp);
    }
    
    //Kthen nr total te mesazhave
    function NrTotalTeMsg() view public returns(uint){
        return numratEMesazhave.length;
    }
    
}
