pragma solidity ^0.4.0; contract Inbox{
    
    string private message;
    address public owner;
    address public recipient;
    address private BCC;
    string private subject;
    
    
   function Inbox(address _recipient,string _subject ,string 
initMessage, address _BCC ) public {
        owner = msg.sender;
        message = initMessage;
        recipient = _recipient;
        BCC = _BCC;
        subject = _subject;
        
    }
    
    function setMessage(string newMessage) public {
        require(msg.sender == owner || msg.sender == recipient);
        message = newMessage;
    }
    
    function getMessage() public view returns (string){
        require(msg.sender == owner || msg.sender == recipient || 
msg.sender == BCC);
        return message;
    }
    
        function getTimeStamp() public view returns (uint){
        require(msg.sender == owner || msg.sender == recipient || 
msg.sender == BCC);
        return now;
    }
    
        function getSubject() public view returns (string){
        require(msg.sender == owner || msg.sender == recipient || 
msg.sender == BCC);
        return subject;
    }
    
    
    
}
