pragma solidity ^0.4.22; contract Noteri{
    
    /*Nje Struktur me te dhenat qe deshirojme ti vendosim
      Kam vendosur vetem keto te dhena bazika, leht mund te shtohen edhe 
te tjera;
    */
    struct teDhenat{
        string emri;
        string mbiemri;
        string emriKompanis;
        uint timeStamp;
        
    }
    
    //HashTable me key => value.
    mapping(string => teDhenat) notedData;
    
    
    //MD5 te dhenat jane ruajtur ne form te stringut,dhe kjo na mundeson 
qe ti ruajm ato dhe ti kerkojme;
    string[] private hashMD5;
    
    //Funksioni per vendosjen e te dhenave;
    function setTeDhenat (string _hashMD5,string _emri,string 
_mbiemri,string _emriKompanis) public{
        
        //Nje variabel me key Hashin MD5;
        var teDhenat = notedData[_hashMD5];
        
        //Mbushja me te dhena;
        teDhenat.emri = _emri;
        teDhenat.mbiemri = _mbiemri;
        teDhenat.emriKompanis = _emriKompanis;
        teDhenat.timeStamp = now;
        
        //Rrujta e key ne string array;
        hashMD5.push(_hashMD5);
    }
    
    //funksioni per shfaqjen e te dhenave duke u bazuar hashin qe ipet;
    function getTeDhenat (string MDHashi) view public 
returns(string,string,string,uint){
                return(notedData[MDHashi].emri,notedData[MDHashi].mbiemri,notedData[MDHashi].emriKompanis,notedData[MDHashi].timeStamp);
    }
}
