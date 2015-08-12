crash = {{{{{{{{ {}, {}, {} }}}}}}}}
isSpeedEnabled = false

function getPlayerFromNamePart(name)
    if name then 
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(name):lower(), 1, true) then
                return player 
            end
        end
    end
    return false
end

function doIHavePermission()
local team = getTeamFromName("Staff")
		if (getPlayerTeam(localPlayer) == team) then
			return true
			else
			return false
			end
	end

function Speedd()
	if (getPedOccupiedVehicle(localPlayer)) then
		if (getVehicleController(getPedOccupiedVehicle(localPlayer)) == localPlayer) then
			if (isVehicleOnGround(getPedOccupiedVehicle(localPlayer))) then
				if (getAnalogControlState("accelerate") == 1) then
					if (doIHavePermission()) then
						local velX, velY, velZ = getElementVelocity(getPedOccupiedVehicle(localPlayer))
						local a = setElementVelocity(getPedOccupiedVehicle(localPlayer), velX * 1.03, velY * 1.03, velZ)
					end
				end
			end
		end
	end
end

function startSpeed()
	if (doIHavePermission()) then
		addEventHandler("onClientRender", root, Speedd)
		isSpeedEnabled = true
	end
end

function killSpeed()
	if (isSpeedEnabled) then
		removeEventHandler("onClientRender", root, Speedd)
		isSpeedEnabled = false
	end
end

function bindStuff()
	outputDebugString("Binding keys for Speed")
	bindKey("l", "down", startSpeed)
	bindKey("l", "up", killSpeed)
end
bindStuff()