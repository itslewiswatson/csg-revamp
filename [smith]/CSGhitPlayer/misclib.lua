local screenWidth, screenHeight = guiGetScreenSize()

function cancelJailDamage()
	for index, players in ipairs(getElementsByType("player")) do
		if (getElementDimension(players) ~= 2) then 
			setElementData(players, "invicible", false)  
		return end
		local posX, posY, posZ = getElementPosition(players)
		if (getDistanceBetweenPoints3D(posX, posY, posZ, 1551, -814, 354) > 500) then return end
			setElementData(players, "invicible", true)
	end
end
setTimer(cancelJailDamage, 1000, 0)

function onClientPlayerDamage()
	if (getElementData(source, "invicible")) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", root, onClientPlayerDamage)

function getFPS()
	if not startTick then startTick = getTickCount() end
	if not frames then frames = 0 end
	frames = frames + 1
	currentTick = getTickCount()
	if currentTick - startTick >= 1000 then
		setElementData(localPlayer, "fps", frames)
		startTick = nil
		frames = nil
	end
	
	local color
end
addEventHandler("onClientRender", root, getFPS)
