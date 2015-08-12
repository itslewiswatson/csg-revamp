function firearms(_,_,x,y,z)
	player = localPlayer
	if (isLaw(player) == true) then 
		return false 
	end
	
	for k,v in ipairs(getElementsByType("player")) do
		_x,_y,_z = getElementPosition(v)
		dist = getDistanceBetweenPoints2D(_x,_y,x,y)
		--outputDebugString(dist)
		if (dist >= 10) and (v ~= player) then
			outputDebugString("Player: "..getPlayerName(v))
			outputDebugString("Player in range")
			triggerServerEvent("addWanted",player,player,player,39,x,y,z)
			local zone = getZoneName(x,y,z,false)
			triggerServerEvent("warnLaw",player,"Shots fired by "..getPlayerName(player).." in "..zone.."!",255,0,0)
			break --stop here.
		end
	end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,firearms)