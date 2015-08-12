
function applyMods()
	local skin = engineLoadTXD("terrorists5.txd", true)
	engineImportTXD(skin, 136)
	local skin = engineLoadDFF("terrorists5.dff", 136)
	engineReplaceModel(skin, 136)
end
addEventHandler("onClientResourceStart", resourceRoot, applyMods)

