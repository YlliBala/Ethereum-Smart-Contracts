pragma solidity ^0.4.21;

contract Company{
    
    mapping(string => address) punetoret;
    
    function addEmployee(string _name,string _lastname,string _position){
        address newPuntor =  new Puntori(_name,_lastname,_position);
        punetoret[_name] = newPuntor;
    }
    
    function getEmployee(string _name) public view returns(address){
        return punetoret[_name];
    }
    
}

contract Puntori{
    
    string public name;
    string public lastname;
    string public position;
    
    constructor(string _name,string _lastname,string _position) public {
        name = _name;
        lastname = _lastname;
        position = _position;
    }
}