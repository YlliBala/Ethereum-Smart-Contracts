pragma solidity ^0.4.24;

//Nuk osht perfundu krejt kom mbet te regjstroStudentin********

contract Kursi{
    string emri;
    address owneriKursit;
    uint256 ID;
    string pershkrimi;
    uint256 NrTel;
    
    struct Studenti{
        
        string emri;
        string mbiemri;
        uint256 NrTel;
        mapping(uint256 => string) kurset;
        
    }
    
    mapping(uint256 => Studenti) studentet;
    
    constructor(uint256 _ID,string _emri,string _pershkrimi,uint256 _NrTel){
        
        ID = _ID;
        emri = _emri;
        pershkrimi = _pershkrimi;
        NrTel = _NrTel;
        owneriKursit = msg.sender;
        
    }
    
    function regjstroStudentin
    (uint256 _sID,string _emri,string _mbiemri,uint256 _NrTel,uint256 _kursiID,string _EmriKursit){
        
        studentet[_sID] = Studenti({
            emri : _emri,
            mbiemri : _mbiemri,
            NrTel : _NrTel
            //Qetu jom jet kom me i shtu pjeset tjerat kur regjistrohet studenti
            
        });
        
        studentet[_sID].kurset[_kursiID] = _EmriKursit;
        
    }
}

contract ICK{
    
    mapping(uint256 => address) kurset;
    
    function addKurse(uint256 _ID,string _emri,string _pershkrimi,uint256 _NrTel){
        address newKurs =  new Kursi(_ID,_emri,_pershkrimi,_NrTel);
        kurset[_ID] = newKurs;
    }
    
    function getAddKursit(uint256 _ID) public view returns(address){
        return kurset[_ID];
    }
}