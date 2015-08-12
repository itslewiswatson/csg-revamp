addEventHandler("onClientPlayerWeaponFire",root,
function(wep,ammo,clip,x,y,z,hitElement)
	if (hitElement == nil) then return false end
	if (getElementType(hitElement) == "vehicle") then
		local driver = getVehicleOccupant(hitElement,0)
		if (isElement(driver)) then
			outputDebugString("vehicle has a driver!",0,0,255,0)
			
			if (getPlayerTeam(driver) == getTeamFromName("Staff")) then
				--outputDebugString("Player is staff, returning...",0,255,0,0)
				return false
			end
			
			if (getPlayerTeam(driver) ~= getTeamFromName("Criminals")) and (getPlayerTeam(driver) == getPlayerTeam(source)) then
				--outputDebugString("Player is not on criminal team / is on same team!",0,255,0,0)
				return false --Player is on the same team
			else
				local vehicleID = getElementModel(hitElement)
				if (vehicleID == 481) or (vehicleID == 510) or (vehicleID == 509) then	
					--outputDebugString("Player is on a bike, setting...",0,0,255,0)
					local loss = math.random(1,15)
					setElementHealth(driver,getElementHealth(driver)-loss)
				else
					--outputDebugString("Player is not on a bike!",0,255,0,0)
					return false -- hes not on a bike!
				end
			end
		end
	else
		return false
	end
end)