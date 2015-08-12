
addEventHandler("onClientPlayerWasted",localPlayer,function(k)
	if source ~= localPlayer then return end
	if isElement(k) then
		if getElementType(k) == "player" then
			setCameraTarget(k)
			exports.dendxmsg:createNewDxMessage("Viewing Kill Cam of "..getPlayerName(k).."!",0,255,0)
		end
	end
end)
