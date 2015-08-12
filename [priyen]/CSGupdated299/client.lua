
function applyMods()
	local skin = engineLoadTXD("skin.txd", true)
	engineImportTXD(skin, 299)
	local skin = engineLoadDFF("skin.dff", 299)
	engineReplaceModel(skin, 299)
end
addEventHandler("onClientResourceStart", resourceRoot, applyMods)
