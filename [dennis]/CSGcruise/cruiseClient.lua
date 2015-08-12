------------------------------------------------------------------------------------
--  CSG
--  CSGcruise/cruiseClient.lua
--  Cruise control
--  Rozza
------------------------------------------------------------------------------------

local cruise = false
local timer = false
local speed = 0
function togCruise()
	local veh = getPedOccupiedVehicle(localPlayer)
	if getVehicleEngineState(veh) == false then killTimer(timer) cruise = false end
	if (cruise) then
		if (not veh or not isElement(veh)) then return false end
		local v1,v2,v3 = getElementVelocity(veh)
		local currspeed = (v1^2 + v2^2 + v3^2)^(0.5)
		if (currspeed < speed) then
			setControlState("accelerate", true)
		else
			setControlState("accelerate", false)
		end
	end
end

function cruiseNow()
	local veh = getPedOccupiedVehicle(localPlayer)
	if (not veh or not isElement(veh)) then return false end
	if (getVehicleOccupant(veh, 0) ~= localPlayer or not getVehicleOccupant(veh, 0)) then
		return false
	end
	if (not cruise) then
		cruise = true
		local speedx,speedy,speedz = getElementVelocity(veh)
		speed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
		timer = setTimer(togCruise, 50, 0)
		exports.DENdxmsg:createNewDxMessage("You are now cruising", 0, 255, 0)
	else
		exports.DENdxmsg:createNewDxMessage("You have disabled cruising", 0, 255, 0)
		cruise = false
		killTimer(timer)
		speed = 0
		setControlState("accelerate", false)
	end
end
bindKey("c", "up", cruiseNow)

function exitVeh(player)
	if (cruise and player == localPlayer) then
		cruise = false
		killTimer(timer)
		speed = 0
		setControlState("accelerate", false)
	end
end
addEventHandler("onClientVehicleExit", root, exitVeh)

addEventHandler("onClientRender",root,
function()
	if not (source == localPlayer) then return end
	if isPedInVehicle(source) and (cruise) then --make sure hes in the vehicle...
		if (getVehicleEngineState(getPlayerOccupiedVehicle(source)) == false) then
			cruise = false
			killTimer(timer)
			speed = 0
			setControlState("accelerate",false)
		end
	end
end)

function diedVeh()
	if (cruise) then
		cruise = false
		killTimer(timer)
		speed = 0
		setControlState("accelerate", false)
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, diedVeh)

function speed2(cmd, speed3)
	speed = tonumber(speed3)
	exports.DENdxmsg:createNewDxMessage("Max speed is now: " .. speed, 0, 255, 0)
end
addCommandHandler("speed", speed2)