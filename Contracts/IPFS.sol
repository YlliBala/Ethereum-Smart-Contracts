pragma solidity ^0.4.22;

contract IPFS{
    
    
    mapping(uint => string) ipfsHashes;
    
    function storeHash(uint _id, string _hash) public {
        
        ipfsHashes[_id] = _hash;
        
    }
    
    function getHash(uint _id) public view returns(string){
        
        return ipfsHashes[_id];
    }
}