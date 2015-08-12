local disabled = false
local theKey = false
function unbindTheBindedKey()
	local key = getKeyBoundToCommand("rob")
	local key2 = getKeyBoundToCommand("rb")
	if key or key2 then
		if key then theKey = key else theKey = key2 end
		if disabled then return end
		disabled = true
		--outputDebugString("Player "..getPlayerName(localPlayer).." has rob binded (Key: "..key.."), disabling feature...",0,255,0,0)
		triggerServerEvent("toggleRob",localPlayer,true)
	else
		if not disabled then return end
		disabled = false
		--outputDebugString("No bind suspected for player "..getPlayerName(localPlayer),0,0,255,0)
		triggerServerEvent("toggleRob",localPlayer,false)
	end
end
setTimer(unbindTheBindedKey,1000,0)


function rob()
	if disabled then
		exports.DENdxmsg:createNewDxMessage("Unbind '"..theKey.."' from the /rob command",255,0,0)
	end
end
addCommandHandler("rb",rob)
addCommandHandler("rob",rob)
