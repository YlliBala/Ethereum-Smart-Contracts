pragma solidity ^0.4.23;

contract Channel {

	address public channelSender;
	address public channelRecipient;
	uint public startDate;
	uint public channelTimeout;
	address public owner;
	mapping (bytes32 => address) signatures;
	
	constructor() {
	    owner = msg.sender;
	}

	function CreateChannel(address to, uint timeout) payable {
	    require(msg.sender == owner);
		channelRecipient = to;
		channelSender = msg.sender;
		startDate = now;
		channelTimeout = timeout;
	}

	function CloseChannel(bytes32 mhash, uint8 v, bytes32 r, bytes32 s, uint value,string Rtxt) {

		address signer;
		bytes32 proof;

		// get signer from signature
		signer = ecrecover(mhash, v, r, s);

		// signature is invalid, throw
		if (signer != channelSender || signer != channelRecipient) throw;

		
		proof = sha3(Rtxt, value);

		// signature is valid but doesn't match the data provided
		if (proof != mhash) throw;

		if (signatures[proof] == 0)
			signatures[proof] = signer;
		else if (signatures[proof] != signer){
			// channel completed, both signatures provided
			if (!channelRecipient.send(value)) throw;
			selfdestruct(channelSender);
		}

	}

	function ChannelTimeout(){
		if (startDate + channelTimeout > now)
			throw;

		selfdestruct(channelSender);
	}

}