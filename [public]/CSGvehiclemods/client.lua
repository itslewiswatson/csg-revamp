outputChatBox ( "Adding car mod" )
 
txd = engineLoadTXD ( "data/club.txd" )
engineImportTXD ( txd, 589 )
dff = engineLoadDFF ( "data/club.dff", 589 )
engineReplaceModel ( dff, 589 )