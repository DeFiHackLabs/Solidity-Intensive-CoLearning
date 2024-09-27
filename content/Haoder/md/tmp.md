# WTF Solidity 極簡入門：

## 重點內容

> [!NOTE]
> 

## 隨筆

## 題目練習

<!--

__        __    _             __        __    _             _    _
\ \      / /_ _| | ___   _    \ \      / /_ _| | ___   _   | |  | |
 \ \ /\ / / _` | |/ / | | |    \ \ /\ / / _` | |/ / | | |  | |  | |
  \ V  V / (_| |   <| |_| |     \ V  V / (_| |   <| |_| |  |_|  |_|
   \_/\_/ \__,_|_|\_\\__,_|      \_/\_/ \__,_|_|\_\\__,_|  (_)  (_)

XXXXXXXXXXXXXXXXXKlkOOOXXXXXXXXXX0xddxddoooodkOKxWWxXXXXOXXX0Ox:llo0XXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXKONWNK00KX0xxO0XNWMMMMMMMWWXK0OOolooxx:llc::;,'';lXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXkOWMMW0ocKMMMMMMMMMMMMMMMMMMMX;l:KW0o,..      .l00KXXXXXXXXXXXXXXXX
OOOOOOOOOO0XXXXXXXX0Ok0XWMMMNXMMMMMMMMMMMMMMMMMMMMx;;:NMN.        .lXOkXXXXXXXXXXXXXXXX
000OOOOOOOkkkkkkxcdKWWNXKNMMMWMMMMMMMMMMMMMMMMMMMMMk. .dWWX.       :OOkOOOOOOOOOOOOOOOO
MMMMMMMMMMMMMMW0ONMMNNWMMMMMMMMMMWXKXWMMMMMMMMMMMMMMX,  .kWWN:.    lMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMM0xNMMMXNMMMMWNXXK0OOOOkxodxk0KKXNMMMMMMMW0:  .c0WWWl:ccWMMMMMMMMMMMMMMMMMM
        ....,OWMMMXWMWNKOxxxxxxxxxxddxddooodddk0XWMMMMWNKd,  .;lx0K,...................
           .XMMMMWNX0kxxxxxxxxxxxxxxxxxxxxdlodddddOXWMMMWNXXx;.    .d:                 
          .XMMMMWKkxxxxxxxxxxxxxxxxxxxdxxdxxdoddddddx0NMMMNXXWMNOl:l0Wk                
          0MMMWKkxxxxxxxxxxxxxxxxxxxxxxxxxdddddddddddddONMWNNKXMMMXKNMMK.              
        'oMMMNOkkxxkxxxxxxxxxxxxxxxxxxxxxxxxxdddodddddddd0WNNMXOWMMMXKNMN:             
     .,olWMMXkkkkkkkkxxxxxxxxxxxxxxxxxxxxxxxxdddddddddddddkXXWMW0NMMMWKXWWd            
   .;,,OdMWKkkkkkkkkkkkxxxxxxxxxxxxxdxxxxxxxxxxxdxdodddddddx0XMMWKKMMMMWXNWO           
  ..  kd0MXkkkkkkkkkkkkkkkkxxxxxxxxxxxxxxxxxxxxxxxxdodxxdddddxNMMMXKWMMMMXKW0.         
   .  dlWMOkkkkkkkxkkkkkkkkkkkkxxxxxxxxdxxxxxxxxxdxxdodxdddddoxKWMMN0WMMMMXKWX'        
    . OlMWkkkkkkkkkxkkkkkkkkkkxkkxxxxxxxddxxxxxxxddxxdoddddddodd0WMMW0NMMMMXNMX'       
     .llMXxkOOkkkkkxxkkkkkkkkkxxkkxxxxxxxxddxxxxxxdoxxdldddddoodxONMMMKWMMMMXWWK.      
      .oMKxkOOkkkOkkxxkkkkkkkkkxdxkxdxxxxxxxdodxxxxdoxxccxdxddoxxxkNMMMKWMMMWKWWK.     
       dW0kxOOOkkOkkkkxkkkkkkkkkkddkkxoclxxxxxdoodxxdox;.oxxxdodxxxkNMMWKWMMMXKMMN:    
       dWOOxOOOOdxkxkkkxxkkkkkkkkkxodkxxc',lllooollllco;l:xxxdodddxdkNMMW0WMMM0NMMWk.  
       oNOOdOOOOOxxOxxkkkxkkkkkkkkkkdclxkkoccoxxxxdooc.':'oxxddxxxxxxkWMMW0MMMN0MMMMX; 
       lNOOdOOOOOOxckOkkkOkxxkkkkkkkkkoccldddxddooc:cox0o,;xxdxxxxxxxdOWMMNXMMM0XMMMMMk
       lN00kxOOOOOOldodkkkxkxxxxxxkkkxxxdddddl::odONXkocdx,cxdxxxxxxxxxKMMMKNMMXKWMMMMM
       cN000x00OxOOOcxOxddxxddddxdddddkkxl:,. ;XXOxocoxdddd,xdxxxxxxxxxxNMMWOWMXKXMMMMM
       ,N000kk00lldxOdxOkkxxxkkkOkkkkkkkc:ooldxdoxxdddoddxx'ldxxxxxxxxxxOMMMX0MXXKMMMMM
       .N0000xO0oOOxxxoxOOOOkkdockOOkkkkkkkkkkkkkkxxxxxxxxx,cxxxxxxxxxxxxKMMMONXNKNMMMM
        KK000Od0xOxk00OkkxlldxxooOOOOkkkkkkkkkkkkkkkkkddoxx;lxxxxxxxxxxxxxWMMN0KWNXMMMM
        k00000kdOOOOxl;ldkK0kddOOOOOOOOOOOkkkkkkkkkkkxddkkx.xxxxxxxxxxxxxoXMMM0XMWKMMMM
        oK0KKK0xxloo;,lkkxdkOOOOOOOOkdOOOOOkkkkkkkkkxocxkko,kxxxxxxxxxxxdxKMMMKXMWKMMMM
        ;XO0KKK0xxddoxxO0000OOOOOOOOOOOOOOOOkkkkkxoodkkkkk:dkkkkkxxxxxxxdxOMMMNXMNXMMMM
        .X0OKKKK0xO0OOO0000000OOOOOOOOOOOOkkOkddodkkkkkkkk:kkkkkkkkxxxxxdxkWMMWXMXWMMMM
         000OKKKKKkO000000000000OOOOOOOOOkddddxkOkkkkkkkkd:kkkkkkkkkxxxdxxkWMMWXWXMMMMM
         dX00O0KKKKOk0K0000000000000OxxxxxxxxxxOOOOOOkkkx,ckkkkkkkkkkkddkxOMMMNNNWMMMMM
        .xKXK000KKKK0kOKK0000000OkkkxkOkkkkOOOOOOOOOOx:'  lkkkkkkkkkkklkkxKMMMOk0WMMMMM
         KkXXK00OKKKKKxd0KKK0000000000000OOOOOOOOxc,.   .;lkkkkkkkkkkoxkkkNMMW;..,ldkXM
         XkOXXX0000KKKKOccd0KKK00000000000Okdc;.      .lkolkkkkkkkkkdxkkkOWMMd    .cc;c
         ONdXXXXKO00KKKKKk,;oxdxxkxxxdoddol        .:kOOOx:OOkkkkkkoxkkkOWMMk     .,..:
         lW0kXXXXXKOO0KKKK0cl000KKK0OOk0Oo,:l'::cokOOOOOOO;kOOOOkkoxkkkkNMMO      ..   
         .WNO0XXXXXX0O0KKKKKOcOOKKK0kkko.;O00koO0OOOOOOOOOolOOOOkdkkkkONMWd      ..    
  .kKo    ONXO0XXXXXXX00KXKKKKdxKKKkko, o00000OO000OOOOOkxdcoOOxdOkOOKWWk'       ,     
  '0KKd   .NNXkKXXXXXXXXK00KKKKOxKKx. .kKK000000000000kxOOOx,oxkOO0XXOc.        ..     
   ,KXXk.  ;NNXOOXXXXXXXXXKO00KK0o:   d0KKK000OO000000Oxl,. .d00kdc.            '      
    ,0KOo   'KNN0OXXXXXXXXXXXKOkOO.  .K0OOOO0O0000xo:.     .'..                 .      
     'OKKd.   lKNXO0XXXXXXXXXXXXKOk;. :odddolc;'.                              ..      
      .KXXk     ckXKOKXXXXXXXXXXXXXKX0c                ...''''...              .       
       'KXNk       .'.'lkXXXXXXXXXXOo,        .coc:ok00K000000000Okl,                  
        'KKNk.            .;ccc:,.       .';cc0KKxOOkO00000000000000x                  
      ,dxd00N0.                      'lkO0000dkKKk0KKKKKKKKK00000000:                  
    .0MWWWWXK0O,:cll:.            .oKXXX00000KxKKkkxkkOOOOOOOOOOOO0O.                  
    dMWWWWWWWW0dkNNNNNK,         .KXXXXXXXK00kol,cKKx0O;.',:coxkOkl.                   
    0MWWNWWWWWWNxl0NNNNd         cNXXXXK0000OxK' :XXO0KK,                              
  .0WWWWNKKXWWWWW0lNNNNk         oNXKKKXKk0X0Kl  :XXkKOKK,                            .
  0MWWWWWWXxkNWWNX0k0XXk         l00XXd,,KXOKK.  cXXOXKKKK;       .;cool:'             
 ,NMWNWWWWWWNkkONWWKkXXx         .xo'  ;XNXXXl   cXX0KXXXXK;..'ckXXXXXXKXWNxol;.       
;WMWWXKKNWWWWWWOookkoo;.              :NNNNNK.   :XXXXK00K00KKXKKK0000KKK0K000K0xodxkxO
xMMMWWWWkONWWWWWWoXXWK.               KNNNNNd    :XXXkKXX0xOk0XK0k0KKKKK0OOOOkK00KXXX0o

-->