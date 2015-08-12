
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	fbiranchTXD = engineLoadTXD("fbiranch.txd",490)
	fbiranchDFF = engineLoadDFF("fbiranch.dff",490)
	if fbiranchTXD == false then
		exports.CSGsecrettrans:downloadFile(":CSGfbirancher/fbiranch.txd", "fbiranch.txd", 100)
	else
		engineImportTXD(fbiranchTXD,490)
	end
	if fbiranchDFF == false then
		exports.CSGsecrettrans:downloadFile(":CSGfbirancher/fbiranch.dff", "fbiranch.dff", 100)
	else
		engineReplaceModel(fbiranchDFF,490)
	end
end)

addEvent("onClientDownloadComplete",true)
addEventHandler("onClientDownloadComplete", getRootElement(),
function (theFile)
	if theFile == ":CSGfbirancher/fbiranch.txd" then
		fbiranchTXD = engineLoadTXD(theFile)
		engineImportTXD(fbiranchTXD,490)
	elseif theFile == ":CSGfbirancher/fbiranch.dff" then
		fbiranchDFF = engineLoadDFF(theFile,490)
		engineReplaceModel(fbiranchDFF,490)
	end
end)
