addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
	-- SWAT Skin
	txd = engineLoadTXD ( "swat.txd" )
	engineImportTXD ( txd,76)
	dff = engineLoadDFF ( "swat.dff",76)
	engineReplaceModel ( dff,76)
	-- MF Skin
	txd = engineLoadTXD ( "af.txd" )
	engineImportTXD ( txd,97)
	dff = engineLoadDFF ( "af.dff",97)
	engineReplaceModel ( dff,97)
	end
)
