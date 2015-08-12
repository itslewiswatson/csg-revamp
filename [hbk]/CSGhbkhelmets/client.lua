function replaceModelHelmetsMod()
txd = engineLoadTXD("helmet.txd")
engineImportTXD(txd, 2050 )
dff = engineLoadDFF("helmet.dff", 2050 )
engineReplaceModel(dff, 2050 )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource () ), replaceModelHelmetsMod )
