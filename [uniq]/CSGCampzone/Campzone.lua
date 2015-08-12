local NoCampZones = {
	{ -2712.34, 580.87, 100, 60 }, -- SF
	{ 1162.87, -1384.79, 83, 93 }, -- LS
	{ 1997.09, -1450.98, 55, 55 }, -- LS
	{ 1557.07, 1702.84, 100, 187 }, -- LV
	{ -345.09, 1008.69, 64, 85 }, -- LV-SF
	{ -1537.49, 2507.3, 52, 54 }, -- SF-LV
}

local NoCampZones2 = {
	{ 1243.89, 331.61, 19.55, 40 }, -- LV-LS
	{ -2195.87, -2303.28, 30.62, 40 }, -- SF-LS
}

local antiCampZoneTimer = {}
	
function createAntiCampZones()
	for _, zone in ipairs(NoCampZones) do
		campRectangle = createColRectangle(zone[1], zone[2], zone[3], zone[4]) 
		addEventHandler("onColShapeHit", campRectangle, onColAntiCampZoneHit)
		addEventHandler("onColShapeLeave", campRectangle, onColAntiCampZoneLeave)
	end
	for a, zone2 in ipairs(NoCampZones2) do
		campColSphere = createColSphere(zone2[1], zone2[2], zone2[3], zone2[4]) 
		addEventHandler("onColShapeHit", campColSphere, onColAntiCampZoneHit)
		addEventHandler("onColShapeLeave", campColSphere, onColAntiCampZoneLeave)
	end
end
addEventHandler("onResourceStart", resourceRoot, createAntiCampZones)

function onColAntiCampZoneHit(hitElement)
	if (getElementType(hitElement) == "player") then
		if not (getTeamName(getPlayerTeam(hitElement)) == "Staff") then
			if (isTimer(antiCampZoneTimer[hitElement])) then return end
			exports.DENdxmsg:createNewDxMessage(hitElement, "You have entered an anti-camp zone. Leave it within 30 seconds or you get reconnected!", 250, 250, 0)
			antiCampZoneTimer[hitElement] = setTimer(killPlayerCampZone, 30000, 1, hitElement)
		end
	end
end

function onColAntiCampZoneLeave(hitElement)
	if (getElementType(hitElement) == "player") then 
		if (isTimer(antiCampZoneTimer[hitElement])) then
			killTimer(antiCampZoneTimer[hitElement])
			if not (getTeamName(getPlayerTeam(hitElement)) == "Staff") then
				exports.DENdxmsg:createNewDxMessage(hitElement, "You have left the anti-camp zone", 0, 250, 0)
			end
		end
	end
end

function killPlayerCampZone(player)
	if isElement(player) then
		if ( getElementType(player) == "player" ) then
			if not (getTeamName(getPlayerTeam(player)) == "Staff") then
				redirectPlayer (player, "188.165.208.28", 22003)
			end
		end
	end
end
