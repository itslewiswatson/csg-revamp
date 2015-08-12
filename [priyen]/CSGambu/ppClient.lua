
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	ambu2TXD = engineLoadTXD("ambu5.txd",529)
	ambu2DFF = engineLoadDFF("ambu5.dff",529)
	if ambu2TXD == false then
		exports.CSGsecrettrans:downloadFile(":CSGambu/ambu2.txd", "ambu5.txd", 150)
	else
		engineImportTXD(ambu2TXD,529)
	end
	if ambu2DFF == false then
		exports.CSGsecrettrans:downloadFile(":CSGambu/ambu2.dff", "ambu5.dff", 150)
	else
		engineReplaceModel(ambu2DFF,529)
	end
end)

addEvent("onClientDownloadComplete",true)
addEventHandler("onClientDownloadComplete", getRootElement(),
function (theFile)
	if theFile == ":CSGambu/ambu5.txd" then
		ambu2TXD = engineLoadTXD(theFile)
		engineImportTXD(ambu2TXD,529)
	elseif theFile == ":CSGambu/ambu5.dff" then
		ambu2DFF = engineLoadDFF(theFile,529)
		engineReplaceModel(ambu2DFF,529)
	end
end)
