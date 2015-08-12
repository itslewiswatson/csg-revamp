local items = {
	[1] = {"Used Condom"},
	[2] = {"Empty pack of cigarretes"},
	[3] = {"Colt45 with 7 bullets"},
	[4] = {"Colt45 with 14 bullets"},
	[5] = {"Stash of weed"},
	[6] = {"Stash of heroin"},
	[7] = {"Stash of ritalin"},
	[8] = {"Stash of LSD"}
}

local sX,sY,sZ
local render = false
local distance = 0

function onStart()
	checkForHobo()
end
addEventHandler("onClientResourceStart",resourceRoot,onStart)

function checkForHobo()
	local team = getPlayerTeam(localPlayer)
	if (team == false) then
		return
	end
	if (getTeamName(team) == "Unemployed") and (getElementData(localPlayer,"Occupation") == "Hobo") then
		startHoboRender()
	else
		setTimer(checkForHobo,1000,1)
	end
end

function startHoboRender()
	if (render) then
		return
	end
	
	setTimer(trackDistance,1000,0)
end

function trackDistance()
	outputDebugString("Distance: "..(math.floor(distance)+1))
	if (distance >= 50) then
		giveRandomItem()
		distance = 0
		return
	end
	
	if not (sX) or not (sY) or not (sZ) then
		sX,sY,sZ = getElementPosition(localPlayer)
		return
	end
	
	local x,y,z = getElementPosition(localPlayer)
	local _distance = getDistanceBetweenPoints2D(sX,sY,x,y)
	local sX,sY,sZ = getElementPosition(localPlayer)
	distance = distance + _distance
	_distance = 0
end

function giveRandomItem()
	outputDebugString("given")
end