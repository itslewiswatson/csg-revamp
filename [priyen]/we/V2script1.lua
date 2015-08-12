
txd = engineLoadTXD ( "Tred.txd" )
engineImportTXD ( txd, 223 )
dff = engineLoadDFF ( "Tred.dff", 223 )
engineReplaceModel ( dff, 223 )

txd = engineLoadTXD ( "Tgreen.txd" )
engineImportTXD ( txd, 224 )
dff = engineLoadDFF ( "tgreen.dff", 224 )
engineReplaceModel ( dff, 224 )

txd = engineLoadTXD ( "Tblue.txd" )
engineImportTXD ( txd, 225 )
dff = engineLoadDFF ( "Tblue.dff", 225 )
engineReplaceModel ( dff, 225 )

txd = engineLoadTXD ( "Torange.txd" )
engineImportTXD ( txd, 226 )
dff = engineLoadDFF ( "Torange.dff", 226 )
engineReplaceModel ( dff, 226 )



--disable  team mate kill


 local allowedSkins = {[223]=true,[224]=true,[225]=true,[226]=true}
addEventHandler("onClientPlayerDamage",localPlayer,function(atker)
 if source ~= localPlayer then return end 
 local myModel = getElementModel(localPlayer)
if not(allowedSkins[myModel]) then return end
 if getElementModel(atker) == myModel then cancelEvent() end
 end)
 
 